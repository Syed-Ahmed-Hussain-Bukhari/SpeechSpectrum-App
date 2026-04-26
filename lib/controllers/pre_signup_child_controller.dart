// // // lib/controllers/pre_signup_child_controller.dart
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:speechspectrum/constants/app_colors.dart';
// // import 'package:speechspectrum/services/child_service.dart';

// // /// Holds child data entered BEFORE signup.
// // /// After signup succeeds and a token is available,
// // /// [createAllChildren] is called with that token to register each child.
// // class PreSignupChildController extends GetxController {
// //   final ChildService _childService = ChildService();

// //   final RxInt childCount = 1.obs;
// //   final RxBool isLoading = false.obs;

// //   // List of child data maps: {name, dob, dobDisplay, gender}
// //   final RxList<Map<String, dynamic>> _children =
// //       <Map<String, dynamic>>[].obs;

// //   @override
// //   void onInit() {
// //     super.onInit();
// //     _initChildren(1);
// //   }

// //   // ── Public API ────────────────────────────────────────────────────────────

// //   void setChildCount(int count) {
// //     childCount.value = count;
// //     _initChildren(count);
// //   }

// //   Map<String, dynamic> getChildData(int index) {
// //     if (index < _children.length) return Map<String, dynamic>.from(_children[index]);
// //     return {'name': '', 'dob': '', 'dobDisplay': '', 'gender': 'male'};
// //   }

// //   void updateChild(
// //     int index, {
// //     String? name,
// //     String? dob,
// //     String? dobDisplay,
// //     String? gender,
// //   }) {
// //     if (index >= _children.length) return;
// //     final updated = Map<String, dynamic>.from(_children[index]);
// //     if (name != null) updated['name'] = name;
// //     if (dob != null) updated['dob'] = dob;
// //     if (dobDisplay != null) updated['dobDisplay'] = dobDisplay;
// //     if (gender != null) updated['gender'] = gender;
// //     _children[index] = updated;
// //     // Trigger rebuild for Obx widgets watching individual child gender
// //     _children.refresh();
// //   }

// //   /// Validate all child forms. Returns true if all are valid.
// //   bool validateAll() {
// //     for (int i = 0; i < childCount.value; i++) {
// //       final d = _children[i];
// //       final name = (d['name'] as String? ?? '').trim();
// //       final dob = (d['dob'] as String? ?? '').trim();

// //       if (name.isEmpty || name.length < 2) {
// //         _snack('Validation Error',
// //             'Please enter a valid name for Child ${i + 1} (min 2 characters)');
// //         return false;
// //       }
// //       if (dob.isEmpty) {
// //         _snack('Validation Error',
// //             'Please select date of birth for Child ${i + 1}');
// //         return false;
// //       }
// //     }
// //     return true;
// //   }

// //   /// Called from [RegistrationController] after signup succeeds.
// //   /// Creates each child using the freshly obtained [token].
// //   /// Returns true if ALL children were created successfully.
// //   Future<bool> createAllChildren(String token) async {
// //     try {
// //       isLoading.value = true;
// //       debugPrint(
// //           '👶 Creating ${childCount.value} child(ren) with fresh token...');

// //       for (int i = 0; i < childCount.value; i++) {
// //         final d = _children[i];
// //         final name = (d['name'] as String? ?? '').trim();
// //         final dob = (d['dob'] as String? ?? '').trim();
// //         final gender = (d['gender'] as String? ?? 'male');

// //         debugPrint('👶 Creating child ${i + 1}: $name ($gender) DOB: $dob');

// //         final response = await _childService.createChildWithToken(
// //           token: token,
// //           childName: name,
// //           dateOfBirth: dob,
// //           gender: gender,
// //         );

// //         if (!response.status) {
// //           debugPrint('❌ Failed to create child ${i + 1}: ${response.message}');
// //           _snack('Child Creation Failed',
// //               'Failed to create profile for ${name.isNotEmpty ? name : "Child ${i + 1}"}');
// //           return false;
// //         }

// //         debugPrint('✅ Child ${i + 1} created: ${response.data?.childId}');
// //       }

// //       debugPrint('✅ All ${childCount.value} child(ren) created successfully');
// //       return true;
// //     } catch (e) {
// //       debugPrint('❌ createAllChildren error: $e');
// //       _snack('Error',
// //           'Could not create child profiles. You can add them later from the app.');
// //       return false;
// //     } finally {
// //       isLoading.value = false;
// //     }
// //   }

