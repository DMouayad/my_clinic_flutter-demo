import 'package:flutter/material.dart';

class UserPreferencesItem {
  final IconData icon;
  final String name;
  final Widget itemWidget;

  UserPreferencesItem({
    required this.icon,
    required this.name,
    required this.itemWidget,
  });
}
