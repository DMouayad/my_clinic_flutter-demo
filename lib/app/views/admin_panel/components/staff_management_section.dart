import 'package:clinic_v2/app/blocs/staff_emails_bloc/staff_emails_bloc.dart';
import 'package:clinic_v2/app/features/staff_email/domain/src/base_staff_email.dart';
import 'package:clinic_v2/app/shared_widgets/custom_buttons/custom_icon_button.dart';
import 'package:clinic_v2/app/shared_widgets/custom_buttons/filled_buttons.dart';
import 'package:clinic_v2/app/shared_widgets/custom_table/custom_table_row.dart';
import 'package:clinic_v2/app/shared_widgets/custom_widget.dart';
import 'package:clinic_v2/app/shared_widgets/loading_indicator.dart';
import 'package:clinic_v2/app/views/admin_panel/components/add_staff_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class StaffManagementSection extends CustomStatelessWidget {
  const StaffManagementSection({Key? key}) : super(key: key);

  @override
  Widget customBuild(BuildContext context, widgetInfo) {
    return BlocBuilder<StaffEmailsBloc, StaffEmailsState>(
      builder: (context, state) {
        if (state is StaffEmailWasLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 20),
                child: AdaptiveFilledButton(
                  label: 'Add new staff',
                  onPressed: () async {
                    if (context.isWindowsPlatform) {
                      showWindowsAddStaffDialog(context);
                    }
                  },
                  width: context.isMobile
                      ? widgetInfo.widgetSize.width * .4
                      : widgetInfo.widgetSize.width * .2,
                ),
              ),
              _StaffDataTable(state.staffEmails!),
            ],
          );
        }
        return const LoadingIndicator(secondsPerRotation: 1);
      },
    );
  }
}

class _StaffDataTable extends StatelessWidget {
  const _StaffDataTable(this.staffEmails, {Key? key}) : super(key: key);
  final List<BaseStaffEmail> staffEmails;
  String getRegisteredWithAt(DateTime? userCreatedAt, BuildContext context) {
    return userCreatedAt != null
        ? '${DateFormat.yMd(context.locale.countryCode).format(userCreatedAt.toLocal())} '
            '- ${DateFormat.jm(context.locale.countryCode).format(userCreatedAt.toLocal())}'
        : 'Not registered';
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.symmetric(
        inside: BorderSide(
          color: context.isDarkMode ? Colors.white12 : Colors.grey.shade100,
        ),
      ),
      children: [
        CustomTableRow(
          textStyle: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          childrenContent: const [
            'Email',
            'Assigned role',
            'Registered with at',
            'Options'
          ],
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 14,
          ),
          decoration: BoxDecoration(
            color: context.isDarkMode
                ? context.colorScheme.secondaryContainer
                : context.colorScheme.primaryContainer,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
        ),
        ...staffEmails
            .map(
              (e) => CustomTableRow(
                childrenContent: [
                  e.email,
                  e.userRole.name,
                  getRegisteredWithAt(e.user?.createdAt, context),
                  _StaffEmailOptions(e),
                ],
                padding: const EdgeInsets.all(16.0),
              ),
            )
            .toList(),
      ],
    );
  }
}

class _StaffEmailOptions extends StatelessWidget {
  const _StaffEmailOptions(this.staffEmail, {Key? key}) : super(key: key);
  final BaseStaffEmail staffEmail;

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      mainAxisSize: MainAxisSize.min,
      alignment: MainAxisAlignment.spaceAround,
      children: [
        CustomIconButton(
          tooltipMessage: 'edit',
          icon: Icon(Icons.edit),
          onPressed: () {},
        ),
        CustomIconButton(
          tooltipMessage: 'email',
          icon: Icon(
            Icons.delete,
            color: Colors.red.shade400,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
