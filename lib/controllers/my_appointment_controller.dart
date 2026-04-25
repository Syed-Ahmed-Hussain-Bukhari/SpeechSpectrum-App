// // // // lib/controllers/my_appointment_controller.dart
// // // import 'package:flutter/material.dart';
// // // import 'package:get/get.dart';
// // // import 'package:speechspectrum/constants/app_colors.dart';
// // // import 'package:speechspectrum/models/my_appointment_model.dart';
// // // import 'package:speechspectrum/services/my_appointment_service.dart';

// // // class MyAppointmentController extends GetxController {
// // //   final MyAppointmentService _service = MyAppointmentService();

// // //   // ── State ──────────────────────────────────────────────────
// // //   var isLoading = false.obs;
// // //   var isActing = false.obs;
// // //   var isLoadingDetail = false.obs;
// // //   var isLoadingRecords = false.obs;
// // //   var isSavingRecord = false.obs;

// // //   var appointments = <MyAppointmentItem>[].obs;
// // //   var selectedAppointment = Rxn<MyAppointmentItem>();
// // //   var records = <AppointmentRecordItem>[].obs;

// // //   // ── Record form controllers ────────────────────────────────
// // //   final notesCtrl = TextEditingController();
// // //   final therapyPlanCtrl = TextEditingController();
// // //   final medicationNameCtrl = TextEditingController();
// // //   final medicationDosageCtrl = TextEditingController();
// // //   final progressFeedbackCtrl = TextEditingController();

// // //   @override
// // //   void onClose() {
// // //     notesCtrl.dispose();
// // //     therapyPlanCtrl.dispose();
// // //     medicationNameCtrl.dispose();
// // //     medicationDosageCtrl.dispose();
// // //     progressFeedbackCtrl.dispose();
// // //     super.onClose();
// // //   }

// // //   void clearRecordForm() {
// // //     notesCtrl.clear();
// // //     therapyPlanCtrl.clear();
// // //     medicationNameCtrl.clear();
// // //     medicationDosageCtrl.clear();
// // //     progressFeedbackCtrl.clear();
// // //   }

// // //   void populateRecordForm(AppointmentRecordItem record) {
// // //     notesCtrl.text = record.notes;
// // //     therapyPlanCtrl.text = record.therapyPlan;
// // //     progressFeedbackCtrl.text = record.progressFeedback;
// // //     if (record.medication != null) {
// // //       medicationNameCtrl.text = record.medication!['name'] ?? '';
// // //       medicationDosageCtrl.text = record.medication!['dosage']?.toString() ?? '';
// // //     }
// // //   }

// // //   // ── Filtered lists ─────────────────────────────────────────
// // //   List<MyAppointmentItem> get allAppointments => appointments;

// // //   List<MyAppointmentItem> get scheduledList =>
// // //       appointments.where((a) => a.isScheduled).toList();

// // //   List<MyAppointmentItem> get confirmedList =>
// // //       appointments.where((a) => a.isConfirmed).toList();

// // //   List<MyAppointmentItem> get completedList =>
// // //       appointments.where((a) => a.isCompleted).toList();

// // //   List<MyAppointmentItem> get cancelledList =>
// // //       appointments.where((a) => a.isCancelled).toList();

// // //   List<MyAppointmentItem> get noShowList =>
// // //       appointments.where((a) => a.isNoShow).toList();

// // //   // ── API calls ──────────────────────────────────────────────

// // //   Future<void> fetchMyAppointments() async {
// // //     try {
// // //       isLoading.value = true;
// // //       final response = await _service.getMyAppointments();
// // //       if (response.success) {
// // //         appointments.value = response.data;
// // //       } else {
// // //         _showError('Failed to load appointments');
// // //       }
// // //     } catch (e) {
// // //       _showError(e.toString().replaceAll('Exception: ', ''));
// // //     } finally {
// // //       isLoading.value = false;
// // //     }
// // //   }

// // //   Future<void> fetchAppointmentDetail(String appointmentId) async {
// // //     try {
// // //       isLoadingDetail.value = true;
// // //       final response = await _service.getAppointmentById(appointmentId);
// // //       if (response.success) {
// // //         selectedAppointment.value = response.data;
// // //       }
// // //     } catch (e) {
// // //       _showError(e.toString().replaceAll('Exception: ', ''));
// // //     } finally {
// // //       isLoadingDetail.value = false;
// // //     }
// // //   }

// // //   Future<bool> confirmAppointment(String appointmentId) async {
// // //     try {
// // //       isActing.value = true;
// // //       final response = await _service.confirmAppointment(appointmentId);
// // //       if (response.success) {
// // //         _updateLocal(response.data);
// // //         _showSuccess('Appointment confirmed successfully');
// // //         return true;
// // //       }
// // //       return false;
// // //     } catch (e) {
// // //       _showError(e.toString().replaceAll('Exception: ', ''));
// // //       return false;
// // //     } finally {
// // //       isActing.value = false;
// // //     }
// // //   }

// // //   Future<bool> completeAppointment(String appointmentId) async {
// // //     try {
// // //       isActing.value = true;
// // //       final response = await _service.completeAppointment(appointmentId);
// // //       if (response.success) {
// // //         _updateLocal(response.data);
// // //         _showSuccess('Appointment marked as completed');
// // //         return true;
// // //       }
// // //       return false;
// // //     } catch (e) {
// // //       _showError(e.toString().replaceAll('Exception: ', ''));
// // //       return false;
// // //     } finally {
// // //       isActing.value = false;
// // //     }
// // //   }

// // //   Future<bool> cancelAppointment(String appointmentId, String reason) async {
// // //     try {
// // //       isActing.value = true;
// // //       final response = await _service.cancelAppointment(appointmentId, reason);
// // //       if (response.success) {
// // //         _updateLocal(response.data);
// // //         _showSuccess('Appointment cancelled');
// // //         return true;
// // //       }
// // //       return false;
// // //     } catch (e) {
// // //       _showError(e.toString().replaceAll('Exception: ', ''));
// // //       return false;
// // //     } finally {
// // //       isActing.value = false;
// // //     }
// // //   }

// // //   Future<bool> markNoShow(String appointmentId) async {
// // //     try {
// // //       isActing.value = true;
// // //       final response = await _service.markNoShow(appointmentId);
// // //       if (response.success) {
// // //         _updateLocal(response.data);
// // //         _showSuccess('Marked as no-show');
// // //         return true;
// // //       }
// // //       return false;
// // //     } catch (e) {
// // //       _showError(e.toString().replaceAll('Exception: ', ''));
// // //       return false;
// // //     } finally {
// // //       isActing.value = false;
// // //     }
// // //   }

// // //   // Records

// // //   Future<void> fetchRecords(String appointmentId) async {
// // //     try {
// // //       isLoadingRecords.value = true;
// // //       records.clear();
// // //       final response = await _service.getRecords(appointmentId);
// // //       if (response.success) {
// // //         records.value = response.data;
// // //       }
// // //     } catch (e) {
// // //       _showError(e.toString().replaceAll('Exception: ', ''));
// // //     } finally {
// // //       isLoadingRecords.value = false;
// // //     }
// // //   }

// // //   Future<bool> createRecord(String appointmentId) async {
// // //     if (!_validateRecordForm()) return false;
// // //     try {
// // //       isSavingRecord.value = true;
// // //       final response = await _service.createRecord(
// // //         appointmentId: appointmentId,
// // //         notes: notesCtrl.text.trim(),
// // //         therapyPlan: therapyPlanCtrl.text.trim(),
// // //         medication: {
// // //           'name': medicationNameCtrl.text.trim().isEmpty
// // //               ? 'None'
// // //               : medicationNameCtrl.text.trim(),
// // //           'dosage': medicationDosageCtrl.text.trim().isEmpty
// // //               ? null
// // //               : medicationDosageCtrl.text.trim(),
// // //         },
// // //         progressFeedback: progressFeedbackCtrl.text.trim(),
// // //       );
// // //       if (response.success) {
// // //         records.insert(0, response.data);
// // //         _showSuccess('Session record saved');
// // //         clearRecordForm();
// // //         return true;
// // //       }
// // //       return false;
// // //     } catch (e) {
// // //       _showError(e.toString().replaceAll('Exception: ', ''));
// // //       return false;
// // //     } finally {
// // //       isSavingRecord.value = false;
// // //     }
// // //   }

