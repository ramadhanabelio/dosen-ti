class Lecturer {
  final int id;
  final String name;
  final String? email;
  final String? nip;
  final String? nik;
  final String? prodi;
  final String? username;
  final String? photo;
  final String? token;

  Lecturer({
    required this.id,
    required this.name,
    this.email,
    this.nip,
    this.nik,
    this.prodi,
    this.username,
    this.photo,
    this.token,
  });

  factory Lecturer.fromJson(Map<String, dynamic> json) {
    return Lecturer(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      nip: json['nip'],
      nik: json['nik'],
      prodi: json['prodi'],
      username: json['username'],
      photo: json['photo'],
      token: json['access_token'],
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
      'username': username,
      'photo': photo,
      'token': token,
    };
  }
}
