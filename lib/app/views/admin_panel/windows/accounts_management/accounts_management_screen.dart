import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
import 'package:flutter_bloc/flutter_bloc.dart';
//
import 'package:clinic_v2/app/blocs/staff_emails_bloc/staff_emails_bloc.dart';
import 'package:clinic_v2/app/features/staff_email/domain/src/base_staff_email.dart';
//
import 'package:clinic_v2/app/shared_widgets/material_with_utils.dart';
import 'package:clinic_v2/app/views/admin_panel/windows/accounts_management/add_staff_email_button.dart';
import 'package:clinic_v2/app/shared_widgets/loading_indicator.dart';

import 'staff_emails_table.dart';

class AccountsManagementWindowsScreen extends StatelessWidget {
  const AccountsManagementWindowsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var staffEmails = <BaseStaffEmail>[];
    return BuilderWithWidgetInfo(builder: (context, widgetInfo) {
      return fluent_ui.ScaffoldPage(
        header: fluent_ui.Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "List of email address which are allowed to register for a CLINIC's account",
                  style: context.textTheme.subtitle1?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: context.colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
              Expanded(
                flex: 0,
                child: AddStaffEmailButton(
                  parentWidgetSize: widgetInfo.widgetSize,
                ),
              ),
            ],
          ),
        ),
        content: fluent_ui.SizedBox.expand(
          child: BlocBuilder<StaffEmailsBloc, StaffEmailsState>(
            builder: (context, state) {
              if (state is StaffEmailsWereLoaded) {
                staffEmails = state.staffEmails!;
              } else if (state is LoadingStaffEmails) {
                return const fluent_ui.Center(child: LoadingIndicator());
              }
              if (staffEmails.isNotEmpty) {
                return SingleChildScrollView(
                  // scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: StaffDataTable(staffEmails),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });
  }
}
