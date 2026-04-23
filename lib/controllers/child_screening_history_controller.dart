// lib/controllers/child_screening_history_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/models/questionnaire_model.dart';
import 'package:speechspectrum/services/questionnaire_service.dart';

class ChildScreeningHistoryController extends GetxController {
  final QuestionnaireService _questionnaireService = QuestionnaireService();

  final RxBool isLoading = false.obs;
  final RxList<SubmissionItem> submissions = <SubmissionItem>[].obs;
  final RxList<SubmissionItem> filteredSubmissions =
      <SubmissionItem>[].obs;

  final searchController = TextEditingController();
  final RxString searchText = ''.obs;

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  // Fetch submissions for a specific child
  Future<void> fetchSubmissions(String childId) async {
    try {
      isLoading.value = true;
      final response =
          await _questionnaireService.getSubmissionsByChildId(childId);
      submissions.value = response.data;
      filteredSubmissions.value = response.data;
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
        if (s.questionnaireResults.isEmpty) return false;
        final prediction =
            s.questionnaireResults.first.result.prediction.toLowerCase();
        final probability =
            s.questionnaireResults.first.result.probability.toLowerCase();
        return prediction.contains(query.toLowerCase()) ||
            probability.contains(query.toLowerCase());
      }).toList();
    }
  }

  void clearSearch() {
    searchController.clear();
    searchText.value = '';
    filteredSubmissions.value = submissions;
  }
}