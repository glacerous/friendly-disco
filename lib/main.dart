import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/item_model.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'services/notification_service.dart';

// =============================================================================
// MAIN.DART (Modul 6 hal. 107, Modul 7 hal. 136, Modul 8 hal. 179)
// =============================================================================

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Inisialisasi Hive (Modul 6 hal. 107)
  await Hive.initFlutter();
  Hive.registerAdapter(ItemModelAdapter());
  await Hive.openBox<ItemModel>('favorites');

  // 2. Inisialisasi Local Notification (Modul 7 hal. 136)
  // Hapus baris ini jika tidak pakai Notification di Web/Desktop
  await NotificationService().init();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Responsi Template',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      initialRoute: AppRoutes.login,
      getPages: AppPages.routes,
    );
  }
}
