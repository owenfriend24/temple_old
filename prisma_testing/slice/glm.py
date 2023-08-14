"""Functions for fitting general linear models to fMRI data."""

from pathlib import Path
import json
import numpy as np
import pandas as pd
import nibabel as nib
import mindstorm.glm as mglm


def prep_run_model(
    data_dir,
    fmriprep_dir,
    subject,
    task,
    run,
    space,
    confound_measures,
    events_column="category",
    offset=None,
):
    """Prepare data and model for fitting one run."""
    # task events, functional data, and confounds
    data_dir = Path(data_dir)
    fmriprep_dir = Path(fmriprep_dir)
    events_path = (
        data_dir
        / f"sub-{subject}"
        / "func"
        / f"sub-{subject}_task-{task}_run-{run}_events.tsv"
    )
    func_path = (
        fmriprep_dir
        / f"sub-{subject}"
        / "func"
        / f"sub-{subject}_task-{task}_run-{run}_space-{space}_desc-preproc_bold.nii.gz"
    )
    confound_path = (
        fmriprep_dir
        / f"sub-{subject}"
        / "func"
        / f"sub-{subject}_task-{task}_run-{run}_desc-confounds_timeseries.tsv"
    )
    mask_path = (
        fmriprep_dir
        / f"sub-{subject}"
        / "func"
        / f"sub-{subject}_task-{task}_run-{run}_space-T1w_desc-brain_mask.nii.gz"
    )

    # load functional timeseries information
    func_json = func_path.with_suffix("").with_suffix(".json")
    with open(func_json, "r") as f:
        func_param = json.load(f)
    tr = func_param["RepetitionTime"]
    time_offset = func_param["StartTime"]

    # create nuisance regressor matrix
    confounds = pd.read_table(confound_path)
    nuisance, nuisance_names = mglm.create_confound_matrix(
        confounds, confound_measures, censor_motion=True
    )

    # make design matrix
    events = pd.read_table(events_path)
    if offset is not None:
        events["onset"] += offset
    img = nib.load(func_path)
    n_vol = img.header["dim"][4]
    design = mglm.create_simple_design(
        events, events_column, n_vol, tr, time_offset, high_pass=0.01
    )

    # add confounds
    full_design = pd.DataFrame(
        np.hstack([design.to_numpy(), nuisance]),
        index=design.index,
        columns=design.columns.to_list() + nuisance_names,
    )

    # load functional data
    bold_vol = nib.load(func_path)
    mask_vol = nib.load(mask_path)
    return full_design, bold_vol, mask_vol
