import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
import 'package:flutter_bloc/flutter_bloc.dart';
//
import 'package:clinic_v2/app/blocs/progress_indicator_bloc/progress_indicator_bloc.dart';
import 'package:clinic_v2/app/blocs/staff_bloc/staff_bloc.dart';
import 'package:clinic_v2/app/core/entities/result/result.dart';
//
import 'package:clinic_v2/app/shared_widgets/material_with_utils.dart';
import 'package:clinic_v2/app/shared_widgets/app_name_text.dart';
import 'package:clinic_v2/app/shared_widgets/windows_components/custom_nav_view/custom_nav_pane_item.dart';
import 'package:clinic_v2/app/shared_widgets/windows_components/custom_nav_view/windows_app_bar.dart';
import 'package:clinic_v2/app/shared_widgets/windows_components/custom_nav_view/windows_nav_view_with_pane.dart';
import 'package:clinic_v2/app/shared_widgets/windows_components/processing_indicator.dart';

import 'components/logout_button.dart';
import 'components/settings_button.dart';
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
        listener: (context, state) {
          if (state is StaffBlocEventProcessing) {
            context.read<ProgressIndicatorBloc>().add(
                  const ShowIndicatorRequested(Duration(seconds: 15)),
                );
          }
          if (state is StaffBlocSuccess || state is StaffBlocErrorState) {
            context.read<ProgressIndicatorBloc>().add(
                  const ResetIndicatorDurationRequested(Duration(seconds: 5)),
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
                              child:
                                  const _StaffBlocEventsProcessingIndicator(),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                      const ButtonBar(
                        children: [
                          SettingsIconButton(),
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

class _StaffBlocEventsProcessingIndicator extends StatelessWidget {
  const _StaffBlocEventsProcessingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WindowsProcessingIndicator(
      status: context
          .read<StaffBloc>()
          .stream
          .takeWhile((s) => s is StaffBlocSuccess || s is StaffBlocErrorState)
          .map<Result<VoidValue, BasicError>>((state) {
        if (state is StaffBlocSuccess) {
          return SuccessResult.voidResult();
        } else {
          return FailureResult(
            (state as StaffBlocErrorState).error,
          );
        }
      }),
      indicatorStatesText: _getProcessingStatesText(context),
    );
  }

  IndicatorStatesText _getProcessingStatesText(BuildContext context) {
    switch (context.read<StaffBloc>().state.runtimeType) {
      case AddingStaffMember:
        return const IndicatorStatesText(
          onProcessing: 'adding new staff member...',
          onSuccess: 'staff member was added successfully',
          onFailure: 'Failed to add staff member',
        );
      case DeletingStaffMember:
        return const IndicatorStatesText(
          onProcessing: 'Deleting staff member...',
          onSuccess: 'staff member was deleted successfully',
          onFailure: 'Failed to delete staff member',
        );
      case UpdatingStaffMember:
        return const IndicatorStatesText(
          onProcessing: 'Updating staff member...',
          onSuccess: 'staff member was updated successfully',
          onFailure: 'Failed to update staff member',
        );
      default:
        return const IndicatorStatesText(
          onProcessing: 'processing...',
          onSuccess: 'request was completed successfully',
          onFailure: 'Failed',
        );
    }
  }
}
