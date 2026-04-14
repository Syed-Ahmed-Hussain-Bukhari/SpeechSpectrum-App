// lib/controllers/expert_profile_controller.dart
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/models/expert_profile_model.dart';
import 'package:speechspectrum/routes/app_routes.dart';
import 'package:speechspectrum/services/expert_profile_service.dart';
import 'package:speechspectrum/services/logout_service.dart';
import 'package:speechspectrum/services/shared_preferences_service.dart';

class ExpertProfileController extends GetxController {
  final ExpertProfileService _service = ExpertProfileService();
  final LogoutService _logoutService = LogoutService();

  final Rx<ExpertProfileModel?> profileModel = Rx<ExpertProfileModel?>(null);
  final RxBool isLoading = false.obs;
  final RxBool isUpdating = false.obs;
  final RxBool isLoggingOut = false.obs;
  final RxBool isDeleting = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  // ── Fetch ──────────────────────────────────────────────────────
  Future<void> fetchProfile() async {
    try {
      isLoading.value = true;
      final profile = await _service.getProfile();
      profileModel.value = profile;
      debugPrint('✅ [Expert] Profile loaded');
    } catch (e) {
      debugPrint('❌ [Expert] Error fetching profile: $e');
      _showError(e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  // ── Update ─────────────────────────────────────────────────────
  Future<void> updateProfile({
    String? fullName,
    String? specialization,
    String? organization,
    String? contactEmail,
    String? phone,
  }) async {
    try {
      isUpdating.value = true;
      final response = await _service.updateProfile(
        fullName: fullName,
        specialization: specialization,
        organization: organization,
        contactEmail: contactEmail,
        phone: phone,
      );
      await fetchProfile();
      Get.back();
      _showSuccess(response.message);
    } catch (e) {
      debugPrint('❌ [Expert] Error updating profile: $e');
      _showError(e.toString().replaceAll('Exception: ', ''));
    } finally {
      isUpdating.value = false;
    }
  }

  // ── Delete ─────────────────────────────────────────────────────
  Future<void> deleteProfile() async {
    try {
      isDeleting.value = true;
      final response = await _service.deleteProfile();
      if (response.status) {
        await SharedPreferencesService.clearUserData();
        Get.offAllNamed(AppRoutes.login);
        _showSuccess(response.message);
      } else {
        throw Exception(response.error ?? response.message);
      }
    } catch (e) {
      debugPrint('❌ [Expert] Error deleting profile: $e');
      _showError(e.toString().replaceAll('Exception: ', ''));
    } finally {
      isDeleting.value = false;
    }
  }

  // ── Logout ─────────────────────────────────────────────────────
  Future<void> logout() async {
    try {
      isLoggingOut.value = true;
      await _logoutService.logout();
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      debugPrint('❌ [Expert] Logout error: $e');
      Get.offAllNamed(AppRoutes.login);
    } finally {
      isLoggingOut.value = false;
    }
  }

  // ── Helpers ────────────────────────────────────────────────────
  ExpertProfile? get profile => profileModel.value?.data.profile;

  String get fullName => profile?.fullName ?? '';
  String get phone => profile?.phone ?? '';
  String get specialization => profile?.specialization ?? '';
  String get organization => profile?.organization ?? '';
  String get contactEmail => profile?.contactEmail ?? '';
  String get pmdcNumber => profile?.pmdcNumber ?? '';
  String get approvalStatus => profile?.approvalStatus ?? 'pending';
  String get userInitial =>
      fullName.isNotEmpty ? fullName[0].toUpperCase() : 'E';

  bool get isApproved => approvalStatus == 'approved';

  void _showSuccess(String msg) => Get.snackbar(
        'Success', msg,
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.successColor,
        colorText: AppColors.whiteColor,
        duration: const Duration(seconds: 2),
      );

  void _showError(String msg) => Get.snackbar(
        'Error', msg,
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.errorColor,
        colorText: AppColors.whiteColor,
        duration: const Duration(seconds: 3),
      );
}