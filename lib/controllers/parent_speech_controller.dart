// // lib/controllers/speech_controller.dart

// import 'package:get/get.dart';
// import '../models/parent_speech_model.dart';
// import '../services/parent_speech_service.dart';

// class ParentParentSpeechController extends GetxController {
//   final ParentSpeechService _speechService = ParentSpeechService();

//   // ─── STATE ────────────────────────────────────────────────────────────────────
//   final RxList<ParentSpeechModel> speeches = <ParentSpeechModel>[].obs;
//   final Rx<ParentSpeechModel?> selectedSpeech = Rx<ParentSpeechModel?>(null);

//   final RxBool isLoading = false.obs;
//   final RxBool isDetailLoading = false.obs;
//   final RxString errorMessage = ''.obs;
//   final RxString currentSubmissionId = ''.obs;

//   // ─── FETCH SPEECHES BY SUBMISSION ID ─────────────────────────────────────────
//   // Call this when user taps on an appointment card
//   // Pass the submissionId from the appointment
//   Future<void> fetchSpeechesBySubmissionId(String submissionId) async {
//     if (submissionId.isEmpty) {
//       errorMessage.value = 'Submission ID is missing';
//       return;
//     }

//     currentSubmissionId.value = submissionId;
//     isLoading.value = true;
//     errorMessage.value = '';
//     speeches.clear();

//     try {
//       final result =
//           await _speechService.getSpeechesBySubmissionId(submissionId);
//       speeches.assignAll(result);

//       if (result.isEmpty) {
//         errorMessage.value = 'No recordings found for this submission';
//       }
//     } catch (e) {
//       errorMessage.value = 'Failed to load speech recordings';
//       print('ParentSpeechController.fetchSpeechesBySubmissionId error: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // ─── FETCH ALL SPEECHES ───────────────────────────────────────────────────────
//   Future<void> fetchAllSpeeches() async {
//     isLoading.value = true;
//     errorMessage.value = '';

//     try {
//       final result = await _speechService.getAllSpeeches();
//       speeches.assignAll(result);
//     } catch (e) {
//       errorMessage.value = 'Failed to load recordings';
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // ─── FETCH SINGLE SPEECH DETAIL ───────────────────────────────────────────────
//   Future<void> fetchSpeechDetail(String speechId) async {
//     if (speechId.isEmpty) return;

//     isDetailLoading.value = true;

//     try {
//       final result = await _speechService.getSpeechById(speechId);
//       selectedSpeech.value = result;
//     } catch (e) {
//       print('ParentSpeechController.fetchSpeechDetail error: $e');
//     } finally {
//       isDetailLoading.value = false;
//     }
//   }

//   // ─── CLEAR STATE ──────────────────────────────────────────────────────────────
//   void clearSpeeches() {
//     speeches.clear();
//     selectedSpeech.value = null;
//     errorMessage.value = '';
//     currentSubmissionId.value = '';
//   }

//   @override
//   void onClose() {
//     clearSpeeches();
//     super.onClose();
//   }
// }


// // lib/controllers/parent_speech_controller.dart
// //
// // SEPARATE controller ONLY for parent-side speech list + detail.
// // Does NOT modify ExpertChildDataController or any other existing controller.
// //
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/services/parent_speech_service.dart';

// class ParentSpeechController extends GetxController {
//   final ParentSpeechService _service = ParentSpeechService();

//   // ── State ──────────────────────────────────────────────────────────────────
//   final isLoadingSpeech = false.obs;
//   final isLoadingSpeechDetail = false.obs;

//   final speechList = <ParentSpeechItem>[].obs;
//   final filteredSpeechList = <ParentSpeechItem>[].obs;
//   final selectedSpeech = Rxn<ParentSpeechItem>();

//   final speechSearch = ''.obs;

//   // Keep track of last fetched childId to avoid redundant calls
//   String? _lastChildId;

//   // ── Fetch list ─────────────────────────────────────────────────────────────
//   Future<void> fetchSpeech(String childId,
//       {bool forceRefresh = false}) async {
//     if (!forceRefresh &&
//         _lastChildId == childId &&
//         speechList.isNotEmpty) {
//       return;
//     }
//     _lastChildId = childId;
//     try {
//       isLoadingSpeech.value = true;
//       speechList.clear();
//       filteredSpeechList.clear();

