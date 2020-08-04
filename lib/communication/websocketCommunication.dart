import 'dart:async';
import 'dart:convert';

import 'package:flutter_linuxstats/data/computerData.dart';
import 'package:web_socket_channel/io.dart';

class WebsocketCommunication {
  static final String url = "ws://192.168.178.73:9499";
  static WebsocketCommunication currentWebsocketCommunication;
  IOWebSocketChannel channel;
  Timer timer;

  void connect() async {
    print("Connecting to " + url + "...");
    channel = IOWebSocketChannel.connect(url);
    print("Connected!");

    askForSystemData();

    Stream stream = channel.stream.asBroadcastStream();
    stream.listen(
      (data) {
        print('got data: ' + data.toString());
        ComputerData computerData = ComputerData.fromJson(json.decode(data));
        ComputerData.setCurrentComputerData(computerData);
      },
    );
    timer =
        Timer.periodic(Duration(seconds: 30), (Timer t) => askForSystemData());
  }

  static void askForSystemData() {
    if (currentWebsocketCommunication == null ||
        currentWebsocketCommunication.channel == null)
      currentWebsocketCommunication = new WebsocketCommunication();
    else
      currentWebsocketCommunication.channel.sink.add("getSystemData()");
  }
}
