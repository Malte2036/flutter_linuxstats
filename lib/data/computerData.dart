import 'package:flutter_linuxstats/utils/ownMath.dart';

class ComputerData {
  static ComputerData currentComputerData = ComputerData.exampleData();

  final String hostname;
  final String os;
  final String kernel;
  final String uptime;
  final String cpu;
  final String gpu;

  final double cpu_percent;

  final int virtual_memory_total;
  final int virtual_memory_used;

  final int disk_usage_total;
  final int disk_usage_used;

  ComputerData({
    this.hostname,
    this.os,
    this.kernel,
    this.uptime,
    this.cpu,
    this.gpu,
    this.cpu_percent,
    this.virtual_memory_total,
    this.virtual_memory_used,
    this.disk_usage_total,
    this.disk_usage_used,
  });

  factory ComputerData.exampleData() {
    return ComputerData(
      hostname: "ArchLinux",
      os: "Arch Linux x86_64",
      kernel: "5.4.50-1-lts",
      uptime: "5 hours, 1 min",
      cpu: "Intel Pentium N3710 (4) @ 2.560GH",
      gpu: "Intel Atom/Celeron/Pentium Proces",
      cpu_percent: 0.76,
      virtual_memory_total: 10367352832,
      virtual_memory_used: 8186245120,
      disk_usage_total: 21378641920,
      disk_usage_used: 17000000000,
    );
  }

  //CPU
  String getCPUPercentString() {
    return OwnMath.round(cpu_percent * 100).toString() + "%";
  }

  //VirtualMemory
  String getVirtualMemoryTotalString() {
    return OwnMath.bytesToHumanString(virtual_memory_total);
  }

  String getVirtualMemoryUsedString() {
    return OwnMath.bytesToHumanString(virtual_memory_used);
  }

  String getVirtualMemoryCompareString() {
    return OwnMath.bytesToHumanCompareString(
        virtual_memory_used, virtual_memory_total);
  }

  double getVirtualMemoryPercent() {
    return OwnMath.round(virtual_memory_used / virtual_memory_total);
  }

  //Disk
  String getDiskUsageTotalString() {
    return OwnMath.bytesToHumanString(disk_usage_total);
  }

  String getDiskUsageUsedString() {
    return OwnMath.bytesToHumanString(disk_usage_used);
  }

  String getDiskUsageCompareString() {
    return OwnMath.bytesToHumanCompareString(disk_usage_used, disk_usage_total);
  }

  double getDiskUsagePercent() {
    return OwnMath.round(disk_usage_used / disk_usage_total);
  }
}
