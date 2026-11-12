import 'package:flutter/material.dart';

import '../models/student.dart';

class ProfileCard extends StatelessWidget {
  final Student student;

  const ProfileCard({super.key, required this.student});

  String get initials {
    final names = student.name.trim().split(' ');
    if (names.isEmpty || names.first.isEmpty) return '?';

    return names.length > 1
        ? '${names.first[0]}${names[1][0]}'.toUpperCase()
        : names.first[0].toUpperCase();
  }

  Widget buildInfo(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 48,
            backgroundColor: Colors.blue,
            child: Text(
              initials,
              style: const TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            student.name,
            style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          const Divider(),
          buildInfo('NIM', student.nim, Icons.badge_outlined),
          buildInfo(
            'Program Studi',
            student.programStudi,
            Icons.school_outlined,
          ),
          buildInfo('Email', student.email, Icons.email_outlined),
        ],
      ),
    );
  }
}