// // //   Future<bool> updateRecord(
// // //       String appointmentId, String recordId) async {
// // //     if (!_validateRecordForm()) return false;
// // //     try {
// // //       isSavingRecord.value = true;
// // //       final response = await _service.updateRecord(
// // //         appointmentId: appointmentId,
// // //         recordId: recordId,
// // //         notes: notesCtrl.text.trim(),
// // //         therapyPlan: therapyPlanCtrl.text.trim(),
// // //         medication: {
// // //           'name': medicationNameCtrl.text.trim().isEmpty
// // //               ? 'None'
// // //               : medicationNameCtrl.text.trim(),
// // //           'dosage': medicationDosageCtrl.text.trim().isEmpty
// // //               ? null
// // //               : medicationDosageCtrl.text.trim(),
// // //         },
// // //         progressFeedback: progressFeedbackCtrl.text.trim(),
// // //       );
// // //       if (response.success) {
// // //         final idx = records.indexWhere((r) => r.recordId == recordId);
// // //         if (idx != -1) records[idx] = response.data;
// // //         _showSuccess('Record updated');
// // //         clearRecordForm();
// // //         return true;
// // //       }
// // //       return false;
// // //     } catch (e) {
// // //       _showError(e.toString().replaceAll('Exception: ', ''));
// // //       return false;
// // //     } finally {
// // //       isSavingRecord.value = false;
// // //     }
// // //   }

// // //   // ── Helpers ────────────────────────────────────────────────
// // //   void _updateLocal(MyAppointmentItem updated) {
// // //     final idx = appointments.indexWhere(
// // //         (a) => a.appointmentId == updated.appointmentId);
// // //     if (idx != -1) appointments[idx] = updated;
// // //     if (selectedAppointment.value?.appointmentId == updated.appointmentId) {
// // //       selectedAppointment.value = updated;
// // //     }
// // //   }

// // //   bool _validateRecordForm() {
// // //     if (notesCtrl.text.trim().isEmpty) {
// // //       _showError('Please enter session notes');
// // //       return false;
// // //     }
// // //     if (therapyPlanCtrl.text.trim().isEmpty) {
// // //       _showError('Please enter a therapy plan');
// // //       return false;
// // //     }
// // //     if (progressFeedbackCtrl.text.trim().isEmpty) {
// // //       _showError('Please enter progress feedback');
// // //       return false;
// // //     }
// // //     return true;
// // //   }

// // //   void _showSuccess(String msg) => Get.snackbar('Success', msg,
// // //       snackPosition: SnackPosition.BOTTOM,
// // //       backgroundColor: AppColors.successColor,
// // //       colorText: AppColors.whiteColor,
// // //       margin: const EdgeInsets.all(16),
// // //       borderRadius: 12,
// // //       duration: const Duration(seconds: 3));

// // //   void _showError(String msg) => Get.snackbar('Error', msg,
// // //       snackPosition: SnackPosition.BOTTOM,
// // //       backgroundColor: AppColors.errorColor,
// // //       colorText: AppColors.whiteColor,
// // //       margin: const EdgeInsets.all(16),
// // //       borderRadius: 12,
// // //       duration: const Duration(seconds: 4));
// // // }


// // // lib/controllers/my_appointment_controller.dart
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:speechspectrum/constants/app_colors.dart';
// // import 'package:speechspectrum/models/my_appointment_model.dart';
// // import 'package:speechspectrum/services/my_appointment_service.dart';

// // class MyAppointmentController extends GetxController {
// //   final MyAppointmentService _service = MyAppointmentService();

// //   // ── State ──────────────────────────────────────────────────────
// //   var isLoading = false.obs;
// //   var isActing = false.obs;
// //   var isLoadingDetail = false.obs;
// //   var isLoadingRecords = false.obs;
// //   var isSavingRecord = false.obs;

// //   var appointments = <MyAppointmentItem>[].obs;
// //   var selectedAppointment = Rxn<MyAppointmentItem>();
// //   var records = <AppointmentRecordItem>[].obs;

// //   // ── Record form controllers ────────────────────────────────────
// //   final notesCtrl = TextEditingController();
// //   final therapyPlanCtrl = TextEditingController();
// //   final medicationNameCtrl = TextEditingController();
// //   final medicationDosageCtrl = TextEditingController();
// //   final progressFeedbackCtrl = TextEditingController();

// //   @override
// //   void onClose() {
// //     notesCtrl.dispose();
// //     therapyPlanCtrl.dispose();
// //     medicationNameCtrl.dispose();
// //     medicationDosageCtrl.dispose();
// //     progressFeedbackCtrl.dispose();
// //     super.onClose();
// //   }

// //   void clearRecordForm() {
// //     notesCtrl.clear();
// //     therapyPlanCtrl.clear();
// //     medicationNameCtrl.clear();
// //     medicationDosageCtrl.clear();
// //     progressFeedbackCtrl.clear();
// //   }

// //   void populateRecordForm(AppointmentRecordItem record) {
// //     notesCtrl.text = record.notes;
// //     therapyPlanCtrl.text = record.therapyPlan;
// //     progressFeedbackCtrl.text = record.progressFeedback;
// //     if (record.medication != null) {
// //       medicationNameCtrl.text = (record.medication!['name'] ?? '').toString();
// //       medicationDosageCtrl.text =
// //           (record.medication!['dosage'] ?? '').toString();
// //     } else {
// //       medicationNameCtrl.clear();
// //       medicationDosageCtrl.clear();
// //     }
// //   }

// //   // ── Filtered lists ─────────────────────────────────────────────
// //   List<MyAppointmentItem> get allAppointments => appointments;

// //   List<MyAppointmentItem> get scheduledList =>
// //       appointments.where((a) => a.isScheduled).toList();

// //   List<MyAppointmentItem> get confirmedList =>
// //       appointments.where((a) => a.isConfirmed).toList();

// //   List<MyAppointmentItem> get completedList =>
// //       appointments.where((a) => a.isCompleted).toList();

// //   List<MyAppointmentItem> get cancelledList =>
// //       appointments.where((a) => a.isCancelled).toList();

// //   List<MyAppointmentItem> get noShowList =>
// //       appointments.where((a) => a.isNoShow).toList();

// //   // ── Fetch all ──────────────────────────────────────────────────

// //   Future<void> fetchMyAppointments() async {
// //     try {
// //       isLoading.value = true;
// //       final response = await _service.getMyAppointments();
// //       if (response.success) {
// //         appointments.value = response.data;
// //       } else {
// //         _showError('Failed to load appointments');
// //       }
// //     } catch (e) {
// //       _showError(_clean(e));
// //     } finally {
// //       isLoading.value = false;
// //     }
// //   }

// //   // ── Fetch single ───────────────────────────────────────────────

// //   Future<void> fetchAppointmentDetail(String appointmentId) async {
// //     try {
// //       isLoadingDetail.value = true;
// //       final response = await _service.getAppointmentById(appointmentId);
// //       if (response.success) {
// //         selectedAppointment.value = response.data;
// //         // Also keep the list in sync
// //         _mergeIntoList(response.data);
// //       }
// //     } catch (e) {
// //       _showError(_clean(e));
// //     } finally {
// //       isLoadingDetail.value = false;
// //     }
// //   }

// //   // ── Actions ────────────────────────────────────────────────────

// //   Future<bool> confirmAppointment(String appointmentId) async {
// //     try {
// //       isActing.value = true;
// //       final response = await _service.confirmAppointment(appointmentId);
// //       if (response.success) {
// //         _mergeAndSelect(response.data);
// //         _showSuccess('Appointment confirmed successfully');
// //         return true;
// //       }
// //       _showError('Failed to confirm appointment');
// //       return false;
// //     } catch (e) {
// //       _showError(_clean(e));
// //       return false;
// //     } finally {
// //       isActing.value = false;
// //     }
// //   }

// //   Future<bool> completeAppointment(String appointmentId) async {
// //     try {
// //       isActing.value = true;
// //       final response = await _service.completeAppointment(appointmentId);
// //       if (response.success) {
// //         _mergeAndSelect(response.data);
// //         _showSuccess('Appointment marked as completed');
// //         return true;
// //       }
// //       _showError('Failed to complete appointment');
// //       return false;
// //     } catch (e) {
// //       _showError(_clean(e));
// //       return false;
// //     } finally {
// //       isActing.value = false;
// //     }
// //   }

