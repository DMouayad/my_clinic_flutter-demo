import 'package:clinic_v2/app/blocs/progress_indicator_bloc/progress_indicator_bloc.dart';
import 'package:clinic_v2/presentation/shared_widgets/material_with_utils.dart';
import 'package:clinic_v2/presentation/views/admin_panel/admin_panel_wide_android_screen.dart';
import 'package:clinic_v2/shared/models/api_request_metadata.dart';
import 'package:clinic_v2/utils/helpers/builders/context_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//
import 'package:clinic_v2/domain/staff_member/data/my_clinic_api_staff_member_repository.dart';
import 'package:clinic_v2/app/blocs/staff_bloc/staff_bloc.dart';
import 'package:clinic_v2/presentation/views/admin_panel/admin_panel_windows_screen.dart';
import 'package:clinic_v2/presentation/navigation/navigation.dart';
//

class AdminPanelPage extends AppPage {
  AdminPanelPage()
      : super(
          routeSettings: const RouteSettings(name: AppRoutes.startupScreen),
          pageTransitionBuilder: const ContextBuilder(
            windowsChild: RouteTransitionType.desktopEntrance,
          ),
          pageScreenBuilder: (context, animation, secondaryAnimation) {
            return ContextBuilder(
              //TODO: create mobile admin panel screen
              // windowsSmallScreen: ,
              // mobileScreen: ,
              androidTabletChild:
                  _provideScreen(const AdminPanelWideAndroidScreen()),
              windowsChild: _provideScreen(WindowsAdminPanelScreen()),
            );
          },
        );

  static Widget _provideScreen(Widget screen) {
    return BlocProvider(
      lazy: false,
      create: (_) {
        const event = FetchStaffMembers(
            metadata: ApiRequestMetadata(
          page: 1,
          sortedBy: ["+registered_with_at"],
        ));
        return StaffBloc(
          MyClinicApiStaffMemberRepository(),
        )..add(event);
      },
      child: BlocProvider(
        create: (context) => ProgressIndicatorBloc(),
        child: BlocListener<StaffBloc, StaffBlocState>(
          listenWhen: (prev, next) => prev is! LoadingStaffMembers,
          listener: (context, state) {
            if (state is StaffBlocEventProcessing) {
              context.read<ProgressIndicatorBloc>().add(
                    const ShowIndicatorRequested(Duration(seconds: 15)),
                  );
            }
            if (state is StaffBlocSuccess || state is StaffBlocErrorState) {
              context.read<ProgressIndicatorBloc>().add(
                    const ResetIndicatorDurationRequested(
                        Duration(seconds: 10)),
                  );
            }
          },
          child: screen,
        ),
      ),
    );
  }
}
