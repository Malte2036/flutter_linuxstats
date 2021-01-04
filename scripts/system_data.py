import platform
import psutil
import cpuinfo
import GPUtil
import os
import time
import json

uname = platform.uname()

username = os.getlogin()
hostname = uname.node
sysname = uname.system
machine = uname.machine
kernel = uname.release
cpu = cpuinfo.get_cpu_info()['brand_raw']

boottime = psutil.boot_time()

cpuCores = psutil.cpu_count()
cpuPhysicalCores = psutil.cpu_count(logical=False)
cpuMinFreq = psutil.cpu_freq().min
cpuMaxFreq = psutil.cpu_freq().max
gpus = GPUtil.getGPUs()
gpu = None
gpuName = ""
if len(gpus) != 0:
    gpu = gpus[0]
    gpuName = gpu.name

virtualMemoryTotal = psutil.virtual_memory().total

swapMemoryTotal = psutil.swap_memory().total

diskUsageTotal = psutil.disk_usage("/").total

temperatureHigh = 0.0
temperatureCritical = 0.0
if hasattr(psutil, 'sensors_temperatures') and psutil.sensors_temperatures().get("acpitz") is not None:
    temperatureHigh = psutil.sensors_temperatures()['acpitz'][0].high
    temperatureCritical = psutil.sensors_temperatures()['acpitz'][0].critical


def getData():
    sensorsBattery = psutil.sensors_battery()
    batteryPercent = 0.0
    batterySecsLeft = 0
    batteryPowerPlugged = True
    if sensorsBattery is not None:
        batteryPercent = sensorsBattery.percent
        batterySecsLeft = sensorsBattery.secsleft
        batteryPowerPlugged = sensorsBattery.power_plugged

    gpuLoad = ""
    gpuTemperature = ""
    gpuMemoryTotal = ""
    gpuMemoryUsed = ""
    gpuMemoryFree = ""
    if gpu is not None:
        gpuLoad = gpu.load
        gpuTemperature = gpu.temperature
        gpuMemoryTotal = int(gpu.memoryTotal) * 1000000
        gpuMemoryUsed = int(gpu.memoryUsed) * 1000000
        gpuMemoryFree = int(gpu.memoryFree) * 1000000

    virtualMemory = psutil.virtual_memory()
    virtualMemoryCached = ""
    if hasattr(virtualMemory, 'cached'):
        virtualMemoryCached = virtualMemory.cached
        
    swapMemory = psutil.swap_memory()
    diskUsage = psutil.disk_usage("/")

    temperatureCurrent = 0.0
    if hasattr(psutil, 'sensors_temperatures') and psutil.sensors_temperatures().get("acpitz") is not None:
        temperatureCurrent = psutil.sensors_temperatures()['acpitz'][0].current

    return json.dumps(
        {
            'username': username,
            'hostname': hostname,
            'sysname': sysname,
            'machine': machine,
            'kernel': kernel,
            'uptime': time.time() - boottime,
            'cpu': cpu,

            'cpuPercent': psutil.cpu_percent(),
            'cpuCores': cpuCores,
            'cpuPhysicalCores': cpuPhysicalCores,
            'cpuCurrentFreq': psutil.cpu_freq().current,
            'cpuMinFreq': cpuMinFreq,
            'cpuMaxFreq': cpuMaxFreq,

            'gpuName': gpuName,
            'gpuLoad': gpuLoad,
            'gpuTemperature': gpuTemperature,
            'gpuMemoryTotal': gpuMemoryTotal,
            'gpuMemoryUsed': gpuMemoryUsed,
            'gpuMemoryFree': gpuMemoryFree,

            'batteryPercent': batteryPercent,
            'batterySecsLeft': batterySecsLeft,
            'batteryPowerPlugged': batteryPowerPlugged,

            'virtualMemoryTotal': virtualMemoryTotal,
            'virtualMemoryUsed': virtualMemory.used,
            'virtualMemoryFree': virtualMemory.free,
            'virtualMemoryCached': virtualMemoryCached,

            'swapMemoryTotal': swapMemoryTotal,
            'swapMemoryUsed': swapMemory.used,
            'swapMemoryFree': swapMemory.free,

            'diskUsageTotal': diskUsageTotal,
            'diskUsageUsed': diskUsage.used,
            'diskUsageFree': diskUsage.free,

            'temperatureCurrent': temperatureCurrent,
            'temperatureHigh': temperatureHigh,
            'temperatureCritical': temperatureCritical
        }
    )


def getDetailData():
    sensorsBattery = psutil.sensors_battery()
    batteryPercent = 0.0
    batterySecsLeft = 0
    batteryPowerPlugged = True
    if sensorsBattery is not None:
        batteryPercent = sensorsBattery.percent
        batterySecsLeft = sensorsBattery.secsleft
        batteryPowerPlugged = sensorsBattery.power_plugged

    gpuLoad = ""
    gpuTemperature = ""
    gpuMemoryUsed = ""
    gpuMemoryFree = ""
    if gpu is not None:
        gpuLoad = gpu.load
        gpuTemperature = gpu.temperature
        gpuMemoryUsed = int(gpu.memoryUsed) * 1000000
        gpuMemoryFree = int(gpu.memoryFree) * 1000000

    virtualMemory = psutil.virtual_memory()
    virtualMemoryCached = ""
    if hasattr(virtualMemory, 'cached'):
        virtualMemoryCached = virtualMemory.cached
    
    swapMemory = psutil.swap_memory()
    diskUsage = psutil.disk_usage("/")

    temperatureCurrent = 0.0
    if hasattr(psutil, 'sensors_temperatures') and psutil.sensors_temperatures().get("acpitz") is not None:
        temperatureCurrent = psutil.sensors_temperatures()['acpitz'][0].current

    return json.dumps(
        {
            'uptime': time.time() - boottime,

            'cpuPercent': psutil.cpu_percent(),
            'cpuCurrentFreq':  psutil.cpu_freq().current,

            'gpuLoad': gpuLoad,
            'gpuTemperature': gpuTemperature,
            'gpuMemoryUsed': gpuMemoryUsed,
            'gpuMemoryFree': gpuMemoryFree,

            'batteryPercent': batteryPercent,
            'batterySecsLeft': batterySecsLeft,
            'batteryPowerPlugged': batteryPowerPlugged,

            'virtualMemoryUsed': virtualMemory.used,
            'virtualMemoryFree': virtualMemory.free,
            'virtualMemoryCached': virtualMemoryCached,

            'swapMemoryUsed': swapMemory.used,
            'swapMemoryFree': swapMemory.free,

            'diskUsageUsed': diskUsage.used,
            'diskUsageFree': diskUsage.free,

            'temperatureCurrent': temperatureCurrent,
        }
    )
