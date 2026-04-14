// // // lib/services/my_appointment_service.dart
// // import 'package:dio/dio.dart';
// // import 'package:flutter/foundation.dart';
// // import 'package:speechspectrum/models/my_appointment_model.dart';
// // import 'package:speechspectrum/routes/app_urls.dart';
// // import 'package:speechspectrum/services/shared_preferences_service.dart';

// // class MyAppointmentService {
// //   final Dio _dio = Dio();

// //   Future<Options> _auth() async {
// //     final token = await SharedPreferencesService.getAccessToken();
// //     if (token == null || token.isEmpty) {
// //       throw Exception('No authentication token found');
// //     }
// //     return Options(headers: {
// //       'Authorization': 'Bearer $token',
// //       'Content-Type': 'application/json',
// //     });
// //   }

// //   // GET /api/appointments/my
// //   Future<MyAppointmentListModel> getMyAppointments() async {
// //     try {
// //       debugPrint('📋 Fetching my appointments');
// //       final response = await _dio.get(
// //         APIEndPoints.myAppointments,
// //         options: await _auth(),
// //       );
// //       debugPrint('✅ Appointments fetched: ${(response.data['data'] as List?)?.length ?? 0}');
// //       return MyAppointmentListModel.fromJson(response.data);
// //     } on DioException catch (e) {
// //       if (e.response?.statusCode == 401) throw Exception('Unauthorized - Please login again');
// //       throw Exception(e.response?.data['message'] ?? 'Failed to fetch appointments');
// //     }
// //   }

// //   // GET /api/appointments/{appointmentId}
// //   Future<MyAppointmentSingleModel> getAppointmentById(String appointmentId) async {
// //     try {
// //       debugPrint('📋 Fetching appointment: $appointmentId');
// //       final response = await _dio.get(
// //         '${APIEndPoints.appointmentsBase}/$appointmentId',
// //         options: await _auth(),
// //       );
// //       return MyAppointmentSingleModel.fromJson(response.data);
// //     } on DioException catch (e) {
// //       if (e.response?.statusCode == 401) throw Exception('Unauthorized - Please login again');
// //       throw Exception(e.response?.data['message'] ?? 'Failed to fetch appointment');
// //     }
// //   }

// //   // POST /api/appointments/{appointmentId}/confirm
// //   Future<MyAppointmentSingleModel> confirmAppointment(String appointmentId) async {
// //     try {
// //       debugPrint('📋 Confirming appointment: $appointmentId');
// //       final response = await _dio.post(
// //         '${APIEndPoints.appointmentsBase}/$appointmentId/confirm',
// //         options: await _auth(),
// //       );
// //       return MyAppointmentSingleModel.fromJson(response.data);
// //     } on DioException catch (e) {
// //       if (e.response?.statusCode == 401) throw Exception('Unauthorized - Please login again');
// //       throw Exception(e.response?.data['message'] ?? 'Failed to confirm appointment');
// //     }
// //   }

// //   // POST /api/appointments/{appointmentId}/complete
// //   Future<MyAppointmentSingleModel> completeAppointment(String appointmentId) async {
// //     try {
// //       debugPrint('📋 Completing appointment: $appointmentId');
// //       final response = await _dio.post(
// //         '${APIEndPoints.appointmentsBase}/$appointmentId/complete',
// //         options: await _auth(),
// //       );
// //       return MyAppointmentSingleModel.fromJson(response.data);
// //     } on DioException catch (e) {
// //       if (e.response?.statusCode == 401) throw Exception('Unauthorized - Please login again');
// //       throw Exception(e.response?.data['message'] ?? 'Failed to complete appointment');
// //     }
// //   }

// //   // POST /api/appointments/{appointmentId}/cancel
// //   Future<MyAppointmentSingleModel> cancelAppointment(
// //       String appointmentId, String reason) async {
// //     try {
// //       debugPrint('📋 Cancelling appointment: $appointmentId');
// //       final response = await _dio.post(
// //         '${APIEndPoints.appointmentsBase}/$appointmentId/cancel',
// //         data: {'cancellation_reason': reason},
// //         options: await _auth(),
// //       );
// //       return MyAppointmentSingleModel.fromJson(response.data);
// //     } on DioException catch (e) {
// //       if (e.response?.statusCode == 401) throw Exception('Unauthorized - Please login again');
// //       throw Exception(e.response?.data['message'] ?? 'Failed to cancel appointment');
// //     }
// //   }

