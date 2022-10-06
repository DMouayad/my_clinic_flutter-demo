import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;

import '../material_with_utils.dart';

class IndicatorStatesText {
  const IndicatorStatesText({
    required this.onProcessing,
    required this.onSuccess,
    required this.onFailure,
  });

  final String onProcessing;
  final String onSuccess;
  final String onFailure;
}

class WindowsProcessingIndicator extends StatefulWidget {
  const WindowsProcessingIndicator({
    Key? key,
    required this.indicatorStatesText,
    required this.status,
  }) : super(key: key);

  final IndicatorStatesText indicatorStatesText;
  final Stream<Result<VoidValue, BasicError>> status;

  @override
  // ignore: library_private_types_in_public_api
  _WindowsProcessingIndicatorState createState() =>
      _WindowsProcessingIndicatorState();
}

class _WindowsProcessingIndicatorState extends State<WindowsProcessingIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();

    widget.status.listen((event) {
      _animationController.value = 0;
      _animationController.forward();
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Result>(
      stream: widget.status,
      builder: (context, snapshot) {
        IndicatorStatus indicatorStatus = !snapshot.hasData
            ? IndicatorStatus.processing
            : snapshot.data is SuccessResult
                ? IndicatorStatus.success
                : IndicatorStatus.failure;
        final child = _buildIndicator(context, indicatorStatus);
        return indicatorStatus == IndicatorStatus.success
            ? Bounce(
                from: 10,
                duration: const Duration(milliseconds: 500),
                child: child,
              )
            : SizeTransition(
                sizeFactor: Tween<double>(begin: 0, end: 1)
                    .chain(CurveTween(curve: Curves.easeInOut))
                    .animate(_animationController),
                axis: Axis.horizontal,
                child: child,
              );
      },
    );
  }

  Widget _buildIndicator(BuildContext context, IndicatorStatus status) {
    var textStyle = context.textTheme.bodyMedium?.copyWith(
      color: context.colorScheme.onBackground,
      fontWeight: FontWeight.w500,
      overflow: TextOverflow.ellipsis,
    );
    return AnimatedContainer(
      duration: const Duration(milliseconds: 700),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: () {
          return status == IndicatorStatus.processing
              ? context.colorScheme.primaryContainer!
              : status == IndicatorStatus.success
                  ? context.fluentTheme.accentColor.lighter
                  : fluent_ui.Colors.red.dark;
        }(),
      ),
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 0,
            child: SizedBox.square(
              dimension: 22,
              child: () {
                if (status != IndicatorStatus.processing) {
                  if (status == IndicatorStatus.success) {
                    return Icon(
                      Icons.check_circle,
                      color: context.colorScheme.onPrimary,
                      size: 24,
                    );
                  } else {
                    return Icon(
                      Icons.error_outline,
                      color: fluent_ui.Colors.red.light,
                      size: 24,
                    );
                  }
                }
                return const fluent_ui.ProgressRing(strokeWidth: 2);
              }(),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 0,
            child: () {
              if (status != IndicatorStatus.processing) {
                if (status == IndicatorStatus.success) {
                  textStyle = textStyle?.copyWith(
                    color: context.colorScheme.onPrimary,
                  );
                  return Text(
                    widget.indicatorStatesText.onSuccess,
                    softWrap: true,
                    style: textStyle,
                  );
                } else {
                  textStyle = textStyle?.copyWith(
                    color: context.colorScheme.onError,
                  );
                  return Text(
                    widget.indicatorStatesText.onFailure,
                    softWrap: true,
                    style: textStyle,
                  );
                }
              }
              return Text(
                widget.indicatorStatesText.onProcessing,
                softWrap: true,
                style: textStyle,
              );
            }(),
          ),
        ],
      ),
    );
  }
}

enum IndicatorStatus { processing, success, failure }
