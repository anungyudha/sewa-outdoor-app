import '../mixins/potongan_harga.dart';
import 'peralatan.dart';
import 'penyewa.dart';

/// Kelas Utama Komposisi yang menggabungkan Penyewa dan Peralatan
class KontrakSewa with PotonganHarga {
  final String idKontrak;
  final Penyewa penyewa; 
  final List<Peralatan> daftarAlat; //
  final DateTime tanggalMulai;
  final DateTime tanggalSelesaiEstimasai;
  final DateTime? tanggalKembaliAktual;
  
  const KontrakSewa({
    required this.idKontrak,
    required this.penyewa,
    required this.daftarAlat,
    required this.tanggalMulai,
    required this.tanggalSelesaiEstimasai,
    this.tanggalKembaliAktual,
  });

  /// Menhitung total durasi sewa dalam hari (minimal 1 hari)
  int get durasiHari {
    final akhir = tanggalKembaliAktual ?? tanggalSelesaiEstimasai;
    final selisih = akhir.difference(tanggalMulai).inDays;
    return selisih < 1 ? 1 : selisih;
  }

  /// Menghitung total harga sebelum diskon
  double hitungSubtotal() {
    double totalHarian = 0;
    for (final alat in daftarAlat) {
      totalHarian += alat.hargaSewaHarian;
    }
    return totalHarian * durasiHari;
  }

  /// Menghitung total biaya akhir menggunakan Mixin PotonganHarga
  double hitungTotalBiaya() {
    final subtotal = hitungSubtotal();
    final persenDiskon = dapatkanDiskonMember(penyewa.tierMember);
    return hitungHargaDiskon(subtotal, persenDiskon);
  }
}
