import 'package:flutter_linuxstats/utils/helper.dart';
import 'package:flutter_linuxstats/utils/ownMath.dart';

class ComputerData {
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

  final double temperaturCurrent;
  final double temperaturHigh;
  final double temperaturCritical;

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
      this.temperaturCurrent,
      this.temperaturHigh,
      this.temperaturCritical});

  factory ComputerData.emptyData() {
    return ComputerData(
      username: "",
      hostname: "",
      sysname: "",
      machine: "",
      kernel: "",
      uptime: 0,
      cpu: "",
      gpu: "",
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
      temperaturCurrent: 0,
      temperaturHigh: 0,
      temperaturCritical: 0,
    );
  }

  factory ComputerData.fromJson(Map<String, dynamic> json) {
    return ComputerData(
      username: json['username'].toString(),
      hostname: json['hostname'].toString(),
      sysname: json['sysname'].toString(),
      machine: json['machine'].toString(),
      kernel: json['kernel'].toString(),
      uptime: json['uptime'],
      cpu: json['cpu'].toString(),
      gpu: json['gpu'].toString(),
      cpuPercent: json['cpuPercent'] / 100.0,
      cpuCores: json['cpuCores'],
      cpuPhysicalCores: json['cpuPhysicalCores'],
      cpuCurrentFreq: json['cpuCurrentFreq'],
      cpuMinFreq: json['cpuMinFreq'],
      cpuMaxFreq: json['cpuMaxFreq'],
      batteryPercent: json['batteryPercent'] / 100.0,
      batterySecsLeft: json['batterySecsLeft'],
      batteryPowerPlugged: json['batteryPowerPlugged'],
      virtualMemoryTotal: json['virtualMemoryTotal'],
      virtualMemoryUsed: json['virtualMemoryUsed'],
      virtualMemoryFree: json['virtualMemoryFree'],
      virtualMemoryCached: json['virtualMemoryCached'],
      swapMemoryTotal: json['swapMemoryTotal'],
      swapMemoryUsed: json['swapMemoryUsed'],
      swapMemoryFree: json['swapMemoryFree'],
      diskUsageTotal: json['diskUsageTotal'],
      diskUsageUsed: json['diskUsageUsed'],
      temperaturCurrent: json['temperaturCurrent'],
      temperaturHigh: json['temperaturHigh'],
      temperaturCritical: json['temperaturCritical'],
    );
  }

  static void setCurrentComputerData(ComputerData newComputerData) {
    currentComputerData = newComputerData;
    Helper.currentStatsMainScreen.refresh();
  }

  List<String> getStatsDetailList(String typeString) {
    switch (typeString.toUpperCase()) {
      case "CPU":
        return [
          "Cores: " + getCPUCoresString(),
          "Physical Cores: " + getCPUPhysicalCoresString(),
          "Current Frequency: " + getCPUCurrentFrequencyString(),
          "Min Frequency: " + getCPUMinFrequencyString(),
          "Max Frequency: " + getCPUMaxFrequencyString(),
          "Percent: " + getCPUPercentString(),
        ];
      case "MEMORY":
        return [
          "Total: " + getVirtualMemoryTotalString(),
          "Used: " + getVirtualMemoryUsedString(),
          "Free: " + getVirtualMemoryFreeString(),
          "Cached: " + getVirtualMemoryCachedString(),
          "Percent: " + getVirtualMemoryPercentString(),
        ];
      case "SWAP":
        return [
          "Total: " + getSwapMemoryTotalString(),
          "Used: " + getSwapMemoryUsedString(),
          "Free: " + getSwapMemoryFreeString(),
          "Percent: " + getSwapMemoryPercentString(),
        ];
      case "DISK":
        return [
          "Total: " + getDiskUsageTotalString(),
          "Used: " + getDiskUsageUsedString(),
          "Percent: " + getDiskUsagePercentString(),
        ];
      case "TEMPERATUR":
        return [
          "Current: " + getTemperaturCurrentString(),
          "High: " + getTemperaturHighString(),
          "Critical: " + getTemperaturCriticalString(),
        ];
      case "BATTERY":
        return [
          "Percent: " + getBatteryPercentString(),
          "Time Left: " + getBatterySecsLeftString(),
          "Power Plugged: " + getBatteryPowerPluggedString(),
        ];
      case "SYSTEM":
        return [
          "Hostname: " + hostname,
          "OS: " + sysname + " " + machine,
          "Kernel: " + kernel,
          "Uptime: " + getUptimeString(),
          "CPU: " + cpu,
          "GPU: " + gpu,
        ];
    }
    return ["ERROR: type " + typeString + " not found!"];
  }

  //Uptime
  String getUptimeString() {
    if (uptime == 0) return "";
    return OwnMath.secondsToHumanString(uptime.toInt());
  }

  //CPU
  String getCPUPercentString() {
    if (cpuPercent == 0) return "";
    return OwnMath.round(cpuPercent * 100).toString() + "%";
  }

  String getCPUCoresString() {
    if (cpuCores == 0) return "";
    return cpuCores.toString();
  }

  String getCPUPhysicalCoresString() {
    if (cpuPhysicalCores == 0) return "";
    return cpuPhysicalCores.toString();
  }

  String getCPUCurrentFrequencyString() {
    if (cpuCurrentFreq == 0) return "";
    return OwnMath.round(cpuCurrentFreq).toString() + "Hz";
  }

  String getCPUMinFrequencyString() {
    if (cpuMinFreq == 0) return "";
    return OwnMath.round(cpuMinFreq).toString() + "Hz";
  }

  String getCPUMaxFrequencyString() {
    if (cpuMaxFreq == 0) return "";
    return OwnMath.round(cpuMaxFreq).toString() + "Hz";
  }

  //Battery
  String getBatteryPercentString() {
    if (batteryPercent == 0) return "";
    return OwnMath.round(batteryPercent * 100).toString() + "%";
  }

  String getBatterySecsLeftString() {
    if (batterySecsLeft == 0 && batteryPercent == 0) return "";
    return OwnMath.secondsToHumanString(batterySecsLeft);
  }

  String getBatteryPowerPluggedString() {
    if (batteryPercent == 0) return "";
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
    double percent = getVirtualMemoryPercent();
    if (percent == 0) return "";
    return OwnMath.round(percent * 100).toString() + "%";
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
    double percent = getSwapMemoryPercent();
    if (percent == 0 && swapMemoryUsed == 0) return "";
    return OwnMath.round(percent * 100).toString() + "%";
  }

  //Disk
  String getDiskUsageTotalString() {
    return OwnMath.bytesToHumanString(diskUsageTotal);
  }

  String getDiskUsageUsedString() {
    return OwnMath.bytesToHumanString(diskUsageUsed);
  }

  String getDiskUsageCompareString() {
    return OwnMath.bytesToHumanCompareString(diskUsageUsed, diskUsageTotal);
  }

  double getDiskUsagePercent() {
    return OwnMath.round(diskUsageUsed / diskUsageTotal);
  }

  String getDiskUsagePercentString() {
    double percent = getDiskUsagePercent();
    if (percent == 0) return "";
    return OwnMath.round(percent * 100).toString() + "%";
  }

  //Temperatur
  String getTemperaturCurrentString() {
    if (temperaturCurrent == 0) return "";
    return temperaturCurrent.toString() + "°";
  }

  String getTemperaturHighString() {
    if (temperaturHigh == 0) return "";
    return temperaturHigh.toString() + "°";
  }

  String getTemperaturCriticalString() {
    if (temperaturCritical == 0) return "";
    return temperaturCritical.toString() + "°";
  }

  String getTemperaturCompareString() {
    if (temperaturCurrent == 0) return "";
    return OwnMath.round(temperaturCurrent).toString() +
        "/" +
        OwnMath.round(temperaturHigh).toString() +
        "°";
  }

  double getTemperaturPercent() {
    return OwnMath.round(temperaturCurrent / temperaturHigh);
  }
}
