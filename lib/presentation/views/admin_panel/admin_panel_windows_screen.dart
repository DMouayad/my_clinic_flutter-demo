import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;

//
import 'package:clinic_v2/presentation/shared_widgets/material_with_utils.dart';
import 'package:clinic_v2/presentation/shared_widgets/app_name_text.dart';
import 'package:clinic_v2/presentation/shared_widgets/windows_components/custom_nav_view/custom_nav_pane_item.dart';
import 'package:clinic_v2/presentation/shared_widgets/windows_components/custom_nav_view/windows_app_bar.dart';
import 'package:clinic_v2/presentation/shared_widgets/windows_components/custom_nav_view/windows_nav_view_with_pane.dart';

import 'components/app_bar_actions.dart';
import 'components/staff_management_screen.dart';

class WindowsAdminPanelScreen extends StatelessWidget {
  WindowsAdminPanelScreen({Key? key}) : super(key: key);

  final _contentWidgets = [
    const StaffManagementScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return WindowsNavViewWithPane(
      displayMode: fluent_ui.PaneDisplayMode.minimal,
      appBar: buildCustomAppBar(
        context,
        appBarTitle: AppNameText(
          fontColor: context.colorScheme.primary,
          fontSize: 26,
        ),
        appBarActions: const AdminPanelAppBarActions(),
      ),
      items: [
        CustomNavPaneItem(
          title: context.localizations!.staffManagement,
          bodyContent: _contentWidgets[0],
          iconData: fluent_ui.FluentIcons.functional_manager_dashboard,
          context: context,
          contentPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
        ),
      ],
    );
  }
}
