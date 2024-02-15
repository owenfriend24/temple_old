#!/bin/bash

if [[ $# -lt 3 ]]; then
    echo "Usage: batch_beta.sh fm_dir fs_dir subject"
    exit 1
fi

fm_dir=$1
fs_dir=$2
subject=$3

source /home1/09123/ofriend/analysis/temple/profile

mkdir /corral-repl/utexas/prestonlab/temple/beta/sub-${subject}

out_dir=/corral-repl/utexas/prestonlab/temple/beta/sub-${subject}

conf=csf:csf_derivative1:white_matter:white_matter_derivative1:trans_x:trans_x_derivative1:trans_y:trans_y_derivative1:trans_z:trans_z_derivative1:rot_x:rot_x_derivative1:rot_y:rot_y_derivative1:rot_z:rot_z_derivative1

for run in 1 2 3 4 5 6; do
    betaseries-bids --confound-measures ${conf} ${fm_dir} ${fm_dir} ${out_dir} ${subject} arrow 0${run} T1w \
    gm_func_dilated ${fs_dir}/sub-${subject}/mri/out/brainmask_func_dilated.nii.gz object

    echo "Created beta image for run ${run}!"
done

cd ${out_dir}/func

fslmaths sub-${subject}_task-arrow_run-01_space-T1w_label-gm_func_dilated_betaseries.nii.gz \
-add sub-${subject}_task-arrow_run-02_space-T1w_label-gm_func_dilated_betaseries.nii.gz \
-add sub-${subject}_task-arrow_run-03_space-T1w_label-gm_func_dilated_betaseries.nii.gz \
sub-${subject}_task-arrow_space-T1w_mask-gm_func_dilated_PRE_betaseries.nii.gz

fslmaths sub-${subject}_task-arrow_run-04_space-T1w_label-gm_func_dilated_betaseries.nii.gz \
-add sub-${subject}_task-arrow_run-05_space-T1w_label-gm_func_dilated_betaseries.nii.gz \
-add sub-${subject}_task-arrow_run-06_space-T1w_label-gm_func_dilated_betaseries.nii.gz \
sub-${subject}_task-arrow_space-T1w_mask-gm_func_dilated_PRE_betaseries.nii.gz
