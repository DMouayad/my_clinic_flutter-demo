import 'package:clinic_v2/app/shared_widgets/material_with_utils.dart';
import 'package:clinic_v2/app/themes/material_themes.dart';
import 'package:flutter/services.dart';

class InputTextField extends StatelessWidget {
  final String? initialValue;
  final String? hintText;
  final TextEditingController? controller;
  final Color cursorColor;
  final IconData? prefixIcon;
  final bool obscure;
  final TextInputType keyboardType;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final void Function()? onEditingComplete;
  final bool filled;
  final Color? fillColor;
  final Color? hoverColor;
  final TextStyle? textStyle;
  final TextStyle? hintTextStyle;
  final Color? prefixIconColor;
  final Color? suffixIconColor;
  final Key? formKey;
  final bool isDense;
  final AutovalidateMode? autovalidateMode;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final TextDirection? textDirection;
  const InputTextField({
    Key? key,
    this.hintText,
    this.validator,
    this.autovalidateMode,
    this.controller,
    this.onSaved,
    this.prefixIcon,
    this.textInputAction,
    this.obscure = false,
    this.cursorColor = Colors.black45,
    this.keyboardType = TextInputType.text,
    this.initialValue,
    this.onEditingComplete,
    this.filled = true,
    this.fillColor,
    this.textDirection,
    this.hoverColor,
    this.textStyle,
    this.hintTextStyle,
    this.prefixIconColor,
    this.onChanged,
    this.formKey,
    this.isDense = false,
    this.maxLength,
    this.suffixIcon,
    this.suffixIconColor,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final kOutlinedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(context.isDesktopPlatform ? 6 : 14),
      borderSide: BorderSide(
          color: context.isDesktopPlatform
              ? context.isDarkMode
                  ? context.fluentTheme.accentColor.light.withOpacity(.2)
                  : context.fluentTheme.accentColor.darkest.withOpacity(.2)
              : context.colorScheme.textFieldBorderColor),
    );
    return Theme(
      data: MaterialAppThemes.of(context),
      child: TextFormField(
        textDirection: textDirection,
        maxLength: maxLength,
        controller: controller,
        key: formKey,
        initialValue: initialValue,
        validator: validator,
        onChanged: onChanged,
        onSaved: onSaved,
        obscureText: obscure,
        cursorColor: cursorColor,
        keyboardType: keyboardType,
        onEditingComplete: onEditingComplete,
        inputFormatters: inputFormatters,
        textInputAction: textInputAction,
        style: textStyle ?? context.textTheme.bodyText1,
        autovalidateMode: autovalidateMode,
        decoration: InputDecoration(
          isDense: isDense,
          filled: filled,
          fillColor: Colors.transparent,
          // fillColor: fillColor ?? AppColorScheme.of(context).primaryContainer,
          // hoverColor ?? AppColorScheme.of(context).secondaryContainer,
          suffixIcon: suffixIcon,
          suffixIconColor: suffixIconColor,
          prefixIcon: Icon(
            prefixIcon,
            // color: prefixIconColor ?? Get.theme.colorScheme.secondary,
          ),
          hintText: hintText,
          hintStyle: context.textTheme.bodyText1?.copyWith(
            color: context.colorScheme.onPrimaryContainer?.withOpacity(.7),
          ),
          enabledBorder: kOutlinedBorder,
          focusedBorder: kOutlinedBorder.copyWith(
            borderSide: BorderSide(
              width: 1.5,
              color: context.isDesktopPlatform
                  ? context.fluentTheme.accentColor.dark
                  : context.colorScheme.primary!,
            ),
          ),
          errorBorder: kOutlinedBorder.copyWith(
            borderSide: BorderSide(color: context.colorScheme.errorColor!),
          ),
          focusedErrorBorder: kOutlinedBorder,
          errorStyle: context.textTheme.bodyText2?.copyWith(
            color: context.colorScheme.errorColor!,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
