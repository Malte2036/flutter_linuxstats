import psutil
import os
import time
import json

username = os.getlogin()
hostname = getattr(os.uname(), 'nodename')
sysname = getattr(os.uname(), 'sysname')
machine = getattr(os.uname(), 'machine')
kernel = getattr(os.uname(), 'release')

boottime = psutil.boot_time()

cpuCores = psutil.cpu_count()
cpuPhysicalCores = psutil.cpu_count(logical=False)

virtualMemoryTotal = getattr(psutil.virtual_memory(), 'total')

swapMemoryTotal = getattr(psutil.swap_memory(), 'total')

temperaturHigh = getattr(psutil.sensors_temperatures()['acpitz'][0], 'high')
temperaturCritical = getattr(psutil.sensors_temperatures()['acpitz'][0], 'critical')

def getData():
    return json.dumps(
        {
            'username': username,
            'hostname': hostname,
            'sysname': sysname,
            'machine': machine,
            'kernel': kernel,
            'uptime': time.time() - boottime,
            
            'cpuPercent': psutil.cpu_percent(),
            'cpuCores': cpuCores,
            'cpuPhysicalCores': cpuPhysicalCores,
            'cpuCurrentFreq':  getattr(psutil.cpu_freq(), 'current'),
            'cpuMinFreq':  getattr(psutil.cpu_freq(), 'min'),
            'cpuMaxFreq':  getattr(psutil.cpu_freq(), 'max'),
            
            'batteryPercent': getattr(psutil.sensors_battery(), 'percent'),
            'batterySecsLeft': getattr(psutil.sensors_battery(), 'secsleft'),
            'batteryPowerPlugged': getattr(psutil.sensors_battery(), 'power_plugged'),
            
            'virtualMemoryTotal': virtualMemoryTotal,
            'virtualMemoryUsed': getattr(psutil.virtual_memory(), 'used'),
            'virtualMemoryFree': getattr(psutil.virtual_memory(), 'free'),
            'virtualMemoryCached': getattr(psutil.virtual_memory(), 'cached'),
            
            'swapMemoryTotal': swapMemoryTotal,
            'swapMemoryUsed': getattr(psutil.swap_memory(), 'used'),
            'swapMemoryFree': getattr(psutil.swap_memory(), 'free'),
            
            'diskUsageTotal': getattr(psutil.disk_usage("/"), 'total'),
            'diskUsageUsed': getattr(psutil.disk_usage("/"), 'used'),

            'temperaturCurrent': getattr(psutil.sensors_temperatures()['acpitz'][0], 'current'),
            'temperaturHigh': temperaturHigh,
            'temperaturCritical': temperaturCritical
        }
    )