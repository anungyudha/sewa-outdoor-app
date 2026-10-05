import '../enums/kondisi_alat.dart';
import '../exceptions/sewa_expection.dart'; 
import '../models/kontrak_penyewa.dart';
import '../models/peralatan.dart';
import '../models/penyewa.dart';

/// Class Service untuk mengelola logika bisnis penyewaan secara Async
class LayananSewa {
  /// Method Async untuk memproses penyewaan dengan validasi aturan bisnis
  Future<KontrakSewa> prosesSewaAsync({
    required String idKontrak,
    required Penyewa penyewa,
    required List<Peralatan> daftarAlat,
    required DateTime tanggalMulai,
    required DateTime tanggalSelesaiEstimasi,
  }) async {
    // Simulasi delay proses database selama 1 detik
    await Future.delayed(const Duration(seconds: 1));

    try {

      if (daftarAlat.isEmpty) {
        throw Exception('Daftar alat sewa tidak boleh kosong!');
      }


      for (final alat in daftarAlat) {
        if (!alat.tersedia) {
          throw AlatTidakTersediaException(
            namaAlat: alat.nama,
            alasan: 'Alat sedang dipinjam oleh pelanggan lain.',
          );
        }

        if (alat.kondisi == KondisiAlat.butuhPerawatan) {
          throw AlatTidakTersediaException(
            namaAlat: alat.nama,
            alasan: 'Alat sedang dalam kondisi rusak/perlu perawatan.',
          );
        }
      }


      final kontrak = KontrakSewa(
        idKontrak: idKontrak,
        penyewa: penyewa,
        daftarAlat: daftarAlat,
        tanggalMulai: tanggalMulai,
        tanggalSelesaiEstimasai: tanggalSelesaiEstimasi,
      );

      print('  [SISTEM] Kontrak sewa $idKontrak berhasil diproses!');
      return kontrak;

    } catch (e) {
      print('  [SISTEM ERROR LOG] Gagal memproses sewa: $e');
      rethrow;
    }
  }
}
