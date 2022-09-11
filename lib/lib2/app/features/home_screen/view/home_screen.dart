import 'package:clinic_v2/app/shared_widgets/custom_widget/custom_widget.dart';

class HomeScreen extends CustomStatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget mobileScreenBuilder(context, contextInfo) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
