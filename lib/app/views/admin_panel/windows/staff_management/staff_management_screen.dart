import 'dart:async';
//
import 'package:animate_do/animate_do.dart';
import 'package:clinic_v2/app/shared_widgets/loading_indicator.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
import 'package:flutter_bloc/flutter_bloc.dart';
//
import 'package:clinic_v2/app/features/staff_member/domain/base_staff_member.dart';
import 'package:clinic_v2/app/core/entities/paginated_data/src/paginated_resource.dart';
import 'package:clinic_v2/app/blocs/staff_bloc/staff_bloc.dart';
import 'package:clinic_v2/app/shared_widgets/material_with_utils.dart';

import 'staff_table.dart';

class StaffManagementWindowsScreen extends fluent_ui.StatefulWidget {
  const StaffManagementWindowsScreen({Key? key}) : super(key: key);

  @override
  fluent_ui.State<StaffManagementWindowsScreen> createState() =>
      _StaffManagementWindowsScreenState();
}

class _StaffManagementWindowsScreenState
    extends fluent_ui.State<StaffManagementWindowsScreen> {
  PaginatedResource<BaseStaffMember>? staffMembersResource;
  int currentPage = 1;
  int perPage = PaginatedDataTable.defaultRowsPerPage;

  void _onPageChanged(int nextPageFirstIndex) {
    currentPage = (nextPageFirstIndex ~/ perPage) + 1;
    if (staffMembersResource != null) {
      final dataCanBeFilledInOnePage =
          staffMembersResource!.paginationInfo.total <= perPage;
      if (!dataCanBeFilledInOnePage) {
        context.read<StaffBloc>().add(FetchStaffMembers(page: currentPage));
      }
    }
  }

  Future<void> _fetchAfterDeletingItem() async {
    // only fetch staff members after deleting an item if it's not the last item
    // in the page that was deleted
    if (staffMembersResource!.data.isNotEmpty &&
        !staffMembersResource!.paginationInfo.isAtLastPage) {
      context.read<StaffBloc>().add(FetchStaffMembers(page: currentPage));
    }
  }

  @override
  Widget build(BuildContext context) {
    return fluent_ui.ScaffoldPage(
      padding: EdgeInsets.zero,
      content: BlocConsumer<StaffBloc, StaffBlocState>(
        listener: ((context, state) {
          if (state is StaffMemberWasDeleted) {
            _fetchAfterDeletingItem();
          }
          if (state is StaffMembersWereLoaded) {
            staffMembersResource = state.staffMembers;
          }
        }),
        builder: (context, state) {
          return Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: [
              if (state is StaffBlocErrorState)
                Card(
                  child: Text(state.error.toString()),
                ),
              if (state is LoadingStaffMembers && staffMembersResource == null)
                const LoadingIndicator(),
              if (staffMembersResource != null)
                FadeInUp(
                  from: 50,
                  child: StaffDataTable(
                    dataResource: state is StaffMembersWereLoaded
                        ? Future.value(staffMembersResource!)
                        : Future.delayed(const Duration(seconds: 10),
                            () => staffMembersResource!),
                    onPageChanged: _onPageChanged,
                    existingEmailsList:
                        staffMembersResource!.data.map((e) => e.email).toList(),
                    onItemsPerPageChanged: (int? rowsCount) {},
                    onSort: (sortedBy) {
                      context.read<StaffBloc>().add(FetchStaffMembers(
                            page: currentPage,
                            sortedBy: sortedBy,
                          ));
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