// //   // POST /api/appointments/{appointmentId}/no-show
// //   Future<MyAppointmentSingleModel> markNoShow(String appointmentId) async {
// //     try {
// //       debugPrint('📋 Marking no-show: $appointmentId');
// //       final response = await _dio.post(
// //         '${APIEndPoints.appointmentsBase}/$appointmentId/no-show',
// //         options: await _auth(),
// //       );
// //       return MyAppointmentSingleModel.fromJson(response.data);
// //     } on DioException catch (e) {
// //       if (e.response?.statusCode == 401) throw Exception('Unauthorized - Please login again');
// //       throw Exception(e.response?.data['message'] ?? 'Failed to mark no-show');
// //     }
// //   }

// //   // GET /api/appointments/{appointmentId}/records
// //   Future<AppointmentRecordListModel> getRecords(String appointmentId) async {
// //     try {
// //       debugPrint('📋 Fetching records: $appointmentId');
// //       final response = await _dio.get(
// //         '${APIEndPoints.appointmentsBase}/$appointmentId/records',
// //         options: await _auth(),
// //       );
// //       return AppointmentRecordListModel.fromJson(response.data);
// //     } on DioException catch (e) {
// //       if (e.response?.statusCode == 401) throw Exception('Unauthorized - Please login again');
// //       throw Exception(e.response?.data['message'] ?? 'Failed to fetch records');
// //     }
// //   }

// //   // POST /api/appointments/{appointmentId}/records
// //   Future<AppointmentRecordSingleModel> createRecord({
// //     required String appointmentId,
// //     required String notes,
// //     required String therapyPlan,
// //     required Map<String, dynamic> medication,
// //     required String progressFeedback,
// //   }) async {
// //     try {
// //       debugPrint('📋 Creating record: $appointmentId');
// //       final response = await _dio.post(
// //         '${APIEndPoints.appointmentsBase}/$appointmentId/records',
// //         data: {
// //           'notes': notes,
// //           'therapy_plan': therapyPlan,
// //           'medication': medication,
// //           'progress_feedback': progressFeedback,
// //         },
// //         options: await _auth(),
// //       );
// //       return AppointmentRecordSingleModel.fromJson(response.data);
// //     } on DioException catch (e) {
// //       if (e.response?.statusCode == 401) throw Exception('Unauthorized - Please login again');
// //       throw Exception(e.response?.data['message'] ?? 'Failed to create record');
// //     }
// //   }

// //   // PUT /api/appointments/{appointmentId}/records/{recordId}
// //   Future<AppointmentRecordSingleModel> updateRecord({
// //     required String appointmentId,
// //     required String recordId,
// //     String? notes,
// //     String? therapyPlan,
// //     Map<String, dynamic>? medication,
// //     String? progressFeedback,
// //   }) async {
// //     try {
// //       debugPrint('📋 Updating record: $recordId');
// //       final data = <String, dynamic>{};
// //       if (notes != null) data['notes'] = notes;
// //       if (therapyPlan != null) data['therapy_plan'] = therapyPlan;
// //       if (medication != null) data['medication'] = medication;
// //       if (progressFeedback != null) data['progress_feedback'] = progressFeedback;

// //       final response = await _dio.put(
// //         '${APIEndPoints.appointmentsBase}/$appointmentId/records/$recordId',
// //         data: data,
// //         options: await _auth(),
// //       );
// //       return AppointmentRecordSingleModel.fromJson(response.data);
// //     } on DioException catch (e) {
// //       if (e.response?.statusCode == 401) throw Exception('Unauthorized - Please login again');
// //       throw Exception(e.response?.data['message'] ?? 'Failed to update record');
// //     }
// //   }
// // }


