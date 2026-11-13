import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final VoidCallback onAddNote;

  const EmptyState({super.key, required this.onAddNote});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.note_alt_outlined,
              size: 80,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            const Text(
              'Belum Ada Catatan',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Tambahkan catatan pertamamu sekarang.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: onAddNote,
              icon: const Icon(Icons.add),
              label: const Text('Tambah Catatan'),
            ),
          ],
        ),
      ),
    );
  }
}
