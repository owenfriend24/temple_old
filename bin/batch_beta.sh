#!/bin/bash

if [[ $# -lt 3 ]]; then
    echo "Usage: batch_beta.sh fm_dir out_dir subject"
    exit 1
fi

fm_dir=$1
out_dir=$2
subject=$3


# Activate your virtual environment if you're using one
source /home1/09123/ofriend/analysis/temple/profile

for run in 1 2 3 4 5 6; do
    betaseries-bids --confound-measures csf:csf_derivative1:white_matter:white_matter_derivative1:trans_x:trans_x_derivative1:trans_y:trans_y_derivative1:trans_z:trans_z_derivative1:rot_x:rot_x_derivative1:rot_y:rot_y_derivative1:rot_z:rot_z_derivative1 
