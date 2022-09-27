import 'package:flutter_bloc/flutter_bloc.dart';
//
import 'package:clinic_v2/app/features/staff_email/data/staff_email_data.dart';
import 'package:clinic_v2/app/blocs/staff_emails_bloc/staff_emails_bloc.dart';
import 'package:clinic_v2/app/views/admin_panel/admin_panel_windows_screen.dart';
import 'package:clinic_v2/app/navigation/navigation.dart';
//

class AdminPanelPage extends AppPage {
  AdminPanelPage()
      : super(
          routeSettings: const RouteSettings(name: AppRoutes.startupScreen),
          pageScreensBuilder: (context, animation, secondaryAnimation) {
            return PageScreensBuilder(
              //TODO: create mobile admin panel screen
              windowsScreen: BlocProvider(
                lazy: false,
                create: (_) {
                  return StaffEmailsBloc(
                    MyClinicApiStaffEmailRepository(),
                  )..add(FetchStaffEmails());
                },
                child: WindowsAdminPanelScreen(),
              ),
            );
          },
        );
}
