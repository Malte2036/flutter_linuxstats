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
    sensorsBattery = psutil.sensors_battery()
    virtualMemory = psutil.virtual_memory()
    swapMemory = psutil.swap_memory()
    diskUsage = psutil.disk_usage("/")

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
            
            'batteryPercent': getattr(sensorsBattery, 'percent'),
            'batterySecsLeft': getattr(sensorsBattery, 'secsleft'),
            'batteryPowerPlugged': getattr(sensorsBattery, 'power_plugged'),
            
            'virtualMemoryTotal': virtualMemoryTotal,
            'virtualMemoryUsed': getattr(virtualMemory, 'used'),
            'virtualMemoryFree': getattr(virtualMemory, 'free'),
            'virtualMemoryCached': getattr(virtualMemory, 'cached'),
            
            'swapMemoryTotal': swapMemoryTotal,
            'swapMemoryUsed': getattr(swapMemory, 'used'),
            'swapMemoryFree': getattr(swapMemory, 'free'),
            
            'diskUsageTotal': diskUsageTotal,
            'diskUsageUsed': getattr(diskUsage, 'used'),
            'diskUsageFree': getattr(diskUsage, 'free'),

            'temperatureCurrent': getattr(psutil.sensors_temperatures()['acpitz'][0], 'current'),
            'temperatureHigh': temperatureHigh,
            'temperatureCritical': temperatureCritical
        }
    )

def getDetailData():
    sensorsBattery = psutil.sensors_battery()
    virtualMemory = psutil.virtual_memory()
    swapMemory = psutil.swap_memory()
    diskUsage = psutil.disk_usage("/")

    return json.dumps(
        {
            'uptime': time.time() - boottime,
            
            'cpuPercent': psutil.cpu_percent(),
            'cpuCurrentFreq':  getattr(psutil.cpu_freq(), 'current'),
            
            'batteryPercent': getattr(sensorsBattery, 'percent'),
            'batterySecsLeft': getattr(sensorsBattery, 'secsleft'),
            'batteryPowerPlugged': getattr(sensorsBattery, 'power_plugged'),
            
            'virtualMemoryUsed': getattr(virtualMemory, 'used'),
            'virtualMemoryFree': getattr(virtualMemory, 'free'),
            'virtualMemoryCached': getattr(virtualMemory, 'cached'),

            'swapMemoryUsed': getattr(swapMemory, 'used'),
            'swapMemoryFree': getattr(swapMemory, 'free'),
            
            'diskUsageUsed': getattr(diskUsage, 'used'),
            'diskUsageFree': getattr(diskUsage, 'free'),

            'temperatureCurrent': getattr(psutil.sensors_temperatures()['acpitz'][0], 'current'),
        }
    )