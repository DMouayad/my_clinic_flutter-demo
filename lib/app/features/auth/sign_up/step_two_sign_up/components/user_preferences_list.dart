//
import 'package:clinic_v2/app/base/responsive/responsive.dart';

import 'user_preferences_list_item.dart';

class UserPreferencesList extends Component {
  const UserPreferencesList({
    this.selectedItemIndex = 0,
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
  final void Function(int tileIndex) onAppearanceTileTapped;
  final void Function(int tileIndex) onCalendarTileTapped;
  final void Function(int tileIndex)? onDentalServicesTileTapped;
  final bool showDentalServicesTile;
  final int selectedItemIndex;

  @override
  Widget builder(BuildContext context, contextInfo) {
    final _preferencesListData = [
      PreferencesListItemData(
        name: AppLocalizations.of(context)!.calendar,
        icon: Icons.calendar_today_outlined,
        onSelected: onCalendarTileTapped,
      ),
      PreferencesListItemData(
        name: AppLocalizations.of(context)!.appearance,
        icon: Icons.devices,
        onSelected: onAppearanceTileTapped,
      ),
      if (showDentalServicesTile)
        PreferencesListItemData(
          name: 'Dental services',
          // name: AppLocalizations.of(context)!.dentalServices,
          icon: Icons.medical_services_outlined,
          onSelected: onDentalServicesTileTapped!,
        ),
    ];
    return ListView(
      children: _preferencesListData
          .asMap()
          .entries
          .map((e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                child: UserPreferencesListItem(
                  index: e.key,
                  selected:
                      contextInfo.isMobile ? false : e.key == selectedItemIndex,
                  itemData: e.value,
                ),
              ))
          .toList(),
    );
  }
}
