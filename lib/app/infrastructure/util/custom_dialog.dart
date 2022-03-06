// import 'package:clinic_v2/app/common/widgets/custom_buttons/custom_filled_button.dart';
// import 'package:clinic_v2/app/infrastructure/themes/app_color_scheme.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_utils/src/extensions/internacionalization.dart';

// import 'package:get/route_manager.dart';

// mixin CustomDialog {
//   static Future<void> showConfirmDialog({
//     required String title,
//     required String content,
//     required String confirmText,
//     required String cancelText,
//     required void Function()? onConfirm,
//   }) async {
//     await Get.defaultDialog(
//       title: title.tr,
//       titleStyle: Get.textTheme.subtitle1,
//       content: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Text(
//           content.tr,
//           style: Get.textTheme.bodyText2,
//         ),
//       ),
//       backgroundColor: Get.theme.scaffoldBackgroundColor,
//       textConfirm: confirmText.tr,
//       textCancel: cancelText.tr,
//       confirm: CustomFilledButton(
//         label: confirmText,
//         onPressed: onConfirm,
//         iconData: Icons.delete_forever,
//         labelColor: AppColorScheme.onError,
//         backgroundColor: AppColorScheme.errorColor,
//       ),
//       cancel: CustomFilledButton(
//         label: cancelText,
//         onPressed: () => Get.back(),
//         iconData: Icons.navigate_before,
//       ),
//     );
//   }
// }
