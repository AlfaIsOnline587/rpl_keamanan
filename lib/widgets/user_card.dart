import 'package:flutter/material.dart';

import '../models/user.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(user.name.isEmpty ? '?' : user.name.characters.first),
        ),
        title: Text(user.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user.email),
            if (user.username != null) Text('@${user.username}'),
            if (user.phone != null) Text(user.phone!),
          ],
        ),
        isThreeLine: user.username != null || user.phone != null,
      ),
    );
  }
}
