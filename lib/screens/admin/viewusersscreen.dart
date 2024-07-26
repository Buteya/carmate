import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../components/badroute.dart';
import '../../components/customtitle.dart';
import '../../components/forminput.dart';
import '../../components/myappdrawer.dart';
import '../../models/user.dart';

class ViewUsersScreen extends StatefulWidget {
  const ViewUsersScreen({super.key});

  @override
  State<ViewUsersScreen> createState() => _ViewUsersScreenState();
}

class _ViewUsersScreenState extends State<ViewUsersScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  User? currentUser;
  String? imageAvailable = '';
  bool _isLoading = false;
  String? image = '';

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
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: Text(
                            textAlign: TextAlign.center,
                            'Displays a list of all the users.',
                            style: GoogleFonts.roboto(
                              fontSize: 17,
                            ),
                          ),
                        ),
                        Consumer<User>(builder: (
                          context,
                          user,
                          child,
                        ) {
                          return SizedBox(
                            height: 690,
                            child: ListView.builder(
                                itemCount: user.users.length,
                                itemBuilder: (context, index) {
                                  var username = user.users[index].username;
                                  var firstname = user.users[index].firstname;
                                  var lastname = user.users[index].lastname;
                                  var mobileNumber = user.users[index].mobilenumber;
                                  var country = user.users[index].country;

                                  return Dismissible(
                                    key: Key(user.users[index].id),
                                    background: Container(
                                      color: Colors.red,
                                      alignment: Alignment.centerRight,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: const Icon(
                                          Icons.delete_forever_sharp,
                                          color: Colors.white),
                                    ),
                                    confirmDismiss: (direction) async {
                                      final confirmed = await showDialog<bool>(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title:
                                                const Text('Confirm Dismissal'),
                                            content: const Text(
                                                'Are you sure you want to remove this item?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop(
                                                      false); // Disallow dismissal
                                                },
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop(
                                                      true); // Allow dismissal
                                                },
                                                child: const Text('Confirm'),
                                              ),
                                            ],
                                          );
                                        },
                                      );

                                      return confirmed ??
                                          false; // Default to disallow dismissal if dialog is dismissed
                                    },
                                    onDismissed: (direction) {
                                      setState(() {
                                        try {
                                          user.removeUser(index);
                                          if (user.users.isEmpty) {
                                            Navigator.pushReplacementNamed(
                                                context, '/signup');
                                          }
                                        } catch (e) {
                                          print(e);
                                        }
                                      });
                                    },
                                    direction: DismissDirection.endToStart,
                                    child: ExpansionTile(
                                      leading: Image.network(
                                        user.users[index].imageUrl,
                                        width: 50,
                                      ),
                                      title: Text(
                                        user.users[index].firstname,
                                      ),
                                      subtitle: Text(
                                        user.users[index].lastname,
                                      ),
                                      trailing: const Text('status'),
                                      children: [
                                        ListTile(
                                          title: Card(
                                            child: Image.network(
                                                user.users[index].imageUrl),
                                          ),
                                        ),
                                        ListTile(
                                          title: const Text(
                                            'Id',
                                          ),
                                          subtitle: Text(
                                            user.users[index].id,
                                          ),
                                        ),
                                        ListTile(
                                          title: const Text(
                                            'Username',
                                          ),
                                          subtitle: Text(
                                            user.users[index].username,
                                          ),
                                        ),
                                        ListTile(
                                          title: const Text(
                                            'Firstname',
                                          ),
                                          subtitle: Text(
                                            user.users[index].firstname,
                                          ),
                                        ),
                                        ListTile(
                                          title: const Text(
                                            'Lastname',
                                          ),
                                          subtitle: Text(
                                            user.users[index].lastname,
                                          ),
                                        ),
                                        ListTile(
                                          title: const Text(
                                            'Email',
                                          ),
                                          subtitle: Text(
                                            user.users[index].email,
                                          ),
                                        ),
                                        ListTile(
                                          title: const Text(
                                            'Password',
                                          ),
                                          subtitle: Text(
                                            user.users[index].password,
                                          ),
                                        ),
                                        ListTile(
                                          title: const Text(
                                            'MobileNumber',
                                          ),
                                          subtitle: Text(
                                            user.users[index].mobilenumber,
                                          ),
                                        ),
                                        ListTile(
                                          title: const Text(
                                            'Country',
                                          ),
                                          subtitle: Text(
                                            user.users[index].country,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: ElevatedButton.icon(
                                            onPressed: () {
                                              // Show the custom overlay
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return StatefulBuilder(
                                                        builder: (BuildContext
                                                                context,
                                                            StateSetter
                                                                setState) {
                                                      return SingleChildScrollView(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Card(
                                                            child: Column(
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          16.0),
                                                                  child: Text(
                                                                    'Update Product Car',
                                                                    style:
                                                                        GoogleFonts
                                                                            .lato(
                                                                      textStyle: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .displayLarge,
                                                                      fontSize:
                                                                          48,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontStyle:
                                                                          FontStyle
                                                                              .italic,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          16.0),
                                                                  child: Card(
                                                                    child: user
                                                                            .users[index]
                                                                            .imageUrl
                                                                            .isEmpty
                                                                        ? const Icon(
                                                                            Icons.image_rounded,
                                                                            size:
                                                                                60,
                                                                          )
                                                                        : ClipRRect(
                                                                            borderRadius:
                                                                                const BorderRadius.all(
                                                                              Radius.circular(12.0),
                                                                            ),
                                                                            child: image!.isEmpty
                                                                                ? Image.network(user.users[index].imageUrl)
                                                                                : Image.network(image!),
                                                                          ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          16.0),
                                                                  child:
                                                                      ElevatedButton
                                                                          .icon(
                                                                    onPressed:
                                                                        () async {
                                                                      final pickedImage =
                                                                          await ImagePicker()
                                                                              .pickImage(source: ImageSource.gallery);
                                                                      if (pickedImage !=
                                                                          null) {
                                                                        setState(
                                                                            () {
                                                                          print(
                                                                              pickedImage.name);
                                                                          print(
                                                                              pickedImage.path);
                                                                          image =
                                                                              pickedImage.path;
                                                                          print(
                                                                              image);
                                                                          print(user
                                                                              .users[index]
                                                                              .imageUrl);
                                                                        });
                                                                        for (final user
                                                                            in currentUser!.users) {
                                                                          print(
                                                                              'image ${user.imageUrl}');
                                                                        }
                                                                      } else {
                                                                        // Handle the case where the user canceled image selection
                                                                        // (e.g., show a message or revert to a default image)
                                                                      }
                                                                    },
                                                                    label:
                                                                        const Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                        Text(
                                                                            "pick Image"),
                                                                        Icon(Icons
                                                                            .camera),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          16.0),
                                                                  child: Card(
                                                                    child: Form(
                                                                      key:
                                                                          _formKey,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          FormInput(
                                                                            initialValue: username,
                                                                            onChangedFunction: (value) =>
                                                                            username = value!,
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
                                                                            initialValue: firstname,
                                                                            onChangedFunction: (value) =>
                                                                            firstname = value!,
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
                                                                            initialValue: lastname,
                                                                            onChangedFunction: (value) =>
                                                                            lastname = value!,
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
                                                                            initialValue: mobileNumber,
                                                                            onChangedFunction: (value) =>
                                                                            mobileNumber = value!,
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
                                                                            initialValue: country,
                                                                            onChangedFunction: (value) =>
                                                                            country = value!,
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
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          16.0),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                    children: [
                                                                      ElevatedButton
                                                                          .icon(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                        label:
                                                                            const Row(
                                                                          children: [
                                                                            Text('close'),
                                                                            Icon(Icons.close_rounded),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      ElevatedButton
                                                                          .icon(
                                                                        onPressed:
                                                                            () {
                                                                          user.updateUser(
                                                                            User(
                                                                              id: user.users[index].id,
                                                                              username: username,
                                                                              email: user.users[index].email,
                                                                              password: user.users[index].id,
                                                                              firstname: firstname,
                                                                              lastname: lastname,
                                                                              mobilenumber: mobileNumber,
                                                                              country: country,
                                                                              imageUrl: image!.isEmpty?user.users[index].imageUrl:image!,
                                                                            ),
                                                                          );
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                        label:
                                                                            const Row(
                                                                          children: [
                                                                            Text('update'),
                                                                            Icon(Icons.update_rounded),
                                                                          ],
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    });
                                                  });
                                            },
                                            label: const Padding(
                                              padding: EdgeInsets.all(16.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text('Update'),
                                                  Icon(Icons.update_rounded),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              );
  }
}
