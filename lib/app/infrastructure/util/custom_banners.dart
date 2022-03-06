// import 'package:app_settings/app_settings.dart';
// import 'package:clinic_v2/app/infrastructure/themes/app_color_scheme.dart';
// import 'package:flutter/material.dart';

// class CustomBanners {
//   static void showWarningBanner({
//     required String title,
//     String? msg,
//   }) {
//     SnackBar(
//       titleText: Text(
//         title.tr,
//         style: Get.textTheme.subtitle2?.copyWith(
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//       messageText: Text(
//         msg?.tr ?? '',
//         style: Get.textTheme.bodyText2,
//       ),
//       icon: Icon(Icons.error, color: AppColorScheme.errorColor),
//       snackPosition: SnackPosition.TOP,
//       snackStyle: SnackStyle.FLOATING,
//       borderRadius: 4,
//       overlayBlur: 0,
//       forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
//       animationDuration: const Duration(milliseconds: 400),
//       duration: const Duration(seconds: 5),
//       backgroundColor: AppColorScheme.primaryContainer!,
//       margin: EdgeInsets.zero,
//     );
//   }

//   /// Custom "No Internet connection" banner with an option to open wifi settings
//   static void showNoInternetConnectionBanner(String message, {IconData? icon}) {
//     Get.snackbar(
//       '',
//       '',
//       snackPosition: SnackPosition.TOP,
//       margin: EdgeInsets.zero,
//       boxShadows: [
//         BoxShadow(
//             blurRadius: 1.5,
//             color: Get.isDarkMode ? Colors.white12 : Colors.grey.shade400),
//       ],
//       borderRadius: 4,
//       duration: const Duration(days: 1),
//       animationDuration: const Duration(milliseconds: 500),
//       backgroundColor: Get.isDarkMode ? const Color(0xFF3F4652) : Colors.white,
//       titleText: ListTile(
//         dense: true,
//         minVerticalPadding: 1,
//         leading: Icon(
//           icon,
//           color: Get.theme.colorScheme.error,
//         ),
//         title: Text(
//           message,
//           style: Get.textTheme.bodyText2,
//         ),
//       ),
//       messageText: ButtonBar(
//         children: [
//           TextButton(
//             onPressed: () => Get.back(),
//             child: Text('DISMISS'.tr),
//           ),
//           TextButton(
//             onPressed: () async {
//               AppSettings.openWIFISettings();
//               Get.back();
//             },
//             child: Text(
//               'OPEN WIFI SETTINGS'.tr,
//               style: Get.textTheme.bodyText2?.copyWith(
//                 color: Get.theme.colorScheme.secondary,
//                 fontSize: 12,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
