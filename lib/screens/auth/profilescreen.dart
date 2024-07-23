

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../components/badroute.dart';
import '../../components/customtitle.dart';
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
  bool _isLoading = false;
  String? imageAvailable = '';
  bool _imagePicked = true;

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

  void _logout() {
    setState(() {
      _isLoading = true;
    });
    if (currentUser != null) {
      setState(() {
        _isLoading = false;
      });
      Navigator.pushReplacementNamed(context, '/login');
    }
    print("called");
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.deepPurple,
          content: Text(
            'You`ve been logged out successfully!!!',
            style: GoogleFonts.roboto(
              fontSize: 17,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
  }

  void _update(
    String username,
    String firstname,
    String lastname,
    String mobileNumber,
    String country,
  ) {
    final user = Provider.of<User>(context, listen: false);

    setState(() {
      _isLoading = true;
    });
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
            imageUrl: imageAvailable!),
      );
    }
    final newUser = Provider.of<User>(context, listen: false);
    for (final user in newUser.users) {
      print(user.id);
      print(user.username);
      print(user.firstname);
      print(user.lastname);
      print(user.mobilenumber);
      print(user.country);
      print(user.imageUrl);
    }
    if (user.users.last.id == newUser.users.last.id) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.deepPurple,
            content: Text(
              'updated successfully!!!',
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
              'unable to update!!!',
              style: GoogleFonts.roboto(
                fontSize: 17,
                color: Colors.white,
              ),
            ),
          ),
        );
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _showDismissConfirmationDialog(
      BuildContext context,
      Function() function,
      String title,
      String content,
      String actionButtonText) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text(actionButtonText),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Perform the dismissal logic here
                function();
              },
            ),
          ],
        );
      },
    );
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
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      DrawerHeader(
                        decoration: const BoxDecoration(
                          color: Colors.deepPurpleAccent,
                        ),
                        child: Column(
                          children: [
                            const CustomTitle(
                              color: Colors.purple,
                            ),
                            CircleAvatar(
                              radius: 27,
                              child: imageAvailable!.isNotEmpty
                                  ? Container(
                                      width: 40, // Adjust the size as needed
                                      height: 40,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(imageAvailable!),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      width: 40, // Adjust the size as needed
                                      height: 40,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              currentUser!.imageUrl),
                                        ),
                                      ),
                                    ),
                            ),
                            Text(softWrap: true,
                                maxLines: 1,
                                'Welcome, ${currentUser!.username[0].toUpperCase() + currentUser!.username.substring(1).toLowerCase()}'),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                        ),
                        child: Text('Admin'),
                      ),
                      const Divider(
                        indent: 50.0,
                        color: Colors.black,
                        thickness: 1.0,
                        endIndent: 10,
                      ),
                      ListTile(
                        title: const Text('Create Product car'),
                        subtitle: const Text(
                            'Add a new car to the product cartlogue'),
                        trailing: const Icon(Icons.add_circle_rounded),
                        onTap: () {
                          // Handle item 1 tap
                          if (mounted) {
                            Navigator.pushReplacementNamed(
                                context, '/createproductcar');
                          }
                        },
                      ),
                      ListTile(
                        title: Text('Item 2'),
                        onTap: () {
                          // Handle item 2 tap
                        },
                      ),
                    ],
                  ),
                ),
                body: SingleChildScrollView(
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: [
                        //     CurrentUserCard(currentUser: currentUser, imageAvailable: imageAvailable),
                        //   ],
                        // ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Text(
                            'Profile',
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
                          padding:
                              const EdgeInsets.only(left: 50.0, right: 50.0),
                          child: Card.filled(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: imageAvailable!.isNotEmpty
                                  ? Image.network(imageAvailable!, height: 400)
                                  : currentUser!.imageUrl.isNotEmpty
                                      ? Image.network(currentUser!.imageUrl,
                                          height: 400)
                                      : const Icon(
                                          Icons.person_add_alt_rounded,
                                          size: 60,
                                        ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              final pickedImage = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);
                              if (pickedImage != null) {
                                setState(() {
                                  print(pickedImage.name);
                                  print(pickedImage.path);
                                  imageAvailable = pickedImage.path;
                                  print(imageAvailable);
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
                                Text("change Image"),
                                Icon(Icons.camera),
                              ],
                            ),
                          ),
                        ),
                        _imagePicked == false
                            ? const Text(
                                'you must pick an image',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                ),
                              )
                            : const SizedBox(),
                        Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Card(
                              child: Container(
                                margin: const EdgeInsets.all(30.0),
                                child: Consumer<User>(
                                  builder: (context, user, child) {
                                    var currentUsername =
                                        user.users.last.username;
                                    var currentUserFirstname =
                                        user.users.last.firstname;
                                    var currentUserLastname =
                                        user.users.last.lastname;
                                    var currentUserMobileNumber =
                                        user.users.last.mobilenumber;
                                    var currentUserCountry =
                                        user.users.last.country;
                                    for (final newuser in user.users) {
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
                                        FormInput(
                                          initialValue: currentUsername,
                                          onChangedFunction: (value) =>
                                              currentUsername = value!,
                                          labelText: 'Username',
                                          hintText: user.users.isNotEmpty
                                              ? user.users.last.username
                                              : 'Enter your username',
                                          validationFunction: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "please enter your username";
                                            }
                                            return null;
                                          },
                                          obscureText: false,
                                        ),
                                        FormInput(
                                          initialValue: currentUserFirstname,
                                          onChangedFunction: (value) =>
                                              currentUserFirstname = value!,
                                          labelText: 'Firstname',
                                          hintText: 'Enter your firstname',
                                          validationFunction: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "please enter your firstname";
                                            }
                                            return null;
                                          },
                                          obscureText: false,
                                        ),
                                        FormInput(
                                          initialValue: currentUserLastname,
                                          onChangedFunction: (value) =>
                                              currentUserLastname = value!,
                                          labelText: 'Lastname',
                                          hintText: 'Enter your lastname',
                                          validationFunction: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "please enter your lastname";
                                            }
                                            return null;
                                          },
                                          obscureText: false,
                                        ),
                                        FormInput(
                                          initialValue: currentUserMobileNumber,
                                          onChangedFunction: (value) =>
                                              currentUserMobileNumber = value!,
                                          labelText: 'Mobile-Number',
                                          hintText: 'Enter your mobile-number',
                                          validationFunction: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "please enter your mobile-number";
                                            }
                                            return null;
                                          },
                                          obscureText: false,
                                        ),
                                        FormInput(
                                          initialValue: currentUserCountry,
                                          onChangedFunction: (value) =>
                                              currentUserCountry = value!,
                                          labelText: 'Country',
                                          hintText: 'Enter your country',
                                          validationFunction: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "please enter your country";
                                            }
                                            return null;
                                          },
                                          obscureText: false,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 24.0),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              // Validate will return true if the form is valid, or false if
                                              // the form is invalid.
                                              if (_formKey.currentState!
                                                      .validate() &&
                                                  imageAvailable!.isNotEmpty || currentUser!.imageUrl.isNotEmpty) {
                                                setState(() {
                                                  _imagePicked = true;
                                                });
                                                // Process data.
                                                _update(
                                                  currentUsername,
                                                  currentUserFirstname,
                                                  currentUserLastname,
                                                  currentUserMobileNumber,
                                                  currentUserCountry,
                                                );
                                              } else {
                                                if(imageAvailable!.isEmpty){
                                                  setState(() {
                                                    _imagePicked = false;
                                                  });
                                                }

                                              }
                                            },
                                            child: const Text('Update'),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 24.0),
                                          child: Card(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Column(
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.all(16.0),
                                                    child: Text(
                                                        'This button below will log you out of your account.'),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      _showDismissConfirmationDialog(
                                                          context,
                                                          _logout,
                                                          'Logout',
                                                          'Are you sure you want to logout?',
                                                          'Logout');
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
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 24.0),
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor: Colors
                                                          .red, // Set the background color to red
                                                      foregroundColor:
                                                          Colors.black,
                                                    ),
                                                    onPressed: () {},
                                                    child: const Text(
                                                        'Delete Account'),
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
                      ],
                    ),
                  ),
                ),
              );
  }
}