// //   Future<bool> cancelAppointment(String appointmentId, String reason) async {
// //     try {
// //       isActing.value = true;
// //       final response = await _service.cancelAppointment(appointmentId, reason);
// //       if (response.success) {
// //         _mergeAndSelect(response.data);
// //         _showSuccess('Appointment cancelled');
// //         return true;
// //       }
// //       _showError('Failed to cancel appointment');
// //       return false;
// //     } catch (e) {
// //       _showError(_clean(e));
// //       return false;
// //     } finally {
// //       isActing.value = false;
// //     }
// //   }

// //   Future<bool> markNoShow(String appointmentId) async {
// //     try {
// //       isActing.value = true;
// //       final response = await _service.markNoShow(appointmentId);
// //       if (response.success) {
// //         _mergeAndSelect(response.data);
// //         _showSuccess('Marked as no-show');
// //         return true;
// //       }
// //       _showError('Failed to mark no-show');
// //       return false;
// //     } catch (e) {
// //       _showError(_clean(e));
// //       return false;
// //     } finally {
// //       isActing.value = false;
// //     }
// //   }

// //   // ── Records ────────────────────────────────────────────────────

// //   Future<void> fetchRecords(String appointmentId) async {
// //     try {
// //       isLoadingRecords.value = true;
// //       records.clear();
// //       final response = await _service.getRecords(appointmentId);
// //       if (response.success) {
// //         records.value = response.data;
// //       }
// //     } catch (e) {
// //       _showError(_clean(e));
// //     } finally {
// //       isLoadingRecords.value = false;
// //     }
// //   }

// //   Future<bool> createRecord(String appointmentId) async {
// //     if (!_validateRecordForm()) return false;
// //     try {
// //       isSavingRecord.value = true;
// //       final response = await _service.createRecord(
// //         appointmentId: appointmentId,
// //         notes: notesCtrl.text.trim(),
// //         therapyPlan: therapyPlanCtrl.text.trim(),
// //         medication: {
// //           'name': medicationNameCtrl.text.trim().isEmpty
// //               ? 'None'
// //               : medicationNameCtrl.text.trim(),
// //           'dosage': medicationDosageCtrl.text.trim().isEmpty
// //               ? null
// //               : medicationDosageCtrl.text.trim(),
// //         },
// //         progressFeedback: progressFeedbackCtrl.text.trim(),
// //       );
// //       if (response.success) {
// //         records.insert(0, response.data);
// //         _showSuccess('Session record saved');
// //         clearRecordForm();
// //         return true;
// //       }
// //       _showError('Failed to save record');
// //       return false;
// //     } catch (e) {
// //       _showError(_clean(e));
// //       return false;
// //     } finally {
// //       isSavingRecord.value = false;
// //     }
// //   }

// //   Future<bool> updateRecord(String appointmentId, String recordId) async {
// //     if (!_validateRecordForm()) return false;
// //     try {
// //       isSavingRecord.value = true;
// //       final response = await _service.updateRecord(
// //         appointmentId: appointmentId,
// //         recordId: recordId,
// //         notes: notesCtrl.text.trim(),
// //         therapyPlan: therapyPlanCtrl.text.trim(),
// //         medication: {
// //           'name': medicationNameCtrl.text.trim().isEmpty
// //               ? 'None'
// //               : medicationNameCtrl.text.trim(),
// //           'dosage': medicationDosageCtrl.text.trim().isEmpty
// //               ? null
// //               : medicationDosageCtrl.text.trim(),
// //         },
// //         progressFeedback: progressFeedbackCtrl.text.trim(),
// //       );
// //       if (response.success) {
// //         final idx = records.indexWhere((r) => r.recordId == recordId);
// //         if (idx != -1) records[idx] = response.data;
// //         _showSuccess('Record updated');
// //         clearRecordForm();
// //         return true;
// //       }
// //       _showError('Failed to update record');
// //       return false;
// //     } catch (e) {
// //       _showError(_clean(e));
// //       return false;
// //     } finally {
// //       isSavingRecord.value = false;
// //     }
// //   }

// //   // ── Helpers ────────────────────────────────────────────────────

// //   /// Merges the action-API response (which has no nested relations) with the
// //   /// existing item in the list so children/expertUsers/slots are preserved.
// //   void _mergeAndSelect(MyAppointmentItem updated) {
// //     final idx = appointments
// //         .indexWhere((a) => a.appointmentId == updated.appointmentId);

// //     MyAppointmentItem merged;
// //     if (idx != -1) {
// //       merged = appointments[idx].mergeWith(updated);
// //       appointments[idx] = merged;
// //     } else {
// //       merged = updated;
// //     }

// //     // Also merge with the currently selected appointment
// //     if (selectedAppointment.value?.appointmentId == updated.appointmentId) {
// //       final current = selectedAppointment.value!;
// //       selectedAppointment.value = current.mergeWith(updated);
// //     }
// //   }

// //   /// Merges a fully-populated item (from detail/list APIs) into the list.
// //   void _mergeIntoList(MyAppointmentItem updated) {
// //     final idx = appointments
// //         .indexWhere((a) => a.appointmentId == updated.appointmentId);
// //     if (idx != -1) {
// //       appointments[idx] = updated;
// //     }
// //   }

// //   bool _validateRecordForm() {
// //     if (notesCtrl.text.trim().isEmpty) {
// //       _showError('Please enter session notes');
// //       return false;
// //     }
// //     if (therapyPlanCtrl.text.trim().isEmpty) {
// //       _showError('Please enter a therapy plan');
// //       return false;
// //     }
// //     if (progressFeedbackCtrl.text.trim().isEmpty) {
// //       _showError('Please enter progress feedback');
// //       return false;
// //     }
// //     return true;
// //   }

// //   String _clean(Object e) =>
// //       e.toString().replaceAll('Exception: ', '').trim();

// //   void _showSuccess(String msg) => Get.snackbar(
// //         'Success',
// //         msg,
// //         snackPosition: SnackPosition.BOTTOM,
// //         backgroundColor: AppColors.successColor,
// //         colorText: AppColors.whiteColor,
// //         margin: const EdgeInsets.all(16),
// //         borderRadius: 12,
// //         duration: const Duration(seconds: 3),
// //       );

// //   void _showError(String msg) => Get.snackbar(
// //         'Error',
// //         msg,
// //         snackPosition: SnackPosition.BOTTOM,
// //         backgroundColor: AppColors.errorColor,
// //         colorText: AppColors.whiteColor,
// //         margin: const EdgeInsets.all(16),
// //         borderRadius: 12,
// //         duration: const Duration(seconds: 4),
// //       );
// // }


// // lib/controllers/my_appointment_controller.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/models/my_appointment_model.dart';
// import 'package:speechspectrum/services/my_appointment_service.dart';

// class MyAppointmentController extends GetxController {
//   final MyAppointmentService _service = MyAppointmentService();

//   // ── Observable state ───────────────────────────────────────
//   final isLoading = false.obs;
//   final isLoadingDetail = false.obs;
//   final isLoadingRecords = false.obs;
//   final isActing = false.obs;
//   final isSavingRecord = false.obs;

//   final appointments = <MyAppointmentItem>[].obs;
//   final selectedAppointment = Rxn<MyAppointmentItem>();
//   final records = <AppointmentRecordItem>[].obs;

//   // ── Record form text controllers ───────────────────────────
//   final notesCtrl = TextEditingController();
//   final therapyPlanCtrl = TextEditingController();
//   final medicationNameCtrl = TextEditingController();
//   final medicationDosageCtrl = TextEditingController();
//   final progressFeedbackCtrl = TextEditingController();

//   @override
//   void onClose() {
//     notesCtrl.dispose();
//     therapyPlanCtrl.dispose();
//     medicationNameCtrl.dispose();
//     medicationDosageCtrl.dispose();
//     progressFeedbackCtrl.dispose();
//     super.onClose();
//   }

//   void clearRecordForm() {
//     notesCtrl.clear();
//     therapyPlanCtrl.clear();
//     medicationNameCtrl.clear();
//     medicationDosageCtrl.clear();
//     progressFeedbackCtrl.clear();
//   }

//   void populateRecordForm(AppointmentRecordItem record) {
//     notesCtrl.text = record.notes;
//     therapyPlanCtrl.text = record.therapyPlan;
//     progressFeedbackCtrl.text = record.progressFeedback;
//     if (record.medication != null) {
//       medicationNameCtrl.text = record.medication!['name']?.toString() ?? '';
//       medicationDosageCtrl.text =
//           record.medication!['dosage']?.toString() ?? '';
//     } else {
//       medicationNameCtrl.clear();
//       medicationDosageCtrl.clear();
//     }
//   }

