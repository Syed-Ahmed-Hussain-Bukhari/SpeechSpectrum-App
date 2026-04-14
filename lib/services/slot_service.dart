// // lib/services/slot_service.dart
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:speechspectrum/models/slot_model.dart';
// import 'package:speechspectrum/routes/app_urls.dart';
// import 'package:speechspectrum/services/shared_preferences_service.dart';

// class SlotService {
//   final Dio _dio = Dio();

//   Future<Options> _auth() async {
//     final token = await SharedPreferencesService.getAccessToken();
//     if (token == null || token.isEmpty) throw Exception('No authentication token found');
//     return Options(headers: {
//       'Authorization': 'Bearer $token',
//       'Content-Type': 'application/json',
//     });
//   }

//   // GET /api/slots/my
//   Future<SlotListModel> getMySlots() async {
//     try {
//       debugPrint('📅 Fetching my slots');
//       final response = await _dio.get(APIEndPoints.mySlots, options: await _auth());
//       debugPrint('✅ Slots fetched: ${(response.data['data'] as List?)?.length ?? 0}');
//       return SlotListModel.fromJson(response.data);
//     } on DioException catch (e) {
//       if (e.response?.statusCode == 401) throw Exception('Unauthorized - Please login again');
//       throw Exception(e.response?.data['message'] ?? 'Failed to fetch slots');
//     }
//   }

//   // POST /api/slots
//   Future<SlotSingleModel> createSlot({
//     required String slotDate,
//     required String startTime,
//     required String endTime,
//     required String mode,
//     double? feeOnline,
//     double? feePhysical,
//     required String currency,
//     String? locationId,
//     required bool isRecurring,
//     String? recurrenceRule,
//     required String status,
//   }) async {
//     try {
//       debugPrint('📅 Creating slot: $slotDate $startTime-$endTime');
//       final data = <String, dynamic>{
//         'slot_date': slotDate,
//         'start_time': startTime,
//         'end_time': endTime,
//         'mode': mode,
//         'currency': currency,
//         'is_recurring': isRecurring,
//         'status': status,
//       };
//       if (feeOnline != null) data['fee_online'] = feeOnline;
//       if (feePhysical != null) data['fee_physical'] = feePhysical;
//       if (locationId != null && locationId.isNotEmpty) data['location_id'] = locationId;
//       if (recurrenceRule != null && recurrenceRule.isNotEmpty) data['recurrence_rule'] = recurrenceRule;

//       final response = await _dio.post(APIEndPoints.slots, data: data, options: await _auth());
//       debugPrint('✅ Slot created');
//       return SlotSingleModel.fromJson(response.data);
//     } on DioException catch (e) {
//       debugPrint('❌ Create slot error: ${e.response?.data}');
//       if (e.response?.statusCode == 401) throw Exception('Unauthorized - Please login again');
//       throw Exception(e.response?.data['message'] ?? 'Failed to create slot');
//     }
//   }

//   // PUT /api/slots/{slotId}
//   Future<SlotSingleModel> updateSlot({
//     required String slotId,
//     String? slotDate,
//     String? startTime,
//     String? endTime,
//     String? mode,
//     double? feeOnline,
//     double? feePhysical,
//     String? currency,
//     String? locationId,
//     bool? isRecurring,
//     String? recurrenceRule,
//     String? status,
//   }) async {
//     try {
//       debugPrint('📅 Updating slot: $slotId');
//       final data = <String, dynamic>{};
//       if (slotDate != null) data['slot_date'] = slotDate;
//       if (startTime != null) data['start_time'] = startTime;
//       if (endTime != null) data['end_time'] = endTime;
//       if (mode != null) data['mode'] = mode;
//       if (feeOnline != null) data['fee_online'] = feeOnline;
//       if (feePhysical != null) data['fee_physical'] = feePhysical;
//       if (currency != null) data['currency'] = currency;
//       if (locationId != null) data['location_id'] = locationId;
//       if (isRecurring != null) data['is_recurring'] = isRecurring;
//       if (recurrenceRule != null) data['recurrence_rule'] = recurrenceRule;
//       if (status != null) data['status'] = status;

//       final response = await _dio.put(
//         '${APIEndPoints.slots}/$slotId',
//         data: data,
//         options: await _auth(),
//       );
//       debugPrint('✅ Slot updated');
//       return SlotSingleModel.fromJson(response.data);
//     } on DioException catch (e) {
//       if (e.response?.statusCode == 401) throw Exception('Unauthorized - Please login again');
//       throw Exception(e.response?.data['message'] ?? 'Failed to update slot');
//     }
//   }

//   // DELETE /api/slots/{slotId}
//   Future<bool> deleteSlot(String slotId) async {
//     try {
//       debugPrint('📅 Deleting slot: $slotId');
//       await _dio.delete('${APIEndPoints.slots}/$slotId', options: await _auth());
//       debugPrint('✅ Slot deleted');
//       return true;
//     } on DioException catch (e) {
//       if (e.response?.statusCode == 401) throw Exception('Unauthorized - Please login again');
//       throw Exception(e.response?.data['message'] ?? 'Failed to delete slot');
//     }
//   }
// }

// lib/services/slot_service.dart
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:speechspectrum/models/slot_model.dart';
import 'package:speechspectrum/routes/app_urls.dart';
import 'package:speechspectrum/services/shared_preferences_service.dart';

