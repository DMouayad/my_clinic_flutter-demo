import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';

class HydratedStorageMock extends Mock implements Storage {}

Storage get hydratedStorage {
  TestWidgetsFlutterBinding.ensureInitialized();
  final storage = HydratedStorageMock();
  when<dynamic>(() => storage.read(any())).thenReturn(<String, dynamic>{});
  when(() => storage.write(any(), any<dynamic>())).thenAnswer((_) async {});
  when(() => storage.delete(any())).thenAnswer((_) async {});
  when(() => storage.clear()).thenAnswer((_) async {});
  return storage;
}

FutureOr<T> mockHydratedStorage<T>(
  T Function() body, {
  Storage? storage,
}) {
  // TestWidgetsFlutterBinding.ensureInitialized();
  return HydratedBlocOverrides.runZoned<T>(
    body,
    storage: storage ?? hydratedStorage,
  );
}
