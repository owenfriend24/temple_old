#!/bin/bash
#
# use feat to run first level analyses - specifically for runs 1 and 4 right now
# e.g. launch -J univ_first "/home1/09123/ofriend/analysis/temple/bin/run_first_levels.sh $FMDIR temple033" -N 1 -n 1 -r 00:30:00 -p development

if [[ $# -lt 2 ]]; then
    echo "Usage: run_first_levels.sh fmriprep_dir subject"
    exit 1
fi

fmriprep_dir=$1
subject=$2


for run in 2 3; do
    echo "running first level analysis for sub ${subject}..."
    feat "${fmriprep_dir}/sub-${subject}/univ/sub-${subject}-first_level_run-0${run}.fsf"
    chmod 775 -R "${fmriprep_dir}/sub-${subject}/transforms"
    
    echo "saving first level output to native directory"
    mkdir "${fmriprep_dir}/sub-${subject}/univ/out_run${run}.feat/native"
    cp -r "${fmriprep_dir}/sub-${subject}/univ/out_run${run}.feat/stats/"* "${fmriprep_dir}/sub-${subject}/univ/out_run${run}.feat/native"
    cp "${fmriprep_dir}/sub-${subject}/univ/out_run${run}.feat/example_func.nii.gz" "${fmriprep_dir}/sub-${subject}/univ/out_run${run}.feat/native/example_func.nii.gz"
        cp "${fmriprep_dir}/sub-${subject}/univ/out_run${run}.feat/mean_func.nii.gz" "${fmriprep_dir}/sub-${subject}/univ/out_run${run}.feat/native/mean_func.nii.gz"
    cp "${fmriprep_dir}/sub-${subject}/univ/out_run${run}.feat/mask.nii.gz" "${fmriprep_dir}/sub-${subject}/univ/out_run${run}.feat/native/mask.nii.gz"
    
    # cope images
    echo "transforming cope images"
    for cope in ${fmriprep_dir}/sub-${subject}/univ/"out_run${run}.feat"/stats/cope*; do
    antsApplyTransforms -d 3 -i "${cope}" -o "${cope}" -n BSpline -r /corral-repl/utexas/prestonlab/xmaze/batch/templates/MNI152_T1_1mm_brain.nii.gz -t "/scratch/09123/ofriend/temple/skyra_prepro/derivatives/fmriprep/sub-temple024/transforms/native_to_MNI_Warp.nii.gz" -t "/scratch/09123/ofriend/temple/skyra_prepro/derivatives/fmriprep/sub-temple024/transforms/native_to_MNI_Affine.txt" -t "/scratch/09123/ofriend/temple/skyra_prepro/derivatives/fmriprep/sub-temple024/transforms/mask_to_func_ref_Affine.txt"
    done
    
    # func data
    echo "transforming func data"
    for func in "${fmriprep_dir}/sub-${subject}/univ/out_run${run}.feat/example_func.nii.gz" "${fmriprep_dir}/sub-${subject}/univ/out_run${run}.feat/mean_func.nii.gz"; do
    antsApplyTransforms -d 3 -i "${func}" -o "${func}" -n BSpline -r /corral-repl/utexas/prestonlab/xmaze/batch/templates/MNI152_T1_1mm_brain.nii.gz -t "/scratch/09123/ofriend/temple/skyra_prepro/derivatives/fmriprep/sub-temple024/transforms/native_to_MNI_Warp.nii.gz" -t "/scratch/09123/ofriend/temple/skyra_prepro/derivatives/fmriprep/sub-temple024/transforms/native_to_MNI_Affine.txt" -t "/scratch/09123/ofriend/temple/skyra_prepro/derivatives/fmriprep/sub-temple024/transforms/mask_to_func_ref_Affine.txt"
    done


    # mask
    echo "transforming mask"
    antsApplyTransforms -d 3 -i "${fmriprep_dir}/sub-${subject}/univ/out_run${run}.feat/mask.nii.gz" -o "${fmriprep_dir}/sub-${subject}/univ/out_run${run}.feat/mask.nii.gz" -n NearestNeighbor -r /corral-repl/utexas/prestonlab/xmaze/batch/templates/MNI152_T1_1mm_brain.nii.gz -t "/scratch/09123/ofriend/temple/skyra_prepro/derivatives/fmriprep/sub-temple024/transforms/native_to_MNI_Warp.nii.gz" -t "/scratch/09123/ofriend/temple/skyra_prepro/derivatives/fmriprep/sub-temple024/transforms/native_to_MNI_Affine.txt" -t "/scratch/09123/ofriend/temple/skyra_prepro/derivatives/fmriprep/sub-temple024/transforms/mask_to_func_ref_Affine.txt"
    
    echo "formatting reg folder"
    # set up reg folder
    mkdir "${fmriprep_dir}/sub-${subject}/univ/out_run${run}.feat/reg"
    cp /corral-repl/utexas/prestonlab/xmaze/batch/templates/MNI152_T1_1mm_brain.nii.gz "${fmriprep_dir}/sub-${subject}/univ/out_run${run}.feat/reg/standard.nii.gz"

    cp "${fmriprep_dir}/sub-${subject}/anat/sub-${subject}_MNI_ss.nii.gz" "${fmriprep_dir}/sub-${subject}/univ/out_run${run}.feat/reg/highres.nii.gz"

    cp "/home1/09123/ofriend/analysis/temple/univ/identity.mat" "${fmriprep_dir}/sub-${subject}/univ/out_run${run}.feat/reg/example_func2standard.mat"

    updatefeatreg "${fmriprep_dir}/sub-${subject}/univ/out_run${run}.feat" -pngs
done

