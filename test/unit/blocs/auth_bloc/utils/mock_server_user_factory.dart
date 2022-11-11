import 'dart:math';

import 'package:clinic_v2/app/core/enums.dart';
import 'package:clinic_v2/app/features/user_preferences/domain/base_user_preferences.dart';
import 'package:faker_dart/faker_dart.dart';

import 'mock_base_server_user.dart';

class MockServerUserFactory {
  int? id;
  String? phoneNumber;
  String? name;
  String? email;
  UserRole? role;
  DateTime? emailVerifiedAt;
  BaseUserPreferences? preferences;

  factory MockServerUserFactory() {
    return MockServerUserFactory._(faker: Faker.instance);
  }
  final Faker _faker;

  MockBaseServerUser create() {
    final rnd = Random();
    return MockBaseServerUser(
      id: id ?? rnd.nextInt(9999),
      name: name ?? _faker.name.fullName(),
      email: email ?? _faker.internet.email(),
      phoneNumber: phoneNumber ?? _faker.phoneNumber.phoneNumber(),
      role: role ?? UserRole.values[rnd.nextInt(UserRole.values.length)],
      createdAt: DateTime.now(),
      emailVerifiedAt: emailVerifiedAt,
      preferences: preferences,
    );
  }

  MockServerUserFactory withAttributes({
    int? id,
    String? phoneNumber,
    String? name,
    String? email,
    UserRole? role,
    DateTime? emailVerifiedAt,
    BaseUserPreferences? preferences,
  }) {
    return MockServerUserFactory._(
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      preferences: preferences ?? this.preferences,
      faker: _faker,
    );
  }

  MockServerUserFactory._({
    this.id,
    this.phoneNumber,
    this.name,
    this.email,
    this.role,
    this.emailVerifiedAt,
    this.preferences,
    required Faker faker,
  }) : _faker = faker;
}