// // lib/services/my_appointment_service.dart
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:speechspectrum/models/my_appointment_model.dart';
// import 'package:speechspectrum/routes/app_urls.dart';
// import 'package:speechspectrum/services/shared_preferences_service.dart';

// class MyAppointmentService {
//   final Dio _dio = Dio();

//   Future<Options> _authOptions() async {
//     final token = await SharedPreferencesService.getAccessToken();
//     if (token == null || token.isEmpty) {
//       throw Exception('No authentication token found. Please login again.');
//     }
//     return Options(
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json',
//       },
//     );
//   }

//   String _errorMessage(dynamic e, String fallback) {
//     if (e is DioException) {
//       final data = e.response?.data;
//       if (data is Map && data['message'] != null) {
//         return data['message'].toString();
//       }
//       if (e.response?.statusCode == 401) return 'Unauthorized. Please login again.';
//       if (e.response?.statusCode == 404) return 'Appointment not found.';
//       if (e.response?.statusCode == 400) return data?['message']?.toString() ?? fallback;
//     }
//     return fallback;
//   }

//   // GET /api/appointments/my
//   Future<MyAppointmentListModel> getMyAppointments() async {
//     try {
//       debugPrint('📋 [Service] GET my appointments');
//       final resp = await _dio.get(
//         APIEndPoints.myAppointments,
//         options: await _authOptions(),
//       );
//       final model = MyAppointmentListModel.fromJson(
//           Map<String, dynamic>.from(resp.data as Map));
//       debugPrint('✅ [Service] Appointments loaded: ${model.data.length}');
//       return model;
//     } on DioException catch (e) {
//       debugPrint('❌ [Service] getMyAppointments: ${e.message}');
//       throw Exception(_errorMessage(e, 'Failed to load appointments'));
//     }
//   }

//   // GET /api/appointments/{id}
//   Future<MyAppointmentSingleModel> getAppointmentById(String appointmentId) async {
//     try {
//       debugPrint('📋 [Service] GET appointment: $appointmentId');
//       final resp = await _dio.get(
//         '${APIEndPoints.appointmentsBase}/$appointmentId',
//         options: await _authOptions(),
//       );
//       return MyAppointmentSingleModel.fromJson(
//           Map<String, dynamic>.from(resp.data as Map));
//     } on DioException catch (e) {
//       debugPrint('❌ [Service] getAppointmentById: ${e.message}');
//       throw Exception(_errorMessage(e, 'Failed to load appointment details'));
//     }
//   }

//   // POST /api/appointments/{id}/confirm
//   Future<MyAppointmentSingleModel> confirmAppointment(String appointmentId) async {
//     try {
//       debugPrint('📋 [Service] POST confirm: $appointmentId');
//       final resp = await _dio.post(
//         '${APIEndPoints.appointmentsBase}/$appointmentId/confirm',
//         options: await _authOptions(),
//       );
//       return MyAppointmentSingleModel.fromJson(
//           Map<String, dynamic>.from(resp.data as Map));
//     } on DioException catch (e) {
//       debugPrint('❌ [Service] confirmAppointment: ${e.message}');
//       throw Exception(_errorMessage(e, 'Failed to confirm appointment'));
//     }
//   }

//   // POST /api/appointments/{id}/complete
//   Future<MyAppointmentSingleModel> completeAppointment(String appointmentId) async {
//     try {
//       debugPrint('📋 [Service] POST complete: $appointmentId');
//       final resp = await _dio.post(
//         '${APIEndPoints.appointmentsBase}/$appointmentId/complete',
//         options: await _authOptions(),
//       );
//       return MyAppointmentSingleModel.fromJson(
//           Map<String, dynamic>.from(resp.data as Map));
//     } on DioException catch (e) {
//       debugPrint('❌ [Service] completeAppointment: ${e.message}');
//       throw Exception(_errorMessage(e, 'Failed to complete appointment'));
//     }
//   }

