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


// // lib/app/controllers/registration_controller.dart
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import '../routes/app_routes.dart';
// import '../services/signup_service.dart';
// import '../services/shared_preferences_service.dart';
// import '../models/signup_response.dart';

// class RegistrationController extends GetxController {
//   final SignupService _signupService = SignupService();
  
//   // User data
//   RxString role = ''.obs;
//   RxString firstName = ''.obs;
//   RxString lastName = ''.obs;
//   RxString fullName = ''.obs;
//   RxString phoneNumber = ''.obs;
//   RxString email = ''.obs;
//   RxString password = ''.obs;
  
//   // Loading state
//   RxBool isLoading = false.obs;

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

//   Future<void> registerUser() async {
//     // Validate data
//     if (email.value.isEmpty || 
//         password.value.isEmpty || 
//         fullName.value.isEmpty || 
//         phoneNumber.value.isEmpty || 
//         role.value.isEmpty) {
//       Get.snackbar(
//         'Error',
//         'Please fill all required fields',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//       return;
//     }

//     try {
//       isLoading.value = true;

//       // Call signup API
//       final SignupResponse response = await _signupService.signup(
//         email: email.value,
//         password: password.value,
//         fullName: fullName.value,
//         phone: phoneNumber.value,
//         role: role.value,
//       );

//       isLoading.value = false;

//       if (response.status && response.data != null) {
//         // Save user data to SharedPreferences
//         await SharedPreferencesService.saveUserData(
//           userId: response.data!.user.id,
//           email: response.data!.user.email,
//           fullName: response.data!.profile.fullName,
//           phone: response.data!.profile.phone,
//           accessToken: response.data!.session.accessToken,
//           refreshToken: response.data!.session.refreshToken,
//           role: role.value,
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

//         // Navigate to home
//         Get.offAllNamed(AppRoutes.home);
//       } else {
//         // Show error message
//         Get.snackbar(
//           'Signup Failed',
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
// }


// lib/app/controllers/registration_controller.dart
import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../routes/app_routes.dart';
import '../services/signup_service.dart';
import '../services/expert_signup_service.dart';
import '../services/storage_service.dart';
import '../services/shared_preferences_service.dart';
import '../models/signup_response.dart';
import '../models/expert_signup_response.dart';

class RegistrationController extends GetxController {
  final SignupService _signupService = SignupService();
  final ExpertSignupService _expertSignupService = ExpertSignupService();
  final StorageService _storageService = StorageService();
  
  // Common user data
  RxString role = ''.obs;
  RxString firstName = ''.obs;
  RxString lastName = ''.obs;
  RxString fullName = ''.obs;
  RxString phoneNumber = ''.obs;
  RxString email = ''.obs;
  RxString password = ''.obs;
  
  // Expert-specific data
  RxString specialization = ''.obs;
  RxString organization = ''.obs;
  RxString contactEmail = ''.obs;
  RxString pmdcNumber = ''.obs;
  RxString profileImagePublicId = ''.obs;
  RxString degreeDocPublicId = ''.obs;
  RxString certificateDocPublicId = ''.obs;
  
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

  void setExpertInfo({
    required String specialization,
    required String organization,
    required String contactEmail,
    required String pmdcNumber,
  }) {
    this.specialization.value = specialization;
    this.organization.value = organization;
    this.contactEmail.value = contactEmail;
    this.pmdcNumber.value = pmdcNumber;
  }

  Future<bool> uploadExpertDocuments({
    required File profileImage,
    required File degreeDoc,
    required File certificateDoc,
  }) async {
    try {
      isLoading.value = true;

      // Upload profile image
      Get.snackbar(
        'Uploading',
        'Uploading profile image...',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );

      final profileImageId = await _storageService.uploadImage(profileImage);
      if (profileImageId == null) {
        isLoading.value = false;
        Get.snackbar(
          'Upload Failed',
          'Failed to upload profile image',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }
      profileImagePublicId.value = profileImageId;

      // Upload degree document
      Get.snackbar(
        'Uploading',
        'Uploading degree document...',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );

      final degreeDocId = await _storageService.uploadDocument(degreeDoc);
      if (degreeDocId == null) {
        isLoading.value = false;
        Get.snackbar(
          'Upload Failed',
          'Failed to upload degree document. Only PDF files are allowed.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }
      degreeDocPublicId.value = degreeDocId;

      // Upload certificate document
      Get.snackbar(
        'Uploading',
        'Uploading certificate document...',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );

      final certificateDocId = await _storageService.uploadDocument(certificateDoc);
      if (certificateDocId == null) {
        isLoading.value = false;
        Get.snackbar(
          'Upload Failed',
          'Failed to upload certificate document. Only PDF files are allowed.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }
      certificateDocPublicId.value = certificateDocId;

      isLoading.value = false;

      Get.snackbar(
        'Success',
        'All documents uploaded successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      return true;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'An error occurred while uploading documents: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }
  }

  Future<void> registerUser() async {
    // Check role and call appropriate signup method
    if (role.value == 'expert') {
      await _registerExpert();
    } else {
      await _registerParent();
    }
  }

  Future<void> _registerParent() async {
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

      // Call parent signup API
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

  Future<void> _registerExpert() async {
    // Validate expert data
    if (email.value.isEmpty || 
        password.value.isEmpty || 
        fullName.value.isEmpty || 
        phoneNumber.value.isEmpty ||
        specialization.value.isEmpty ||
        organization.value.isEmpty ||
        contactEmail.value.isEmpty ||
        pmdcNumber.value.isEmpty ||
        profileImagePublicId.value.isEmpty ||
        degreeDocPublicId.value.isEmpty ||
        certificateDocPublicId.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all required fields and upload all documents',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;

      // Call expert signup API
      final ExpertSignupResponse response = await _expertSignupService.signup(
        email: email.value,
        password: password.value,
        fullName: fullName.value,
        phone: phoneNumber.value,
        specialization: specialization.value,
        organization: organization.value,
        contactEmail: contactEmail.value,
        pmdcNumber: pmdcNumber.value,
        profileImagePublicId: profileImagePublicId.value,
        degreeDocPublicId: degreeDocPublicId.value,
        certificateDocPublicId: certificateDocPublicId.value,
      );

      isLoading.value = false;

      if (response.status && response.data != null) {
        // For experts, save minimal data as they need admin approval
        await SharedPreferencesService.saveUserData(
          userId: response.data!.user.id,
          email: response.data!.user.email,
          fullName: response.data!.profile.fullName,
          phone: response.data!.profile.phone,
          accessToken: '', // No session token until approved
          refreshToken: '',
          role: 'expert',
          expiresAt: 0,
        );

        // Show success message with approval info
        Get.snackbar(
          'Registration Successful',
          response.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
        );

        // Navigate to a pending approval screen or login
        // You may want to create a separate screen for pending approval
        Get.offAllNamed(AppRoutes.login); // Or AppRoutes.pendingApproval
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