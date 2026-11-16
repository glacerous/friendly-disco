import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../routes/app_routes.dart';

// =============================================================================
// HOME PAGE - GRID / LIST DATA API (Modul 8 hal. 171-173, 179)
// =============================================================================

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Item')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // [ENABLE SEARCH] Uncomment blok TextField di bawah jika soal butuh Search bar:
            // TextField(
            //   onChanged: controller.search,
            //   decoration: const InputDecoration(
            //     hintText: 'Cari...',
            //     prefixIcon: Icon(Icons.search),
            //     border: OutlineInputBorder(),
            //   ),
            // ),
            // const SizedBox(height: 12),
            Expanded(
              child: Obx(() {
                if (controller.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return GridView.builder(
                  itemCount: controller.items.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.65,
                  ),
                  itemBuilder: (context, index) {
                    final item = controller.items[index];
                    return GestureDetector(
                      onTap: () =>
                          Get.toNamed(AppRoutes.detail, arguments: item.id),
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: item.image.isNotEmpty
                                  ? Image.network(
                                      item.image,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => const Center(
                                          child: Icon(Icons.broken_image, size: 48)),
                                    )
                                  : const Center(
                                      child: Icon(Icons.image, size: 48)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text('⭐ ${item.rating}'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
