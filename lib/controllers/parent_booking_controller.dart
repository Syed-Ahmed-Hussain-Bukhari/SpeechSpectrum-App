// // lib/controllers/parent_booking_controller.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/models/my_appointment_model.dart';
// import 'package:speechspectrum/models/parent_booking_model.dart';
// import 'package:speechspectrum/services/parent_booking_service.dart';

// class ParentBookingController extends GetxController {
//   final ParentBookingService _service = ParentBookingService();

//   // ── State ──────────────────────────────────────────────────
//   var isLoadingSlots = false.obs;
//   var isBooking = false.obs;
//   var isLoadingAppointments = false.obs;
//   var isLoadingDetail = false.obs;
//   var isLoadingRecords = false.obs;

//   var expertSlots = <ExpertSlotItem>[].obs;
//   var myAppointments = <MyAppointmentItem>[].obs;
//   var selectedAppointment = Rxn<MyAppointmentItem>();
//   var appointmentRecords = <AppointmentRecordItem>[].obs;

//   // Booking form state
//   var selectedSlot = Rxn<ExpertSlotItem>();
//   var selectedMode = 'online'.obs;

//   // ── Filtered slots by day ──────────────────────────────────
//   Map<String, List<ExpertSlotItem>> get slotsByDay {
//     final map = <String, List<ExpertSlotItem>>{};
//     for (final slot in expertSlots) {
//       final day = slot.fullDayName;
//       map.putIfAbsent(day, () => []).add(slot);
//     }
//     return map;
//   }

//   List<ExpertSlotItem> get availableSlots =>
//       expertSlots.where((s) => s.isAvailable).toList();

//   // ── Appointment filters ────────────────────────────────────
//   List<MyAppointmentItem> get scheduledList =>
//       myAppointments.where((a) => a.isScheduled).toList();

//   List<MyAppointmentItem> get confirmedList =>
//       myAppointments.where((a) => a.isConfirmed).toList();

//   List<MyAppointmentItem> get completedList =>
//       myAppointments.where((a) => a.isCompleted).toList();

//   List<MyAppointmentItem> get cancelledList =>
//       myAppointments.where((a) => a.isCancelled).toList();

//   void selectSlot(ExpertSlotItem slot) {
//     selectedSlot.value = slot;
//     // Auto-set mode based on slot mode
//     if (slot.mode == 'online') {
//       selectedMode.value = 'online';
//     } else if (slot.mode == 'physical') {
//       selectedMode.value = 'physical';
//     } else {
//       selectedMode.value = 'online'; // default for 'both'
//     }
//   }

//   void setMode(String mode) => selectedMode.value = mode;

//   void clearSelection() {
//     selectedSlot.value = null;
//     selectedMode.value = 'online';
//   }

//   // ── API calls ──────────────────────────────────────────────

//   Future<void> fetchExpertSlots(String expertId) async {
//     try {
//       isLoadingSlots.value = true;
//       expertSlots.clear();
//       final response = await _service.getExpertSlots(expertId);
//       if (response.success) {
//         expertSlots.value = response.data;
//       } else {
//         _showError('Failed to fetch expert availability');
//       }
//     } catch (e) {
//       _showError(e.toString().replaceAll('Exception: ', ''));
//     } finally {
//       isLoadingSlots.value = false;
//     }
//   }

//   Future<bool> bookAppointment({
//     required String childId,
//   }) async {
//     final slot = selectedSlot.value;
//     if (slot == null) {
//       _showError('Please select a slot first');
//       return false;
//     }
//     try {
//       isBooking.value = true;
//       final response = await _service.bookAppointment(
//         slotId: slot.slotId,
//         childId: childId,
//         bookedMode: selectedMode.value,
//       );
//       if (response.success) {
//         _showSuccess('Appointment booked successfully!');
//         await fetchMyAppointments();
//         clearSelection();
//         return true;
//       } else {
//         _showError(response.message ?? 'Failed to book appointment');
//         return false;
//       }
//     } catch (e) {
//       _showError(e.toString().replaceAll('Exception: ', ''));
//       return false;
//     } finally {
//       isBooking.value = false;
//     }
//   }

//   Future<void> fetchMyAppointments() async {
//     try {
//       isLoadingAppointments.value = true;
//       final response = await _service.getMyAppointments();
//       if (response.success) {
//         myAppointments.value = response.data;
//       }
//     } catch (e) {
//       _showError(e.toString().replaceAll('Exception: ', ''));
//     } finally {
//       isLoadingAppointments.value = false;
//     }
//   }

//   Future<void> fetchAppointmentDetail(String appointmentId) async {
//     try {
//       isLoadingDetail.value = true;
//       selectedAppointment.value = null;
//       final response = await _service.getAppointmentById(appointmentId);
//       if (response.success) {
//         selectedAppointment.value = response.data;
//       }
//     } catch (e) {
//       _showError(e.toString().replaceAll('Exception: ', ''));
//     } finally {
//       isLoadingDetail.value = false;
//     }
//   }

//   Future<void> fetchAppointmentRecords(String appointmentId) async {
//     try {
//       isLoadingRecords.value = true;
//       appointmentRecords.clear();
//       final response = await _service.getAppointmentRecords(appointmentId);
//       if (response.success) {
//         appointmentRecords.value = response.data;
//       }
//     } catch (e) {
//       debugPrint('❌ Fetch records: $e');
//     } finally {
//       isLoadingRecords.value = false;
//     }
//   }

