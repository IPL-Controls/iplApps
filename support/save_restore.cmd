############################################################################
# Begin save_restore.cmd

# Debug-output level
save_restoreSet_Debug(0)

# status PV-Prefix for save restore
save_restoreSet_status_prefix("P=$(P):")
dbLoadRecords("$(AUTOSAVE)/asApp/Db/save_restoreStatus.db","P=$(P):")
# BUSY support is required to load this record
dbLoadRecords("$(AUTOSAVE)/asApp/Db/configMenu.db","P=$(P):,CONFIG=$(CONFIG)")

# Ok to save/restore save sets with missing values (no CA connection to PV)?
save_restoreSet_IncompleteSetsOk(1)

# Save dated backup files. Boot backup file is written 
# during pass 0. At boot time the restore software will 
# write a dated back up copy from which it restored the PVs
save_restoreSet_DatedBackupFiles(1)

# Number of sequenced backup files to write
# Create a single back-up of .sav file (.sav0)
save_restoreSet_NumSeqFiles(1)

# Time interval between sequenced backups
# Writes .sav0 files every 10 mins
save_restoreSet_SeqPeriodInSeconds(600)

# Ok to retry connecting to PVs whose initial connection attempt failed?
save_restoreSet_CAReconnect(1)

# Time interval in seconds between forced save-file writes (-1 means forever).
save_restoreSet_CallbackTimeout(-1)

# Specify the directory in which you want .sav files to be written
# This path is prepended to the .sav file when set_passX_restoreFile("xxx.sav")
# command is invoked. 
set_savefile_path("$(TOP)/iocBoot/$(IOC)", "autosave")

# specify what save files should be restored.  Note these files must be
# in the directory specified in set_savefile_path(), BOOT TIME RESTORE: 
# pass_0 => before record initialization, pass_1 => after record initialization
set_pass0_restoreFile("auto_positions.sav")
set_pass1_restoreFile("auto_settings.sav")

# Save files associated with the request files 'info_positions.req' and
# 'info_settings.req'.  These .req files are written by the autosave function
# makeAutosaveFiles().
set_pass0_restoreFile("info_positions.sav")
set_pass1_restoreFile("info_settings.sav")

# specify directories in which to to search for included request files
set_requestfile_path("$(TOP)/iocBoot/$(IOC)", "")
set_requestfile_path("$(TOP)/iocBoot/$(IOC)", "autosave")
set_requestfile_path("$(ADCORE)", "ADApp/Db")
set_requestfile_path("$(AUTOSAVE)", "asApp/Db")
set_requestfile_path("$(CALC)", "calcApp/Db")
set_requestfile_path("$(SSCAN)", "sscanApp/Db")

# End save_restore.cmd
############################################################################
