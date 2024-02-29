# Pre-Processing:
Notes:
* When new fmriprep image works, re-run all preprocessing and output into one directory; copy to corral
* current preprocessing commands written below, still work in progress
* behavioral data in $WORK/temple/sourcebehav/sourcebehav, will need to fix double nesting
* slaunch is for multiple subjects at once, just use launch to run a normal job (slaunch for just one sub won't work unless you define subject variable in advance)

## 1. Source relevant profile
* activates virtual environment with relevant packages, sets some paths
```
cd $HOME/analysis/temple
source profile
```

## 2. Convert source DICOM data to BIDS formatting
* DICOM data comes off the scanner with slightly different file structures for the Prisma and the Skyra; different scripts and heuristic files needed depending on subject
* 53 and below = Skyra, 56+ = Prisma
* SKYRA
```
slaunch -J heudiconv "skyra_heudiconv.sh {} $WORK/temple/sourcedata2 $HOME/analysis/temple/bin/skyra_heuristic.py $SCRATCH/temple/skyra_prepro" $SUBIDS -N 1 -n 1 -r 00:30:00 -p development
```
* PRISMA
```
slaunch -J heudiconv "temple_heudiconv.sh {} $WORK/temple/sourcedata2 $HOME/analysis/temple/bin/temple_heuristic.py $SCRATCH/temple/prisma_prepro" $SUBIDS -N 1 -n 1 -r 00:30:00 -p development
```
## 3. Add fieldmap information to BIDS formatted raw data
* may need a separate script for skyra ppt's vs. prisma - test when reprocessing
* SKYRA
```
old_temple_bids_post.py $SCRATCH/temple/skyra_prepro
```
* PRISMA
```
temple_bids_post.py $SCRATCH/temple/prisma_prepro
```
## 4. Convert behavioral data into BIDS format within BIDS formatted subject directories - move this to a separate behavioral markdown file
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
* runs via Singularity/Apptainer image in $WORK; currently testing to make sure it works. Still points to Neal's freesurfer license I believe
* temple_fmriprep.sh includes command line that specifies some parameters including:
   * participant label - passed in with job launch; temple_### denotes raw data, temple### denotes data converted to BIDS (BIDS does not allow underscores)
   * std. dvars threshold = 1.5
   * framewise displacement threshold = 0.5
   * high-pass filter = 128
   * output spaces = MNI
   * omp-nthreads = 12
   * num_threads = 18
   * mem_mb = 60000
   * skip_bids_validation (make sure BIDS compliant when running heudiconv)
```
slaunch -J fmriprep “temple_fmriprep.sh $SCRATCH/temple/prisma_prepro {}" $BIDIDS -N 1 -n 1 -r 08:00:00 -p normal
```

## 6. Create mask based on freesurfer parcellations and skullstrip functional runs
* fmriprep doesn't skullstrip the functional data, so we create a brainmask here using the freesurfer output and use it to skullstrip all functional runs
```
prep_func_data.sh freesurfer_dir fmriprep_dir subject task num_runs
```

## 7. Skullstrip anatomical image and create transform images/affine files for registration between functional, anatomical, and MNI space
* Now skullstrip the anatomical image and create all files necessary to transform between different spaces
```
mni_transforms.sh fmriprep_dir subject
```
## 8. Smooth functional data with 4mm kernel
* set up to smooth four runs right now, will need to edit for arrow
* also will want to incorporate some of the 'clean_scratch' code here to make sure the files we're working with stay in BIDS format
```
temple_smooth.sh fmriprep_dir freesurfer_dir subject task
```


