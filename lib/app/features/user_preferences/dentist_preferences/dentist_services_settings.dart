import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/core/features/users/data/dentist_data.dart';

class DentalServicesSettings extends Component {
  const DentalServicesSettings({required this.onDentalServicesChange, Key? key})
      : super(key: key);
  final void Function(List<DentalService> dentalServices)
      onDentalServicesChange;
  @override
  Widget builder(BuildContext context, ContextInfo contextInfo) {
    return Container();
  }
}
