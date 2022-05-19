import 'package:clinic_v2/app/common/widgets/components/app_name_text.dart';
import 'package:clinic_v2/app/common/widgets/custom_buttons/custom_back_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
//
import 'package:clinic_v2/app/common/widgets/components/windows_components/custom_nav_view.dart';
import 'package:clinic_v2/app/features/auth/sign_up/view/step_two_sign_up/components/user_preferences_list_item.dart';
import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/common/widgets/components/scaffold_with_appbar.dart';
import 'package:clinic_v2/app/common/widgets/components/section_card.dart';
import 'package:clinic_v2/app/common/widgets/components/simple_card.dart';
import 'package:clinic_v2/app/features/auth/common/components/submit_button.dart';
import 'package:clinic_v2/app/features/auth/sign_up/cubit/sign_up_cubit.dart';
import 'package:clinic_v2/app/features/auth/sign_up/view/components/sign_up_components.dart';
import 'package:clinic_v2/app/features/auth/sign_up/view/step_two_sign_up/components/user_preferences_list.dart';
import 'package:clinic_v2/app/features/user_preferences/appearance/view/components/appearance_settings.dart';
import 'package:clinic_v2/core/common/utilities/enums.dart';
//
part 'tablet_screen.dart';
part 'desktop_screen.dart';

class LargeStepTwoSignUpScreen extends Component {
  const LargeStepTwoSignUpScreen({Key? key}) : super(key: key);

  @override
  Widget windowsDesktopBuilder(BuildContext context, ContextInfo contextInfo) {
    return const _DesktopStepTwoSignUpScreen();
  }

  @override
  Widget? tabletBuilder(BuildContext context, ContextInfo contextInfo) {
    return const _TabletStepTwoSignUpScreen();
  }
}
