// lib/controllers/splash_controller.dart
import 'package:get/get.dart';
import '../routes/app_routes.dart';
import '../services/shared_preferences_service.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    checkAuthenticationStatus();
  }

  Future<void> checkAuthenticationStatus() async {
    // Wait for splash animation to complete (adjust timing as needed)
    await Future.delayed(const Duration(milliseconds: 2500));

    try {
      // Check if user is logged in
      final isLoggedIn = await SharedPreferencesService.isLoggedIn();
      
      if (!isLoggedIn) {
        // User is not logged in, go to login
        Get.offAllNamed(AppRoutes.login);
        return;
      }

      // User is logged in, check if token is expired
      final isTokenValid = await _isTokenValid();
      
      if (isTokenValid) {
        // Token is valid, go to home
        Get.offAllNamed(AppRoutes.home);
      } else {
        // Token is expired, clear data and go to login
        await SharedPreferencesService.clearUserData();
        Get.offAllNamed(AppRoutes.login);
      }
    } catch (e) {
      // On any error, go to login
      await SharedPreferencesService.clearUserData();
      Get.offAllNamed(AppRoutes.login);
    }
  }

  Future<bool> _isTokenValid() async {
    try {
      final expiresAt = await SharedPreferencesService.getExpiresAt();
      
      if (expiresAt == null) {
        return false;
      }

      // Get current timestamp in seconds
      final currentTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      
      // Check if token is expired
      // Add a buffer of 60 seconds to refresh before actual expiration
      final isValid = expiresAt > (currentTimestamp + 60);
      
      return isValid;
    } catch (e) {
      return false;
    }
  }
}