// //   // ── Helpers ───────────────────────────────────────────────────────────────

// //   void _initChildren(int count) {
// //     // Preserve existing data when expanding
// //     while (_children.length < count) {
// //       _children.add({'name': '', 'dob': '', 'dobDisplay': '', 'gender': 'male'});
// //     }
// //     // Trim if shrinking
// //     while (_children.length > count) {
// //       _children.removeLast();
// //     }
// //   }

// //   void _snack(String title, String msg) {
// //     Get.snackbar(
// //       title,
// //       msg,
// //       snackPosition: SnackPosition.BOTTOM,
// //       backgroundColor: AppColors.errorColor,
// //       colorText: Colors.white,
// //       margin: const EdgeInsets.all(16),
// //       borderRadius: 12,
// //       duration: const Duration(seconds: 4),
// //     );
// //   }
// // }


// // lib/controllers/pre_signup_child_controller.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/services/child_service.dart';
// import 'package:speechspectrum/services/reg_child_health_service.dart'; // ← new service

// class PreSignupChildController extends GetxController {
//   final ChildService _childService = ChildService();
//   final RegChildHealthService _regHealthService = RegChildHealthService();

//   final RxInt childCount = 1.obs;
//   final RxBool isLoading = false.obs;

//   final RxList<Map<String, dynamic>> _children =
//       <Map<String, dynamic>>[].obs;

//   @override
//   void onInit() {
//     super.onInit();
//     _initChildren(1);
//   }

//   // ── Public API ────────────────────────────────────────────────────────────

//   void setChildCount(int count) {
//     childCount.value = count;
//     _initChildren(count);
//   }

//   Map<String, dynamic> getChildData(int index) {
//     if (index < _children.length) {
//       return Map<String, dynamic>.from(_children[index]);
//     }
//     return _defaultChild();
//   }

//   void updateChild(
//     int index, {
//     String? name,
//     String? dob,
//     String? dobDisplay,
//     String? gender,
//     String? bloodGroup,
//     String? knownAllergies,
//     bool? familyHistoryAsd,
//     bool? familyHistorySpeech,
//     bool? familyHistoryHearing,
//     String? geneticDisorders,
//     String? chronicConditions,
//     String? weightKg,
//     String? heightCm,
//   }) {
//     if (index >= _children.length) return;
//     final updated = Map<String, dynamic>.from(_children[index]);
//     if (name != null) updated['name'] = name;
//     if (dob != null) updated['dob'] = dob;
//     if (dobDisplay != null) updated['dobDisplay'] = dobDisplay;
//     if (gender != null) updated['gender'] = gender;
//     if (bloodGroup != null) updated['bloodGroup'] = bloodGroup;
//     if (knownAllergies != null) updated['knownAllergies'] = knownAllergies;
//     if (familyHistoryAsd != null) updated['familyHistoryAsd'] = familyHistoryAsd;
//     if (familyHistorySpeech != null) updated['familyHistorySpeech'] = familyHistorySpeech;
//     if (familyHistoryHearing != null) updated['familyHistoryHearing'] = familyHistoryHearing;
//     if (geneticDisorders != null) updated['geneticDisorders'] = geneticDisorders;
//     if (chronicConditions != null) updated['chronicConditions'] = chronicConditions;
//     if (weightKg != null) updated['weightKg'] = weightKg;
//     if (heightCm != null) updated['heightCm'] = heightCm;
//     _children[index] = updated;
//     _children.refresh();
//   }

//   void addDocument(int index,
//       {required String path, required String type, required String name}) {
//     if (index >= _children.length) return;
//     final updated = Map<String, dynamic>.from(_children[index]);
//     final docs = List<Map<String, String>>.from(
//         (updated['documents'] as List?)
//                 ?.map((d) => Map<String, String>.from(d as Map))
//                 .toList() ??
//             []);
//     docs.add({'path': path, 'type': type, 'name': name});
//     updated['documents'] = docs;
//     _children[index] = updated;
//     _children.refresh();
//   }

//   void removeDocument(int childIndex, int docIndex) {
//     if (childIndex >= _children.length) return;
//     final updated = Map<String, dynamic>.from(_children[childIndex]);
//     final docs = List<Map<String, String>>.from(
//         (updated['documents'] as List?)
//                 ?.map((d) => Map<String, String>.from(d as Map))
//                 .toList() ??
//             []);
//     if (docIndex < docs.length) docs.removeAt(docIndex);
//     updated['documents'] = docs;
//     _children[childIndex] = updated;
//     _children.refresh();
//   }

