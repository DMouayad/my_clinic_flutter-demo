import 'package:flutter/material.dart';

import '../loading_indicator.dart';
import 'adaptive_dialog.dart';

Future<T?> showAdaptiveProgressDialog<T>({
  required BuildContext context,
  Widget? content,
  String? contentText,
  bool useRootNavigator = true,
}) async {
  return await showDialog(
    context: context,
    barrierDismissible: false,
    useRootNavigator: useRootNavigator,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => true,
        child: AdaptiveDialog(
          type: DialogType.progress,
          titleText: contentText,
          content: const Center(child: LoadingIndicator()),
        ),
      );
    },
  );
}
