// // lib/controllers/expert_controller.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/models/parent_expert_model.dart';
// import 'package:speechspectrum/services/expert_service.dart';

// class ExpertController extends GetxController {
//   final ExpertService _expertService = ExpertService();

//   var isLoading = false.obs;
//   var isLoadingMore = false.obs;
//   var isRequesting = false.obs;

//   var experts = <ExpertData>[].obs;
//   var filteredExperts = <ExpertData>[].obs;

//   var consultations = <ConsultationItem>[].obs;
//   var linkedExperts = <LinkedExpertItem>[].obs;

//   final searchController = TextEditingController();
//   final searchText = ''.obs;

//   // Pagination
//   var currentPage = 1.obs;
//   var totalPages = 1.obs;
//   var hasNextPage = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     // Initialize if needed
//   }

//   @override
//   void onClose() {
//     searchController.dispose();
//     super.onClose();
//   }

//   // Fetch all experts
//   Future<void> fetchExperts({
//     int page = 1,
//     String? specialization,
//     bool loadMore = false,
//   }) async {
//     try {
//       if (loadMore) {
//         isLoadingMore.value = true;
//       } else {
//         isLoading.value = true;
//         experts.clear();
//       }

//       debugPrint('🔐 Fetching experts - Page: $page');

//       final response = await _expertService.getAllExperts(
//         page: page,
//         limit: 10,
//         specialization: specialization,
//       );

//       debugPrint('✅ Experts fetched: ${response.data.experts.length}');

//       if (response.status) {
//         if (loadMore) {
//           experts.addAll(response.data.experts);
//         } else {
//           experts.value = response.data.experts;
//         }
        
//         filteredExperts.value = experts;
//         currentPage.value = response.data.pagination.currentPage;
//         totalPages.value = response.data.pagination.totalPages;
//         hasNextPage.value = response.data.pagination.hasNextPage;
//       } else {
//         _showError(response.message);
//       }
//     } catch (e) {
//       debugPrint('❌ Error fetching experts: $e');
//       _showError(e.toString().replaceAll('Exception: ', ''));
//     } finally {
//       isLoading.value = false;
//       isLoadingMore.value = false;
//     }
//   }

//   // Load more experts
//   Future<void> loadMoreExperts({String? specialization}) async {
//     if (!hasNextPage.value || isLoadingMore.value) return;
    
//     await fetchExperts(
//       page: currentPage.value + 1,
//       specialization: specialization,
//       loadMore: true,
//     );
//   }

//   // Search experts by specialization
//   void searchExperts(String query) {
//     searchText.value = query;

//     if (query.isEmpty) {
//       filteredExperts.value = experts;
//     } else {
//       filteredExperts.value = experts
//           .where((expert) =>
//               expert.specialization.toLowerCase().contains(query.toLowerCase()) ||
//               expert.fullName.toLowerCase().contains(query.toLowerCase()) ||
//               expert.organization.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     }
//   }

//   void clearSearch() {
//     searchController.clear();
//     searchText.value = '';
//     filteredExperts.value = experts;
//   }

//   // Request consultation
//   Future<bool> requestConsultation({
//     required String expertId,
//     required String childId,
//   }) async {
//     try {
//       isRequesting.value = true;
//       debugPrint('🔐 Requesting consultation for expert: $expertId, child: $childId');

//       final response = await _expertService.requestConsultation(
//         expertId: expertId,
//         childId: childId,
//       );

//       if (response.status) {
//         Get.back(); // Close any dialog
//         Get.snackbar(
//           'Success',
//           response.message,
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: AppColors.successColor,
//           colorText: AppColors.whiteColor,
//           margin: const EdgeInsets.all(16),
//           borderRadius: 12,
//           duration: const Duration(seconds: 3),
//         );
//         return true;
//       } else {
//         _showError(response.message);
//         return false;
//       }
//     } catch (e) {
//       debugPrint('❌ Error requesting consultation: $e');
//       _showError(e.toString().replaceAll('Exception: ', ''));
//       return false;
//     } finally {
//       isRequesting.value = false;
//     }
//   }