//       final list = await _service.getSpeechByChild(childId);

//       speechList.assignAll(list);
//       filteredSpeechList.assignAll(list);

//       debugPrint(
//           '✅ [ParentSpeechController] loaded ${list.length} speech records for child $childId');
//     } catch (e) {
//       _showError(_clean(e));
//     } finally {
//       isLoadingSpeech.value = false;
//     }
//   }

//   // ── Filter ─────────────────────────────────────────────────────────────────
//   void filterSpeech(String query) {
//     speechSearch.value = query;
//     if (query.trim().isEmpty) {
//       filteredSpeechList.assignAll(speechList);
//       return;
//     }
//     final q = query.toLowerCase();
//     filteredSpeechList.assignAll(speechList.where((s) {
//       if (!s.hasResults) return false;
//       return s.latestResult!.result.riskInterpretation
//           .toLowerCase()
//           .contains(q);
//     }).toList());
//   }

//   // ── Fetch detail ───────────────────────────────────────────────────────────
//   //
//   // IMPORTANT: always pass item.speechSubmissionId, NOT item.submissionId
//   // (there is no 'submissionId' on speech — the correct field is
//   //  'speech_submission_id' which maps to ExpertSpeechItem.speechSubmissionId)
//   //
//   Future<void> fetchSpeechDetail(String speechSubmissionId) async {
//     if (speechSubmissionId.trim().isEmpty) {
//       _showError('Cannot load detail — submission ID is empty.');
//       return;
//     }

//     debugPrint(
//         '🔍 [ParentSpeechController] fetchSpeechDetail id="$speechSubmissionId"');

//     // ── Try cache-first: if the list already has this item, use it ──────────
//     final cached = speechList
//         .where((s) => s.speechSubmissionId == speechSubmissionId)
//         .toList();

//     if (cached.isNotEmpty) {
//       selectedSpeech.value = cached.first;
//       debugPrint('✅ [ParentSpeechController] served from cache');
//       // Still fetch fresh in background silently
//       _fetchDetailFromApi(speechSubmissionId, silent: true);
//       return;
//     }

//     // ── Not in cache — fetch from API ────────────────────────────────────────
//     await _fetchDetailFromApi(speechSubmissionId, silent: false);
//   }

//   Future<void> _fetchDetailFromApi(String speechSubmissionId,
//       {required bool silent}) async {
//     try {
//       if (!silent) isLoadingSpeechDetail.value = true;

//       final result = await _service.getSpeechDetail(speechSubmissionId);
//       if (result.status) {
//         selectedSpeech.value = result.data;
//         debugPrint(
//             '✅ [ParentSpeechController] detail loaded: ${result.data.speechSubmissionId}');
//       } else {
//         if (!silent) _showError(result.message);
//       }
//     } catch (e) {
//       if (!silent) _showError(_clean(e));
//     } finally {
//       if (!silent) isLoadingSpeechDetail.value = false;
//     }
//   }

//   // ── Helpers ────────────────────────────────────────────────────────────────
//   void clearAll() {
//     speechList.clear();
//     filteredSpeechList.clear();
//     selectedSpeech.value = null;
//     speechSearch.value = '';
//     _lastChildId = null;
//   }

//   String _clean(dynamic e) =>
//       e.toString().replaceAll('Exception: ', '').trim();

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
//       icon: const Icon(Icons.error_rounded, color: Colors.white, size: 20),
//     );
//   }
// }

// // lib/controllers/parent_speech_controller.dart
// //
// // ISOLATED controller — only uses ParentSpeechService.
// // Never touches ExpertChildDataController or screening endpoints.
// //
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/services/parent_speech_service.dart';

// class ParentSpeechController extends GetxController {
//   final ParentSpeechService _service = ParentSpeechService();

//   // ── State ──────────────────────────────────────────────────────────────────
//   final isLoadingSpeech = false.obs;
//   final isLoadingSpeechDetail = false.obs;

//   final speechList = <ParentSpeechItem>[].obs;
//   final filteredSpeechList = <ParentSpeechItem>[].obs;
//   final selectedSpeech = Rxn<ParentSpeechItem>();

