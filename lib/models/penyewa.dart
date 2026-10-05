
class Penyewa {
  final String id;
  final String nama;
  final String email;
  final String? telepon; 
  final String tierMember; 

  const Penyewa({
    required this.id,
    required this.nama,
    required this.email,
    this.telepon,
    this.tierMember = 'REGULAR',
  });

  /// 1. Fitur copyWith untuk mengubah data tanpa merusak imutabilitas
  Penyewa copyWith({
    String? id,
    String? nama,
    String? email,
    String? telepon,
    String? tierMember,
  }) {
    return Penyewa(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      email: email ?? this.email,
      telepon: telepon ?? this.telepon,
      tierMember: tierMember ?? this.tierMember,
    );
  }

  /// 2. Fitur toJson untuk mengubah objek ke Map/JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'email': email,
      'telepon': telepon,
      'tierMember': tierMember,
    };
  }

  /// 3. Fitur fromJson untuk membuat objek dari Map/JSON
  factory Penyewa.fromJson(Map<String, dynamic> json) {
    return Penyewa(
      id: json['id'] as String,
      nama: json['nama'] as String,
      email: json['email'] as String,
      telepon: json['telepon'] as String?,
      tierMember: json['tierMember'] as String? ?? 'REGULAR',
    );
  }
}
