import 'package:clinic_v2/utils/extensions/context_extensions.dart';
import 'package:clinic_v2/utils/extensions/string_extensions.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';

class FormHelper {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _passwordController;
  late final TextEditingController? _usernameController;
  late final TextEditingController? _emailController;
  late final TextEditingController? _phoneNoController;

  TextEditingController get passwordController => _passwordController;
  TextEditingController? get usernameController => _usernameController;
  TextEditingController? get emailController => _emailController;
  TextEditingController? get phoneNoController => _phoneNoController;
  GlobalKey<FormState> get formKey => _formKey;

  FormHelper({required bool isLoginForm}) {
    _formKey = GlobalKey();
    _passwordController = TextEditingController();

    if (isLoginForm) {
      _emailController = TextEditingController();
      _usernameController = null;
      _phoneNoController = null;
    } else {
      _emailController = TextEditingController();
      _usernameController = TextEditingController();
      final translator = {
        '#': RegExp(r'[0-9]{0,3}'),
      };

      _phoneNoController = MaskedTextController(
          mask: '+(###) - # ### ### ###', translator: translator)
        ..text = '+(963) ';
    }
  }

  String? passwordValidator(String? password, BuildContext context) {
    if (password?.isEmpty ?? true) {
      return context.localizations?.passwordIsRequired;
    } else if (password!.length < 8) {
      return context.localizations!.passwordIsTooShort;
    }
    return null;
  }

  String? emailValidator(String? value, BuildContext context) {
    if (value?.isEmpty ?? false) {
      return context.localizations?.emailIsRequired;
    }
    if ((value?.isNotEmpty ?? false) && !value!.isValidEmail) {
      return context.localizations?.emailInvalid;
    }
    return null;
  }

  String? usernameValidator(String? value, BuildContext context) {
    if (!usernameIsValid) {
      return context.localizations?.usernameIsRequired;
    }
    return null;
  }

  String? phoneNoValidator(String? value, BuildContext context) {
    if (value?.isEmpty ?? true) {
      return context.localizations?.phoneNoIsRequired;
    }

    if (!phoneNoIsValid) {
      return context.localizations?.invalidPhoneNo;
    }
    return null;
  }

  bool get emailIsValid {
    if (_emailController != null) {
      return _emailController!.text.isNotEmpty &&
          _emailController!.text.isValidEmail;
    }
    return true;
  }

  bool get usernameIsValid {
    return _usernameController?.text.isNotEmpty ?? true;
  }

  bool get passwordIsValid {
    return _passwordController.text.length >= 8;
  }

  bool get phoneNoIsValid {
    if (_phoneNoController?.text.isNotEmpty ?? false) {
      return _phoneNoController?.text.length == 22;
    }
    return true;
  }

  bool get inputIsValid {
    return usernameIsValid && emailIsValid && passwordIsValid && phoneNoIsValid;
  }

  void validateInput() {
    _formKey.currentState?.validate();
  }

  void saveFormState() => _formKey.currentState?.save();

  void dispose() {
    _passwordController.dispose();
    _usernameController?.dispose();
    _emailController?.dispose();
    _phoneNoController?.dispose();
  }
}
