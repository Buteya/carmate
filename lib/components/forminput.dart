import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  const FormInput({
    super.key,
    required this.obscureText,
    required this.labelText,
    required this.hintText,
    required this.validationFunction,
    required TextEditingController inputController,
  }) : _usernameController = inputController;

  final TextEditingController _usernameController;
  final String? labelText;
  final String? hintText;
  final Function validationFunction;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: _usernameController,
      decoration:  InputDecoration(
        labelText: labelText,
        hintText: hintText,
      ),
      validator: (String? value) {

        return null;
      },
    );
  }
}
