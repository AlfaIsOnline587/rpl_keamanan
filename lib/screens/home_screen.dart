import 'package:flutter/material.dart';

import 'post_list_screen.dart';
import 'user_list_screen.dart';
import 'validation_test_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                      builder: (_) => const UserListScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.people),
                label: const Text('Lihat Pengguna'),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const PostListScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.article),
                label: const Text('Lihat Daftar Post'),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const ValidationTestScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.fact_check),
                label: const Text('Uji Validasi'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
