/// Model untuk menampung data pengguna dari API.
class ApiUser {
  final int id;
  final String name;
  final String email;
  final String companyName;

  /// Membuat objek ApiUser.
  const ApiUser({
    required this.id,
    required this.name,
    required this.email,
    required this.companyName,
  });

  /// Mengubah data JSON menjadi objek ApiUser.
  factory ApiUser.fromJson(Map<String, dynamic> json) {
    final company = json['company'];

    return ApiUser(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      companyName: company is Map ? company['name'] as String? ?? '-' : '-',
    );
  }
}
