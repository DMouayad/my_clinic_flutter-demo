import 'package:clinic_v2/presentation/shared_widgets/custom_android_scaffold.dart';
import 'package:clinic_v2/presentation/shared_widgets/material_with_utils.dart';
import 'components/app_bar_actions.dart';
import 'components/staff_management_screen.dart';

class AdminPanelWideAndroidScreen extends StatelessWidget {
  const AdminPanelWideAndroidScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAndroidScaffold(
      withDrawer: true,
      appBarActions: const [AdminPanelAppBarActions()],
      drawerTiles: [
        NavigationDrawerDestinationInfo(
          context.localizations!.staffManagement,
          Icons.manage_accounts,
          const StaffManagementScreen(),
        ),
        NavigationDrawerDestinationInfo(
          context.localizations!.search,
          Icons.settings,
          Container(),
        ),
      ],
    );
  }
}
