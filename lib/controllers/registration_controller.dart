// import 'package:get/get.dart';
// import '../routes/app_routes.dart';

// class RegistrationController extends GetxController {
//   // User data
//   RxString role = ''.obs;
//   RxString firstName = ''.obs;
//   RxString lastName = ''.obs;
//   RxString fullName = ''.obs;
//   RxString phoneNumber = ''.obs;
//   RxString email = ''.obs;
//   RxString password = ''.obs;

//   void setRole(String userRole) {
//     role.value = userRole;
//   }

//   void setNames(String first, String last) {
//     firstName.value = first;
//     lastName.value = last;
//     fullName.value = '$first $last';
//   }

//   void setPhoneNumber(String phone) {
//     phoneNumber.value = phone;
//   }

//   void setEmailAndPassword(String userEmail, String userPassword) {
//     email.value = userEmail;
//     password.value = userPassword;
//   }

//   void registerUser() {
//     // Print data in required format
//     print('''
// {
//     "email": "${email.value}",
//     "password": "${password.value}",
//     "full_name": "${fullName.value}",
//     "phone": "${phoneNumber.value}",
//     "role": "${role.value}"
// }
//     ''');
    
//     // Navigate to home or next screen
//     Get.offAllNamed(AppRoutes.home);
//   }
// }


// lib/app/controllers/registration_controller.dart
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../routes/app_routes.dart';
import '../services/signup_service.dart';
import '../services/shared_preferences_service.dart';
import '../models/signup_response.dart';

class RegistrationController extends GetxController {
  final SignupService _signupService = SignupService();
  
  // User data
  RxString role = ''.obs;
  RxString firstName = ''.obs;
  RxString lastName = ''.obs;
  RxString fullName = ''.obs;
  RxString phoneNumber = ''.obs;
  RxString email = ''.obs;
  RxString password = ''.obs;
  
  // Loading state
  RxBool isLoading = false.obs;

  void setRole(String userRole) {
    role.value = userRole;
  }

  void setNames(String first, String last) {
    firstName.value = first;
    lastName.value = last;
    fullName.value = '$first $last';
  }

  void setPhoneNumber(String phone) {
    phoneNumber.value = phone;
  }

  void setEmailAndPassword(String userEmail, String userPassword) {
    email.value = userEmail;
    password.value = userPassword;
  }

  Future<void> registerUser() async {
    // Validate data
    if (email.value.isEmpty || 
        password.value.isEmpty || 
        fullName.value.isEmpty || 
        phoneNumber.value.isEmpty || 
        role.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all required fields',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;

      // Call signup API
      final SignupResponse response = await _signupService.signup(
        email: email.value,
        password: password.value,
        fullName: fullName.value,
        phone: phoneNumber.value,
        role: role.value,
      );

      isLoading.value = false;

      if (response.status && response.data != null) {
        // Save user data to SharedPreferences
        await SharedPreferencesService.saveUserData(
          userId: response.data!.user.id,
          email: response.data!.user.email,
          fullName: response.data!.profile.fullName,
          phone: response.data!.profile.phone,
          accessToken: response.data!.session.accessToken,
          refreshToken: response.data!.session.refreshToken,
          role: role.value,
          expiresAt: response.data!.session.expiresAt,
        );

        // Show success message
        Get.snackbar(
          'Success',
          response.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Navigate to home
        Get.offAllNamed(AppRoutes.home);
      } else {
        // Show error message
        Get.snackbar(
          'Signup Failed',
          response.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 4),
        );
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'An unexpected error occurred: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}