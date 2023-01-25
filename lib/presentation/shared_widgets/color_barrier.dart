import 'package:animate_do/animate_do.dart';
import 'package:clinic_v2/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class BlurredColorBarrier extends StatelessWidget {
  const BlurredColorBarrier({
    this.child = const SizedBox.shrink(),
    Key? key,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      duration: const Duration(milliseconds: 400),
      child: Container(
        color: context.colorScheme.backgroundColor?.withOpacity(.5),
        // color: const Color(0xFF354c49).withOpacity(.5),
        child: GestureDetector(child: child),
      ),
    );
  }
}
