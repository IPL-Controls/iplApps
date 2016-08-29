#!/bin/sh

# start, or restart, caputRecorder.py

PREFIX=$1
if [ "" == "${PREFIX}" ] ; then
	PREFIX="VPFI:SCAN:"
fi

MACROS_PY_DIR=../../scanSupportApp/opi/python
# output=`perl -s ${EPICS_APP}/release.pl -form=bash ${EPICS_APP}`
# eval $output

CAPUTRECORDER_PY=${MACROS_PY_DIR}/caputRecorder.py
COMMAND="/bin/python ${CAPUTRECORDER_PY}"

export PYTHONPATH=${MACROS_PY_DIR}:$PYTHONPATH
MACROS_PY=${MACROS_PY_DIR}/macros.py

# start caputRecorder.py
$COMMAND ${PREFIX} ${MACROS_PY}&

# start caputRecorder.py, and give it a list of additional prefixes to monitor
#$COMMAND ${PREFIX} VPFI:OXFORD:xray: VPFI:KOHZU: VPFI:Qi2: ${MACROS_PY}&
