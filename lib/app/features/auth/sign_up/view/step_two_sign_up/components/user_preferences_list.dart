import 'package:clinic_v2/app/features/auth/sign_up/view/step_two_sign_up/components/user_preferences_list_item.dart';
//
import 'package:clinic_v2/app/base/responsive/responsive.dart';

class UserPreferencesList extends StatefulWidget {
  const UserPreferencesList({
    required this.onAppearanceTileTapped,
    required this.onCalendarTileTapped,
    required this.showDentalServicesTile,
    this.onDentalServicesTileTapped,
    Key? key,
  })  : assert(
          showDentalServicesTile ? onDentalServicesTileTapped != null : true,
        ),
        super(key: key);
  //
  final void Function() onAppearanceTileTapped;
  final void Function() onCalendarTileTapped;
  final void Function()? onDentalServicesTileTapped;
  final bool showDentalServicesTile;

  @override
  State<UserPreferencesList> createState() => _UserPreferencesListState();
}

class _UserPreferencesListState extends State<UserPreferencesList> {
  int selectedItemIndex = 0;
  @override
  Widget build(BuildContext context) {
    final _preferencesListData = [
      PreferencesListItemData(
        name: AppLocalizations.of(context)!.calendar,
        icon: Icons.calendar_today_outlined,
        onSelected: widget.onCalendarTileTapped,
      ),
      PreferencesListItemData(
        name: AppLocalizations.of(context)!.appearance,
        icon: Icons.devices,
        onSelected: widget.onAppearanceTileTapped,
      ),
      if (widget.showDentalServicesTile)
        PreferencesListItemData(
          name: 'Dental services',
          // name: AppLocalizations.of(context)!.dentalServices,
          icon: Icons.medical_services_outlined,
          onSelected: widget.onDentalServicesTileTapped!,
        ),
    ];
    return ListView(
      children: _preferencesListData
          .asMap()
          .entries
          .map((e) => UserPreferencesListItem(
                selected: e.key == selectedItemIndex,
                itemData: e.value,
                onTap: () {
                  if (selectedItemIndex != e.key) {
                    setState(() => selectedItemIndex = e.key);
                  }
                },
              ))
          .toList(),
    );
  }
}
