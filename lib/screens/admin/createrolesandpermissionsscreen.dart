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
  String? selectedPermission;
  Set<String> newListPermissions = {}; // add Permission tab
  List<Permission>? newList = [];
  final uuid = const Uuid();
  bool? _addRolePressed = false;

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
    bool?  permissionBool;
    try {
       permissionBool = permissions.permissions.firstWhere(
            (item) => item.permission == _permissionController.text,
      ).permission != _permissionController.text;
      // Element found, handle it
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
           backgroundColor: Colors.deepPurple,
           content: Text(
             'Permission already exists!!!',
             style: GoogleFonts.roboto(
               fontSize: 17,
               color: Colors.white,
             ),
           ),
         ),
       );
       print('permission already exists');
    } catch (e) {
      // Element not found, handle the absence
      permissions.add(
        Permission(
          id: id,
          permission: _permissionController.text,
        ),
      );
      print('No matching element: $e');
    }

    if (currentUser?.id != null) {
      if (permissions.permissions.isEmpty
          ) {
        permissions.add(
          Permission(
            id: id,
            permission: _permissionController.text,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.deepPurple,
            content: Text(
              'Failed to create permission!!!',
              style: GoogleFonts.roboto(
                fontSize: 17,
                color: Colors.white,
              ),
            ),
          ),
        );
        print('Failed to create permission');
      }

      newListPermissions.add(_permissionController.text);
      print(newListPermissions);

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
      print('function addPermission permissionId:${permission.id}');
      print('function addPermission permission:${permission.permission}');
    }
  }

  void _addRole() {
    final roles = Provider.of<Role>(context, listen: false);
    final id = uuid.v4();
    bool? roleBool;
    try {
      roleBool = roles.roles
          .firstWhere((role) => role.roleName == _roleController.text)
          .roleName
          !=
          _roleController.text;
      // Element found, handle it
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.deepPurple,
          content: Text(
            'Role already exists!!!',
            style: GoogleFonts.roboto(
              fontSize: 17,
              color: Colors.white,
            ),
          ),
        ),
      );
      print('Role already exists');
    } catch (e) {
      // Element not found, handle the absence
      roles.add(
        Role(
          id: id,
          roleName: _roleController.text,
          permissions: newList!,
        ),
      );
      print('No matching element: $e');
    }
    if (currentUser?.id != null) {
      if (roles.roles.isEmpty) {
        roles.add(
          Role(
            id: id,
            roleName: _roleController.text,
            permissions: newList!,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.deepPurple,
            content: Text(
              'Failed to create role!!!',
              style: GoogleFonts.roboto(
                fontSize: 17,
                color: Colors.white,
              ),
            ),
          ),
        );
        print('failed to create role');
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.deepPurple,
          content: Text(
            'Role $id has been added successfully!!!',
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
      print('functionAddRole roleId: ${role.id}');
      print('functionAddRole roleName: ${role.roleName}');
      for (final item in role.permissions) {
        print('functionAddRole permissionId: ${item.id}');
        print('functionAddRole permission: ${item.permission}');
      }
    }
  }

  void _addRoleToUser(
      int index, String roleId, String roleName, List<Permission> permissions) {
    final users = Provider.of<User>(context, listen: false);
    if (currentUser?.id != null) {

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.deepPurple,
            content: Text(
              'Replacing role for user ${users.users[index].id}!!!',
              style: GoogleFonts.roboto(
                fontSize: 17,
                color: Colors.white,
              ),
            ),
          ),
        );
        users.updateSingleUser(
            User(
                id: users.users[index].id,
                username: users.users[index].username,
                email: users.users[index].email,
                password: users.users[index].password,
                firstname: users.users[index].firstname,
                lastname: users.users[index].lastname,
                mobileNumber: users.users[index].mobileNumber,
                country: users.users[index].country,
                imageUrl: users.users[index].imageUrl,
                role: Role(
                    id: roleId, roleName: roleName, permissions: permissions)),
            index);


      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.deepPurple,
          content: Text(
            'Role ${users.users[index].role?.id} has been added to user ${users.users[index].id} successfully!!!',
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

    for (final user in users.users) {
      print(user.id);
      print(user.username);
      print(user.email);
      print(user.password);
      print('user roleId: ${user.role?.id}');
      print('user roleName: ${user.role?.roleName}');
      print('user permissions list: ${user.role!.permissions.length}');
      for (final item in user.role!.permissions) {
        print(item.id);
        print(item.permission);
      }
    }
    print(users.users.length);
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
                    bottom: const TabBar(
                      tabs: [
                        Tab(
                          text: 'Assign Role',
                          icon: Icon(Icons.add_task_rounded),
                        ),
                        Tab(
                          text: 'Create Role',
                          icon: Icon(Icons.sign_language_rounded),
                        ),
                        Tab(
                          text: 'Create Permission',
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
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Consumer2<User, Role>(builder: (
                                context,
                                user,
                                role,
                                child,
                              ) {
                                for (final role in role.roles) {
                                  print(role.permissions.length);
                                  for (final item in role.permissions) {
                                    print(item.permission);
                                  }
                                }
                                return SizedBox(
                                  height: 200,
                                  child: ListView.builder(
                                      itemCount: user.users.length,
                                      itemBuilder: (context, indexUser) {
                                        return ExpansionTile(
                                            leading: user.users[indexUser]
                                                    .imageUrl.isEmpty
                                                ? const SizedBox(
                                                    width: 50,
                                                    child: Card(
                                                      child: Icon(Icons.person),
                                                    ),
                                                  )
                                                : SizedBox(
                                                    width: 50,
                                                    child: Card(
                                                      child: Image.network(
                                                        user.users[indexUser]
                                                            .imageUrl,
                                                        width: 50,
                                                      ),
                                                    ),
                                                  ),
                                            title: Text(user
                                                .users[indexUser].firstname),
                                            subtitle: Text(
                                                user.users[indexUser].lastname),
                                            children: [
                                              SizedBox(
                                                height: 200,
                                                child: ListView.builder(
                                                    itemCount:
                                                        role.roles.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return ListTile(
                                                        title: Text(role
                                                                .roles[index]
                                                                .roleName
                                                                .isEmpty
                                                            ? ''
                                                            : role.roles[index]
                                                                .roleName),
                                                        trailing:
                                                            ElevatedButton.icon(
                                                          onPressed: () {
                                                            print('pressed');
                                                            _addRoleToUser(
                                                                user.users.indexOf(
                                                                    user.users[
                                                                        indexUser]),
                                                                role
                                                                    .roles[
                                                                        index]
                                                                    .id,
                                                                role
                                                                    .roles[
                                                                        index]
                                                                    .roleName,
                                                                role
                                                                    .roles[
                                                                        index]
                                                                    .permissions);
                                                          },
                                                          label: const Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Text('Add Role'),
                                                              Icon(Icons.add)
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                              ),
                                            ]);
                                      }),
                                );
                              })
                            ],
                          ),
                        ),
                      ),
                      // Content for Tab 2
                      SingleChildScrollView(
                        child: Card(
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
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: FormInput(
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
                                  ),
                                  StatefulBuilder(
                                    builder: (BuildContext context,
                                        StateSetter setState) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Text(
                                              'Pick the permissions to assign to '
                                              'the new role from the dropdown:',
                                              style: GoogleFonts.roboto(
                                                fontSize: 17,
                                              ),
                                              softWrap: true,
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Card(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: DropdownButton<String>(
                                                    value: selectedPermission,
                                                    onChanged: (newValue) {
                                                      setState(() {
                                                        selectedPermission =
                                                            newValue!;
                                                        newList!.add(Permission(
                                                            id: Provider.of<
                                                                        Permission>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .permissions
                                                                .firstWhere((permission) =>
                                                                    permission
                                                                        .permission ==
                                                                    selectedPermission!)
                                                                .id,
                                                            permission:
                                                                selectedPermission!));
                                                        for (final item
                                                            in newList!) {
                                                          print(
                                                              'item ${item.permission}');
                                                        }
                                                        print(
                                                            "newlist ${newList!.length}");
                                                      });
                                                    },
                                                    items: newListPermissions
                                                        .map((String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Text(
                                              'The following permissions will be assigned to the new role: ',
                                              style: GoogleFonts.roboto(
                                                fontSize: 17,
                                              ),
                                              softWrap: true,
                                            ),
                                          ),
                                          Card(
                                            child: SizedBox(
                                              height: 200,
                                              width: 300,
                                              child: ListView.builder(
                                                itemCount: newList!.length,
                                                itemBuilder: (context, indexNewList) {
                                                  print(indexNewList);
                                                  final permission =
                                                      newList![indexNewList];
                                                  print(permission.permission);
                                                  return _addRolePressed!? SizedBox():ListTile(
                                                    title: Text(newList![indexNewList]
                                                        .permission),
                                                    trailing: TextButton.icon(
                                                        onPressed: () {
                                                          setState((){
                                                            newList!.removeAt(indexNewList);
                                                          });
                                                        },
                                                        label: const Icon(Icons
                                                            .close_rounded)),
                                                    // Other list item properties (e.g., subtitle, trailing, etc.)
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        if (_formRolesKey.currentState!
                                            .validate()) {
                                          _addRole();
                                          _formRolesKey.currentState?.reset();
                                          setState(() {
                                            // newList!.clear();
                                            _addRolePressed = true;
                                          });
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
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: FormInput(
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
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      if (_formPermissionsKey.currentState!
                                          .validate()) {
                                        _addPermission();
                                        _formPermissionsKey.currentState
                                            ?.reset();
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