//   // ── Filtered lists ─────────────────────────────────────────
//   List<MyAppointmentItem> get allAppointments => appointments.toList();
//   List<MyAppointmentItem> get scheduledList =>
//       appointments.where((a) => a.isScheduled).toList();
//   List<MyAppointmentItem> get confirmedList =>
//       appointments.where((a) => a.isConfirmed).toList();
//   List<MyAppointmentItem> get completedList =>
//       appointments.where((a) => a.isCompleted).toList();
//   List<MyAppointmentItem> get cancelledList =>
//       appointments.where((a) => a.isCancelled).toList();
//   List<MyAppointmentItem> get noShowList =>
//       appointments.where((a) => a.isNoShow).toList();

//   // ── Fetch all appointments ─────────────────────────────────
//   Future<void> fetchMyAppointments() async {
//     try {
//       isLoading.value = true;
//       final result = await _service.getMyAppointments();
//       if (result.success) {
//         appointments.assignAll(result.data);
//       } else {
//         _showError('Failed to load appointments');
//       }
//     } catch (e) {
//       _showError(_clean(e));
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // ── Fetch single appointment detail ───────────────────────
//   Future<void> fetchAppointmentDetail(String appointmentId) async {
//     try {
//       isLoadingDetail.value = true;
//       selectedAppointment.value = null;
//       final result = await _service.getAppointmentById(appointmentId);
//       if (result.success) {
//         selectedAppointment.value = result.data;
//       }
//     } catch (e) {
//       _showError(_clean(e));
//     } finally {
//       isLoadingDetail.value = false;
//     }
//   }

//   // ── Confirm ────────────────────────────────────────────────
//   Future<bool> confirmAppointment(String appointmentId) async {
//     try {
//       isActing.value = true;
//       final result = await _service.confirmAppointment(appointmentId);
//       if (result.success) {
//         _patchLocal(result.data);
//         await fetchMyAppointments();
//         _showSuccess('Appointment confirmed successfully!');
//         return true;
//       }
//       _showError('Could not confirm appointment');
//       return false;
//     } catch (e) {
//       _showError(_clean(e));
//       return false;
//     } finally {
//       isActing.value = false;
//     }
//   }

//   // ── Complete ───────────────────────────────────────────────
//   Future<bool> completeAppointment(String appointmentId) async {
//     try {
//       isActing.value = true;
//       final result = await _service.completeAppointment(appointmentId);
//       if (result.success) {
//         _patchLocal(result.data);
//         await fetchMyAppointments();
//         _showSuccess('Appointment marked as completed!');
//         return true;
//       }
//       _showError('Could not complete appointment');
//       return false;
//     } catch (e) {
//       _showError(_clean(e));
//       return false;
//     } finally {
//       isActing.value = false;
//     }
//   }

//   // ── Cancel ─────────────────────────────────────────────────
//   Future<bool> cancelAppointment(String appointmentId, String reason) async {
//     try {
//       isActing.value = true;
//       final result = await _service.cancelAppointment(appointmentId, reason);
//       if (result.success) {
//         _patchLocal(result.data);
//         await fetchMyAppointments();
//         _showSuccess('Appointment cancelled');
//         return true;
//       }
//       _showError('Could not cancel appointment');
//       return false;
//     } catch (e) {
//       _showError(_clean(e));
//       return false;
//     } finally {
//       isActing.value = false;
//     }
//   }

//   // ── No Show ────────────────────────────────────────────────
//   Future<bool> markNoShow(String appointmentId) async {
//     try {
//       isActing.value = true;
//       final result = await _service.markNoShow(appointmentId);
//       if (result.success) {
//         _patchLocal(result.data);
//         await fetchMyAppointments();
//         _showSuccess('Marked as no-show');
//         return true;
//       }
//       _showError('Could not mark as no-show');
//       return false;
//     } catch (e) {
//       _showError(_clean(e));
//       return false;
//     } finally {
//       isActing.value = false;
//     }
//   }

//   // ── Fetch records ──────────────────────────────────────────
//   Future<void> fetchRecords(String appointmentId) async {
//     try {
//       isLoadingRecords.value = true;
//       records.clear();
//       final result = await _service.getRecords(appointmentId);
//       if (result.success) {
//         records.assignAll(result.data);
//       }
//     } catch (e) {
//       _showError(_clean(e));
//     } finally {
//       isLoadingRecords.value = false;
//     }
//   }

//   // ── Create record ──────────────────────────────────────────
//   Future<bool> createRecord(String appointmentId) async {
//     if (!_validateRecordForm()) return false;
//     try {
//       isSavingRecord.value = true;
//       final result = await _service.createRecord(
//         appointmentId: appointmentId,
//         notes: notesCtrl.text.trim(),
//         therapyPlan: therapyPlanCtrl.text.trim(),
//         medication: {
//           'name': medicationNameCtrl.text.trim().isEmpty
//               ? 'None'
//               : medicationNameCtrl.text.trim(),
//           'dosage': medicationDosageCtrl.text.trim().isEmpty
//               ? null
//               : medicationDosageCtrl.text.trim(),
//         },
//         progressFeedback: progressFeedbackCtrl.text.trim(),
//       );
//       if (result.success) {
//         records.insert(0, result.data);
//         clearRecordForm();
//         _showSuccess('Session record saved successfully!');
//         return true;
//       }
//       _showError('Failed to save record');
//       return false;
//     } catch (e) {
//       _showError(_clean(e));
//       return false;
//     } finally {
//       isSavingRecord.value = false;
//     }
//   }

//   // ── Update record ──────────────────────────────────────────
//   Future<bool> updateRecord(String appointmentId, String recordId) async {
//     if (!_validateRecordForm()) return false;
//     try {
//       isSavingRecord.value = true;
//       final result = await _service.updateRecord(
//         appointmentId: appointmentId,
//         recordId: recordId,
//         notes: notesCtrl.text.trim(),
//         therapyPlan: therapyPlanCtrl.text.trim(),
//         medication: {
//           'name': medicationNameCtrl.text.trim().isEmpty
//               ? 'None'
//               : medicationNameCtrl.text.trim(),
//           'dosage': medicationDosageCtrl.text.trim().isEmpty
//               ? null
//               : medicationDosageCtrl.text.trim(),
//         },
//         progressFeedback: progressFeedbackCtrl.text.trim(),
//       );
//       if (result.success) {
//         final idx = records.indexWhere((r) => r.recordId == recordId);
//         if (idx != -1) {
//           records[idx] = result.data;
//         }
//         clearRecordForm();
//         _showSuccess('Record updated successfully!');
//         return true;
//       }
//       _showError('Failed to update record');
//       return false;
//     } catch (e) {
//       _showError(_clean(e));
//       return false;
//     } finally {
//       isSavingRecord.value = false;
//     }
//   }

//   // ── Private helpers ────────────────────────────────────────
//   void _patchLocal(MyAppointmentItem updated) {
//     final idx = appointments
//         .indexWhere((a) => a.appointmentId == updated.appointmentId);
//     if (idx != -1) {
//       appointments[idx] = updated;
//     }
//     if (selectedAppointment.value?.appointmentId == updated.appointmentId) {
//       selectedAppointment.value = updated;
//     }
//   }

//   bool _validateRecordForm() {
//     if (notesCtrl.text.trim().isEmpty) {
//       _showError('Please enter session notes');
//       return false;
//     }
//     if (therapyPlanCtrl.text.trim().isEmpty) {
//       _showError('Please enter a therapy plan');
//       return false;
//     }
//     if (progressFeedbackCtrl.text.trim().isEmpty) {
//       _showError('Please enter progress feedback');
//       return false;
//     }
//     return true;
//   }

//   String _clean(dynamic e) =>
//       e.toString().replaceAll('Exception: ', '').trim();

//   void _showSuccess(String msg) {
//     Get.snackbar(
//       '✅ Success',
//       msg,
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: AppColors.successColor,
//       colorText: AppColors.whiteColor,
//       margin: const EdgeInsets.all(16),
//       borderRadius: 14,
//       duration: const Duration(seconds: 3),
//       icon: const Icon(Icons.check_circle_rounded,
//           color: Colors.white, size: 20),
//     );
//   }

