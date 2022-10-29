import 'package:clinic_v2/app/core/entities/base_notification.dart';

import 'base_notification_listener.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

abstract class SocketIoListener<T extends BaseNotification>
    extends BaseNotificationListener<T> {
  final io.Socket _socket;

  SocketIoListener(this._socket);

  void connectToSocket({
    required String channel,
    dynamic Function(dynamic)? onConnect,
    dynamic Function(dynamic)? onConnectError,
  }) {
    _socket.connect();
    if (onConnect != null) {
      _socket.onConnect(onConnect);
    }
    if (onConnectError != null) {
      _socket.onConnectError(onConnectError);
    }

    registerEventsHandlers(_socket, channel);
  }

  void emitEvent({required String event, required Map<String, dynamic> data}) {
    if (_socket.disconnected) {
      _socket.connect();
    }
    _socket.emit(event, data);
  }

  void registerEventsHandlers(io.Socket socket, String channel);

  @override
  bool get isListening => !_socket.disconnected;

  @override
  Future<void> startListening() async {
    _socket.connect();
  }

  @override
  Future<void> stopListening() async {
    _socket.disconnect();
  }

  @override
  Future<void> dispose() async {
    _socket.dispose();
  }
}
