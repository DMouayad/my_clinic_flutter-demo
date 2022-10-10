import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
import 'package:flutter_bloc/flutter_bloc.dart';
//
import 'package:clinic_v2/app/core/entities/paginated_data/src/paginated_resource.dart';
import 'package:clinic_v2/app/features/staff_email/domain/src/base_staff_email.dart';
import 'package:clinic_v2/app/shared_widgets/color_barrier.dart';
import 'package:clinic_v2/app/blocs/staff_emails_bloc/staff_emails_bloc.dart';
import 'package:clinic_v2/app/shared_widgets/material_with_utils.dart';

import 'staff_emails_table.dart';

class AccountsManagementWindowsScreen extends fluent_ui.StatefulWidget {
  const AccountsManagementWindowsScreen({Key? key}) : super(key: key);

  @override
  fluent_ui.State<AccountsManagementWindowsScreen> createState() =>
      _AccountsManagementWindowsScreenState();
}

class _AccountsManagementWindowsScreenState
    extends fluent_ui.State<AccountsManagementWindowsScreen> {
  PaginatedResource<BaseStaffEmail>? staffEmailsResource;

  void _onPageChanged(int nextPageFirstIndex) {
    if (staffEmailsResource != null &&
        (nextPageFirstIndex + 1) != staffEmailsResource!.paginationInfo.to) {
      final dataFillsOnlyOnePage = staffEmailsResource!.paginationInfo.total ==
          staffEmailsResource!.data.length;
      if (!dataFillsOnlyOnePage) {
        final newPage = staffEmailsResource!.paginationInfo.currentPage +
            ((nextPageFirstIndex + 1) > staffEmailsResource!.paginationInfo.from
                ? 1
                : -1);
        context.read<StaffEmailsBloc>().add(FetchStaffEmails(newPage));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return fluent_ui.ScaffoldPage(
      padding: EdgeInsets.zero,
      content: BlocBuilder<StaffEmailsBloc, StaffEmailsState>(
        builder: (context, state) {
          if (state is StaffEmailsWereLoaded) {
            staffEmailsResource = state.staffEmails;
          }
          return Stack(
            fit: StackFit.expand,
            children: [
              if (staffEmailsResource != null)
                FadeInUp(
                  from: 50,
                  child: StaffDataTable(
                    dataResource: Future.sync(() => staffEmailsResource!),
                    onPageChanged: _onPageChanged,
                    existingEmailsList:
                        staffEmailsResource!.data.map((e) => e.email).toList(),
                    onItemsPerPageChanged: (int? rowsCount) {},
                  ),
                ),
              if (state is StaffEmailErrorState)
                Card(
                  child: Text(state.error.toString()),
                )
              else if (state is! StaffEmailsWereLoaded &&
                  state is! StaffEmailsSuccess) ...[
                const BlurredColorBarrier(),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: fluent_ui.SizedBox(
                    width: 100,
                    height: 22,
                    child: LinearProgressIndicator(
                      color: context.colorScheme.primary,
                      backgroundColor: context.colorScheme.surface,
                    ),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