//   void _showError(String msg) {
//     Get.snackbar(
//       '❌ Error',
//       msg,
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: AppColors.errorColor,
//       colorText: AppColors.whiteColor,
//       margin: const EdgeInsets.all(16),
//       borderRadius: 14,
//       duration: const Duration(seconds: 4),
//       icon: const Icon(Icons.error_rounded, color: Colors.white, size: 20),
//     );
//   }
// }


// // lib/controllers/my_appointment_controller.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/models/my_appointment_model.dart';
// import 'package:speechspectrum/services/my_appointment_service.dart';

// class MyAppointmentController extends GetxController {
//   final MyAppointmentService _service = MyAppointmentService();

//   // ── Observable state ───────────────────────────────────────
//   final isLoading = false.obs;
//   final isLoadingDetail = false.obs;
//   final isLoadingRecords = false.obs;
//   final isActing = false.obs;
//   final isSavingRecord = false.obs;

//   final appointments = <MyAppointmentItem>[].obs;
//   final selectedAppointment = Rxn<MyAppointmentItem>();
//   final records = <AppointmentRecordItem>[].obs;

//   /// Set before Get.back() so MyAppointmentsScreen can jump to the right tab.
//   /// Tab indices: 0=All 1=Scheduled 2=Confirmed 3=Completed 4=Cancelled 5=NoShow
//   final pendingTabIndex = RxnInt();

//   // ── Record form text controllers ───────────────────────────
//   final notesCtrl = TextEditingController();
//   final therapyPlanCtrl = TextEditingController();
//   final medicationNameCtrl = TextEditingController();
//   final medicationDosageCtrl = TextEditingController();
//   final progressFeedbackCtrl = TextEditingController();

//   @override
//   void onClose() {
//     notesCtrl.dispose();
//     therapyPlanCtrl.dispose();
//     medicationNameCtrl.dispose();
//     medicationDosageCtrl.dispose();
//     progressFeedbackCtrl.dispose();
//     super.onClose();
//   }

//   void clearRecordForm() {
//     notesCtrl.clear();
//     therapyPlanCtrl.clear();
//     medicationNameCtrl.clear();
//     medicationDosageCtrl.clear();
//     progressFeedbackCtrl.clear();
//   }

//   void populateRecordForm(AppointmentRecordItem record) {
//     notesCtrl.text = record.notes;
//     therapyPlanCtrl.text = record.therapyPlan;
//     progressFeedbackCtrl.text = record.progressFeedback;
//     if (record.medication != null) {
//       medicationNameCtrl.text = record.medication!['name']?.toString() ?? '';
//       medicationDosageCtrl.text =
//           record.medication!['dosage']?.toString() ?? '';
//     } else {
//       medicationNameCtrl.clear();
//       medicationDosageCtrl.clear();
//     }
//   }

//   // ── Filtered lists ─────────────────────────────────────────
//   List<MyAppointmentItem> get allAppointments => appointments.toList();
//   List<MyAppointmentItem> get scheduledList =>
//       appointments.where((a) => a.isScheduled).toList();
//   List<MyAppointmentItem> get confirmedList =>
//       appointments.where((a) => a.isConfirmed).toList();
//   List<MyAppointmentItem> get completedList =>
//       appointments.where((a) => a.isCompleted).toList();
//   List<MyAppointmentItem> get cancelledList =>
//       appointments.where((a) => a.isCancelled).toList();
//   List<MyAppointmentItem> get noShowList =>
//       appointments.where((a) => a.isNoShow).toList();

//   // ── Fetch all appointments ─────────────────────────────────
//   Future<void> fetchMyAppointments() async {
//     try {
//       isLoading.value = true;
//       final result = await _service.getMyAppointments();
//       if (result.success) {
//         appointments.assignAll(result.data);
//       } else {
//         _showError('Failed to load appointments');
//       }
//     } catch (e) {
//       _showError(_clean(e));
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // ── Fetch single appointment detail ───────────────────────
//   Future<void> fetchAppointmentDetail(String appointmentId) async {
//     try {
//       isLoadingDetail.value = true;
//       selectedAppointment.value = null;
//       final result = await _service.getAppointmentById(appointmentId);
//       if (result.success) {
//         selectedAppointment.value = result.data;
//       }
//     } catch (e) {
//       _showError(_clean(e));
//     } finally {
//       isLoadingDetail.value = false;
//     }
//   }

//   // ── Confirm ────────────────────────────────────────────────
//   Future<bool> confirmAppointment(String appointmentId) async {
//     try {
//       isActing.value = true;
//       final result = await _service.confirmAppointment(appointmentId);
//       if (result.success) {
//         _patchLocal(result.data);
//         await fetchMyAppointments();
//         _showSuccess('Appointment confirmed successfully!');
//         return true;
//       }
//       _showError('Could not confirm appointment');
//       return false;
//     } catch (e) {
//       _showError(_clean(e));
//       return false;
//     } finally {
//       isActing.value = false;
//     }
//   }

//   // ── Complete ───────────────────────────────────────────────
//   Future<bool> completeAppointment(String appointmentId) async {
//     try {
//       isActing.value = true;
//       final result = await _service.completeAppointment(appointmentId);
//       if (result.success) {
//         _patchLocal(result.data);
//         await fetchMyAppointments();
//         _showSuccess('Appointment marked as completed!');
//         return true;
//       }
//       _showError('Could not complete appointment');
//       return false;
//     } catch (e) {
//       _showError(_clean(e));
//       return false;
//     } finally {
//       isActing.value = false;
//     }
//   }

//   // ── Cancel ─────────────────────────────────────────────────
//   Future<bool> cancelAppointment(String appointmentId, String reason) async {
//     try {
//       isActing.value = true;
//       final result = await _service.cancelAppointment(appointmentId, reason);
//       if (result.success) {
//         _patchLocal(result.data);
//         await fetchMyAppointments();
//         _showSuccess('Appointment cancelled');
//         return true;
//       }
//       _showError('Could not cancel appointment');
//       return false;
//     } catch (e) {
//       _showError(_clean(e));
//       return false;
//     } finally {
//       isActing.value = false;
//     }
//   }

//   // ── No Show ────────────────────────────────────────────────
//   Future<bool> markNoShow(String appointmentId) async {
//     try {
//       isActing.value = true;
//       final result = await _service.markNoShow(appointmentId);
//       if (result.success) {
//         _patchLocal(result.data);
//         await fetchMyAppointments();
//         _showSuccess('Marked as no-show');
//         return true;
//       }
//       _showError('Could not mark as no-show');
//       return false;
//     } catch (e) {
//       _showError(_clean(e));
//       return false;
//     } finally {
//       isActing.value = false;
//     }
//   }

//   // ── Fetch records ──────────────────────────────────────────
//   Future<void> fetchRecords(String appointmentId) async {
//     try {
//       isLoadingRecords.value = true;
//       records.clear();
//       final result = await _service.getRecords(appointmentId);
//       if (result.success) {
//         records.assignAll(result.data);
//       }
//     } catch (e) {
//       _showError(_clean(e));
//     } finally {
//       isLoadingRecords.value = false;
//     }
//   }

//   // ── Create record ──────────────────────────────────────────
//   Future<bool> createRecord(String appointmentId) async {
//     if (!_validateRecordForm()) return false;
//     try {
//       isSavingRecord.value = true;
//       final result = await _service.createRecord(
//         appointmentId: appointmentId,
//         notes: notesCtrl.text.trim(),
//         therapyPlan: therapyPlanCtrl.text.trim(),
//         medication: {
//           'name': medicationNameCtrl.text.trim().isEmpty
//               ? 'None'
//               : medicationNameCtrl.text.trim(),
//           'dosage': medicationDosageCtrl.text.trim().isEmpty
//               ? null
//               : medicationDosageCtrl.text.trim(),
//         },
//         progressFeedback: progressFeedbackCtrl.text.trim(),
//       );
//       if (result.success) {
//         records.insert(0, result.data);
//         clearRecordForm();
//         _showSuccess('Session record saved successfully!');
//         return true;
//       }
//       _showError('Failed to save record');
//       return false;
//     } catch (e) {
//       _showError(_clean(e));
//       return false;
//     } finally {
//       isSavingRecord.value = false;
//     }
//   }

