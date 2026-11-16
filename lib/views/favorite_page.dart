import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/favorite_controller.dart';
import '../routes/app_routes.dart';

// =============================================================================
// FAVORITE PAGE - HIVE CRUD (Modul 6 hal. 117-118 + Modul 8 hal. 157, 179)
// =============================================================================

class FavoritePage extends StatelessWidget {
  FavoritePage({super.key});

  final FavoriteController controller = Get.find<FavoriteController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Favorit')),
      body: Obx(() {
        if (controller.favorites.isEmpty) {
          return const Center(child: Text('Belum ada item favorit.'));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: controller.favorites.length,
          itemBuilder: (context, index) {
            final item = controller.favorites[index];
            return Card(
              child: ListTile(
                onTap: () => Get.toNamed(AppRoutes.detail, arguments: item.id),
                leading: item.image.isNotEmpty
                    ? Image.network(
                        item.image,
                        width: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
                      )
                    : const Icon(Icons.image),
                title: Text(item.title),
                subtitle: Text('⭐ ${item.rating}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.redAccent),
                  onPressed: () => controller.removeAt(index),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
