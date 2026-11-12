class Validators {
  static String? validateTitle(String? value) {
    final title = value?.trim() ?? '';

    if (title.isEmpty) {
      return 'Judul catatan wajib diisi';
    }

    if (title.length < 3) {
      return 'Judul minimal 3 karakter';
    }

    if (title.length > 50) {
      return 'Judul maksimal 50 karakter';
    }

    return null;
  }

  static String? validateContent(String? value) {
    final content = value?.trim() ?? '';

    if (content.isEmpty) {
      return 'Isi catatan wajib diisi';
    }

    if (content.length < 10) {
      return 'Isi catatan minimal 10 karakter';
    }

    if (content.length > 1000) {
      return 'Isi catatan maksimal 1000 karakter';
    }

    return null;
  }

  static String sanitize(String value) {
    return value.replaceAll(RegExp(r'''[<>"']'''), '');
  }
}
