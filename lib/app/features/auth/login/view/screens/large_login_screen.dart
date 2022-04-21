import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/common/widgets/components/app_name_text.dart';
import 'package:clinic_v2/app/common/widgets/screens/two_sides_screen_layout.dart';
import 'package:clinic_v2/app/features/auth/auth_cubit/auth_cubit.dart';
import 'package:clinic_v2/app/common/widgets/components/appearance_settings_bar.dart';
import 'package:clinic_v2/app/features/auth/login/view/components/login_form.dart';
import 'package:clinic_v2/app/features/auth/login/view/components/login_message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LargeLoginScreen extends ResponsiveScreen {
  const LargeLoginScreen({required this.animation, Key? key}) : super(key: key);
  final Animation<double> animation;

  @override
  Widget builder(BuildContext context, ContextInfo contextInfo) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return TwoSidesScreenLayout(
          leftSideAnimation: animation,
          rightSideBlurred: state is LoginInProgress,
          leftSide: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.horizontalMargins,
                  vertical: context.height * .1,
                ),
                child: const LoginMessage(),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal:
                        contextInfo.isTablet ? 0 : context.horizontalMargins,
                  ),
                  child: const LoginForm(),
                ),
              ),
            ],
          ),
          rightSide: Hero(
            tag: 'appName',
            child: Stack(
              children: [
                Container(
                  constraints: const BoxConstraints.expand(),
                  color: context.colorScheme.primary,
                  alignment: Alignment.center,
                  child: AppNameText(
                    fontSize: 44,
                    fontColor: context.colorScheme.onPrimary,
                  ),
                ),
                if (contextInfo.isDesktopPlatform)
                  Align(
                    alignment: context.isArabicLocale
                        ? Alignment.topLeft
                        : Alignment.topRight,
                    child: const AppearanceSettingsBar(),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
