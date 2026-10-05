class AlatTidakTersediaException implements Exception {
  final String namaAlat;
  final String alasan;

  AlatTidakTersediaException({
    required this.namaAlat,
    required this.alasan,
  });

  @override
  String toString() {
    return 'AlatTidakTersediaException: Alat "$namaAlat" tidak dapat disewa. Alasan: $alasan';
  }
}
