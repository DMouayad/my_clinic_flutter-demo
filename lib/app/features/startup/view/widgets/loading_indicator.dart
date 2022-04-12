import 'dart:math' as Math;

import 'package:clinic_v2/app/common/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatefulWidget {
  const LoadingIndicator({
    Key? key,
    this.currentDotColor,
    this.defaultDotColor,
    this.numDots = 8,
    this.size = 60,
    this.dotSize = 5,
    this.secondsPerRotation = 1,
  }) : super(key: key);

  final int numDots; //Number of dots around the dot circle
  final double size; //Width and height of the
  final double dotSize; //Diameter of each dot
  final int secondsPerRotation;
  final Color?
      currentDotColor; //The color of the dot that "circles" around the indicator
  final Color? defaultDotColor; //The color of the dots that aren't animated

  @override
  State<LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController animController;
  late Animation<int> animation;

  @override
  void initState() {
    super.initState();
    animController = AnimationController(
        duration: Duration(seconds: widget.secondsPerRotation), vsync: this)
      ..repeat();
    animation =
        StepTween(begin: 0, end: widget.numDots + 1).animate(animController)
          ..addListener(() {
            setState(() {});
          });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      // decoration: BoxDecoration(color: Colors.red), //for debugging purposes
      child: CustomPaint(
        child: Container(),
        painter: DottedCircularProgressIndicatorPainterFb(
            dotColor:
                widget.defaultDotColor ?? context.colorScheme.primaryContainer!,
            currentDotColor:
                widget.currentDotColor ?? context.colorScheme.secondary!,
            percentage: 0,
            numDots: widget.numDots,
            currentDotNum: animation.value,
            dotWidth: widget.dotSize),
      ),
    );
  }
}

class DottedCircularProgressIndicatorPainterFb extends CustomPainter {
  final double percentage;
  final Color dotColor;
  final Color currentDotColor;
  final int numDots;
  final int currentDotNum;
  final double dotWidth;

  DottedCircularProgressIndicatorPainterFb(
      {required this.dotColor,
      required this.currentDotColor,
      required this.percentage,
      required this.numDots,
      required this.dotWidth,
      required this.currentDotNum});

  @override
  void paint(Canvas canvas, Size size) {
    final double smallestSide = Math.min(size.width, size.height);
    final double radius = (smallestSide / 2 - dotWidth / 2) - dotWidth / 2;
    final Offset centerPoint = Offset(size.width / 2, size.height / 2);

    final dotPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = dotColor;

    Circle myCircle = Circle(radius: radius, totalNumOfDots: numDots);
    for (var i = 0; i < numDots; i++) {
      if (i == currentDotNum) {
        dotPaint.color = currentDotColor;
      } else {
        dotPaint.color = dotColor;
      }
      canvas.drawCircle(
          centerPoint - myCircle.calcDotOffsetFromCenter(i, radius),
          dotWidth,
          dotPaint);
    }
  }

  @override
  bool shouldRepaint(DottedCircularProgressIndicatorPainterFb oldDelegate) =>
      oldDelegate.currentDotNum != currentDotNum ? true : false;
}

//  Calculates the offst each dot based on the total number of dots
class Circle {
  int totalNumOfDots;
  double radius;

  Circle({required this.totalNumOfDots, required this.radius});

  Offset calcDotOffsetFromCenter(int dotNumber, double radius) {
    return Offset(_calcDotX(dotNumber), _calcDotY(dotNumber));
  }

  double _calcDotAngle(int currentDotNumber) {
    return -currentDotNumber * _calcRadiansPerDot();
  }

  double _calcRadiansPerDot() {
    return 2 * Math.pi / (totalNumOfDots);
  }

  double _calcDotX(int thisDotNum) {
    //offset from indicator circles center
    return radius * Math.sin(_calcDotAngle(thisDotNum));
  }

  double _calcDotY(int thisDotNum) {
    //offset from indicator circles center
    return radius * Math.cos(_calcDotAngle(thisDotNum));
  }
}
