import 'dart:math';

import 'package:clinic_v2/utils/enums.dart';
import 'package:clinic_v2/domain/user_preferences/base/base_user_preferences.dart';
import 'package:faker_dart/faker_dart.dart';

import 'fake_server_user.dart';

class FakeServerUserFactory {
  int? id;
  String? phoneNumber;
  String? name;
  String? email;
  UserRole? role;
  DateTime? emailVerifiedAt;
  BaseUserPreferences? preferences;

  factory FakeServerUserFactory() {
    return FakeServerUserFactory._(faker: Faker.instance);
  }
  final Faker _faker;

  FakeServerUser create() {
    final rnd = Random();
    return FakeServerUser(
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

  FakeServerUserFactory withAttributes({
    int? id,
    String? phoneNumber,
    String? name,
    String? email,
    UserRole? role,
    DateTime? emailVerifiedAt,
    BaseUserPreferences? preferences,
  }) {
    return FakeServerUserFactory._(
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

  FakeServerUserFactory._({
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
