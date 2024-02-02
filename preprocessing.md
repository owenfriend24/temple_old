# Pre-Processing:
Notes:
* current preprocessing commands written below, still work in progress
* behavioral data in $WORK/temple/sourcebehav/sourcebehav, will need to fix double nesting
* slaunch is for multiple subjects at once, just use launch to run a normal job (slaunch for just one sub won't work unless you define variable in advance)

## 1. Source relevant profile
* activates virtual environment with relevant packages, sets some paths
```
cd $HOME/analysis/temple
source profile
```

## 2. Convert source DICOM data to BIDS formatting
```
slaunch -J heudiconv "temple_heudiconv.sh {} $WORK/temple/sourcedata2 $HOME/analysis/temple/bin/temple_heuristic.py $SCRATCH/temple/skyra_prepro" $SUBIDS -N 1 -n 1 -r 00:30:00 -p development
```
* new heuristic file needed for prisma

## 3. Add fieldmap information to BIDS formatted raw data
```
temple_bids_post.py $SCRATCH/temple/skyra_prepro/
```

## 4. Convert behavioral data into BIDS format within BIDS formatted subject directories
```
temple_bids_events.py $WORK/temple/sourcebehav/ $SCRATCH/temple/skyra_prepro/
```
 * need to make sure subject number listed in tasks.py
 * may need to replace nans with 0's for later analyses
   
### 4.2 Fix collector task output 
```
fix_collector.py fmriprep_dir subject
```
   
## 5. Run fmriprep
```
slaunch -J fmriprep “temple_fmriprep.sh $SCRATCH/temple/rawdata2 {}" $BIDIDS -N 1 -n 1 -r 08:00:00 -p normal
```

## 6. Create mask based on freesurfer parcellations and skullstrip functional runs
```
prep_func_data.sh freesurfer_dir fmriprep_dir subject task num_runs
```

## 7. Skullstrip anatomical image and create transform images/affine files for registration between functional, anatomical, and MNI space
```
mni_transforms.sh fmriprep_dir subject
```
## 8. Smooth functional data with 4mm kernel
* set up to smooth four runs right now, will need to edit for arrow
```
temple_smooth.sh fmriprep_dir freesurfer_dir subject task
```


