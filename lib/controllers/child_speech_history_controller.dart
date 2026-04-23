// lib/controllers/child_speech_history_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/models/speech_models.dart';
import 'package:speechspectrum/services/speech_service.dart';

class ChildSpeechHistoryController extends GetxController {
  final SpeechService _speechService = SpeechService();

  final RxBool isLoading = false.obs;
  final RxList<SpeechSubmissionDetail> submissions =
      <SpeechSubmissionDetail>[].obs;
  final RxList<SpeechSubmissionDetail> filteredSubmissions =
      <SpeechSubmissionDetail>[].obs;

  final searchController = TextEditingController();
  final RxString searchText = ''.obs;

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  /// Fetches all speech submissions then filters by [childId]
  Future<void> fetchAndFilterSpeech(String childId) async {
    try {
      isLoading.value = true;
      final response = await _speechService.getAllSpeechSubmissions();
      // Filter only this child's submissions
      final childSubmissions = response.data
          .where((s) => s.childId == childId)
          .toList();
      submissions.value = childSubmissions;
      filteredSubmissions.value = childSubmissions;
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString().replaceAll('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.errorColor,
        colorText: AppColors.whiteColor,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void searchSubmissions(String query) {
    searchText.value = query;
    if (query.isEmpty) {
      filteredSubmissions.value = submissions;
    } else {
      filteredSubmissions.value = submissions.where((s) {
        final result = s.getLatestResult()?.result;
        if (result == null) return false;
        return result.riskInterpretation
            .toLowerCase()
            .contains(query.toLowerCase());
      }).toList();
    }
  }

  void clearSearch() {
    searchController.clear();
    searchText.value = '';
    filteredSubmissions.value = submissions;
  }
}