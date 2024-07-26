import 'dart:collection';

import 'package:flutter/material.dart';

class Permission with ChangeNotifier{
  final String id;
  final String permission;

  Permission({
    required this.id,
    required this.permission,
  });

  final List<Permission> _permissions = [];

  UnmodifiableListView<Permission> get permissions =>
      UnmodifiableListView(_permissions);

  void add(Permission permission) {
    _permissions.add(permission);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void removePermission(int index) {
    _permissions.removeAt(index);
    notifyListeners();
  }

  void updatePermission(Permission updatedPermission,int index){
    _permissions[index]= updatedPermission;
    notifyListeners();
  }

  void removeAll() {
    _permissions.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
