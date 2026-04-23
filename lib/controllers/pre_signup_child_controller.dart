// lib/controllers/pre_signup_child_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/services/child_service.dart';

/// Holds child data entered BEFORE signup.
/// After signup succeeds and a token is available,
/// [createAllChildren] is called with that token to register each child.
class PreSignupChildController extends GetxController {
  final ChildService _childService = ChildService();

  final RxInt childCount = 1.obs;
  final RxBool isLoading = false.obs;

  // List of child data maps: {name, dob, dobDisplay, gender}
  final RxList<Map<String, dynamic>> _children =
      <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initChildren(1);
  }

  // ── Public API ────────────────────────────────────────────────────────────

  void setChildCount(int count) {
    childCount.value = count;
    _initChildren(count);
  }

  Map<String, dynamic> getChildData(int index) {
    if (index < _children.length) return Map<String, dynamic>.from(_children[index]);
    return {'name': '', 'dob': '', 'dobDisplay': '', 'gender': 'male'};
  }

  void updateChild(
    int index, {
    String? name,
    String? dob,
    String? dobDisplay,
    String? gender,
  }) {
    if (index >= _children.length) return;
    final updated = Map<String, dynamic>.from(_children[index]);
    if (name != null) updated['name'] = name;
    if (dob != null) updated['dob'] = dob;
    if (dobDisplay != null) updated['dobDisplay'] = dobDisplay;
    if (gender != null) updated['gender'] = gender;
    _children[index] = updated;
    // Trigger rebuild for Obx widgets watching individual child gender
    _children.refresh();
  }

  /// Validate all child forms. Returns true if all are valid.
  bool validateAll() {
    for (int i = 0; i < childCount.value; i++) {
      final d = _children[i];
      final name = (d['name'] as String? ?? '').trim();
      final dob = (d['dob'] as String? ?? '').trim();

      if (name.isEmpty || name.length < 2) {
        _snack('Validation Error',
            'Please enter a valid name for Child ${i + 1} (min 2 characters)');
        return false;
      }
      if (dob.isEmpty) {
        _snack('Validation Error',
            'Please select date of birth for Child ${i + 1}');
        return false;
      }
    }
    return true;
  }

  /// Called from [RegistrationController] after signup succeeds.
  /// Creates each child using the freshly obtained [token].
  /// Returns true if ALL children were created successfully.
  Future<bool> createAllChildren(String token) async {
    try {
      isLoading.value = true;
      debugPrint(
          '👶 Creating ${childCount.value} child(ren) with fresh token...');

      for (int i = 0; i < childCount.value; i++) {
        final d = _children[i];
        final name = (d['name'] as String? ?? '').trim();
        final dob = (d['dob'] as String? ?? '').trim();
        final gender = (d['gender'] as String? ?? 'male');

        debugPrint('👶 Creating child ${i + 1}: $name ($gender) DOB: $dob');

        final response = await _childService.createChildWithToken(
          token: token,
          childName: name,
          dateOfBirth: dob,
          gender: gender,
        );

        if (!response.status) {
          debugPrint('❌ Failed to create child ${i + 1}: ${response.message}');
          _snack('Child Creation Failed',
              'Failed to create profile for ${name.isNotEmpty ? name : "Child ${i + 1}"}');
          return false;
        }

        debugPrint('✅ Child ${i + 1} created: ${response.data?.childId}');
      }

      debugPrint('✅ All ${childCount.value} child(ren) created successfully');
      return true;
    } catch (e) {
      debugPrint('❌ createAllChildren error: $e');
      _snack('Error',
          'Could not create child profiles. You can add them later from the app.');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  void _initChildren(int count) {
    // Preserve existing data when expanding
    while (_children.length < count) {
      _children.add({'name': '', 'dob': '', 'dobDisplay': '', 'gender': 'male'});
    }
    // Trim if shrinking
    while (_children.length > count) {
      _children.removeLast();
    }
  }

  void _snack(String title, String msg) {
    Get.snackbar(
      title,
      msg,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.errorColor,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 4),
    );
  }
}