import 'package:flutter/material.dart';

import '../repositories/user_repository.dart';
import 'user_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.userRepository});

  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manajemen Pengguna')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.people_outline,
                size: 72,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 16),
              Text(
                'Data Pengguna',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              const Text(
                'Lihat daftar pengguna yang tersedia dari layanan API.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) =>
                          UserListScreen(userRepository: userRepository),
                    ),
                  );
                },
                icon: const Icon(Icons.people),
                label: const Text('Lihat Pengguna'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
