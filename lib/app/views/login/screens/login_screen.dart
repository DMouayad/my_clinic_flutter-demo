import 'package:clinic_v2/app/shared_widgets/app_name_text.dart';
import 'package:clinic_v2/app/shared_widgets/custom_widget.dart';
import 'package:clinic_v2/app/shared_widgets/scaffold_with_appbar.dart';
//
import '../components/bloc_login_form.dart';
import '../components/login_message.dart';

class LoginScreen extends CustomStatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget customBuild(BuildContext context, widgetInfo) {
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
                height: widgetInfo.widgetSize.height * .1,
              ),
              const Center(
                child: BlocLoginForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
