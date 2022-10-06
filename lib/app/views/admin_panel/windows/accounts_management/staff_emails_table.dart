import 'package:clinic_v2/app/blocs/staff_emails_bloc/staff_emails_bloc.dart';
import 'package:clinic_v2/app/core/extensions/context_extensions.dart';
import 'package:clinic_v2/app/features/staff_email/domain/staff_email_domain.dart';
import 'package:clinic_v2/app/shared_widgets/custom_buttons/custom_icon_button.dart';
import 'package:clinic_v2/app/shared_widgets/custom_dialogs/show_alert_dialog.dart';
import 'package:clinic_v2/app/shared_widgets/custom_table/custom_table_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;

class StaffDataTable extends StatelessWidget {
  const StaffDataTable(this.staffEmails, {Key? key}) : super(key: key);
  final List<BaseStaffEmail> staffEmails;

  String getRegisteredWithAt(
    DateTime? userCreatedAt,
    BuildContext context,
  ) {
    return userCreatedAt != null
        ? '${DateFormat.yMd(context.locale.countryCode).format(userCreatedAt.toLocal())} '
            '- ${DateFormat.jm(context.locale.countryCode).format(userCreatedAt.toLocal())}'
        : context.localizations!.notUsed;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: DataTable(
        // defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        // horizontalMargin: 6,
        // dataRowHeight: ,
        border: TableBorder.symmetric(
          inside: BorderSide(
            color: context.isDarkMode ? Colors.white12 : Colors.grey.shade100,
          ),
        ),
        // columnWidths: {4: fluent_ui.FractionColumnWidth(.1)},
        // headingRowColor: MaterialStateProperty.resolveWith((states) {
        //   if (states.contains(MaterialState.hovered)) {
        //     return context.fluentTheme.accentColor.lighter;
        //   }
        //   return context.colorScheme.primaryContainer;
        // }),
        // source: DataTableSource(),
        columns: [
          DataColumn(
            label: Text(
              context.localizations!.email,
            ),
          ),
          DataColumn(
            label: Text(
              context.localizations!.assignedRole,
            ),
          ),
          DataColumn(
            label: Text(
              context.localizations!.registeredWithAt,
            ),
          ),
          DataColumn(
            label: Text(
              context.localizations!.name,
            ),
          ),
          DataColumn(
            label: Text(
              context.localizations!.options,
            ),
          ),
        ],
        rows: staffEmails
            .map((e) => DataRow(
                  onSelectChanged: (selected) {},
                  cells: [
                    DataCell(Text(e.email), showEditIcon: true),
                    DataCell(Text(e.userRole.name), showEditIcon: true),
                    DataCell(
                        Text(getRegisteredWithAt(e.user?.createdAt, context))),
                    DataCell(Text(
                      e.user?.name ?? context.localizations!.none,
                    )),
                    DataCell(
                      _StaffEmailOptions(e),
                    ),
                  ],
                ))
            .toList(),
        // children: [
        //   CustomTableRow(
        //     textStyle: context.textTheme.titleMedium?.copyWith(
        //       fontWeight: FontWeight.w400,
        //       color: context.colorScheme.onSecondaryContainer,
        //     ),
        //     childrenContent: [
        //       context.localizations!.email,
        //       context.localizations!.assignedRole,
        //       context.localizations!.registeredWithAt,
        //       context.localizations!.name,
        //       context.localizations!.options,
        //     ],
        //     padding: const EdgeInsets.symmetric(
        //       vertical: 16.0,
        //       horizontal: 14,
        //     ),
        //     decoration: BoxDecoration(
        //       color: context.isDarkMode
        //           ? context.colorScheme.secondaryContainer
        //           : context.colorScheme.primaryContainer,
        //       borderRadius: const BorderRadius.only(
        //         topLeft: Radius.circular(8),
        //         topRight: Radius.circular(8),
        //       ),
        //     ),
        //   ),
        //   ...staffEmails
        //       .map(
        //         (e) => CustomTableRow(
        //           childrenContent: [
        //             e.email,
        //             e.userRole.name,
        //             getRegisteredWithAt(e.user?.createdAt, context),
        //             e.user?.name ?? context.localizations!.none,
        //             _StaffEmailOptions(e),
        //           ],
        //           textStyle: context.textTheme.bodyLarge?.copyWith(
        //             fontWeight: FontWeight.w500,
        //             color: context.colorScheme.onPrimaryContainer,
        //           ),
        //           padding: const EdgeInsets.symmetric(
        //             vertical: 8.0,
        //             horizontal: 14,
        //           ),
        //         ),
        //       )
        //       .toList(),
        // ],
      ),
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
          // tooltipMessage: context.localizations!.edit,
          icon: Icon(Icons.edit),
          onPressed: () {},
        ),
        CustomIconButton(
          tooltipMessage: context.localizations!.delete,
          icon: Icon(
            Icons.delete,
            color: Colors.red.shade400,
          ),
          onPressed: () async {
            //TODO: IF DELETED STAFF EMAIL BELONGS TO A DENTIST,
            // ASK IF HIS PATIENTS SHOULD BE ASSIGNED TO ANOTHER ONE/OR CREATE
            // A NEW STAFF EMAIL BEFORE DELETING IF NO DENTIST ACCOUNTS FOUND
            final deleteConfirmed = await showAdaptiveAlertDialog<bool>(
              context: context,
              titleText: 'Delete staff email',
              confirmText: 'Delete',
              contentText:
                  'Are you sure to delete this staff email(${staffEmail.email})?'
                  '\nIf deleted, It wont be possible to login to the account associated with this email address.',
            );
            if (deleteConfirmed ?? false) {
              context
                  .read<StaffEmailsBloc>()
                  .add(DeleteStaffEmail(staffEmail.id));
            }
          },
        ),
      ],
    );
  }
}
