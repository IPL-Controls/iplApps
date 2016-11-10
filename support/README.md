iplApps
=======


REQUISITES
==========
* EPICS base must be compiled. All the apps provided in iplApps have been tested and are compatible with base >= 3.14
* The following synApps support modules are also required: areaDetector, asyn, autosave, busy, devIocStats, calc, caPutLog, caputRecorder, motor, seq, sscan, stream.

SITE CONFIGURATION
==================
Edit the following for your site:

configure/CONFIG_SITE
---------------------
Set the values of variables to indicate what resources your system has.
        
configure/RELEASE
-----------------
Specify paths to EPICS base, synApps support modules, and to iplApps support modules. After modifying this file, run "make release" in support to propagate changes to all module RELEASE files.

Makefile
--------
Select modules to build. Add IPL support modules as follows
```make
ifdef MODULE
	DIRS += $(MODULE)
	RELEASE_FILES += $(MODULE)/configure/RELEASE
endif
```

To build iplApps:
-----------------
Make sure that EPICS_HOST_ARCH appropriately
```make
make release
make
```

To rebuild iplApps:
-------------------
```make
make release
make clean uninstall
make
```
"make release" ensures that all the modules have consistent paths in
their RELEASE files.

After adding a module
---------------------
* edit support/configure/RELEASE
* edit support/Makefile
* run "make release" in support
* run "make rebuild" in any module that uses the new module

Optionally on linux OS you might have to change permissions
`sudo chmod -R 777 support`

To get a clone of the full iplApps support distribution perform a recursive clone of this repository:
`git clone --recursive https://github.com/IPL-Controls/iplApps.git`

* [Release notes](RELEASE.md)
* [Report an issue with iplApps](https://github.com/IPL-Controls/iplApps/issues)  
* [documentation](https://github.com/IPL-Controls/iplApps/tree/master/support/documentation/README.1st)