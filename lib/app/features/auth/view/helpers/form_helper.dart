import 'package:flutter/material.dart';

class FormHelper {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _passwordController;
  late final TextEditingController _usernameController;
  late final TextEditingController? _emailController;

  TextEditingController get passwordController => _passwordController;
  TextEditingController get usernameController => _usernameController;
  TextEditingController? get emailController => _emailController;
  GlobalKey<FormState> get formKey => _formKey;

  FormHelper({required bool isLoginForm}) {
    _formKey = GlobalKey();
    _passwordController = TextEditingController();
    _usernameController = TextEditingController();
    if (!isLoginForm) {
      _emailController = TextEditingController();
    }
  }

  bool get inputIsValid {
    return _passwordController.text.isNotEmpty &&
        // (_emailController?.text.isNotEmpty ?? true) &&
        _usernameController.text.isNotEmpty;
  }

  void validateInput() {
    _formKey.currentState?.validate();
  }

  void saveFormState() => _formKey.currentState?.save();

  void dispose() {
    _passwordController.dispose();
    _usernameController.dispose();
    // _emailController?.dispose();
  }
}