//   // Fetch parent consultations
//   Future<void> fetchConsultations() async {
//     try {
//       isLoading.value = true;
//       debugPrint('🔐 Fetching parent consultations');

//       final response = await _expertService.getParentConsultations();

//       debugPrint('✅ Consultations fetched: ${response.data.length}');

//       if (response.status) {
//         consultations.value = response.data;
//       } else {
//         _showError(response.message);
//       }
//     } catch (e) {
//       debugPrint('❌ Error fetching consultations: $e');
//       _showError(e.toString().replaceAll('Exception: ', ''));
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // Fetch linked experts
//   Future<void> fetchLinkedExperts() async {
//     try {
//       isLoading.value = true;
//       debugPrint('🔐 Fetching linked experts');

//       final response = await _expertService.getLinkedExperts();

//       debugPrint('✅ Linked experts fetched: ${response.data.length}');

//       if (response.status) {
//         linkedExperts.value = response.data;
//       } else {
//         _showError(response.message);
//       }
//     } catch (e) {
//       debugPrint('❌ Error fetching linked experts: $e');
//       _showError(e.toString().replaceAll('Exception: ', ''));
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // Get pending consultations count
//   int getPendingCount() {
//     return consultations.where((c) => c.isPending()).length;
//   }

//   // Get approved consultations count
//   int getApprovedCount() {
//     return consultations.where((c) => c.isApproved()).length;
//   }

//   void _showError(String message) {
//     Get.snackbar(
//       'Error',
//       message,
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: AppColors.errorColor,
//       colorText: AppColors.whiteColor,
//       margin: const EdgeInsets.all(16),
//       borderRadius: 12,
//       duration: const Duration(seconds: 3),
//     );
//   }
// }


// lib/controllers/expert_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/models/parent_expert_model.dart';
import 'package:speechspectrum/models/speech_models.dart'; // ← reuse Child model
import 'package:speechspectrum/services/expert_service.dart';
import 'package:speechspectrum/services/speech_service.dart'; // ← reuse SpeechService

class ExpertController extends GetxController {
  final ExpertService _expertService = ExpertService();
  final SpeechService _speechService = SpeechService(); // ← for children

  var isLoading = false.obs;
  var isLoadingMore = false.obs;
  var isRequesting = false.obs;

  var experts = <ExpertData>[].obs;
  var filteredExperts = <ExpertData>[].obs;

  var consultations = <ConsultationItem>[].obs;
  var linkedExperts = <LinkedExpertItem>[].obs;

  final searchController = TextEditingController();
  final searchText = ''.obs;

  // ── Pagination ─────────────────────────────────────────────────────────────
  var currentPage = 1.obs;
  var totalPages = 1.obs;
  var hasNextPage = false.obs;

