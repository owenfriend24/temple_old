# Univariate Contrasts

## for benchmarks - differences in boundary items between run 4 and run 1
* collector outputted with temple_bids_events isn't formatted right, need to run fix_collector.py
  * tested locally, need to test on tacc
  * usage: fix_collector.py {data_dir} {sub}
    * e.g. fix_collector.py $SCRATCH/temple/skyra_prepro/derivatives/fmriprep-23.0.2 024
* reformat collector output and motion confounds to .txt files with univ_text_files.py
  * tested locally, need to test on tacc
  * usage: univ_text_files.py {data_dir {type} {sub} {out_dir}
    * e.g. univ_text_files.py $SCRATCH/temple/skyra_prepro/derivatives/fmriprep-23.0.2 motion 024 $SCRATCH/temple/skyra_prepro-derivatives/fmriprep-23.0.2/sub-temple024/univ
    * e.g. univ_text_files.py $SCRATCH/temple/skyra_prepro/derivatives/fmriprep-23.0.2 collector 024 $SCRATCH/temple/skyra_prepro-derivatives/fmriprep-23.0.2/sub-temple024/univ
