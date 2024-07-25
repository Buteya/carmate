import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class User extends ChangeNotifier {
  final String id;
  final String username;
  final String email;
  final String password;
  final String firstname;
  final String lastname;
  final String mobilenumber;
  final String country;
  final String imageUrl;

  final List<User> _users = [];

  UnmodifiableListView<User> get users => UnmodifiableListView(_users);

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.firstname,
    required this.lastname,
    required this.mobilenumber,
    required this.country,
    required this.imageUrl,
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

  void updateUser(User updatedUser){
    _users.insert(_users.length, updatedUser);
    notifyListeners();
  }

  void removeAll() {
    _users.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
