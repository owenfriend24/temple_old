## Whole brain searchlight for within-triad similarity and AC similarity
### 1. activate rsa profile
```
source $HOME/analysis/temple/rsa/bin/activate
```
### 2. Searchlight 
* calls temple_function_prepost.py function
```
temple_sl_prepost.py temple071 whole_brain
```

### 3. whole brain / FS hippocampus RSA
* calls prepost_roi.py
```
ac_rs_values.py temple071 whole_brain
```

* some commented out code related to residuals in betaseries_est.py - pretty sure don't need that anymore because I have pull_resid.py function but left just in case it comes up later

### cluster
cluster -i {input} -t 0.99 --minextent= ### --oindex = {output mask}


### MDS within extracted SL ROI masks
sl_masks_to_func.sh temple016 $FM AC adult_IFG_AC_mask
mds_sub.py $FM temple016 $FM/sub-temple016/transforms/adult_IFG_AC_mask.nii.gz adult_IFG_AC
batch_mds_subs.sh $adults


### symmetry analyses (in progress) - need to create dropped run version; so far only looking at Apost and B/Cpre, will need to add a CpostApre and Bpost Apre function for full asymmetry indices
sl_symmetry.py temple016 whole_brain AC


### check back later with already completed sub to make sure this is the right order of functions and such
mni_hip_masks.sh $FM temple069
mkdir $FM/searchlight/prepost_AC_txt/temple069
ac_rs_values.py temple069 sl AC
* looks good
