#!/usr/bin/env python
#
# fix collector runs to correctly reflect triads and objects

from pathlib import Path
import pandas as pd
import os
import argparse

def main(data_dir, sub):
    func_dir = data_dir + f'/sub-{sub}/func/'
    a1 = pd.read_table(func_dir + f'sub-{sub}_task-arrow_run-01_events.tsv')
    a2 = pd.read_table(func_dir + f'sub-{sub}_task-arrow_run-02_events.tsv')
    a3 = pd.read_table(func_dir + f'sub-{sub}_task-arrow_run-03_events.tsv')
    a4 = pd.read_table(func_dir + f'sub-{sub}_task-arrow_run-04_events.tsv')
    a5 = pd.read_table(func_dir + f'sub-{sub}_task-arrow_run-05_events.tsv')
    a6 = pd.read_table(func_dir + f'sub-{sub}_task-arrow_run-06_events.tsv')

    run = 1
    for arr_run in [a1, a2, a3, a4, a5, a6]:
        arr_run = arr_run.fillna(0)  
        out = (func_dir + f'sub-{sub}_task-arrow_run-0{run}_events.tsv')
        arr_run.to_csv(out, sep='\t', index=False)
        print('fixed run ' + str(run))
        run += 1

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("data_dir", help="fmriprep directory")
    parser.add_argument("sub", help="subject number e.g. temple001")
    args = parser.parse_args()
    main(args.data_dir, args.sub)
