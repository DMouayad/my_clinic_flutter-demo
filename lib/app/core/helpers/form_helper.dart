import 'package:clinic_v2/app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class FormHelper {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _passwordController;
  late final TextEditingController? _usernameController;
  late final TextEditingController? _emailController;

  TextEditingController get passwordController => _passwordController;
  TextEditingController? get usernameController => _usernameController;
  TextEditingController? get emailController => _emailController;
  GlobalKey<FormState> get formKey => _formKey;

  FormHelper({required bool isLoginForm}) {
    _formKey = GlobalKey();
    _passwordController = TextEditingController();

    if (isLoginForm) {
      _emailController = TextEditingController();
      _usernameController = null;
    } else {
      _emailController = TextEditingController();
      _usernameController = TextEditingController();
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

  bool get inputIsValid {
    bool isValid = _passwordController.text.length >= 6 &&
        (_usernameController?.text.isNotEmpty ?? true) &&
        (_emailController?.text.isValidEmail ?? true);
    if (_emailController != null) {
      isValid = isValid && (_emailController!.text.isNotEmpty);
    }
    return isValid;
  }

  void validateInput() {
    _formKey.currentState?.validate();
  }

  void saveFormState() => _formKey.currentState?.save();

  void dispose() {
    _passwordController.dispose();
    _usernameController?.dispose();
    _emailController?.dispose();
  }
}

extension EmailValidator on String {
  bool get isValidEmail {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
