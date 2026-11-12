import 'package:flutter/material.dart';

import '../providers/app_provider.dart';
import 'profile_screen.dart';
import 'note_form_screen.dart';
import 'api_users_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = AppProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsi Flutter'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                title: Text(provider.student.name),
                subtitle: Text(provider.student.nim),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Catatan Saya',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: provider.notes.isEmpty
                  ? const Center(child: Text('Belum ada catatan'))
                  : ListView.builder(
                      itemCount: provider.notes.length,
                      itemBuilder: (context, index) {
                        final note = provider.notes[index];

                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.note, color: Colors.blue),
                            title: Text(note.title),
                            subtitle: Text(
                              note.content,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                provider.deleteNote(note.id);
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),

            const SizedBox(height: 10),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ApiUsersScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.cloud_download),
              label: const Text('Data Pengguna API'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(15),
              ),
            ),

            const SizedBox(height: 10),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NoteFormScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Tambah Catatan'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
