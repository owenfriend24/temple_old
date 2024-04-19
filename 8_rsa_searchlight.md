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
### cluster
cluster -i {input} -t 0.99 --minextent= ### --oindex = {output mask}