//   // POST /api/appointments/{id}/cancel
//   Future<MyAppointmentSingleModel> cancelAppointment(
//       String appointmentId, String reason) async {
//     try {
//       debugPrint('📋 [Service] POST cancel: $appointmentId | reason: $reason');
//       final resp = await _dio.post(
//         '${APIEndPoints.appointmentsBase}/$appointmentId/cancel',
//         data: {'cancellation_reason': reason},
//         options: await _authOptions(),
//       );
//       return MyAppointmentSingleModel.fromJson(
//           Map<String, dynamic>.from(resp.data as Map));
//     } on DioException catch (e) {
//       debugPrint('❌ [Service] cancelAppointment: ${e.message}');
//       throw Exception(_errorMessage(e, 'Failed to cancel appointment'));
//     }
//   }

//   // POST /api/appointments/{id}/no-show
//   Future<MyAppointmentSingleModel> markNoShow(String appointmentId) async {
//     try {
//       debugPrint('📋 [Service] POST no-show: $appointmentId');
//       final resp = await _dio.post(
//         '${APIEndPoints.appointmentsBase}/$appointmentId/no-show',
//         options: await _authOptions(),
//       );
//       return MyAppointmentSingleModel.fromJson(
//           Map<String, dynamic>.from(resp.data as Map));
//     } on DioException catch (e) {
//       debugPrint('❌ [Service] markNoShow: ${e.message}');
//       throw Exception(_errorMessage(e, 'Failed to mark as no-show'));
//     }
//   }

//   // GET /api/appointments/{id}/records
//   Future<AppointmentRecordListModel> getRecords(String appointmentId) async {
//     try {
//       debugPrint('📋 [Service] GET records: $appointmentId');
//       final resp = await _dio.get(
//         '${APIEndPoints.appointmentsBase}/$appointmentId/records',
//         options: await _authOptions(),
//       );
//       return AppointmentRecordListModel.fromJson(
//           Map<String, dynamic>.from(resp.data as Map));
//     } on DioException catch (e) {
//       debugPrint('❌ [Service] getRecords: ${e.message}');
//       throw Exception(_errorMessage(e, 'Failed to load records'));
//     }
//   }

//   // POST /api/appointments/{id}/records
//   Future<AppointmentRecordSingleModel> createRecord({
//     required String appointmentId,
//     required String notes,
//     required String therapyPlan,
//     required Map<String, dynamic> medication,
//     required String progressFeedback,
//   }) async {
//     try {
//       debugPrint('📋 [Service] POST create record: $appointmentId');
//       final resp = await _dio.post(
//         '${APIEndPoints.appointmentsBase}/$appointmentId/records',
//         data: {
//           'notes': notes,
//           'therapy_plan': therapyPlan,
//           'medication': medication,
//           'progress_feedback': progressFeedback,
//         },
//         options: await _authOptions(),
//       );
//       return AppointmentRecordSingleModel.fromJson(
//           Map<String, dynamic>.from(resp.data as Map));
//     } on DioException catch (e) {
//       debugPrint('❌ [Service] createRecord: ${e.message}');
//       throw Exception(_errorMessage(e, 'Failed to create record'));
//     }
//   }

//   // PUT /api/appointments/{id}/records/{recordId}
//   Future<AppointmentRecordSingleModel> updateRecord({
//     required String appointmentId,
//     required String recordId,
//     required String notes,
//     required String therapyPlan,
//     required Map<String, dynamic> medication,
//     required String progressFeedback,
//   }) async {
//     try {
//       debugPrint('📋 [Service] PUT update record: $recordId');
//       final resp = await _dio.put(
//         '${APIEndPoints.appointmentsBase}/$appointmentId/records/$recordId',
//         data: {
//           'notes': notes,
//           'therapy_plan': therapyPlan,
//           'medication': medication,
//           'progress_feedback': progressFeedback,
//         },
//         options: await _authOptions(),
//       );
//       return AppointmentRecordSingleModel.fromJson(
//           Map<String, dynamic>.from(resp.data as Map));
//     } on DioException catch (e) {
//       debugPrint('❌ [Service] updateRecord: ${e.message}');
//       throw Exception(_errorMessage(e, 'Failed to update record'));
//     }
//   }
// }


