import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../components/badroute.dart';
import '../../components/customtitle.dart';
import '../../components/forminput.dart';
import '../../components/myappdrawer.dart';
import '../../models/user.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({super.key});

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  User? currentUser;
  String? imageAvailable = '';
  String? carImage = '';
  bool _isLoading = false;
  bool _carImagePicked = true;
  final uuid = const Uuid();

  @override
  void initState() {
    try {
      currentUser = Provider.of<User>(context, listen: false).users.last;
      print(Provider.of<User>(context, listen: false).users.length);
    } catch (e) {
      print(e.toString());
    }
    super.initState();
  }

  @override
  void dispose() {
     _usernameController.dispose();
     _firstnameController.dispose();
     _lastnameController.dispose();
     _emailController.dispose();
     _mobileNumberController.dispose();
     _countryController.dispose();
     _passwordController.dispose();
    super.dispose();
  }

  void _addUser() {
    final users = Provider.of<User>(context, listen: false);
    final id = uuid.v4();
    final encodedPassword = base64.encode(utf8.encode(_passwordController.text));
    if (currentUser?.id != null) {
      users.add(User(
        id: id,
        username: _usernameController.text,
        email: _emailController.text,
        password: encodedPassword,
        firstname: _firstnameController.text,
        lastname: _lastnameController.text,
        mobileNumber: _mobileNumberController.text,
        country: _countryController.text,
        imageUrl: carImage!,
      ));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.deepPurple,
          content: Text(
            'User $id has been added successfully!!!',
            style: GoogleFonts.roboto(
              fontSize: 17,
              color: Colors.white,
            ),
          ),
        ),
      );
      setState(() {
        carImage = '';
      });
    } else {
      print('no current user');
    }
    for (final user in users.users) {
      print(user.id);
      print(user.username);
      print(user.firstname);
      print(user.lastname);
      print(user.email);
      print(user.mobileNumber);
      print(user.country);
      print(user.password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return currentUser == null
        ? const BadRoute()
        : _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: const CustomTitle(
                    color: Colors.deepPurpleAccent,
                  ),
                ),
                drawer: Drawer(
                  child: MyAppDrawer(
                      imageAvailable: imageAvailable,
                      currentUser: currentUser,
                      mounted: mounted),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: Text(
                                'Add New User',
                                style: GoogleFonts.lato(
                                  textStyle:
                                      Theme.of(context).textTheme.displayLarge,
                                  fontSize: 48,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'Create a new user product, with the required details captured. '
                                'Ensuring all the fields are filled and with the proper appropriate details.',
                                style: GoogleFonts.roboto(
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Card(
                                child: carImage!.isEmpty
                                    ? const Icon(
                                        Icons.image_rounded,
                                        size: 60,
                                      )
                                    : ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(12.0),
                                        ),
                                        child: Image.network(carImage!)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  final pickedImage = await ImagePicker()
                                      .pickImage(source: ImageSource.gallery);
                                  if (pickedImage != null) {
                                    setState(() {
                                      print(pickedImage.name);
                                      print(pickedImage.path);
                                      carImage = pickedImage.path;
                                      print(carImage);
                                    });
                                    for (final user in currentUser!.users) {
                                      print('image ${user.imageUrl}');
                                    }
                                  } else {
                                    // Handle the case where the user canceled image selection
                                    // (e.g., show a message or revert to a default image)
                                  }
                                },
                                label: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("pick Image"),
                                    Icon(Icons.camera),
                                  ],
                                ),
                              ),
                            ),
                            _carImagePicked == false
                                ? const Text(
                                    'please pick car image',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.red,
                                    ),
                                  )
                                : const SizedBox(),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  FormInput(
                                    onChangedFunction: (value) =>
                                        _usernameController.text = value!,
                                    labelText: 'Username',
                                    hintText: 'Enter a username',
                                    validationFunction: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "please enter a username";
                                      }
                                      return null;
                                    },
                                    obscureText: false,
                                  ),
                                  FormInput(
                                    onChangedFunction: (value) =>
                                        _firstnameController.text = value!,
                                    labelText: 'Firstname',
                                    hintText: 'Enter a firstname',
                                    validationFunction: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "please enter a firstname";
                                      }
                                      return null;
                                    },
                                    obscureText: false,
                                  ),
                                  FormInput(
                                    onChangedFunction: (value) =>
                                        _lastnameController.text = value!,
                                    labelText: 'Lastname',
                                    hintText: 'Enter a lastname',
                                    validationFunction: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "please enter a lastname";
                                      }
                                      return null;
                                    },
                                    obscureText: false,
                                  ),
                                  FormInput(
                                    onChangedFunction: (value) =>
                                        _emailController.text = value!,
                                    labelText: 'Email',
                                    hintText: 'Enter an email',
                                    validationFunction: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "please enter an email";
                                      }
                                      return null;
                                    },
                                    obscureText: false,
                                  ),
                                  FormInput(
                                    onChangedFunction: (value) =>
                                        _mobileNumberController.text = value!,
                                    labelText: 'Mobile Number',
                                    hintText: 'Enter a mobile number',
                                    validationFunction: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "please enter a mobile number";
                                      }
                                      return null;
                                    },
                                    obscureText: false,
                                  ),
                                  FormInput(
                                    onChangedFunction: (value) =>
                                        _countryController.text = value!,
                                    labelText: 'Country',
                                    hintText: 'Enter a country',
                                    validationFunction: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "please enter a country";
                                      }
                                      return null;
                                    },
                                    obscureText: false,
                                  ),
                                  FormInput(
                                    onChangedFunction: (value) =>
                                        _passwordController.text = value!,
                                    labelText: 'Password',
                                    hintText: 'Enter a password',
                                    validationFunction: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "please enter a password";
                                      }else if (value.length < 8) {
                                        return "password must be at least 8 characters long";
                                      }
                                      return null;
                                    },
                                    obscureText: true,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        // Validate will return true if the form is valid, or false if
                                        // the form is invalid.
                                        if (_formKey.currentState!.validate() &&
                                            carImage!.isNotEmpty) {
                                          setState(() {
                                            _carImagePicked = true;
                                          });
                                          _addUser();
                                          _formKey.currentState?.reset();
                                        } else {
                                          setState(() {
                                            _carImagePicked = false;
                                          });
                                        }
                                      },
                                      label: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text('add user'),
                                          Icon(Icons.add)
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
