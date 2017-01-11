#!/bin/bash
if [ -z "$EPICS_BASE" ];                then export   EPICS_BASE=/usr/local/epics/base;
fi
if [ -z "$EPICS_IOC_LOG_PORT" ];        then export   EPICS_IOC_LOG_PORT=7004;
fi
if [ -z "$EPICS_IOC_LOG_FILE_LIMIT" ];  then export   EPICS_IOC_LOG_FILE_LIMIT=1073741824;
fi
echo =============================================================================================
echo
echo EPICS_BASE                   is defined as ${EPICS_BASE}                 for locating epics
echo EPICS_IOC_LOG_PORT           is defined as ${EPICS_IOC_LOG_PORT}         for setting epics ioc log port
echo EPICS_IOC_LOG_FILE_LIMIT     is defined as ${EPICS_IOC_LOG_FILE_LIMIT}   for setting ioc log file size limit
echo EPICS_IOC_LOG_FILE_NAME      is defined as ${EPICS_IOC_LOG_FILE_NAME}    for ioc log file name

EPICS_IOC_LOG_FILE_NAME="/home/admin/Desktop/epics/ioc.log" export EPICS_IOC_LOG_FILE_NAME
echo "Starting EPICS Log Server. Ctrl + C to Quit Server"
iocLogServer
