// // lib/app/controllers/login_controller.dart
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import '../routes/app_routes.dart';
// import '../services/login_service.dart';
// import '../services/shared_preferences_service.dart';
// import '../models/login_response.dart';

// class LoginController extends GetxController {
//   final LoginService _loginService = LoginService();

//   // Form controllers
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   // Observable variables
//   RxBool isLoading = false.obs;
//   RxBool obscurePassword = true.obs;

//   // Toggle password visibility
//   void togglePasswordVisibility() {
//     obscurePassword.value = !obscurePassword.value;
//   }

//   // Login function
//   Future<void> login() async {
//     final email = emailController.text.trim();
//     final password = passwordController.text.trim();

//     // Validation
//     if (email.isEmpty || password.isEmpty) {
//       Get.snackbar(
//         'Error',
//         'Please enter both email and password',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//       return;
//     }

//     // Email validation
//     if (!GetUtils.isEmail(email)) {
//       Get.snackbar(
//         'Error',
//         'Please enter a valid email address',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//       return;
//     }

//     try {
//       isLoading.value = true;

//       // Call login API
//       final LoginResponse response = await _loginService.login(
//         email: email,
//         password: password,
//       );

//       isLoading.value = false;

//       if (response.status && response.data != null) {
//         // Save user data to SharedPreferences
//         await SharedPreferencesService.saveUserData(
//           userId: response.data!.user.id,
//           email: response.data!.user.email,
//           phone: response.data!.user.phone,
//           accessToken: response.data!.session.accessToken,
//           refreshToken: response.data!.session.refreshToken,
//           expiresAt: response.data!.session.expiresAt,
//         );

//         // Show success message
//         Get.snackbar(
//           'Success',
//           response.message,
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.green,
//           colorText: Colors.white,
//         );

//         // Clear text fields
//         emailController.clear();
//         passwordController.clear();

//         // Navigate to home
//         Get.offAllNamed(AppRoutes.home);
//       } else {
//         // Show error message
//         Get.snackbar(
//           'Login Failed',
//           response.message,
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//           duration: const Duration(seconds: 4),
//         );
//       }
//     } catch (e) {
//       isLoading.value = false;
//       Get.snackbar(
//         'Error',
//         'An unexpected error occurred: ${e.toString()}',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     }
//   }

//   @override
//   void onClose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.onClose();
//   }
// }

// // lib/controllers/login_controller.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:speechspectrum/services/shared_preferences_service.dart';
// import '../services/login_service.dart';
// import '../routes/app_routes.dart';

// class LoginController extends GetxController {
//   final LoginService _loginService = LoginService();
  
//   final RxBool isLoading = false.obs;
//   final RxString errorMessage = ''.obs;

//   Future<void> login(String email, String password) async {
//     try {
//       isLoading.value = true;
//       errorMessage.value = '';
      
//       final response = await _loginService.login(email, password);
      
//       if (response.status && response.data != null) {
//         // Login successful
//         Get.snackbar(
//           'Success',
//           response.message,
//           backgroundColor: Colors.green,
//           colorText: Colors.white,
//           snackPosition: SnackPosition.TOP,
//           duration: const Duration(seconds: 2),
//         );
        
//         // Get user role from shared preferences
//         final userRole = await SharedPreferencesService.getRole();

//         // Navigate based on role
//         if (userRole != null && userRole.toLowerCase() == 'expert') {
//           // Navigate to Expert Home
//           Get.offAllNamed(AppRoutes.expertHome);
//         } else {
//           // Navigate to Parent Home
//           Get.offAllNamed(AppRoutes.home);
//         }

//           Get.offAllNamed(AppRoutes.expertHome);        
//       } else {
//         // Login failed
//         errorMessage.value = response.message;
//         Get.snackbar(
//           'Login Failed',
//           response.message,
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//           snackPosition: SnackPosition.TOP,
//           duration: const Duration(seconds: 3),
//         );
//       }
//     } catch (e) {
//       errorMessage.value = 'An unexpected error occurred';
//       Get.snackbar(
//         'Error',
//         'An unexpected error occurred',
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//         snackPosition: SnackPosition.TOP,
//         duration: const Duration(seconds: 3),
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }

// lib/controllers/login_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speechspectrum/services/shared_preferences_service.dart';
import '../services/login_service.dart';
import '../routes/app_routes.dart';

class LoginController extends GetxController {
  final LoginService _loginService = LoginService();
  
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      final response = await _loginService.login(email, password);
      
      if (response.status && response.data != null) {
        // Login successful
        Get.snackbar(
          'Success',
          response.message,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 2),
        );
        
        // Get user role from the response data (more reliable than shared preferences at this point)
        final userRole = response.data!.role;

        // Navigate based on role
        if (userRole.toLowerCase() == 'expert') {
          // Navigate to Expert Home
          debugPrint('✅ Navigating to Expert Home');
          Get.offAllNamed(AppRoutes.expertHome);
        } else if (userRole.toLowerCase() == 'parent') {
          // Navigate to Parent Home
          debugPrint('✅ Navigating to Parent Home');
          Get.offAllNamed(AppRoutes.home);
        } else {
          // Fallback - use shared preferences role
          final savedRole = await SharedPreferencesService.getRole();
          debugPrint('⚠️ Unknown role from response: $userRole, checking saved role: $savedRole');
          
          if (savedRole?.toLowerCase() == 'expert') {
            Get.offAllNamed(AppRoutes.expertHome);
          } else {
            Get.offAllNamed(AppRoutes.home);
          }
        }
      } else {
        // Login failed
        errorMessage.value = response.message;
        Get.snackbar(
          'Login Failed',
          response.message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      errorMessage.value = 'An unexpected error occurred';
      debugPrint('❌ Login Controller Error: $e');
      Get.snackbar(
        'Error',
        'An unexpected error occurred',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }
}