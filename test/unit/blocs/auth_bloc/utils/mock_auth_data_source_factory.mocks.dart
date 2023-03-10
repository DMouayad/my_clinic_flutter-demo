// Mocks generated by Mockito 5.3.2 from annotations
// in clinic_v2/test/unit/blocs/auth_bloc/utils/mock_auth_data_source_factory.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:clinic_v2/domain/authentication/base/base_auth_data_source.dart'
    as _i3;
import 'package:clinic_v2/shared/models/result/result.dart' as _i1;
import 'package:mockito/mockito.dart' as _i2;

import 'fake_server_user.dart' as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeResult_0<V extends Object?, E extends _i1.AppError>
    extends _i2.SmartFake implements _i1.Result<V, E> {
  _FakeResult_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [BaseAuthDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockBaseAuthDataSource extends _i2.Mock
    implements _i3.BaseAuthDataSource<_i4.FakeServerUser> {
  @override
  _i5.Future<_i1.Result<_i4.FakeServerUser, _i1.AppError>> register({
    required String? username,
    required String? email,
    required String? phoneNumber,
    required String? password,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #register,
          [],
          {
            #username: username,
            #email: email,
            #phoneNumber: phoneNumber,
            #password: password,
          },
        ),
        returnValue:
            _i5.Future<_i1.Result<_i4.FakeServerUser, _i1.AppError>>.value(
                _FakeResult_0<_i4.FakeServerUser, _i1.AppError>(
          this,
          Invocation.method(
            #register,
            [],
            {
              #username: username,
              #email: email,
              #phoneNumber: phoneNumber,
              #password: password,
            },
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i1.Result<_i4.FakeServerUser, _i1.AppError>>.value(
                _FakeResult_0<_i4.FakeServerUser, _i1.AppError>(
          this,
          Invocation.method(
            #register,
            [],
            {
              #username: username,
              #email: email,
              #phoneNumber: phoneNumber,
              #password: password,
            },
          ),
        )),
      ) as _i5.Future<_i1.Result<_i4.FakeServerUser, _i1.AppError>>);
  @override
  _i5.Future<_i1.Result<_i4.FakeServerUser, _i1.AppError>> login({
    required String? email,
    required String? password,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #login,
          [],
          {
            #email: email,
            #password: password,
          },
        ),
        returnValue:
            _i5.Future<_i1.Result<_i4.FakeServerUser, _i1.AppError>>.value(
                _FakeResult_0<_i4.FakeServerUser, _i1.AppError>(
          this,
          Invocation.method(
            #login,
            [],
            {
              #email: email,
              #password: password,
            },
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i1.Result<_i4.FakeServerUser, _i1.AppError>>.value(
                _FakeResult_0<_i4.FakeServerUser, _i1.AppError>(
          this,
          Invocation.method(
            #login,
            [],
            {
              #email: email,
              #password: password,
            },
          ),
        )),
      ) as _i5.Future<_i1.Result<_i4.FakeServerUser, _i1.AppError>>);
  @override
  _i5.Future<_i1.Result<_i4.FakeServerUser?, _i1.AppError>> loadUser() =>
      (super.noSuchMethod(
        Invocation.method(
          #loadUser,
          [],
        ),
        returnValue:
            _i5.Future<_i1.Result<_i4.FakeServerUser?, _i1.AppError>>.value(
                _FakeResult_0<_i4.FakeServerUser?, _i1.AppError>(
          this,
          Invocation.method(
            #loadUser,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i1.Result<_i4.FakeServerUser?, _i1.AppError>>.value(
                _FakeResult_0<_i4.FakeServerUser?, _i1.AppError>(
          this,
          Invocation.method(
            #loadUser,
            [],
          ),
        )),
      ) as _i5.Future<_i1.Result<_i4.FakeServerUser?, _i1.AppError>>);
  @override
  _i5.Future<_i1.Result<_i1.VoidValue, _i1.AppError>> logout() =>
      (super.noSuchMethod(
        Invocation.method(
          #logout,
          [],
        ),
        returnValue: _i5.Future<_i1.Result<_i1.VoidValue, _i1.AppError>>.value(
            _FakeResult_0<_i1.VoidValue, _i1.AppError>(
          this,
          Invocation.method(
            #logout,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i1.Result<_i1.VoidValue, _i1.AppError>>.value(
                _FakeResult_0<_i1.VoidValue, _i1.AppError>(
          this,
          Invocation.method(
            #logout,
            [],
          ),
        )),
      ) as _i5.Future<_i1.Result<_i1.VoidValue, _i1.AppError>>);
  @override
  _i5.Future<_i1.Result<_i1.VoidValue, _i1.AppError>> requestPasswordReset(
          String? email) =>
      (super.noSuchMethod(
        Invocation.method(
          #requestPasswordReset,
          [email],
        ),
        returnValue: _i5.Future<_i1.Result<_i1.VoidValue, _i1.AppError>>.value(
            _FakeResult_0<_i1.VoidValue, _i1.AppError>(
          this,
          Invocation.method(
            #requestPasswordReset,
            [email],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i1.Result<_i1.VoidValue, _i1.AppError>>.value(
                _FakeResult_0<_i1.VoidValue, _i1.AppError>(
          this,
          Invocation.method(
            #requestPasswordReset,
            [email],
          ),
        )),
      ) as _i5.Future<_i1.Result<_i1.VoidValue, _i1.AppError>>);
  @override
  _i5.Future<_i1.Result<_i1.VoidValue, _i1.AppError>> sendVerificationEmail() =>
      (super.noSuchMethod(
        Invocation.method(
          #sendVerificationEmail,
          [],
        ),
        returnValue: _i5.Future<_i1.Result<_i1.VoidValue, _i1.AppError>>.value(
            _FakeResult_0<_i1.VoidValue, _i1.AppError>(
          this,
          Invocation.method(
            #sendVerificationEmail,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i1.Result<_i1.VoidValue, _i1.AppError>>.value(
                _FakeResult_0<_i1.VoidValue, _i1.AppError>(
          this,
          Invocation.method(
            #sendVerificationEmail,
            [],
          ),
        )),
      ) as _i5.Future<_i1.Result<_i1.VoidValue, _i1.AppError>>);
}
