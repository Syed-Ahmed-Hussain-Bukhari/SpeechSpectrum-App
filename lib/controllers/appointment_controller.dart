// lib/controllers/appointment_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/models/appointment_model.dart';
import 'package:speechspectrum/services/appointment_service.dart';

class AppointmentController extends GetxController {
  final AppointmentService _appointmentService = AppointmentService();

  var isLoading = false.obs;
  var isCreating = false.obs;
  var isSaving = false.obs;

  var appointments = <ExpertAppointmentItem>[].obs;
  var appointmentDetails = Rx<AppointmentDetailsModel?>(null);

  // Text Controllers for forms
  final topicController = TextEditingController();
  final durationController = TextEditingController();
  final contactController = TextEditingController();
  final locationController = TextEditingController();
  final discussionSummaryController = TextEditingController();
  final notesController = TextEditingController();
  final recommendationsController = TextEditingController();
  final feedbackController = TextEditingController();

  // Prescription controllers
  var prescriptions = <PrescriptionForm>[].obs;

  @override
  void onInit() {
    super.onInit();
    durationController.text = '30'; // Default duration
  }

  @override
  void onClose() {
    topicController.dispose();
    durationController.dispose();
    contactController.dispose();
    locationController.dispose();
    discussionSummaryController.dispose();
    notesController.dispose();
    recommendationsController.dispose();
    feedbackController.dispose();
    for (var prescription in prescriptions) {
      prescription.nameController.dispose();
      prescription.dosageController.dispose();
      prescription.durationController.dispose();
    }
    super.onClose();
  }

  // Add Prescription
  void addPrescription() {
    prescriptions.add(PrescriptionForm());
  }

  // Remove Prescription
  void removePrescription(int index) {
    if (prescriptions.length > index) {
      prescriptions[index].nameController.dispose();
      prescriptions[index].dosageController.dispose();
      prescriptions[index].durationController.dispose();
      prescriptions.removeAt(index);
    }
  }

  // Clear all form data
  void clearFormData() {
    topicController.clear();
    durationController.text = '30';
    contactController.clear();
    locationController.clear();
    discussionSummaryController.clear();
    notesController.clear();
    recommendationsController.clear();
    feedbackController.clear();
    
    for (var prescription in prescriptions) {
      prescription.nameController.dispose();
      prescription.dosageController.dispose();
      prescription.durationController.dispose();
    }
    prescriptions.clear();
  }

  // Create Appointment with Google Meet
  Future<bool> createAppointmentWithMeet({
    required String linkId,
    required String childName,
    required DateTime scheduledDateTime,
  }) async {
    try {
      isCreating.value = true;

      // First, generate zoom link
      final zoomResponse = await _appointmentService.generateZoomLink(
        topic: 'Speech Therapy - $childName',
        startTime: scheduledDateTime.toUtc().toIso8601String(),
        duration: int.tryParse(durationController.text) ?? 30,
        timezone: 'UTC',
      );

      debugPrint('✅ Zoom link generated: ${zoomResponse.data.joinUrl}');

      // Then create appointment with the link
      final appointmentResponse = await _appointmentService.createAppointment(
        linkId: linkId,
        appointmentType: 'google_meet',
        scheduledAt: scheduledDateTime.toUtc().toIso8601String(),
        meetLink: zoomResponse.data.joinUrl,
      );

      _showSuccess(appointmentResponse.message);
      clearFormData();
      await fetchExpertAppointments(); // Refresh list
      return true;
    } catch (e) {
      debugPrint('❌ Error creating appointment with meet: $e');
      _showError(e.toString().replaceAll('Exception: ', ''));
      return false;
    } finally {
      isCreating.value = false;
    }
  }

  // Create Appointment with Call
  Future<bool> createAppointmentWithCall({
    required String linkId,
    required DateTime scheduledDateTime,
    required String contact,
  }) async {
    try {
      isCreating.value = true;

      final response = await _appointmentService.createAppointment(
        linkId: linkId,
        appointmentType: 'call',
        scheduledAt: scheduledDateTime.toUtc().toIso8601String(),
        contact: contact,
      );

      _showSuccess(response.message);
      clearFormData();
      await fetchExpertAppointments();
      return true;
    } catch (e) {
      debugPrint('❌ Error creating appointment with call: $e');
      _showError(e.toString().replaceAll('Exception: ', ''));
      return false;
    } finally {
      isCreating.value = false;
    }
  }

