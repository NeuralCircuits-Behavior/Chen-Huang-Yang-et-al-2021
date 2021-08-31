function func_imageJstitching(filePath,pixelSize,stitchingP)
% 2018/4/4, CH
% filePath, '...*.tif', note use absPositionsX_absPositionsY_.tif or 
%   relPositionsX_relPositionsY_.tif to name file. 
%   relPositionsX_relPositionsY_.tif is prefred
% pixelSize, um per pixel
% stitchingP, optional, responsed paramters in imageJ
%   stitchingP.regression_threshold
%   stitchingP.max_avg_displacement_threshold
%   stitchingP.absolute_displacement_threshold

if nargin == 2
    stitchingP.regression_threshold = 0.30;
    stitchingP.max_avg_displacement_threshold = 2.50;
    stitchingP.absolute_displacement_threshold = 3.50;
end

oldPath = cd(fileparts(filePath));
list = dir(filePath);
coordxyz = getCoordinates(list);
removeFilesIdx = getRemoveFilesIdx(getRepeatedFile(coordxyz),list);
removeRepeatedFiles(list,removeFilesIdx);
fName = createTileConfiguration(list,coordxyz,pixelSize,removeFilesIdx);
stitchingByFiji(fileparts(filePath),fName,stitchingP)
cd(oldPath);

    function coordxyz = getCoordinates(list)
        names = {list.name}';
        coordxyz = regexp(names,'[0-9.]+(?=_)','match'); % char
        coordxyz = cell2mat(...
            cellfun(@(f)[str2double(f{1}),str2double(f{2}),str2double(f{3})],...
            coordxyz,'unif',0));
        if ~ismember([0,0,0],coordxyz,'rows')
            % named using abs positions
            [~,idx] = min([list.datenum]); % find first position, always only one pic
            coordxyz = coordxyz - coordxyz(idx,:);
        end
    end

    function filePairs = getRepeatedFile(coordxyz)
        distM = @(coordxy,p)abs(triu(coordxy(:,p)-coordxy(:,p)'));
        xTfM = distM(coordxyz,1) > 0 & distM(coordxyz,1) < 0.8;
        yTfM = distM(coordxyz,2) > 0 & distM(coordxyz,2) < 0.8;
        zTfM = distM(coordxyz,3) > 0 & distM(coordxyz,3) < 0.8;
        [filePairs(:,1),filePairs(:,2)] = find(xTfM & yTfM & zTfM);
    end

    function removeFilesIdx = getRemoveFilesIdx(filePairs,list)
        if isempty(filePairs)
            removeFilesIdx = [];
            return
        end
        % keep last file (datenum bigger) and remove old,
        fRemove1stFile = arrayfun(...
            @(i)list(filePairs(i,1)).datenum < list(filePairs(i,2)).datenum,...
            1:size(filePairs,1));
        removeFilesIdx = filePairs([fRemove1stFile(:),~fRemove1stFile(:)]);
    end

    function removeRepeatedFiles(list,removeFilesIdx)
        if isempty(removeFilesIdx)
            return
        end
        mkdir('repeatedImages');
        for i = removeFilesIdx'
            movefile(list(i).name,'repeatedImages');
        end
    end

    function fName = createTileConfiguration(list,coordxyz,pixelSize,removeFilesIdx)
        pixelxyz = coordxyz./pixelSize * 1000;
        fName = sprintf('TileConfiguration_%s.txt',datestr(now,'yyyymmddTHHMMSS'));
        f = fopen(fName,'w');
        fprintf(f,'dim = 3\r\n\r\n'); % head
        n = 0;
        for k = setdiff(1:numel(list),removeFilesIdx)
            n = n + 1;
            fprintf(f,...
                sprintf('%s; ; (%.4f, %.4f, %.4f)\r\n',list(k).name,...
                pixelxyz(k,1),pixelxyz(k,2),pixelxyz(k,3)));
        end
        fclose(f);
    end

    function stitchingByFiji(filePath,fName,stitchingP)
        Miji(0);
        try
            type_order = sprintf('type=%s order=%s ',...
                '[Positions from file]','[Defined by TileConfiguration]');
            directory = sprintf('directory=%s ',regexprep(filePath,'\\','\\\'));
            layout_file = sprintf('layout_file=%s ',fName);
            fusion_method = sprintf('fusion_method=%s ','[Linear Blending]');
            threshold = sprintf('regression_threshold=%.2f max/avg_displacement_threshold=%.2f absolute_displacement_threshold=%.2f ',...
                stitchingP.regression_threshold,...
                stitchingP.max_avg_displacement_threshold,...
                stitchingP.absolute_displacement_threshold);
            compute_overlap = '';%'compute_overlap ';
            computation_parameters = sprintf('computation_parameters=%s ',...
                '[Save computation time (but use more RAM)]');
            image_output = sprintf('image_output=%s output_directory=%s ',...
                '[Write to disk]',regexprep(filePath,'\\','\\\'));
            cmd = sprintf('%s%s%s%s%s%s%s%s',...
                type_order,...
                directory,...
                layout_file,...
                fusion_method,...
                threshold,...
                compute_overlap,...
                computation_parameters,...
                image_output);
            MIJ.run('Grid/Collection stitching',cmd);
            MIJ.exit;
        catch
            MIJ.exit;
        end
    end
end