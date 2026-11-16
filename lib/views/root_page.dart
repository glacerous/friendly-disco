import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/root_controller.dart';
import 'favorite_page.dart';
import 'home_page.dart';
import 'lbs_notif_page.dart';
import 'profile_page.dart';

// =============================================================================
// ROOT PAGE - BOTTOM NAVIGATION BAR (Modul 4 hal. 66-67, Modul 8 hal. 179)
// CARA SWAP SAAT RESPONSI:
// Hapus tab LbsNotifPage() & BottomNavigationBarItem-nya jika soal tidak pakai Modul 7.
// =============================================================================

class RootPage extends StatelessWidget {
  RootPage({super.key});

  final RootController controller = Get.find<RootController>();

  final List<Widget> _pages = [
    HomePage(),
    FavoritePage(),
    LbsNotifPage(), // Modul 7 (opsional: hapus jika tidak dibutuhkan)
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: _pages[controller.selectedIndex.value],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: controller.selectedIndex.value,
            selectedItemColor: Colors.redAccent,
            onTap: controller.changeTab,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Beranda',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorit',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications_active),
                label: 'Notif/LBS',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profil',
              ),
            ],
          ),
        ));
  }
}
