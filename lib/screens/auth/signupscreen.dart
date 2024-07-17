import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Card(
            child: Container(
              margin: EdgeInsets.all(30.0),
              child: Column(
                children: [
                  const Card.filled(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.car_rental_rounded,size: 96,color: Colors.deepPurpleAccent
                      ,),
                  ),),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'Signup',
                      style: GoogleFonts.lato(
                        textStyle: Theme.of(context).textTheme.displayLarge,
                        fontSize: 48,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'Welcome to carmate, an application that helps you get the car you need at the press of a button.',
                      style: GoogleFonts.roboto(
                        fontSize: 17,
                      ),
                    ),
                  ),
                  FormInput(
                    inputController: _usernameController,
                    labelText: 'Username',
                    hintText: 'Enter your username',
                    validationFunction: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a username';
                      }
                      return null;
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
                      return null;
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
                      return null;
                    },
                    inputController: _passwordController,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Validate will return true if the form is valid, or false if
                        // the form is invalid.
                        if (_formKey.currentState!.validate()) {
                          // Process data.
                        }
                      },
                      child: const Text('Signup'),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (mounted) {
                        Navigator.pushNamed(context, '/login');
                      }
                    },
                    child: const Text("already have an account? login here!!!"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
