import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_linuxstats/communication/communicationState.dart';
import 'package:flutter_linuxstats/data/computerData.dart';
import 'package:flutter_linuxstats/utils/helper.dart';
import 'package:web_socket_channel/io.dart';
import 'package:wifi/wifi.dart';
import 'package:ping_discover_network/ping_discover_network.dart';

class WebsocketCommunication {
  static final int port = 9499;
  static CommunicationState communicationState =
      CommunicationState.DISCONNECTED;

  static WebsocketCommunication currentWebsocketCommunication;
  IOWebSocketChannel channel;
  Timer timer;

  WebsocketCommunication() {
    communicationState = CommunicationState.DISCONNECTED;
  }

  void connect() async {
    String ipString = await getIPString(port);
    if (ipString.length == 0) {
      communicationState = CommunicationState.DISCONNECTED;
      ComputerData.setCurrentComputerData(ComputerData.emptyData());
      Helper.currentStatsMainScreen.showConnectionRefusedDialog();
      return;
    }
    String url = "ws://" + ipString + ":" + port.toString();
    debugPrint("Connecting to " + url + "...");
    channel = IOWebSocketChannel.connect(url);
    debugPrint("Connected!");

    communicationState = CommunicationState.CONNECTED;

    Stream stream = channel.stream.asBroadcastStream();
    stream.listen((data) {
      debugPrint('got data: ' + data.toString());
      ComputerData computerData = ComputerData.fromJson(json.decode(data));
      ComputerData.setCurrentComputerData(computerData);
    }, onDone: () {
      communicationState = CommunicationState.DISCONNECTED;
      ComputerData.setCurrentComputerData(ComputerData.emptyData());
      Helper.currentStatsMainScreen.showConnectionRefusedDialog();
    }, onError: (e) {
      communicationState = CommunicationState.DISCONNECTED;
      ComputerData.setCurrentComputerData(ComputerData.emptyData());
      Helper.currentStatsMainScreen.showConnectionRefusedDialog();
    }, cancelOnError: true);

    currentWebsocketCommunication.channel.sink.add("getSystemData()");

    timer =
        Timer.periodic(Duration(seconds: 30), (Timer t) => askForSystemData());
  }

  static void askForSystemData() {
    if (currentWebsocketCommunication == null ||
        currentWebsocketCommunication.channel == null)
      currentWebsocketCommunication = new WebsocketCommunication();
    else if (WebsocketCommunication.communicationState ==
        CommunicationState.DISCONNECTED)
      currentWebsocketCommunication.connect();
    else
      currentWebsocketCommunication.channel.sink.add("getSystemDetailData()");
  }

  static Future<String> getIPString(int port) async {
    if (Platform.isLinux) return "0.0.0.0";

    String ip = await Wifi.ip;
    String subnet = ip.substring(0, ip.lastIndexOf('.'));

    var stream = NetworkAnalyzer.discover2(subnet, port);
    await for (NetworkAddress addr in stream) {
      if (addr.exists) {
        debugPrint('Found device: ${addr.ip}');
        return addr.ip.toString();
      }
    }
    return "";
  }
}
