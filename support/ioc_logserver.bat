@echo off
rem ****************************************************************************
rem This bat file starts the EPICS IOC log server.
rem
rem Name:            ioc_logserver.bat
rem Status:          Stable
rem Date Created:    8/2015
rem Author:          Alireza Panna, IPL/NHLBI/NIH
rem Update log:      10/2015 (AP) set env variables, ask for log file name
rem ****************************************************************************

: set filename
rem set /P FNAME= "Enter log file name: "
  set YYYY=%DATE:~10%
  set DD=%DATE:~7,2%
  set MO=%DATE:~4,2%
  set HH=%TIME:~0,2%
  set MM=%TIME:~3,2%
  set SS=%TIME:~6,2%
  set FNAME=d%YYYY%%MO%%DD%_%HH%%MM%%SS%

:set environment variables
  set TOP=C:\Epics
  if [%EPICS_BASE%] == [] set EPICS_BASE=C:\Epics\base-3.14.12.5
  if [%EPICS_EXTENSIONS%] == [] set EPICS_EXTENSIONS=C:\Epics\extensions
  if [%EPICS_IOC_LOG_PORT%] == [] set EPICS_IOC_LOG_PORT=7004
  if [%EPICS_IOC_LOG_FILE_LIMIT%] == [] set EPICS_IOC_LOG_FILE_LIMIT=1073741824
  if exist "%EPICS_BASE%\bin\%EPICS_HOST_ARCH%" set PATH=%EPICS_BASE%\bin\%EPICS_HOST_ARCH%;%PATH%
  if exist "%EPICS_EXTENSIONS%\bin\%EPICS_HOST_ARCH%" set PATH=%EPICS_EXTENSIONS%\bin\%EPICS_HOST_ARCH%;%PATH%
  if not exist %TOP%\log mkdir %TOP%\log
  set EPICS_IOC_LOG_FILE_NAME=%TOP%\log\%FNAME%.log

:display environment variables
  echo =========================================================================
  echo EPICS base location: %EPICS_BASE%
  echo IOC log port: %EPICS_IOC_LOG_PORT%
  echo Log file location: %EPICS_IOC_LOG_FILE_NAME%
  echo =========================================================================
  
:start log server
  if exist "C:\Epics\extensions\bin\%EPICS_HOST_ARCH%\procServ.exe" (
    echo Starting EPICS Log Server...
    procServ --allow -n "LOG-SERVER" -i ^D^C 7000 %EPICS_BASE%\bin\%EPICS_HOST_ARCH%\iocLogServer.exe 
  ) else (
    echo Starting EPICS Log Server. Ctrl + C to Quit Server
    iocLogServer
  )