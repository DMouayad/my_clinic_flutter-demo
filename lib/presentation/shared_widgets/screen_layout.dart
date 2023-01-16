import 'package:flutter/material.dart';

/// A layout used in the main screens of the app [
/// home screen, my patients screen, payments screen,
/// settings screen ] it consists of a scaffold with an appbar,
/// also optional fab and bottom navigation bar
class MainScreenLayout extends StatelessWidget {
  const MainScreenLayout({
    this.bottomNavBar,
    this.fab,
    this.floatingActionButtonLocation = FloatingActionButtonLocation.endFloat,
    required this.body,
    required this.screenIndex,
    this.titleText,
    this.actions,
    this.centerTitle = true,
    this.showAppBar = true,
    this.appBarBottom,
    this.appBarBackgroundColor,
    Key? key,
    this.title,
  }) : super(key: key);

  final List<Widget>? actions;
  final Widget body;
  final bool showAppBar;
  final Widget? bottomNavBar;
  final Widget? fab;
  final Widget? title;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final PreferredSizeWidget? appBarBottom;
  final int screenIndex;
  final Color? appBarBackgroundColor;
  final bool centerTitle;
  final String? titleText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      floatingActionButton: fab,
      floatingActionButtonLocation: floatingActionButtonLocation,
      appBar: showAppBar
          ? AppBar(
              title: title ??
                  Text(
                    titleText!,
                  ),
              leadingWidth: 48,
              elevation: 0,
              centerTitle: centerTitle,
              bottom: appBarBottom,
              actions: actions,
            )
          : null,
      bottomNavigationBar: bottomNavBar,
      body: body,
    );
  }
}
