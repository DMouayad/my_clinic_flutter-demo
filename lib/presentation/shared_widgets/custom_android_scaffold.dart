import 'package:clinic_v2/app/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_name_text.dart';
import 'material_with_utils.dart';

class CustomAndroidScaffold extends StatefulWidget {
  const CustomAndroidScaffold({
    super.key,
    this.appBarActions,
    this.drawerTiles,
    this.body,
    this.appBarTitle = const AppNameText(fontSize: 28),
    this.withDrawer = false,
  }) : assert((withDrawer && drawerTiles != null));

  final List<Widget>? appBarActions;
  final Widget? body;
  final bool withDrawer;
  final List<NavigationDrawerDestinationInfo>? drawerTiles;
  final Widget appBarTitle;

  @override
  State<CustomAndroidScaffold> createState() => _CustomAndroidScaffoldState();
}

class _CustomAndroidScaffoldState extends State<CustomAndroidScaffold> {
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Scaffold(
        backgroundColor: context.colorScheme.backgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: context.colorScheme.backgroundColor,
          actions: widget.appBarActions,
          foregroundColor: context.colorScheme.onBackground,
          title: widget.appBarTitle,
        ),
        drawer: !widget.withDrawer
            ? null
            : _CustomDrawer(
                currentTab: currentTab,
                onDestinationSelected: (tabIndex) {
                  setState(() => currentTab = tabIndex);
                },
                destinations: widget.drawerTiles!
                    .map((destInfo) => NavigationDrawerDestination(
                          backgroundColor:
                              context.colorScheme.secondaryContainer,
                          label: Text(destInfo.label),
                          icon: Icon(destInfo.iconData),
                        ))
                    .toList(),
              ),
        body: widget.withDrawer
            ? widget.drawerTiles![currentTab].bodyWidget
            : widget.body,
      ),
    );
  }
}

class _CustomDrawer extends StatelessWidget {
  final int currentTab;
  final void Function(int) onDestinationSelected;
  final List<NavigationDrawerDestination> destinations;

  const _CustomDrawer({
    required this.currentTab,
    required this.onDestinationSelected,
    required this.destinations,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationDrawerTheme(
      data: NavigationDrawerThemeData(
        indicatorColor: context.colorScheme.primary,
      ),
      child: NavigationDrawer(
        selectedIndex: currentTab,
        backgroundColor: context.colorScheme.backgroundColor,
        onDestinationSelected: (selectedIndex) {
          Scaffold.of(context).closeDrawer();
          Future.delayed(const Duration(milliseconds: 400), () {
            onDestinationSelected(selectedIndex);
          });
        },
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: context.colorScheme.primaryContainer,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AppNameText(),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: context.colorScheme.secondaryContainer,
                    child: Icon(
                      Icons.person_4,
                      color: context.colorScheme.secondary,
                    ),
                  ),
                  title: Text(
                    (context.read<AuthBloc>().state as AuthHasLoggedInUser)
                        .currentUser
                        .name,
                  ),
                  subtitle: Text(
                    (context.read<AuthBloc>().state as AuthHasLoggedInUser)
                        .currentUser
                        .email,
                  ),
                ),
              ],
            ),
          ),
          ...destinations,
        ],
      ),
    );
  }
}

class NavigationDrawerDestinationInfo {
  final String label;
  final IconData iconData;
  final Widget bodyWidget;

  const NavigationDrawerDestinationInfo(
    this.label,
    this.iconData,
    this.bodyWidget,
  );
}
