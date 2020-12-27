import 'package:flutter_linuxstats/utils/helper.dart';
import 'package:flutter_linuxstats/utils/ownMath.dart';

class ComputerData {
  ComputerData(
      {this.username,
      this.hostname,
      this.sysname,
      this.machine,
      this.kernel,
      this.uptime,
      this.cpu,
      this.gpu,
      this.cpuPercent,
      this.cpuCores,
      this.cpuPhysicalCores,
      this.cpuCurrentFreq,
      this.cpuMinFreq,
      this.cpuMaxFreq,
      this.batteryPercent,
      this.batterySecsLeft,
      this.batteryPowerPlugged,
      this.virtualMemoryTotal,
      this.virtualMemoryUsed,
      this.virtualMemoryFree,
      this.virtualMemoryCached,
      this.swapMemoryTotal,
      this.swapMemoryUsed,
      this.swapMemoryFree,
      this.diskUsageTotal,
      this.diskUsageUsed,
      this.diskUsageFree,
      this.temperatureCurrent,
      this.temperatureHigh,
      this.temperatureCritical});

  factory ComputerData.emptyData() {
    return ComputerData(
      username: '',
      hostname: '',
      sysname: '',
      machine: '',
      kernel: '',
      uptime: 0,
      cpu: '',
      gpu: '',
      cpuPercent: 0,
      cpuCores: 0,
      cpuPhysicalCores: 0,
      cpuCurrentFreq: 0,
      cpuMinFreq: 0,
      cpuMaxFreq: 0,
      batteryPercent: 0,
      batterySecsLeft: 0,
      batteryPowerPlugged: false,
      virtualMemoryTotal: 0,
      virtualMemoryUsed: 0,
      virtualMemoryFree: 0,
      virtualMemoryCached: 0,
      swapMemoryTotal: 0,
      swapMemoryUsed: 0,
      swapMemoryFree: 0,
      diskUsageTotal: 0,
      diskUsageUsed: 0,
      diskUsageFree: 0,
      temperatureCurrent: 0,
      temperatureHigh: 0,
      temperatureCritical: 0,
    );
  }

  factory ComputerData.fromJson(Map<String, dynamic> json) {
    return ComputerData(
      username: json.containsKey('username')
          ? json['username'].toString()
          : currentComputerData.username,
      hostname: json.containsKey('hostname')
          ? json['hostname'].toString()
          : currentComputerData.hostname,
      sysname: json.containsKey('sysname')
          ? json['sysname'].toString()
          : currentComputerData.sysname,
      machine: json.containsKey('machine')
          ? json['machine'].toString()
          : currentComputerData.machine,
      kernel: json.containsKey('kernel')
          ? json['kernel'].toString()
          : currentComputerData.kernel,
      uptime: json['uptime'],
      cpu: json.containsKey('cpu')
          ? json['cpu'].toString()
          : currentComputerData.cpu,
      gpu: json.containsKey('gpu')
          ? json['gpu'].toString()
          : currentComputerData.gpu,
      cpuPercent:
          json.containsKey('cpuPercent') ? json['cpuPercent'] / 100.0 : 0,
      cpuCores: json.containsKey('cpuCores')
          ? json['cpuCores']
          : currentComputerData.cpuCores,
      cpuPhysicalCores: json.containsKey('cpuPhysicalCores')
          ? json['cpuPhysicalCores']
          : currentComputerData.cpuPhysicalCores,
      cpuCurrentFreq: json['cpuCurrentFreq'],
      cpuMinFreq: json.containsKey('cpuMinFreq')
          ? json['cpuMinFreq']
          : currentComputerData.cpuMinFreq,
      cpuMaxFreq: json.containsKey('cpuMaxFreq')
          ? json['cpuMaxFreq']
          : currentComputerData.cpuMaxFreq,
      batteryPercent: json.containsKey('batteryPercent')
          ? json['batteryPercent'] / 100.0
          : 0,
      batterySecsLeft:
          json.containsKey('batterySecsLeft') ? json['batterySecsLeft'] : 0,
      batteryPowerPlugged: json.containsKey('batteryPowerPlugged')
          ? json['batteryPowerPlugged']
          : true,
      virtualMemoryTotal: json.containsKey('virtualMemoryTotal')
          ? json['virtualMemoryTotal']
          : currentComputerData.virtualMemoryTotal,
      virtualMemoryUsed:
          json.containsKey('virtualMemoryUsed') ? json['virtualMemoryUsed'] : 0,
      virtualMemoryFree:
          json.containsKey('virtualMemoryFree') ? json['virtualMemoryFree'] : 0,
      virtualMemoryCached:
          json.containsKey('swapMemoryTotal') ? json['virtualMemoryCached'] : 0,
      swapMemoryTotal: json.containsKey('swapMemoryTotal')
          ? json['swapMemoryTotal']
          : currentComputerData.swapMemoryTotal,
      swapMemoryUsed:
          json.containsKey('swapMemoryTotal') ? json['swapMemoryUsed'] : 0,
      swapMemoryFree:
          json.containsKey('swapMemoryFree') ? json['swapMemoryFree'] : 0,
      diskUsageTotal: json.containsKey('diskUsageTotal')
          ? json['diskUsageTotal']
          : currentComputerData.diskUsageTotal,
      diskUsageUsed:
          json.containsKey('diskUsageUsed') ? json['diskUsageUsed'] : 0,
      diskUsageFree:
          json.containsKey('diskUsageUsed') ? json['diskUsageFree'] : 0,
      temperatureCurrent: json.containsKey('temperatureCurrent')
          ? json['temperatureCurrent']
          : 0,
      temperatureHigh: json.containsKey('temperatureHigh')
          ? json['temperatureHigh']
          : currentComputerData.temperatureHigh,
      temperatureCritical: json.containsKey('temperatureCritical')
          ? json['temperatureCritical']
          : currentComputerData.temperatureCritical,
    );
  }

