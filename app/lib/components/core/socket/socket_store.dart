import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:send_zap/components/core/dio/enviroments.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketStore {
  final _socketResponse = StreamController<String>();

  late io.Socket socket;

  Stream<String> get getQrCode => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
  }

  void connectAndListen() {
    try {
      // ignore: avoid_debugPrint
      debugPrint('**** INIT SOCKET ****');
      socket = io.io(Enviroments.param('base_url'),
          io.OptionBuilder().setTransports(['websocket']).build());
    } catch (e) {
      connectAndListen();
    }

    socket.onConnect((_) {
      debugPrint('**** CONNECTED ****');
    });

    socket.on("qrCode", (data) {
      _socketResponse.add(data['data']);
      debugPrint(data.toString());
    });

    socket.on("whatsapp-status", (data) {
      if (data) {
        debugPrint("status true");
        Modular.to.pushReplacementNamed('/home');
      } else {
        debugPrint("status false");
      }
    });

    socket.on('event', (data) => debugPrint(data.toString()));

    socket.onDisconnect((_) {
      debugPrint('disconnect');
    });
    socket.onError((data) {
      debugPrint("ERROR SOCKET " + data.toString());
    });

    socket.onConnectError((data) {
      debugPrint('ON CONNECT ERROR');
      debugPrint(data.toString());
    });
  }

  Future<void> logout() async {
    final storage = FlutterSecureStorage();
    await storage.deleteAll();
  }
}
