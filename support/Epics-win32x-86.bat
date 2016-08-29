@ ECHO OFF
rem ##################################################
rem Epics 32.bat                                                                                     
rem This bat file compiles base-3.14.12.4/base-3.15.1 
rem and support drivers for win32-x86 architecture.   
rem ##################################################

cd "C:\Epics\base-3.14.12.4"
rem cd "C:\Epics\base-3.15.1"

rem Set the compiler environment. For win32-x86 use vcvarsall.bat or vcvars32.bat.
call "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat"
rem call "C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\vcvarsall.bat"
rem call "C:\Program Files (x86)\Microsoft Visual Studio 9.0\VC\vcvarsall.bat"

make realclean realuninstall

cd "C:\Epics\support"
make realclean realuninstall

rem Set EPICS host architecture and EPICS base.
set EPICS_HOST_ARCH=win32-x86
setx -m EPICS_HOST_ARCH "win32-x86"

rem Set EPICS time zone to eastern time.
set EPICS_TS_MIN_WEST=300
setx -m EPICS_TS_MIN_WEST "300"

rem Set the size of the largest array that may pass through CA
set EPICS_CA_MAX_ARRAY_BYTES=3000000
setx -m EPICS_CA_MAX_ARRAY_BYTES "3000000"

set EPICS_BASE "C:\Epics\base-3.14.12.4"
rem set EPICS_BASE "C:\Epics\base-3.15.1"

setx -m EPICS_BASE "C:\Epics\base-3.14.12.4"
rem setx -m EPICS_BASE "C:\Epics\base-3.15.1"

rem Set path to EPICS exe files like caget, caput etc.
setx -m EPICS_PATH "C:\Epics\base-3.14.12\bin\win32-x86"
rem setx -m EPICS_PATH "C:\Epics\base-3.15.1\bin\win32-x86"

rem set path for Gnu make and perl for this session.
@if exist "C:\Program Files (x86)\GnuWin32\bin" set PATH=C:\Program Files (x86)\GnuWin32\bin;%PATH%
@if exist "C:\Perl64\bin" set PATH=C:\Perl64\bin;%PATH%
@if exist "C:\strawberry\perl\bin" set PATH=C:\strawberry\perl\bin;%PATH%

cd "C:\Epics\base-3.14.12.4"
rem cd "C:\Epics\base-3.15.1"
make

rem #####################
rem Build support modules                                                                       
rem #####################

rem re2c is required to compile seq-2-1-xx (also edit re2c path in the sequencer config_site file) 
@if exist "C:\re2c" set PATH=C:\re2c;%PATH%

cd "C:\Epics\support\configure"

rem Edit the support release file and comment out the support modules that are not required.
rem Refer to C:\Epics\support\Makefile for module dependencies.
sublime RELEASE
cd..
make release
make
pause