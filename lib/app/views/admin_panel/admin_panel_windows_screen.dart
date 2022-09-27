import 'package:clinic_v2/app/core/extensions/context_extensions.dart';
import 'package:clinic_v2/app/shared_widgets/app_name_text.dart';
import 'package:clinic_v2/app/shared_widgets/windows_components/custom_nav_pane_item.dart';
import 'package:clinic_v2/app/shared_widgets/windows_components/custom_nav_view.dart';
import 'package:fluent_ui/fluent_ui.dart';

class WindowsAdminPanelScreen extends StatelessWidget {
  WindowsAdminPanelScreen({Key? key}) : super(key: key);

  final _contentWidgets = [
    Container(child: Text('0')),
    Container(child: Text('1')),
    Container(child: Text('2')),
  ];
  @override
  Widget build(BuildContext context) {
    final footerItems = [
      PaneItemSeparator(
        color: context.colorScheme.dividerColor,
      ),
      CustomNavPaneItem(
        context: context,
        title: context.localizations!.myAccount,
        iconData: FluentIcons.account_management,
      ),
      CustomNavPaneItem(
        context: context,
        title: context.localizations!.settings,
        iconData: FluentIcons.settings,
      ),
    ];

    return WindowsNavViewWithPane(
      items: [
        CustomNavPaneItem(
            title: context.localizations!.staffManagement,
            iconData: FluentIcons.functional_manager_dashboard,
            context: context),
      ],
      contentWidgets: _contentWidgets,
      footerItems: footerItems,
    );
  }
}
