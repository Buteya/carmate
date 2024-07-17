import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  const FormInput({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.validationFunction,
    required TextEditingController inputController,
  }) : _usernameController = inputController;

  final TextEditingController _usernameController;
  final String? labelText;
  final String? hintText;
  final Function validationFunction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
