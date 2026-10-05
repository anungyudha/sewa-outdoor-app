import 'dart:convert';
import 'package:sewa_outdoor_app/enums/kondisi_alat.dart';
import 'package:sewa_outdoor_app/exceptions/sewa_expection.dart'; 
import 'package:sewa_outdoor_app/models/alat_camping.dart';
import 'package:sewa_outdoor_app/models/alat_climbing.dart';
import 'package:sewa_outdoor_app/models/penyewa.dart';
import 'package:sewa_outdoor_app/services/layanan_sewa.dart';

void main() async {
  print('====================================================');
  print('    DEMO APLIKASI PENYEWAAN ALAT OUTDOOR');
  print('====================================================\n');

  final service = LayananSewa();

  // 1. INISIALISASI OBJEK
  print('>>> 1. Inisialisasi Peralatan & Penyewa:');
  final tenda = AlatCamping(
    id: 'CMP-01',
    nama: 'Tenda Eiger Dome 4P',
    hargaSewaHarian: 75000,
    kondisi: KondisiAlat.sangatBaik,
    kapasitasOrang: 4,
    tahanAir: true,
    catatan: 'Termasuk pasak cadangan',
  );

  final taliClimbing = AlatClimbing(
    id: 'CLM-01',
    nama: 'Tali Beal Dynamic 60m',
    hargaSewaHarian: 120000,
    kondisi: KondisiAlat.baik,
    standarKeamanan: 'UIAA / CE',
    bebanMaksimalKg: 800,
  );

  final komporRusak = AlatCamping(
    id: 'CMP-02',
    nama: 'Kompor Portable',
    hargaSewaHarian: 30000,
    kondisi: KondisiAlat.butuhPerawatan, // Kondisi Rusak!
    kapasitasOrang: 2,
    tahanAir: false,
  );

  final penyewaGold = Penyewa(
    id: 'PNY-01',
    nama: 'Budi Santoso',
    email: 'budi@gmail.com',
    telepon: '08123456789',
    tierMember: 'GOLD', // Dapat diskon 15% dari Mixin PotonganHarga
  );

  print('  [Item 1] ${tenda.nama} - Rp ${tenda.hargaSewaHarian}/hari');
  print('  [Item 2] ${taliClimbing.nama} - Rp ${taliClimbing.hargaSewaHarian}/hari');
  print('  [Penyewa] ${penyewaGold.nama} (${penyewaGold.tierMember})\n');

  // 2. UJI COBA copyWith
  print('>>> 2. Uji Coba copyWith (Imutabilitas):');
  final penyewaDiperbarui = penyewaGold.copyWith(telepon: '08999999999');
  print('  [Sebelum Update] Phone: ${penyewaGold.telepon}');
  print('  [Setelah copyWith] Phone: ${penyewaDiperbarui.telepon}\n');

  // 3. UJI COBA JSON
  print('>>> 3. Uji Coba Konversi JSON (toJson & fromJson):');
  final penyewaJson = penyewaGold.toJson();
  print('  [toJson]: ${jsonEncode(penyewaJson)}');

  final penyewaDariJson = Penyewa.fromJson(penyewaJson);
  print('  [fromJson Reconstructed]: ${penyewaDariJson.nama}\n');

  // 4. UJI COBA METHOD ASYNC SUKSES
  print('>>> 4. Menjalankan Transaksi Async (Alur Sukses):');
  final tanggalMulai = DateTime.now();
  final tanggalSelesai = tanggalMulai.add(const Duration(days: 3)); // 3 hari

  try {
    final kontrak = await service.prosesSewaAsync(
      idKontrak: 'KTR-2026-001',
      penyewa: penyewaDiperbarui,
      daftarAlat: [tenda, taliClimbing],
      tanggalMulai: tanggalMulai,
      tanggalSelesaiEstimasi: tanggalSelesai,
    );

    print('  - Durasi Sewa  : ${kontrak.durasiHari} hari');
    print('  - Subtotal     : Rp ${kontrak.hitungSubtotal()}');
    print('  - Diskon Member: 15% (${penyewaDiperbarui.tierMember})');
    print('  - Total Biaya  : Rp ${kontrak.hitungTotalBiaya()}\n');
  } catch (e) {
    print('  [ERROR] $e\n');
  }

  // 5. UJI COBA PELANGGARAN ATURAN (CUSTOM EXCEPTION & TRY-CATCH)
  print('>>> 5. Uji Coba Pelanggaran Aturan (Try-Catch Exception):');
  print('  [Kasus: Mencoba menyewa alat yang dalam kondisi butuhPerawatan]');
  try {
    await service.prosesSewaAsync(
      idKontrak: 'KTR-2026-002',
      penyewa: penyewaDiperbarui,
      daftarAlat: [komporRusak], // Memasukkan kompor yang rusak!
      tanggalMulai: tanggalMulai,
      tanggalSelesaiEstimasi: tanggalSelesai,
    );
  } on AlatTidakTersediaException catch (e) {
    print('  >>> DITANGKAP DENGAN SUKSES [AlatTidakTersediaException]:');
    print('      $e\n');
  } catch (err) {
    print('  >>> Tangkapan Error Umum: $err\n');
  }

  print('====================================================');
  print('   DEMO PROGRAM SELESAI DENGAN SUKSES');
  print('====================================================');
}