// lib/services/my_appointment_service.dart
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:speechspectrum/models/my_appointment_model.dart';
import 'package:speechspectrum/routes/app_urls.dart';
import 'package:speechspectrum/services/shared_preferences_service.dart';

class MyAppointmentService {
  final Dio _dio = Dio();

  Future<Options> _authOptions() async {
    final token = await SharedPreferencesService.getAccessToken();
    if (token == null || token.isEmpty) {
      throw Exception('No authentication token found. Please login again.');
    }
    return Options(
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
  }

  String _errorMessage(dynamic e, String fallback) {
    if (e is DioException) {
      final data = e.response?.data;
      if (data is Map && data['message'] != null) {
        return data['message'].toString();
      }
      switch (e.response?.statusCode) {
        case 401:
          return 'Unauthorized. Please login again.';
        case 403:
          return 'You do not have permission to perform this action.';
        case 404:
          return 'Appointment not found.';
        case 400:
          return data?['message']?.toString() ?? fallback;
        case 422:
          return data?['message']?.toString() ?? 'Validation error.';
        default:
          return fallback;
      }
    }
    return fallback;
  }

  // ── GET /api/appointments/my ───────────────────────────────
  Future<MyAppointmentListModel> getMyAppointments() async {
    try {
      debugPrint('📋 [Service] GET my appointments');
      final resp = await _dio.get(
        APIEndPoints.myAppointments,
        options: await _authOptions(),
      );
      final model = MyAppointmentListModel.fromJson(
          Map<String, dynamic>.from(resp.data as Map));
      debugPrint('✅ [Service] Appointments loaded: ${model.data.length}');
      return model;
    } on DioException catch (e) {
      debugPrint('❌ [Service] getMyAppointments: ${e.message}');
      throw Exception(_errorMessage(e, 'Failed to load appointments'));
    }
  }

  // ── GET /api/appointments/{id} ─────────────────────────────
  Future<MyAppointmentSingleModel> getAppointmentById(
      String appointmentId) async {
    try {
      debugPrint('📋 [Service] GET appointment: $appointmentId');
      final resp = await _dio.get(
        '${APIEndPoints.appointmentsBase}/$appointmentId',
        options: await _authOptions(),
      );
      return MyAppointmentSingleModel.fromJson(
          Map<String, dynamic>.from(resp.data as Map));
    } on DioException catch (e) {
      debugPrint('❌ [Service] getAppointmentById: ${e.message}');
      throw Exception(_errorMessage(e, 'Failed to load appointment details'));
    }
  }

  // ── PATCH /api/appointments/{id}/confirm ──────────────────
  Future<MyAppointmentSingleModel> confirmAppointment(
      String appointmentId) async {
    try {
      debugPrint('📋 [Service] PATCH confirm: $appointmentId');
      final resp = await _dio.patch(
        '${APIEndPoints.appointmentsBase}/$appointmentId/confirm',
        options: await _authOptions(),
      );
      return MyAppointmentSingleModel.fromJson(
          Map<String, dynamic>.from(resp.data as Map));
    } on DioException catch (e) {
      debugPrint('❌ [Service] confirmAppointment: ${e.message}');
      throw Exception(_errorMessage(e, 'Failed to confirm appointment'));
    }
  }

  // ── PATCH /api/appointments/{id}/complete ─────────────────
  Future<MyAppointmentSingleModel> completeAppointment(
      String appointmentId) async {
    try {
      debugPrint('📋 [Service] PATCH complete: $appointmentId');
      final resp = await _dio.patch(
        '${APIEndPoints.appointmentsBase}/$appointmentId/complete',
        options: await _authOptions(),
      );
      return MyAppointmentSingleModel.fromJson(
          Map<String, dynamic>.from(resp.data as Map));
    } on DioException catch (e) {
      debugPrint('❌ [Service] completeAppointment: ${e.message}');
      throw Exception(_errorMessage(e, 'Failed to complete appointment'));
    }
  }

  // ── PATCH /api/appointments/{id}/cancel ───────────────────
  Future<MyAppointmentSingleModel> cancelAppointment(
      String appointmentId, String reason) async {
    try {
      debugPrint(
          '📋 [Service] PATCH cancel: $appointmentId | reason: $reason');
      final resp = await _dio.patch(
        '${APIEndPoints.appointmentsBase}/$appointmentId/cancel',
        data: {'cancellation_reason': reason},
        options: await _authOptions(),
      );
      return MyAppointmentSingleModel.fromJson(
          Map<String, dynamic>.from(resp.data as Map));
    } on DioException catch (e) {
      debugPrint('❌ [Service] cancelAppointment: ${e.message}');
      throw Exception(_errorMessage(e, 'Failed to cancel appointment'));
    }
  }

  // ── PATCH /api/appointments/{id}/no-show ──────────────────
  Future<MyAppointmentSingleModel> markNoShow(String appointmentId) async {
    try {
      debugPrint('📋 [Service] PATCH no-show: $appointmentId');
      final resp = await _dio.patch(
        '${APIEndPoints.appointmentsBase}/$appointmentId/no-show',
        options: await _authOptions(),
      );
      return MyAppointmentSingleModel.fromJson(
          Map<String, dynamic>.from(resp.data as Map));
    } on DioException catch (e) {
      debugPrint('❌ [Service] markNoShow: ${e.message}');
      throw Exception(_errorMessage(e, 'Failed to mark as no-show'));
    }
  }

  // ── GET /api/appointments/{id}/records ────────────────────
  Future<AppointmentRecordListModel> getRecords(String appointmentId) async {
    try {
      debugPrint('📋 [Service] GET records: $appointmentId');
      final resp = await _dio.get(
        '${APIEndPoints.appointmentsBase}/$appointmentId/records',
        options: await _authOptions(),
      );
      return AppointmentRecordListModel.fromJson(
          Map<String, dynamic>.from(resp.data as Map));
    } on DioException catch (e) {
      debugPrint('❌ [Service] getRecords: ${e.message}');
      throw Exception(_errorMessage(e, 'Failed to load records'));
    }
  }

  // ── POST /api/appointments/{id}/records ───────────────────
  // Records use POST to create (not PATCH)
  Future<AppointmentRecordSingleModel> createRecord({
    required String appointmentId,
    required String notes,
    required String therapyPlan,
    required Map<String, dynamic> medication,
    required String progressFeedback,
  }) async {
    try {
      debugPrint('📋 [Service] POST create record: $appointmentId');
      final resp = await _dio.post(
        '${APIEndPoints.appointmentsBase}/$appointmentId/records',
        data: {
          'notes': notes,
          'therapy_plan': therapyPlan,
          'medication': medication,
          'progress_feedback': progressFeedback,
        },
        options: await _authOptions(),
      );
      return AppointmentRecordSingleModel.fromJson(
          Map<String, dynamic>.from(resp.data as Map));
    } on DioException catch (e) {
      debugPrint('❌ [Service] createRecord: ${e.message}');
      throw Exception(_errorMessage(e, 'Failed to create record'));
    }
  }

  // ── PUT /api/appointments/{id}/records/{recordId} ─────────
  Future<AppointmentRecordSingleModel> updateRecord({
    required String appointmentId,
    required String recordId,
    required String notes,
    required String therapyPlan,
    required Map<String, dynamic> medication,
    required String progressFeedback,
  }) async {
    try {
      debugPrint('📋 [Service] PUT update record: $recordId');
      final resp = await _dio.put(
        '${APIEndPoints.appointmentsBase}/$appointmentId/records/$recordId',
        data: {
          'notes': notes,
          'therapy_plan': therapyPlan,
          'medication': medication,
          'progress_feedback': progressFeedback,
        },
        options: await _authOptions(),
      );
      return AppointmentRecordSingleModel.fromJson(
          Map<String, dynamic>.from(resp.data as Map));
    } on DioException catch (e) {
      debugPrint('❌ [Service] updateRecord: ${e.message}');
      throw Exception(_errorMessage(e, 'Failed to update record'));
    }
  }
}