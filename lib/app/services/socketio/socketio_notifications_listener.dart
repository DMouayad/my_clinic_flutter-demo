import 'package:clinic_v2/app/services/socketio/socketio_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

//
import 'package:clinic_v2/domain/notifications/data/socket_io/socket_io_notification_handler.dart';
import '../../../domain/notifications/base/base_notification.dart';
import '../../../domain/notifications/base/base_notifications_listener.dart';

class SocketIoNotificationsListener<T extends BaseSocketIoNotificationHandler>
    extends BaseNotificationsListener<BaseNotification, T> {
  io.Socket get _socket => GetIt.I.get<SocketIoProvider>().socket;

  @override
  Future<void> listenOnChannel(String channel) async {
    _socket.connect();

    // emit an event to the socket io server to listen on the specified channel
    // so it can redirect the messages to us
    _emitEvent(
      event: "start-listening",
      data: {'channel': channel},
    );
  }

  void _emitEvent({required String event, required Map<String, dynamic> data}) {
    if (_socket.disconnected) {
      _socket.connect();
    }
    _socket.emit(event, data);
  }

  @override
  bool get isListening => !_socket.disconnected;

  @override
  Future<void> dispose() async {
    _socket.emit('disconnect');
    _socket.dispose();
  }

  @override
  Future<void> registerHandlers(List<T> handlers) async {
    for (var handler in handlers) {
      handler.call(notificationsController);
    }
  }

  @override
  Future<void> unRegisterHandlers(List<T> handlers) async {
    for (var handler in handlers) {
      handler.dispose();
    }
  }
}
