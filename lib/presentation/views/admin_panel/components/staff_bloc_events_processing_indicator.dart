import 'package:clinic_v2/app/blocs/progress_indicator_bloc/progress_indicator_bloc.dart';
import 'package:clinic_v2/app/blocs/staff_bloc/staff_bloc.dart';
import 'package:clinic_v2/presentation/shared_widgets/material_with_utils.dart';
import 'package:clinic_v2/presentation/shared_widgets/windows_components/processing_indicator.dart';
import 'package:clinic_v2/shared/models/result/result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StaffBlocEventsProcessingIndicator extends StatelessWidget {
  const StaffBlocEventsProcessingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WindowsProcessingIndicator(
      status: context
          .read<StaffBloc>()
          .stream
          .takeWhile((state) =>
              state is StaffBlocErrorState || state is StaffBlocSuccess)
          .map<Result<VoidValue, BasicError>>((state) {
        if (state is StaffBlocSuccess) {
          return SuccessResult.voidResult();
        } else {
          return FailureResult(
            (state as StaffBlocErrorState).error,
          );
        }
      }),
      indicatorStatesText: _getProcessingStatesText(context),
      onTap: () {
        context
            .read<ProgressIndicatorBloc>()
            .add(const HideIndicatorRequested());
      },
    );
  }

  IndicatorStatesText _getProcessingStatesText(BuildContext context) {
    switch (context.read<StaffBloc>().state.runtimeType) {
      case AddingStaffMember:
        return const IndicatorStatesText(
          onProcessing: 'adding new staff member...',
          onSuccess: 'staff member was added successfully',
          onFailure: 'Failed to add staff member',
        );
      case DeletingStaffMember:
        return const IndicatorStatesText(
          onProcessing: 'Deleting staff member...',
          onSuccess: 'staff member was deleted successfully',
          onFailure: 'Failed to delete staff member',
        );
      case UpdatingStaffMember:
        return const IndicatorStatesText(
          onProcessing: 'Updating staff member...',
          onSuccess: 'staff member was updated successfully',
          onFailure: 'Failed to update staff member',
        );
      default:
        return const IndicatorStatesText(
          onProcessing: 'processing...',
          onSuccess: 'request was completed successfully',
          onFailure: 'Failed',
        );
    }
  }
}
