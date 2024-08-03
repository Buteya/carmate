import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../components/badroute.dart';
import '../../components/customtitle.dart';
import '../../components/forminput.dart';
import '../../components/myappdrawer.dart';
import '../../models/roleandpermissions/permission.dart';
import '../../models/user.dart';

class ViewRolesAndPermissionsScreen extends StatefulWidget {
  const ViewRolesAndPermissionsScreen({super.key});

  @override
  State<ViewRolesAndPermissionsScreen> createState() =>
      _ViewRolesAndPermissionsScreenState();
}

class _ViewRolesAndPermissionsScreenState
    extends State<ViewRolesAndPermissionsScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  User? currentUser;
  String? imageAvailable = '';
  bool _isLoading = false;

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
            : DefaultTabController(
                length: 2,
                child: Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    title: const CustomTitle(
                      color: Colors.deepPurpleAccent,
                    ),
                    bottom: const TabBar(
                      tabs: [
                        Tab(
                          text: 'Manage Roles',
                          icon: Icon(Icons.sign_language_outlined),
                        ),
                        Tab(
                          text: 'Manage Permissions',
                          icon: Icon(Icons.multiple_stop_outlined),
                        ),
                      ],
                    ),
                  ),
                  drawer: Drawer(
                    child: MyAppDrawer(
                        imageAvailable: imageAvailable,
                        currentUser: currentUser,
                        mounted: mounted),
                  ),
                  body: TabBarView(
                    children: [
                      //tab 1 view
                      Icon(Icons.directions_transit),
                      //tab 2 view
                      SingleChildScrollView(
                        child: Consumer<Permission>(
                            builder: (context, permission, permissionIndex) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: SizedBox(
                              height: 690,
                              child: ListView.builder(
                                  itemCount: permission.permissions.length,
                                  itemBuilder: (context, index) {
                                    var editPermission = permission
                                        .permissions[index].permission;
                                    return Dismissible(
                                      key:
                                          Key(permission.permissions[index].id),
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
                                        final confirmed =
                                            await showDialog<bool>(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  'Confirm Dismissal'),
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
                                            permission.removePermission(index);
                                          } catch (e) {
                                            print(e);
                                          }
                                        });
                                      },
                                      direction: DismissDirection.endToStart,
                                      child: ExpansionTile(
                                        title: const Text('Permission'),
                                        subtitle: Text(
                                          permission
                                              .permissions[index].permission,
                                        ),
                                        children: [
                                          ListTile(
                                            title: Text(
                                                'Permission Id: ${permission.permissions[index].id}'),
                                          ),
                                          ListTile(
                                            title: Text(
                                                'Permission: ${permission.permissions[index].permission}'),
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
                                                                    .all(16.0),
                                                            child: Card(
                                                              child: Column(
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            16.0),
                                                                    child: Text(
                                                                      'Edit Permission',
                                                                      style: GoogleFonts
                                                                          .lato(
                                                                        textStyle: Theme.of(context)
                                                                            .textTheme
                                                                            .displayLarge,
                                                                        fontSize:
                                                                            48,
                                                                        fontWeight:
                                                                            FontWeight.w700,
                                                                        fontStyle:
                                                                            FontStyle.italic,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Card(
                                                                    child: Form(
                                                                      key:
                                                                          _formkey,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            16.0),
                                                                        child: Column(
                                                                            children: [
                                                                              ListTile(
                                                                                title: Text(
                                                                                    'Permission Id: ${permission.permissions[index].id}'),
                                                                              ),
                                                                              FormInput(
                                                                                initialValue: editPermission,
                                                                                onChangedFunction: (value) => editPermission = value!,
                                                                                labelText: 'Permission',
                                                                                hintText: permission.permissions.isNotEmpty ? permission.permissions[index].permission : 'Enter permission',
                                                                                validationFunction: (value) {
                                                                                  if (value == null || value.isEmpty) {
                                                                                    return "please enter permission";
                                                                                  }
                                                                                  return null;
                                                                                },
                                                                                obscureText: false,
                                                                              ),
                                                                              Padding(
                                                                                padding: const EdgeInsets.all(16.0),
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                  children: [
                                                                                    ElevatedButton.icon(
                                                                                      onPressed: () {
                                                                                        Navigator.of(context).pop();
                                                                                      },
                                                                                      label: const Row(
                                                                                        children: [
                                                                                          Text('close'),
                                                                                          Icon(Icons.close_rounded),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    ElevatedButton.icon(
                                                                                      onPressed: () {
                                                                                        permission.updatePermission(
                                                                                          Permission(
                                                                                            id: permission.permissions[index].id,
                                                                                            permission: editPermission,
                                                                                          ),
                                                                                          index,
                                                                                        );
                                                                                        Navigator.of(context).pop();
                                                                                      },
                                                                                      label: const Row(
                                                                                        children: [
                                                                                          Text('update'),
                                                                                          Icon(Icons.update_rounded),
                                                                                        ],
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ]),
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      });
                                                    });
                                              },
                                              label: const Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text('edit user'),
                                                  Icon(Icons.update_rounded),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          );
                        }),
                      )
                    ],
                  ),
                ),
              );
  }
}
