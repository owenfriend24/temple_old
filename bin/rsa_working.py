#!/usr/bin/env python

from mvpa2.misc.fsl.base import *
from mvpa2.datasets.mri import fmri_dataset
from mvpa2.measures.rsa import PDist


import nibabel
import scipy.stats
from scipy.stats.mstats import zscore
from scipy.ndimage import convolve1d
from scipy.sparse import spdiags
from scipy.linalg import toeplitz
from mvpa2.datasets.mri import *
import os
import sys
from copy import copy


import numpy as np

subjects = ['temple037']
masks = ['b_hip_func']
fsdir = '/scratch/09123/ofriend/temple/skyra_prepro/derivatives/fmriprep/sourcedata/freesurfer'
fmdir = '/scratch/09123/ofriend/temple/skyra_prepro/derivatives/fmriprep/beta'

for sub in subjects:
    for mask in masks:
        # create full matrix with correlation distance
        rsafx = PDist(square=True)
        runs = ['pre', 'post']
        rsamask = f'{fsdir}/sub-{sub}/mri/{mask}.nii.gz'
        
        for r in runs:
            betadir = f'{fmdir}/sub-{sub}/func/sub-{sub}_task-arrow_{r}.nii.gz'  # Assuming the filename construction is correct
            if not os.path.exists(betadir):
                print(f"File {betadir} does not exist. Skipping...")
                continue
            
            ds = fmri_dataset(betadir, mask=rsamask)
            rs = rsafx(ds)

            # save as text file
            subjoutfile = f"sub-{sub}_{r}_allruns_{mask}.txt"
            np.savetxt(subjoutfile, 1 - rs.samples, fmt="%.8f")
