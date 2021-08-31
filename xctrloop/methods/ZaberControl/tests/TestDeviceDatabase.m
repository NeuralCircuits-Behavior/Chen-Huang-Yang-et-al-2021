% Test data
db = Zaber.DeviceDatabase.instance();

%% Test device/peripheral IDs exist and can be retrieved.
ids = db.getalldeviceids();
assert(~isempty(ids));
for (i = 1:length(ids))
    deviceRecord = db.finddevice(ids(i));
    assert(~isempty(deviceRecord));
    assert(deviceRecord.DeviceId == ids(i)); % This knows an implementation detail.
    perIds = db.getallperipheralids(deviceRecord);
    assert(~isempty(perIds))
    for (j = 1:length(perIds))
        pId = perIds(j);
        periRecord = db.findperipheral(deviceRecord, pId);
        assert(~isempty(periRecord));
        assert(periRecord.PeripheralId == pId); % This knows an implementation detail.
        name = db.getdevicename(deviceRecord, periRecord);
        assert(~isempty(name));
        [type, units] = db.determinemotiontype(deviceRecord, periRecord);
        if (type ~= Zaber.MotionType.None)
            assert(units.PositionUnitScale > 0);
            assert(units.VelocityUnitScale > 0);
            assert(units.AccelerationUnitScale > 0);
        end
    end
end

%% Test units of measure are as expected for a few choice devices.
% RST-120AK
devRec = db.finddevice(50001);
[type, units] = db.determinemotiontype(devRec);
assert(type == Zaber.MotionType.Rotary);
units.Resolution = 64;
assert(MathHelper.issimilar(units.nativetoposition(1), 0.00015625));
assert(MathHelper.issimilar(units.positiontonative(1), 6400));
assert(MathHelper.issimilar(units.nativetovelocity(0.01), 1 / 1048576));
assert(MathHelper.issimilar(units.velocitytonative(100), 1048576));
assert(MathHelper.issimilar(units.nativetoacceleration(0.6400 * 1.6384), 1.0));
assert(MathHelper.issimilar(units.accelerationtonative(1/1.6384), 0.6400));
% X-LHM100A
devRec = db.finddevice(50081);
[type, units] = db.determinemotiontype(devRec);
assert(type == Zaber.MotionType.Linear);
units.Resolution = 64;
assert(MathHelper.issimilar(units.nativetoposition(1), 1 / 8062992, 0.0000005)); %% Rounding because the scale factor has lots of digits for this device.
assert(MathHelper.issimilar(units.positiontonative(1), 8062992, 0.5));
assert(MathHelper.issimilar(units.nativetovelocity(1), 1 / 13210406, 0.00000005));
assert(MathHelper.issimilar(units.velocitytonative(1), 13210406, 0.5));
assert(MathHelper.issimilar(units.nativetoacceleration(8062992.15 * 1.6384), 10000, 1));
assert(MathHelper.issimilar(units.accelerationtonative(0.124023437 / 1.6384), 100, 0.1));
% X-GSM40
devRec = db.finddevice(50315);
[type, units] = db.determinemotiontype(devRec);
assert(type == Zaber.MotionType.Rotary);
units.Resolution = 64;
assert(MathHelper.issimilar(units.nativetoposition(1), 1 / 6151, 0.0005));
% T-OMG
devRec = db.finddevice(311);
[type, units] = db.determinemotiontype(devRec);
assert(type == Zaber.MotionType.Tangential);
% X-JOY
devRec = db.finddevice(51000);
[type, units] = db.determinemotiontype(devRec);
assert(type == Zaber.MotionType.None);

%% Test that unknown device and peripheral IDs produce correct names.
devRec = db.finddevice(-99);
name = db.getdevicename(devRec);
assert(strcmp(name, 'Device id -99'));
devRec = db.finddevice(30222);
periRec = db.findperipheral(devRec, -99);
name = db.getdevicename(devRec, periRec);
assert(strcmp(name, 'X-MCB2 Controller + peripheral id -99'));
devRec = db.finddevice(-99);
periRec = db.findperipheral(devRec, -98);
name = db.getdevicename(devRec, periRec);
assert(strcmp(name, 'Device id -99 + peripheral id -98'));


%% Cleanup
clear all;


