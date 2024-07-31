import 'dart:collection';

import 'package:carmate/models/roleandpermissions/role.dart';
import 'package:flutter/material.dart';

class User extends ChangeNotifier {
  final String id;
  final String username;
  final String email;
  final String password;
  final String firstname;
  final String lastname;
  final String mobileNumber;
  final String country;
  final String imageUrl;
  String? status;
  Role? role = Role(
    id: '',
    roleName: 'user',
    permissions: [],
  );

  final List<User> _users = [];

  UnmodifiableListView<User> get users => UnmodifiableListView(_users);

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.firstname,
    required this.lastname,
    required this.mobileNumber,
    required this.country,
    required this.imageUrl,
    this.status = 'offline',
    this.role,
  });

  void add(User user) {
    _users.add(user);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void removeUser(int index) {
    _users.removeAt(index);
    notifyListeners();
  }

  void updateUser(User updatedUser) {
    _users[_users.length - 1] = updatedUser;
    notifyListeners();
  }

  void removeAll() {
    _users.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
