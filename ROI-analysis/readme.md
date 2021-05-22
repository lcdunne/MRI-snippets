# Extracting beta weights for ROI analyses
The `make_roi.m` and `extract_betas.m` contain convenience functions to avoid the hassle of clicking through the MarsBar GUI and manually extracting betas, which can be a bit tedious. These functions make use of MarsBar, and give the same results to what you get from using the MarsBar GUI.

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

This can easily be adapted for multiple ROIs and multiple contrasts. For example, I created a table called `ROI_definitions.csv` containing an ROI label, radius, and xyz coordinates for the left angular gyrus, precuneus, and anterior insula (L_AG, L_PCU, L_AI):

| label      | radius | x      | y | z |
| ----------- | ----------- | ----------- | ----------- | ----------- |
| L_AG      | 6       | -30      | -72       | 42       |
| L_PCU   | 6        | -8   | -66        | 30        |
| L_AI   | 6        | -32   | 22        | -4        |

By reading in this table, I looped over each ROI, then looped over each contrast in my analysis directory, and extracted the betas. The result looked like this (example here with just 2 participants):


| index      | contrast | L_AG      | L_PCU | L_AI |
| ----------- | ----------- | ----------- | ----------- | ----------- |
| 1      | hits       | 0.646941665621582      | 1.120690520792230       | -0.745793919404590       |
| 2   | hits        | 0.361029489012050   | -0.082688451631040        | 0.708165565157324        |
| 1      | correct_rejections       | 0.556142854419622      | 0.185282376556983       | 2.026709071504391       |
| 2   | correct_rejections        | 0.556142854419622   | 0.185282376556983        | 2.026709071504391        |

See `roi_beta_extract.m` for the code.
