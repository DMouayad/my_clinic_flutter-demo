import 'package:clinic_v2/presentation/shared_widgets/material_with_utils.dart';
import 'package:clinic_v2/presentation/themes/material_themes.dart';
import 'package:flutter/services.dart';

class InputTextField extends StatefulWidget {
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
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  bool? inputIsValid;
  final _errorSuffixIcon = const Icon(Icons.error_outline, color: Colors.red);

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
        textDirection: widget.textDirection,
        maxLength: widget.maxLength,
        controller: widget.controller,
        key: widget.formKey,
        initialValue: widget.initialValue,
        validator: widget.validator,
        onChanged: (value) {
          if (widget.validator != null) {
            setState(() {
              inputIsValid = widget.validator!(value) == null;
            });
          }
        },
        onSaved: widget.onSaved,
        obscureText: widget.obscure,
        cursorColor: widget.cursorColor,
        keyboardType: widget.keyboardType,
        onEditingComplete: widget.onEditingComplete,
        inputFormatters: widget.inputFormatters,
        textInputAction: widget.textInputAction,
        style: widget.textStyle ?? context.textTheme.bodyLarge,
        autovalidateMode:
            widget.autovalidateMode ?? AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          isDense: widget.isDense,
          filled: widget.filled,
          fillColor: Colors.transparent,
          // fillColor: fillColor ?? AppColorScheme.of(context).primaryContainer,
          // hoverColor ?? AppColorScheme.of(context).secondaryContainer,
          suffixIcon: widget.suffixIcon ??
              ((inputIsValid ?? true) ? null : _errorSuffixIcon),
          suffixIconColor: widget.suffixIconColor,
          prefixIcon: Icon(
            widget.prefixIcon,
            // color: prefixIconColor ?? Get.theme.colorScheme.secondary,
          ),
          hintText: widget.hintText,
          hintStyle: context.textTheme.bodyMedium?.copyWith(
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
          errorStyle: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.errorColor!,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
