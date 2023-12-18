#!/bin/bash

if [[ $# -lt 2 ]]; then
    echo "Usage: move_to_corral.sh fmriprep_dir subject"

    exit 1
fi

fmriprep_dir=$1
subject=$2

corr="/corral-repl/utexas/prestonlab/temple"

mkdir ${corr}/sub-${subject}


mkdir ${corr}/"sub-${subject}"/anat
# anatomical images


cp ${fmriprep_dir}/"sub-${subject}"/anat/"sub-${subject}"_desc-preproc_T1w.json ${corr}/"sub-${subject}"/anat/"sub-${subject}"_desc-preproc_T1w.json
cp ${fmriprep_dir}/"sub-${subject}"/anat/"sub-${subject}"_desc-preproc_T1w.nii.gz ${corr}/"sub-${subject}"/anat/"sub-${subject}"_desc-preproc_T1w.nii.gz
cp ${fmriprep_dir}/"sub-${subject}"/anat/"sub-${subject}"_desc-preproc_T2w.json ${corr}/"sub-${subject}"/anat/"sub-${subject}"_desc-preproc_T2w.json
cp ${fmriprep_dir}/"sub-${subject}"/anat/"sub-${subject}"_desc-preproc_T2w.nii.gz ${corr}/"sub-${subject}"/anat/"sub-${subject}"_desc-preproc_T2w.nii.gz
cp ${fmriprep_dir}/"sub-${subject}"/anat/"sub-${subject}"_MNI_ss.nii.gz ${corr}/"sub-${subject}"/anat/"sub-${subject}"_MNI_ss.nii.gz
cp ${fmriprep_dir}/"sub-${subject}"/anat/"sub-${subject}"_T1w_ss.nii.gz ${corr}/"sub-${subject}"/anat/"sub-${subject}"_T1w_ss.nii.gz

mkdir ${corr}/"sub-${subject}"/func
for run in 1 2 3 4 5 6; do
    cp ${fmriprep_dir}/"sub-${subject}"/func/"sub-${subject}"_task-arrow_run-0${run}_desc-confounds_timeseries.json ${corr}/"sub-${subject}"/func/"sub-${subject}"_task-arrow_run-0${run}_desc-confounds_timeseries.json
    cp ${fmriprep_dir}/"sub-${subject}"/func/"sub-${subject}"_task-arrow_run-0${run}_desc-confounds_timeseries.tsv ${corr}/"sub-${subject}"/func/"sub-${subject}"_task-arrow_run-0${run}_desc-confounds_timeseries.tsv
    cp ${fmriprep_dir}/"sub-${subject}"/func/"sub-${subject}"_task-arrow_run-0${run}_events.tsv ${corr}/"sub-${subject}"/func/"sub-${subject}"_task-arrow_run-0${run}_events.tsv
    cp ${fmriprep_dir}/"sub-${subject}"/func/"sub-${subject}"_task-arrow_run-0${run}_space-T1w_boldref.nii.gz ${corr}/"sub-${subject}"/func/"sub-${subject}"_task-arrow_run-0${run}_space-T1w_boldref.nii.gz
    cp ${fmriprep_dir}/"sub-${subject}"/func/"sub-${subject}"_task-arrow_run-0${run}_space-T1w_desc-aparcaseg_dseg.nii.gz ${corr}/"sub-${subject}"/func/"sub-${subject}"_task-arrow_run-0${run}_space-T1w_desc-aparcaseg_dseg.nii.gz
    cp ${fmriprep_dir}/"sub-${subject}"/func/"sub-${subject}"_task-arrow_run-0${run}_space-T1w_desc-aseg_dseg.nii.gz ${corr}/"sub-${subject}"/func/"sub-${subject}"_task-arrow_run-0${run}_space-T1w_desc-aseg_dseg.nii.gz
    cp ${fmriprep_dir}/"sub-${subject}"/func/"sub-${subject}"_task-arrow_run-0${run}_space-T1w_desc-brain_mask.json ${corr}/"sub-${subject}"/func/"sub-${subject}"_task-arrow_run-0${run}_space-T1w_desc-brain_mask.json
    cp ${fmriprep_dir}/"sub-${subject}"/func/"sub-${subject}"_task-arrow_run-0${run}_space-T1w_desc-brain_mask.nii.gz ${corr}/"sub-${subject}"/func/"sub-${subject}"_task-arrow_run-0${run}_space-T1w_desc-brain_mask.nii.gz
    cp ${fmriprep_dir}/"sub-${subject}"/func/"sub-${subject}"_task-arrow_run-0${run}_space-T1w_desc-preproc_bold.json ${corr}/"sub-${subject}"/func/"sub-${subject}"_task-arrow_run-0${run}_space-T1w_desc-preproc_bold.json
    cp ${fmriprep_dir}/"sub-${subject}"/func/"sub-${subject}"_task-arrow_run-0${run}_space-T1w_desc-preproc_bold.nii.gz ${corr}/"sub-${subject}"/func/"sub-${subject}"_task-arrow_run-0${run}_space-T1w_desc-preproc_bold.nii.gz
done

for run in 1 2 3 4; do
    cp ${fmriprep_dir}/"sub-${subject}"/func/"sub-${subject}"_task-collector_run-0${run}_desc-confounds_timeseries.json ${corr}/"sub-${subject}"/func/"sub-${subject}"_task-collector_run-0${run}_desc-confounds_timeseries.json
    cp ${fmriprep_dir}/"sub-${subject}"/func/"sub-${subject}"_task-collector_run-0${run}_desc-confounds_timeseries.tsv ${corr}/"sub-${subject}"/func/"sub-${subject}"_task-collector_run-0${run}_desc-confounds_timeseries.tsv
    cp ${fmriprep_dir}/"sub-${subject}"/func/"sub-${subject}"_task-collector_run-0${run}_events.tsv ${corr}/"sub-${subject}"/func/"sub-${subject}"_task-collector_run-0${run}_events.tsv
    cp ${fmriprep_dir}/"sub-${subject}"/func/"sub-${subject}"_task-collector_run-0${run}_events_fixed.tsv ${corr}/"sub-${subject}"/func/"sub-${subject}"_task-collector_run-0${run}_events_fixed.tsv
    cp ${fmriprep_dir}/"sub-${subject}"/func/"sub-${subject}"_task-collector_run-0${run}_space-T1w_boldref.nii.gz ${corr}/"sub-${subject}"/func/"sub-${subject}"_task-collector_run-0${run}_space-T1w_boldref.nii.gz
    cp ${fmriprep_dir}/"sub-${subject}"/func/"sub-${subject}"_task-collector_run-0${run}_space-T1w_desc-aparcaseg_dseg.nii.gz ${corr}/"sub-${subject}"/func/"sub-${subject}"_task-collector_run-0${run}_space-T1w_desc-aparcaseg_dseg.nii.gz
    cp ${fmriprep_dir}/"sub-${subject}"/func/"sub-${subject}"_task-collector_run-0${run}_space-T1w_desc-aseg_dseg.nii.gz ${corr}/"sub-${subject}"/func/"sub-${subject}"_task-collector_run-0${run}_space-T1w_desc-aseg_dseg.nii.gz
    cp ${fmriprep_dir}/"sub-${subject}"/func/"sub-${subject}"_task-collector_run-0${run}_space-T1w_desc-brain_mask.json ${corr}/"sub-${subject}"/func/"sub-${subject}"_task-collector_run-0${run}_space-T1w_desc-brain_mask.json
    cp ${fmriprep_dir}/"sub-${subject}"/func/"sub-${subject}"_task-collector_run-0${run}_space-T1w_desc-brain_mask.nii.gz ${corr}/"sub-${subject}"/func/"sub-${subject}"_task-collector_run-0${run}_space-T1w_desc-brain_mask.nii.gz
    cp ${fmriprep_dir}/"sub-${subject}"/func/"sub-${subject}"_task-collector_run-0${run}_space-T1w_desc-preproc_bold.json ${corr}/"sub-${subject}"/func/"sub-${subject}"_task-collector_run-0${run}_space-T1w_desc-preproc_bold.json
    cp ${fmriprep_dir}/"sub-${subject}"/func/"sub-${subject}"_task-collector_run-0${run}_space-T1w_desc-preproc_bold.nii.gz ${corr}/"sub-${subject}"/func/"sub-${subject}"_task-collector_run-0${run}_space-T1w_desc-preproc_bold.nii.gz
    cp ${fmriprep_dir}/"sub-${subject}"/func/skullstripped_T1/"sub-${subject}"_task-collector_run-0${run}_space-T1w_desc-preproc_bold_ss_4mm.nii.gz ${corr}/"sub-${subject}"//func/"sub-${subject}"_task-collector_run-0${run}_space-T1w_desc-preproc_bold_ss_4mm.nii.gz
done

for run in 1 2; do
   cp ${fmriprep_dir}/"sub-${subject}"/func/"sub-${subject}"_task-movie_run-0${run}_desc-confounds_timeseries.json ${corr}/"sub-${subject}"/func/"sub-${subject}"_task-movie_run-0${run}_desc-confounds_timeseries.json
    cp ${fmriprep_dir}/"sub-${subject}"/func/"sub-${subject}"_task-movie_run-0${run}_desc-confounds_timeseries.tsv ${corr}/"sub-${subject}"/func/"sub-${subject}"_task-movie_run-0${run}_desc-confounds_timeseries.tsv
    cp ${fmriprep_dir}/"sub-${subject}"/func/"sub-${subject}"_task-movie_run-0${run}_space-T1w_boldref.nii.gz ${corr}/"sub-${subject}"/func/"sub-${subject}"_task-movie_run-0${run}_space-T1w_boldref.nii.gz
    cp ${fmriprep_dir}/"sub-${subject}"/func/"sub-${subject}"_task-movie_run-0${run}_space-T1w_desc-aparcaseg_dseg.nii.gz ${corr}/"sub-${subject}"/func/"sub-${subject}"_task-movie_run-0${run}_space-T1w_desc-aparcaseg_dseg.nii.gz
    cp ${fmriprep_dir}/"sub-${subject}"/func/"sub-${subject}"_task-movie_run-0${run}_space-T1w_desc-aseg_dseg.nii.gz ${corr}/"sub-${subject}"/func/"sub-${subject}"_task-movie_run-0${run}_space-T1w_desc-aseg_dseg.nii.gz
    cp ${fmriprep_dir}/"sub-${subject}"/func/"sub-${subject}"_task-movie_run-0${run}_space-T1w_desc-brain_mask.json ${corr}/"sub-${subject}"/func/"sub-${subject}"_task-movie_run-0${run}_space-T1w_desc-brain_mask.json
    cp ${fmriprep_dir}/"sub-${subject}"/func/"sub-${subject}"_task-movie_run-0${run}_space-T1w_desc-brain_mask.nii.gz ${corr}/"sub-${subject}"/func/"sub-${subject}"_task-movie_run-0${run}_space-T1w_desc-brain_mask.nii.gz
    cp ${fmriprep_dir}/"sub-${subject}"/func/"sub-${subject}"_task-movie_run-0${run}_space-T1w_desc-preproc_bold.json ${corr}/"sub-${subject}"/func/"sub-${subject}"_task-movie_run-0${run}_space-T1w_desc-preproc_bold.json
    cp ${fmriprep_dir}/"sub-${subject}"/func/"sub-${subject}"_task-movie_run-0${run}_space-T1w_desc-preproc_bold.nii.gz ${corr}/"sub-${subject}"/func/"sub-${subject}"_task-movie_run-0${run}_space-T1w_desc-preproc_bold.nii.gz 
done


# transofrms - full directory
mkdir ${corr}/"sub-${subject}"/transforms
cp -R ${fmriprep_dir}/"sub-${subject}"/transforms ${corr}/"sub-${subject}"/transforms

mkdir ${corr}/"sub-${subject}"/univ
for file in ${fmriprep_dir}/"sub-${subject}"/univ/*.fsf; do
    cp ${file} ${corr}/"sub-${subject}"/univ/
done