//   // ── Update record ──────────────────────────────────────────
//   Future<bool> updateRecord(String appointmentId, String recordId) async {
//     if (!_validateRecordForm()) return false;
//     try {
//       isSavingRecord.value = true;
//       final result = await _service.updateRecord(
//         appointmentId: appointmentId,
//         recordId: recordId,
//         notes: notesCtrl.text.trim(),
//         therapyPlan: therapyPlanCtrl.text.trim(),
//         medication: {
//           'name': medicationNameCtrl.text.trim().isEmpty
//               ? 'None'
//               : medicationNameCtrl.text.trim(),
//           'dosage': medicationDosageCtrl.text.trim().isEmpty
//               ? null
//               : medicationDosageCtrl.text.trim(),
//         },
//         progressFeedback: progressFeedbackCtrl.text.trim(),
//       );
//       if (result.success) {
//         final idx = records.indexWhere((r) => r.recordId == recordId);
//         if (idx != -1) {
//           records[idx] = result.data;
//         }
//         clearRecordForm();
//         _showSuccess('Record updated successfully!');
//         return true;
//       }
//       _showError('Failed to update record');
//       return false;
//     } catch (e) {
//       _showError(_clean(e));
//       return false;
//     } finally {
//       isSavingRecord.value = false;
//     }
//   }

//   // ── Private helpers ────────────────────────────────────────
//   void _patchLocal(MyAppointmentItem updated) {
//     final idx = appointments
//         .indexWhere((a) => a.appointmentId == updated.appointmentId);
//     if (idx != -1) {
//       appointments[idx] = updated;
//     }
//     if (selectedAppointment.value?.appointmentId == updated.appointmentId) {
//       selectedAppointment.value = updated;
//     }
//   }

//   bool _validateRecordForm() {
//     if (notesCtrl.text.trim().isEmpty) {
//       _showError('Please enter session notes');
//       return false;
//     }
//     if (therapyPlanCtrl.text.trim().isEmpty) {
//       _showError('Please enter a therapy plan');
//       return false;
//     }
//     if (progressFeedbackCtrl.text.trim().isEmpty) {
//       _showError('Please enter progress feedback');
//       return false;
//     }
//     return true;
//   }

//   String _clean(dynamic e) =>
//       e.toString().replaceAll('Exception: ', '').trim();

//   void _showSuccess(String msg) {
//     Get.snackbar(
//       '✅ Success',
//       msg,
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: AppColors.successColor,
//       colorText: AppColors.whiteColor,
//       margin: const EdgeInsets.all(16),
//       borderRadius: 14,
//       duration: const Duration(seconds: 3),
//       icon: const Icon(Icons.check_circle_rounded,
//           color: Colors.white, size: 20),
//     );
//   }

//   void _showError(String msg) {
//     Get.snackbar(
//       '❌ Error',
//       msg,
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: AppColors.errorColor,
//       colorText: AppColors.whiteColor,
//       margin: const EdgeInsets.all(16),
//       borderRadius: 14,
//       duration: const Duration(seconds: 4),
//       icon: const Icon(Icons.error_rounded, color: Colors.white, size: 20),
//     );
//   }
// }



// // lib/controllers/my_appointment_controller.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/models/my_appointment_model.dart';
// import 'package:speechspectrum/services/my_appointment_service.dart';

// class MyAppointmentController extends GetxController {
//   final MyAppointmentService _service = MyAppointmentService();

//   // ── Observable state ───────────────────────────────────────
//   final isLoading = false.obs;
//   final isLoadingDetail = false.obs;
//   final isLoadingRecords = false.obs;
//   final isActing = false.obs;
//   final isSavingRecord = false.obs;

//   final appointments = <MyAppointmentItem>[].obs;
//   final selectedAppointment = Rxn<MyAppointmentItem>();
//   final records = <AppointmentRecordItem>[].obs;

//   /// Set before Get.back() so MyAppointmentsScreen can jump to the right tab.
//   /// Tab indices: 0=All 1=Scheduled 2=Confirmed 3=Completed 4=Cancelled 5=NoShow
//   final pendingTabIndex = RxnInt();

//   // ── Record form text controllers ───────────────────────────
//   final notesCtrl = TextEditingController();
//   final therapyPlanCtrl = TextEditingController();
//   final medicationNameCtrl = TextEditingController();
//   final medicationDosageCtrl = TextEditingController();
//   final progressFeedbackCtrl = TextEditingController();

//   @override
//   void onClose() {
//     notesCtrl.dispose();
//     therapyPlanCtrl.dispose();
//     medicationNameCtrl.dispose();
//     medicationDosageCtrl.dispose();
//     progressFeedbackCtrl.dispose();
//     super.onClose();
//   }

//   void clearRecordForm() {
//     notesCtrl.clear();
//     therapyPlanCtrl.clear();
//     medicationNameCtrl.clear();
//     medicationDosageCtrl.clear();
//     progressFeedbackCtrl.clear();
//   }

//   void populateRecordForm(AppointmentRecordItem record) {
//     notesCtrl.text = record.notes;
//     therapyPlanCtrl.text = record.therapyPlan;
//     progressFeedbackCtrl.text = record.progressFeedback;
//     if (record.medication != null) {
//       medicationNameCtrl.text = record.medication!['name']?.toString() ?? '';
//       medicationDosageCtrl.text =
//           record.medication!['dosage']?.toString() ?? '';
//     } else {
//       medicationNameCtrl.clear();
//       medicationDosageCtrl.clear();
//     }
//   }

//   // ── Filtered lists ─────────────────────────────────────────
//   List<MyAppointmentItem> get allAppointments => appointments.toList();
//   List<MyAppointmentItem> get scheduledList =>
//       appointments.where((a) => a.isScheduled).toList();
//   List<MyAppointmentItem> get confirmedList =>
//       appointments.where((a) => a.isConfirmed).toList();
//   List<MyAppointmentItem> get completedList =>
//       appointments.where((a) => a.isCompleted).toList();
//   List<MyAppointmentItem> get cancelledList =>
//       appointments.where((a) => a.isCancelled).toList();
//   List<MyAppointmentItem> get noShowList =>
//       appointments.where((a) => a.isNoShow).toList();

//   List<MyAppointmentItem> get expiredList => null;

//   // ── Fetch all appointments ─────────────────────────────────
//   Future<void> fetchMyAppointments() async {
//     try {
//       isLoading.value = true;
//       final result = await _service.getMyAppointments();
//       if (result.success) {
//         appointments.assignAll(result.data);
//       } else {
//         _showError('Failed to load appointments');
//       }
//     } catch (e) {
//       _showError(_clean(e));
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // ── Fetch single appointment detail ───────────────────────
//   Future<void> fetchAppointmentDetail(String appointmentId) async {
//     try {
//       isLoadingDetail.value = true;
//       selectedAppointment.value = null;
//       final result = await _service.getAppointmentById(appointmentId);
//       if (result.success) {
//         selectedAppointment.value = result.data;
//       }
//     } catch (e) {
//       _showError(_clean(e));
//     } finally {
//       isLoadingDetail.value = false;
//     }
//   }

//   // ── Confirm ────────────────────────────────────────────────
//   Future<bool> confirmAppointment(String appointmentId) async {
//     try {
//       isActing.value = true;
//       final result = await _service.confirmAppointment(appointmentId);
//       if (result.success) {
//         _patchLocal(result.data);
//         await fetchMyAppointments();
//         _showSuccess('Appointment confirmed successfully!');
//         return true;
//       }
//       _showError('Could not confirm appointment');
//       return false;
//     } catch (e) {
//       _showError(_clean(e));
//       return false;
//     } finally {
//       isActing.value = false;
//     }
//   }

//   // ── Complete ───────────────────────────────────────────────
//   Future<bool> completeAppointment(String appointmentId) async {
//     try {
//       isActing.value = true;
//       final result = await _service.completeAppointment(appointmentId);
//       if (result.success) {
//         _patchLocal(result.data);
//         await fetchMyAppointments();
//         _showSuccess('Appointment marked as completed!');
//         return true;
//       }
//       _showError('Could not complete appointment');
//       return false;
//     } catch (e) {
//       _showError(_clean(e));
//       return false;
//     } finally {
//       isActing.value = false;
//     }
//   }

//   // ── Cancel ─────────────────────────────────────────────────
//   Future<bool> cancelAppointment(String appointmentId, String reason) async {
//     try {
//       isActing.value = true;
//       final result = await _service.cancelAppointment(appointmentId, reason);
//       if (result.success) {
//         _patchLocal(result.data);
//         await fetchMyAppointments();
//         _showSuccess('Appointment cancelled');
//         return true;
//       }
//       _showError('Could not cancel appointment');
//       return false;
//     } catch (e) {
//       _showError(_clean(e));
//       return false;
//     } finally {
//       isActing.value = false;
//     }
//   }

