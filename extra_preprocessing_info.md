## Remote desktop via TACC
[https://docs.tacc.utexas.edu/hpc/lonestar6/#vis]
```
sbatch /share/doc/slurm/job.dcv2vnc
touch dcvserver.out ; tail -f dcvserver.out
```
* job needs to be running before touch command works
* to quit job:
```
  scancel JOBID
```
* use '&' to open software within session
```
fsleyes &
```
* Ctrl + c in terminal to get back to normal TACC after running job commands


## Working between TACC and local machine
* It's annoying to re-clone github repo in TACC every time I make a change, so I'm making changes on local machine and using CyberDuck to upload
*   need to chmod 557 on new .py and .sh scripts to let me run them
* To pull behavioral data from cluster onto local machine (e.g., to check motion):
*   From local machine terminal:
```
cd /Users/owenfriend/Document/Temple_Local
./temple_behav_data.sh ofriend@ls6.tacc.utexas.edu:/scratch/09123/ofriend/temple/rawdata /Users/owenfriend/Document/Temple_Local/behav_pull
```

## using idev
* still kind of confused on how it works, but don't need to launch jobs via slurm, gives direct access to development node

## betaseries-bids fields
* example call, below each bulleted field is working example (not sure if all work)
```
betaseries-bids [OPTIONS] data_dir fmriprep_dir out_dir subject task run space mask_name mask_file events_field
```
* data_dir – path to BIDS-compliant dataset with task events
*   $SCRATCH/temple/rawdata2
*	fmriprep_dir
*	  $SCRATCH/temple/rawdata2/derivatives/fmriprep-20.2.1/fmriprep/
*	out_dir
*	  $SCRATCH/temple/output
*	subject
*	  temple019
*	task
*	  arrow
*	run
*	  1
*	space
*	  MNI152NLin2009cAsym
*	mask_name
*	  GM
*	mask_file
*	  $SCRATCH/temple/rawdata/derivatives/fmriprep-20.2.1/fmriprep/sub-temple019/anat/sub-temple019_space-MNI152NLin2009cAsym_label-GM_probseg.nii.gz
*	events_field – column of events file to use to indicate individual explanatory variable
*	  object

* [OPTIONS]
--high-pass FLOAT (highpass filter in Hz)
--smooth FLOAT (smoothing kernel FWHM)
--confound-measures TEXT (colon-separated list of confound measures (see below)


## Confound list for betaseries-bids script
csf:csf_derivative1:white_matter:white_matter_derivative1:trans_x:trans_x_derivative1:trans_y:trans_y_derivative1:trans_z:trans_z_derivative1:rot_x:rot_x_derivative1:rot_y:rot_y_derivative1:rot_z:rot_z_derivative1
