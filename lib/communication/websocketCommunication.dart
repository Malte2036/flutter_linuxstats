import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_linuxstats/communication/communicationState.dart';
import 'package:flutter_linuxstats/data/computerData.dart';
import 'package:flutter_linuxstats/data/computerDataManager.dart';
import 'package:web_socket_channel/io.dart';
import 'package:wifi/wifi.dart';
import 'package:ping_discover_network/ping_discover_network.dart';

class WebsocketCommunication {
  WebsocketCommunication() {
    communicationState = CommunicationState.DISCONNECTED;
  }

  static const int port = 9499;
  static CommunicationState communicationState =
      CommunicationState.DISCONNECTED;

  static WebsocketCommunication currentWebsocketCommunication;
  IOWebSocketChannel channel;
  Timer timer;

  Future<void> connect() async {
    final String ipString = await getIPString(port);
    if (ipString.isEmpty) {
      communicationState = CommunicationState.DISCONNECTED;
      ComputerDataManager.addComputerData(null);
      return;
    }
    final String url = 'ws://' + ipString + ':' + port.toString();
    debugPrint('Connecting to ' + url + '...');
    channel = IOWebSocketChannel.connect(url);
    debugPrint('Connected!');

    communicationState = CommunicationState.CONNECTED;

    // ignore: always_specify_types
    final Stream stream = channel.stream.asBroadcastStream();
    stream.listen((dynamic data) {
      debugPrint('got data: ' + data.toString());
      final ComputerData computerData =
          ComputerData.fromJson(json.decode(data));
      ComputerDataManager.addComputerData(computerData);
    }, onDone: () {
      communicationState = CommunicationState.DISCONNECTED;
      ComputerDataManager.addComputerData(null);
    }, onError: (dynamic e) {
      communicationState = CommunicationState.DISCONNECTED;
      ComputerDataManager.addComputerData(null);
    }, cancelOnError: true);

    currentWebsocketCommunication.channel.sink.add('getSystemData()');

    timer = Timer.periodic(
        const Duration(seconds: 30), (Timer t) => askForSystemData());
  }

  static void askForSystemData() {
    if (currentWebsocketCommunication == null ||
        currentWebsocketCommunication.channel == null)
      currentWebsocketCommunication = WebsocketCommunication();
    else if (WebsocketCommunication.communicationState ==
        CommunicationState.DISCONNECTED)
      currentWebsocketCommunication.connect();
    else
      currentWebsocketCommunication.channel.sink.add('getSystemDetailData()');
  }

  static Future<String> getIPString(int port) async {
    if (Platform.isLinux) {
      return '0.0.0.0';
    }

    final String ip = await Wifi.ip;
    final String subnet = ip.substring(0, ip.lastIndexOf('.'));

    final Stream<NetworkAddress> stream =
        NetworkAnalyzer.discover2(subnet, port);
    await for (NetworkAddress addr in stream) {
      if (addr.exists) {
        debugPrint('Found device: ${addr.ip}');
        return addr.ip.toString();
      }
    }
    return '';
  }
}
