mixin PotonganHarga {
  double hitungHargaDiskon(double hargaAwal, double persenDiskon) {
    if (persenDiskon <= 0) return hargaAwal;
    if (persenDiskon >= 100) return 0.0;
    return hargaAwal * (1.0 - (persenDiskon / 100.0));
  }

  double dapatkanDiskonMember(String tierMember) {
    switch (tierMember.toUpperCase()) {
      case 'GOLD':
        return 15.0; // Diskon 15%
      case 'SILVER':
        return 10.0; // Diskon 10%
      case 'BRONZE':
        return 5.0;  // Diskon 5%
      default:
        return 0.0;
    }
  }
}
