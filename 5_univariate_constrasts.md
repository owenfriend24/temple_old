# Univariate Contrasts

### for benchmarks - comparing activity at boundary at end of learning to beginning
* first-level; 1st item in a triplet minus 3rd item in a triplet
* second-level; 4th run vs. 1st run
### 1. format behavioral data and motion confounds into .txt files for feat
   * file_type can be collector, motion, or both
```
univ_txt_files.py fmriprep_dir file_type subject out_dir
```
```
univ_txt_files.py $FMDIR collector temple024 $FMDIR/sub-temple024/univ/
```
### 2. create first level .fsf files based on template
```
edit_first_uni.sh template out_path subject fmriprep_dir
```
```
edit_first_uni.sh $HOME/analysis/temple/univ/univ_first_template.fsf $FMDIR/sub-temple024/univ/ temple024 $FMDIR
```
### 3. run first level univariate analyses, save to native directory and transform output to MNI space for second level
```
run_first_unis.sh fmriprep_dir subject
```
### 4. create second level .fsf files based on template - passes in 222 as num_vols to indicate second level
```
edit_second_uni.sh template out_path subject fmriprep_dir
```
### 5. run second level analyses
```
run_second_unis.sh fmriprep_dir subject
```
### 6. run third level analysis to average across subjects
```
run_third_feat.sh fmriprep_dir uni
