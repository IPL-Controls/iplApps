#FILENAME:      Makefile
#USAGE:         Top iplApps Makefile
#Modified By:   Author: Alireza Panna
#Last Modified: Date: Fri, 10 April 2015

#NOTES
#     - The user must modify SYN_SUPPORT, IPL_SUPPORT and EPICS_BASE in the
#       <iplApps>/support/configure directory for the local configuration.
#     - Support modules can be shared between configurations only if
#       dependencies are not violated.
#     - To remove modules from the build, delete or comment out the module
#       in the <iplApps>/configure/RELEASE file; not here.


TOP = .

MASTER_FILE = $(TOP)/configure/RELEASE

include $(TOP)/configure/CONFIG

DIRS := $(DIRS) $(filter-out $(DIRS), configure)

DIRS = $(SUPPORT_DIRS)

####################### User Modules #############################
ifdef ADNIKONKS
	# only build this module for windows arch
	ifeq ($(findstring win, $(EPICS_HOST_ARCH)), win)
		DIRS += $(ADNIKONKS)
		RELEASE_FILES += $(ADNIKONKS)/configure/RELEASE
	endif
endif

ifdef ADVARIAN
	# only build this module for windows arch
	ifeq ($(findstring win, $(EPICS_HOST_ARCH)), win)
		DIRS += $(ADVARIAN)
		RELEASE_FILES += $(ADVARIAN)/configure/RELEASE
	endif
endif

ifdef AGILENT_HPE3631A
DIRS += $(AGILENT_HPE3631A)
RELEASE_FILES += $(AGILENT_HPE3631A)/configure/RELEASE
endif

ifdef CPI
DIRS += $(CPI)
RELEASE_FILES += $(CPI)/configure/RELEASE
endif

ifdef GALIL
DIRS += $(GALIL)
RELEASE_FILES += $(GALIL)/configure/RELEASE
endif

ifdef KEITHLEY_K2410
DIRS += $(KEITHLEY_K2410)
RELEASE_FILES += $(KEITHLEY_K2410)/configure/RELEASE
endif 

ifdef OXFORD
DIRS += $(OXFORD)
RELEASE_FILES += $(OXFORD)/configure/RELEASE
endif

ifdef PROCSERVCONTROL
DIRS += $(PROCSERVCONTROL)
RELEASE_FILES += $(PROCSERVCONTROL)/configure/RELEASE
endif

ifdef SCAN_SUPPORT
DIRS += $(SCAN_SUPPORT)
RELEASE_FILES += $(SCAN_SUPPORT)/configure/RELEASE
endif

ifdef RUN_CONTROL
DIRS += $(RUN_CONTROL)
RELEASE_FILES += $(RUN_CONTROL)/configure/RELEASE
endif

ifdef SOURCE_RAY
DIRS += $(SOURCE_RAY)
RELEASE_FILES += $(SOURCE_RAY)/configure/RELEASE
endif

ifdef SRS_DS345
DIRS += $(SRS_DS345)
RELEASE_FILES += $(SRS_DS345)/configure/RELEASE
endif

ifdef THORLABS_APT
	# only build this module for windows arch
	ifeq ($(findstring win, $(EPICS_HOST_ARCH)), win)
		DIRS += $(THORLABS_APT)
		RELEASE_FILES += $(THORLABS_APT)/configure/RELEASE
	endif
endif

ACTIONS += uninstall realuninstall distclean cvsclean

include $(TOP)/configure/RULES_TOP
    
release:
	echo EPICS_HOST_ARCH=$(EPICS_HOST_ARCH)
	echo ' '
	echo SUPPORT=$(SUPPORT)
	echo ' '
	echo IPL_SUPPORT=$(IPL_SUPPORT)
	echo ' '
	echo EPICS_BASE=$(EPICS_BASE)
	echo ' '
	echo MASTER_FILE=$(MASTER_FILE)
	echo ' '
	echo DIRS=$(DIRS)
	echo ' '
	echo RELEASE_FILES=$(RELEASE_FILES)
	echo ' '
	$(PERL) $(TOP)/configure/makeReleaseConsistent.pl $(SUPPORT) $(IPL_SUPPORT) $(EPICS_BASE) $(MASTER_FILE) $(RELEASE_FILES)

