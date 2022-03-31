import 'package:clinic_v2/app/base/responsive/responsive.dart';

class UserPreferencesItem extends Component {
  final IconData icon;
  final String name;
  final void Function() onTap;

  const UserPreferencesItem({
    required this.icon,
    required this.name,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget builder(BuildContext context, ContextInfo contextInfo) {
    return ListTile(
      leading: Icon(icon),
      title: Text(name),
      onTap: onTap,
    );
  }
}
