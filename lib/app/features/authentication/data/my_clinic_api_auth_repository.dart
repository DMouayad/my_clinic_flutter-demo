import 'dart:async';
//
import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:clinic_v2/app/features/authentication/domain/base_user_notification.dart';
import 'package:clinic_v2/app/services/auth_tokens/base_auth_tokens_service.dart';
import 'package:clinic_v2/app/services/socket_io_service.dart';
import 'package:clinic_v2/app/features/notifications/data/socket_io_user_notifications_listener.dart';
import '../domain/base_auth_repository.dart';
import 'auth_notifications/user_was_deleted.dart';
import 'auth_notifications/user_was_verified_notification.dart';
import 'my_clinic_api_auth_data_source.dart';
import 'my_clinic_api_user.dart';
import 'package:clinic_v2/app/core/config/socket_io_channels.dart';

class MyClinicApiAuthRepository implements BaseAuthRepository<MyClinicApiUser> {
  late final MyClinicApiAuthDataSource _dataSource;
  late final SocketIoUserNotificationsListener _userNotificationsListener;
  MyClinicApiUser? _currentUser;

  MyClinicApiAuthRepository({
    required BaseAuthTokensService authTokensService,
    required SocketIoService socketIoService,
  }) {
    _usersStreamController = StreamController.broadcast();

    _dataSource = MyClinicApiAuthDataSource(authTokensService);

    _userNotificationsListener =
        SocketIoUserNotificationsListener(socketIoService.socket)..init();

    usersStream.listen((user) {
      _currentUser = user;
      if (user != null) {
        _userNotificationsListener.connectToSocket(
          channel: _getUsersSocketIoChannel(user.id),
        );
      } else {
        _userNotificationsListener.dispose();
      }
    });
    _userNotificationsListener.notifications.listen(_handleNotifications);
  }

  void _handleNotifications(BaseUserNotification notification) {
    if (notification is UserWasVerifiedNotification) {
      if (_currentUser != null && _currentUser?.id == notification.userId) {
        _currentUser =
            _currentUser!.copyWith(emailVerifiedAt: notification.verifiedAt);

        _usersStreamController.add(_currentUser);
      }
    } else if (notification is CurrentUserWasDeleted) {
      _usersStreamController.add(null);
    }
  }

  late final StreamController<MyClinicApiUser?> _usersStreamController;
  @override
  Stream<MyClinicApiUser?> get usersStream => _usersStreamController.stream;

  String _getUsersSocketIoChannel(int userId) {
    return SocketIoChannels.usersChannel + userId.toString();
  }

  @override
  Future<Result<VoidValue, BasicError>> login(
      {required String email, required String password}) async {
    // login user with email and password
    final loginResult = await _dataSource.login(email, password);
    return loginResult.mapSuccessToVoid(
      (user) => _usersStreamController.add(user),
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
        .mapSuccessToVoid((user) {
      _usersStreamController.add(user);
    });
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
    return (await _dataSource.loadUser()).flatMap(
      onSuccess: (user) {
        _usersStreamController.add(user);
        return SuccessResult.voidResult();
      },
      onFailure: (error) {
        _usersStreamController.add(null);
        return FailureResult(error);
      },
    );
  }

  @override
  MyClinicApiUser? get currentUser => _currentUser;
}
