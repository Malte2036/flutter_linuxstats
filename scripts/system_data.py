import psutil
import os
import time
import json

username = os.getlogin()
hostname = getattr(os.uname(), 'nodename')
machine = getattr(os.uname(), 'machine')
kernel = getattr(os.uname(), 'release')
boottime = psutil.boot_time()

def getData():
    return json.dumps(
        {
            'username': username,
            'hostname': hostname,
            'kernel': kernel,
            'uptime': time.time() - boottime,
            
            'cpuPercent': psutil.cpu_percent(),
            
            'virtualMemoryTotal': getattr(psutil.virtual_memory(), 'total'),
            'virtualMemoryUsed': getattr(psutil.virtual_memory(), 'used'),
            
            'diskUsageTotal': getattr(psutil.disk_usage("/"), 'total'),
            'diskUsageUsed': getattr(psutil.disk_usage("/"), 'used'),

            'temperaturCurrent': getattr(psutil.sensors_temperatures()['acpitz'][0], 'current'),
            'temperaturHigh': getattr(psutil.sensors_temperatures()['acpitz'][0], 'high')
        }
    )