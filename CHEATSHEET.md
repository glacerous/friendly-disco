# Flutter Prak Mobile Responsi Cheatsheet (Modul 1–8)

Template modular siap *drag-and-drop* / *swap* saat responsi.

---

## 1. Command CLI Penting

```powershell
# Buat project baru (Modul 1 hal. 13)
flutter create nama_project

# Tambah package per kelompok modul (supaya gampang copy per kebutuhan)
flutter pub add get http shared_preferences hive hive_flutter
flutter pub add flutter_local_notifications timezone geolocator
flutter pub add --dev hive_generator build_runner

# Generate ulang lib/models/item_model.g.dart
# Wajib dijalankan ulang setiap kali kamu edit @HiveType / @HiveField di lib/models/item_model.dart (Modul 6 hal. 109)
dart run build_runner build --delete-conflicting-outputs

# Cek error sebelum run / kumpul
flutter analyze

# Jalankan project (Modul 1 hal. 14-15)
flutter run
flutter run -d chrome   # khusus web (hati-hati CORS & Modul 7 tidak jalan di web)

# Push ke GitHub
git init
git add .
git commit -m "responsi mobile"
git branch -M main
git remote add origin https://github.com/<username>/<nama_repo>.git
git push -u origin main
```

---

## 2. Alur Cepat 5 Menit Saat Responsi (Swap Template)

1. **Buka URL endpoint soal di Browser / Postman** (Modul 5 hal. 88):
   - Cek pembungkus terluar:
     - `[` (Array langsung) → `decoded` langsung `List`
     - `{` (Map wrapper, mis. `{"products": [...]}`) → ambil `decoded['products']`
   - Cek key & tipe data tiap item (`String`, `int`, `double`, `List`, nested `Map`).
2. **Edit `lib/services/api_service.dart`**:
   - Ganti `baseUrl` & key wrapper jika JSON dibungkus `{}`.
3. **Edit `lib/models/item_model.dart`**:
   - Sesuaikan properti + `@HiveField(...)` dan key di `ItemModel.fromJson(json)`.
   - Jalankan ulang: `dart run build_runner build --delete-conflicting-outputs`.
4. **Edit `lib/controllers/auth_controller.dart`**:
   - Sesuaikan syarat username & password di `login()`.
5. **Edit `lib/views/`**:
   - Sesuaikan label teks & field yang ditampilkan di `home_page.dart`, `detail_page.dart`, `favorite_page.dart`, `profile_page.dart`.
   - Jika soal **tidak pakai Modul 7 (Notif/LBS)**, hapus tab `LbsNotifPage()` di `root_page.dart` dan `NotificationService().init()` di `main.dart`.

---

## 3. Peta Materi per Modul

- **Modul 2 (Widget)**: `Scaffold`, `AppBar`, `Column`, `Row`, `Stack`, `Container`, `SizedBox`, `ListView.builder`, `GridView.builder`, `SingleChildScrollView`, `ListTile`, `TextField`.
- **Modul 3 (State & Model)**: `StatefulWidget` + `setState()`, `TextEditingController`, conditional rendering, Model class.
- **Modul 4 (Navigation)**:
  - `Navigator.push` (tambah stack, ada tombol back)
  - `Navigator.pop` (kembali)
  - `Navigator.pushReplacement` (ganti halaman, dipakai setelah Login)
  - `Navigator.pushAndRemoveUntil(..., (route) => false)` (hapus semua stack, dipakai Logout)
  - `BottomNavigationBar` di `RootPage` (indexed navigation).
- **Modul 5 (HTTP Request)**: `http.get(Uri.parse(...))`, `jsonDecode(response.body)`, `Future`/`async`/`await`, `try-catch`, `isLoading`, `Model.fromJson()`.
- **Modul 6 (Local Storage)**:
  - **SharedPreferences**: simpan data ringan key-value (`setBool`, `setString`, `getBool`, `getString`, `remove`) untuk session login & username.
  - **Hive**: database NoSQL lokal untuk list objek (`Hive.initFlutter()`, `Hive.registerAdapter()`, `Hive.openBox<T>()`, CRUD: `add`, `put`, `getAt`, `putAt`, `delete`, `deleteAt`).
- **Modul 7 (Notification & LBS)**:
  - **Notification**: `flutter_local_notifications` (`show` untuk immediate, `zonedSchedule` + `timezone` untuk scheduled). Wajib **desugaring** di `android/app/build.gradle.kts` & **permissions + 3 `<receiver>`** di `AndroidManifest.xml` (hal. 131–132).
  - **LBS**: `geolocator` (`isLocationServiceEnabled`, `checkPermission`, `requestPermission`, `getCurrentPosition`, `distanceBetween`). Wajib `ACCESS_FINE_LOCATION` & `ACCESS_COARSE_LOCATION` di `AndroidManifest.xml` (hal. 142).
- **Modul 8 (GetX)**:
  - **State**: `.obs` + `Obx(() => ...)` + `GetxController` (`onInit`, `onReady`, `onClose`).
  - **DI**: `Bindings` (`Get.lazyPut` / `Get.put`) + `Get.find<Controller>()`.
  - **Routing**: `GetMaterialApp`, `GetPage`, `Get.toNamed`, `Get.offAllNamed`, `Get.back`, `Get.arguments`.

---

## 4. Perbandingan Cepat: GetX vs Tanpa GetX

| Fitur | GetX (Template Ini) | Tanpa GetX (Modul 3–6) |
| :--- | :--- | :--- |
| Root App | `GetMaterialApp` | `MaterialApp` |
| Update UI | `.obs` + `Obx()` | `StatefulWidget` + `setState()` |
| Update Hive | `RxList` + `Obx()` | `ValueListenableBuilder(valueListenable: Hive.box(...).listenable())` |
| Pindah Page | `Get.toNamed('/detail', arguments: id)` | `Navigator.push(context, MaterialPageRoute(...))` |
| Login / Logout | `Get.offAllNamed('/root')` | `Navigator.pushReplacement` / `pushAndRemoveUntil` |
| Awal Load | `onInit()` di Controller | `initState()` di State |
