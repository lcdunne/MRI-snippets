%% Configs
% The table containing ROI names, radii, and xyz coords
ROIs = readtable('G:\PhD\exp\data\derivatives\ROI\ROI_definitions.csv');

% Where to store the ROIs
roi_output_path = 'G:\PhD\exp\data\derivatives\ROI\regions';

% Path containing all of the second level contrasts
analysis_path = 'G:\PhD\exp\data\derivatives\GLM\memory\group';

%% Build the ROIs
ROIs = table2struct(ROIs);

% Loop over each region
nroi = size(ROIs, 1);
for r=1:nroi
    disp(ROIs(r))
    
    label = ROIs(r).label;
    radius = ROIs(r).radius;
    xyz = [ROIs(r).x ROIs(r).y ROIs(r).z];
    
    % Construct the ROI & save it to the output path
    [~, roi_fpath] = make_roi(xyz, radius, label, roi_output_path);
    
    % Add the output path to the ROIs struct
    ROIs(r).roi_fpath = roi_fpath;

    r = r + 1;
end

%% Loop over each contrast & extract betas to a table
RESULTS = table();
analysis_dir = dir(analysis_path);
f = 1; % A counter

for i=1:length(analysis_dir)
    this_dir = analysis_dir(i);
    
    if this_dir.isdir == 0
        % This item isn't a directory
        continue
    end
    
    % SPM file to check for
    spm_file = [this_dir.folder, '\', this_dir.name, '\SPM.mat'];
    if exist(spm_file, 'file') ~= 2
        % This one doesn't contain an SPM.mat file
        continue
    end
    
    % Get the contrast name
    load(spm_file);
    con_name = SPM.xCon.name; % Must be equal to this dir.name
    if ~strcmp(con_name, this_dir.name)
        disp(['Skipping ', this_dir.name])
    end
      
    % Loop over the ROIs and extract the betas for this contrast
    nscan = SPM.nscan;
    % index for each subject in this case
    index = [1: nscan]';
    contrast = repelem(categorical({con_name}), nscan)';
    T = table(index, contrast);
    for r=1:nroi
        label = ROIs(r).label;
        % Extract the beta weights
        roi_fpath = ROIs(r).roi_fpath;
        y = extract_betas(spm_file, roi_fpath);
        
        T = [T, table(y)];
        T.Properties.VariableNames(size(T,2)) = {label};
        
    end
    
    RESULTS = [RESULTS; T];
    
    f = f + 1;

end
