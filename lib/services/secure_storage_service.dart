import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Service untuk menyimpan dan mengelola isi catatan secara aman.
class SecureStorageService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  /// Menyimpan isi catatan secara terenkripsi berdasarkan ID catatan.
  Future<void> saveContent(String noteId, String content) async {
    await _storage.write(key: 'note_content_$noteId', value: content);
  }

  /// Mengambil isi catatan berdasarkan ID.
  /// Mengembalikan null jika catatan tidak ditemukan.
  Future<String?> getContent(String noteId) async {
    return await _storage.read(key: 'note_content_$noteId');
  }

  /// Menghapus isi catatan berdasarkan ID.
  Future<void> deleteContent(String noteId) async {
    await _storage.delete(key: 'note_content_$noteId');
  }
}