class SlotService {
  final Dio _dio = Dio();

  Future<Options> _auth() async {
    final token = await SharedPreferencesService.getAccessToken();
    if (token == null || token.isEmpty) throw Exception('No authentication token found');
    return Options(headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    });
  }

  // POST /api/appointments/generate-zoom-link
  // Called before creating a slot when mode is 'online' or 'both'
  Future<ZoomLinkResult> generateZoomLink({
    required String topic,
    required String startTime, // ISO8601 UTC e.g. "2026-03-20T10:00:00Z"
  }) async {
    try {
      debugPrint('🔗 Generating Zoom link: $topic');
      final response = await _dio.post(
        APIEndPoints.generateZoomLink,
        data: {
          'topic': topic,
          'start_time': startTime,
          'duration': 30,
          'timezone': 'Asia/Karachi',
        },
        options: await _auth(),
      );
      debugPrint('✅ Zoom link generated');
      return ZoomLinkResult.fromJson(response.data['data']);
    } on DioException catch (e) {
      debugPrint('❌ Zoom link error: ${e.response?.data}');
      if (e.response?.statusCode == 401) throw Exception('Unauthorized - Please login again');
      throw Exception(e.response?.data['message'] ?? 'Failed to generate Zoom link');
    }
  }

  // GET /api/slots/my
  Future<SlotListModel> getMySlots() async {
    try {
      debugPrint('📅 Fetching my slots');
      final response = await _dio.get(APIEndPoints.mySlots, options: await _auth());
      debugPrint('✅ Slots fetched: ${(response.data['data'] as List?)?.length ?? 0}');
      return SlotListModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) throw Exception('Unauthorized - Please login again');
      throw Exception(e.response?.data['message'] ?? 'Failed to fetch slots');
    }
  }

  // POST /api/slots
  Future<SlotSingleModel> createSlot({
    required String slotDate,
    required String startTime,
    required String endTime,
    required String mode,
    double? feeOnline,
    double? feePhysical,
    required String currency,
    String? locationId,
    required bool isRecurring,
    String? recurrenceRule,
    required String status,
    String? meetLink, // Zoom join URL — passed when mode is online/both
  }) async {
    try {
      debugPrint('📅 Creating slot: $slotDate $startTime-$endTime');
      final data = <String, dynamic>{
        'slot_date': slotDate,
        'start_time': startTime,
        'end_time': endTime,
        'mode': mode,
        'currency': currency,
        'is_recurring': isRecurring,
        'status': status,
      };
      if (feeOnline != null) data['fee_online'] = feeOnline;
      if (feePhysical != null) data['fee_physical'] = feePhysical;
      if (locationId != null && locationId.isNotEmpty) data['location_id'] = locationId;
      if (recurrenceRule != null && recurrenceRule.isNotEmpty) data['recurrence_rule'] = recurrenceRule;
      if (meetLink != null && meetLink.isNotEmpty) data['meet_link'] = meetLink;

      final response = await _dio.post(APIEndPoints.slots, data: data, options: await _auth());
      debugPrint('✅ Slot created');
      return SlotSingleModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Create slot error: ${e.response?.data}');
      if (e.response?.statusCode == 401) throw Exception('Unauthorized - Please login again');
      throw Exception(e.response?.data['message'] ?? 'Failed to create slot');
    }
  }

  // PUT /api/slots/{slotId}
  Future<SlotSingleModel> updateSlot({
    required String slotId,
    String? slotDate,
    String? startTime,
    String? endTime,
    String? mode,
    double? feeOnline,
    double? feePhysical,
    String? currency,
    String? locationId,
    bool? isRecurring,
    String? recurrenceRule,
    String? status,
  }) async {
    try {
      debugPrint('📅 Updating slot: $slotId');
      final data = <String, dynamic>{};
      if (slotDate != null) data['slot_date'] = slotDate;
      if (startTime != null) data['start_time'] = startTime;
      if (endTime != null) data['end_time'] = endTime;
      if (mode != null) data['mode'] = mode;
      if (feeOnline != null) data['fee_online'] = feeOnline;
      if (feePhysical != null) data['fee_physical'] = feePhysical;
      if (currency != null) data['currency'] = currency;
      if (locationId != null) data['location_id'] = locationId;
      if (isRecurring != null) data['is_recurring'] = isRecurring;
      if (recurrenceRule != null) data['recurrence_rule'] = recurrenceRule;
      if (status != null) data['status'] = status;

      final response = await _dio.put(
        '${APIEndPoints.slots}/$slotId',
        data: data,
        options: await _auth(),
      );
      debugPrint('✅ Slot updated');
      return SlotSingleModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) throw Exception('Unauthorized - Please login again');
      throw Exception(e.response?.data['message'] ?? 'Failed to update slot');
    }
  }

  // DELETE /api/slots/{slotId}
  Future<bool> deleteSlot(String slotId) async {
    try {
      debugPrint('📅 Deleting slot: $slotId');
      await _dio.delete('${APIEndPoints.slots}/$slotId', options: await _auth());
      debugPrint('✅ Slot deleted');
      return true;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) throw Exception('Unauthorized - Please login again');
      throw Exception(e.response?.data['message'] ?? 'Failed to delete slot');
    }
  }
}