import psutil
import os
import time
import json

uname = os.uname()

username = os.getlogin()
hostname = getattr(uname, 'nodename')
sysname = getattr(uname, 'sysname')
machine = getattr(uname, 'machine')
kernel = getattr(uname, 'release')

boottime = psutil.boot_time()

cpuCores = psutil.cpu_count()
cpuPhysicalCores = psutil.cpu_count(logical=False)
cpuMinFreq = getattr(psutil.cpu_freq(), 'min')
cpuMaxFreq = getattr(psutil.cpu_freq(), 'max')

virtualMemoryTotal = getattr(psutil.virtual_memory(), 'total')

swapMemoryTotal = getattr(psutil.swap_memory(), 'total')

diskUsageTotal = getattr(psutil.disk_usage("/"), 'total')

temperatureHigh = getattr(psutil.sensors_temperatures()['acpitz'][0], 'high')
temperatureCritical = getattr(psutil.sensors_temperatures()['acpitz'][0], 'critical')

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
            'cpuCurrentFreq': getattr(psutil.cpu_freq(), 'current'),
            'cpuMinFreq': cpuMinFreq,
            'cpuMaxFreq': cpuMaxFreq,
            
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
            
            'diskUsageTotal': diskUsageTotal,
            'diskUsageUsed': getattr(psutil.disk_usage("/"), 'used'),
            'diskUsageFree': getattr(psutil.disk_usage("/"), 'free'),

            'temperatureCurrent': getattr(psutil.sensors_temperatures()['acpitz'][0], 'current'),
            'temperatureHigh': temperatureHigh,
            'temperatureCritical': temperatureCritical
        }
    )

def getDetailData():
    return json.dumps(
        {
            'uptime': time.time() - boottime,
            
            'cpuPercent': psutil.cpu_percent(),
            'cpuCurrentFreq':  getattr(psutil.cpu_freq(), 'current'),
            
            'batteryPercent': getattr(psutil.sensors_battery(), 'percent'),
            'batterySecsLeft': getattr(psutil.sensors_battery(), 'secsleft'),
            'batteryPowerPlugged': getattr(psutil.sensors_battery(), 'power_plugged'),
            
            'virtualMemoryUsed': getattr(psutil.virtual_memory(), 'used'),
            'virtualMemoryFree': getattr(psutil.virtual_memory(), 'free'),
            'virtualMemoryCached': getattr(psutil.virtual_memory(), 'cached'),

            'swapMemoryUsed': getattr(psutil.swap_memory(), 'used'),
            'swapMemoryFree': getattr(psutil.swap_memory(), 'free'),
            
            'diskUsageUsed': getattr(psutil.disk_usage("/"), 'used'),
            'diskUsageFree': getattr(psutil.disk_usage("/"), 'free'),

            'temperatureCurrent': getattr(psutil.sensors_temperatures()['acpitz'][0], 'current'),
        }
    )