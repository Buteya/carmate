import 'package:flutter/material.dart';

import '../models/user.dart';
import 'customtitle.dart';

class MyAppDrawer extends StatelessWidget {
  const MyAppDrawer({
    super.key,
    required this.imageAvailable,
    required this.currentUser,
    required this.mounted,
  });

  final String? imageAvailable;
  final User? currentUser;
  final bool mounted;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(
            color: Colors.deepPurpleAccent,
          ),
          child: GestureDetector(
            onTap: (){
              if(mounted){
                Navigator.pushReplacementNamed(context, '/profile');
              }
            },
            child: Column(
              children: [
                const CustomTitle(
                  color: Colors.purple,
                ),
                CircleAvatar(
                  radius: 27,
                  child: imageAvailable!.isNotEmpty
                      ? Container(
                    width: 40, // Adjust the size as needed
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(imageAvailable!),
                      ),
                    ),
                  )
                      : Container(
                    width: 40, // Adjust the size as needed
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            currentUser!.imageUrl),
                      ),
                    ),
                  ),
                ),
                Text(softWrap: true,
                    maxLines: 1,
                    'Welcome, ${currentUser!.username[0].toUpperCase() + currentUser!.username.substring(1).toLowerCase()}'),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(
            left: 8.0,
          ),
          child: Text('Admin'),
        ),
        const Divider(
          indent: 50.0,
          color: Colors.black,
          thickness: 1.0,
          endIndent: 10,
        ),
        ListTile(
          title: const Text('Create Product car'),
          subtitle: const Text(
              'Add a new car to the product catalogue'),
          trailing: const Icon(Icons.add_circle_rounded),
          onTap: () {
            // Handle item 1 tap
            if (mounted) {
              Navigator.pushReplacementNamed(
                  context, '/createproductcar');
            }
          },
        ),
        ListTile(
          title: const Text('View Product cars'),
          subtitle: const Text(
              'view all the cars in the catalogue and manage them'),
          onTap: () {
            // Handle item 2 tap
            if (mounted) {
              Navigator.pushReplacementNamed(
                  context, '/viewproductcars');
            }
          },
        ),
      ],
    );
  }
}