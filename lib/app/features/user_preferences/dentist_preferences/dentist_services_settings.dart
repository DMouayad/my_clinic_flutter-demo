import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/core/features/users/data/dentist_data.dart';

class DentalServicesSettings extends ResponsiveStatelessWidget {
  const DentalServicesSettings({required this.onDentalServicesChange, Key? key})
      : super(key: key);
  final void Function(List<DentalService> dentalServices)
      onDentalServicesChange;
  @override
  Widget defaultBuilder(BuildContext context, ContextInfo contextInfo) {
    return Container();
  }
}
