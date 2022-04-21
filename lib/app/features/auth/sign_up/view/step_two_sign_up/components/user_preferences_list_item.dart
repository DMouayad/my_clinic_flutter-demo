import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;

class UserPreferencesListItem extends Component {
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
  Widget? windowsDesktopBuilder(BuildContext context, ContextInfo contextInfo) {
    if (!contextInfo.isMobile || !contextInfo.isPortraitTablet) {
      return fluent_ui.TappableListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 1.0,
        ),
        onTap: () {
          itemData.onSelected();
          onTap();
        },
        tileColor: fluent_ui.ButtonState.resolveWith(
          (states) => states.isHovering
              // ? const Color(0xFFF6F6F6).withOpacity(.12)
              ? context.colorScheme.onPrimaryContainer!
                  .withOpacity(context.isDarkMode ? .08 : .066)
              : Colors.transparent,
        ),
        leading: Icon(
          itemData.icon,
          color: selected
              ? context.colorScheme.primary
              : context.colorScheme.onPrimaryContainer,
          size: contextInfo.isTablet ? 24 : 26,
        ),
        title: Text(
          itemData.name,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: selected
                ? context.colorScheme.primary
                : context.colorScheme.onPrimaryContainer,
          ),
        ),
      );
    }
    return null;
  }

  @override
  Widget builder(BuildContext context, contextInfo) {
    return ListTile(
        horizontalTitleGap: contextInfo.isTablet ? 8 : null,
        selectedColor: context.colorScheme.primary,
        selected: selected,
        dense: false,
        leading: Icon(
          itemData.icon,
        ),
        title: Text(
          itemData.name,
          style: context.textTheme.subtitle1?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: contextInfo.isTablet ? 14 : null,
          ),
        ),
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
