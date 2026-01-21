// lib/controllers/history_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/models/questionnaire_model.dart';
import 'package:speechspectrum/services/questionnaire_service.dart';

class HistoryController extends GetxController {
  final QuestionnaireService _questionnaireService = QuestionnaireService();

  var isLoading = false.obs;
  var isDeleting = false.obs;

  var submissions = <SubmissionItem>[].obs;
  var filteredSubmissions = <SubmissionItem>[].obs;

  final searchController = TextEditingController();
  final searchText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Don't fetch here, let the screen call it
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  // Fetch all submissions
  Future<void> fetchAllSubmissions() async {
    try {
      isLoading.value = true;
      debugPrint('🔐 Fetching all submissions with token');
      
      final response = await _questionnaireService.getAllSubmissions();

      debugPrint('✅ Submissions fetched successfully');
      debugPrint('📊 Total submissions: ${response.data.length}');

      if (response.status) {
        submissions.value = response.data;
        filteredSubmissions.value = response.data;
      } else {
        _showError(response.message);
      }
    } catch (e) {
      debugPrint('❌ Error fetching submissions: $e');
      _showError(e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch submissions by child ID
  Future<List<SubmissionItem>> fetchSubmissionsByChildId(String childId) async {
    try {
      isLoading.value = true;
      debugPrint('🔐 Fetching submissions for child $childId');
      
      final response = await _questionnaireService.getSubmissionsByChildId(childId);

      debugPrint('✅ Child submissions fetched: ${response.data.length}');

      if (response.status) {
        return response.data;
      } else {
        _showError(response.message);
        return [];
      }
    } catch (e) {
      debugPrint('❌ Error fetching child submissions: $e');
      _showError(e.toString().replaceAll('Exception: ', ''));
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch single submission
  Future<SubmissionItem?> fetchSubmission(String submissionId) async {
    try {
      isLoading.value = true;
      debugPrint('🔐 Fetching submission $submissionId');
      
      final response = await _questionnaireService.getSubmission(submissionId);

      debugPrint('✅ Submission fetched successfully');

      if (response.status) {
        return response.data;
      } else {
        _showError(response.message);
        return null;
      }
    } catch (e) {
      debugPrint('❌ Error fetching submission: $e');
      _showError(e.toString().replaceAll('Exception: ', ''));
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  // Delete submission
  Future<void> deleteSubmission(String submissionId) async {
    try {
      isDeleting.value = true;
      debugPrint('🗑️ Deleting submission $submissionId');

      final response = await _questionnaireService.deleteSubmission(submissionId);

      if (response.status) {
        Get.back(); // Close dialog
        Get.snackbar(
          'Success',
          response.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.successColor,
          colorText: AppColors.whiteColor,
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
          duration: const Duration(seconds: 2),
        );
        await fetchAllSubmissions(); // Refresh list
      } else {
        _showError(response.message);
      }
    } catch (e) {
      debugPrint('❌ Error deleting submission: $e');
      _showError(e.toString().replaceAll('Exception: ', ''));
    } finally {
      isDeleting.value = false;
    }
  }

  // Search submissions by child name
  void searchSubmissions(String query) {
    searchText.value = query;

    if (query.isEmpty) {
      filteredSubmissions.value = submissions;
    } else {
      filteredSubmissions.value = submissions
          .where((submission) => submission.children.childName
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    }
  }

  void clearSearch() {
    searchController.clear();
    searchText.value = '';
    filteredSubmissions.value = submissions;
  }

  // Group submissions by child
  Map<String, List<SubmissionItem>> getGroupedSubmissions() {
    final Map<String, List<SubmissionItem>> grouped = {};

    for (var submission in filteredSubmissions) {
      final childName = submission.children.childName;
      if (!grouped.containsKey(childName)) {
        grouped[childName] = [];
      }
      grouped[childName]!.add(submission);
    }

    return grouped;
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