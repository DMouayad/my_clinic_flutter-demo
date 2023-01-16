import 'dart:async';

import 'package:clinic_v2/app/services/socketio/socketio_provider.dart';
import 'package:clinic_v2/domain/notifications/base/base_notification.dart';
import 'package:clinic_v2/domain/notifications/base/base_notifications_listener.dart';
import 'package:clinic_v2/domain/notifications/data/socket_io/socket_io_auth_notifications_handler.dart';
import 'package:clinic_v2/domain/notifications/data/user/user_was_deleted.dart';
import 'package:clinic_v2/domain/notifications/data/user/user_was_verified_notification.dart';
import 'package:clinic_v2/shared/models/result/result.dart';
import 'package:clinic_v2/utils/constants/notifications_channels.dart';

import '../base/base_auth_repository.dart';
import '../base/base_auth_tokens_service.dart';
import 'my_clinic_api_auth_data_source.dart';
import 'my_clinic_api_user.dart';
import 'package:get_it/get_it.dart';

class MyClinicApiAuthRepository implements BaseAuthRepository<MyClinicApiUser> {
  late final MyClinicApiAuthDataSource _dataSource;

  MyClinicApiUser? _currentUser;

  BaseNotificationsListener get userNotificationsListener => GetIt.I.get();

  @override
  MyClinicApiUser? get currentUser => _currentUser;
  String? _userAuthNotificationChannel;

  MyClinicApiAuthRepository({
    required BaseAuthTokensService authTokensService,
  }) {
    _usersStreamController = StreamController.broadcast();

    _dataSource = MyClinicApiAuthDataSource(authTokensService);

    userNotificationsListener.ensureInitialized();
    userNotificationsListener.notifications.listen(_handleNotifications);

    void onUserStreamData(MyClinicApiUser? user) {
      _currentUser = user;
      if (user != null) {
        _userAuthNotificationChannel =
            NotificationsChannels.usersChannel + user.id.toString();
        print("Connecting to user channel $_userAuthNotificationChannel");
        userNotificationsListener
            .listenOnChannel(_userAuthNotificationChannel!);
        userNotificationsListener.registerHandlers([
          SocketIoAuthNotificationHandler(
            channel: _userAuthNotificationChannel!,
            socket: SocketIoProvider().socket,
          ),
        ]);
      } else {
        // dispose of the socketIO connection
        if (_userAuthNotificationChannel != null) {
          userNotificationsListener.unRegisterHandlers([
            SocketIoAuthNotificationHandler(
              channel: _userAuthNotificationChannel!,
              socket: SocketIoProvider().socket,
            )
          ]);
        }
        _userAuthNotificationChannel = null;
      }
    }

    usersStream.listen(onUserStreamData);
  }

  /// handles coming notifications(events) from server
  void _handleNotifications(BaseNotification notification) {
    if (notification is UserWasVerifiedNotification) {
      if (_currentUser != null && _currentUser?.id == notification.userId) {
        _currentUser =
            _currentUser!.copyWith(emailVerifiedAt: notification.verifiedAt);

        _usersStreamController.add(_currentUser);
      }
    } else if (notification is CurrentUserWasDeletedNotification) {
      _usersStreamController.add(null);
    }
  }

  late final StreamController<MyClinicApiUser?> _usersStreamController;

  @override
  Stream<MyClinicApiUser?> get usersStream => _usersStreamController.stream;

  @override
  Future<Result<VoidValue, BasicError>> login({
    required String email,
    required String password,
  }) async {
    // login user with email and password
    final loginResult = await _dataSource.login(email, password);
    return loginResult.mapSuccessToVoid(
      onSuccess: (user) => _usersStreamController.add(user),
    );
  }

  @override
  Future<Result<VoidValue, BasicError>> register({
    required String name,
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    return (await _dataSource.register(
      username: name,
      email: email,
      password: password,
      phoneNumber: phoneNumber,
    ))
        .mapSuccessToVoid(
            onSuccess: (user) => _usersStreamController.add(user));
  }

  @override
  Future<Result<VoidValue, BasicError>> logout() async {
    return (await _dataSource.logout()).fold(
      ifSuccess: (_) => _usersStreamController.add(null),
    );
  }

  @override
  Future<Result<VoidValue, BasicError>> requestPasswordReset(
      String emailAddress) {
    // TODO: implement requestPasswordReset
    throw UnimplementedError();
  }

  @override
  Future<Result<VoidValue, BasicError>> requestVerificationEmail() async {
    return await _dataSource.sendVerificationEmail();
  }

  @override
  Future<Result<VoidValue, BasicError>> onInit() async {
    return (await _dataSource.loadUser()).mapSuccessToVoid(
      onSuccess: (user) {
        _usersStreamController.add(user);
      },
    );
  }
}
