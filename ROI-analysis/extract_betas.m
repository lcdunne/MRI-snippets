function y = extract_betas(spm_path, roi_or_path)
    % Extracts beta weights from an SPM design file ----------------------%
    % PARAMETERS
    % ==========
    % spm_path    : 'char'
    %     A directory path to the SPM.mat file containing the design from 
    %     which to extract beta weights...
    % roi_or_path : 'char' OR 'maroi_sphere'
    %     EITHER a path to the .mat file containing the
    %     ROI (e.g. outputted from `make_roi.m`) OR a loaded maroi sphere.
    
    % Check if a sphere was given or not
    if isa(roi_or_path, 'maroi_sphere')
        roi = {roi_or_path};
    else
        roi = maroi('load_cell', roi_path);
    end
    
    % Load the design & extract the betas
    design = mardo(spm_path);
    mY = get_marsy(roi{:}, design, 'mean');
    y  = summary_data(mY);
end
