import 'peralatan.dart';

class AlatCamping extends Peralatan {
  final int kapasitasOrang;
  final bool tahanAir;

  const AlatCamping({
    required super.id,
    required super.nama, 
    required super.hargaSewaHarian,
    super.tersedia = true,
    required super.kondisi,
    super.catatan,
    required this.kapasitasOrang,
    required this.tahanAir,
  });

  @override
  double hitungUangJaminan() {
    return hargaSewaHarian * 2.0;
  }
}
