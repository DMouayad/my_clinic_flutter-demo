import 'dart:async';

//
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';

//
import 'package:clinic_v2/presentation/shared_widgets/custom_buttons/custom_outlined_button.dart';
import 'package:clinic_v2/presentation/shared_widgets/error_card.dart';
import 'package:clinic_v2/presentation/shared_widgets/loading_indicator.dart';
import 'package:clinic_v2/shared/models/api_request_metadata.dart';
import 'package:clinic_v2/shared/models/error/basic_error.dart';
import 'package:clinic_v2/domain/staff_member/base/base_staff_member.dart';
import 'package:clinic_v2/shared/models/paginated_api_resource/paginated_api_resource.dart';
import 'package:clinic_v2/app/blocs/staff_bloc/staff_bloc.dart';
import 'package:clinic_v2/presentation/shared_widgets/material_with_utils.dart';

import 'staff_table.dart';

class StaffManagementScreen extends StatefulWidget {
  const StaffManagementScreen({Key? key}) : super(key: key);

  @override
  State<StaffManagementScreen> createState() => _StaffManagementScreenState();
}

class _StaffManagementScreenState extends State<StaffManagementScreen> {
  PaginatedResource<BaseStaffMember>? staffMembersResource;
  int currentPage = 1;
  int perPage = PaginatedDataTable.defaultRowsPerPage;
  List<String>? sortedBy;

  @override
  void initState() {
    super.initState();
  }

  void _onPageChanged(int nextPageFirstIndex) {
    currentPage = (nextPageFirstIndex ~/ perPage) + 1;
    if (staffMembersResource != null) {
      final dataCanBeFilledInOnePage =
          staffMembersResource!.paginationInfo.total <= perPage;
      if (!dataCanBeFilledInOnePage) {
        context.read<StaffBloc>().add(FetchStaffMembers(
              metadata: ApiRequestMetadata(
                page: currentPage,
                sortedBy: sortedBy,
                perPage: perPage,
              ),
            ));
      }
    }
  }

  Future<void> _fetchAfterDeletingItem() async {
    // After staffMembersResource been updated,
    if (staffMembersResource!.data.isEmpty) {
      // No actions needed - first page will be fetched by [AsyncPaginatedDataTable2]
      return;
    }

    if (!staffMembersResource!.paginationInfo.isAtLastPage) {
      context.read<StaffBloc>().add(
            FetchStaffMembers.withMeta(
              page: currentPage,
              sortedBy: sortedBy,
              perPage: perPage,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StaffBloc, StaffBlocState>(
      listener: ((context, state) {
        if (state is StaffMemberWasDeleted) {
          _fetchAfterDeletingItem();
        }
      }),
      buildWhen: (prev, next) =>
          next is StaffMembersWereLoaded ||
          next is LoadingStaffMembers ||
          (next is StaffBlocErrorState && prev is LoadingStaffMembers),
      builder: (context, state) {
        if (state is StaffMembersWereLoaded) {
          staffMembersResource = state.staffMembers;
          perPage = staffMembersResource!.paginationInfo.perPage;
        }
        if (state is StaffBlocErrorState && staffMembersResource == null) {
          return _ErrorFetchingStaffMembersWidget(state.error);
        } else if (staffMembersResource != null) {
          return Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: [
              FadeInUp(
                from: 50,
                child: StaffDataTable(
                  dataResource: state is StaffMembersWereLoaded
                      ? Future.value(staffMembersResource!)
                      : Future.delayed(const Duration(milliseconds: 200),
                          () => staffMembersResource!),
                  onPageChanged: _onPageChanged,
                  onItemsPerPageChanged: (int? rowsCount) {
                    if (rowsCount != null &&
                        staffMembersResource!.paginationInfo.total >
                            staffMembersResource!.data.length) {
                      perPage = rowsCount;
                      context.read<StaffBloc>().add(FetchStaffMembers.withMeta(
                            sortedBy: sortedBy,
                            perPage: perPage,
                          ));
                    }
                  },
                  onSort: (sort) {
                    sortedBy = sort;
                    context.read<StaffBloc>().add(FetchStaffMembers.withMeta(
                          page: currentPage,
                          sortedBy: sortedBy,
                        ));
                  },
                ),
              ),
            ],
          );
        } else {
          return const LoadingIndicator();
        }
      },
    );
  }
}

class _ErrorFetchingStaffMembersWidget extends StatelessWidget {
  final AppError error;

  const _ErrorFetchingStaffMembersWidget(this.error);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ErrorCard(
          errorText:
              "Failed to load staff members list.\n${error.appException?.getMessage(context)}",
        ),
        const SizedBox(height: 30),
        CustomOutlinedButton(
          label: context.localizations!.retry,
          iconData: Icons.refresh,
          onPressed: () {
            context.read<StaffBloc>().add(const FetchStaffMembers());
          },
        ),
      ],
    );
  }
}
