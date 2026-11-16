import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../models/item_model.dart';

// =============================================================================
// FAVORITE CONTROLLER (Modul 6 hal. 104, 117-118 + Modul 8 hal. 157)
// Menyimpan/menghapus ItemModel ke Hive Box 'favorites' secara reaktif.
// =============================================================================

class FavoriteController extends GetxController {
  final Box<ItemModel> _box = Hive.box<ItemModel>('favorites');
  final RxList<ItemModel> _favorites = <ItemModel>[].obs;

  List<ItemModel> get favorites => _favorites;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  void loadFavorites() {
    _favorites.assignAll(_box.values.toList());
  }

  bool isFavorite(int id) => _favorites.any((e) => e.id == id);

  Future<void> toggleFavorite(ItemModel item) async {
    if (_box.containsKey(item.id)) {
      await _box.delete(item.id);
    } else {
      await _box.put(item.id, item);
    }
    loadFavorites();
  }

  Future<void> removeAt(int index) async {
    await _box.deleteAt(index);
    loadFavorites();
  }
}
