import 'package:clinic_v2/app/base/responsive/responsive.dart';

class HomeScreen extends ResponsiveScreen {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget mobile(context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
