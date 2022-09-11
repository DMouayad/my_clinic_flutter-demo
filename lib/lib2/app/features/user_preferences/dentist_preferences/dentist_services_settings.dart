import 'package:clinic_v2/app/shared_widgets/custom_widget/custom_widget.dart';
import 'package:clinic_v2/common/features/users/data/dentist_data.dart';

class DentalServicesSettings extends CustomStatelessWidget {
  const DentalServicesSettings({required this.onDentalServicesChange, Key? key})
      : super(key: key);
  final void Function(List<DentalService> dentalServices)
      onDentalServicesChange;
  @override
  Widget defaultBuilder(BuildContext context, ContextInfo contextInfo) {
    return Container();
  }
}
