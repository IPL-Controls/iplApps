#!/usr/bin/env python
"""
Generic multipurpose features common to all python iocs
"""
import epics, time, threading, socket, platform, datetime, psutil, os, sys
from pcaspy import cas
import epics.autosave

AUTOSAVE_SLEEP_TIME = 60

pvdb = {
    ##############################################################
    # values relating to IOC admin/restart
    # these record names are the same as DevIocStats record names
    ##############################################################
    'STARTTOD'              : {'type' : 'string',
                               'value': str(datetime.datetime.now().strftime("%m/%d/%Y %H:%M:%S"))},
    'TOD'                   : {'type': 'string',
                               'scan': 1 },
    'KERNEL_VERS'           : {'type' : 'string',
                               'value': str(platform.system() + " " + platform.release())},
    'HOSTNAME'              : {'type' : 'string',
                               'value': str(socket.gethostname())},
    'RECORD_CNT'            : {'type': 'int'},
    'UPTIME'                : {'type': 'string',
                               'scan': 1 },
    'EPICS_VERS'            : {'type' : 'string',
                               'value': str(cas.EPICS_VERSION_STRING)},
    'APP_DIR1'              : {'type': 'string'},
    'SysReset'              : {'asyn': True},
    'ENGINEER'              : {'type': 'string'},
    'LOCATION'              : {'type': 'string'},
    'PARENT_ID'             : {'type': 'int'},
    'MEM_FREE'              : {'type' : 'float',
                               'value': psutil.virtual_memory()[-1]},
    'MEM_USED'              : {'type' : 'float', 
                               'value': psutil.virtual_memory()[-2]},
    'MEM_MAX'               : {'type' : 'float',
                               'value': psutil.virtual_memory()[0]},
    'HEARTBEAT'             : {'type': 'float',
                               'scan': 1},
}


def buildRequestFiles(p, db, path):
    """
    Auto generates the auto_settings.req file
    p = record prefix
    db = record name w/o prefix
    path = where to save req file
    """
    if p.endswith(':'):
        p = p
    else:
        p = p + ':'
    if os.path.exists(str(path) + os.sep + 'auto_settings.req'):
        return
    else:
        print str(datetime.datetime.now())[:-3], "Creating auto_settings.req file for autosave."
        with open(str(path) + os.sep + 'auto_settings.req', 'w+') as f:
            f.write('# auto_settings.req' + '\n')
            for keys in db:
                # dont save input records.
                if keys.split('_')[-1] != 'RBV':
                    if keys == db[-1]:
                        f.write(str(p) + str(keys))
                    else:
                        f.write(str(p) + str(keys) + '\n')

def makeAutosaveFiles():
    """
    Starts the auto save restore thread
    """
    sid = threading.Thread(target=autoSaveRestore, args=())
    sid.daemon = True
    sid.start()   
    
def autoSaveRestore():
        """
        Parallel thread to generate autosave files periodically and restore
        values on ioc restart/reboot. Functionally it is similar to synApps 
        autosave module.
        """    
        try:
            epics.autosave.restore_pvs("auto_settings.sav")
        except:
            pass
        while True: 
            time.sleep(AUTOSAVE_SLEEP_TIME)
            try:
                epics.autosave.save_pvs("auto_settings.req", "auto_settings.sav")
            except:
                pass

if __name__ == '__main__':
    print "I am main!"