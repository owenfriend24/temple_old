#!/bin/bash
#
# Pull Temple bids behavior files.

if [[ $# -lt 2 ]]; then
    echo "Usage:   temple_pull_bids_beh.sh src dest [rsync flags]"
    exit 1
fi

src=$1
dest=$2
shift 2

rsync -azvu "$src" "$dest" \
    --include="sub-*/*/*.tsv" \
    --exclude="sub-*/*/*.nii.gz" \
    --exclude="der*" \
    --exclude="*.tsv" \
    --exclude="*.json" \
    --exclude="*.out" \
    --exclude="fmap" \
    --exclude="anat" \
    --exclude=".heudiconv" \
    --exclude="CHANGES" \
    --exclude="README"