  // Create Appointment with Physical Address
  Future<bool> createAppointmentWithPhysical({
    required String linkId,
    required DateTime scheduledDateTime,
    required String location,
  }) async {
    try {
      isCreating.value = true;

      final response = await _appointmentService.createAppointment(
        linkId: linkId,
        appointmentType: 'physical',
        scheduledAt: scheduledDateTime.toUtc().toIso8601String(),
        location: location,
      );

      _showSuccess(response.message);
      clearFormData();
      await fetchExpertAppointments();
      return true;
    } catch (e) {
      debugPrint('❌ Error creating appointment with physical: $e');
      _showError(e.toString().replaceAll('Exception: ', ''));
      return false;
    } finally {
      isCreating.value = false;
    }
  }

  // Create Appointment with Chat
  Future<bool> createAppointmentWithChat({
    required String linkId,
    required DateTime scheduledDateTime,
  }) async {
    try {
      isCreating.value = true;

      final response = await _appointmentService.createAppointment(
        linkId: linkId,
        appointmentType: 'chat',
        scheduledAt: scheduledDateTime.toUtc().toIso8601String(),
      );

      _showSuccess(response.message);
      clearFormData();
      await fetchExpertAppointments();
      return true;
    } catch (e) {
      debugPrint('❌ Error creating appointment with chat: $e');
      _showError(e.toString().replaceAll('Exception: ', ''));
      return false;
    } finally {
      isCreating.value = false;
    }
  }

  // Fetch Expert Appointments
  Future<void> fetchExpertAppointments() async {
    try {
      isLoading.value = true;
      debugPrint('🔐 Fetching expert appointments');

      final response = await _appointmentService.getExpertAppointments();

      debugPrint('✅ Appointments fetched: ${response.data.length}');

      if (response.status) {
        appointments.value = response.data;
      } else {
        _showError(response.message);
      }
    } catch (e) {
      debugPrint('❌ Error fetching appointments: $e');
      _showError(e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  // Save Appointment Notes
  Future<bool> saveAppointmentNotes({
    required String appointmentId,
  }) async {
    try {
      isSaving.value = true;

      // Build medication object
      final medicationData = {
        'prescriptions': prescriptions
            .map((p) => {
                  'name': p.nameController.text.trim(),
                  'dosage': p.dosageController.text.trim(),
                  'duration': p.durationController.text.trim(),
                })
            .toList(),
        'recommendations': recommendationsController.text.trim(),
      };

      final response = await _appointmentService.saveAppointmentNotes(
        appointmentId: appointmentId,
        discussionSummary: discussionSummaryController.text.trim(),
        notes: notesController.text.trim(),
        medication: medicationData,
      );

      _showSuccess(response.message);
      return true;
    } catch (e) {
      debugPrint('❌ Error saving notes: $e');
      _showError(e.toString().replaceAll('Exception: ', ''));
      return false;
    } finally {
      isSaving.value = false;
    }
  }

  // Save Appointment Feedback
  Future<bool> saveAppointmentFeedback({
    required String appointmentId,
  }) async {
    try {
      isSaving.value = true;

      final response = await _appointmentService.saveAppointmentFeedback(
        appointmentId: appointmentId,
        progressFeedback: feedbackController.text.trim(),
      );

      _showSuccess(response.message);
      clearFormData();
      return true;
    } catch (e) {
      debugPrint('❌ Error saving feedback: $e');
      _showError(e.toString().replaceAll('Exception: ', ''));
      return false;
    } finally {
      isSaving.value = false;
    }
  }

  // Fetch Appointment Details
  Future<void> fetchAppointmentDetails({
    required String appointmentId,
  }) async {
    try {
      isLoading.value = true;

      final response = await _appointmentService.getAppointmentDetails(
        appointmentId: appointmentId,
      );

      if (response.status) {
        appointmentDetails.value = response;
      } else {
        _showError(response.message);
      }
    } catch (e) {
      debugPrint('❌ Error fetching appointment details: $e');
      _showError(e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  // Get counts
  int getScheduledCount() {
    return appointments.where((a) => a.isScheduled()).length;
  }

  int getCompletedCount() {
    return appointments.where((a) => a.isCompleted()).length;
  }

  void _showSuccess(String message) {
    Get.snackbar(
      'Success',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.successColor,
      colorText: AppColors.whiteColor,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 3),
    );
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

// Helper class for prescription forms
class PrescriptionForm {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dosageController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
}