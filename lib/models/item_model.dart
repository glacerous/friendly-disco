import 'package:hive/hive.dart';

part 'item_model.g.dart';

// =============================================================================
// MODEL UNIVERSAL (Modul 5 hal. 99, Modul 6 hal. 108, Modul 8 hal. 168)
// CARA SWAP SAAT RESPONSI:
// 1. Sesuaikan properti & @HiveField(0..N) jika butuh field baru.
// 2. Ganti key JSON di fromJson() sesuai struktur API soal.
// 3. Wajib jalankan: dart run build_runner build --delete-conflicting-outputs
// =============================================================================

@HiveType(typeId: 0)
class ItemModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String image;

  @HiveField(3)
  final double rating;

  @HiveField(4)
  final List<String> genres;

  @HiveField(5)
  final String summary;

  ItemModel({
    required this.id,
    required this.title,
    required this.image,
    required this.rating,
    required this.genres,
    required this.summary,
  });

  // Cek bentuk JSON di browser sebelum ubah fromJson:
  // - Flat string ("image": "https://...") -> json['image'] ?? ''
  // - Nested Map ("image": {"medium": "..."}) -> json['image']?['medium'] ?? ''
  // - List item ("images": ["..."]) -> json['images']?[0] ?? ''
  // - List semua ("genres": ["Drama"]) -> List<String>.from(json['genres'] ?? [])
  // - Angka desimal/campur (int/double) -> (json['rating'] as num?)?.toDouble() ?? 0.0
  factory ItemModel.fromJson(Map<String, dynamic> json) {
    final rawSummary = (json['summary'] ?? '') as String; // bersihkan tag HTML
    return ItemModel(
      id: json['id'] ?? 0,
      // Contoh jika API pakai 'title': json['title'] ?? 'No Title'
      title: json['name'] ?? 'No Title',
      // Contoh jika API pakai List 'images': json['images']?[0] ?? ''
      image: json['image']?['medium'] ?? json['image']?['original'] ?? '',
      // Contoh jika API pakai 'price': (json['price'] as num?)?.toDouble() ?? 0.0
      rating: (json['rating']?['average'] as num?)?.toDouble() ?? 0.0,
      genres: List<String>.from(json['genres'] ?? []),
      summary: rawSummary.replaceAll(RegExp(r'<[^>]*>'), ''),
    );
  }
}
