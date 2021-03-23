import 'dart:async';

import 'package:flutter_linuxstats/data/computerData.dart';

mixin ComputerDataManager {
  static StreamController<ComputerData> computerDataController = StreamController<ComputerData>.broadcast();
  static ComputerData computerData = ComputerData.emptyData();

  static void addComputerData(ComputerData computerData){
    ComputerDataManager.computerData = computerData;
    computerDataController.add(computerData);
  }
}
