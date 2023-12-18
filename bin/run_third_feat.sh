#!/bin/bash
#


if [[ $# -lt 2 ]]; then
    echo "Usage: run_third_feat.sh fmriprep_dir ppi/uni"
    exit 1
fi

fmriprep_dir=$1
model=$2

if [[ "${model}" == "uni" ]]; then
    echo "running third level univariate analysis"
    feat "${fmriprep_dir}/group_univ/uni_third_level.fsf"
fi

if [[ "${model}" == "ppi" ]]; then
    echo "running third level ppi analysis"
    feat "${fmriprep_dir}/group_univ/ppi_third_level.fsf"
fi



