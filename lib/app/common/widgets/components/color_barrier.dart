import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class BlurredColorBarrier extends StatelessWidget {
  const BlurredColorBarrier({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      duration: const Duration(milliseconds: 400),
      child: Container(
        color: const Color(0xFF354c49).withOpacity(.3),
        child: GestureDetector(),
      ),
    );
  }
}
