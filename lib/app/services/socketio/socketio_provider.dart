import 'package:socket_io_client/socket_io_client.dart';

// const uri = 'https://expressjs-postgres-production-0cfd.up.railway.app/';
const uri = 'http://127.0.0.1:3444';

class SocketIoProvider {
  late final Socket _socket;

  Socket get socket => _socket;

  SocketIoProvider() {
    _socket = io(
      uri,
      OptionBuilder().setTransports(['websocket']).disableAutoConnect().build(),
    );
  }
}
