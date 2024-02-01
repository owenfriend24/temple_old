## Estimating betaseries images for each object during each run ##
based on Jeannette Mumford's work, essentially runs a GLM for each voxel ~ stimulus and extracts the beta weight for the stimulus's effect on that voxel's activity

### betaseries-bids command in mindstorm (Neal's utilities) ###
counfound list for fmriprep: csf:csf_derivative1:white_matter:white_matter_derivative1:trans_x:trans_x_derivative1:trans_y:trans_y_derivative1:trans_z:trans_z_derivative1:rot_x:rot_x_derivative1:rot_y:rot_y_derivative1:rot_z:rot_z_derivative1

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