//   final speechSearch = ''.obs;

//   String? _lastChildId;

//   // ── Fetch list ─────────────────────────────────────────────────────────────
//   Future<void> fetchSpeech(String childId,
//       {bool forceRefresh = false}) async {
//     if (!forceRefresh &&
//         _lastChildId == childId &&
//         speechList.isNotEmpty) {
//       return;
//     }
//     _lastChildId = childId;
//     try {
//       isLoadingSpeech.value = true;
//       speechList.clear();
//       filteredSpeechList.clear();

//       final list = await _service.getSpeechByChild(childId);

//       speechList.assignAll(list);
//       filteredSpeechList.assignAll(list);

//       debugPrint(
//           '✅ [ParentSpeechController] loaded ${list.length} speech records for child $childId');
//       for (final item in list) {
//         debugPrint(
//             '   → speechSubmissionId="${item.speechSubmissionId}"');
//       }
//     } catch (e) {
//       _showError(_clean(e));
//     } finally {
//       isLoadingSpeech.value = false;
//     }
//   }

//   // ── Filter ─────────────────────────────────────────────────────────────────
//   void filterSpeech(String query) {
//     speechSearch.value = query;
//     if (query.trim().isEmpty) {
//       filteredSpeechList.assignAll(speechList);
//       return;
//     }
//     final q = query.toLowerCase();
//     filteredSpeechList.assignAll(speechList.where((s) {
//       if (!s.hasResults) return false;
//       return s.latestResult!.result.riskInterpretation
//           .toLowerCase()
//           .contains(q);
//     }).toList());
//   }

//   // ── Fetch detail ───────────────────────────────────────────────────────────
//   //
//   // Always call with item.speechSubmissionId from ParentSpeechItem.
//   // This hits /api/speech/:id  — NOT the screening endpoint.
//   //
//   Future<void> fetchSpeechDetail(String speechSubmissionId) async {
//     final id = speechSubmissionId.trim();
//     if (id.isEmpty) {
//       _showError('Cannot load detail — speech submission ID is empty.');
//       return;
//     }

//     debugPrint(
//         '🔍 [ParentSpeechController] fetchSpeechDetail id="$id"');

//     // ── Cache-first: if already in list, serve immediately ─────────────────
//     final cached =
//         speechList.where((s) => s.speechSubmissionId == id).toList();

//     if (cached.isNotEmpty) {
//       selectedSpeech.value = cached.first;
//       debugPrint('✅ [ParentSpeechController] served from cache');
//       // Silently refresh in background
//       _fetchDetailFromApi(id, silent: true);
//       return;
//     }

//     // ── Not cached — fetch from /api/speech/:id ────────────────────────────
//     await _fetchDetailFromApi(id, silent: false);
//   }

//   Future<void> _fetchDetailFromApi(String speechSubmissionId,
//       {required bool silent}) async {
//     try {
//       if (!silent) isLoadingSpeechDetail.value = true;

//       debugPrint(
//           '📡 [ParentSpeechController] calling getSpeechDetail("$speechSubmissionId")');

//       final result = await _service.getSpeechDetail(speechSubmissionId);
//       if (result.status) {
//         selectedSpeech.value = result.data;
//         debugPrint(
//             '✅ [ParentSpeechController] detail OK: ${result.data.speechSubmissionId}');
//       } else {
//         if (!silent) _showError(result.message);
//       }
//     } catch (e) {
//       if (!silent) _showError(_clean(e));
//     } finally {
//       if (!silent) isLoadingSpeechDetail.value = false;
//     }
//   }

//   // ── Helpers ────────────────────────────────────────────────────────────────
//   void clearAll() {
//     speechList.clear();
//     filteredSpeechList.clear();
//     selectedSpeech.value = null;
//     speechSearch.value = '';
//     _lastChildId = null;
//   }

//   String _clean(dynamic e) =>
//       e.toString().replaceAll('Exception: ', '').trim();

//   void _showError(String msg) {
//     Get.snackbar(
//       'Error',
//       msg,
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: AppColors.errorColor,
//       colorText: Colors.white,
//       margin: const EdgeInsets.all(16),
//       borderRadius: 14,
//       duration: const Duration(seconds: 4),
//       icon:
//           const Icon(Icons.error_rounded, color: Colors.white, size: 20),
//     );
//   }
// }


