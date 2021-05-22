# Extracting beta weights
The `make_roi.m` and `extract_betas.m` contain convenience functions to avoid the hassle of clicking through the MarsBar GUI and manually extracting betas, which can be a bit tedious. These functions give the same results to MarsBar. 

They also give the same results as you would obtain from loading an SPM, inclusively masking it with an ROI (`*.nii`), thresholding to 1 (uncorrected), snapping the marker to the global max, right-clicking, and selecting `Extract data --> whitened & filtered y --> This cluster` ([as demonstrated in this video](https://www.youtube.com/watch?v=zVuSHTJLJj4)).

#### Simple Example:
```matlab
% Define where to save the ROI
roi_output_path = 'G:\PhD\exp\data\derivatives\ROI\regions';

% Define where to look for the `SPM.mat` design file
spm_path = 'G:\PhD\exp\data\derivatives\GLM\memory\group\main_effect_hits\SPM.mat';

% Create & save the ROI, return the sphere object & the fulle path to it (with name)
[left_AG_ROI, roi_fpath] = make_roi([-30, -72, 42], 6, 'L_AG', roi_output_path);

% Extract the beta weights
y1 = extract_betas(spm_path, roi_fpath);
```

This could be repeated for a different contrast:
```matlab
% Define where to save the ROI
roi_output_path = 'G:\PhD\exp\data\derivatives\ROI\regions';

% Define where to look for the `SPM.mat` design file
spm_path = 'G:\PhD\exp\data\derivatives\GLM\memory\group\main_effect_correct_rejections\SPM.mat';

% Create & save the ROI, return the sphere object & the fulle path to it (with name)
[left_AG_ROI, roi_fpath] = make_roi([-30, -72, 42], 6, 'L_AG', roi_output_path);

% Extract the beta weights
y2 = extract_betas(spm_path, roi_fpath);
```
And then y1 and y2 can be compared statistically.

This can easily be adapted for multiple ROIs and multiple contrasts, for example by reading in a table of ROI definitions, looping over each ROI, looping over each contrast file, and extracting the betas that way.
