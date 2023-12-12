### create .txt files for mean activation within hippocampus for each TR
* starts with creating bilateral hippocampus mask in participant's functional space
```
ppi_hpc_mean.sh freesurfer_dir fmriprep_dir subject task
```

```
ppi_txt_behav.sh fmriprep_dir both subject out_dir/
```
template = ppi_first_template.fsf
``` 
edit_first_fsf.sh template out_path subject fmriprep_dir
```

'''
run_first_ppis.sh fmriprep_dir subject
```
