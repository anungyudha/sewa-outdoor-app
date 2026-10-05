import 'peralatan.dart';

class AlatClimbing extends Peralatan {
  final String standarKeamanan;
  final double bebanMaksimalKg;

  const AlatClimbing({
    required super.id,
    required super.nama,
    required super.hargaSewaHarian,
    super.tersedia = true,
    required super.kondisi,
    super.catatan,
    required this.standarKeamanan,
    required this.bebanMaksimalKg,
  });

  @override
  double hitungUangJaminan() {
    return hargaSewaHarian * 3.5;
  }
}
