import 'package:flutter/material.dart';

import '../models/student.dart';
import '../models/note.dart';

class AppProvider extends InheritedWidget {
  final Student student;
  final List<Note> notes;

  final void Function(Student) updateStudent;
  final void Function(Note) addNote;
  final void Function(String) deleteNote;

  const AppProvider({
    super.key,
    required this.student,
    required this.notes,
    required this.updateStudent,
    required this.addNote,
    required this.deleteNote,
    required super.child,
  });

  static AppProvider of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<AppProvider>();

    assert(provider != null, 'AppProvider tidak ditemukan');
    return provider!;
  }

  @override
  bool updateShouldNotify(AppProvider oldWidget) {
    return student != oldWidget.student || notes != oldWidget.notes;
  }
}

class AppProviderWrapper extends StatefulWidget {
  final Widget child;

  const AppProviderWrapper({super.key, required this.child});

  @override
  State<AppProviderWrapper> createState() => _AppProviderWrapperState();
}

class _AppProviderWrapperState extends State<AppProviderWrapper> {
  Student student = const Student(
    name: 'Nama Mahasiswa',
    nim: '25XXXXXXXX',
    programStudi: 'S1 Informatika',
    email: 'email@contoh.com',
  );

  List<Note> notes = [];

  // Hanya memperbarui data mahasiswa.
  void _updateStudent(Student newStudent) {
    setState(() {
      student = newStudent;
    });
  }

  // Hanya menambahkan catatan.
  void _addNote(Note note) {
    setState(() {
      notes = [...notes, note];
    });
  }

  // Hanya menghapus catatan berdasarkan ID.
  void _deleteNote(String id) {
    setState(() {
      notes = notes.where((note) => note.id != id).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppProvider(
      student: student,
      notes: notes,
      updateStudent: _updateStudent,
      addNote: _addNote,
      deleteNote: _deleteNote,
      child: widget.child,
    );
  }
}
