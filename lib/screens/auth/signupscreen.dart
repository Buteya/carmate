import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../components/forminput.dart';
import '../../models/user.dart';

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
  final uuid = const Uuid();

  void _signup(String username, String email, String password) async {
    final users = Provider.of<User>(context, listen: false);
    final encodedPassword = base64.encode(utf8.encode(password));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final id = uuid.v4();
    User? checkEmail;

    do {
      await prefs.setString('id', '$id');
      await prefs.setString('username', '$username');
      await prefs.setString('email', '$email');
      await prefs.setString('password', '$encodedPassword');
    }while (prefs.getString('id')!.isEmpty);

    users.add(
      User(
        id: id,
        username: username,
        email: email,
        password: encodedPassword,
        firstname: '',
        lastname: '',
        mobilenumber: '',
        country: '',
        imageUrl: '',
      ),
    );

    try {
      checkEmail = users.users.singleWhere((user) => user.email == email);
    } catch (e) {
      print(e.toString());
    }

    if (prefs.getString('email') == users.users[users.users.length - 1].email &&
        prefs.getString('password') ==
            users.users[users.users.length - 1].password &&
        checkEmail?.email == email &&
        checkEmail?.email == prefs.getString('email')) {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.deepPurple,
            content: Text(
              'Signup successful!!!',
              style: GoogleFonts.roboto(
                fontSize: 17,
                color: Colors.white,
              ),
            ),
          ),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.deepPurple,
            content: Text(
              'Signup failed, user already exists!!!',
              style: GoogleFonts.roboto(
                fontSize: 17,
                color: Colors.white,
              ),
            ),
          ),
        );
        if (users.users.length > 1) {
          users.removeUser(users.users.length - 1);
          print(users.users.length);
        }
        print(users.users.length);
      }

      print("Wrong username or password");
    }
    print("stored state users: ${users.users.length}");
    for (final user in users.users) {
      print("id: ${user.id}");
      print("username: ${user.username}");
      print("email: ${user.email}");
      print("password: ${user.password}");
    }
    print('SharedPreferences id:${prefs.getString('id')}');
    print('SharedPreferences username:${prefs.getString('username')}');
    print('SharedPreferences email:${prefs.getString('email')}');
    print('SharedPreferences password:${prefs.getString('password')}');
  }

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
                        'Welcome to Carmate, an application that helps you get the car you need at the press of a button.',
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
                            _signup(
                                _usernameController.text,
                                _emailController.text,
                                _passwordController.text);
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
                      child:
                          const Text("already have an account? login here!!!"),
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