//   void _showSuccess(String msg) => Get.snackbar('Success', msg,
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: AppColors.successColor,
//       colorText: AppColors.whiteColor,
//       margin: const EdgeInsets.all(16),
//       borderRadius: 12,
//       duration: const Duration(seconds: 3));

//   void _showError(String msg) => Get.snackbar('Error', msg,
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: AppColors.errorColor,
//       colorText: AppColors.whiteColor,
//       margin: const EdgeInsets.all(16),
//       borderRadius: 12,
//       duration: const Duration(seconds: 4));
// }


// lib/controllers/parent_booking_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/models/my_appointment_model.dart';
import 'package:speechspectrum/models/parent_booking_model.dart';
import 'package:speechspectrum/services/parent_booking_service.dart';

class ParentBookingController extends GetxController {
  final ParentBookingService _service = ParentBookingService();

  // ── State ──────────────────────────────────────────────────
  var isLoadingSlots = false.obs;
  var isBooking = false.obs;
  var isLoadingAppointments = false.obs;
  var isLoadingDetail = false.obs;
  var isLoadingRecords = false.obs;

  var expertSlots = <ExpertSlotItem>[].obs;
  var myAppointments = <MyAppointmentItem>[].obs;
  var selectedAppointment = Rxn<MyAppointmentItem>();
  var appointmentRecords = <AppointmentRecordItem>[].obs;

  // Booking form state
  var selectedSlot = Rxn<ExpertSlotItem>();
  var selectedMode = 'online'.obs;

  // ── Filtered slots by day ──────────────────────────────────
  Map<String, List<ExpertSlotItem>> get slotsByDay {
    final map = <String, List<ExpertSlotItem>>{};
    for (final slot in expertSlots) {
      final day = slot.fullDayName;
      map.putIfAbsent(day, () => []).add(slot);
    }
    return map;
  }

  List<ExpertSlotItem> get availableSlots =>
      expertSlots.where((s) => s.isAvailable).toList();

  // ── Appointment filters ────────────────────────────────────
  List<MyAppointmentItem> get scheduledList =>
      myAppointments.where((a) => a.isScheduled).toList();

  List<MyAppointmentItem> get confirmedList =>
      myAppointments.where((a) => a.isConfirmed).toList();

  List<MyAppointmentItem> get completedList =>
      myAppointments.where((a) => a.isCompleted).toList();

  List<MyAppointmentItem> get cancelledList =>
      myAppointments.where((a) => a.isCancelled).toList();

  List<MyAppointmentItem> get noShowList =>
      myAppointments.where((a) => a.isNoShow).toList();

  void selectSlot(ExpertSlotItem slot) {
    selectedSlot.value = slot;
    if (slot.mode == 'online') {
      selectedMode.value = 'online';
    } else if (slot.mode == 'physical') {
      selectedMode.value = 'physical';
    } else {
      selectedMode.value = 'online';
    }
  }

  void setMode(String mode) => selectedMode.value = mode;

  void clearSelection() {
    selectedSlot.value = null;
    selectedMode.value = 'online';
  }

  // ── API calls ──────────────────────────────────────────────

  Future<void> fetchExpertSlots(String expertId) async {
    try {
      isLoadingSlots.value = true;
      expertSlots.clear();
      final response = await _service.getExpertSlots(expertId);
      if (response.success) {
        expertSlots.value = response.data;
      } else {
        _showError('Failed to fetch expert availability');
      }
    } catch (e) {
      _showError(e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoadingSlots.value = false;
    }
  }

  Future<bool> bookAppointment({
    required String childId,
  }) async {
    final slot = selectedSlot.value;
    if (slot == null) {
      _showError('Please select a slot first');
      return false;
    }
    try {
      isBooking.value = true;
      final response = await _service.bookAppointment(
        slotId: slot.slotId,
        childId: childId,
        bookedMode: selectedMode.value,
      );
      if (response.success) {
        _showSuccess('Appointment booked successfully!');
        await fetchMyAppointments();
        clearSelection();
        return true;
      } else {
        _showError(response.message ?? 'Failed to book appointment');
        return false;
      }
    } catch (e) {
      _showError(e.toString().replaceAll('Exception: ', ''));
      return false;
    } finally {
      isBooking.value = false;
    }
  }

  Future<void> fetchMyAppointments() async {
    try {
      isLoadingAppointments.value = true;
      final response = await _service.getMyAppointments();
      if (response.success) {
        myAppointments.value = response.data;
      }
    } catch (e) {
      _showError(e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoadingAppointments.value = false;
    }
  }

  Future<void> fetchAppointmentDetail(String appointmentId) async {
    try {
      isLoadingDetail.value = true;
      selectedAppointment.value = null;
      final response = await _service.getAppointmentById(appointmentId);
      if (response.success) {
        selectedAppointment.value = response.data;
      }
    } catch (e) {
      _showError(e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoadingDetail.value = false;
    }
  }

  Future<void> fetchAppointmentRecords(String appointmentId) async {
    try {
      isLoadingRecords.value = true;
      appointmentRecords.clear();
      final response = await _service.getAppointmentRecords(appointmentId);
      if (response.success) {
        appointmentRecords.value = response.data;
      }
    } catch (e) {
      debugPrint('❌ Fetch records: $e');
    } finally {
      isLoadingRecords.value = false;
    }
  }

  void _showSuccess(String msg) => Get.snackbar('Success', msg,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.successColor,
      colorText: AppColors.whiteColor,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 3));

  void _showError(String msg) => Get.snackbar('Error', msg,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.errorColor,
      colorText: AppColors.whiteColor,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 4));
}