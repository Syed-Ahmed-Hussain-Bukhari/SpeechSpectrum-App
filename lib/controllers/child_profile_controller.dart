// // lib/controllers/child_profile_controller.dart
// import 'package:get/get.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/models/child_profile_model.dart';
// import 'package:speechspectrum/services/child_profile_service.dart';
// import 'package:flutter/material.dart';

// class ChildProfileController extends GetxController {
//   final ChildProfileService _service = ChildProfileService();

//   final isLoadingProfile = false.obs;
//   final isLoadingHealth = false.obs;

//   final childProfile = Rxn<ChildData>();
//   final childHealth = Rxn<ChildHealthData>();

//   // Track the last loaded childId so we don't re-fetch unnecessarily
//   String? _lastChildId;

//   Future<void> loadAll(String childId) async {
//     if (_lastChildId == childId &&
//         childProfile.value != null &&
//         childHealth.value != null) {
//       return; // already loaded
//     }
//     _lastChildId = childId;
//     childProfile.value = null;
//     childHealth.value = null;
//     await Future.wait([
//       _loadProfile(childId),
//       _loadHealth(childId),
//     ]);
//   }

//   Future<void> refresh(String childId) async {
//     _lastChildId = null;
//     await loadAll(childId);
//   }

//   Future<void> _loadProfile(String childId) async {
//     try {
//       isLoadingProfile.value = true;
//       final result = await _service.getChildProfile(childId);
//       if (result.status) {
//         childProfile.value = result.data;
//       }
//     } catch (e) {
//       _showError(e.toString().replaceAll('Exception: ', ''));
//     } finally {
//       isLoadingProfile.value = false;
//     }
//   }

//   Future<void> _loadHealth(String childId) async {
//     try {
//       isLoadingHealth.value = true;
//       final result = await _service.getChildHealth(childId);
//       if (result.status) {
//         childHealth.value = result.data;
//       }
//     } catch (_) {
//       // Health profile might not exist — silently ignore
//     } finally {
//       isLoadingHealth.value = false;
//     }
//   }

//   void _showError(String msg) {
//     Get.snackbar(
//       '❌ Error',
//       msg,
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: AppColors.errorColor,
//       colorText: Colors.white,
//       margin: const EdgeInsets.all(16),
//       borderRadius: 14,
//       duration: const Duration(seconds: 4),
//     );
//   }
// }


// lib/controllers/child_profile_controller.dart
import 'package:get/get.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/models/child_profile_model.dart';
import 'package:speechspectrum/services/child_profile_service.dart';
import 'package:flutter/material.dart';

class ChildProfileController extends GetxController {
  final ChildProfileService _service = ChildProfileService();

  final isLoadingProfile = false.obs;
  final isLoadingHealth = false.obs;

  final childProfile = Rxn<ChildData>();
  final childHealth = Rxn<ChildHealthData>();

  // Track the last loaded childId so we don't re-fetch unnecessarily
  String? _lastChildId;

  Future<void> loadAll(String childId) async {
    if (_lastChildId == childId &&
        childProfile.value != null &&
        childHealth.value != null) {
      return; // already loaded
    }
    _lastChildId = childId;
    childProfile.value = null;
    childHealth.value = null;
    await Future.wait([
      _loadProfile(childId),
      _loadHealth(childId),
    ]);
  }

  // Renamed from refresh() to avoid conflict with GetX's inherited refresh()
  Future<void> refreshProfile(String childId) async {
    _lastChildId = null;
    await loadAll(childId);
  }

  Future<void> _loadProfile(String childId) async {
    try {
      isLoadingProfile.value = true;
      final result = await _service.getChildProfile(childId);
      if (result.status) {
        childProfile.value = result.data;
      }
    } catch (e) {
      _showError(e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoadingProfile.value = false;
    }
  }

  Future<void> _loadHealth(String childId) async {
    try {
      isLoadingHealth.value = true;
      final result = await _service.getChildHealth(childId);
      if (result.status) {
        childHealth.value = result.data;
      }
    } catch (_) {
      // Health profile might not exist — silently ignore
    } finally {
      isLoadingHealth.value = false;
    }
  }

  void _showError(String msg) {
    Get.snackbar(
      '❌ Error',
      msg,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.errorColor,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 14,
      duration: const Duration(seconds: 4),
    );
  }
}