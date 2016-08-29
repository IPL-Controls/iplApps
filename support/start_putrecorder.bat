@echo on
rem start caputRecorder.py

:set environment
  	set TOP=%cd%
  	set EPICS_APP=%TOP%\scanSupport
  	set MACROS_PY_DIR=%EPICS_APP%\scanSupportApp\opi\python
  	if [%EPICS_BASE%] == [] set EPICS_BASE=C:\Epics\base-3.14.12.5
  	if [%START_PUTRECORDER%] == [] set START_PUTRECORDER=%cd%
  	if [%MACROS_PY%] == [] set MACROS_PY=%MACROS_PY_DIR%\macros.py
  	if [%PYTHONPATH%] == [] set PYTHONPATH=C:\WinPython-32bit-2.7.6.4\python-2.7.6
  	set CAPUTRECORDER_PY=%MACROS_PY_DIR%\caputRecorder.py	
  	set PREFIX=SIM:SCAN:

: start recorder
  	set COMMAND=%PYTHONPATH%\python.exe %CAPUTRECORDER_PY%
	%COMMAND% %PREFIX% %MACROS_PY%
	rem COMMAND ${PREFIX} yyy: zzz: ${MACROS_PY}

