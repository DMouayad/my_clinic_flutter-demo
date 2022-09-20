import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class BaseUserPreferences extends Equatable {
  final int id;
  final int userId;
  final ThemeMode themePreference;
  final Locale localePreference;

  const BaseUserPreferences({
    required this.id,
    required this.userId,
    required this.localePreference,
    required this.themePreference,
  });

  @override
  List<Object?> get props => [id, userId, themePreference, localePreference];
}
