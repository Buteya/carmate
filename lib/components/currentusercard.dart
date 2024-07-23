import 'package:flutter/material.dart';

import '../models/user.dart';
class CurrentUserCard extends StatelessWidget {
  const CurrentUserCard({
    super.key,
    required this.currentUser,
    required this.imageAvailable,
  });

  final User? currentUser;
  final String? imageAvailable;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: Row(
          children: [
            currentUser!.imageUrl.isEmpty
                ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: imageAvailable!.isNotEmpty
                  ? CircleAvatar(
                child: Container(
                  width:
                  100, // Adjust the size as needed
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          imageAvailable!),
                    ),
                  ),
                ),
              )
                  : const CircleAvatar(
                child: Icon(Icons.person),
              ),
            )
                : Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                child: Container(
                  width:
                  100, // Adjust the size as needed
                  height: 100,
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
            ),
            Text('welcome ${currentUser?.username}  '),
          ],
        ),
      ),
    );
  }
}