# DeviceDatabaseUpdater.py
#
# This Python 3 script will download the Zaber Device Database from the
# Zaber website, decompress it, extract data, output the data to 
# a MATLAB .mat file, generate enumerations for Binary protocol codes,
# then optionally delete the downloaded database file.
#
# The normal invocation is:
# python3 DeviceDatabaseUpdater.py --download --delete --devices --enums
#
# You may wish to use this script if you want updated data about
# new Zaber products without updating to a new version of the Zaber
# MATLAB toolbox. Otherwise, new versions of the generated data will 
# be published by default with new releases of the Zaber MATLAB toolbox.
# 
# The generated .mat file provides a way for the Zaber MATLAB library
# to look up needed information about Zaber products without users
# having to have the MATLAB Database Toolbox installed. Those who do have
# the Database Toolbox may wish to write their own implementation of the
# Zaber.DeviceDatabase MATLAB class that uses the sqlite3 database directly
# or uses hardcoded data to answer queries, and only use this script to 
# download and decompress the file.
#
# The .mat file produced by this script is only intended for use with
# the Zaber MATLAB library and its content and schema are subject to
# change. If you want a customized .mat file of Zaber device data, you
# are encouraged to modify this file to output the data you want to
# a different .mat file.
#
# This script can also generate MATLAB enumerations from the database
# in order to provide symbolic names for Zaber Binary protocol code
# numbers (ie commands, error codes and status codes). The names of the
# files generated are fixed: BinaryCommandType.m, BinaryErrorType.m 
# and BinaryReplyType.m.
 
# Revision history:
#{
#  2016-10-19: First implementation.
#  2017-01-04: Fixed incorrect unit conversion for velocities.
#              Changed the default behavior to update the device list 
#              and enums, so no arguments are needed for normal use.
#}

import argparse
import lzma
import numpy
import os
import scipy.io
import sqlite3
import sys
import urllib.request

# Defaults
gDownloadUrl = "https://www.zaber.com/software/device-database/devices-public.sqlite.lzma"
gInputFilename = "devices-public.sqlite"
gOutputFilename = "DeviceDatabase.mat"


# .mat file schema for the top-level table, keyed by device ID.
sDeviceSchema = [("DeviceId", int),
                 ("Name", object),
                 ("Peripherals", numpy.recarray)
                ]

# .mat file schema for the peripherals field of the device schema above.
sPeripheralSchema = [("PeripheralId", int), 
                     ("Name", object),
                     ("PositionUnitScale", float),
                     ("VelocityUnitScale", float),
                     ("AccelerationUnitScale", float),
                     ("ForceUnitScale", float),
                     ("MotionType", object)
                    ]


# Create a command line argument parser.
def createArgParser():
    global gDownloadUrl, gInputFilename, gOutputFilename

    parser = argparse.ArgumentParser(description = "Download the Zaber Device Database and convert it for use with the Zaber MATLAB library.")
    parser.add_argument("--url", dest = "url", type = str, default = gDownloadUrl, help = "Optional: Specify an alternate URL to download the database from.")
    parser.add_argument("--dbfile", dest = "dbfile", type = str, default = gInputFilename, help = "Optional: Override the default name of the sqlite database file to download to and read from (" + gInputFilename + ").")
    parser.add_argument("--matfile", dest = "matfile", type = str, default = gOutputFilename, help = "Override the name of the MATLAB .mat device database (" + gOutputFilename + ").")
    parser.add_argument("--download", dest = "download", action="store_true", default = False, help = "Optional: Force re-download of database file even if already present. Default is to use the existing file if present, or download it otherwise.")
    parser.add_argument("--delete", dest = "delete", action="store_true", default = False, help = "Optional: Delete the downloaded file(s) after processing is complete. Defaults to false.")
    parser.add_argument("--devices", dest = "devices", action="store_true", default = True, help = "Optional: Update the device database .mat file. Default is to do this.")
    parser.add_argument("--enums", dest = "enums", action="store_true", default = True, help = "Optional: Update the binary code enumerations. Default is to do this.")

    return parser


# Download a database, decompress it and save to the specified filename.
def downloadFile(aUrl, aPath):
    (tmpFile, headers) = urllib.request.urlretrieve(aUrl)

    if (not os.path.isfile(tmpFile)) or (os.path.getsize(tmpFile) < 1):
        raise IOError("Download failed.");

    print("Decompressing downloaded file...")
    with lzma.open(tmpFile) as ifp:
        data = ifp.read()

    os.remove(tmpFile)

    if len(data) < 1:
        raise IOError("Failed to decompress downloaded device database.")

    if os.path.exists(aPath):
        os.remove(aPath)

    with open(aPath, "wb") as ofp:
        ofp.write(data)


# Get the dimension table in indexable form.
def getDimensions(aCursor):
    aCursor.execute("SELECT * FROM Console_Dimensions;")
    dimensions = { 0: "none" }
    maxIndex = 0
    for row in aCursor.fetchall():
        id = int(row["Id"])
        name = str(row["Name"])
        dimensions[id] = name
        if (id > maxIndex):
            maxIndex = id;

    result = []
    result.extend(["unknown"] * (maxIndex + 1))
    for (key, value) in iter(dimensions.items()):
        result[key] = value

    return result


