## Estimating betaseries images for each object during each run ##
based on Jeannette Mumford's work, essentially runs a GLM for each voxel ~ stimulus and extracts the beta weight for the stimulus's effect on that voxel's activity

### betaseries-bids command in mindstorm (Neal's utilities) ###
counfound list for fmriprep: csf:csf_derivative1:white_matter:white_matter_derivative1:trans_x:trans_x_derivative1:trans_y:trans_y_derivative1:trans_z:trans_z_derivative1:rot_x:rot_x_derivative1:rot_y:rot_y_derivative1:rot_z:rot_z_derivative1

### 1. make sure BIDS data is pre-processed, skullstripped, and smoothed
* See [preprocessing.md] (https://github.com/owenfriend24/temple/blob/main/1_preprocessing.md)
### 2. replace any NaN's in events files with zeroes
```
fix_arrow.py <fmriprep_dir> <subject>
```
### 3. make sure BIDS directories have smoothed skullstripped data as functional runs, store original T1 runs (i.e. not smooothed/skullstripped) in separate folder
```
clean_scratch.sh <fmriprep_dir> <subject>
```
### 4. run betaseries for all 6 arrow runs for single subject
```
batch_beta.sh <fmriprep_dir> <freesurfer_dir> <out_dir> <subject>
```

### 5. adding pre and post beta images together
```
fslmaths beta1.nii.gz -add beta2.nii.gz -add beta3.nii.gz output_sum.nii.gz
```

### betaseries-bids fields
```
betaseries-bids [OPTIONS] data_dir fmriprep_dir out_dir subject task run space mask_name mask_file events_field
```
* data_dir – path to BIDS-compliant dataset with task events
  `$SCRATCH/temple/skyra_prepro`
*	fmriprep_dir
  `$SCRATCH/temple/skyra_prepro/derivatives/fmriprep/`
*	out_dir
  `$SCRATCH/temple/skyra_prepro/beta`
*	subject
  `temple051`
*	task
  `arrow`
*	run
  `01`
*	space
 `T1w`
*	mask_name
  `gm_func_dilated`
*	mask_file
  `$FSDIR/sub-temple051/mri/out/brainmask_func_dilated.nii.gz`
*	events_field – column of events file to use to indicate individual explanatory variable
  `object`

* [OPTIONS]
--high-pass FLOAT (highpass filter in Hz)
--smooth FLOAT (smoothing kernel FWHM)
--confound-measures TEXT (colon-separated list of confound measures (see below)

example call:
```
betaseries-bids --confound-measures $conf $SCRATCH/temple/skyra_prepro/ $FMDIR $FMDIR/beta temple051 arrow 01 T1w gm_func_dilated $FSDIR/sub-temple051/mri/out/brainmask_func_dilated.nii.gz object
```
*IMPORTANT - fill NA's with 0's in event files
