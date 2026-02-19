// lib/controllers/speech_controller.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/models/speech_models.dart';
import 'package:speechspectrum/services/speech_service.dart';

class SpeechController extends GetxController {
  final SpeechService _speechService = SpeechService();

  // Observable variables
  final RxList<Child> children = <Child>[].obs;
  final Rx<Child?> selectedChild = Rx<Child?>(null);
  final RxBool isLoadingChildren = false.obs;
  final RxBool isSubmitting = false.obs;

  // All speech submissions
  final RxList<SpeechSubmissionDetail> speechSubmissions =
      <SpeechSubmissionDetail>[].obs;
  final RxList<SpeechSubmissionDetail> filteredSubmissions =
      <SpeechSubmissionDetail>[].obs;
  final RxBool isLoadingSubmissions = false.obs;
  
  // Single submission detail
  final Rx<SpeechSubmissionDetail?> currentSubmission =
      Rx<SpeechSubmissionDetail?>(null);
  final RxBool isLoadingDetail = false.obs;

  // Search
  final searchController = TextEditingController();
  final RxString searchText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchChildren();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  // Fetch all children
  Future<void> fetchChildren() async {
    try {
      isLoadingChildren.value = true;
      final response = await _speechService.getChildren();
      children.value = response.data;
      
      // Auto-select first child if available
      if (children.isNotEmpty) {
        selectedChild.value = children.first;
      }
      
      debugPrint('✅ Fetched ${children.length} children');
    } catch (e) {
      debugPrint('❌ Error fetching children: $e');
      Get.snackbar(
        'Error',
        e.toString().replaceAll('Exception: ', ''),
        backgroundColor: AppColors.errorColor,
        colorText: AppColors.whiteColor,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoadingChildren.value = false;
    }
  }

  // Select a child
  void selectChild(Child child) {
    selectedChild.value = child;
    debugPrint('✅ Selected child: ${child.childName}');
  }

  // Submit speech recording
  Future<bool> submitSpeech({
    required File audioFile,
    required int durationSeconds,
    required String format,
  }) async {
    if (selectedChild.value == null) {
      Get.snackbar(
        'Error',
        'Please select a child first',
        backgroundColor: AppColors.errorColor,
        colorText: AppColors.whiteColor,
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }

    try {
      isSubmitting.value = true;

      final response = await _speechService.submitSpeech(
        audioFile: audioFile,
        childId: selectedChild.value!.childId,
        recordingDurationSeconds: durationSeconds,
        recordingFormat: format,
      );

      debugPrint('✅ Speech submitted: ${response.data.speechSubmissionId}');

      Get.snackbar(
        'Success',
        'Speech recording submitted successfully!',
        backgroundColor: AppColors.successColor,
        colorText: AppColors.whiteColor,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );

      return true;
    } catch (e) {
      debugPrint('❌ Error submitting speech: $e');
      Get.snackbar(
        'Error',
        e.toString().replaceAll('Exception: ', ''),
        backgroundColor: AppColors.errorColor,
        colorText: AppColors.whiteColor,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
      return false;
    } finally {
      isSubmitting.value = false;
    }
  }

  // Fetch all speech submissions
  Future<void> fetchAllSubmissions() async {
    try {
      isLoadingSubmissions.value = true;
      final response = await _speechService.getAllSpeechSubmissions();
      speechSubmissions.value = response.data;
      filteredSubmissions.value = response.data;
      debugPrint('✅ Fetched ${speechSubmissions.length} submissions');
    } catch (e) {
      debugPrint('❌ Error fetching submissions: $e');
      Get.snackbar(
        'Error',
        e.toString().replaceAll('Exception: ', ''),
        backgroundColor: AppColors.errorColor,
        colorText: AppColors.whiteColor,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoadingSubmissions.value = false;
    }
  }

  // Search submissions
  void searchSubmissions(String query) {
    searchText.value = query;

    if (query.isEmpty) {
      filteredSubmissions.value = speechSubmissions;
    } else {
      filteredSubmissions.value = speechSubmissions.where((submission) {
        final childName = submission.getChildName().toLowerCase();
        final searchLower = query.toLowerCase();
        return childName.contains(searchLower);
      }).toList();
    }
  }

  // Clear search
  void clearSearch() {
    searchController.clear();
    searchText.value = '';
    filteredSubmissions.value = speechSubmissions;
  }

  // Fetch single submission
  Future<void> fetchSubmissionDetail(String submissionId) async {
    try {
      isLoadingDetail.value = true;
      final response = await _speechService.getSpeechSubmission(submissionId);
      
      // Convert to SpeechSubmissionDetail
      currentSubmission.value = SpeechSubmissionDetail(
        speechSubmissionId: response.data.speechSubmissionId,
        parentUserId: response.data.parentUserId,
        childId: response.data.childId,
        recordingPublicId: response.data.recordingPublicId,
        recordingDurationSeconds: response.data.recordingDurationSeconds,
        recordingFormat: response.data.recordingFormat,
        submittedAt: response.data.submittedAt,
        children: null,
        speechResults: [],
      );
      
      debugPrint('✅ Fetched submission detail');
    } catch (e) {
      debugPrint('❌ Error fetching submission detail: $e');
      Get.snackbar(
        'Error',
        e.toString().replaceAll('Exception: ', ''),
        backgroundColor: AppColors.errorColor,
        colorText: AppColors.whiteColor,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoadingDetail.value = false;
    }
  }

  // Delete submission
  Future<bool> deleteSubmission(String submissionId) async {
    try {
      final response = await _speechService.deleteSpeechSubmission(submissionId);

      if (response.status) {
        // Remove from local list
        speechSubmissions.removeWhere(
          (submission) => submission.speechSubmissionId == submissionId,
        );
        filteredSubmissions.removeWhere(
          (submission) => submission.speechSubmissionId == submissionId,
        );

        Get.snackbar(
          'Success',
          response.message,
          backgroundColor: AppColors.successColor,
          colorText: AppColors.whiteColor,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 2),
        );

        debugPrint('✅ Submission deleted');
        return true;
      }

      return false;
    } catch (e) {
      debugPrint('❌ Error deleting submission: $e');
      Get.snackbar(
        'Error',
        e.toString().replaceAll('Exception: ', ''),
        backgroundColor: AppColors.errorColor,
        colorText: AppColors.whiteColor,
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }
  }

  // Get grouped submissions by child
  Map<String, List<SpeechSubmissionDetail>> getGroupedSubmissions() {
    final Map<String, List<SpeechSubmissionDetail>> grouped = {};

    for (var submission in filteredSubmissions) {
      final childName = submission.getChildName();
      if (!grouped.containsKey(childName)) {
        grouped[childName] = [];
      }
      grouped[childName]!.add(submission);
    }

    return grouped;
  }
}