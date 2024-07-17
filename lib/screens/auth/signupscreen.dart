import 'package:flutter/material.dart';

import '../../components/forminput.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            FormInput(
              inputController: _usernameController,
              labelText: 'Username',
              hintText: 'Enter your username',
              validationFunction: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
              },
              obscureText: false,
            ),
            FormInput(
              inputController: _emailController,
              labelText: 'Email',
              hintText: 'Enter your email',
              validationFunction: (value) {
                if (value == null || value.isEmpty) {
                  return "please enter your email";
                } else if (!value.contains("@")) {
                  return "please enter a valid email";
                }
              },
              obscureText: false,
            ),
            FormInput(
              obscureText: false,
              labelText: 'Password',
              hintText: 'Enter your password',
              validationFunction: (value) {
                if (value == null || value.isEmpty) {
                  return "please enter your password";
                } else if (value.length < 8) {
                  return "password must be at least 8 characters long";
                }
              },
              inputController: _passwordController,
            ),
            ElevatedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState!.validate()) {
                  // Process data.
                }
              },
              child: const Text('Signup'),
            ),
          ],
        ),
      ),
    );
  }
}
