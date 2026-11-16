import 'package:get/get.dart';
import '../routes/app_routes.dart';
import '../services/auth_service.dart';

// =============================================================================
// AUTH CONTROLLER (Modul 8 hal. 159, 162 & Modul 6 hal. 112-113, 119)
// CARA SWAP SAAT RESPONSI:
// Ubah syarat username & password di fungsi login() sesuai ketentuan soal.
// =============================================================================

class AuthController extends GetxController {
  final RxString _username = ''.obs;
  final RxBool _isLoginFailed = false.obs;

  String get username => _username.value;
  bool get isLoginFailed => _isLoginFailed.value;

  @override
  void onInit() {
    super.onInit();
    checkLogin();
  }

  Future<void> checkLogin() async {
    final loggedIn = await AuthService.isLoggedIn();
    if (loggedIn) {
      _username.value = await AuthService.getUsername();
      Get.offAllNamed(AppRoutes.root);
    }
  }

  Future<void> login(String inputUser, String inputPass) async {
    final user = inputUser.trim();
    final pass = inputPass.trim();

    // Ganti kredensial ini sesuai soal responsi
    if (user == '124240018' && pass == '123') {
      _isLoginFailed.value = false;
      _username.value = user;
      await AuthService.saveLogin(user);
      Get.offAllNamed(AppRoutes.root);
    } else {
      _isLoginFailed.value = true;
      Get.snackbar('Login Gagal', 'Username atau password salah');
    }
  }

  Future<void> logout() async {
    await AuthService.logout();
    _username.value = '';
    Get.offAllNamed(AppRoutes.login);
  }
}
