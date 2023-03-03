import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_test/flutter_test.dart' as flutter_test;

import 'base_repository_factory.dart';

/// ### Custom [BLoc]/[Cubit] testcase function
///
/// Includes all the functionalities of default [test] function alongside
/// an additional setup for the required repository.
///
/// Subclasses have to provide:
/// - [createBloc]: to create the under-test bloc.
/// - [repositoryFactory].
///
/// Note that a [BlocTestCase] can be executed by `BlocTestCase().call()`
/// or `BlocTestCase()()`.
///
/// ### Example:
///   - First we create a base class for a specified bloc/cubit:
///
/// ``` dart
///   class ExampleBlocTestCase extends BlocTestCase<ExampleBlocState,
///   ExampleBloc,ExampleRepository, ExampleRepositoryFactory>{
///   ExampleBlocTestCase(super.description);
///    @override
///   ExampleBloc createBloc(repository) {
///     return ExampleBloc(repository);
///   }
///
///   @override
///   ExampleRepositoryFactory get repositoryFactory =>
///       ExampleRepositoryFactory();
///   }
/// ```
///
///   - Usage for a testcase:
/// ``` dart
///   ExampleBlocTestCase(
///     "Example testcase description",
///     act: (bloc, repo) => bloc.add(SomeEvent()),
///     expectedStates: (bloc,repo) => [StateA(), StateB()],
///     ).call();
/// ```
///

abstract class BlocTestCase<B extends BlocBase<S>, S, R,
    F extends BaseRepositoryFactory<R>> {
  final String description;
  final F Function(F factory)? setupRepository;
  final dynamic Function(B bloc)? act;

  /// for custom expect use cases i.e. not regarding emitted states
  final dynamic Function(B bloc, R repository)? expect;
  final List<S> Function(B bloc, R repository)? expectedStates;
  final dynamic Function(B bloc, R repository)? verify;
  final Duration? waitAfterAct;
  final S Function()? seed;
  F repositoryFactory;

  B createBloc(R repository);

  BlocTestCase(
    this.description, {
    required this.repositoryFactory,
    this.setupRepository,
    this.act,
    this.expect,
    this.seed,
    this.expectedStates,
    this.verify,
    this.waitAfterAct,
  });

  @isTest
  void call() async {
    flutter_test.test(description, () async {
      // setup
      List<S> states = [];
      F repoFactory = repositoryFactory;
      late R mockRepository;
      late B bloc;
      if (setupRepository != null) {
        repoFactory = setupRepository!(repoFactory);
      }
      mockRepository = repoFactory.create();
      bloc = createBloc(mockRepository);
      // store emitted states for matching them later with [expectedStates]
      final sub = bloc.stream.listen((s) => states.add(s));
      if (seed != null) bloc.emit(seed!());
      // act
      if (act != null) {
        await act!(bloc);
      }
      await Future<void>.delayed(waitAfterAct ?? Duration.zero);
      await Future<void>.delayed(Duration.zero);
      // After [act] is called, the bloc should be closed to prevent emitting
      // undesired states
      await bloc.close();

      if (expect != null) {
        expect!(bloc, mockRepository);
      }
      if (expectedStates != null) {
        flutter_test.expect(states, expectedStates!(bloc, mockRepository));
      }
      if (verify != null) {
        verify!(bloc, mockRepository);
      }
      await sub.cancel();
    });
  }
}