//   void updateDocumentType(int childIndex, int docIndex, String newType) {
//     if (childIndex >= _children.length) return;
//     final updated = Map<String, dynamic>.from(_children[childIndex]);
//     final docs = List<Map<String, String>>.from(
//         (updated['documents'] as List?)
//                 ?.map((d) => Map<String, String>.from(d as Map))
//                 .toList() ??
//             []);
//     if (docIndex < docs.length) {
//       docs[docIndex] = {...docs[docIndex], 'type': newType};
//     }
//     updated['documents'] = docs;
//     _children[childIndex] = updated;
//     _children.refresh();
//   }

//   List<Map<String, String>> getDocuments(int index) {
//     if (index >= _children.length) return [];
//     final docs = _children[index]['documents'];
//     if (docs == null) return [];
//     return (docs as List)
//         .map((d) => Map<String, String>.from(d as Map))
//         .toList();
//   }

//   bool validateAll() {
//     for (int i = 0; i < childCount.value; i++) {
//       final d = _children[i];
//       final name = (d['name'] as String? ?? '').trim();
//       final dob = (d['dob'] as String? ?? '').trim();
//       if (name.isEmpty || name.length < 2) {
//         _snack('Validation Error',
//             'Please enter a valid name for Child ${i + 1} (min 2 characters)');
//         return false;
//       }
//       if (dob.isEmpty) {
//         _snack('Validation Error',
//             'Please select date of birth for Child ${i + 1}');
//         return false;
//       }
//     }
//     return true;
//   }

//   /// Full 3-step flow per child after signup succeeds:
//   ///   1. Create child          → POST /api/children
//   ///   2. Save health profile   → POST /api/children/health/:childId  (if filled)
//   ///   3. Upload each document  → POST /api/children/health/:childId/records
//   ///                              (one call per document)
//   Future<bool> createAllChildren(String token) async {
//     try {
//       isLoading.value = true;
//       debugPrint('👶 Creating ${childCount.value} child(ren)...');

//       for (int i = 0; i < childCount.value; i++) {
//         final d = _children[i];
//         final name = (d['name'] as String? ?? '').trim();
//         final dob = (d['dob'] as String? ?? '').trim();
//         final gender = (d['gender'] as String? ?? 'male');

//         // ── STEP 1: Create child ──────────────────────────────────────
//         debugPrint('👶 [${i + 1}] Creating: $name ($gender) $dob');
//         final childResp = await _childService.createChildWithToken(
//           token: token,
//           childName: name,
//           dateOfBirth: dob,
//           gender: gender,
//         );

//         if (!childResp.status || childResp.data == null) {
//           debugPrint('❌ Failed to create child ${i + 1}: ${childResp.message}');
//           _snack('Child Creation Failed',
//               'Failed to create profile for ${name.isNotEmpty ? name : "Child ${i + 1}"}');
//           return false;
//         }

//         final childId = childResp.data!.childId;
//         debugPrint('✅ [${i + 1}] Child created → $childId');

//         // ── STEP 2: Health profile (optional, non-fatal) ──────────────
//         if (_hasHealthData(d)) {
//           debugPrint('🏥 [${i + 1}] Saving health profile...');
//           try {
//             await _regHealthService.saveHealthProfile(
//               childId: childId,
//               token: token,
//               data: _buildHealthPayload(d),
//             );
//             debugPrint('✅ [${i + 1}] Health profile saved');
//           } catch (e) {
//             debugPrint('⚠️ [${i + 1}] Health save failed (non-fatal): $e');
//           }
//         }

//         // ── STEP 3: Upload documents one by one (non-fatal) ───────────
//         final docs = getDocuments(i);
//         if (docs.isNotEmpty) {
//           debugPrint('📄 [${i + 1}] Uploading ${docs.length} doc(s)...');
//           for (int j = 0; j < docs.length; j++) {
//             final doc = docs[j];
//             debugPrint(
//                 '📄 [${i + 1}] Doc ${j + 1}/${docs.length}: ${doc['name']} (${doc['type']})');
//             try {
//               await _regHealthService.uploadMedicalRecord(
//                 childId: childId,
//                 token: token,
//                 filePath: doc['path']!,
//                 documentType: doc['type']!,
//               );
//               debugPrint('✅ [${i + 1}] Doc ${j + 1} uploaded');
//             } catch (e) {
//               debugPrint('⚠️ [${i + 1}] Doc ${j + 1} failed (non-fatal): $e');
//             }
//           }
//         }
//       }

