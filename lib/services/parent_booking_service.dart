// lib/services/parent_booking_service.dart
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:speechspectrum/models/my_appointment_model.dart';
import 'package:speechspectrum/models/parent_booking_model.dart';
import 'package:speechspectrum/routes/app_urls.dart';
import 'package:speechspectrum/services/shared_preferences_service.dart';

class ParentBookingService {
  final Dio _dio = Dio();

  Future<Options> _auth() async {
    final token = await SharedPreferencesService.getAccessToken();
    if (token == null || token.isEmpty) throw Exception('No authentication token found');
    return Options(headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    });
  }

  // GET /api/slots/expert/{expertId}
  Future<ExpertSlotListModel> getExpertSlots(String expertId) async {
    try {
      debugPrint('📅 Fetching slots for expert: $expertId');
      final response = await _dio.get(
        '${APIEndPoints.slots}/expert/$expertId',
        options: await _auth(),
      );
      debugPrint('✅ Expert slots fetched: ${(response.data['data'] as List?)?.length ?? 0}');
      return ExpertSlotListModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) throw Exception('Unauthorized - Please login again');
      throw Exception(e.response?.data['message'] ?? 'Failed to fetch expert slots');
    }
  }

  // POST /api/appointments → Book appointment
  Future<BookAppointmentModel> bookAppointment({
    required String slotId,
    required String childId,
    required String bookedMode,
  }) async {
    try {
      debugPrint('📋 Booking appointment: slot=$slotId child=$childId mode=$bookedMode');
      final response = await _dio.post(
        APIEndPoints.appointmentsBase,
        data: {
          'slot_id': slotId,
          'child_id': childId,
          'booked_mode': bookedMode,
        },
        options: await _auth(),
      );
      debugPrint('✅ Appointment booked: ${response.data}');
      return BookAppointmentModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Book appointment error: ${e.response?.data}');
      if (e.response?.statusCode == 401) throw Exception('Unauthorized - Please login again');
      throw Exception(e.response?.data['message'] ?? 'Failed to book appointment');
    }
  }

  // GET /api/appointments/my
  Future<MyAppointmentListModel> getMyAppointments() async {
    try {
      debugPrint('📋 Fetching parent appointments');
      final response = await _dio.get(
        APIEndPoints.myAppointments,
        options: await _auth(),
      );
      return MyAppointmentListModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) throw Exception('Unauthorized - Please login again');
      throw Exception(e.response?.data['message'] ?? 'Failed to fetch appointments');
    }
  }

  // GET /api/appointments/{id}
  Future<MyAppointmentSingleModel> getAppointmentById(String id) async {
    try {
      final response = await _dio.get(
        '${APIEndPoints.appointmentsBase}/$id',
        options: await _auth(),
      );
      return MyAppointmentSingleModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) throw Exception('Unauthorized - Please login again');
      throw Exception(e.response?.data['message'] ?? 'Failed to fetch appointment');
    }
  }

  // GET /api/appointments/{id}/records
  Future<AppointmentRecordListModel> getAppointmentRecords(String id) async {
    try {
      final response = await _dio.get(
        '${APIEndPoints.appointmentsBase}/$id/records',
        options: await _auth(),
      );
      return AppointmentRecordListModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) throw Exception('Unauthorized - Please login again');
      throw Exception(e.response?.data['message'] ?? 'Failed to fetch records');
    }
  }
}