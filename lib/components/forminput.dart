import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  const FormInput({
    super.key,
   this.obscureText,
    required this.labelText,
    required this.hintText,
      this.validationFunction,
   this.inputController,
    this.initialValue,
    this.onChangedFunction,
  });

  final TextEditingController? inputController;
  final String? labelText;
  final String? hintText;
  final String? Function(String?)? validationFunction;
   final bool? obscureText;
  final String? initialValue;
  final String? Function(String?)? onChangedFunction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChangedFunction,
      initialValue: initialValue,
      obscureText: obscureText!,
      controller: inputController,
      decoration:  InputDecoration(
        labelText: labelText,
        hintText: hintText,
      ),
      validator: validationFunction,
    );
  }
}
