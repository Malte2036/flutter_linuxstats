import 'package:flutter_linuxstats/utils/helper.dart';
import 'package:flutter_linuxstats/utils/ownMath.dart';

class ComputerData {
  static ComputerData currentComputerData = ComputerData.emptyData();

  final String username;
  final String hostname;
  final String os;
  final String kernel;
  final double uptime;
  final String cpu;
  final String gpu;

  final double cpuPercent;

  final int virtualMemoryTotal;
  final int virtualMemoryUsed;

  final int diskUsageTotal;
  final int diskUsageUsed;

  ComputerData({
    this.username,
    this.hostname,
    this.os,
    this.kernel,
    this.uptime,
    this.cpu,
    this.gpu,
    this.cpuPercent,
    this.virtualMemoryTotal,
    this.virtualMemoryUsed,
    this.diskUsageTotal,
    this.diskUsageUsed,
  });

  factory ComputerData.exampleData() {
    return ComputerData(
      username: "malte",
      hostname: "ArchLinux",
      os: "Arch Linux x86_64",
      kernel: "5.4.50-1-lts",
      uptime: 5000000,
      cpu: "Intel Pentium N3710 (4) @ 2.560GH",
      gpu: "Intel Atom/Celeron/Pentium Proces",
      cpuPercent: 0.76,
      virtualMemoryTotal: 8186245120,
      virtualMemoryUsed: 3932812319,
      diskUsageTotal: 21378641920,
      diskUsageUsed: 17000000000,
    );
  }

  factory ComputerData.emptyData() {
    return ComputerData(
      username: "",
      hostname: "",
      os: "",
      kernel: "",
      uptime: 0,
      cpu: "",
      gpu: "",
      cpuPercent: 0,
      virtualMemoryTotal: 0,
      virtualMemoryUsed: 0,
      diskUsageTotal: 0,
      diskUsageUsed: 0,
    );
  }

  factory ComputerData.fromJson(Map<String, dynamic> json) {
    return ComputerData(
      username: json['username'].toString(),
      hostname: json['hostname'].toString(),
      os: json['os'].toString(),
      kernel: json['kernel'].toString(),
      uptime: json['uptime'],
      cpu: json['cpu'].toString(),
      gpu: json['gpu'].toString(),
      cpuPercent: json['cpuPercent'] / 100.0,
      virtualMemoryTotal: json['virtualMemoryTotal'],
      virtualMemoryUsed: json['virtualMemoryUsed'],
      diskUsageTotal: json['diskUsageTotal'],
      diskUsageUsed: json['diskUsageUsed'],
    );
  }

  static void setCurrentComputerData(ComputerData newComputerData) {
    currentComputerData = newComputerData;
    Helper.currentStatsMainScreen.refresh();
  }

  //Uptime
  String getUptimeString() {
    if (uptime == 0) return "";
    return OwnMath.secondsToHumanString(uptime);
  }

  //CPU
  String getCPUPercentString() {
    if (cpuPercent == 0) return "";
    return OwnMath.round(cpuPercent * 100).toString() + "%";
  }

  //VirtualMemory
  String getVirtualMemoryTotalString() {
    return OwnMath.bytesToHumanString(virtualMemoryTotal);
  }

  String getVirtualMemoryUsedString() {
    return OwnMath.bytesToHumanString(virtualMemoryUsed);
  }

  String getVirtualMemoryCompareString() {
    return OwnMath.bytesToHumanCompareString(
        virtualMemoryUsed, virtualMemoryTotal);
  }

  double getVirtualMemoryPercent() {
    return OwnMath.round(virtualMemoryUsed / virtualMemoryTotal);
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
}
