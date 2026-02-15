// lib/services/appointment_service.dart
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:speechspectrum/models/appointment_model.dart';
import 'package:speechspectrum/routes/app_urls.dart';
import 'package:speechspectrum/services/shared_preferences_service.dart';

class AppointmentService {
  final Dio _dio = Dio();

  // Generate Zoom Link
  Future<GenerateZoomLinkModel> generateZoomLink({
    required String topic,
    required String startTime,
    required int duration,
    required String timezone,
  }) async {
    try {
      final token = await SharedPreferencesService.getAccessToken();

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      debugPrint('🔐 Generating Zoom link');

      final data = {
        'topic': topic,
        'start_time': startTime,
        'duration': duration,
        'timezone': timezone,
      };

      debugPrint('📤 Zoom link request: $data');

      final response = await _dio.post(
        APIEndPoints.generateZoomLink,
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      debugPrint('✅ Zoom link generated successfully');
      return GenerateZoomLinkModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Generate zoom link error: ${e.message}');
      debugPrint('❌ Response: ${e.response?.data}');

      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized - Please login again');
      }

      throw Exception(
        e.response?.data['message'] ?? 'Failed to generate zoom link',
      );
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  // Create Appointment
  Future<CreateAppointmentModel> createAppointment({
    required String linkId,
    required String appointmentType,
    required String scheduledAt,
    String? meetLink,
    String? contact,
    String? location,
  }) async {
    try {
      final token = await SharedPreferencesService.getAccessToken();

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      debugPrint('🔐 Creating appointment');

      final data = {
        'link_id': linkId,
        'appointment_type': appointmentType,
        'scheduled_at': scheduledAt,
        if (meetLink != null) 'meet_link': meetLink,
        if (contact != null) 'contact': contact,
        if (location != null) 'location': location,
      };

      debugPrint('📤 Create appointment data: $data');

      final response = await _dio.post(
        APIEndPoints.createAppointment,
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      debugPrint('✅ Appointment created successfully');
      return CreateAppointmentModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Create appointment error: ${e.message}');
      debugPrint('❌ Response: ${e.response?.data}');

      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized - Please login again');
      }

      throw Exception(
        e.response?.data['message'] ?? 'Failed to create appointment',
      );
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  // Get Expert Appointments
  Future<ExpertAppointmentsModel> getExpertAppointments() async {
    try {
      final token = await SharedPreferencesService.getAccessToken();

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      debugPrint('🔐 Fetching expert appointments');

      final response = await _dio.get(
        APIEndPoints.expertAppointments,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      debugPrint('✅ Expert appointments fetched successfully');
      return ExpertAppointmentsModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Fetch expert appointments error: ${e.message}');

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

  // Save Appointment Notes
  Future<SaveNotesModel> saveAppointmentNotes({
    required String appointmentId,
    required String discussionSummary,
    required String notes,
    required Map<String, dynamic> medication,
  }) async {
    try {
      final token = await SharedPreferencesService.getAccessToken();

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      debugPrint('🔐 Saving appointment notes');

      final data = {
        'discussion_summary': discussionSummary,
        'notes': notes,
        'medication': medication,
      };

      debugPrint('📤 Save notes data: $data');

      final response = await _dio.post(
        '${APIEndPoints.appointmentNotes}/$appointmentId/notes',
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      debugPrint('✅ Appointment notes saved successfully');
      return SaveNotesModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Save appointment notes error: ${e.message}');
      debugPrint('❌ Response: ${e.response?.data}');

      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized - Please login again');
      }

      throw Exception(
        e.response?.data['message'] ?? 'Failed to save notes',
      );
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  // Save Appointment Feedback
  Future<SaveNotesModel> saveAppointmentFeedback({
    required String appointmentId,
    required String progressFeedback,
  }) async {
    try {
      final token = await SharedPreferencesService.getAccessToken();

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      debugPrint('🔐 Saving appointment feedback');

      final data = {
        'progress_feedback': progressFeedback,
      };

      debugPrint('📤 Save feedback data: $data');

      final response = await _dio.post(
        '${APIEndPoints.appointmentNotes}/$appointmentId/feedback',
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      debugPrint('✅ Appointment feedback saved successfully');
      return SaveNotesModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Save appointment feedback error: ${e.message}');
      debugPrint('❌ Response: ${e.response?.data}');

      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized - Please login again');
      }

      throw Exception(
        e.response?.data['message'] ?? 'Failed to save feedback',
      );
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  // Get Appointment Details
  Future<AppointmentDetailsModel> getAppointmentDetails({
    required String appointmentId,
  }) async {
    try {
      final token = await SharedPreferencesService.getAccessToken();

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      debugPrint('🔐 Fetching appointment details');

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