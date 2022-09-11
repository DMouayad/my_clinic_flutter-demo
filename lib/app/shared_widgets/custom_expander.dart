import 'package:fluent_ui/fluent_ui.dart';

/// The expander direction
enum CustomExpanderDirection {
  /// Whether the [Expander] expands down
  down,

  /// Whether the [Expander] expands up
  up,

  /// Whether the [Expander] expands towards the left
  left,

  /// Whether the [Expander] expands towards the right
  right,
}

/// The [Expander] control lets you show or hide less important content
/// that's related to a piece of primary content that's always visible.
/// Items contained in the Header are always visible. The user can expand
/// and collapse the Content area, where secondary content is displayed,
/// by interacting with the header. When the content area is expanded,
/// it pushes other UI elements out of the way; it does not overlay other
/// UI. The Expander can expand upwards or downwards.
///
/// Both the Header and Content areas can contain any content, from simple
/// text to complex UI layouts. For example, you can use the control to show
/// additional options for an item.
///
/// ![Expander Preview](https://docs.microsoft.com/en-us/windows/apps/design/controls/images/expander-default.gif)
///
/// See also:
///
///  * <https://docs.microsoft.com/en-us/windows/apps/design/controls/expander>
class CustomExpander extends StatefulWidget {
  /// Creates an expander
  const CustomExpander({
    Key? key,
    this.leading,
    this.header,
    required this.content,
    this.icon,
    this.trailing,
    this.animationCurve,
    this.animationDuration,
    this.direction = CustomExpanderDirection.down,
    this.initiallyExpanded = false,
    this.onStateChanged,
    this.headerHeight = 48.0,
    this.contentHeight = 48.0,
    this.expanderWidth = 200.0,
    this.contentWidth = 200.0,
    this.headerBackgroundColor,
    this.contentBackgroundColor,
  }) : super(key: key);

  /// The leading widget.
  ///
  /// See also:
  ///
  ///  * [Icon]
  ///  * [RadioButton]
  ///  * [Checkbox]
  final Widget? leading;

  /// The expander header
  ///
  /// Usually a [Text]
  final Widget? header;

  /// The expander content
  ///
  /// You can use complex, interactive UI as the content of the
  /// Expander, including nested Expander controls in the content
  /// of a parent Expander as shown here.
  ///
  /// ![Expander Nested Content](https://docs.microsoft.com/en-us/windows/apps/design/controls/images/expander-nested.png)
  final Widget content;

  /// The icon of the toggle button.
  final Widget? icon;

  /// The trailing widget. It's positioned at the right of [header]
  /// and at the left of [icon].
  ///
  /// See also:
  ///
  ///  * [ToggleSwitch]
  final Widget? trailing;

  /// The expand-collapse animation duration. If null, defaults to
  /// [FluentTheme.fastAnimationDuration]
  final Duration? animationDuration;

  /// The expand-collapse animation curve. If null, defaults to
  /// [FluentTheme.animationCurve]
  final Curve? animationCurve;

  /// The expand direction. Defaults to [ExpanderDirection.down]
  final CustomExpanderDirection direction;

  /// Whether the [Expander] is initially expanded. Defaults to `false`
  final bool initiallyExpanded;

  /// A callback called when the current state is changed. `true` when
  /// open and `false` when closed.
  final ValueChanged<bool>? onStateChanged;

  /// The height of the header.
  ///
  /// Defaults to 48.0
  final double headerHeight;
  final double contentHeight;

  /// The background color of the header.
  final ButtonState<Color>? headerBackgroundColor;

  /// The content color of the header
  final Color? contentBackgroundColor;

  /// Defaults to 200.0
  final double expanderWidth;
  final double contentWidth;
  @override
  CustomExpanderState createState() => CustomExpanderState();
}

