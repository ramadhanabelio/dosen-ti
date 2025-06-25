class Lecturer {
  final int id;
  final String name;
  final String? email;
  final String? nip;
  final String? nik;
  final String? prodi;
  final String? photo;

  Lecturer({
    required this.id,
    required this.name,
    this.email,
    this.nip,
    this.nik,
    this.prodi,
    this.photo,
  });

  factory Lecturer.fromJson(Map<String, dynamic> json) {
    return Lecturer(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      nip: json['nip'],
      nik: json['nik'],
      prodi: json['prodi'],
      photo: json['photo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'nip': nip,
      'nik': nik,
      'prodi': prodi,
      'photo': photo,
    };
  }
}