  static ComputerData currentComputerData = ComputerData.emptyData();

  final DateTime updated = DateTime.now();

  final String username;
  final String hostname;
  final String sysname;
  final String machine;
  final String kernel;
  final double uptime;
  final String cpu;
  final String gpu;

  final double cpuPercent;
  final int cpuCores;
  final int cpuPhysicalCores;
  final double cpuCurrentFreq;
  final double cpuMinFreq;
  final double cpuMaxFreq;

  final double batteryPercent;
  final int batterySecsLeft;
  final bool batteryPowerPlugged;

  final int virtualMemoryTotal;
  final int virtualMemoryUsed;
  final int virtualMemoryFree;
  final int virtualMemoryCached;

  final int swapMemoryTotal;
  final int swapMemoryUsed;
  final int swapMemoryFree;

  final int diskUsageTotal;
  final int diskUsageUsed;
  final int diskUsageFree;

  final double temperatureCurrent;
  final double temperatureHigh;
  final double temperatureCritical;

  static void setCurrentComputerData(ComputerData newComputerData) {
    currentComputerData = newComputerData;
    Helper.currentStatsMainScreen.refresh();
  }

  List<String> getStatsDetailList(String typeString) {
    switch (typeString.toUpperCase()) {
      case 'CPU':
        return <String>[
          'Cores: ' + getCPUCoresString(),
          'Physical Cores: ' + getCPUPhysicalCoresString(),
          'Current Frequency: ' + getCPUCurrentFrequencyString(),
          'Min Frequency: ' + getCPUMinFrequencyString(),
          'Max Frequency: ' + getCPUMaxFrequencyString(),
          'Percent: ' + getCPUPercentString(),
        ];
      case 'MEMORY':
        return <String>[
          'Total: ' + getVirtualMemoryTotalString(),
          'Used: ' + getVirtualMemoryUsedString(),
          'Free: ' + getVirtualMemoryFreeString(),
          'Cached: ' + getVirtualMemoryCachedString(),
          'Percent: ' + getVirtualMemoryPercentString(),
        ];
      case 'SWAP':
        return <String>[
          'Total: ' + getSwapMemoryTotalString(),
          'Used: ' + getSwapMemoryUsedString(),
          'Free: ' + getSwapMemoryFreeString(),
          'Percent: ' + getSwapMemoryPercentString(),
        ];
      case 'DISK':
        return <String>[
          'Total: ' + getDiskUsageTotalString(),
          'Used: ' + getDiskUsageUsedString(),
          'Free: ' + getDiskUsageFreeString(),
          'Percent: ' + getDiskUsagePercentString(),
        ];
      case 'TEMPERATURE':
        return <String>[
          'Current: ' + getTemperatureCurrentString(),
          'High: ' + getTemperatureHighString(),
          'Critical: ' + getTemperatureCriticalString(),
        ];
      case 'BATTERY':
        return <String>[
          'Percent: ' + getBatteryPercentString(),
          'Time Left: ' + getBatterySecsLeftString(),
          'Power Plugged: ' + getBatteryPowerPluggedString(),
        ];
      case 'SYSTEM':
        return <String>[
          'Hostname: ' + hostname,
          'OS: ' + sysname + ' ' + machine,
          'Kernel: ' + kernel,
          'Uptime: ' + getUptimeString(),
          'CPU: ' + cpu,
          'GPU: ' + gpu,
        ];
    }
    return <String>['ERROR: type ' + typeString + ' not found!'];
  }

  //Uptime
  String getUptimeString() {
    if (uptime == 0) {
      return '';
    }
    return OwnMath.secondsToHumanString(uptime.toInt());
  }

  //CPU
  String getCPUPercentString() {
    if (cpuPercent == 0) {
      return '';
    }
    return OwnMath.round(cpuPercent * 100).toString() + '%';
  }

  String getCPUCoresString() {
    if (cpuCores == 0) {
      return '';
    }
    return cpuCores.toString();
  }

