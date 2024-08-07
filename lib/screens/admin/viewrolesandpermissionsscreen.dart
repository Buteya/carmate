import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../components/badroute.dart';
import '../../components/customtitle.dart';
import '../../components/forminput.dart';
import '../../components/myappdrawer.dart';
import '../../models/roleandpermissions/permission.dart';
import '../../models/roleandpermissions/role.dart';
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
  final GlobalKey<FormState> _formEditRoleKey = GlobalKey<FormState>();
  User? currentUser;
  String? imageAvailable = '';
  bool _isLoading = false;
  String? dropdownValue;

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
                      SingleChildScrollView(
                        child: Consumer3<User, Role,Permission>(
                            builder: (context, user, role,perm, consumerIndex) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: SizedBox(
                              height: 690,
                              child: ListView.builder(
                                  itemCount: role.roles.length,
                                  itemBuilder: (context, index) {
                                    var editRoleName =
                                        role.roles[index].roleName;
                                    var editRolePermissions =
                                        role.roles[index].permissions;
                                    return Dismissible(
                                      key: Key(role.roles[index].id),
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
                                            role.removeRole(index);
                                          } catch (e) {
                                            print(e);
                                          }
                                        });
                                      },
                                      direction: DismissDirection.endToStart,
                                      child: ExpansionTile(
                                        title: const Text('Role'),
                                        subtitle:
                                            Text(role.roles[index].roleName),
                                        children: [
                                          ListTile(
                                            title: Text(
                                                'Id: ${role.roles[index].id}'),
                                          ),
                                          ListTile(
                                            title: Text(
                                                'RoleName: ${role.roles[index].roleName}'),
                                          ),
                                          ListTile(
                                            title: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text('Permissions: '),
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .start, // Adjust alignment as needed
                                                  children: [
                                                    for (final permission
                                                        in role.roles[index]
                                                            .permissions)
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Text(permission
                                                            .permission),
                                                      ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                ElevatedButton.icon(
                                                  onPressed: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return StatefulBuilder(
                                                              builder: (BuildContext
                                                                      context,
                                                                  StateSetter
                                                                      setState) {
                                                            return SingleChildScrollView(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        16.0),
                                                                child: Card(
                                                                  child: Column(
                                                                    children: [
                                                                      SizedBox(
                                                                        height:
                                                                            690,
                                                                        child: ListView.builder(
                                                                            itemCount: user.users.where((user) => user.role?.roleName == role.roles[index].roleName).length,
                                                                            itemBuilder: (context, userIndex) {
                                                                              return Dismissible(
                                                                                key: Key(role.roles[userIndex].id),
                                                                                background: Container(
                                                                                  color: Colors.red,
                                                                                  alignment: Alignment.centerRight,
                                                                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                                                                  child: const Icon(Icons.delete_forever_sharp, color: Colors.white),
                                                                                ),
                                                                                confirmDismiss: (direction) async {
                                                                                  final confirmed = await showDialog<bool>(
                                                                                    context: context,
                                                                                    builder: (context) {
                                                                                      return AlertDialog(
                                                                                        title: const Text('Confirm Dismissal'),
                                                                                        content: const Text('Are you sure you want to remove this item?'),
                                                                                        actions: [
                                                                                          TextButton(
                                                                                            onPressed: () {
                                                                                              Navigator.of(context).pop(false); // Disallow dismissal
                                                                                            },
                                                                                            child: const Text('Cancel'),
                                                                                          ),
                                                                                          TextButton(
                                                                                            onPressed: () {
                                                                                              Navigator.of(context).pop(true); // Allow dismissal
                                                                                            },
                                                                                            child: const Text('Confirm'),
                                                                                          ),
                                                                                        ],
                                                                                      );
                                                                                    },
                                                                                  );

                                                                                  return confirmed ?? false; // Default to disallow dismissal if dialog is dismissed
                                                                                },
                                                                                onDismissed: (direction) {
                                                                                  setState(() {
                                                                                    try {
                                                                                      user.updateSingleUser(User(id: user.users[userIndex].id, username: user.users[userIndex].username, email: user.users[userIndex].email, password: user.users[userIndex].password, firstname: user.users[userIndex].firstname, lastname: user.users[userIndex].lastname, mobileNumber: user.users[userIndex].mobileNumber, country: user.users[userIndex].country, imageUrl: user.users[userIndex].imageUrl, role: Role(id: '', roleName: 'user', permissions: [])), userIndex);
                                                                                    } catch (e) {
                                                                                      print(e);
                                                                                    }
                                                                                  });
                                                                                },
                                                                                direction: DismissDirection.endToStart,
                                                                                child: ExpansionTile(
                                                                                  leading: user.users[userIndex].imageUrl.isEmpty
                                                                                      ? const Card(
                                                                                          child: Icon(Icons.person),
                                                                                        )
                                                                                      : SizedBox(
                                                                                          width: 50,
                                                                                          child: Card(
                                                                                            child: Image.network(
                                                                                              user.users[userIndex].imageUrl,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                  title: Text(user.users[userIndex].username),
                                                                                  children: [
                                                                                    Text('Id: ${user.users[userIndex].id}'),
                                                                                    Text('Firstname: ${user.users[userIndex].firstname}'),
                                                                                    Text('Lastname: ${user.users[userIndex].lastname}'),
                                                                                    Text('Email: ${user.users[userIndex].email}'),
                                                                                    Text('Mobile Number: ${user.users[userIndex].mobileNumber}'),
                                                                                    Text('Country: ${user.users[userIndex].country}'),
                                                                                  ],
                                                                                ),
                                                                              );
                                                                            }),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            16.0),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceEvenly,
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
                                                  label: const Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text('users with role'),
                                                      Icon(Icons.people),
                                                    ],
                                                  ),
                                                ),
                                                ElevatedButton.icon(
                                                  onPressed: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return StatefulBuilder(
                                                              builder: (BuildContext
                                                                      context,
                                                                  StateSetter
                                                                      setState) {
                                                            return SingleChildScrollView(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        16.0),
                                                                child: Card(
                                                                  child: Form(
                                                                    key:
                                                                        _formEditRoleKey,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          16.0),
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(vertical: 16.0),
                                                                            child:
                                                                                Text(
                                                                              'Edit Role',
                                                                              style: GoogleFonts.lato(
                                                                                textStyle: Theme.of(context).textTheme.displayLarge,
                                                                                fontSize: 48,
                                                                                fontWeight: FontWeight.w700,
                                                                                fontStyle: FontStyle.italic,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                              'Role id: ${role.roles[index].id}'),
                                                                          FormInput(
                                                                            initialValue:
                                                                                editRoleName,
                                                                            onChangedFunction: (value) =>
                                                                                editRoleName = value!,
                                                                            labelText:
                                                                                'Rolename',
                                                                            hintText: role.roles.isNotEmpty
                                                                                ? role.roles[index].roleName
                                                                                : 'Enter rolename',
                                                                            validationFunction:
                                                                                (value) {
                                                                              if (value == null || value.isEmpty) {
                                                                                return "please enter permission";
                                                                              }
                                                                              return null;
                                                                            },
                                                                            obscureText:
                                                                                false,
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsets.all(8.0),
                                                                            child: Row(
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: [
                                                                                const Text('Add permission: '),
                                                                                DropdownButton<String>(
                                                                                  value: dropdownValue,
                                                                                  onChanged: (String? newValue) {
                                                                                    final permissi = perm.permissions.firstWhere((perm)=>perm.permission == newValue);
                                                                                    setState(() {

                                                                                      dropdownValue = newValue!;// Update the selected value
                                                                                    });  role.roles[index].permissions.add(permissi);
                                                                                  },
                                                                                  items: perm.permissions.map((item) {
                                                                                    return DropdownMenuItem<String>(
                                                                                      value: item.permission.toString(),
                                                                                      child: Text(item.permission.toString()),
                                                                                    );
                                                                                  }).toList(),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            children: [
                                                                              const Text('Permissions: '),
                                                                              Card(
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  children: [
                                                                                    for (final permission in role.roles[index].permissions)
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.all(16.0),
                                                                                        child: Row(
                                                                                          mainAxisSize: MainAxisSize.min,
                                                                                          children: [
                                                                                            Text(permission.permission),
                                                                                            TextButton.icon(
                                                                                              onPressed: () {
                                                                                                final permissions = role.roles[index].permissions;
                                                                                                setState(() {
                                                                                                  editRolePermissions.removeAt(index);
                                                                                                });
                                                                                                role.updateRole(Role(id: role.roles[index].id, roleName: role.roles[index].roleName, permissions: editRolePermissions), index);
                                                                                              },
                                                                                              label: const Icon(Icons.close_rounded),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(16.0),
                                                                            child:
                                                                                Row(
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
                                                                                    if (role.roles[index].permissions.isEmpty) {
                                                                                      role.removeRole(index);
                                                                                    } else {
                                                                                      role.updateRole(Role(id: role.roles[index].id, roleName: editRoleName, permissions: editRolePermissions), index);
                                                                                    }
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
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          });
                                                        });
                                                  },
                                                  label: const Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text('edit role'),
                                                      Icon(
                                                          Icons.update_rounded),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          );
                        }),
                      ),
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
                                                                                title: Text('Permission Id: ${permission.permissions[index].id}'),
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
