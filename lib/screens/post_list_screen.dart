import 'package:flutter/material.dart';

import '../config/dependency_injector.dart';
import '../models/post.dart';
import '../repositories/post_repository.dart';
import '../services/api_service.dart';

/// Halaman untuk menampilkan daftar post.
class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key});

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  late PostRepository _repository;
  late Future<List<Post>> _postsFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _repository = DependencyInjector.of(context).postRepository;
    _postsFuture = _repository.getPosts();
  }

  void _reloadPosts() {
    setState(() {
      _postsFuture = _repository.getPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Post'),
        actions: [
          IconButton(
            onPressed: _reloadPosts,
            tooltip: 'Muat ulang',
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder<List<Post>>(
        future: _postsFuture,
        builder: (context, snapshot) => _buildBody(snapshot),
      ),
    );
  }

  Widget _buildBody(AsyncSnapshot<List<Post>> snapshot) {
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
                'Gagal memuat post:\n$errorMessage',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: _reloadPosts,
                icon: const Icon(Icons.refresh),
                label: const Text('Coba Lagi'),
              ),
            ],
          ),
        ),
      );
    }

    final posts = snapshot.data ?? const <Post>[];
    if (posts.isEmpty) {
      return const Center(child: Text('Tidak ada data post.'));
    }

    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: CircleAvatar(
              child: Text('${post.id}', style: const TextStyle(fontSize: 12)),
            ),
            title: Text(
              post.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              post.body,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      },
    );
  }
}
