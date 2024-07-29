import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../components/badroute.dart';
import '../../components/customtitle.dart';
import '../../components/forminput.dart';
import '../../components/myappdrawer.dart';
import '../../models/roleandpermissions/permission.dart';
import '../../models/roleandpermissions/role.dart';
import '../../models/user.dart';

class CreateRolesAndPermissions extends StatefulWidget {
  const CreateRolesAndPermissions({super.key});

  @override
  State<CreateRolesAndPermissions> createState() =>
      _CreateRolesAndPermissionsState();
}

class _CreateRolesAndPermissionsState extends State<CreateRolesAndPermissions> {
  final GlobalKey<FormState> _formPermissionsKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formRolesKey = GlobalKey<FormState>();
  final TextEditingController _permissionController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  User? currentUser;
  bool _isLoading = false;
  String? imageAvailable = '';
  String selectedPermission = 'create user';
  List<String> listPermissions = [];
  List<String> newListPermisssions = ['create user'];
  List<String> selectPermissionsRole = [];
  final uuid = const Uuid();

  @override
  void initState() {
    try {
      currentUser = Provider.of<User>(context, listen: false).users.last;
      print(Provider.of<User>(context, listen: false).users.length);
      print(Provider.of<Permission>(context, listen: false).permissions);
      final listPermissions = Provider.of<Permission>(context, listen: false)
          .permissions
          .map((permission) => permission.permission)
          .toList()
          .toString();
      print(listPermissions.toString());
      print(listPermissions.length);
      // listPermissions?.add(List.from(permissions)['']);
    } catch (e) {
      print(e.toString());
    }
    super.initState();
  }

  void _addPermission() {
    final permissions = Provider.of<Permission>(context, listen: false);
    final id = uuid.v4();
    if (currentUser?.id != null) {
      permissions.add(
        Permission(
          id: id,
          permission: _permissionController.text,
        ),
      );
      newListPermisssions.add(_permissionController.text);
      print(newListPermisssions);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.deepPurple,
          content: Text(
            'Permission $id has been added successfully!!!',
            style: GoogleFonts.roboto(
              fontSize: 17,
              color: Colors.white,
            ),
          ),
        ),
      );
    } else {
      print('no current user');
    }
    for (final permission in permissions.permissions) {
      print(permission.id);
      print(permission.permission);
    }
  }

  void _addRole() {
    final roles = Provider.of<Role>(context, listen: false);
    final id = uuid.v4();
    if (currentUser?.id != null) {
      roles.add(
        Role(
          id: id,
          roleName: _roleController.text,
          permissions: [],
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.deepPurple,
          content: Text(
            'Permission $id has been added successfully!!!',
            style: GoogleFonts.roboto(
              fontSize: 17,
              color: Colors.white,
            ),
          ),
        ),
      );
    } else {
      print('no current user');
    }
    for (final role in roles.roles) {
      print(role.id);
      print(role.roleName);
      print(role.permissions);
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
            : DefaultTabController(
                length: 3,
                child: Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    title: const CustomTitle(
                      color: Colors.deepPurpleAccent,
                    ),
                    bottom: TabBar(
                      tabs: [
                        Tab(text: 'Tab 1'),
                        Tab(
                          text: 'Role',
                          icon: Icon(Icons.sign_language_rounded),
                        ),
                        Tab(
                          text: 'Permission',
                          icon: Icon(Icons.multiple_stop),
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
                      // Content for Tab 1
                      Center(child: Text('Tab 1 Content')),
                      // Content for Tab 2
                      Card(
                        child: Form(
                          key: _formRolesKey,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: Text(
                                    'Add New Role',
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
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    'Create a new role, with the required details captured. '
                                    'Ensuring all the fields are filled and with the proper appropriate details.',
                                    style: GoogleFonts.roboto(
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                                FormInput(
                                  onChangedFunction: (value) =>
                                      _roleController.text = value!,
                                  labelText: 'Role Name',
                                  hintText: 'Enter a role,e.g Manager',
                                  validationFunction: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "please enter a role";
                                    }
                                    return null;
                                  },
                                  obscureText: false,
                                ),
                                Text('pick all the permissions of the roles'),
                                Row(
                                  children: [
                                    Text('Roles'),
                                    StatefulBuilder(
                                      builder: (BuildContext context,
                                          StateSetter setState) {
                                        return DropdownButton<String>(
                                          value: selectedPermission,
                                          onChanged: (newValue) {
                                            setState(() {
                                              selectedPermission = newValue!;
                                              selectPermissionsRole.add(newValue);
                                              print(selectPermissionsRole.length);
                                            });
                                          },
                                          items: newListPermisssions
                                              .map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                ...selectPermissionsRole.map((item)=>Text(item)),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      if (_formPermissionsKey.currentState!
                                          .validate()) {
                                        _addRole();
                                      }
                                    },
                                    label: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text('add role'),
                                        Icon(Icons.add),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Content for Tab 3
                      Card(
                        child: Form(
                          key: _formPermissionsKey,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: Text(
                                    'Add New Permission',
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
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    'Create a new permission, with the required details captured. '
                                    'Ensuring all the fields are filled and with the proper appropriate details.',
                                    style: GoogleFonts.roboto(
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                                FormInput(
                                  onChangedFunction: (value) =>
                                      _permissionController.text = value!,
                                  labelText: 'Permission',
                                  hintText:
                                      'Enter a permission,e.g create user',
                                  validationFunction: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "please enter a permission";
                                    }
                                    return null;
                                  },
                                  obscureText: false,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      if (_formPermissionsKey.currentState!
                                          .validate()) {
                                        _addPermission();
                                      }
                                    },
                                    label: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text('add permission'),
                                        Icon(Icons.add),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
  }
}
