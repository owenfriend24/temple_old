## 1. Convert behavioral data into BIDS format within BIDS formatted subject directories
```
temple_bids_events.py $WORK/temple/sourcebehav/ $SCRATCH/temple/skyra_prepro/
```
 * need to make sure subject number listed in tasks.py to run
 * need to replace nans with 0's or remove for later analyses
 * collector and arrow output are both a little weird; right now have fix scripts but can integrate them all later
   
### 2 Fix collector task output 
* adds/fixes triad (1-4) and position (1-3) values
```
fix_collector.py fmriprep_dir subject
```

### 3 Fix arrow task output 
* adds/fixes triad (1-4) and position (1-3) values
```
fix_arrow.py fmriprep_dir subject
```
### 4. Create separate formatted .txt files for each EV and for confounds (i.e., each of the 12 items)
```
prep_arrow.py fmriprep_dir subject
```
 
