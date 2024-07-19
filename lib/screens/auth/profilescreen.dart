import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/badroute.dart';
import '../../components/forminput.dart';
import '../../models/user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  User? currentUser;

  void _logout() {
    if (currentUser != null) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  void _update(String username, String firstname, String lastname,
      String mobileNumber, String country) {
    final user = Provider.of<User>(context, listen: false);
    print(user.users.length);
    if (currentUser != null) {
      user.updateUser(
        User(
            id: currentUser!.id,
            username: username,
            email: currentUser!.email,
            password: currentUser!.password,
            firstname: firstname,
            lastname: lastname,
            mobilenumber: mobileNumber,
            country: country,
            imageUrl: currentUser!.imageUrl),
      );
    }
    final newUser = Provider.of<User>(context,listen:false);
    for(final user in newUser.users){
      print(user.id);
      print(user.username);
      print(user.firstname);
      print(user.lastname);
      print(user.mobilenumber);
      print(user.country);
      print(user.imageUrl);
    }
  }

  @override
  void initState() {
    super.initState();
    try {
      currentUser = Provider.of<User>(context, listen: false).users.last;
      print(Provider.of<User>(context, listen: false).users.length);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return currentUser == null
        ? const BadRoute()
        : Scaffold(
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    child: Container(
                      margin: const EdgeInsets.all(30.0),
                      child: Consumer<User>(
                        builder: (context, user, child) {
                          final currentUserId = user.users.last.id;
                          var currentUsername = user.users.last.username;
                          var currentUserFirstname = user.users.last.firstname;
                          var currentUserLastname = user.users.last.lastname;
                          var currentUserMobileNumber= user.users.last.mobilenumber;
                          var currentUserCountry = user.users.last.country;
                          final currentUserImageUrl = user.users.last.imageUrl;
                          for(final newuser in user.users){
                            print(newuser.id);
                            print(newuser.username);
                            print(newuser.firstname);
                            print(newuser.lastname);
                            print(newuser.mobilenumber);
                            print(newuser.country);
                            print(newuser.imageUrl);
                          }

                          return Column(
                            children: [
                              Text('user: ${user.users.last.username}'),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: Text(
                                  'Profile',
                                  style: GoogleFonts.lato(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .displayLarge,
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
                                    size: 192,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                ),
                              ),
                              FormInput(
                                initialValue: currentUsername,
                                onChangedFunction: (value)=> currentUsername = value!,
                                labelText: 'Username',
                                hintText: user.users.isNotEmpty
                                    ? user.users.last.username
                                    : 'Enter your username',
                                validationFunction: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "please enter your username";
                                  }
                                  return null;
                                },
                                obscureText: false,
                              ),
                              FormInput(
                                initialValue: currentUserFirstname,
                                onChangedFunction: (value)=>currentUserFirstname=value!,
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
                                initialValue: currentUserLastname,
                                onChangedFunction: (value)=>currentUserLastname=value!,
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
                                initialValue: currentUserMobileNumber,
                                onChangedFunction: (value)=>currentUserMobileNumber =value!,
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
                                initialValue: currentUserCountry,
                                onChangedFunction: (value)=>currentUserCountry=value!,
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 24.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Validate will return true if the form is valid, or false if
                                    // the form is invalid.
                                    if (_formKey.currentState!.validate()) {
                                      // Process data.
                                      _update(currentUsername, currentUserFirstname, currentUserLastname, currentUserMobileNumber, currentUserCountry);
                                    }
                                  },
                                  child: const Text('Update'),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 24.0),
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: Text(
                                              'This button below will log you out of your account.'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            _logout();
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
                                      const Text(
                                          'The button below permanently deletes your account and all your data will be lost.'
                                          'If you are sure you want to delete your account press the button below.'),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 24.0),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors
                                                .red, // Set the background color to red
                                            foregroundColor: Colors.black,
                                          ),
                                          onPressed: () {},
                                          child: const Text('Delete Account'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
