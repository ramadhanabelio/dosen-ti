import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/lecturer.dart';

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  static Future<List<String>> getProdiList() async {
    final response = await http.get(Uri.parse('$baseUrl/prodi'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> prodis = data['data'];
      return prodis.cast<String>();
    } else {
      throw Exception('Gagal memuat daftar prodi');
    }
  }

  static Future<List<Lecturer>> getLecturersByProdi(String prodi) async {
    final encodedProdi = Uri.encodeComponent(prodi);
    final response = await http.get(
      Uri.parse('$baseUrl/lecturers/$encodedProdi'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> list = data['data'];
      return list.map((e) => Lecturer.fromJson(e)).toList();
    } else {
      throw Exception('Gagal memuat dosen untuk prodi $prodi');
    }
  }
}
