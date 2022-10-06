import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
import 'package:flutter_bloc/flutter_bloc.dart';
//
import 'package:clinic_v2/app/blocs/progress_indicator_bloc/progress_indicator_bloc.dart';
import 'package:clinic_v2/app/blocs/staff_emails_bloc/staff_emails_bloc.dart';
import 'package:clinic_v2/app/core/entities/result/result.dart';
//
import 'package:clinic_v2/app/shared_widgets/material_with_utils.dart';
import 'package:clinic_v2/app/shared_widgets/app_name_text.dart';
import 'package:clinic_v2/app/shared_widgets/windows_components/custom_nav_view/custom_nav_pane_item.dart';
import 'package:clinic_v2/app/shared_widgets/windows_components/custom_nav_view/windows_app_bar.dart';
import 'package:clinic_v2/app/shared_widgets/windows_components/custom_nav_view/windows_nav_view_with_pane.dart';
import 'package:clinic_v2/app/shared_widgets/windows_components/processing_indicator.dart';

import 'accounts_management/accounts_management_screen.dart';
import 'components/logout_button.dart';
import 'components/settings_button.dart';

class WindowsAdminPanelScreen extends StatelessWidget {
  WindowsAdminPanelScreen({Key? key}) : super(key: key);

  final _contentWidgets = [
    const AccountsManagementWindowsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProgressIndicatorBloc(),
      child: BlocListener<StaffEmailsBloc, StaffEmailsState>(
        listener: (context, state) {
          if (state is StaffEmailsEventProcessing) {
            context.read<ProgressIndicatorBloc>().add(
                  ShowIndicatorRequested(
                    Duration(seconds: 15),
                  ),
                );
          }
          if (state is StaffEmailsSuccess) {
            print('hi');
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
            appBarActions:
                BuilderWithWidgetInfo(builder: (context, widgetInfo) {
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
                    BlocBuilder<ProgressIndicatorBloc, ProgressIndicatorState>(
                      builder: (context, state) {
                        if (state is ProgressIndicatorIsVisible) {
                          return Container(
                            constraints: BoxConstraints(
                              // minWidth: 200,
                              maxWidth: widgetInfo.widgetSize.width * .6,
                              maxHeight: 70,
                            ),
                            margin: const EdgeInsets.only(top: 12),
                            child: BlocProvider.value(
                              value: context.read<StaffEmailsBloc>(),
                              child:
                                  const _StaffEmailsBlocEventsProcessingIndicator(),
                            ),
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
            }),
          ),
          items: [
            CustomNavPaneItem(
              title: context.localizations!.accountsManagement,
              iconData: fluent_ui.FluentIcons.functional_manager_dashboard,
              context: context,
              contentPadding: EdgeInsets.zero,
              bodyContent: _contentWidgets[0],
            ),
          ],
        ),
      ),
    );
  }
}

class _StaffEmailsBlocEventsProcessingIndicator extends StatelessWidget {
  const _StaffEmailsBlocEventsProcessingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WindowsProcessingIndicator(
      status: context
          .read<StaffEmailsBloc>()
          .stream
          .takeWhile(
              (s) => s is StaffEmailsSuccess || s is StaffEmailErrorState)
          .map<Result<VoidValue, BasicError>>((state) {
        if (state is StaffEmailsSuccess) {
          return SuccessResult.voidResult();
        } else {
          return FailureResult(
            (state as StaffEmailErrorState).error,
          );
        }
      }),
      indicatorStatesText: _getProcessingStatesText(context),
    );
  }

  IndicatorStatesText _getProcessingStatesText(BuildContext context) {
    switch (context.read<StaffEmailsBloc>().state.runtimeType) {
      case AddStaffEmailProcessing:
        return const IndicatorStatesText(
          onProcessing: 'adding new staff email...',
          onSuccess: 'staff email was added successfully',
          onFailure: 'Failed to add staff email',
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