  // ── Children (for Expert Detail booking) ──────────────────────────────────
  final RxList<Child> children = <Child>[].obs;
  final Rx<Child?> selectedChild = Rx<Child?>(null);
  final RxBool isLoadingChildren = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  // ── Fetch children (same API as SpeechController) ─────────────────────────
  Future<void> fetchChildren() async {
    try {
      isLoadingChildren.value = true;
      selectedChild.value = null; // reset selection on each fetch
      final response = await _speechService.getChildren();
      children.value = response.data;
      debugPrint('✅ ExpertController: fetched ${children.length} children');
    } catch (e) {
      debugPrint('❌ ExpertController fetchChildren: $e');
      _showError(e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoadingChildren.value = false;
    }
  }

  void selectChild(Child child) {
    selectedChild.value = child;
    debugPrint('✅ Selected child: ${child.childName}');
  }

  // ── Fetch all experts ──────────────────────────────────────────────────────
  Future<void> fetchExperts({
    int page = 1,
    String? specialization,
    bool loadMore = false,
  }) async {
    try {
      if (loadMore) {
        isLoadingMore.value = true;
      } else {
        isLoading.value = true;
        experts.clear();
      }

      debugPrint('🔐 Fetching experts - Page: $page');

      final response = await _expertService.getAllExperts(
        page: page,
        limit: 10,
        specialization: specialization,
      );

      debugPrint('✅ Experts fetched: ${response.data.experts.length}');

      if (response.status) {
        if (loadMore) {
          experts.addAll(response.data.experts);
        } else {
          experts.value = response.data.experts;
        }
        filteredExperts.value = experts;
        currentPage.value = response.data.pagination.currentPage;
        totalPages.value = response.data.pagination.totalPages;
        hasNextPage.value = response.data.pagination.hasNextPage;
      } else {
        _showError(response.message);
      }
    } catch (e) {
      debugPrint('❌ Error fetching experts: $e');
      _showError(e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }

  // ── Load more experts ──────────────────────────────────────────────────────
  Future<void> loadMoreExperts({String? specialization}) async {
    if (!hasNextPage.value || isLoadingMore.value) return;
    await fetchExperts(
      page: currentPage.value + 1,
      specialization: specialization,
      loadMore: true,
    );
  }

  // ── Search experts ─────────────────────────────────────────────────────────
  void searchExperts(String query) {
    searchText.value = query;
    if (query.isEmpty) {
      filteredExperts.value = experts;
    } else {
      filteredExperts.value = experts
          .where((expert) =>
              expert.specialization
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              expert.fullName.toLowerCase().contains(query.toLowerCase()) ||
              expert.organization.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  void clearSearch() {
    searchController.clear();
    searchText.value = '';
    filteredExperts.value = experts;
  }

  // ── Request consultation ───────────────────────────────────────────────────
  Future<bool> requestConsultation({
    required String expertId,
    required String childId,
  }) async {
    try {
      isRequesting.value = true;
      debugPrint(
          '🔐 Requesting consultation for expert: $expertId, child: $childId');

      final response = await _expertService.requestConsultation(
        expertId: expertId,
        childId: childId,
      );

      if (response.status) {
        Get.back();
        Get.snackbar(
          'Success',
          response.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.successColor,
          colorText: AppColors.whiteColor,
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
          duration: const Duration(seconds: 3),
        );
        return true;
      } else {
        _showError(response.message);
        return false;
      }
    } catch (e) {
      debugPrint('❌ Error requesting consultation: $e');
      _showError(e.toString().replaceAll('Exception: ', ''));
      return false;
    } finally {
      isRequesting.value = false;
    }
  }

  // ── Fetch parent consultations ─────────────────────────────────────────────
  Future<void> fetchConsultations() async {
    try {
      isLoading.value = true;
      debugPrint('🔐 Fetching parent consultations');
      final response = await _expertService.getParentConsultations();
      debugPrint('✅ Consultations fetched: ${response.data.length}');
      if (response.status) {
        consultations.value = response.data;
      } else {
        _showError(response.message);
      }
    } catch (e) {
      debugPrint('❌ Error fetching consultations: $e');
      _showError(e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  // ── Fetch linked experts ───────────────────────────────────────────────────
  Future<void> fetchLinkedExperts() async {
    try {
      isLoading.value = true;
      debugPrint('🔐 Fetching linked experts');
      final response = await _expertService.getLinkedExperts();
      debugPrint('✅ Linked experts fetched: ${response.data.length}');
      if (response.status) {
        linkedExperts.value = response.data;
      } else {
        _showError(response.message);
      }
    } catch (e) {
      debugPrint('❌ Error fetching linked experts: $e');
      _showError(e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  // ── Helpers ────────────────────────────────────────────────────────────────
  int getPendingCount() => consultations.where((c) => c.isPending()).length;
  int getApprovedCount() => consultations.where((c) => c.isApproved()).length;

  void _showError(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.errorColor,
      colorText: AppColors.whiteColor,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 3),
    );
  }
}