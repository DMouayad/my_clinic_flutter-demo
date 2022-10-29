import 'dart:async';
//
import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:clinic_v2/app/features/authentication/data/my_clinic_user_notifications_listener.dart';
import 'package:clinic_v2/app/features/authentication/data/notifications/user_was_verified_notification.dart';
import 'package:clinic_v2/app/services/auth_tokens/base_auth_tokens_service.dart';
import 'package:clinic_v2/app/services/socket_io_service.dart';

import '../domain/base_auth_repository.dart';
import 'my_clinic_api_auth_data_source.dart';
import 'my_clinic_api_user.dart';

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
      if (user != null) {
        _userNotificationsListener.connectToSocket(
          channel: _getUsersSocketIoChannel(user.id),
        );
      } else {
        _userNotificationsListener.dispose();
      }
    });
    _userNotificationsListener.notifications.listen((event) {
      if (event is UserWasVerifiedNotification) {
        if (_currentUser != null && _currentUser?.id == event.userId) {
          _currentUser =
              _currentUser!.copyWith(emailVerifiedAt: event.verifiedAt);

          _usersStreamController.add(_currentUser);
        }
      }
    });
  }

  late final StreamController<MyClinicApiUser?> _usersStreamController;
  @override
  Stream<MyClinicApiUser?> get usersStream => _usersStreamController.stream;

  String _getUsersSocketIoChannel(int userId) {
    return "myclinic_database_private-users.$userId";
  }

  @override
  Future<Result<VoidValue, BasicError>> login({
    required String email,
    required String password,
  }) async {
    // login user with email and password
    final loginResult = await _dataSource.login(email, password);

    return loginResult.mapSuccessToVoid(
      (user) {
        _currentUser = user;
        _usersStreamController.add(_currentUser);
      },
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
      (user) {
        _userNotificationsListener.emitEvent(
          event: "verification-email-sent",
          data: {'listen-to': _getUsersSocketIoChannel(user.id)},
        );
        _currentUser = user;

        _usersStreamController.add(_currentUser);
      },
    );
  }

  @override
  Future<Result<VoidValue, BasicError>> logout() async {
    return (await _dataSource.logout()).fold(
      ifSuccess: (_) {
        _currentUser = null;
        _usersStreamController.add(_currentUser);
      },
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
        _currentUser = user;
        _usersStreamController.add(_currentUser);
        return SuccessResult.voidResult();
      },
      onFailure: (error) {
        _usersStreamController.add(null);
        return FailureResult(error);
      },
    );
  }
}