# Determine the physical units of the device.
def getUnits(aCursor, aDimensionTable, aProductId):

    motionType = 0
    positionScale = 1.0
    velocityScale = 1.0
    accelScale = 1.0
    forceScale = 1.0
    function = "linear-resolution"

    aCursor.execute("SELECT * FROM Console_BinaryCommands2 WHERE ProductId = " + str(aProductId) + " AND Command = 20 AND ParameterUnitScale NOT NULL;")
    rows = aCursor.fetchall()
    if (len(rows) > 0):
        positionScale = float(rows[0]["ParameterUnitScale"])
        dimension = int(rows[0]["ParameterDimension"])
        function = str(rows[0]["ParameterUnitFunction"])

        # These values have to match the MATLAB Zaber.MotionType enum.
        if ("linear" in function):
            dimName = aDimensionTable[dimension]
            if ("Length" == dimName) or ("Velocity" == dimName) or ("Acceleration" == dimName):
                motionType = 1
            elif ("Ang" in dimName):
                motionType = 2
            elif ("none" in dimName):
                motionType = 0
            else:
                motionType = 9
        elif ("tangential" in function):
            motionType = 3
        else:
            raise KeyError("Unrecognized unit conversion function " + function)

    aCursor.execute("SELECT * FROM Console_BinaryCommands2 WHERE ProductId = " + str(aProductId) + " AND Command = 22 AND ParameterUnitScale NOT NULL AND ParameterUnitFunction = '" + function + "';")
    rows = aCursor.fetchall()
    if (len(rows) > 0):
        velocityScale = float(rows[0]["ParameterUnitScale"])

    aCursor.execute("SELECT * FROM Console_BinarySettings2 WHERE ProductId = " + str(aProductId) + " AND SetCommand = 43 AND UnitScale NOT NULL AND UnitFunction = '" + function + "';")
    rows = aCursor.fetchall()
    if (len(rows) > 0):
        accelScale = float(rows[0]["UnitScale"])

    aCursor.execute("SELECT * FROM Console_BinaryCommands2 WHERE ProductId = " + str(aProductId) + " AND Command = 87 AND ParameterUnitScale NOT NULL AND ParameterUnitFunction = '" + function + "';")
    rows = aCursor.fetchall()
    if (len(rows) > 0):
        forceScale = float(rows[0]["ParameterUnitScale"])

    return (motionType, positionScale, velocityScale, accelScale, forceScale)



# Extract relevant data from the database.
def readDeviceData(aCursor):

    dimensions = getDimensions(aCursor);

    # Get all device IDs and choose only the latest firmware version for each.
    devices = []
    aCursor.execute("SELECT * FROM Console_Devices WHERE MinorVersion < 95 ORDER BY DeviceId, MajorVersion DESC, MinorVersion DESC, Build DESC;")
    rows = aCursor.fetchall()

    if (len(rows) < 1):
        raise IOError("No devices found in this database!")

    currentId = -1
    for row in rows:
        dId = int(row["DeviceId"])
        if (dId != currentId):
            # Only take information from the highest firmware version.
            # The MATLAB toolbox currently does not consider firmware version part of the device identity.
            currentId = dId; 
            # First column is the device ID, second is the device name, third is the primary key.
            devices.append((dId, str(row["Name"]), int(row["Id"])))

    numDevices = len(devices)
    print("Found " + str(numDevices) + " unique device IDs.")
    table = numpy.recarray((numDevices,), dtype=sDeviceSchema)

    for i in range(0, numDevices):
        device = devices[i]
        table[i].DeviceId = device[0]
        table[i].Name = device[1]
        msg = str(device[0]) + " = " + device[1]

        peripherals = []
        aCursor.execute("SELECT * FROM Console_Peripherals WHERE ParentId = " + str(device[2]) + " ORDER BY PeripheralId;")
        rows = aCursor.fetchall()
        for row in rows:
            # First column is the peripheral ID, second is the peripheral name, third is the primary key.
            peripherals.append((int(row["PeripheralId"]), str(row["Name"]), int(row["Id"])))

        numPeripherals = len(peripherals)
        if (numPeripherals < 1): # Not a controller.
            periTable = numpy.recarray((1,), dtype=sPeripheralSchema)
            periTable[0].PeripheralId = 0
            periTable[0].Name = ""
            
            unit = getUnits(aCursor, dimensions, device[2])
            periTable[0].MotionType = unit[0]
            periTable[0].PositionUnitScale = unit[1]
            periTable[0].VelocityUnitScale = unit[2]
            periTable[0].AccelerationUnitScale = unit[3]
            periTable[0].ForceUnitScale = unit[4]
        else:
            msg += " + " + str(numPeripherals) + " peripherals:"
            periTable = numpy.recarray((numPeripherals,), dtype=sPeripheralSchema)
            for j in range(0, numPeripherals):
                peripheral = peripherals[j]
                periTable[j].PeripheralId = peripheral[0]
                periTable[j].Name = peripheral[1]
                msg += "\n- " + str(periTable[j].PeripheralId) + " = " + str(periTable[j].Name)
            
                unit = getUnits(aCursor, dimensions, peripheral[2])
                periTable[j].MotionType = unit[0]
                periTable[j].PositionUnitScale = unit[1]
                periTable[j].VelocityUnitScale = unit[2]
                periTable[j].AccelerationUnitScale = unit[3]
                periTable[j].ForceUnitScale = unit[4]

        table[i].Peripherals = periTable

        print(msg)

    return table


