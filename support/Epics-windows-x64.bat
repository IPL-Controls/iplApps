::*******************************************************
:: This bat file compiles base-3.14.12.4/5/base-3.15.2
:: and support drivers for windows-x64 architecture
:: under the MS Visual Studios environment.
::
:: Name:            Epics-windows-x64.bat
:: Status:          Stable
:: Date Created:    8/2014
:: Author:          Alireza Panna, IPL/NHLBI/NIH
:: Update log:      (AP)
::*******************************************************

::***********************************
:: 32/64 OS building for 32 => x86
:: 32 OS building for 64 => x86_amd64
:: 64 OS building for 64 => amd64
::***********************************
:: Using MS Visual Studio 10.0/12.0 Ultimate Edition. Set Compiler env to 64 bit
rem call "C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\bin\amd64\vcvars64.bat"
call "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\bin\amd64\vcvars64.bat"

@echo off

:: Set path for Gnu make and perl for this session.
if exist "C:\Program Files (x86)\GnuWin32\bin" set PATH=C:\Program Files (x86)\GnuWin32\bin;%PATH%
if exist "C:\Perl64\bin" set PATH=C:\Perl64\bin;%PATH%
if exist "C:\strawberry\perl\bin" set PATH=C:\strawberry\perl\bin;%PATH%

cd "C:\epics\base-3.14.12.5"
rem cd "C:\epics\base-3.14.12.4"
rem cd "C:\epics\base-3.15.2"
make realclean realuninstall

cd "C:\epics\support"
make realclean realuninstall

:: Set EPICS host architecture and EPICS base.
set EPICS_HOST_ARCH=windows-x64
setx -m EPICS_HOST_ARCH "windows-x64"

:: Set EPICS time zone to eastern time.
set EPICS_TS_MIN_WEST=300
setx -m EPICS_TS_MIN_WEST "300"

:: Set the size of the largest array that may pass through CA
set EPICS_CA_MAX_ARRAY_BYTES=3000000
setx -m EPICS_CA_MAX_ARRAY_BYTES "3000000"

set EPICS_BASE "C:\epics\base-3.14.12.5"
rem set EPICS_BASE "C:\epics\base-3.14.12.4"
rem set EPICS_BASE "C:\epics\base-3.15.2"

setx -m EPICS_BASE "C:\epics\base-3.14.12.5"
rem setx -m EPICS_BASE "C:\epics\base-3.14.12.4"
rem setx -m EPICS_BASE "C:\epics\base-3.15.2"

:: Set path to EPICS exe like caget, caput etc.
setx -m EPICS_PATH "C:\epics\base-3.14.12.5\bin\windows-x64"
rem setx -m EPICS_PATH "C:\epics\base-3.14.12.4\bin\windows-x64"
rem setx -m EPICS_PATH "C:\epics\base-3.15.2\bin\windows-x64"

cd "C:\epics\base-3.14.12.5"
rem cd "C:\epics\base-3.14.12.4"
rem cd "C:\epics\base-3.15.2"
make

:: Build Extensions
cd "C:\epics\extensions"
make

:: Build Support Modules
:: re2c is required to compile seq
if exist "C:\re2c" set PATH=C:\re2c;%PATH%
cd "C:\epics\support\configure"

:: Edit the support release file and comment out the support modules that are not required.
:: Refer to C:\epics\support\Makefile for module dependencies.
sublime RELEASE
cd..
make release
make
pause