//   // ── No Show ────────────────────────────────────────────────
//   Future<bool> markNoShow(String appointmentId) async {
//     try {
//       isActing.value = true;
//       final result = await _service.markNoShow(appointmentId);
//       if (result.success) {
//         _patchLocal(result.data);
//         await fetchMyAppointments();
//         _showSuccess('Marked as no-show');
//         return true;
//       }
//       _showError('Could not mark as no-show');
//       return false;
//     } catch (e) {
//       _showError(_clean(e));
//       return false;
//     } finally {
//       isActing.value = false;
//     }
//   }

//   // ── Fetch records ──────────────────────────────────────────
//   Future<void> fetchRecords(String appointmentId) async {
//     try {
//       isLoadingRecords.value = true;
//       records.clear();
//       final result = await _service.getRecords(appointmentId);
//       if (result.success) {
//         records.assignAll(result.data);
//       }
//     } catch (e) {
//       _showError(_clean(e));
//     } finally {
//       isLoadingRecords.value = false;
//     }
//   }

//   // ── Create record ──────────────────────────────────────────
//   Future<bool> createRecord(String appointmentId) async {
//     if (!_validateRecordForm()) return false;
//     try {
//       isSavingRecord.value = true;
//       final result = await _service.createRecord(
//         appointmentId: appointmentId,
//         notes: notesCtrl.text.trim(),
//         therapyPlan: therapyPlanCtrl.text.trim(),
//         medication: {
//           'name': medicationNameCtrl.text.trim().isEmpty
//               ? 'None'
//               : medicationNameCtrl.text.trim(),
//           'dosage': medicationDosageCtrl.text.trim().isEmpty
//               ? null
//               : medicationDosageCtrl.text.trim(),
//         },
//         progressFeedback: progressFeedbackCtrl.text.trim(),
//       );
//       if (result.success) {
//         records.insert(0, result.data);
//         clearRecordForm();
//         _showSuccess('Session record saved successfully!');
//         return true;
//       }
//       _showError('Failed to save record');
//       return false;
//     } catch (e) {
//       _showError(_clean(e));
//       return false;
//     } finally {
//       isSavingRecord.value = false;
//     }
//   }

//   // ── Update record ──────────────────────────────────────────
//   Future<bool> updateRecord(String appointmentId, String recordId) async {
//     if (!_validateRecordForm()) return false;
//     try {
//       isSavingRecord.value = true;
//       final result = await _service.updateRecord(
//         appointmentId: appointmentId,
//         recordId: recordId,
//         notes: notesCtrl.text.trim(),
//         therapyPlan: therapyPlanCtrl.text.trim(),
//         medication: {
//           'name': medicationNameCtrl.text.trim().isEmpty
//               ? 'None'
//               : medicationNameCtrl.text.trim(),
//           'dosage': medicationDosageCtrl.text.trim().isEmpty
//               ? null
//               : medicationDosageCtrl.text.trim(),
//         },
//         progressFeedback: progressFeedbackCtrl.text.trim(),
//       );
//       if (result.success) {
//         final idx = records.indexWhere((r) => r.recordId == recordId);
//         if (idx != -1) {
//           records[idx] = result.data;
//         }
//         clearRecordForm();
//         _showSuccess('Record updated successfully!');
//         return true;
//       }
//       _showError('Failed to update record');
//       return false;
//     } catch (e) {
//       _showError(_clean(e));
//       return false;
//     } finally {
//       isSavingRecord.value = false;
//     }
//   }

//   // ── Private helpers ────────────────────────────────────────
//   void _patchLocal(MyAppointmentItem updated) {
//     final idx = appointments
//         .indexWhere((a) => a.appointmentId == updated.appointmentId);
//     if (idx != -1) {
//       appointments[idx] = updated;
//     }
//     if (selectedAppointment.value?.appointmentId == updated.appointmentId) {
//       selectedAppointment.value = updated;
//     }
//   }

//   bool _validateRecordForm() {
//     if (notesCtrl.text.trim().isEmpty) {
//       _showError('Please enter session notes');
//       return false;
//     }
//     if (therapyPlanCtrl.text.trim().isEmpty) {
//       _showError('Please enter a therapy plan');
//       return false;
//     }
//     if (progressFeedbackCtrl.text.trim().isEmpty) {
//       _showError('Please enter progress feedback');
//       return false;
//     }
//     return true;
//   }

//   String _clean(dynamic e) =>
//       e.toString().replaceAll('Exception: ', '').trim();

//   void _showSuccess(String msg) {
//     Get.snackbar(
//       '✅ Success',
//       msg,
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: AppColors.successColor,
//       colorText: AppColors.whiteColor,
//       margin: const EdgeInsets.all(16),
//       borderRadius: 14,
//       duration: const Duration(seconds: 3),
//       icon: const Icon(Icons.check_circle_rounded,
//           color: Colors.white, size: 20),
//     );
//   }

//   void _showError(String msg) {
//     Get.snackbar(
//       '❌ Error',
//       msg,
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: AppColors.errorColor,
//       colorText: AppColors.whiteColor,
//       margin: const EdgeInsets.all(16),
//       borderRadius: 14,
//       duration: const Duration(seconds: 4),
//       icon: const Icon(Icons.error_rounded, color: Colors.white, size: 20),
//     );
//   }
// }


// lib/controllers/my_appointment_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/models/my_appointment_model.dart';
import 'package:speechspectrum/services/my_appointment_service.dart';

class MyAppointmentController extends GetxController {
  final MyAppointmentService _service = MyAppointmentService();

  // ── Observable state ───────────────────────────────────────
  final isLoading = false.obs;
  final isLoadingDetail = false.obs;
  final isLoadingRecords = false.obs;
  final isActing = false.obs;
  final isSavingRecord = false.obs;

  final appointments = <MyAppointmentItem>[].obs;
  final selectedAppointment = Rxn<MyAppointmentItem>();
  final records = <AppointmentRecordItem>[].obs;

  /// Set before Get.back() so MyAppointmentsScreen can jump to the right tab.
  /// Tab indices: 0=All 1=Requested 2=Confirmed 3=Completed 4=Cancelled 5=NoShow 6=Expired
  final pendingTabIndex = RxnInt();

  // ── Record form text controllers ───────────────────────────
  final notesCtrl = TextEditingController();
  final therapyPlanCtrl = TextEditingController();
  final medicationNameCtrl = TextEditingController();
  final medicationDosageCtrl = TextEditingController();
  final progressFeedbackCtrl = TextEditingController();

  @override
  void onClose() {
    notesCtrl.dispose();
    therapyPlanCtrl.dispose();
    medicationNameCtrl.dispose();
    medicationDosageCtrl.dispose();
    progressFeedbackCtrl.dispose();
    super.onClose();
  }

  void clearRecordForm() {
    notesCtrl.clear();
    therapyPlanCtrl.clear();
    medicationNameCtrl.clear();
    medicationDosageCtrl.clear();
    progressFeedbackCtrl.clear();
  }

  void populateRecordForm(AppointmentRecordItem record) {
    notesCtrl.text = record.notes;
    therapyPlanCtrl.text = record.therapyPlan;
    progressFeedbackCtrl.text = record.progressFeedback;
    if (record.medication != null) {
      medicationNameCtrl.text = record.medication!['name']?.toString() ?? '';
      medicationDosageCtrl.text =
          record.medication!['dosage']?.toString() ?? '';
    } else {
      medicationNameCtrl.clear();
      medicationDosageCtrl.clear();
    }
  }

  // ── Filtered lists ─────────────────────────────────────────

  /// All appointments unfiltered
  List<MyAppointmentItem> get allAppointments => appointments.toList();

  /// Requested = scheduled status AND date is in the future (not expired)
  /// Sorted soonest first
  List<MyAppointmentItem> get scheduledList => appointments
      .where((a) => a.isScheduled && !a.isExpired)
      .toList()
    ..sort((a, b) => _parseDate(a.scheduledAt).compareTo(_parseDate(b.scheduledAt)));