class CustomExpanderState extends State<CustomExpander>
    with SingleTickerProviderStateMixin {
  late ThemeData _theme;

  bool? _open;
  bool get open => _open ?? false;
  set open(bool value) {
    if (_open != value) _handlePressed();
  }

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration ?? const Duration(milliseconds: 150),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _theme = FluentTheme.of(context);
    if (_open == null) {
      _open = !widget.initiallyExpanded;
      open = widget.initiallyExpanded;
    }
  }

  void _handlePressed() {
    if (open) {
      _controller.animateTo(
        0.0,
        duration: widget.animationDuration ?? _theme.fastAnimationDuration,
        curve: widget.animationCurve ?? _theme.animationCurve,
      );
      _open = false;
    } else {
      _controller.animateTo(
        1.0,
        duration: widget.animationDuration ?? _theme.fastAnimationDuration,
        curve: widget.animationCurve ?? _theme.animationCurve,
      );
      _open = true;
    }
    widget.onStateChanged?.call(open);
    if (mounted) setState(() {});
  }

  bool get _isDown => widget.direction == CustomExpanderDirection.down;
  bool get _isVerticalExpander =>
      widget.direction == CustomExpanderDirection.down ||
      widget.direction == CustomExpanderDirection.up;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  static Color backgroundColor(ThemeData style, Set<ButtonStates> states) {
    if (style.brightness == Brightness.light) {
      if (states.isDisabled) return style.disabledColor;
      if (states.isPressing) return const Color(0xFFf9f9f9).withOpacity(0.2);
      if (states.isHovering) return const Color(0xFFf9f9f9).withOpacity(0.4);
      return Colors.white.withOpacity(0.7);
    } else {
      if (states.isDisabled) return style.disabledColor;
      if (states.isPressing) return Colors.white.withOpacity(0.03);
      if (states.isHovering) return Colors.white.withOpacity(0.082);
      return Colors.white.withOpacity(0.05);
    }
  }

  static Color borderColor(ThemeData style, Set<ButtonStates> states) {
    if (style.brightness == Brightness.light) {
      if (states.isHovering && !states.isPressing) {
        return const Color(0xFF212121).withOpacity(0.22);
      }
      return const Color(0xFF212121).withOpacity(0.17);
    } else {
      if (states.isPressing) return Colors.white.withOpacity(0.062);
      if (states.isHovering) return Colors.white.withOpacity(0.02);
      return Colors.black.withOpacity(0.52);
    }
  }

  static const double borderSize = 0.5;
  static final Color darkBorderColor = Colors.black.withOpacity(0.8);

  static const Duration expanderAnimationDuration = Duration(milliseconds: 70);

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasFluentTheme(context));
    final children = [
      Expanded(
        // flex: 0,
        child: HoverButton(
          onPressed: _handlePressed,
          builder: (context, states) {
            return AnimatedContainer(
              duration: expanderAnimationDuration,
              height: widget.headerHeight,

              width: widget.expanderWidth,

              decoration: BoxDecoration(
                color: widget.headerBackgroundColor?.resolve(states) ??
                    backgroundColor(_theme, states),
                border: Border.all(
                  width: borderSize,
                  color: borderColor(_theme, states),
                ),
                borderRadius: BorderRadius.vertical(
                  top: const Radius.circular(4.0),
                  bottom: Radius.circular(open ? 0.0 : 4.0),
                ),
              ),
              // padding: const EdgeInsetsDirectional.only(start: 16.0),
              alignment: AlignmentDirectional.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.leading != null)
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 10.0),
                      child: widget.leading!,
                    ),
                  if (widget.header != null) Expanded(child: widget.header!),
                  if (widget.trailing != null)
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 20.0),
                      child: widget.trailing!,
                    ),
                  Container(
                    // padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    alignment: Alignment.center,
                    child: widget.icon ??
                        RotationTransition(
                          turns: Tween<double>(begin: 0, end: 0.5)
                              .animate(_controller),
                          child: Icon(
                            _isDown
                                ? FluentIcons.chevron_down
                                : FluentIcons.chevron_up,
                            size: 10,
                          ),
                        ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      Expanded(
        // flex: 0,
        child: SizeTransition(
          sizeFactor: _controller,
          child: Container(
            width: widget.contentWidth,
            height: widget.contentHeight,
            // alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                width: borderSize,
                color: borderColor(_theme, {ButtonStates.none}),
              ),
              color: widget.contentBackgroundColor ??
                  backgroundColor(_theme, {ButtonStates.none}),
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(4.0)),
            ),
            child: widget.content,
          ),
        ),
      ),
    ];
    return ConstrainedBox(
      constraints: BoxConstraints.loose(
        Size(
          widget.expanderWidth +
              (_isVerticalExpander ? 0 : widget.contentWidth),
          widget.headerHeight + widget.contentHeight,
        ),
      ),
      child: Flex(
        direction: _isVerticalExpander ? Axis.vertical : Axis.horizontal,
        mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.end,
        children: _isDown ? children : children.reversed.toList(),
      ),
    );
  }
}
