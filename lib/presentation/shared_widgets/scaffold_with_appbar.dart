import 'package:flutter/material.dart';
//
import 'package:auto_size_text/auto_size_text.dart';
//
import 'package:clinic_v2/utils/extensions/context_extensions.dart';

import '../../presentation/shared_widgets/custom_buttons/custom_back_button.dart';

class ScaffoldWithAppBar extends StatelessWidget {
  const ScaffoldWithAppBar({
    this.showLeading = true,
    this.centerTitle = false,
    this.appBarBottom,
    this.floatingActionButton,
    this.actions,
    this.titleFontSize = 18,
    Key? key,
    this.titleText,
    this.title,
    this.appBarBackgroundColor,
    this.scaffoldBackgroundColor,
    this.persistentFooterButtons,
    this.appBarBorderRadius,
    this.titleFontColor,
    this.showLoadingIndicator = false,
    this.bodyWithSafeArea = true,
    this.leading,
    this.showBottomTitle = false,
    required this.body,
  })  : assert(title != null || titleText != null),
        super(key: key);

  final List<Widget>? actions;
  final PreferredSizeWidget? appBarBottom;
  final Widget body;
  final Widget? title;
  final Widget? floatingActionButton;
  final bool showLeading;
  final String? titleText;
  final double titleFontSize;
  final Color? appBarBackgroundColor;
  final Color? scaffoldBackgroundColor;
  final Color? titleFontColor;
  final bool centerTitle;
  final List<Widget>? persistentFooterButtons;
  final double? appBarBorderRadius;
  final bool bodyWithSafeArea;
  final bool showBottomTitle;
  final Widget? leading;

  /// when [true], this scaffold will be covered by a color-barrier with a
  /// progress indicator in the center
  final bool showLoadingIndicator;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor:
          scaffoldBackgroundColor ?? context.colorScheme.backgroundColor,
      floatingActionButton: floatingActionButton,
      persistentFooterButtons: persistentFooterButtons,
      appBar: AppBar(
        automaticallyImplyLeading: showLeading,
        leading: () {
          if (showLeading) {
            final hasRouteParent = Navigator.of(context).canPop();
            return leading ??
                (hasRouteParent ? const CustomBackButton() : null);
          }
        }(),
        backgroundColor:
            appBarBackgroundColor ?? context.colorScheme.backgroundColor,
        centerTitle: centerTitle,
        foregroundColor: context.colorScheme.onBackground,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(appBarBorderRadius ?? 0),
          ),
        ),
        leadingWidth: 48,
        title: () {
          if (!showBottomTitle) {
            return title ??
                Text(
                  titleText!,
                  style: context.textTheme.headline6?.copyWith(
                    fontSize: titleFontSize,
                    color: titleFontColor,
                    fontWeight: FontWeight.w600,
                  ),
                );
          }
        }(),
        actions: actions,
        bottom: showBottomTitle
            ? _AppBarBottomTitle(
                preferredSize: const Size(double.infinity, 50),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.horizontalMargins),
                  child: Row(
                    children: [
                      Flexible(
                        child: title ??
                            AutoSizeText(
                              titleText!,
                              textAlign: TextAlign.start,
                              style: context.textTheme.headline6?.copyWith(
                                fontSize: titleFontSize,
                                color: titleFontColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                      ),
                    ],
                  ),
                ),
              )
            : appBarBottom,
      ),
      body: bodyWithSafeArea ? SafeArea(child: body) : body,
    );
  }
}

class _AppBarBottomTitle extends PreferredSize {
  const _AppBarBottomTitle({required Widget child, required Size preferredSize})
      : super(child: child, preferredSize: preferredSize);
}
