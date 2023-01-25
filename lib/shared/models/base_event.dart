import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseBlocEvent<T, State> {
  const BaseBlocEvent();

  Future<void> handle(
    T repository,
    State state,
    Emitter<State> emit,
  );
}
