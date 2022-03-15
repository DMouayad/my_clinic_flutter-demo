import 'package:flutter/material.dart';

mixin LoginScreenFormHelper {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _passwordController;
  late final TextEditingController _usernameController;

  TextEditingController get passwordController => _passwordController;
  TextEditingController get usernameController => _usernameController;
  GlobalKey<FormState> get formKey => _formKey;

  void initFormHelper() {
    _formKey = GlobalKey();
    _passwordController = TextEditingController();
    _usernameController = TextEditingController();
  }

  void validateInput() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
    }
  }

  bool get inputIsValid =>
      _passwordController.text.isNotEmpty &&
      _usernameController.text.isNotEmpty;

  void saveFormState() => _formKey.currentState?.save();

  void disposeFormHelper() {
    _passwordController.dispose();
    _usernameController.dispose();
  }
}
