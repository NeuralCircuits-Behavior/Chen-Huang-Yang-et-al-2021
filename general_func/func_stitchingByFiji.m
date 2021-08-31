function varargout = func_stitchingByFiji(filePath,fName,fExist,stitchingP)
% 2018/5/20, CH
% filePath, where images are
% fName, need not full path, only name of TileConfiguration
% fExist, if 1 exist fiji after runing 
% stitchingP, regression_threshold, max_avg_displacement_threshold, absolute_displacement_threshold

if nargin == 2
    fExist = 1;
    stitchingP = defaultSeting(filePath);
elseif nargin == 3
    stitchingP = defaultSeting(filePath);
end

%try
    type_order = sprintf('type=%s order=%s ',...
        '[Positions from file]','[Defined by TileConfiguration]');
    directory = sprintf('directory=%s ',regexprep(filePath,'\\','\\\'));
    layout_file = sprintf('layout_file=%s ',fName);
    fusion_method = sprintf('fusion_method=%s ','[Linear Blending]');
    threshold = sprintf('%s=%.2f %s=%.2f %s=%.2f ',...
        'regression_threshold',...
        stitchingP.regression_threshold,...
        'max/avg_displacement_threshold',...
        stitchingP.max_avg_displacement_threshold,...
        'absolute_displacement_threshold',...
        stitchingP.absolute_displacement_threshold);
    compute_overlap = stitchingP.compute_overlap;%'compute_overlap ';
    subpixel_accuracy = stitchingP.subpixel_accuracy;
    computation_parameters = sprintf('computation_parameters=%s ',...
        stitchingP.computation_parameters);
    image_output = stitchingP.image_output;
    cmd = sprintf('%s%s%s%s%s%s%s%s%s',...
        type_order,...
        directory,...
        layout_file,...
        fusion_method,...
        threshold,...
        compute_overlap,...
        subpixel_accuracy,...
        computation_parameters,...
        image_output);
    MIJ.run('Grid/Collection stitching',cmd);
    
    if contains(image_output,'[Fuse and display]')
        MIJ.run('Save',sprintf('Tiff..., path=%s',stitchingP.fileName));
        MIJ.run('Close');
    end
    
    if fExist
        MIJ.exit;
    end
%catch
%    MIJ.exit;
%end

if nargout
    varargout{1} = imread(fullfile(filePath,'img_t1_z1_c1'));
end
end

function stitchingP = defaultSeting(filePath)
stitchingP.regression_threshold = 0.01;%0.30;
stitchingP.max_avg_displacement_threshold = 2.50;
stitchingP.absolute_displacement_threshold = 3.50;
stitchingP.compute_overlap = '';%'compute_overlap ';
stitchingP.subpixel_accuracy = '';
stitchingP.image_output = sprintf('image_output=%s output_directory=%s ',...
    '[Write to disk]',regexprep(filePath,'\\','\\\'));
stitchingP.computation_parameters = '[Save computation time (but use more RAM)]';
end