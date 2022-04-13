// Mocks generated by Mockito 5.0.17 from annotations
// in clinic_v2/test/app/features/startup/cubit/startup_cubit_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:bloc/bloc.dart' as _i4;
import 'package:clinic_v2/app/features/startup/cubit/startup_cubit.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeStartupState_0 extends _i1.Fake implements _i2.StartupState {}

/// A class which mocks [StartupCubit].
///
/// See the documentation for Mockito's code generation for more information.
class MockStartupCubit extends _i1.Mock implements _i2.StartupCubit {
  MockStartupCubit() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.StartupState get state => (super.noSuchMethod(Invocation.getter(#state),
      returnValue: _FakeStartupState_0()) as _i2.StartupState);
  @override
  _i3.Stream<_i2.StartupState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: Stream<_i2.StartupState>.empty())
          as _i3.Stream<_i2.StartupState>);
  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);
  @override
  _i3.Future<void> initServerConnection() =>
      (super.noSuchMethod(Invocation.method(#initServerConnection, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
  @override
  void retryToInitWhenConnectionIsRestored() => super.noSuchMethod(
      Invocation.method(#retryToInitWhenConnectionIsRestored, []),
      returnValueForMissingStub: null);
  @override
  void emit(_i2.StartupState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void onChange(_i4.Change<_i2.StartupState>? change) =>
      super.noSuchMethod(Invocation.method(#onChange, [change]),
          returnValueForMissingStub: null);
  @override
  void addError(Object? error, [StackTrace? stackTrace]) =>
      super.noSuchMethod(Invocation.method(#addError, [error, stackTrace]),
          returnValueForMissingStub: null);
  @override
  void onError(Object? error, StackTrace? stackTrace) =>
      super.noSuchMethod(Invocation.method(#onError, [error, stackTrace]),
          returnValueForMissingStub: null);
  @override
  _i3.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
}
