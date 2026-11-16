import 'package:get/get.dart';
import '../models/item_model.dart';
import '../services/api_service.dart';

// =============================================================================
// HOME CONTROLLER (Modul 8 hal. 170 & Modul 5 hal. 91)
// =============================================================================

class HomeController extends GetxController {
  final RxList<ItemModel> _items = <ItemModel>[].obs;
  final RxBool _isLoading = false.obs;

  List<ItemModel> get items => _items;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    _retrieveData();
    super.onInit();
  }

  Future<void> _retrieveData() async {
    try {
      _isLoading.value = true;
      final data = await ApiService.fetchItems();
      _items.assignAll(data);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      _isLoading.value = false;
    }
  }
}
