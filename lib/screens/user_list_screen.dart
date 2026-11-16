import 'package:flutter/material.dart';

import '../config/dependency_injector.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';
import '../services/api_service.dart';
import '../widgets/user_card.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late UserRepository _userRepository;
  late Future<List<User>> _usersFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userRepository = DependencyInjector.of(context).userRepository;
    _usersFuture = _userRepository.getUsers();
  }

  void _reloadUsers() {
    setState(() {
      _usersFuture = _userRepository.getUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Pengguna'),
        actions: [
          IconButton(
            onPressed: _reloadUsers,
            tooltip: 'Muat ulang',
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder<List<User>>(
        future: _usersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            final error = snapshot.error;
            final errorMessage = error is ApiException
                ? error.message
                : 'Terjadi kesalahan. Silakan coba lagi nanti.';
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline, size: 48),
                    const SizedBox(height: 12),
                    Text(
                      'Gagal memuat pengguna:\n$errorMessage',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: _reloadUsers,
                      child: const Text('Coba Lagi'),
                    ),
                  ],
                ),
              ),
            );
          }

          final users = snapshot.data ?? const <User>[];
          if (users.isEmpty) {
            return const Center(child: Text('Belum ada data pengguna.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: users.length,
            itemBuilder: (context, index) => UserCard(user: users[index]),
          );
        },
      ),
    );
  }
}
