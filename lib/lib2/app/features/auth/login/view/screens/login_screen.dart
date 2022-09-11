import 'package:clinic_v2/app/shared_widgets/app_name_text.dart';
import 'package:clinic_v2/app/shared_widgets/custom_widget/custom_widget.dart';
import 'package:clinic_v2/app/shared_widgets/scaffold_with_appbar.dart';

class LoginScreen extends CustomStatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget defaultBuilder(BuildContext context, ContextInfo contextInfo) {
    return ScaffoldWithAppBar(
      showLeading: false,
      title: AppNameText(
        fontColor: context.colorScheme.primary,
        fontSize: 32,
      ),
      appBarBackgroundColor: context.colorScheme.backgroundColor,
      centerTitle: true,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: context.horizontalMargins,
            vertical: 25,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: context.horizontalMargins),
                child: const LoginMessage(),
              ),
              SizedBox(
                height: contextInfo.widgetSize!.height * .1,
              ),
              const Center(child: LoginForm()),
            ],
          ),
        ),
      ),
    );
  }
}