// // lib/controllers/parent_speech_controller.dart
// //
// // ISOLATED controller — only uses ParentSpeechService.
// //
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/services/parent_speech_service.dart';

// class ParentSpeechController extends GetxController {
//   final ParentSpeechService _service = ParentSpeechService();

//   // ── State ──────────────────────────────────────────────────────────────────
//   final isLoadingSpeech = false.obs;
//   final isLoadingSpeechDetail = false.obs;

//   final speechList = <ParentSpeechItem>[].obs;
//   final filteredSpeechList = <ParentSpeechItem>[].obs;
//   final selectedSpeech = Rxn<ParentSpeechItem>();

//   final speechSearch = ''.obs;

//   String? _lastChildId;

//   // ── Fetch list ─────────────────────────────────────────────────────────────
//   Future<void> fetchSpeech(String childId,
//       {bool forceRefresh = false}) async {
//     if (!forceRefresh &&
//         _lastChildId == childId &&
//         speechList.isNotEmpty) {
//       return;
//     }
//     _lastChildId = childId;
//     try {
//       isLoadingSpeech.value = true;
//       speechList.clear();
//       filteredSpeechList.clear();

//       final list = await _service.getSpeechByChild(childId);

//       speechList.assignAll(list);
//       filteredSpeechList.assignAll(list);

//       debugPrint(
//           '✅ [ParentSpeechController] loaded ${list.length} records for child $childId');
//     } catch (e) {
//       _showError(_clean(e));
//     } finally {
//       isLoadingSpeech.value = false;
//     }
//   }

//   // ── Filter ─────────────────────────────────────────────────────────────────
//   void filterSpeech(String query) {
//     speechSearch.value = query;
//     if (query.trim().isEmpty) {
//       filteredSpeechList.assignAll(speechList);
//       return;
//     }
//     final q = query.toLowerCase();
//     filteredSpeechList.assignAll(speechList.where((s) {
//       if (!s.hasResults) return false;
//       return s.latestResult!.result.displayRiskLabel
//           .toLowerCase()
//           .contains(q);
//     }).toList());
//   }

//   // ── Fetch detail ───────────────────────────────────────────────────────────
//   Future<void> fetchSpeechDetail(String speechSubmissionId) async {
//     final id = speechSubmissionId.trim();
//     if (id.isEmpty) {
//       _showError('Cannot load detail — speech submission ID is empty.');
//       return;
//     }

//     debugPrint(
//         '🔍 [ParentSpeechController] fetchSpeechDetail id="$id"');

//     // Cache-first
//     final cached =
//         speechList.where((s) => s.speechSubmissionId == id).toList();
//     if (cached.isNotEmpty) {
//       selectedSpeech.value = cached.first;
//       _fetchDetailFromApi(id, silent: true);
//       return;
//     }

//     await _fetchDetailFromApi(id, silent: false);
//   }

//   Future<void> _fetchDetailFromApi(String speechSubmissionId,
//       {required bool silent}) async {
//     try {
//       if (!silent) isLoadingSpeechDetail.value = true;

//       final result = await _service.getSpeechDetail(speechSubmissionId);
//       if (result.status) {
//         selectedSpeech.value = result.data;
//       } else {
//         if (!silent) _showError(result.message);
//       }
//     } catch (e) {
//       if (!silent) _showError(_clean(e));
//     } finally {
//       if (!silent) isLoadingSpeechDetail.value = false;
//     }
//   }

//   // ── Helpers ────────────────────────────────────────────────────────────────
//   void clearAll() {
//     speechList.clear();
//     filteredSpeechList.clear();
//     selectedSpeech.value = null;
//     speechSearch.value = '';
//     _lastChildId = null;
//   }

//   String _clean(dynamic e) =>
//       e.toString().replaceAll('Exception: ', '').trim();

//   void _showError(String msg) {
//     Get.snackbar(
//       'Error',
//       msg,
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: AppColors.errorColor,
//       colorText: Colors.white,
//       margin: const EdgeInsets.all(16),
//       borderRadius: 14,
//       duration: const Duration(seconds: 4),
//       icon: const Icon(Icons.error_rounded, color: Colors.white, size: 20),
//     );
//   }
// }

