// // lib/controllers/profile_controller.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/models/profile_model.dart';
// import 'package:speechspectrum/routes/app_routes.dart';
// import 'package:speechspectrum/services/logout_service.dart';
// import 'package:speechspectrum/services/profile_service.dart';

// class ProfileController extends GetxController {
//   final ProfileService _profileService = ProfileService();
//   final LogoutService _logoutService = LogoutService();

//   final Rx<ProfileModel?> profileModel = Rx<ProfileModel?>(null);
//   final RxBool isLoading = false.obs;
//   final RxBool isUpdating = false.obs;
//   final RxBool isLoggingOut = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchProfile();
//   }

//   // Get profile data
//   Future<void> fetchProfile() async {
//     try {
//       isLoading.value = true;
//       final profile = await _profileService.getProfile();
//       profileModel.value = profile;
//       debugPrint('✅ Profile loaded: ${profile.data.role}');
//     } catch (e) {
//       debugPrint('❌ Error fetching profile: $e');
//       Get.snackbar(
//         'Error',
//         e.toString(),
//         backgroundColor: AppColors.errorColor,
//         colorText: AppColors.whiteColor,
//         snackPosition: SnackPosition.TOP,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // Update profile
//   Future<void> updateProfile({
//     required String fullName,
//     required String phone,
//     String? specialization,
//     String? organization,
//     String? contactEmail,
//   }) async {
//     try {
//       isUpdating.value = true;
      
//       final updatedProfile = await _profileService.updateProfile(
//         fullName: fullName,
//         phone: phone,
//         specialization: specialization,
//         organization: organization,
//         contactEmail: contactEmail,
//       );

//       profileModel.value = updatedProfile;

//       Get.back();
      
//       Get.snackbar(
//         'Success',
//         'Profile updated successfully!',
//         backgroundColor: AppColors.successColor,
//         colorText: AppColors.whiteColor,
//         snackPosition: SnackPosition.TOP,
//       );

//       debugPrint('✅ Profile updated successfully');
//     } catch (e) {
//       debugPrint('❌ Error updating profile: $e');
//       Get.snackbar(
//         'Error',
//         e.toString(),
//         backgroundColor: AppColors.errorColor,
//         colorText: AppColors.whiteColor,
//         snackPosition: SnackPosition.TOP,
//       );
//     } finally {
//       isUpdating.value = false;
//     }
//   }

//   // Logout
//   Future<void> logout() async {
//     try {
//       isLoggingOut.value = true;

//       final response = await _logoutService.logout();

//       if (response.status) {
//         Get.offAllNamed(AppRoutes.login);
        
//         Get.snackbar(
//           'Success',
//           'Logged out successfully',
//           backgroundColor: AppColors.successColor,
//           colorText: AppColors.whiteColor,
//           snackPosition: SnackPosition.TOP,
//         );
//       }
//     } catch (e) {
//       debugPrint('❌ Logout error: $e');
//       // Even on error, navigate to login
//       Get.offAllNamed(AppRoutes.login);
//     } finally {
//       isLoggingOut.value = false;
//     }
//   }

//   // Helper methods
//   String get fullName {
//     if (profileModel.value == null) return '';
    
//     final data = profileModel.value!.data;
//     if (data.isParent()) {
//       return (data.profile as ParentProfile).fullName;
//     } else if (data.isExpert()) {
//       return (data.profile as ExpertProfile).fullName;
//     }
//     return '';
//   }

//   String get phone {
//     if (profileModel.value == null) return '';
    
//     final data = profileModel.value!.data;
//     if (data.isParent()) {
//       return (data.profile as ParentProfile).phone;
//     } else if (data.isExpert()) {
//       return (data.profile as ExpertProfile).phone;
//     }
//     return '';
//   }

//   String get roleDisplay {
//     if (profileModel.value == null) return '';
    
//     final role = profileModel.value!.data.role;
//     return role == 'expert' ? 'Therapist' : 'Parent';
//   }

//   String get userInitial {
//     return fullName.isNotEmpty ? fullName[0].toUpperCase() : 'U';
//   }
// }

// lib/controllers/profile_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/models/profile_model.dart';
import 'package:speechspectrum/routes/app_routes.dart';
import 'package:speechspectrum/services/logout_service.dart';
import 'package:speechspectrum/services/profile_service.dart';
import 'package:speechspectrum/services/shared_preferences_service.dart';

