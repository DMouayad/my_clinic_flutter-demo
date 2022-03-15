/// A library contains a group of custom widgets used across the app.
library components;

import 'package:clinic_v2/app/base/responsive/responsive.dart';

part 'src/app_name_text.dart';

//
/// Custom group of Simple [Component] used across the app screens.
///
/// every function returns a new instance of the [Component] widget.
class SimpleComponents {
  static Widget appNameText() {
    return _AppNameText();
  }
}
