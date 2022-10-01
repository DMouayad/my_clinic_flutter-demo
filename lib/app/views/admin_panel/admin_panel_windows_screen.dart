import 'package:clinic_v2/app/shared_widgets/app_name_text.dart';
import 'package:clinic_v2/app/shared_widgets/custom_widget.dart';

import 'package:clinic_v2/app/shared_widgets/windows_components/custom_nav_view/custom_nav_pane_item.dart';
import 'package:clinic_v2/app/shared_widgets/windows_components/custom_nav_view/windows_app_bar.dart';
import 'package:clinic_v2/app/shared_widgets/windows_components/custom_nav_view/windows_nav_view_with_pane.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;

import 'components/logout_button.dart';
import 'components/settings_button.dart';
import 'components/staff_management_section.dart';

class WindowsAdminPanelScreen extends CustomStatelessWidget {
  WindowsAdminPanelScreen({Key? key}) : super(key: key);

  final _contentWidgets = [
    StaffManagementSection(),
  ];

  @override
  Widget customBuild(BuildContext context, widgetInfo) {
    return WindowsNavViewWithPane(
      appBar: buildCustomAppBar(
        context,
        appBarTitle: AppNameText(
          fontColor: context.colorScheme.primary,
          fontSize: 26,
        ),
        appBarActions: Container(
          constraints: BoxConstraints.tight(
            Size.fromWidth(widgetInfo.widgetSize.width),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: const ButtonBar(
            children: [
              SettingsIconButton(),
              LogoutIconButton(),
            ],
          ),
        ),
      ),
      items: [
        CustomNavPaneItem(
          title: context.localizations!.staffManagement,
          iconData: fluent_ui.FluentIcons.functional_manager_dashboard,
          context: context,
          contentPadding: EdgeInsets.zero,
          bodyContent: _contentWidgets[0],
        ),
      ],
    );
  }
}
