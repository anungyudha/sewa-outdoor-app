# P02 – Outdoor Equipment Rental Domain Model

**Mata Kuliah:** Pemrograman Mobile / Dart OOP Challenge  
**Domain:** Sistem Penyewaan Alat Outdoor & Camping (*Outdoor Equipment Rental System*)

---

## 1. Ringkasan Domain & Aturan Bisnis

Aplikasi ini memodelkan domain penyewaan alat-alat petualangan outdoor (seperti tenda camping dan perlengkapan panjat). Sistem ini dirancang untuk mencegah **keadaan mustahil (*impossible states*)** dengan aturan bisnis berikut:
1. Perlengkapan yang sedang dipinjam atau berstatus **butuhPerawatan** tidak dapat disewa.
2. Kontrak sewa tidak dapat dibuat jika daftar alat kosong.
3. Potongan harga disesuaikan secara otomatis berdasarkan tingkat keanggotaan penyewa (*Membership Tier*: GOLD 15%, SILVER 10%, BRONZE 5%).
4. Biaya deposit (*security deposit*) dihitung secara khusus sesuai kategori perlengkapan (Camping 2x, Climbing 3.5x).

---

## 2. Pemenuhan 6 Butir Elemen Teknis

| No | Elemen Wajib | Implementasi & Justifikasi Domain |
|---|---|---|
| 1 | **Minimal 3 Kelas Berelasi** | `Peralatan` (Base), `AlatCamping`, `AlatClimbing`, `Penyewa`, dan `KontrakSewa`. Pemisahan ini membedakan entitas fisik alat, profil penyewa, dan transaksi hukum sewa. |
| 2 | **Pewarisan & Komposisi** | **Pewarisan (*Inheritance*):** `AlatCamping` dan `AlatClimbing` mewarisi `Peralatan` karena keduanya memiliki sifat dasar alat namun spesifikasi keselamatan yang berbeda.<br>**Komposisi (*Composition*):** `KontrakSewa` mengomposisikan `Penyewa` dan `List<Peralatan>`. |
| 3 | **Satu Mixin (`PotonganHarga`)** | Perilaku perhitungan diskon dipisah ke dalam `mixin PotonganHarga` agar dapat digunakan bersama oleh kelas transaksi/kontrak tanpa mengikat hierarki kelas. |
| 4 | **Enum untuk Nilai Terbatas** | `KondisiAlat` (`sangatBaik`, `baik`, `butuhPerawatan`) mencegah penggunaan String acak. |
| 5 | **Null Safety yang Bermakna** | `catatan` pada `Peralatan` opsional (`String?`), `telepon` pada `Penyewa` opsional (`String?`), dan `tanggalKembaliAktual` pada `KontrakSewa` opsional (`DateTime?`) karena baru terisi saat peralatan dikembalikan. |
| 6 | **Custom Exception** | `AlatTidakTersediaException` menghentikan alur transaksi jika alat tidak siap sewa/rusak. |

---

## 3. Fitur Tambahan (copyWith, JSON, Async)

- **`copyWith`**: Diterapkan pada kelas `Penyewa` untuk memfasilitasi imutabilitas data.
- **`toJson` & `fromJson`**: Diterapkan pada kelas `Penyewa` untuk mendukung serialisasi data.
- **Asynchronous Method (`try-catch`)**: `LayananSewa.prosesSewaAsync()` mensimulasikan proses asynchronous dengan validasi aturan bisnis berbasis `try-catch`.

---

## 4. Keputusan Pemodelan yang Sempat Diragukan

**Dilema Penanganan Tanggal Pengembalian (`tanggalKembaliAktual`):**  
Awalnya diragukan apakah tanggal pengembalian aktual sebaiknya dipisahkan ke kelas transaksi baru (misal `TandaTerimaPengembalian`), atau dijadikan bidang opsional/nullable (`DateTime?`) pada `KontrakSewa`.  
*Keputusan:* Dipilih opsi `DateTime?` pada `KontrakSewa` dipadukan dengan `null safety` Dart. Hal ini menjaga representasi *single source of truth* untuk seluruh siklus hidup kontrak penyewaan dari status aktif hingga selesai, tanpa memerlukan kelas tambahan yang redundan.
