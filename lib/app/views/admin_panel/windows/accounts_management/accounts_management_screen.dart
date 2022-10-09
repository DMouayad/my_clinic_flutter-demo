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
                StaffDataTable(
                  itemsPerPage: 10,
                  paginatedStaffEmails: staffEmailsResource!.data,
                  onPageChanged: (int page) {
                    if (staffEmailsResource != null &&
                        page !=
                            staffEmailsResource!.paginationInfo.currentPage) {
                      final dataFillsOnlyOnePage =
                          staffEmailsResource!.paginationInfo.total ==
                              staffEmailsResource!.data.length;
                      if (!dataFillsOnlyOnePage) {
                        print('fetch page items');
                      }
                    }
                  },
                  onItemsPerPageChanged: (int? rowsCount) {},
                ),
              if (state is! StaffEmailsWereLoaded) ...[
                ModalBarrier(dismissible: false),
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
              ]
            ],
          );
        },
      ),
    );
  }
}
