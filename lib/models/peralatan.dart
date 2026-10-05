import '../enums/kondisi_alat.dart';

abstract class Peralatan {
  final String id;
  final String nama;
  final double hargaSewaHarian;
  final bool tersedia;
  final KondisiAlat kondisi;
  final String? catatan; 

  const Peralatan({
    required this.id,
    required this.nama,
    required this.hargaSewaHarian,
    this.tersedia = true,
    required this.kondisi,
    this.catatan, 
  });

  double hitungUangJaminan();
}
