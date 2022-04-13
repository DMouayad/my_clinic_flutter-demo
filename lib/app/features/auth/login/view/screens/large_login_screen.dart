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
  Widget tabletBuilder(BuildContext context, ContextInfo contextInfo) {
    if (contextInfo.isTablet && contextInfo.isLandscapeMode) return Scaffold();
    return builder(context, contextInfo);
  }

  @override
  Widget builder(BuildContext context, ContextInfo contextInfo) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return TwoSidesScreenLayout(
          leftSideAnimation: animation,
          rightSideBlurred: state is LoginInProgress,
          leftSide: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.horizontalMargins,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                LoginMessage(),
                Center(child: LoginForm()),
              ],
            ),
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
                const Align(
                  alignment: Alignment.topRight,
                  child: AppearanceSettingsBar(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
