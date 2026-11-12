import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../services/secure_storage_service.dart';

/// Repository untuk mengelola metadata dan isi catatan.
class NoteRepository {
  static const String _metadataKey = 'notes_metadata';

  final SecureStorageService _secureStorage;

  /// Membuat repository dengan SecureStorageService.
  NoteRepository({SecureStorageService? secureStorage})
    : _secureStorage = secureStorage ?? SecureStorageService();

  /// Mengambil seluruh metadata catatan dari SharedPreferences.
  Future<List<Map<String, dynamic>>> getNotes() async {
    final prefs = await SharedPreferences.getInstance();

    final String? data = prefs.getString(_metadataKey);

    if (data == null || data.isEmpty) {
      return [];
    }

    final List<dynamic> decoded = jsonDecode(data);

    return decoded
        .map((item) => Map<String, dynamic>.from(item as Map))
        .toList();
  }

  /// Menyimpan metadata dan isi catatan berdasarkan ID.
  Future<void> saveNote({
    required String id,
    required String title,
    required DateTime date,
    required String content,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final notes = await getNotes();

    final newNote = {'id': id, 'title': title, 'date': date.toIso8601String()};

    final index = notes.indexWhere((note) => note['id'] == id);

    if (index >= 0) {
      notes[index] = newNote;
    } else {
      notes.add(newNote);
    }

    await _secureStorage.saveContent(id, content);

    await prefs.setString(_metadataKey, jsonEncode(notes));
  }

  /// Mengambil isi catatan dari Secure Storage berdasarkan ID.
  Future<String?> getNoteContent(String id) async {
    return await _secureStorage.getContent(id);
  }

  /// Menghapus metadata dan isi catatan berdasarkan ID.
  Future<void> deleteNote(String id) async {
    final prefs = await SharedPreferences.getInstance();

    await _secureStorage.deleteContent(id);

    final notes = await getNotes();

    notes.removeWhere((note) => note['id'] == id);

    await prefs.setString(_metadataKey, jsonEncode(notes));
  }
}
