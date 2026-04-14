// // lib/services/payment_service.dart
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:speechspectrum/models/payment_model.dart';
// import 'package:speechspectrum/routes/app_urls.dart';
// import 'package:speechspectrum/services/shared_preferences_service.dart';

// class PaymentService {
//   final Dio _dio = Dio();

//   Future<Options> _auth() async {
//     final token = await SharedPreferencesService.getAccessToken();
//     if (token == null || token.isEmpty) {
//       throw Exception('No authentication token found');
//     }
//     return Options(headers: {
//       'Authorization': 'Bearer $token',
//       'Content-Type': 'application/json',
//     });
//   }

//   // POST /api/payments/initiate
//   Future<InitiatePaymentModel> initiatePayment({
//     required String appointmentId,
//     required String redirectUrl,
//     required String cancelUrl,
//   }) async {
//     try {
//       debugPrint('💳 Initiating payment for appointment: $appointmentId');
//       final response = await _dio.post(
//         APIEndPoints.paymentsInitiate,
//         data: {
//           'appointment_id': appointmentId,
//           'redirect_url': redirectUrl,
//           'cancel_url': cancelUrl,
//         },
//         options: await _auth(),
//       );
//       debugPrint('✅ Payment initiated: ${response.data}');
//       return InitiatePaymentModel.fromJson(response.data);
//     } on DioException catch (e) {
//       debugPrint('❌ Initiate payment error: ${e.response?.data}');
//       if (e.response?.statusCode == 401) {
//         throw Exception('Unauthorized - Please login again');
//       }
//       throw Exception(
//           e.response?.data['message'] ?? 'Failed to initiate payment');
//     }
//   }

//   // POST /api/payments/verify
//   Future<VerifyPaymentModel> verifyPayment({
//     required String tracker,
//     String? sig,
//   }) async {
//     try {
//       debugPrint('🔍 Verifying payment tracker: $tracker');
//       final body = <String, dynamic>{'tracker': tracker};
//       if (sig != null && sig.isNotEmpty) body['sig'] = sig;

//       final response = await _dio.post(
//         APIEndPoints.paymentsVerify,
//         data: body,
//         options: await _auth(),
//       );
//       debugPrint('✅ Payment verified: ${response.data}');
//       return VerifyPaymentModel.fromJson(response.data);
//     } on DioException catch (e) {
//       debugPrint('❌ Verify payment error: ${e.response?.data}');
//       if (e.response?.statusCode == 401) {
//         throw Exception('Unauthorized - Please login again');
//       }
//       throw Exception(
//           e.response?.data['message'] ?? 'Failed to verify payment');
//     }
//   }

//   // GET /api/payments/status?appointment_id=
//   Future<PaymentStatusModel> getPaymentStatus({
//     required String appointmentId,
//   }) async {
//     try {
//       debugPrint('📊 Fetching payment status for: $appointmentId');
//       final response = await _dio.get(
//         APIEndPoints.paymentsStatus,
//         queryParameters: {'appointment_id': appointmentId},
//         options: await _auth(),
//       );
//       debugPrint('✅ Payment status: ${response.data}');
//       return PaymentStatusModel.fromJson(response.data);
//     } on DioException catch (e) {
//       debugPrint('❌ Payment status error: ${e.response?.data}');
//       if (e.response?.statusCode == 401) {
//         throw Exception('Unauthorized - Please login again');
//       }
//       throw Exception(
//           e.response?.data['message'] ?? 'Failed to fetch payment status');
//     }
//   }
// }

// lib/services/payment_service.dart
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:speechspectrum/models/payment_model.dart';
import 'package:speechspectrum/routes/app_urls.dart';
import 'package:speechspectrum/services/shared_preferences_service.dart';

class PaymentService {
  final Dio _dio = Dio();

  Future<Options> _auth() async {
    final token = await SharedPreferencesService.getAccessToken();
    if (token == null || token.isEmpty) {
      throw Exception('No authentication token found');
    }
    return Options(headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    });
  }

  // POST /api/payments/initiate
  Future<InitiatePaymentModel> initiatePayment({
    required String appointmentId,
    required String redirectUrl,
    required String cancelUrl,
  }) async {
    try {
      debugPrint('💳 Initiating payment for appointment: $appointmentId');
      final response = await _dio.post(
        APIEndPoints.paymentsInitiate,
        data: {
          'appointment_id': appointmentId,
          'redirect_url': redirectUrl,
          'cancel_url': cancelUrl,
        },
        options: await _auth(),
      );
      debugPrint('✅ Payment initiated: ${response.data}');
      return InitiatePaymentModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Initiate payment error: ${e.response?.data}');
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized - Please login again');
      }
      throw Exception(
          e.response?.data['message'] ?? 'Failed to initiate payment');
    }
  }

  // POST /api/payments/verify
  Future<VerifyPaymentModel> verifyPayment({
    required String tracker,
    String? sig,
  }) async {
    try {
      debugPrint('🔍 Verifying payment tracker: $tracker');
      final body = <String, dynamic>{'tracker': tracker};
      if (sig != null && sig.isNotEmpty) body['sig'] = sig;

      final response = await _dio.post(
        APIEndPoints.paymentsVerify,
        data: body,
        options: await _auth(),
      );
      debugPrint('✅ Payment verified: ${response.data}');
      return VerifyPaymentModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Verify payment error: ${e.response?.data}');
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized - Please login again');
      }
      throw Exception(
          e.response?.data['message'] ?? 'Failed to verify payment');
    }
  }

  // GET /api/payments/status?appointment_id=
  Future<PaymentStatusModel> getPaymentStatus({
    required String appointmentId,
  }) async {
    try {
      debugPrint('📊 Fetching payment status for: $appointmentId');
      final response = await _dio.get(
        APIEndPoints.paymentsStatus,
        queryParameters: {'appointment_id': appointmentId},
        options: await _auth(),
      );
      debugPrint('✅ Payment status: ${response.data}');
      return PaymentStatusModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Payment status error: ${e.response?.data}');
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized - Please login again');
      }
      throw Exception(
          e.response?.data['message'] ?? 'Failed to fetch payment status');
    }
  }
}