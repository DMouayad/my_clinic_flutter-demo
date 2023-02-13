import 'package:clinic_v2/app/blocs/progress_indicator_bloc/progress_indicator_bloc.dart';
import 'package:clinic_v2/presentation/shared_widgets/buttons/logout_button.dart';
import 'package:clinic_v2/presentation/shared_widgets/buttons/settings_button.dart';
import 'package:clinic_v2/presentation/shared_widgets/material_with_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'staff_bloc_events_processing_indicator.dart';

class AdminPanelAppBarActions extends StatelessWidget {
  const AdminPanelAppBarActions({super.key});

  @override
  Widget build(BuildContext context) {
    return BuilderWithWidgetInfo(
      builder: (context, widgetInfo) {
        return Container(
          constraints: BoxConstraints.loose(
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
    );
  }
}