//       debugPrint('✅ All ${childCount.value} child(ren) done');
//       return true;
//     } catch (e) {
//       debugPrint('❌ createAllChildren error: $e');
//       _snack('Error',
//           'Could not create child profiles. You can add them later from the app.');
//       return false;
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // ── Helpers ───────────────────────────────────────────────────────────────

//   Map<String, dynamic> _defaultChild() => {
//         'name': '',
//         'dob': '',
//         'dobDisplay': '',
//         'gender': 'male',
//         'bloodGroup': '',
//         'knownAllergies': '',
//         'familyHistoryAsd': false,
//         'familyHistorySpeech': false,
//         'familyHistoryHearing': false,
//         'geneticDisorders': '',
//         'chronicConditions': '',
//         'weightKg': '',
//         'heightCm': '',
//         'documents': <Map<String, String>>[],
//       };

//   void _initChildren(int count) {
//     while (_children.length < count) {
//       _children.add(_defaultChild());
//     }
//     while (_children.length > count) {
//       _children.removeLast();
//     }
//   }

//   bool _hasHealthData(Map<String, dynamic> d) {
//     return (d['bloodGroup'] as String? ?? '').isNotEmpty ||
//         (d['knownAllergies'] as String? ?? '').isNotEmpty ||
//         (d['weightKg'] as String? ?? '').isNotEmpty ||
//         (d['heightCm'] as String? ?? '').isNotEmpty ||
//         (d['familyHistoryAsd'] as bool? ?? false) ||
//         (d['familyHistorySpeech'] as bool? ?? false) ||
//         (d['familyHistoryHearing'] as bool? ?? false);
//   }

//   Map<String, dynamic> _buildHealthPayload(Map<String, dynamic> d) {
//     final payload = <String, dynamic>{
//       'family_history_asd': d['familyHistoryAsd'] ?? false,
//       'family_history_speech_disorders': d['familyHistorySpeech'] ?? false,
//       'family_history_hearing_loss': d['familyHistoryHearing'] ?? false,
//     };
//     if ((d['bloodGroup'] as String? ?? '').isNotEmpty) {
//       payload['blood_group'] = d['bloodGroup'];
//     }
//     if ((d['knownAllergies'] as String? ?? '').isNotEmpty) {
//       payload['known_allergies'] = d['knownAllergies'];
//     }
//     if ((d['geneticDisorders'] as String? ?? '').isNotEmpty) {
//       payload['genetic_disorders'] = d['geneticDisorders'];
//     }
//     if ((d['chronicConditions'] as String? ?? '').isNotEmpty) {
//       payload['chronic_conditions'] = d['chronicConditions'];
//     }
//     if ((d['weightKg'] as String? ?? '').isNotEmpty) {
//       final w = double.tryParse(d['weightKg'] as String);
//       if (w != null) payload['weight_kg'] = w;
//     }
//     if ((d['heightCm'] as String? ?? '').isNotEmpty) {
//       final h = double.tryParse(d['heightCm'] as String);
//       if (h != null) payload['height_cm'] = h;
//     }
//     return payload;
//   }

//   void _snack(String title, String msg) {
//     Get.snackbar(
//       title,
//       msg,
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: AppColors.errorColor,
//       colorText: Colors.white,
//       margin: const EdgeInsets.all(16),
//       borderRadius: 12,
//       duration: const Duration(seconds: 4),
//     );
//   }
// }


// lib/controllers/pre_signup_child_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/services/child_service.dart';
import 'package:speechspectrum/services/reg_child_health_service.dart'; // ← new service

class PreSignupChildController extends GetxController {
  final ChildService _childService = ChildService();
  final RegChildHealthService _regHealthService = RegChildHealthService();

