// // lib/app/controllers/logout_controller.dart
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import '../routes/app_routes.dart';
// import '../services/logout_service.dart';
// import '../services/shared_preferences_service.dart';
// import '../models/logout_response.dart';

// class LogoutController extends GetxController {
//   final LogoutService _logoutService = LogoutService();

//   RxBool isLoading = false.obs;

//   // Logout function
//   Future<void> logout() async {
//     try {
//       isLoading.value = true;

//       // Call logout API
//       final LogoutResponse response = await _logoutService.logout();

//       isLoading.value = false;

//       // Clear local data regardless of API response
//       await SharedPreferencesService.clearUserData();

//       if (response.status) {
//         // Show success message
//         Get.snackbar(
//           'Success',
//           response.message,
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.green,
//           colorText: Colors.white,
//         );
//       }

//       // Navigate to login screen
//       Get.offAllNamed(AppRoutes.login);
//     } catch (e) {
//       isLoading.value = false;
      
//       // Even if API call fails, clear local data and logout
//       await SharedPreferencesService.clearUserData();
      
//       Get.snackbar(
//         'Logged Out',
//         'You have been logged out',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.orange,
//         colorText: Colors.white,
//       );

//       // Navigate to login screen
//       Get.offAllNamed(AppRoutes.login);
//     }
//   }

//   // Logout with confirmation dialog
//   Future<void> logoutWithConfirmation() async {
//     Get.dialog(
//       AlertDialog(
//         title: const Text('Logout'),
//         content: const Text('Are you sure you want to logout?'),
//         actions: [
//           TextButton(
//             onPressed: () => Get.back(),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               Get.back(); // Close dialog
//               logout(); // Perform logout
//             },
//             child: const Text(
//               'Logout',
//               style: TextStyle(color: Colors.red),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// lib/controllers/logout_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/logout_service.dart';
import '../routes/app_routes.dart';

class LogoutController extends GetxController {
  final LogoutService _logoutService = LogoutService();
  
  final RxBool isLoading = false.obs;

  Future<void> logout() async {
    try {
      isLoading.value = true;
      
      // Show loading dialog
      Get.dialog(
        const Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false,
      );
      
      final response = await _logoutService.logout();
      
      // Close loading dialog
      Get.back();
      
      if (response.status) {
        Get.snackbar(
          'Success',
          response.message,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 2),
        );
        
        // Navigate to login
        Get.offAllNamed(AppRoutes.login);
      } else {
        Get.snackbar(
          'Logout Failed',
          response.message,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 2),
        );
        
        // Still navigate to login as local data is cleared
        Get.offAllNamed(AppRoutes.login);
      }
    } catch (e) {
      // Close loading dialog if still open
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      
      Get.snackbar(
        'Error',
        'An error occurred during logout',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
      
      // Navigate to login anyway
      Get.offAllNamed(AppRoutes.login);
    } finally {
      isLoading.value = false;
    }
  }

  // Optional: Logout with confirmation dialog
  Future<void> logoutWithConfirmation() async {
    Get.dialog(
      AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back(); // Close dialog
              logout(); // Perform logout
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}