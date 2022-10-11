import 'package:data_table_2/data_table_2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
//
import 'package:clinic_v2/app/blocs/staff_bloc/staff_bloc.dart';
//
import 'package:clinic_v2/app/core/entities/paginated_data/src/paginated_resource.dart';
import 'package:clinic_v2/app/features/staff_member/domain/base_staff_member.dart';
import 'package:clinic_v2/app/shared_widgets/color_barrier.dart';
import 'package:clinic_v2/app/shared_widgets/custom_buttons/custom_icon_button.dart';
import 'package:clinic_v2/app/shared_widgets/custom_dialogs/show_alert_dialog.dart';
import 'package:clinic_v2/app/shared_widgets/material_with_utils.dart';

import 'add_staff_member_button.dart';
import 'custom_dialogs.dart';

class StaffDataTable extends StatefulWidget {
  const StaffDataTable({
    required this.dataResource,
    required this.onItemsPerPageChanged,
    required this.onPageChanged,
    required this.existingEmailsList,
    required this.onSort,
    Key? key,
  }) : super(key: key);

  final Future<PaginatedResource<BaseStaffMember>> dataResource;
  final void Function(int nextPageFirstIndex) onPageChanged;
  final void Function(int? rowsCount) onItemsPerPageChanged;
  final List<String> existingEmailsList;
  final void Function(List<String> sortedBy) onSort;
  @override
  State<StaffDataTable> createState() => _StaffDataTableState();
}

class _StaffDataTableState extends State<StaffDataTable> {
  bool _sortAscending = true;

  int _sortColumnIndex = 0;
  void sort(int index, bool ascending) {
    _sortColumnIndex = index;
    _sortAscending = !_sortAscending;
    String columnName = "";
    switch (index) {
      case 0:
        columnName = 'email';
        break;
      case 1:
        columnName = 'role';
        break;
      case 2:
        columnName = 'registered_with_at';
        break;
      case 3:
        columnName = 'registration_name';
        break;
    }
    columnName = (_sortAscending ? '+' : '-') + columnName;
    widget.onSort([columnName]);
  }

  @override
  Widget build(BuildContext context) {
    return BuilderWithWidgetInfo(
      builder: (context, widgetInfo) {
        return FutureBuilder(
          future: widget.dataResource,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox.shrink();
            }
            final itemsPerPage = snapshot.data!.paginationInfo.perPage;
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
                child: AsyncPaginatedDataTable2(
                  pageSyncApproach: PageSyncApproach.goToFirst,
                  wrapInCard: false,
                  minWidth: 900,
                  lmRatio: 1.4,
                  headingRowColor: MaterialStateProperty.all(
                    context.colorScheme.primaryContainer,
                  ),
                  actions: [
                    AddStaffMemberButton(
                      parentWidgetSize: widgetInfo.widgetSize,
                      existingStaffMembers: widget.existingEmailsList,
                    ),
                  ],
                  header: const _TableHeader(),
                  rowsPerPage: itemsPerPage,
                  availableRowsPerPage: [
                    itemsPerPage,
                    itemsPerPage * 2,
                    itemsPerPage * 5,
                    itemsPerPage * 50,
                  ],
                  onPageChanged: widget.onPageChanged,
                  onRowsPerPageChanged: widget.onItemsPerPageChanged,
                  sortColumnIndex: _sortColumnIndex,
                  sortAscending: _sortAscending,
                  source: StaffMembersDataSource(context, widget.dataResource),
                  border: TableBorder.symmetric(
                    inside: BorderSide(
                      color: context.isDarkMode
                          ? Colors.white12
                          : Colors.blueGrey.shade50,
                    ),
                  ),
                  loading: const _TableLoadingWidget(),
                  columns: [
                    DataColumn2(
                      size: ColumnSize.L,
                      label: Text(context.localizations!.email),
                      onSort: (index, ascending) => sort(index, ascending),
                    ),
                    DataColumn2(
                      label: Text(context.localizations!.assignedRole),
                      onSort: (index, ascending) => sort(index, ascending),
                    ),
                    DataColumn2(
                      label: Text(context.localizations!.registeredWithAt),
                      onSort: (index, ascending) => sort(index, ascending),
                    ),
                    DataColumn2(
                      label: Text(context.localizations!.registrationName),
                      onSort: (index, ascending) => sort(index, ascending),
                    ),
                    DataColumn2(
                      size: ColumnSize.S,
                      label: Text(context.localizations!.options),
                      onSort: (index, ascending) => sort(index, ascending),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _TableLoadingWidget extends StatelessWidget {
  const _TableLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const BlurredColorBarrier(),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: SizedBox(
            width: 100,
            height: 22,
            child: LinearProgressIndicator(
              color: context.colorScheme.primary,
              backgroundColor: context.colorScheme.surface,
            ),
          ),
        ),
      ],
    );
  }
}

class _TableHeader extends StatelessWidget {
  const _TableHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Tooltip(
          message: context.localizations!.staffMembersTableDescription,
          child: const Icon(Icons.info_outline),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
          ),
        ),
      ],
    );
  }
}

class StaffMembersDataSource extends AsyncDataTableSource {
  StaffMembersDataSource(
    this.context,
    this.dataResource,
  );
  Future<PaginatedResource<BaseStaffMember>> dataResource;
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
      style: context.textTheme.titleSmall?.copyWith(
        color: context.colorScheme.onBackground,
        fontWeight: FontWeight.w500,
      ),
    ));
  }

  @override
  Future<AsyncRowsResponse> getRows(int start, int end) async {
    final resource = await dataResource;
    // await Future.delayed(Duration(milliseconds: 200));
    return AsyncRowsResponse(
      resource.paginationInfo.total,
      resource.data.map((e) {
        return DataRow(
          color: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.hovered)) {
              return context.colorScheme.surface;
            }
            return context.colorScheme.backgroundColor;
          }),
          cells: [
            _customCell(e.email),
            _customCell(e.userRole.name),
            _customCell(
              getRegisteredWithAt(e.user?.createdAt, context),
            ),
            _customCell(
              e.user?.name ?? '-',
            ),
            DataCell(_StaffMemberOptions(
              e,
              resource.data.map((e) => e.email).toList(),
            )),
          ],
        );
      }).toList(),
    );
  }
}

class _StaffMemberOptions extends StatelessWidget {
  const _StaffMemberOptions(
    this.staffMember,
    this.existingStaffMembers, {
    Key? key,
  }) : super(key: key);

  final BaseStaffMember staffMember;
  final List<String> existingStaffMembers;

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
            showWindowsEditStaffMemberDialog(
              context,
              staffMember: staffMember,
              existingStaffMembers: existingStaffMembers,
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
              titleText: context.localizations!.deleteStaffMemberDialogTitle,
              confirmText: context.localizations!.delete,
              contentText: context.localizations!.deleteStaffMemberDialogContent
                  .replaceFirst('toDelete', staffMember.email),
            );
            if (deleteConfirmed ?? false) {
              context.read<StaffBloc>().add(DeleteStaffMember(staffMember.id));
            }
          },
        ),
      ],
    );
  }
}
