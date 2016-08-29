iplApps Releases
================

The latest untagged master branch can be obtained at
<https://bitbucket.org/iplshare/iplapps>


Release Notes
=============
The release notes below provide a short summary of the most significant items from the submodules.

v4.0 (December XXX 2016)
----

v3-0 (June 10, 2016)
----
* procServControl snl code modified so that it doesn't use 100% cpu when we try to connect to invalid portname.
  Updated to v1-4.
* Removed unfinished pycode from utils
* updated ui for sb-80-1k
* Re worked seqRad.st to only depend on camera ioc, removed single shot functionality and renamed as makeDark.st.
  Added makeDark.st to ADNikonKs. Corresponding makeDark.db file also added to ADNikonKs. seqRad.st is deprecated.
  Currently this code is Qi2 specific i.e. it makes master dark field and enables background corrections for Qi2 only.
  I am not sure that it will work on generic Area detectors, this will need testing.
* Added verifySettings.st to seqControl App which is intended to verify pfi settings before a scan to make sure scans 
  run smoothly. This code is pfi specific and requires all pfi iocs to be online.  
* Added makeFlat.st and makeFlat.db to ADNikonKs to automate master flat field acquisition and correction. Requires 
  Oxford x-ray ioc to be online.
* Added snl client for auto shut off watchdog timer, mAs readback, and exposure time readback to oxford and sri x-rays. 
* Added $(P):FIRING_RBV record to devoxford.db to notify when the x-ray has reached its set point kvp and W. Updated ui 
  and version to 1-2
* Added VPFIAttributes.xml file for tiff meta data.
* Added caputRecorder support to all scan ioc.
* Device support upgraded to use asyn-4-29 and areaDetector-2-5.
* Added nikonKsSync which performs hardware synchronization of x-ray and camera trigger for ADNikonKS. Currently only oxford and sri x-rays are supported by this driver. 

v2-0 (December 3, 2015)
----
* Device support for CPI X-ray Generator. This is from Andrew Gomella
* DevIocStat support added for all modules
* Caputlog Support added for all modules
* AutoSave Support added for all modules
* iocs can now run daemon using procServ through batch/shell scripts located in ioc dir
* added support for cmd commands to be run in iocs using the system command
* Completely re-worked ADVarian src. Updated to v1-1
* Added Ri2 template file to ADNikonKs. Updated to v1-1
* Added PFI attributes file
* New soft support app seqControl for PFI related sequences. Currently only offset mode and single shot mode supported. 
* Fixed dll install in ADNikonKs and make AD module builds independent of release versions.
* Start-up files of all modules load devIocStats and Autosave records by default.


v1-0 (August 1, 2015)
----
* Device support for Agilent HPE3631A Power supply. This is from Andrew Gomella
* Device support for Keithley K2410 source meter. This is from Alireza Panna
* Device support for Oxford 96000 series micro-focus x-ray sources. This is from Alireza Panna
* Device support for Source ray sb-80-1k and sb-80-500 x-ray sources. This is from Andrew Gomella
* Device support for Stanford Research Systems DS345 Arbitrary waveform generator. This is from Alireza Panna
* Process server snl app. This is originally from DLS and modified by Alireza Panna
* Generic Scan app. This is from ANL
* Area detector modules for Varian PaxScan 3024M and Nikon KsCam detectors. These are from Andrew Gomella

