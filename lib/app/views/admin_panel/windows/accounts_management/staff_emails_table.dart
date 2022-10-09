import 'package:data_table_2/data_table_2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
//
import 'package:clinic_v2/app/blocs/staff_emails_bloc/staff_emails_bloc.dart';
import 'package:clinic_v2/app/features/staff_email/domain/staff_email_domain.dart';
//
import 'package:clinic_v2/app/shared_widgets/custom_buttons/custom_icon_button.dart';
import 'package:clinic_v2/app/shared_widgets/custom_dialogs/show_alert_dialog.dart';
import 'package:clinic_v2/app/shared_widgets/material_with_utils.dart';

import 'add_staff_email_button.dart';
import 'staff_email_dialogs.dart';

class StaffDataTable extends StatelessWidget {
  const StaffDataTable({
    required this.paginatedStaffEmails,
    required this.onItemsPerPageChanged,
    required this.onPageChanged,
    required this.itemsPerPage,
    Key? key,
  }) : super(key: key);

  final List<BaseStaffEmail> paginatedStaffEmails;
  final void Function(int page) onPageChanged;
  final void Function(int? rowsCount) onItemsPerPageChanged;
  final int itemsPerPage;

  @override
  Widget build(BuildContext context) {
    return BuilderWithWidgetInfo(
      builder: (context, widgetInfo) {
        return SizedBox.expand(
          child: Material(
            elevation: 1,
            shadowColor: context.fluentTheme.shadowColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            type: MaterialType.card,
            color: context.isDarkMode
                ? context.colorScheme.secondaryContainer
                : context.colorScheme.surface,
            child: PaginatedDataTable2(
              wrapInCard: false,
              minWidth: 900,
              // smRatio: .5,
              lmRatio: 1.4,
              headingRowColor: MaterialStateProperty.all(
                context.colorScheme.primaryContainer,
              ),
              header: Text(
                context.localizations!.staffEmailsTableDescription,
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: context.colorScheme.onBackground,
                ),
              ),
              actions: [
                AddStaffEmailButton(
                  parentWidgetSize: widgetInfo.widgetSize,
                  existingStaffEmails:
                      paginatedStaffEmails.map((e) => e.email).toList(),
                ),
              ],
              rowsPerPage: itemsPerPage,
              onPageChanged: onPageChanged,
              onRowsPerPageChanged: onItemsPerPageChanged,
              source: StaffEmailsDataSource(
                paginatedStaffEmails,
                context,
              ),
              border: TableBorder.symmetric(
                inside: BorderSide(
                  color: context.isDarkMode
                      ? Colors.white12
                      : Colors.grey.shade100,
                ),
              ),
              columns: [
                DataColumn2(
                  size: ColumnSize.L,
                  label: Text(context.localizations!.email),
                ),
                DataColumn2(
                  // size: ColumnSize.S,
                  label: Text(context.localizations!.assignedRole),
                ),
                DataColumn2(
                  label: Text(context.localizations!.registeredWithAt),
                ),
                DataColumn2(
                  label: Text(context.localizations!.name),
                ),
                DataColumn2(
                  size: ColumnSize.S,
                  label: Text(context.localizations!.options),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class StaffEmailsDataSource extends DataTableSource {
  StaffEmailsDataSource(this.staffEmails, this.context);
  List<BaseStaffEmail> staffEmails;
  final BuildContext context;

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
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
  DataCell _customCell(String text) {
    return DataCell(Text(
      text,
      style: context.textTheme.titleMedium?.copyWith(
        color: context.colorScheme.onBackground,
        fontWeight: FontWeight.w500,
      ),
    ));
  }

  @override
  DataRow? getRow(int index) {
    return DataRow(
      color: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.hovered)) {
          return context.colorScheme.surface;
        }
        return context.colorScheme.backgroundColor;
      }),
      cells: [
        _customCell(staffEmails[index].email),
        _customCell(staffEmails[index].userRole.name),
        _customCell(
          getRegisteredWithAt(staffEmails[index].user?.createdAt, context),
        ),
        _customCell(
          staffEmails[index].user?.name ?? '-',
        ),
        DataCell(_StaffEmailOptions(
          staffEmails[index],
          staffEmails.map((e) => e.email).toList(),
        )),
      ],
    );
  }

  @override
  int get rowCount => staffEmails.length;
}

class _StaffEmailOptions extends StatelessWidget {
  const _StaffEmailOptions(this.staffEmail, this.existingStaffEmails,
      {Key? key})
      : super(key: key);

  final BaseStaffEmail staffEmail;
  final List<String> existingStaffEmails;
  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomIconButton(
          tooltipMessage: context.localizations!.edit,
          icon: Icon(
            Icons.edit_outlined,
            size: 18,
            color: context.colorScheme.onPrimaryContainer,
          ),
          onPressed: () {
            showWindowsEditStaffEmailDialog(
              context,
              staffEmail: staffEmail,
              existingStaffEmails: existingStaffEmails,
            );
          },
        ),
        CustomIconButton(
          tooltipMessage: context.localizations!.delete,
          icon: Icon(
            Icons.remove,
            color: Colors.red.shade400,
          ),
          onPressed: () async {
            //TODO: IF DELETED STAFF EMAIL BELONGS TO A DENTIST,
            // ASK IF HIS PATIENTS SHOULD BE ASSIGNED TO ANOTHER ONE/OR CREATE
            // A NEW STAFF EMAIL BEFORE DELETING IF NO DENTIST ACCOUNTS FOUND
            final deleteConfirmed = await showAdaptiveAlertDialog<bool>(
              context: context,
              titleText: context.localizations!.deleteStaffEmailDialogTitle,
              confirmText: context.localizations!.delete,
              contentText: context.localizations!.deleteStaffEmailDialogContent
                  .replaceFirst('toDelete', staffEmail.email),
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
