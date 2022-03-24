import 'package:clinic_v2/app/base/responsive/responsive.dart';

class InputTextField extends Component {
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
  final TextStyle? textStyle;
  final TextStyle? hintTextStyle;
  final Color? prefixIconColor;
  final Key? formKey;
  final bool isDense;
  final AutovalidateMode? autovalidateMode;
  final TextInputAction? textInputAction;

  InputTextField({
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
    this.textStyle,
    this.hintTextStyle,
    this.prefixIconColor,
    this.onChanged,
    this.formKey,
    this.isDense = false,
  }) : super(key: key);

  @override
  Widget builder(BuildContext context, ContextInfo contextInfo) {
    final kOutlinedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(contextInfo.isDesktop ? 8 : 14),
      borderSide:
          BorderSide(color: AppColorScheme.textFieldBorderColor(context)),
    );
    return SizedBox(
      width: contextInfo.widgetSize.width * .8,
      // height: context.isDesktop ? 55 : null,
      child: TextFormField(
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
        textInputAction: textInputAction,
        style: textStyle ?? context.textTheme.bodyText1,
        autovalidateMode: autovalidateMode,
        decoration: InputDecoration(
          isDense: isDense,
          filled: filled,
          fillColor: AppColorScheme.primaryContainer(context),
          prefixIcon: Icon(
            prefixIcon,
            // color: prefixIconColor ?? Get.theme.colorScheme.secondary,
          ),
          hintText: hintText,
          hintStyle: context.textTheme.bodyText1?.copyWith(
            color: AppColorScheme.onPrimaryContainer(context)?.withOpacity(.7),
          ),
          enabledBorder: kOutlinedBorder,
          focusedBorder: kOutlinedBorder.copyWith(
            borderSide: BorderSide(color: AppColorScheme.primary(context)!),
          ),
          errorBorder: kOutlinedBorder.copyWith(
            borderSide: BorderSide(color: AppColorScheme.errorColor(context)!),
          ),
          focusedErrorBorder: kOutlinedBorder,
          errorStyle: context.textTheme.bodyText2?.copyWith(
            color: AppColorScheme.errorColor(context)!,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
