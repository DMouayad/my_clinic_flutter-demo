import 'package:socket_io_client/socket_io_client.dart';

const uri = 'http://127.0.0.1:3444';

class SocketIoService {
  late final Socket _socket;

  Socket get socket => _socket;

  SocketIoService._internal() {
    _socket = io(
      uri,
      OptionBuilder().setTransports(['websocket']).disableAutoConnect().build(),
    );
  }

  factory SocketIoService() => _instance;

  static final SocketIoService _instance = SocketIoService._internal();
}