# Find binary command names and values.
def findBinaryCodes(aCursor):
    result = {}

    commands = []
    aCursor.execute("SELECT DISTINCT Command, CommandName FROM Console_BinaryCommands2 ORDER BY Command;")
    rows = aCursor.fetchall()
    for row in rows:
        commands.append((row["Command"], row["CommandName"]))

    aCursor.execute("SELECT DISTINCT ReturnCommand, Name FROM Console_BinarySettings2 WHERE ReturnCommand NOT NULL ORDER BY ReturnCommand;")
    rows = aCursor.fetchall()
    for row in rows:
        commands.append((row["ReturnCommand"], "Return " + row["Name"]))

    aCursor.execute("SELECT DISTINCT SetCommand, Name FROM Console_BinarySettings2 WHERE SetCommand NOT NULL ORDER BY SetCommand;")
    rows = aCursor.fetchall()
    for row in rows:
        commands.append((row["SetCommand"], "Set " + row["Name"]))

    result["commands"] = sorted(commands, key=lambda item: item[1])
    
    replies = []
    aCursor.execute("SELECT DISTINCT Reply, ReplyName FROM Console_BinaryReplies2 ORDER BY Reply;")
    rows = aCursor.fetchall()
    for row in rows:
        replies.append((row["Reply"], row["ReplyName"]))

    result["replies"] = sorted(replies, key=lambda item: item[1])

    errors = []

    aCursor.execute("SELECT * FROM Console_BinaryErrors ORDER BY Code;")
    rows = aCursor.fetchall()
    for row in rows:
        errors.append((row["Code"], row["Name"]))

    result["errors"] = sorted(errors, key=lambda item: item[1])

    return result

def generateBinaryEnum(aCodeTable, aEnumName, aBaseType):

    maxLength = 1
    for (code, name) in aCodeTable:
        maxLength = max(maxLength, len(name))

    filename = aEnumName + ".m"
    print("Generating " + filename + "...")
    if (os.path.exists(filename)):
        os.remove(filename);

    generatedNames = {}
    with open(filename, "wt") as fp:
        fp.write("%%   %s Enumeration to assist with interpreting Zaber Binary protocol codes.\n\n" % (aEnumName.upper()))
        fp.write("%   THIS IS A GENERATED FILE - DO NOT EDIT. See DeviceDatabaseUpdate.py.\n\n")
        fp.write("classdef %s < %s\n" % (aEnumName, aBaseType))
        fp.write("    enumeration\n")

        first = True
        for i in range(0, len(aCodeTable)):
            (code, name) = aCodeTable[i]
            fixedName = name.replace(" ", "_").replace("-", "_")
            if fixedName not in generatedNames:
                generatedNames[fixedName] = True
                if not first:
                    fp.write(",\n")
                first = False
                fp.write("        %s (%d)" % (fixedName.ljust(maxLength, " "), code))
        fp.write("\n")

        fp.write("    end\n")
        fp.write("end\n")


if (__name__ == "__main__"):
    
    parser = createArgParser()
    args = parser.parse_args()
    gDownloadUrl = args.url
    gInputFilename = args.dbfile
    gOutputFilename = args.matfile

    doDownload = args.download
    doDelete = args.delete
    doOutputMatrix = args.devices
    doOutputEnums = args.enums

    if not os.path.isfile(gInputFilename):
        print("Database download forced because file " + gInputFilename + " does not exist.")
        doDownload = True

    if doDownload:
        print("Downloading device database from: " + gDownloadUrl)
        downloadFile(gDownloadUrl, gInputFilename)

    print("Reading database " + gInputFilename + " (might take a while)...")
    connection = sqlite3.connect(gInputFilename)
    connection.row_factory = sqlite3.Row
    cursor = connection.cursor()

    # Save the database to the .mat file.
    if (doOutputMatrix):

        table = readDeviceData(cursor)
        print("Saving device database data to " + gOutputFilename)
        scipy.io.savemat(gOutputFilename, { "devices" : table })

    # Generate the binary command list.
    if (doOutputEnums):
        enums = findBinaryCodes(cursor)
        generateBinaryEnum(enums["commands"], "BinaryCommandType", "uint8");
        generateBinaryEnum(enums["replies"], "BinaryReplyType", "uint8");
        generateBinaryEnum(enums["errors"], "BinaryErrorType", "int32");

    connection.close()

    # Optionally delete the downloaded file.
    if doDelete:
        print("Removing downloaded file " + gInputFilename)
        os.remove(gInputFilename)


    
