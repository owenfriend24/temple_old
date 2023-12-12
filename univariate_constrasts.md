# Univariate Contrasts

### for benchmarks - comparing activity at boundary at end of learning to beginning
* first-level; 3rd item in a triplet compared to 1st item
* second-level; 4th run vs. 1st run
1. format behavioral data and motion confounds for feat
   * file_type can be collector, motion, or both
```
univ_txt_files.py fmriprep_dir file_type subject out_dir
univ_txt_files.py $FMDIR collector temple024 $FMDIR/sub-temple024/univ
```
2. create first level .fsf files based on template
```
edit_first_fsf.sh template out_path subject fmriprep_dir
edit_first_fsf.sh $HOME/analysis/temple/univ/new_template.fsf $FMDIR/sub-temple024/univ/ temple024 $FMDIR
```
3. run first level univariate analyses, save to native directory and transform output to MNI space for second level
```
run_first_levels.sh fmriprep_dir subject
```
4. create second level .fsf files based on template
```
edit_second_fsf.sh template out_path subject fmriprep_dir
```
