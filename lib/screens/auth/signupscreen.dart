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
              validationFunction: (value){
                if (value == null || value.isEmpty)
                {
                return 'Please enter some text';
                }
                },
            ),
            FormInput(
              inputController: _emailController,
              labelText: 'Email',
              hintText: 'Enter your email',
              validationFunction: (value){
                if (value == null || value.isEmpty)
                {
                  return 'Please enter some text';
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
