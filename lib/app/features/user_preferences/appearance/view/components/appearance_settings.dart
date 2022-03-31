import 'package:clinic_v2/app/common/widgets/components/section_card.dart';
//
import 'package:clinic_v2/app/base/responsive/responsive.dart';

import 'theme_settings.dart';

class AppearanceSettingsScreen extends Component {
  const AppearanceSettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget builder(BuildContext context, contextInfo) {
    return ConstrainedBox(
      constraints: BoxConstraints.loose(contextInfo.widgetSize!),
      child: Column(
        children: [
          SectionCard(
            title: 'Theme',
            children: [
              ThemeSettings(),
            ],
          ),
        ],
      ),
    );
  }
}
