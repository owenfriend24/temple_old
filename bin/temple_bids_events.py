#!/usr/bin/env python
#
# Export behavioral task events to BIDS format.

import os
import argparse
import json
import pdb, traceback, sys

from pkg_resources import resource_filename
import numpy as np

from temple import tasks
from temple import raw


def write_events(data, keys, bids_dir, task, data_type, file_type):
    """Write run events."""
    multiple_runs = data["run"].nunique() > 1
    for (subject, part, run_n), run_data in data.groupby(["subject", "part", "run"]):
        subj_dir = os.path.join(bids_dir, f"sub-temple{subject:03d}", data_type)
        os.makedirs(subj_dir, exist_ok=True)
        if multiple_runs:
            file = os.path.join(
                subj_dir, f"sub-temple{subject:03d}_task-{task}_run-{run_n:02d}_events.tsv"
            )
        else:
            file = os.path.join(subj_dir, f"sub-temple{subject:03d}_task-{task}_{file_type}.tsv")
        
        # fill blanks with NaN for bids formatting
        run_data.replace(r'^\s*$', np.nan, regex=True, inplace=True)

        # save out
        run_data[keys].to_csv(
            file, sep='\t', index=False
        )


def copy_json(in_file, out_file):
    """Copy a JSON file."""
    with open(in_file, "r") as f:
        j = json.load(f)

    with open(out_file, "w") as f:
        json.dump(j, f, indent=4)


def main(study_dir, bids_dir, mat=True):
    data_dir = os.path.join(study_dir, "sourcebehav")
    scan_dir = os.path.join(study_dir, "sourcedata")
    srcdir = os.environ["SRCDIR"]
    subjects = tasks.get_subj_list()
    keys = [
        "onset",
        "trial",
        "duration",
        "object",
        "position",
        "triad",
        "left_right",
        "response",
        "response_time",
        "acc"
    ]

    # get all data
    data = raw.load_arrow_runs(data_dir)

    # arrow
    write_events(data, keys, bids_dir, "arrow", "func", "events")
    json_file = os.path.join(srcdir, "src/temple/data/task-arrow_events.json")
    copy_json(json_file, os.path.join(bids_dir, "task-arrow_events.json"))

    # # using more sophisticated package structure
    # json_file = resource_filename("temple", "data/task-arrow_pt1_events.json")
    # copy_json(json_file, os.path.join(bids_dir, "task-arrow_pt1_events.json"))

    # collector
    keys = [
        "trial",
        "onset",
        "duration",
        "object",
        "position",
        "triad",
        "odd",
        "response",
        "response_time",
        "acc"
    ]

    # get all data
    data = raw.load_collector_runs(data_dir, mat=True)
    write_events(data, keys, bids_dir, "collector", "func", "events")
    json_file = os.path.join(srcdir, "src/temple/data/task-collector_events.json")
    copy_json(json_file, os.path.join(bids_dir, "task-collector_events.json"))

    keys = [
        "trial",
        "item1",
        "item2",
        "item3",
        "item4",
        "item5",
        "item6",
        "order",
        "order_resp",
        "side",
        "side_resp",
        "acc",
        "response_time",
        "reps"
    ]
    data = raw.load_remember(data_dir, subjects=None)
    write_events(data, keys, bids_dir, "remember", "beh", "events")
    json_file = os.path.join(srcdir, "src/temple/data/task-remember_events.json")
    copy_json(json_file, os.path.join(bids_dir, "task-remember_events.json"))


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("study_dir", help="main data directory")
    parser.add_argument("bids_dir", help="output directory for BIDS files")
    parser.add_argument("--mat", action=argparse.BooleanOptionalAction, default=False, help="process .mat files or not")
    args = parser.parse_args()
    main(args.study_dir, args.bids_dir, args.mat)
