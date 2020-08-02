import 'package:flutter_linuxstats/utils/ownMath.dart';

class ComputerData {
  static ComputerData currentComputerData = ComputerData.exampleData();

  final String hostname;
  final String os;
  final String kernel;
  final String uptime;
  final String cpu;
  final String gpu;

  final double cpuPercent;

  final int virtualMemoryTotal;
  final int virtualMemoryUsed;

  final int diskUsageTotal;
  final int diskUsageUsed;

  ComputerData({
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
      hostname: "ArchLinux",
      os: "Arch Linux x86_64",
      kernel: "5.4.50-1-lts",
      uptime: "5 hours, 1 min",
      cpu: "Intel Pentium N3710 (4) @ 2.560GH",
      gpu: "Intel Atom/Celeron/Pentium Proces",
      cpuPercent: 0.76,
      virtualMemoryTotal: 8186245120,
      virtualMemoryUsed: 3932812319,
      diskUsageTotal: 21378641920,
      diskUsageUsed: 17000000000,
    );
  }

  //CPU
  String getCPUPercentString() {
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
