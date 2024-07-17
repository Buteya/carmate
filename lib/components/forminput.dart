import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  const FormInput({
    super.key,
    required this.obscureText,
    required this.labelText,
    required this.hintText,
    required this.validationFunction,
    required this.inputController,
  });

  final TextEditingController inputController;
  final String? labelText;
  final String? hintText;
  final String? Function(String?) validationFunction;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: inputController,
      decoration:  InputDecoration(
        labelText: labelText,
        hintText: hintText,
      ),
      validator: validationFunction,
    );
  }
}
