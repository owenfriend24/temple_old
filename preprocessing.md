# Pre-Processing:
Notes:
* current preprocessing commands written below, still work in progress
* currently set up to work on just one subject at a time (excl. steps 3 and 4)
* directories somewhat disorganized, will need to fix later but treating $SCRATCH//rawdata2 as current output directory
* behavioral data in $WORK/temple/sourcebehav/sourcebehav, will need to fix double nesting

## 1. Source relevant profile
* activates virtual environment with relevant packages, sets some paths
```
cd $HOME/analysis/temple
source .profile_onesubject
```

## 2. Convert source DICOM data to BIDS formatting
```
slaunch -J heudiconv "temple_heudiconv.sh {} $WORK/temple/sourcedata2 $HOME/analysis/temple/bin/temple_heuristic.py $SCRATCH/temple/rawdata2" $SUBIDS -N 1 -n 1 -r 00:30:00 -p development
```

## 3. Add fieldmap information to BIDS formatted raw data
```
temple_bids_post.py $SCRATCH/temple/rawdata2
```

## 4. Convert behavioral data into BIDS format within BIDS formatted subject directories
```
temple_bids_events.py $WORK/temple/sourcebehav/ $SCRATCH/temple/rawdata2
```
 * not sure why but sub 022 causing problems with behavioral data
## 5. Run fmriprep
```
slaunch -J fmriprep “temple_fmriprep.sh $SCRATCH/temple/rawdata2 {}" $BIDIDS -N 1 -n 1 -r 08:00:00 -p normal
```

## 6. Create gray matter mask (need to update gray_prob, currently set for prisma protocol testing)
```
temple_gray_prob.sh $SCRATCH/temple/rawdata3/derivatives/fmriprep-23.0.2 MNI152NLin2009cAsym $SCRATCH/temple/output
```
```
slaunch -J template_rois "temple_template_rois.sh /work2/03206/mortonne/frontera/.cache/templateflow/MNI152NLin2009cAsym $SCRATCH/temple/rawdata2/derivatives {}" $BIDIDS -N 1 -n 1 -p development -r 01:00:00
```
* outputs into relevant subject's anat directory
* need to look into creating ROI specific masks using freesurfer output, currently just putting all into template space with WM/GM/CSF differentiated
  
# Imaging Analysis

## 1. Estimate betaseries for given task/run based on unique novel objects (IN PROGRESS) (need to module load afni/21.1.07)
```
slaunch -J betaseries "betaseries-bids --high-pass 0.01 --smooth 4 --confound-measures csf:csf_derivative1:white_matter:white_matter_derivative1:trans_x:trans_x_derivative1:trans_y:trans_y_derivative1:trans_z:trans_z_derivative1:rot_x:rot_x_derivative1:rot_y:rot_y_derivative1:rot_z:rot_z_derivative1 $SCRATCH/temple/rawdata/ $SCRATCH/temple/rawdata/derivatives/fmriprep-20.2.1/fmriprep/ $SCRATCH/temple/output/ temple030 arrow 1 MNI152NLin2009cAsym GM $SCRATCH/temple/rawdata/derivatives/fmriprep-20.2.1/fmriprep/sub-temple030/anat/sub-temple030_space-MNI152NLin2009cAsym_label-GM_probseg.nii.gz object” -N 1 -n 1 -r 01:00:00 -p development
```
for idev
```
betaseries-bids --high-pass 0.01 --smooth 4 --confound-measures csf:csf_derivative1:white_matter:white_matter_derivative1:trans_x:trans_x_derivative1:trans_y:trans_y_derivative1:trans_z:trans_z_derivative1:rot_x:rot_x_derivative1:rot_y:rot_y_derivative1:rot_z:rot_z_derivative1 $SCRATCH/temple/rawdata3/ $SCRATCH/temple/rawdata3/derivatives/fmriprep-23.0.2/ $SCRATCH/temple/output/ temple024 arrow 01 MNI152NLin2009cAsym gray $SCRATCH/temple/output/sub-temple024/anat/sub-temple024_space-MNI152NLin2009cAsym_label-gray_probseg.nii.gz object
```
* issue with temple022: events files not in rawdata2 directory, not being processed by events script, not sure what issue is



