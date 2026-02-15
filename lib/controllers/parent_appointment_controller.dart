// // lib/controllers/parent_appointment_controller.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/models/appointment_model.dart';
// import 'package:speechspectrum/services/parent_appointment_service.dart';

// class ParentAppointmentController extends GetxController {
//   final ParentAppointmentService _appointmentService = ParentAppointmentService();

//   var isLoading = false.obs;
//   var appointments = <ExpertAppointmentItem>[].obs;
//   var appointmentDetails = Rx<AppointmentDetailsModel?>(null);

//   // Fetch Parent Appointments
//   Future<void> fetchParentAppointments() async {
//     try {
//       isLoading.value = true;
//       debugPrint('🔐 Fetching parent appointments');

//       final response = await _appointmentService.getParentAppointments();

//       debugPrint('✅ Appointments fetched: ${response.data.length}');

//       if (response.status) {
//         appointments.value = response.data;
//       } else {
//         _showError(response.message);
//       }
//     } catch (e) {
//       debugPrint('❌ Error fetching appointments: $e');
//       _showError(e.toString().replaceAll('Exception: ', ''));
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // Fetch Appointment Details
//   Future<void> fetchAppointmentDetails({
//     required String appointmentId,
//   }) async {
//     try {
//       isLoading.value = true;

//       final response = await _appointmentService.getAppointmentDetails(
//         appointmentId: appointmentId,
//       );

//       if (response.status) {
//         appointmentDetails.value = response;
//       } else {
//         _showError(response.message);
//       }
//     } catch (e) {
//       debugPrint('❌ Error fetching appointment details: $e');
//       _showError(e.toString().replaceAll('Exception: ', ''));
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // Get counts
//   int getScheduledCount() {
//     return appointments.where((a) => a.isScheduled()).length;
//   }

//   int getCompletedCount() {
//     return appointments.where((a) => a.isCompleted()).length;
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

// lib/controllers/parent_appointment_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/models/parent_appointment_model.dart';
import 'package:speechspectrum/services/parent_appointment_service.dart';

class ParentAppointmentController extends GetxController {
  final ParentAppointmentService _appointmentService = ParentAppointmentService();

  var isLoading = false.obs;
  var appointments = <ParentAppointmentItem>[].obs; // Changed to ParentAppointmentItem
  var appointmentDetails = Rx<AppointmentDetailsModel?>(null);

  // Fetch Parent Appointments
  Future<void> fetchParentAppointments() async {
    try {
      isLoading.value = true;
      debugPrint('🔐 Fetching parent appointments');

      final response = await _appointmentService.getParentAppointments();

      debugPrint('✅ Appointments fetched: ${response.data.length}');

      if (response.status) {
        appointments.value = response.data;
        debugPrint('✅ Appointments assigned to observable list');
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

  // Fetch Appointment Details
  Future<void> fetchAppointmentDetails({
    required String appointmentId,
  }) async {
    try {
      isLoading.value = true;
      debugPrint('🔐 Fetching appointment details for: $appointmentId');

      final response = await _appointmentService.getAppointmentDetails(
        appointmentId: appointmentId,
      );

      debugPrint('✅ Appointment details fetched');

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