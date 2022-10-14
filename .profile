#!/bin/bash

#script directory

# study name and directory
export STUDY=temple
export SRCDIR=$HOME/analysis/temple
export STUDYDIR=$STOCKYARD2/ls6/temple
export BATCHDIR=$STOCKYARD2/ls6/temple/batch/launchscripts

# add analysis scripts to path
export PATH=$PATH:$SRCDIR/bin
export STUDYDIR=$STOCKYARD2/ls6/temple
. $STOCKYARD2/ls6/venv/envtemple_ls/bin/activate

# subjects
export SUBJNOS=016:019:020:022:023:024:025:029:030:032:033:034:035:036:037:038:041:042:050:051
export SUBIDS=temple_016:temple_019:temple_020:temple_022:temple_023:temple_024:temple_025:temple_029:temple_030:temple_032:temple_033:temple_034:temple_035:temple_036:temple_037:temple_038:temple_041:temple_042:temple_050:temple_051
export BIDIDS=temple016:temple019:temple020:temple022:temple023:temple024:temple025:temple029:temple030:temple032:temple033:temple034:temple035:temple036:temple037:temple038:temple041:temple042:temple050:temple051
