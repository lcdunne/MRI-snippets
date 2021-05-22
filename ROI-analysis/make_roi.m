function [roi, output_fpath] = make_roi(xyz, radius, roi_name, output_path)
    % Creates a spherical ROI given coordinates --------------------------%
    % PARAMETERS
    % ==========
    % xyz        : 'double' (1x3)
    %     The x, y, and z values to define the sphere centre.
    % radius     : 'double'
    %     Radius of the sphere (in mm)
    % roi_name   : 'char'
    %     A name/label for the ROI.
    % output_path: 'char'
    %     An optional path to output the sphere to.
    
    roi = maroi_sphere(struct('centre', xyz, 'radius', radius));
    
    if exist('output_path', 'var')        
        label = sprintf('%s_%i_%i_%i_%imm_ROI', roi_name, xyz.', radius);
        % Save as a .mat file
        output_fpath = fullfile(output_path, sprintf('%s.mat', label));
        saveroi(roi, output_fpath);
        % % Save as .nii file - only good if want to manually explore in
        % % spm
        % save_as_image(roi, fullfile(output_path, sprintf('%s.nii', label)));
    end
    
    fprintf('Created ROI: %s (%i %i %i)\n', roi_name, xyz.');
end