  /// Confirmed = confirmed status AND date is in the future (not expired)
  /// Sorted soonest first
  List<MyAppointmentItem> get confirmedList => appointments
      .where((a) => a.isConfirmed && !a.isExpired)
      .toList()
    ..sort((a, b) => _parseDate(a.scheduledAt).compareTo(_parseDate(b.scheduledAt)));

  /// Expired = scheduled or confirmed but date has already passed
  /// Sorted most recent first
  List<MyAppointmentItem> get expiredList => appointments
      .where((a) => (a.isScheduled || a.isConfirmed) && a.isExpired)
      .toList()
    ..sort((a, b) => _parseDate(b.scheduledAt).compareTo(_parseDate(a.scheduledAt)));

  /// Completed — no date filter needed
  List<MyAppointmentItem> get completedList =>
      appointments.where((a) => a.isCompleted).toList();

  /// Cancelled — no date filter needed
  List<MyAppointmentItem> get cancelledList =>
      appointments.where((a) => a.isCancelled).toList();

  /// No Show — no date filter needed
  List<MyAppointmentItem> get noShowList =>
      appointments.where((a) => a.isNoShow).toList();

  // ── Date parse helper ──────────────────────────────────────
  DateTime _parseDate(String s) {
    try {
      return DateTime.parse(s);
    } catch (_) {
      return DateTime(2000);
    }
  }

  // ── Fetch all appointments ─────────────────────────────────
  Future<void> fetchMyAppointments() async {
    try {
      isLoading.value = true;
      final result = await _service.getMyAppointments();
      if (result.success) {
        appointments.assignAll(result.data);
      } else {
        _showError('Failed to load appointments');
      }
    } catch (e) {
      _showError(_clean(e));
    } finally {
      isLoading.value = false;
    }
  }

  // ── Fetch single appointment detail ───────────────────────
  Future<void> fetchAppointmentDetail(String appointmentId) async {
    try {
      isLoadingDetail.value = true;
      selectedAppointment.value = null;
      final result = await _service.getAppointmentById(appointmentId);
      if (result.success) {
        selectedAppointment.value = result.data;
      }
    } catch (e) {
      _showError(_clean(e));
    } finally {
      isLoadingDetail.value = false;
    }
  }

  // ── Confirm ────────────────────────────────────────────────
  Future<bool> confirmAppointment(String appointmentId) async {
    try {
      isActing.value = true;
      final result = await _service.confirmAppointment(appointmentId);
      if (result.success) {
        _patchLocal(result.data);
        await fetchMyAppointments();
        _showSuccess('Appointment confirmed successfully!');
        return true;
      }
      _showError('Could not confirm appointment');
      return false;
    } catch (e) {
      _showError(_clean(e));
      return false;
    } finally {
      isActing.value = false;
    }
  }

  // ── Complete ───────────────────────────────────────────────
  Future<bool> completeAppointment(String appointmentId) async {
    try {
      isActing.value = true;
      final result = await _service.completeAppointment(appointmentId);
      if (result.success) {
        _patchLocal(result.data);
        await fetchMyAppointments();
        _showSuccess('Appointment marked as completed!');
        return true;
      }
      _showError('Could not complete appointment');
      return false;
    } catch (e) {
      _showError(_clean(e));
      return false;
    } finally {
      isActing.value = false;
    }
  }

  // ── Cancel ─────────────────────────────────────────────────
  Future<bool> cancelAppointment(String appointmentId, String reason) async {
    try {
      isActing.value = true;
      final result = await _service.cancelAppointment(appointmentId, reason);
      if (result.success) {
        _patchLocal(result.data);
        await fetchMyAppointments();
        _showSuccess('Appointment cancelled');
        return true;
      }
      _showError('Could not cancel appointment');
      return false;
    } catch (e) {
      _showError(_clean(e));
      return false;
    } finally {
      isActing.value = false;
    }
  }

  // ── No Show ────────────────────────────────────────────────
  Future<bool> markNoShow(String appointmentId) async {
    try {
      isActing.value = true;
      final result = await _service.markNoShow(appointmentId);
      if (result.success) {
        _patchLocal(result.data);
        await fetchMyAppointments();
        _showSuccess('Marked as no-show');
        return true;
      }
      _showError('Could not mark as no-show');
      return false;
    } catch (e) {
      _showError(_clean(e));
      return false;
    } finally {
      isActing.value = false;
    }
  }

  // ── Fetch records ──────────────────────────────────────────
  Future<void> fetchRecords(String appointmentId) async {
    try {
      isLoadingRecords.value = true;
      records.clear();
      final result = await _service.getRecords(appointmentId);
      if (result.success) {
        records.assignAll(result.data);
      }
    } catch (e) {
      _showError(_clean(e));
    } finally {
      isLoadingRecords.value = false;
    }
  }

  // ── Create record ──────────────────────────────────────────
  Future<bool> createRecord(String appointmentId) async {
    if (!_validateRecordForm()) return false;
    try {
      isSavingRecord.value = true;
      final result = await _service.createRecord(
        appointmentId: appointmentId,
        notes: notesCtrl.text.trim(),
        therapyPlan: therapyPlanCtrl.text.trim(),
        medication: {
          'name': medicationNameCtrl.text.trim().isEmpty
              ? 'None'
              : medicationNameCtrl.text.trim(),
          'dosage': medicationDosageCtrl.text.trim().isEmpty
              ? null
              : medicationDosageCtrl.text.trim(),
        },
        progressFeedback: progressFeedbackCtrl.text.trim(),
      );
      if (result.success) {
        records.insert(0, result.data);
        clearRecordForm();
        _showSuccess('Session record saved successfully!');
        return true;
      }
      _showError('Failed to save record');
      return false;
    } catch (e) {
      _showError(_clean(e));
      return false;
    } finally {
      isSavingRecord.value = false;
    }
  }

  // ── Update record ──────────────────────────────────────────
  Future<bool> updateRecord(String appointmentId, String recordId) async {
    if (!_validateRecordForm()) return false;
    try {
      isSavingRecord.value = true;
      final result = await _service.updateRecord(
        appointmentId: appointmentId,
        recordId: recordId,
        notes: notesCtrl.text.trim(),
        therapyPlan: therapyPlanCtrl.text.trim(),
        medication: {
          'name': medicationNameCtrl.text.trim().isEmpty
              ? 'None'
              : medicationNameCtrl.text.trim(),
          'dosage': medicationDosageCtrl.text.trim().isEmpty
              ? null
              : medicationDosageCtrl.text.trim(),
        },
        progressFeedback: progressFeedbackCtrl.text.trim(),
      );
      if (result.success) {
        final idx = records.indexWhere((r) => r.recordId == recordId);
        if (idx != -1) {
          records[idx] = result.data;
        }
        clearRecordForm();
        _showSuccess('Record updated successfully!');
        return true;
      }
      _showError('Failed to update record');
      return false;
    } catch (e) {
      _showError(_clean(e));
      return false;
    } finally {
      isSavingRecord.value = false;
    }
  }

  // ── Private helpers ────────────────────────────────────────
  void _patchLocal(MyAppointmentItem updated) {
    final idx = appointments
        .indexWhere((a) => a.appointmentId == updated.appointmentId);
    if (idx != -1) {
      appointments[idx] = updated;
    }
    if (selectedAppointment.value?.appointmentId == updated.appointmentId) {
      selectedAppointment.value = updated;
    }
  }

  bool _validateRecordForm() {
    if (notesCtrl.text.trim().isEmpty) {
      _showError('Please enter session notes');
      return false;
    }
    if (therapyPlanCtrl.text.trim().isEmpty) {
      _showError('Please enter a therapy plan');
      return false;
    }
    if (progressFeedbackCtrl.text.trim().isEmpty) {
      _showError('Please enter progress feedback');
      return false;
    }
    return true;
  }

  String _clean(dynamic e) =>
      e.toString().replaceAll('Exception: ', '').trim();

  void _showSuccess(String msg) {
    Get.snackbar(
      '✅ Success',
      msg,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.successColor,
      colorText: AppColors.whiteColor,
      margin: const EdgeInsets.all(16),
      borderRadius: 14,
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.check_circle_rounded,
          color: Colors.white, size: 20),
    );
  }

  void _showError(String msg) {
    Get.snackbar(
      '❌ Error',
      msg,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.errorColor,
      colorText: AppColors.whiteColor,
      margin: const EdgeInsets.all(16),
      borderRadius: 14,
      duration: const Duration(seconds: 4),
      icon: const Icon(Icons.error_rounded, color: Colors.white, size: 20),
    );
  }
}