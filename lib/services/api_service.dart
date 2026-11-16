import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/item_model.dart';

// =============================================================================
// API SERVICE (Modul 5 hal. 89, 93, 96, 100 & Modul 8 hal. 169)
// Tugas: Hanya fetch & parse JSON. Tidak ada state atau UI di sini.
//
// CARA SWAP SAAT RESPONSI:
// 1. Ganti baseUrl dengan endpoint soal.
// 2. Cek bentuk root JSON di browser:
//    - Jika diawali '[' (Array langsung): pakai `final List data = decoded;`
//    - Jika diawali '{' (Map wrapper, mis. {"products": [...]}):
//      pakai `final List data = decoded['nama_key'];`
// =============================================================================

class ApiService {
  static const String baseUrl = 'https://api.tvmaze.com/shows';

  static Future<List<ItemModel>> fetchItems() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      // Otomatis handle JSON Array [...] maupun Map {"key": [...]}
      // Jika Map, ganti 'products' sesuai key di API soal!
      final List<dynamic> list =
          decoded is List ? decoded : (decoded['products'] ?? []);

      return list.map((e) => ItemModel.fromJson(e)).toList();
    } else {
      throw Exception('Gagal memuat data (${response.statusCode})');
    }
  }

  static Future<ItemModel> fetchItemDetail(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return ItemModel.fromJson(data);
    } else {
      throw Exception('Gagal memuat detail (${response.statusCode})');
    }
  }

  // Contoh POST Login jika soal responsi pakai Auth API (Modul 5 hal. 81):
  // static Future<Map<String, dynamic>> loginApi(String username, String password) async {
  //   final response = await http.post(
  //     Uri.parse('https://dummyjson.com/auth/login'),
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode({'username': username, 'password': password}),
  //   );
  //   if (response.statusCode == 200) return jsonDecode(response.body);
  //   throw Exception('Login gagal');
  // }
}
