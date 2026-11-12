import 'package:flutter/material.dart';

import '../models/api_user.dart';
import '../services/api_service.dart';

/// Halaman untuk menampilkan daftar pengguna dari API.
class ApiUsersScreen extends StatefulWidget {
  /// Membuat halaman daftar pengguna.
  const ApiUsersScreen({super.key});

  @override
  State<ApiUsersScreen> createState() => _ApiUsersScreenState();
}

class _ApiUsersScreenState extends State<ApiUsersScreen> {
  final ApiService _apiService = ApiService();

  late Future<List<ApiUser>> _usersFuture;

  @override
  void initState() {
    super.initState();
    _usersFuture = _apiService.getUsers();
  }

  void _retryRequest() {
    setState(() {
      _usersFuture = _apiService.getUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Pengguna API'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<ApiUser>>(
        future: _usersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 50),
                  const SizedBox(height: 12),
                  Text(
                    'Gagal memuat data: ${snapshot.error}',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _retryRequest,
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            );
          }

          final users = snapshot.data ?? [];

          if (users.isEmpty) {
            return const Center(child: Text('Tidak ada data pengguna.'));
          }

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: CircleAvatar(child: Text('${user.id}')),
                  title: Text(user.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.email),
                      Text('Perusahaan: ${user.companyName}'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
