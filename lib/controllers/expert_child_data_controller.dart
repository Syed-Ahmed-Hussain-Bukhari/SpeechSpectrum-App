// lib/controllers/expert_child_data_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/services/expert_child_data_service.dart';

class ExpertChildDataController extends GetxController {
  final ExpertChildDataService _service = ExpertChildDataService();

  // ── State ──────────────────────────────────────────────────────────────────
  final isLoadingScreening = false.obs;
  final isLoadingScreeningDetail = false.obs;
  final isLoadingSpeech = false.obs;
  final isLoadingSpeechDetail = false.obs;

  final screeningList = <ExpertScreeningItem>[].obs;
  final filteredScreeningList = <ExpertScreeningItem>[].obs;
  final selectedScreening = Rxn<ExpertScreeningItem>();

  final speechList = <ExpertSpeechItem>[].obs;
  final filteredSpeechList = <ExpertSpeechItem>[].obs;
  final selectedSpeech = Rxn<ExpertSpeechItem>();

  final screeningSearch = ''.obs;
  final speechSearch = ''.obs;

  // ── Screening ──────────────────────────────────────────────────────────────

  Future<void> fetchScreening(String childId) async {
    try {
      isLoadingScreening.value = true;
      screeningList.clear();
      filteredScreeningList.clear();
      final result = await _service.getScreeningByChild(childId);
      if (result.status) {
        screeningList.assignAll(result.data);
        filteredScreeningList.assignAll(result.data);
      }
    } catch (e) {
      _showError(_clean(e));
    } finally {
      isLoadingScreening.value = false;
    }
  }

  void filterScreening(String query) {
    screeningSearch.value = query;
    if (query.trim().isEmpty) {
      filteredScreeningList.assignAll(screeningList);
    } else {
      final q = query.toLowerCase();
      filteredScreeningList.assignAll(screeningList.where((s) {
        if (s.questionnaireResults.isEmpty) return false;
        final prob = s.questionnaireResults.first.result.probability
            .toLowerCase();
        final pred = s.questionnaireResults.first.result.prediction
            .toLowerCase();
        return prob.contains(q) || pred.contains(q);
      }).toList());
    }
  }

  Future<void> fetchScreeningDetail(String submissionId) async {
    try {
      isLoadingScreeningDetail.value = true;
      selectedScreening.value = null;
      final result = await _service.getScreeningDetail(submissionId);
      if (result.status) {
        selectedScreening.value = result.data;
      }
    } catch (e) {
      _showError(_clean(e));
    } finally {
      isLoadingScreeningDetail.value = false;
    }
  }

  // ── Speech ─────────────────────────────────────────────────────────────────

  Future<void> fetchSpeech(String childId) async {
    try {
      isLoadingSpeech.value = true;
      speechList.clear();
      filteredSpeechList.clear();
      final list = await _service.getSpeechByChild(childId);
      speechList.assignAll(list);
      filteredSpeechList.assignAll(list);
    } catch (e) {
      _showError(_clean(e));
    } finally {
      isLoadingSpeech.value = false;
    }
  }

  void filterSpeech(String query) {
    speechSearch.value = query;
    if (query.trim().isEmpty) {
      filteredSpeechList.assignAll(speechList);
    } else {
      final q = query.toLowerCase();
      filteredSpeechList.assignAll(speechList.where((s) {
        if (!s.hasResults) return false;
        final risk = s.latestResult!.result.riskInterpretation
            .toLowerCase();
        return risk.contains(q);
      }).toList());
    }
  }

  Future<void> fetchSpeechDetail(String submissionId) async {
    try {
      isLoadingSpeechDetail.value = true;
      selectedSpeech.value = null;
      final result = await _service.getSpeechDetail(submissionId);
      if (result.status) {
        selectedSpeech.value = result.data;
      }
    } catch (e) {
      _showError(_clean(e));
    } finally {
      isLoadingSpeechDetail.value = false;
    }
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  void clearAll() {
    screeningList.clear();
    filteredScreeningList.clear();
    speechList.clear();
    filteredSpeechList.clear();
    selectedScreening.value = null;
    selectedSpeech.value = null;
    screeningSearch.value = '';
    speechSearch.value = '';
  }

  String _clean(dynamic e) =>
      e.toString().replaceAll('Exception: ', '').trim();

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
      icon: const Icon(Icons.error_rounded, color: Colors.white, size: 20),
    );
  }
}