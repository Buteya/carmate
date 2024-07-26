import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/badroute.dart';
import '../../components/customtitle.dart';
import '../../components/myappdrawer.dart';
import '../../models/user.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({super.key});

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
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
        : Scaffold( appBar: AppBar(
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
      ),);
  }
}
