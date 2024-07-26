import 'dart:collection';

import 'package:carmate/models/roleandpermissions/permission.dart';
import 'package:flutter/material.dart';

class Role with ChangeNotifier{
  final String id;
  final String roleName;
  final List<Permission> permissions;

  Role({
    required this.id,
    required this.roleName,
    required this.permissions,
  });

  final List<Role> _roles = [];

  UnmodifiableListView<Role> get roles =>
      UnmodifiableListView(_roles);

  void add(Role role) {
    _roles.add(role);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void removeRole(int index) {
    _roles.removeAt(index);
    notifyListeners();
  }

  void updateRole(Role updatedRole,int index){
    _roles[index]= updatedRole;
    notifyListeners();
  }

  void removeAll() {
    _roles.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
