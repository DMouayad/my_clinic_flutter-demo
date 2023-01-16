import 'package:clinic_v2/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
//

import '../../../../presentation/views/appearance_settings/components/user_preferences_list_item.dart';

class UserPreferencesList extends StatelessWidget {
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
  final void Function(int tileIndex) onAppearanceTileTapped;
  final void Function(int tileIndex) onCalendarTileTapped;
  final void Function(int tileIndex)? onDentalServicesTileTapped;
  final bool showDentalServicesTile;
  final int selectedItemIndex;

  @override
  Widget build(BuildContext context) {
    final preferencesListData = [
      PreferencesListItemData(
        name: context.localizations!.calendar,
        icon: Icons.calendar_today_outlined,
        onSelected: onCalendarTileTapped,
      ),
      PreferencesListItemData(
        name: context.localizations!.appearance,
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
      children: preferencesListData
          .asMap()
          .entries
          .map((e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                child: UserPreferencesListItem(
                  index: e.key,
                  selected:
                      context.isMobile ? false : e.key == selectedItemIndex,
                  itemData: e.value,
                ),
              ))
          .toList(),
    );
  }
}
