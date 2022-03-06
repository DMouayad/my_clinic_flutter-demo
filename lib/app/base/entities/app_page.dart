import 'package:flutter/material.dart';

class AppPage extends Page {
  final Route route;
  const AppPage({required this.route});
  @override
  Route createRoute(BuildContext context) {
    return route;
  }
}
