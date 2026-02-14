// // lib/controllers/expert_consultation_controller.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/models/expert_model.dart';
// import 'package:speechspectrum/services/expert_consultation_service.dart';

// class ExpertConsultationController extends GetxController {
//   final ExpertConsultationService _service = ExpertConsultationService();

//   var isLoading = false.obs;
//   var isResponding = false.obs;

//   var consultations = <ExpertConsultationItem>[].obs;
//   var filteredConsultations = <ExpertConsultationItem>[].obs;
//   var linkedParents = <LinkedExpertItem>[].obs;

//   final searchController = TextEditingController();
//   final searchText = ''.obs;

//   @override
//   void onInit() {
//     super.onInit();
//   }

//   @override
//   void onClose() {
//     searchController.dispose();
//     super.onClose();
//   }

//   // Fetch expert consultations
//   Future<void> fetchConsultations() async {
//     try {
//       isLoading.value = true;
//       debugPrint('🔐 Fetching expert consultations');

//       final response = await _service.getExpertConsultations();

//       debugPrint('✅ Consultations fetched: ${response.data.length}');

//       if (response.status) {
//         consultations.value = response.data;
//         filteredConsultations.value = response.data;
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

//   // Respond to consultation
//   Future<bool> respondToConsultation({
//     required String requestId,
//     required String status,
//     required String responseMessage,
//     required String parentUserId,
//     required String childId,
//   }) async {
//     try {
//       isResponding.value = true;
//       debugPrint('🔐 Responding to consultation: $requestId');

//       final response = await _service.respondToConsultation(
//         requestId: requestId,
//         status: status,
//         responseMessage: responseMessage,
//       );

//       if (response.status) {
//         // If approved, create link
//         if (status.toLowerCase() == 'approved') {
//           await _createLink(parentUserId: parentUserId, childId: childId);
//         }

//         Get.back(); // Close dialog
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

//         // Refresh consultations
//         await fetchConsultations();
//         return true;
//       } else {
//         _showError(response.message);
//         return false;
//       }
//     } catch (e) {
//       debugPrint('❌ Error responding to consultation: $e');
//       _showError(e.toString().replaceAll('Exception: ', ''));
//       return false;
//     } finally {
//       isResponding.value = false;
//     }
//   }

//   // Create link (private helper)
//   Future<void> _createLink({
//     required String parentUserId,
//     required String childId,
//   }) async {
//     try {
//       debugPrint('🔐 Creating link for approved consultation');

//       final response = await _service.createLink(
//         parentUserId: parentUserId,
//         childId: childId,
//       );

//       if (response.status) {
//         debugPrint('✅ Link created successfully');
//       } else {
//         debugPrint('⚠️ Link creation failed: ${response.message}');
//       }
//     } catch (e) {
//       debugPrint('❌ Error creating link: $e');
//       // Don't show error to user as the main action (approval) succeeded
//     }
//   }

//   // Fetch linked parents
//   Future<void> fetchLinkedParents() async {
//     try {
//       isLoading.value = true;
//       debugPrint('🔐 Fetching linked parents');

//       final response = await _service.getExpertLinks();

//       debugPrint('✅ Linked parents fetched: ${response.data.length}');

//       if (response.status) {
//         linkedParents.value = response.data;
//       } else {
//         _showError(response.message);
//       }
//     } catch (e) {
//       debugPrint('❌ Error fetching linked parents: $e');
//       _showError(e.toString().replaceAll('Exception: ', ''));
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // Search consultations
//   void searchConsultations(String query) {
//     searchText.value = query;

//     if (query.isEmpty) {
//       filteredConsultations.value = consultations;
//     } else {
//       filteredConsultations.value = consultations
//           .where((consultation) =>
//               consultation.parentUserId.toLowerCase().contains(query.toLowerCase()) ||
//               consultation.childId.toLowerCase().contains(query.toLowerCase()) ||
//               consultation.status.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     }
//   }

//   void clearSearch() {
//     searchController.clear();
//     searchText.value = '';
//     filteredConsultations.value = consultations;
//   }

//   // Get counts
//   int getPendingCount() {
//     return consultations.where((c) => c.isPending()).length;
//   }

//   int getApprovedCount() {
//     return consultations.where((c) => c.isApproved()).length;
//   }

//   int getRejectedCount() {
//     return consultations.where((c) => c.isRejected()).length;
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

// lib/controllers/expert_consultation_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/models/expert_model.dart';
import 'package:speechspectrum/services/expert_consultation_service.dart';

class ExpertConsultationController extends GetxController {
  final ExpertConsultationService _expertService = ExpertConsultationService();

  var isLoading = false.obs;
  var isResponding = false.obs;

  var consultations = <ExpertConsultationItem>[].obs;
  var linkedParents = <ExpertLinkedParentItem>[].obs;

  final responseMessageController = TextEditingController();

  @override
  void onClose() {
    responseMessageController.dispose();
    super.onClose();
  }

  // Fetch Expert Consultations
  Future<void> fetchExpertConsultations() async {
    try {
      isLoading.value = true;
      debugPrint('🔐 Fetching expert consultations');

      final response = await _expertService.getExpertConsultations();

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

  // Respond to Consultation
  Future<bool> respondToConsultation({
    required String requestId,
    required String status,
    required String responseMessage,
    required String parentUserId,
    required String childId,
  }) async {
    try {
      isResponding.value = true;
      debugPrint('🔐 Responding to consultation: $requestId');

      // First, respond to the consultation
      final response = await _expertService.respondToConsultation(
        requestId: requestId,
        status: status,
        responseMessage: responseMessage,
      );

      if (response.status) {
        // If approved, create the link
        if (status.toLowerCase() == 'approved') {
          try {
            await _expertService.createLink(
              parentUserId: parentUserId,
              childId: childId,
            );
            debugPrint('✅ Link created successfully');
          } catch (linkError) {
            debugPrint('⚠️ Link creation error (might already exist): $linkError');
            // Don't fail the entire operation if link already exists
          }
        }

        Get.back(); // Close any dialog
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

        // Refresh consultations
        await fetchExpertConsultations();
        return true;
      } else {
        _showError(response.message);
        return false;
      }
    } catch (e) {
      debugPrint('❌ Error responding to consultation: $e');
      _showError(e.toString().replaceAll('Exception: ', ''));
      return false;
    } finally {
      isResponding.value = false;
      responseMessageController.clear();
    }
  }

  // Fetch Expert Linked Parents
  Future<void> fetchExpertLinkedParents() async {
    try {
      isLoading.value = true;
      debugPrint('🔐 Fetching expert linked parents');

      final response = await _expertService.getExpertLinkedParents();

      debugPrint('✅ Linked parents fetched: ${response.data.length}');

      if (response.status) {
        linkedParents.value = response.data;
      } else {
        _showError(response.message);
      }
    } catch (e) {
      debugPrint('❌ Error fetching linked parents: $e');
      _showError(e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  // Get counts
  int getPendingCount() {
    return consultations.where((c) => c.isPending()).length;
  }

  int getApprovedCount() {
    return consultations.where((c) => c.isApproved()).length;
  }

  int getRejectedCount() {
    return consultations.where((c) => c.isRejected()).length;
  }

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