  String getCPUPhysicalCoresString() {
    if (cpuPhysicalCores == 0) {
      return '';
    }
    return cpuPhysicalCores.toString();
  }

  String getCPUCurrentFrequencyString() {
    if (cpuCurrentFreq == 0) {
      return '';
    }
    return OwnMath.round(cpuCurrentFreq).toString() + 'Hz';
  }

  String getCPUMinFrequencyString() {
    if (cpuMinFreq == 0) {
      return '';
    }
    return OwnMath.round(cpuMinFreq).toString() + 'Hz';
  }

  String getCPUMaxFrequencyString() {
    if (cpuMaxFreq == 0) {
      return '';
    }
    return OwnMath.round(cpuMaxFreq).toString() + 'Hz';
  }

  //Battery
  String getBatteryPercentString() {
    if (batteryPercent == 0) {
      return '';
    }
    return OwnMath.round(batteryPercent * 100).toString() + '%';
  }

  String getBatterySecsLeftString() {
    if (batterySecsLeft == 0 && batteryPercent == 0) {
      return '';
    }
    return OwnMath.secondsToHumanString(batterySecsLeft);
  }

  String getBatteryPowerPluggedString() {
    if (batteryPercent == 0) {
      return '';
    }
    return batteryPowerPlugged.toString();
  }

  //VirtualMemory
  String getVirtualMemoryTotalString() {
    return OwnMath.bytesToHumanString(virtualMemoryTotal);
  }

  String getVirtualMemoryUsedString() {
    return OwnMath.bytesToHumanString(virtualMemoryUsed);
  }

  String getVirtualMemoryFreeString() {
    return OwnMath.bytesToHumanString(virtualMemoryFree);
  }

  String getVirtualMemoryCachedString() {
    return OwnMath.bytesToHumanString(virtualMemoryCached);
  }

  String getVirtualMemoryCompareString() {
    return OwnMath.bytesToHumanCompareString(
        virtualMemoryUsed, virtualMemoryTotal);
  }

  double getVirtualMemoryPercent() {
    return OwnMath.round(virtualMemoryUsed / virtualMemoryTotal);
  }

  String getVirtualMemoryPercentString() {
    final double percent = getVirtualMemoryPercent();
    if (percent == 0) {
      return '';
    }
    return OwnMath.round(percent * 100).toString() + '%';
  }

  //SwapMemory
  String getSwapMemoryTotalString() {
    return OwnMath.bytesToHumanString(swapMemoryTotal);
  }

  String getSwapMemoryUsedString() {
    return OwnMath.bytesToHumanString(swapMemoryUsed);
  }

  String getSwapMemoryFreeString() {
    return OwnMath.bytesToHumanString(swapMemoryFree);
  }

  String getSwapMemoryCompareString() {
    return OwnMath.bytesToHumanCompareString(swapMemoryUsed, swapMemoryTotal);
  }

  double getSwapMemoryPercent() {
    return OwnMath.round(swapMemoryUsed / swapMemoryTotal);
  }

  String getSwapMemoryPercentString() {
    final double percent = getSwapMemoryPercent();
    if (percent == 0 && swapMemoryTotal == 0) {
      return '';
    }
    return OwnMath.round(percent * 100).toString() + '%';
  }

  //Disk
  String getDiskUsageTotalString() {
    return OwnMath.bytesToHumanString(diskUsageTotal);
  }

  String getDiskUsageUsedString() {
    return OwnMath.bytesToHumanString(diskUsageUsed);
  }

  String getDiskUsageFreeString() {
    return OwnMath.bytesToHumanString(diskUsageFree);
  }

  String getDiskUsageCompareString() {
    return OwnMath.bytesToHumanCompareString(diskUsageUsed, diskUsageTotal);
  }

  double getDiskUsagePercent() {
    return OwnMath.round(diskUsageUsed / diskUsageTotal);
  }

  String getDiskUsagePercentString() {
    final double percent = getDiskUsagePercent();
    if (percent == 0) {
      return '';
    }
    return OwnMath.round(percent * 100).toString() + '%';
  }

  //Temperature
  String getTemperatureCurrentString() {
    if (temperatureCurrent == 0) {
      return '';
    }
    return temperatureCurrent.toString() + '°';
  }

  String getTemperatureHighString() {
    if (temperatureHigh == 0) {
      return '';
    }
    return temperatureHigh.toString() + '°';
  }

  String getTemperatureCriticalString() {
    if (temperatureCritical == 0) {
      return '';
    }
    return temperatureCritical.toString() + '°';
  }

  String getTemperatureCompareString() {
    if (temperatureCurrent == 0) {
      return '';
    }
    return OwnMath.round(temperatureCurrent).toString() +
        '/' +
        OwnMath.round(temperatureHigh).toString() +
        '°';
  }

  double getTemperaturePercent() {
    return OwnMath.round(temperatureCurrent / temperatureHigh);
  }
}
