// // lib/services/parent_appointment_service.dart
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:speechspectrum/models/appointment_model.dart';
// import 'package:speechspectrum/routes/app_urls.dart';
// import 'package:speechspectrum/services/shared_preferences_service.dart';

// class ParentAppointmentService {
//   final Dio _dio = Dio();

//   // Get Parent Appointments
//   Future<ExpertAppointmentsModel> getParentAppointments() async {
//     try {
//       final token = await SharedPreferencesService.getAccessToken();

//       if (token == null || token.isEmpty) {
//         throw Exception('No authentication token found');
//       }

//       debugPrint('🔐 Fetching parent appointments');

//       final response = await _dio.get(
//         APIEndPoints.parentAppointments,
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer $token',
//             'Content-Type': 'application/json',
//           },
//         ),
//       );

//       debugPrint('✅ Parent appointments fetched successfully');
//       return ExpertAppointmentsModel.fromJson(response.data);
//     } on DioException catch (e) {
//       debugPrint('❌ Fetch parent appointments error: ${e.message}');

//       if (e.response?.statusCode == 401) {
//         throw Exception('Unauthorized - Please login again');
//       }

//       throw Exception(
//         e.response?.data['message'] ?? 'Failed to fetch appointments',
//       );
//     } catch (e) {
//       debugPrint('❌ Unexpected error: $e');
//       throw Exception('An unexpected error occurred');
//     }
//   }

//   // Get Appointment Details (same endpoint for both parent and expert)
//   Future<AppointmentDetailsModel> getAppointmentDetails({
//     required String appointmentId,
//   }) async {
//     try {
//       final token = await SharedPreferencesService.getAccessToken();

//       if (token == null || token.isEmpty) {
//         throw Exception('No authentication token found');
//       }

//       debugPrint('🔐 Fetching appointment details');

//       final response = await _dio.get(
//         '${APIEndPoints.appointmentNotes}/$appointmentId/details',
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer $token',
//             'Content-Type': 'application/json',
//           },
//         ),
//       );

//       debugPrint('✅ Appointment details fetched successfully');
//       return AppointmentDetailsModel.fromJson(response.data);
//     } on DioException catch (e) {
//       debugPrint('❌ Fetch appointment details error: ${e.message}');

//       if (e.response?.statusCode == 401) {
//         throw Exception('Unauthorized - Please login again');
//       }

//       throw Exception(
//         e.response?.data['message'] ?? 'Failed to fetch appointment details',
//       );
//     } catch (e) {
//       debugPrint('❌ Unexpected error: $e');
//       throw Exception('An unexpected error occurred');
//     }
//   }
// }


// lib/services/parent_appointment_service.dart
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:speechspectrum/models/parent_appointment_model.dart';
import 'package:speechspectrum/routes/app_urls.dart';
import 'package:speechspectrum/services/shared_preferences_service.dart';

class ParentAppointmentService {
  final Dio _dio = Dio();

  // Get Parent Appointments - Uses ParentAppointmentsModel
  Future<ParentAppointmentsModel> getParentAppointments() async {
    try {
      final token = await SharedPreferencesService.getAccessToken();

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      debugPrint('🔐 Fetching parent appointments');

      final response = await _dio.get(
        APIEndPoints.parentAppointments,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      debugPrint('✅ Parent appointments fetched successfully');
      debugPrint('Response data: ${response.data}');
      
      return ParentAppointmentsModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Fetch parent appointments error: ${e.message}');

      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized - Please login again');
      }

      throw Exception(
        e.response?.data['message'] ?? 'Failed to fetch appointments',
      );
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  // Get Appointment Details (same endpoint for both parent and expert)
  Future<AppointmentDetailsModel> getAppointmentDetails({
    required String appointmentId,
  }) async {
    try {
      final token = await SharedPreferencesService.getAccessToken();

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      debugPrint('🔐 Fetching appointment details for: $appointmentId');

      final response = await _dio.get(
        '${APIEndPoints.appointmentNotes}/$appointmentId/details',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      debugPrint('✅ Appointment details fetched successfully');
      return AppointmentDetailsModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Fetch appointment details error: ${e.message}');

      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized - Please login again');
      }

      throw Exception(
        e.response?.data['message'] ?? 'Failed to fetch appointment details',
      );
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }
}