// lib/controllers/parent_speech_controller.dart
//
// ISOLATED controller — only uses ParentSpeechService.
// Updated for new API format: sa_score, risk_level, severity_percentage.
//
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/services/parent_speech_service.dart';

class ParentSpeechController extends GetxController {
  final ParentSpeechService _service = ParentSpeechService();

  // ── State ──────────────────────────────────────────────────────────────────
  final isLoadingSpeech = false.obs;
  final isLoadingSpeechDetail = false.obs;

  final speechList = <ParentSpeechItem>[].obs;
  final filteredSpeechList = <ParentSpeechItem>[].obs;
  final selectedSpeech = Rxn<ParentSpeechItem>();

  final speechSearch = ''.obs;

  String? _lastChildId;

  // ── Fetch list ─────────────────────────────────────────────────────────────
  Future<void> fetchSpeech(String childId,
      {bool forceRefresh = false}) async {
    if (!forceRefresh &&
        _lastChildId == childId &&
        speechList.isNotEmpty) {
      return;
    }
    _lastChildId = childId;
    try {
      isLoadingSpeech.value = true;
      speechList.clear();
      filteredSpeechList.clear();

      final list = await _service.getSpeechByChild(childId);

      speechList.assignAll(list);
      filteredSpeechList.assignAll(list);

      debugPrint(
          '✅ [ParentSpeechController] loaded ${list.length} records for child $childId');
    } catch (e) {
      _showError(_clean(e));
    } finally {
      isLoadingSpeech.value = false;
    }
  }

  // ── Filter ─────────────────────────────────────────────────────────────────
  void filterSpeech(String query) {
    speechSearch.value = query;
    if (query.trim().isEmpty) {
      filteredSpeechList.assignAll(speechList);
      return;
    }
    final q = query.toLowerCase();
    filteredSpeechList.assignAll(speechList.where((s) {
      if (!s.hasResults) return false;
      final analysis = s.latestResult!.result;
      return analysis.riskInterpretation.toLowerCase().contains(q) ||
          analysis.riskLevel.toLowerCase().contains(q) ||
          analysis.severityPercentage.toLowerCase().contains(q);
    }).toList());
  }

  // ── Fetch detail ───────────────────────────────────────────────────────────
  Future<void> fetchSpeechDetail(String speechSubmissionId) async {
    final id = speechSubmissionId.trim();
    if (id.isEmpty) {
      _showError('Cannot load detail — speech submission ID is empty.');
      return;
    }

    debugPrint(
        '🔍 [ParentSpeechController] fetchSpeechDetail id="$id"');

    // Cache-first: show from list immediately, then refresh from API silently
    final cached =
        speechList.where((s) => s.speechSubmissionId == id).toList();
    if (cached.isNotEmpty) {
      selectedSpeech.value = cached.first;
      _fetchDetailFromApi(id, silent: true);
      return;
    }

    await _fetchDetailFromApi(id, silent: false);
  }

  Future<void> _fetchDetailFromApi(String speechSubmissionId,
      {required bool silent}) async {
    try {
      if (!silent) isLoadingSpeechDetail.value = true;

      final result = await _service.getSpeechDetail(speechSubmissionId);
      if (result.status) {
        selectedSpeech.value = result.data;
      } else {
        if (!silent) _showError(result.message);
      }
    } catch (e) {
      if (!silent) _showError(_clean(e));
    } finally {
      if (!silent) isLoadingSpeechDetail.value = false;
    }
  }

  // ── Helpers ────────────────────────────────────────────────────────────────
  void clearAll() {
    speechList.clear();
    filteredSpeechList.clear();
    selectedSpeech.value = null;
    speechSearch.value = '';
    _lastChildId = null;
  }

  String _clean(dynamic e) =>
      e.toString().replaceAll('Exception: ', '').trim();

  void _showError(String msg) {
    Get.snackbar(
      'Error',
      msg,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.errorColor,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 14,
      duration: const Duration(seconds: 4),
      icon:
          const Icon(Icons.error_rounded, color: Colors.white, size: 20),
    );
  }
}