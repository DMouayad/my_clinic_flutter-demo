import 'package:clinic_v2/app/base/responsive/responsive.dart';

class UserPreferencesListItem extends StatelessWidget {
  final bool selected;
  final PreferencesListItemData itemData;
  final void Function() onTap;

  const UserPreferencesListItem({
    required this.selected,
    required this.itemData,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        selected: selected,
        leading: Icon(itemData.icon),
        title: Text(itemData.name),
        onTap: () {
          itemData.onSelected();
          onTap();
        });
  }
}

class PreferencesListItemData {
  final IconData icon;
  final String name;
  final void Function() onSelected;

  PreferencesListItemData({
    required this.icon,
    required this.name,
    required this.onSelected,
  });
}
