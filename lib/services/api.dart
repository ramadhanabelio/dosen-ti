import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/lecturer.dart';
import '../models/research.dart';

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

  static Future<List<Research>> getResearchByLecturerId(int lecturerId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/research-by-lecturer/$lecturerId'),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final List<dynamic> data = json['data'];
      return data.map((item) => Research.fromJson(item)).toList();
    } else {
      throw Exception('Gagal memuat data penelitian');
    }
  }

  static Future<Map<String, dynamic>> login(
    String login,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'login': login, 'password': password}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(json.decode(response.body)['message'] ?? 'Login gagal');
    }
  }

  static Future<Map<String, dynamic>> updateProfile(
    String token,
    Map<String, dynamic> data,
  ) async {
    final response = await http.put(
      Uri.parse('$baseUrl/profile'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(
        json.decode(response.body)['message'] ?? 'Update profil gagal',
      );
    }
  }

  static Future<List<Research>> getMyResearch(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/research'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> data = jsonData['data'];

      return data.map((item) => Research.fromJson(item)).toList();
    } else {
      throw Exception('Gagal memuat penelitian');
    }
  }

  static Future<Research> addResearch(
    String token,
    Map<String, dynamic> data,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/research'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Research.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception(
        json.decode(response.body)['message'] ?? 'Gagal menambahkan penelitian',
      );
    }
  }

  static Future<Research> updateResearch(
    String token,
    int id,
    Map<String, dynamic> data,
  ) async {
    final response = await http.put(
      Uri.parse('$baseUrl/research/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return Research.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception(
        json.decode(response.body)['message'] ?? 'Gagal memperbarui penelitian',
      );
    }
  }

  static Future<bool> deleteResearch(String token, int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/research/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception(
        json.decode(response.body)['message'] ?? 'Gagal menghapus penelitian',
      );
    }
  }
}
