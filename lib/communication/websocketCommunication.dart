import 'dart:async';
import 'dart:convert';

import 'package:flutter_linuxstats/data/computerData.dart';
import 'package:web_socket_channel/io.dart';
import 'package:wifi/wifi.dart';
import 'package:ping_discover_network/ping_discover_network.dart';

class WebsocketCommunication {
  static final int port = 9499;
  static WebsocketCommunication currentWebsocketCommunication;
  IOWebSocketChannel channel;
  Timer timer;

  void connect() async {
    String url = "ws://" + (await getIPString(port)) + ":" + port.toString();
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

  static Future<String> getIPString(int port) async {
    String ip = await Wifi.ip;
    String subnet = ip.substring(0, ip.lastIndexOf('.'));

    var stream = NetworkAnalyzer.discover2(subnet, port);
    await for (NetworkAddress addr in stream) {
      if (addr.exists) {
        print('Found device: ${addr.ip}');
        return addr.ip.toString();
      }
    }
    return getIPString(port);
  }
}