  final RxInt childCount = 1.obs;
  final RxBool isLoading = false.obs;

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
    if (index < _children.length) {
      return Map<String, dynamic>.from(_children[index]);
    }
    return _defaultChild();
  }

  void updateChild(
    int index, {
    String? name,
    String? dob,
    String? dobDisplay,
    String? gender,
    String? bloodGroup,
    String? knownAllergies,
    bool? familyHistoryAsd,
    bool? familyHistorySpeech,
    bool? familyHistoryHearing,
    String? geneticDisorders,
    String? chronicConditions,
    String? weightKg,
    String? heightCm,
  }) {
    if (index >= _children.length) return;
    final updated = Map<String, dynamic>.from(_children[index]);
    if (name != null) updated['name'] = name;
    if (dob != null) updated['dob'] = dob;
    if (dobDisplay != null) updated['dobDisplay'] = dobDisplay;
    if (gender != null) updated['gender'] = gender;
    if (bloodGroup != null) updated['bloodGroup'] = bloodGroup;
    if (knownAllergies != null) updated['knownAllergies'] = knownAllergies;
    if (familyHistoryAsd != null) updated['familyHistoryAsd'] = familyHistoryAsd;
    if (familyHistorySpeech != null) updated['familyHistorySpeech'] = familyHistorySpeech;
    if (familyHistoryHearing != null) updated['familyHistoryHearing'] = familyHistoryHearing;
    if (geneticDisorders != null) updated['geneticDisorders'] = geneticDisorders;
    if (chronicConditions != null) updated['chronicConditions'] = chronicConditions;
    if (weightKg != null) updated['weightKg'] = weightKg;
    if (heightCm != null) updated['heightCm'] = heightCm;
    _children[index] = updated;
    _children.refresh();
  }

  void addDocument(int index,
      {required String path, required String type, required String name}) {
    if (index >= _children.length) return;
    final updated = Map<String, dynamic>.from(_children[index]);
    final docs = List<Map<String, String>>.from(
        (updated['documents'] as List?)
                ?.map((d) => Map<String, String>.from(d as Map))
                .toList() ??
            []);
    docs.add({'path': path, 'type': type, 'name': name});
    updated['documents'] = docs;
    _children[index] = updated;
    _children.refresh();
  }

  void removeDocument(int childIndex, int docIndex) {
    if (childIndex >= _children.length) return;
    final updated = Map<String, dynamic>.from(_children[childIndex]);
    final docs = List<Map<String, String>>.from(
        (updated['documents'] as List?)
                ?.map((d) => Map<String, String>.from(d as Map))
                .toList() ??
            []);
    if (docIndex < docs.length) docs.removeAt(docIndex);
    updated['documents'] = docs;
    _children[childIndex] = updated;
    _children.refresh();
  }

  void updateDocumentType(int childIndex, int docIndex, String newType) {
    if (childIndex >= _children.length) return;
    final updated = Map<String, dynamic>.from(_children[childIndex]);
    final docs = List<Map<String, String>>.from(
        (updated['documents'] as List?)
                ?.map((d) => Map<String, String>.from(d as Map))
                .toList() ??
            []);
    if (docIndex < docs.length) {
      docs[docIndex] = {...docs[docIndex], 'type': newType};
    }
    updated['documents'] = docs;
    _children[childIndex] = updated;
    _children.refresh();
  }

  List<Map<String, String>> getDocuments(int index) {
    if (index >= _children.length) return [];
    final docs = _children[index]['documents'];
    if (docs == null) return [];
    return (docs as List)
        .map((d) => Map<String, String>.from(d as Map))
        .toList();
  }

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

  /// Full 3-step flow per child after signup succeeds:
  ///   1. Create child          → POST /api/children
  ///   2. Save health profile   → POST /api/children/health/:childId  (if filled)
  ///   3. Upload each document  → POST /api/children/health/:childId/records
  ///                              (one call per document)
  Future<bool> createAllChildren(String token) async {
    try {
      isLoading.value = true;
      debugPrint('👶 Creating ${childCount.value} child(ren)...');

      for (int i = 0; i < childCount.value; i++) {
        final d = _children[i];
        final name = (d['name'] as String? ?? '').trim();
        final dob = (d['dob'] as String? ?? '').trim();
        final gender = (d['gender'] as String? ?? 'male');

        // ── STEP 1: Create child ──────────────────────────────────────
        debugPrint('👶 [${i + 1}] Creating: $name ($gender) $dob');
        final childResp = await _childService.createChildWithToken(
          token: token,
          childName: name,
          dateOfBirth: dob,
          gender: gender,
        );

        if (!childResp.status || childResp.data == null) {
          debugPrint('❌ Failed to create child ${i + 1}: ${childResp.message}');
          _snack('Child Creation Failed',
              'Failed to create profile for ${name.isNotEmpty ? name : "Child ${i + 1}"}');
          return false;
        }

        final childId = childResp.data!.childId;
        debugPrint('✅ [${i + 1}] Child created → $childId');

        // ── STEP 2: Health profile (optional, non-fatal) ──────────────
        if (_hasHealthData(d)) {
          debugPrint('🏥 [${i + 1}] Saving health profile...');
          try {
            await _regHealthService.saveHealthProfile(
              childId: childId,
              token: token,
              data: _buildHealthPayload(d),
            );
            debugPrint('✅ [${i + 1}] Health profile saved');
          } catch (e) {
            debugPrint('⚠️ [${i + 1}] Health save failed (non-fatal): $e');
          }
        }

        // ── STEP 3: Upload documents one by one (non-fatal) ───────────
        final docs = getDocuments(i);
        if (docs.isNotEmpty) {
          debugPrint('📄 [${i + 1}] Uploading ${docs.length} doc(s)...');
          for (int j = 0; j < docs.length; j++) {
            final doc = docs[j];
            debugPrint(
                '📄 [${i + 1}] Doc ${j + 1}/${docs.length}: ${doc['name']} (${doc['type']})');
            try {
              await _regHealthService.uploadMedicalRecord(
                childId: childId,
                token: token,
                filePath: doc['path']!,
                documentType: doc['type']!,
              );
              debugPrint('✅ [${i + 1}] Doc ${j + 1} uploaded');
            } catch (e) {
              debugPrint('⚠️ [${i + 1}] Doc ${j + 1} failed (non-fatal): $e');
            }
          }
        }
      }

      debugPrint('✅ All ${childCount.value} child(ren) done');
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

  Map<String, dynamic> _defaultChild() => {
        'name': '',
        'dob': '',
        'dobDisplay': '',
        'gender': 'male',
        'bloodGroup': null,      // null = no selection, never empty string
        'knownAllergies': '',
        'familyHistoryAsd': false,
        'familyHistorySpeech': false,
        'familyHistoryHearing': false,
        'geneticDisorders': '',
        'chronicConditions': '',
        'weightKg': '',
        'heightCm': '',
        'documents': <Map<String, String>>[],
      };

  void _initChildren(int count) {
    while (_children.length < count) {
      _children.add(_defaultChild());
    }
    while (_children.length > count) {
      _children.removeLast();
    }
  }

  bool _hasHealthData(Map<String, dynamic> d) {
    return (d['bloodGroup'] as String? ?? '').isNotEmpty ||
        (d['knownAllergies'] as String? ?? '').isNotEmpty ||
        (d['weightKg'] as String? ?? '').isNotEmpty ||
        (d['heightCm'] as String? ?? '').isNotEmpty ||
        (d['familyHistoryAsd'] as bool? ?? false) ||
        (d['familyHistorySpeech'] as bool? ?? false) ||
        (d['familyHistoryHearing'] as bool? ?? false);
  }

  Map<String, dynamic> _buildHealthPayload(Map<String, dynamic> d) {
    final payload = <String, dynamic>{
      'family_history_asd': d['familyHistoryAsd'] ?? false,
      'family_history_speech_disorders': d['familyHistorySpeech'] ?? false,
      'family_history_hearing_loss': d['familyHistoryHearing'] ?? false,
    };
    if ((d['bloodGroup'] as String? ?? '').isNotEmpty) {
      payload['blood_group'] = d['bloodGroup'];
    }
    if ((d['knownAllergies'] as String? ?? '').isNotEmpty) {
      payload['known_allergies'] = d['knownAllergies'];
    }
    if ((d['geneticDisorders'] as String? ?? '').isNotEmpty) {
      payload['genetic_disorders'] = d['geneticDisorders'];
    }
    if ((d['chronicConditions'] as String? ?? '').isNotEmpty) {
      payload['chronic_conditions'] = d['chronicConditions'];
    }
    if ((d['weightKg'] as String? ?? '').isNotEmpty) {
      final w = double.tryParse(d['weightKg'] as String);
      if (w != null) payload['weight_kg'] = w;
    }
    if ((d['heightCm'] as String? ?? '').isNotEmpty) {
      final h = double.tryParse(d['heightCm'] as String);
      if (h != null) payload['height_cm'] = h;
    }
    return payload;
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