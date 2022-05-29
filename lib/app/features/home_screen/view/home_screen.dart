import 'package:clinic_v2/app/base/responsive/responsive.dart';

class HomeScreen extends ResponsiveStatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget mobileScreenBuilder(context, contextInfo) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
