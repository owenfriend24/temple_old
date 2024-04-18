## 1. Convert behavioral data into BIDS format within BIDS formatted subject directories
```
temple_bids_events.py $WORK/temple/sourcebehav/ $SCRATCH/temple/skyra_prepro/
```
 * need to make sure subject number listed in tasks.py to run
```
vim $WORK/tempenv/lib/python3.9/site-packages/temple/tasks.py
```
 * need to replace nans with 0's or remove for later analyses
 * collector and arrow output are both a little weird; right now have fix scripts but can integrate them all later

### 2 Fix arrow task output 
* adds/fixes triad (1-4) and position (1-3) values
* outputs events files directly back into func directory, while creating an 'orig_events' directory within func and copying original events files
```
fix_arrow.py fmriprep_dir subject
```

### 3. Fix collector task output - problem with fix_collector when running after reformatting arrow files. will need to fix later. for now, fix_collector works with unformatted arrow (i.e. directly after temple_bids_events)
* adds/fixes triad (1-4) and position (1-3) values
```
fix_collector.py fmriprep_dir subject
```

 
