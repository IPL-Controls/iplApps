Run make in support, and it references configure/RELEASE.

REQUISITES
==========
* EPICS base must be compiled.
* The following synApps support modules are also required: areaDetector, devIocStats, caPutLog, motor, sscan, asyn, calc, busy, seq, stream, autosave.

SITE CONFIGURATION
==================
Edit the following for your site:

configure/CONFIG_SITE
---------------------
Set the values of variables to indicate what resources your system has.
        
configure/RELEASE
-----------------
Specify paths to EPICS base, synapps support modules, and to IPL modules. After modifying this file, run "make release" in support to propagate changes to all module RELEASE files.

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
``        
sudo chmod -R 777 support
``