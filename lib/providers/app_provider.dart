import 'package:flutter/material.dart';

import '../models/student.dart';
import '../models/note.dart';
import '../repositories/note_repository.dart';

class AppProvider extends InheritedWidget {
  final Student student;
  final List<Note> notes;
  final bool isLoading;
  final String? error;

  final Future<void> Function(Student) updateStudent;
  final Future<void> Function(Note, String) addNote;
  final Future<void> Function(String) deleteNote;
  final Future<String?> Function(String) getNoteContent;
  final Future<void> Function() loadNotes;

  const AppProvider({
    super.key,
    required this.student,
    required this.notes,
    required this.isLoading,
    required this.error,
    required this.updateStudent,
    required this.addNote,
    required this.deleteNote,
    required this.getNoteContent,
    required this.loadNotes,
    required super.child,
  });

  static AppProvider of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<AppProvider>();

    assert(provider != null, 'AppProvider tidak ditemukan');
    return provider!;
  }

  @override
  bool updateShouldNotify(AppProvider oldWidget) {
    return student != oldWidget.student ||
        notes != oldWidget.notes ||
        isLoading != oldWidget.isLoading ||
        error != oldWidget.error;
  }
}

class AppProviderWrapper extends StatefulWidget {
  final Widget child;

  const AppProviderWrapper({super.key, required this.child});

  @override
  State<AppProviderWrapper> createState() => _AppProviderWrapperState();
}

class _AppProviderWrapperState extends State<AppProviderWrapper> {
  final NoteRepository _repository = NoteRepository();

  Student student = const Student(
    name: 'Sisilya Sorlury',
    nim: '25.11.6566',
    programStudi: 'S1 Informatika',
    email: 'sisilya2030@gmail.com',
  );

  List<Note> notes = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final metadata = await _repository.getNotes();

      final loadedNotes = metadata.map((item) {
        return Note(
          id: item['id'] as String,
          title: item['title'] as String,
          content: '',
          createdAt: DateTime.parse(item['date'] as String),
        );
      }).toList();

      if (!mounted) return;

      setState(() {
        notes = loadedNotes;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        error = 'Gagal memuat catatan: $e';
        isLoading = false;
      });
    }
  }

  Future<void> _updateStudent(Student newStudent) async {
    setState(() {
      student = newStudent;
    });
  }

  Future<void> _addNote(Note note, String content) async {
    await _repository.saveNote(
      id: note.id,
      title: note.title,
      date: note.createdAt,
      content: content,
    );

    if (!mounted) return;

    setState(() {
      notes = [...notes.where((item) => item.id != note.id), note];
      error = null;
    });
  }

  Future<void> _deleteNote(String id) async {
    await _repository.deleteNote(id);

    if (!mounted) return;

    setState(() {
      notes = notes.where((note) => note.id != id).toList();
      error = null;
    });
  }

  Future<String?> _getNoteContent(String id) async {
    return await _repository.getNoteContent(id);
  }

  @override
  Widget build(BuildContext context) {
    return AppProvider(
      student: student,
      notes: notes,
      isLoading: isLoading,
      error: error,
      updateStudent: _updateStudent,
      addNote: _addNote,
      deleteNote: _deleteNote,
      getNoteContent: _getNoteContent,
      loadNotes: _loadNotes,
      child: widget.child,
    );
  }
}
