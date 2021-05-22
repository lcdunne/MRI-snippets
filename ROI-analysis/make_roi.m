function [roi, output_fpath] = make_roi(xyz, radius, roi_name, output_path)
    % Creates a spherical ROI given coordinates --------------------------%
    % PARAMETERS
    % ==========
    % xyz        : 1d array with x, y, and z values for the sphere centre.
    % radius     : radius of the sphere in mm
    % roi_name   : a name for the ROI, optional. If not provided will
    %               default to `sphere`.
    % output_path: an optional path to output the sphere to.
    
    if ~exist('roi_name', 'var')
        roi_name = 'sphere';
    end
    
    roi = maroi_sphere(struct('centre', xyz, 'radius', radius));
    
    if exist('output_path', 'var')        
        roi_label = sprintf('%s_%i_%i_%i_%imm_ROI', roi_name, xyz.', radius);
        output_fpath = fullfile(output_path, sprintf('%s.mat', roi_label));
        saveroi(roi, output_fpath);
    end
    
    fprintf('Created ROI: %s (%i %i %i)\n', roi_name, xyz.');
end
