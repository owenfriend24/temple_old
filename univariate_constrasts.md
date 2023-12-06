# Univariate Contrasts

## for benchmarks - differences in boundary items between run 4 and run 1
* collector outputted with temple_bids_events isn't formatted right, need to run fix_collector.py
  * tested locally, need to test on tacc
  * usage: fix_collector.py {data_dir} {sub}
    * e.g. fix_collector.py $SCRATCH/temple/skyra_prepro/derivatives/fmriprep-23.0.2 024
      ```
    * (tempenv) login2.ls6(1256)$ for subject in temple016 temple019 temple020 temple022 temple024 temple025 temple029 temple030 temple032 temple033 temple034 temple035 temple036 temple037 temple038 temple041 temple042 temple050 temple051; do
     fix_collector.py $FMDIR $subject
```
      done
      *did not work on 22, 34, will need to check on their data (same with collector stuff below)

* reformat collector output and motion confounds to .txt files with univ_text_files.py
  * tested locally, need to test on tacc
  * usage: univ_text_files.py {data_dir {type} {sub} {out_dir}
    * e.g. univ_text_files.py $SCRATCH/temple/skyra_prepro/derivatives/fmriprep-23.0.2 motion 024 $SCRATCH/temple/skyra_prepro-derivatives/fmriprep-23.0.2/sub-temple024/univ
     * need to run for 16 and 19 once succesfully processed
```
or SUBJECT in temple016 temple019 temple020 temple022 temple024 temple025 temple029 temple030 temple032 temple033 temple034 temple035 temple036 temple037 temple038 temple041 temple042 temple050 temple051; do     univ_txt_files.py "$FMDIR" collector "$SUBJECT" "$FMDIR/sub-$SUBJECT/univ/"; done
```
    * e.g. univ_text_files.py $SCRATCH/temple/skyra_prepro/derivatives/fmriprep-23.0.2 collector 024 $SCRATCH/temple/skyra_prepro-derivatives/fmriprep-23.0.2/sub-temple024/univ
