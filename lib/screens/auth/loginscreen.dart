import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/forminput.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: Container(
                margin: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    const Card.filled(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.car_rental_rounded,
                          size: 96,
                          color: Colors.deepPurpleAccent,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        'Login',
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
                        'Welcome to Carmate',
                        style: GoogleFonts.roboto(
                          fontSize: 17,
                        ),
                      ),
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
                      obscureText: true,
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
                            if(mounted){
                              Navigator.pushReplacementNamed(context, '/profile');
                            }
                          }
                        },
                        child: const Text('Login'),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (mounted) {
                          Navigator.pushNamed(context, '/signup');
                        }
                      },
                      child:
                      const Text("don`t have an account? signup here!!!"),
                    ),
                    TextButton(
                      onPressed: () {
                        if (mounted) {
                          Navigator.pushNamed(context, '/passwordreset');
                        }
                      },
                      child:
                      const Text("forgot password?"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
