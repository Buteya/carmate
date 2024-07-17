import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/forminput.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  // final String _imageUrl = '';


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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        'Profile',
                        style: GoogleFonts.lato(
                          textStyle: Theme.of(context).textTheme.displayLarge,
                          fontSize: 48,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    const Card.filled(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.person,
                          size: 144,
                          color: Colors.deepPurpleAccent,
                        ),
                      ),
                    ),
                    FormInput(
                      inputController: _usernameController,
                      labelText: 'Username',
                      hintText: 'Enter your username',
                      validationFunction: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter your username";
                        }
                        return null;
                      },
                      obscureText: false,
                    ),
                    FormInput(
                      inputController: _firstnameController,
                      labelText: 'Firstname',
                      hintText: 'Enter your firstname',
                      validationFunction: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter your firstname";
                        }
                        return null;
                      },
                      obscureText: false,
                    ),
                    FormInput(
                      inputController: _lastnameController,
                      labelText: 'Lastname',
                      hintText: 'Enter your lastname',
                      validationFunction: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter your lastname";
                        }
                        return null;
                      },
                      obscureText: false,
                    ),
                    FormInput(
                      inputController: _mobileNumberController,
                      labelText: 'Mobile-Number',
                      hintText: 'Enter your mobile-number',
                      validationFunction: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter your mobile-number";
                        }
                        return null;
                      },
                      obscureText: false,
                    ),
                    FormInput(
                      inputController: _countryController,
                      labelText: 'Country',
                      hintText: 'Enter your country',
                      validationFunction: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter your country";
                        }
                        return null;
                      },
                      obscureText: false,
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
                        child: const Text('Update'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text('This button below will log you out of your account.'),
                              ),
                              ElevatedButton(
                                onPressed: () {

                                },
                                child: const Text('Logout'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                   Card(
                     child: Padding(
                       padding: const EdgeInsets.all(16.0),
                       child: Column(
                         children: [
                           const Text('The button below permanently deletes your account and all your data will be lost.'
                               'If you are sure you want to delete your account press the button below.'),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 24.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red, // Set the background color to red
                                  foregroundColor: Colors.black,
                                ),
                                onPressed: () {

                                },
                                child: const Text('Delete Account'),
                              ),
                            ),
                         ],
                       ),
                     ),
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
