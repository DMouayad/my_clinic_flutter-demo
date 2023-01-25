import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
import 'package:flutter_bloc/flutter_bloc.dart';
//
import 'package:clinic_v2/presentation/shared_widgets/buttons/logout_button.dart';
import 'package:clinic_v2/app/blocs/progress_indicator_bloc/progress_indicator_bloc.dart';
import 'package:clinic_v2/app/blocs/staff_bloc/staff_bloc.dart';
import 'package:clinic_v2/presentation/shared_widgets/material_with_utils.dart';
import 'package:clinic_v2/presentation/shared_widgets/app_name_text.dart';
import 'package:clinic_v2/presentation/shared_widgets/windows_components/custom_nav_view/custom_nav_pane_item.dart';
import 'package:clinic_v2/presentation/shared_widgets/windows_components/custom_nav_view/windows_app_bar.dart';
import 'package:clinic_v2/presentation/shared_widgets/windows_components/custom_nav_view/windows_nav_view_with_pane.dart';

import '../../../shared_widgets/buttons/settings_button.dart';
import 'staff_management/staff_bloc_events_processing_indicator.dart';
import 'staff_management/staff_management_screen.dart';

class WindowsAdminPanelScreen extends StatelessWidget {
  WindowsAdminPanelScreen({Key? key}) : super(key: key);

  final _contentWidgets = [
    const StaffManagementWindowsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
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
                  const ResetIndicatorDurationRequested(Duration(seconds: 10)),
                );
          }
        },
        child: WindowsNavViewWithPane(
          appBar: buildCustomAppBar(
            context,
            appBarTitle: AppNameText(
              fontColor: context.colorScheme.primary,
              fontSize: 26,
            ),
            appBarActions: BuilderWithWidgetInfo(
              builder: (context, widgetInfo) {
                return Container(
                  constraints: BoxConstraints.tight(
                    Size.fromWidth(widgetInfo.widgetSize.width),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BlocBuilder<ProgressIndicatorBloc,
                          ProgressIndicatorState>(
                        builder: (context, state) {
                          if (state is ProgressIndicatorIsVisible) {
                            return Container(
                              constraints: BoxConstraints(
                                maxWidth: widgetInfo.widgetSize.width * .6,
                                maxHeight: 70,
                              ),
                              margin: const EdgeInsets.only(top: 12),
                              child: const StaffBlocEventsProcessingIndicator(),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                      const ButtonBar(
                        children: [
                          ShowSettingsDialogButton(),
                          LogoutIconButton(),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
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
        ),
      ),
    );
  }
}
