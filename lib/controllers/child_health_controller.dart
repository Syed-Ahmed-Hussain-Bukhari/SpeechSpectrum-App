// lib/controllers/child_health_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speechspectrum/models/child_health_model.dart';
import 'package:speechspectrum/services/child_health_service.dart';

class ChildHealthController extends GetxController {
  final ChildHealthService _service = ChildHealthService();

  var isLoading = false.obs;
  var isSaving = false.obs;
  var isUploading = false.obs;
  var isDeletingRecord = false.obs;

  var healthData = Rxn<ChildHealthData>();
  var uploadProgress = 0.0.obs;
  var uploadedCount = 0.obs;
  var totalToUpload = 0.obs;

  // ─── Fetch health profile ─────────────────────────────────────────────────
  Future<void> fetchHealthProfile(String childId) async {
    try {
      isLoading.value = true;
      final response = await _service.getHealthProfile(childId);
      if (response.status && response.data != null) {
        healthData.value = response.data;
      } else {
        healthData.value = null;
      }
    } catch (e) {
      healthData.value = null;
      debugPrint('fetchHealthProfile error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // ─── Save health profile (create or update) ───────────────────────────────
  Future<bool> saveHealthProfile({
    required String childId,
    required Map<String, dynamic> data,
    bool isUpdate = false,
  }) async {
    try {
      isSaving.value = true;
      final response = await _service.saveHealthProfile(
        childId: childId,
        data: data,
        isUpdate: isUpdate,
      );
      if (response.status) {
        healthData.value = response.data;
        _snack('Success', response.message, isError: false);
        return true;
      } else {
        _snack('Error', response.message);
        return false;
      }
    } catch (e) {
      _snack('Error', e.toString().replaceFirst('Exception: ', ''));
      return false;
    } finally {
      isSaving.value = false;
    }
  }

  // ─── Upload multiple medical records sequentially ─────────────────────────
  Future<bool> uploadMedicalRecords({
    required String childId,
    required List<Map<String, String>> records, // [{path, type}]
  }) async {
    try {
      isUploading.value = true;
      uploadedCount.value = 0;
      totalToUpload.value = records.length;

      ChildHealthModel? lastResponse;

      for (final record in records) {
        final response = await _service.uploadMedicalRecord(
          childId: childId,
          filePath: record['path']!,
          documentType: record['type']!,
        );
        if (!response.status) {
          _snack('Upload Error', response.message);
          return false;
        }
        lastResponse = response;
        uploadedCount.value++;
      }

      if (lastResponse != null && lastResponse.status) {
        healthData.value = lastResponse.data;
        _snack('Success', '${records.length} document${records.length > 1 ? 's' : ''} uploaded successfully', isError: false);
      }
      return true;
    } catch (e) {
      _snack('Error', e.toString().replaceFirst('Exception: ', ''));
      return false;
    } finally {
      isUploading.value = false;
    }
  }

  // ─── Update a single medical record ───────────────────────────────────────
  Future<bool> updateMedicalRecord({
    required String childId,
    required String documentId,
    required String filePath,
    required String documentType,
  }) async {
    try {
      isUploading.value = true;
      final response = await _service.updateMedicalRecord(
        childId: childId,
        documentId: documentId,
        filePath: filePath,
        documentType: documentType,
      );
      if (response.status) {
        healthData.value = response.data;
        _snack('Success', 'Medical record updated', isError: false);
        return true;
      } else {
        _snack('Error', response.message);
        return false;
      }
    } catch (e) {
      _snack('Error', e.toString().replaceFirst('Exception: ', ''));
      return false;
    } finally {
      isUploading.value = false;
    }
  }

  // ─── Delete a medical record ──────────────────────────────────────────────
  Future<bool> deleteMedicalRecord({
    required String childId,
    required String documentId,
  }) async {
    try {
      isDeletingRecord.value = true;
      final response = await _service.deleteMedicalRecord(documentId);
      if (response.status) {
        // Remove locally
        if (healthData.value != null) {
          final updated = (healthData.value!.medicalRecords ?? [])
              .where((r) => r.documentId != documentId)
              .toList();
          healthData.value = ChildHealthData(
            profileId: healthData.value!.profileId,
            childId: healthData.value!.childId,
            bloodGroup: healthData.value!.bloodGroup,
            knownAllergies: healthData.value!.knownAllergies,
            familyHistoryAsd: healthData.value!.familyHistoryAsd,
            familyHistorysSpeechDisorders: healthData.value!.familyHistorysSpeechDisorders,
            familyHistoryHearingLoss: healthData.value!.familyHistoryHearingLoss,
            geneticDisorders: healthData.value!.geneticDisorders,
            chronicConditions: healthData.value!.chronicConditions,
            weightKg: healthData.value!.weightKg,
            heightCm: healthData.value!.heightCm,
            bmi: healthData.value!.bmi,
            medicalRecords: updated,
            currentPrescriptions: healthData.value!.currentPrescriptions,
            createdAt: healthData.value!.createdAt,
            updatedAt: healthData.value!.updatedAt,
          );
        }
        _snack('Success', response.message, isError: false);
        return true;
      } else {
        _snack('Error', response.message);
        return false;
      }
    } catch (e) {
      _snack('Error', e.toString().replaceFirst('Exception: ', ''));
      return false;
    } finally {
      isDeletingRecord.value = false;
    }
  }

  void _snack(String title, String message, {bool isError = true}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isError ? const Color(0xFFE74C3C) : const Color(0xFF4CAF50),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 3),
    );
  }
}