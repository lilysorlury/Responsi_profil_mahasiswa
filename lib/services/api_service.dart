import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../config/app_config.dart';
import '../models/api_user.dart';

/// Service untuk mengambil data pengguna dari API publik.
class ApiService {
  /// Mengambil daftar pengguna menggunakan HTTP GET.
  ///
  /// Request memiliki batas waktu 10 detik dan menangani
  /// kesalahan jaringan serta status HTTP.
  Future<List<ApiUser>> getUsers() async {
    try {
      final uri = Uri.parse('${AppConfig.baseUrl}/users');

      final response = await http
          .get(uri, headers: {'Accept': 'application/json'})
          .timeout(const Duration(seconds: 10));

      if (kDebugMode) {
        debugPrint('HTTP GET status: ${response.statusCode}');
      }

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        return data
            .map((item) => ApiUser.fromJson(item as Map<String, dynamic>))
            .toList();
      }

      throw Exception('Gagal mengambil data. Status: ${response.statusCode}');
    } on SocketException {
      if (kDebugMode) {
        debugPrint('HTTP Error: koneksi jaringan bermasalah.');
      }
      throw Exception('Tidak ada koneksi internet.');
    } on TimeoutException {
      if (kDebugMode) {
        debugPrint('HTTP Error: request mengalami timeout.');
      }
      throw Exception('Permintaan terlalu lama. Coba lagi.');
    } catch (e) {
      if (kDebugMode) {
        debugPrint('HTTP Error: ${e.runtimeType}');
      }

      rethrow;
    }
  }
}
