import 'package:flutter_bloc/flutter_bloc.dart';
//
import 'package:clinic_v2/domain/staff_member/data/my_clinic_api_staff_member_repository.dart';
import 'package:clinic_v2/app/blocs/staff_bloc/staff_bloc.dart';
import 'package:clinic_v2/presentation/views/admin_panel/windows/admin_panel_windows_screen.dart';
import 'package:clinic_v2/presentation/navigation/navigation.dart';
//

class AdminPanelPage extends AppPage {
  AdminPanelPage()
      : super(
          routeSettings: const RouteSettings(name: AppRoutes.startupScreen),
          pageTransitions: const RouteTransitionBuilder(
            windows: RouteTransitionType.desktopEntrance,
          ),
          pageScreensBuilder: (context, animation, secondaryAnimation) {
            return PageScreensBuilder(
              //TODO: create mobile admin panel screen
              windowsScreen: BlocProvider(
                lazy: false,
                create: (_) {
                  return StaffBloc(
                    MyClinicApiStaffMemberRepository(),
                  )..add(const FetchStaffMembers(
                      page: 1,
                      sortedBy: ["+registered_with_at"],
                    ));
                },
                child: WindowsAdminPanelScreen(),
              ),
            );
          },
        );
}
