import 'package:flutter/material.dart';

import '../models/student.dart';
import '../widgets/profile_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Student student = const Student(
    name: 'Nama Mahasiswa',
    nim: '25XXXXXXXX',
    programStudi: 'S1 Informatika',
    email: 'email@contoh.com',
  );

  void editProfile() {
    final nameController = TextEditingController(text: student.name);
    final nimController = TextEditingController(text: student.nim);
    final programController = TextEditingController(text: student.programStudi);
    final emailController = TextEditingController(text: student.email);

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Edit Profil'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Nama'),
                ),
                TextField(
                  controller: nimController,
                  decoration: const InputDecoration(labelText: 'NIM'),
                ),
                TextField(
                  controller: programController,
                  decoration: const InputDecoration(labelText: 'Program Studi'),
                ),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.trim().isEmpty ||
                    nimController.text.trim().isEmpty ||
                    programController.text.trim().isEmpty ||
                    emailController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Semua data harus diisi!')),
                  );
                  return;
                }

                setState(() {
                  student = student.copyWith(
                    name: nameController.text.trim(),
                    nim: nimController.text.trim(),
                    programStudi: programController.text.trim(),
                    email: emailController.text.trim(),
                  );
                });

                Navigator.pop(dialogContext);
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    ).then((_) {
      nameController.dispose();
      nimController.dispose();
      programController.dispose();
      emailController.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Profil Mahasiswa'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ProfileCard(student: student),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: editProfile,
                icon: const Icon(Icons.edit),
                label: const Text('Edit Profil'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