class ProfileController extends GetxController {
  final ProfileService _profileService = ProfileService();
  final LogoutService _logoutService = LogoutService();

  final Rx<ProfileModel?> profileModel = Rx<ProfileModel?>(null);
  final RxBool isLoading = false.obs;
  final RxBool isUpdating = false.obs;
  final RxBool isLoggingOut = false.obs;
  final RxBool isDeleting = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  // Get profile data
  Future<void> fetchProfile() async {
    try {
      isLoading.value = true;
      final profile = await _profileService.getProfile();
      profileModel.value = profile;
      debugPrint('✅ Profile loaded: ${profile.data.role}');
    } catch (e) {
      debugPrint('❌ Error fetching profile: $e');
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: AppColors.errorColor,
        colorText: AppColors.whiteColor,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Update profile
  Future<void> updateProfile({
    required String fullName,
    required String phone,
    String? specialization,
    String? organization,
    String? contactEmail,
  }) async {
    try {
      isUpdating.value = true;
      
      final updateResponse = await _profileService.updateProfile(
        fullName: fullName,
        phone: phone,
        specialization: specialization,
        organization: organization,
        contactEmail: contactEmail,
      );

      // Refresh profile data after update
      await fetchProfile();

      Get.back();
      
      Get.snackbar(
        'Success',
        updateResponse.message,
        backgroundColor: AppColors.successColor,
        colorText: AppColors.whiteColor,
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 2),
      );

      debugPrint('✅ Profile updated successfully');
    } catch (e) {
      debugPrint('❌ Error updating profile: $e');
      Get.snackbar(
        'Error',
        e.toString().replaceAll('Exception: ', ''),
        backgroundColor: AppColors.errorColor,
        colorText: AppColors.whiteColor,
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
      );
    } finally {
      isUpdating.value = false;
    }
  }

  // Delete profile
  Future<void> deleteProfile() async {
    try {
      isDeleting.value = true;

      final deleteResponse = await _profileService.deleteProfile();

      if (deleteResponse.status) {
        Get.offAllNamed(AppRoutes.login);
        
        Get.snackbar(
          'Account Deleted',
          deleteResponse.message,
          backgroundColor: AppColors.successColor,
          colorText: AppColors.whiteColor,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 2),
        );
         // ✅ Always clear local data
        await SharedPreferencesService.clearUserData();
        debugPrint('🧹 Local user data cleared');
        debugPrint('✅ Profile deleted successfully');
      } else {
        throw Exception(deleteResponse.error ?? deleteResponse.message);
      }
    } catch (e) {
      debugPrint('❌ Error deleting profile: $e');
      Get.snackbar(
        'Error',
        e.toString().replaceAll('Exception: ', ''),
        backgroundColor: AppColors.errorColor,
        colorText: AppColors.whiteColor,
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
      );
    } finally {
      isDeleting.value = false;
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      isLoggingOut.value = true;

      final response = await _logoutService.logout();

      if (response.status) {
        Get.offAllNamed(AppRoutes.login);
        
        Get.snackbar(
          'Success',
          'Logged out successfully',
          backgroundColor: AppColors.successColor,
          colorText: AppColors.whiteColor,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      debugPrint('❌ Logout error: $e');
      // Even on error, navigate to login
      Get.offAllNamed(AppRoutes.login);
    } finally {
      isLoggingOut.value = false;
    }
  }

  // Helper methods
  String get fullName {
    if (profileModel.value == null) return '';
    
    final data = profileModel.value!.data;
    if (data.isParent()) {
      return (data.profile as ParentProfile).fullName;
    } else if (data.isExpert()) {
      return (data.profile as ExpertProfile).fullName;
    }
    return '';
  }

  String get phone {
    if (profileModel.value == null) return '';
    
    final data = profileModel.value!.data;
    if (data.isParent()) {
      return (data.profile as ParentProfile).phone;
    } else if (data.isExpert()) {
      return (data.profile as ExpertProfile).phone;
    }
    return '';
  }

  String get roleDisplay {
    if (profileModel.value == null) return '';
    
    final role = profileModel.value!.data.role;
    return role == 'expert' ? 'Therapist' : 'Parent';
  }

  String get userInitial {
    return fullName.isNotEmpty ? fullName[0].toUpperCase() : 'U';
  }
}