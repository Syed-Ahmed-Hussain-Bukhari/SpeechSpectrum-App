// // lib/services/expert_consultation_service.dart
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:speechspectrum/models/expert_model.dart';
// import 'package:speechspectrum/routes/app_urls.dart';
// import 'package:speechspectrum/services/shared_preferences_service.dart';

// class ExpertConsultationService {
//   final Dio _dio = Dio();

//   // Get Expert's Consultations
//   Future<ExpertConsultationListModel> getExpertConsultations() async {
//     try {
//       final token = await SharedPreferencesService.getAccessToken();

//       if (token == null || token.isEmpty) {
//         throw Exception('No authentication token found');
//       }

//       debugPrint('🔐 Fetching expert consultations');

//       final response = await _dio.get(
//         APIEndPoints.expertConsultations,
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer $token',
//             'Content-Type': 'application/json',
//           },
//         ),
//       );

//       debugPrint('✅ Expert consultations fetched successfully');
//       return ExpertConsultationListModel.fromJson(response.data);
//     } on DioException catch (e) {
//       debugPrint('❌ Fetch expert consultations error: ${e.message}');

//       if (e.response?.statusCode == 401) {
//         throw Exception('Unauthorized - Please login again');
//       }

//       throw Exception(
//         e.response?.data['message'] ?? 'Failed to fetch consultations',
//       );
//     } catch (e) {
//       debugPrint('❌ Unexpected error: $e');
//       throw Exception('An unexpected error occurred');
//     }
//   }

//   // Respond to Consultation Request
//   Future<ConsultationResponseModel> respondToConsultation({
//     required String requestId,
//     required String status,
//     required String responseMessage,
//   }) async {
//     try {
//       final token = await SharedPreferencesService.getAccessToken();

//       if (token == null || token.isEmpty) {
//         throw Exception('No authentication token found');
//       }

//       debugPrint('🔐 Responding to consultation');

//       final data = {
//         'request_id': requestId,
//         'status': status,
//         'response_message': responseMessage,
//       };

//       debugPrint('📤 Consultation response data: $data');

//       final response = await _dio.post(
//         APIEndPoints.respondConsultation,
//         data: data,
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer $token',
//             'Content-Type': 'application/json',
//           },
//         ),
//       );

//       debugPrint('✅ Consultation response submitted successfully');
//       return ConsultationResponseModel.fromJson(response.data);
//     } on DioException catch (e) {
//       debugPrint('❌ Respond consultation error: ${e.message}');
//       debugPrint('❌ Response: ${e.response?.data}');

//       if (e.response?.statusCode == 401) {
//         throw Exception('Unauthorized - Please login again');
//       }

//       throw Exception(
//         e.response?.data['message'] ?? 'Failed to respond to consultation',
//       );
//     } catch (e) {
//       debugPrint('❌ Unexpected error: $e');
//       throw Exception('An unexpected error occurred');
//     }
//   }

//   // Create Link
//   Future<CreateLinkResponseModel> createLink({
//     required String parentUserId,
//     required String childId,
//   }) async {
//     try {
//       final token = await SharedPreferencesService.getAccessToken();

//       if (token == null || token.isEmpty) {
//         throw Exception('No authentication token found');
//       }

//       debugPrint('🔐 Creating link');

//       final data = {
//         'parent_user_id': parentUserId,
//         'child_id': childId,
//       };

//       debugPrint('📤 Create link data: $data');

//       final response = await _dio.post(
//         APIEndPoints.createLink,
//         data: data,
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer $token',
//             'Content-Type': 'application/json',
//           },
//         ),
//       );

//       debugPrint('✅ Link created successfully');
//       return CreateLinkResponseModel.fromJson(response.data);
//     } on DioException catch (e) {
//       debugPrint('❌ Create link error: ${e.message}');
//       debugPrint('❌ Response: ${e.response?.data}');

//       if (e.response?.statusCode == 401) {
//         throw Exception('Unauthorized - Please login again');
//       }

//       throw Exception(
//         e.response?.data['message'] ?? 'Failed to create link',
//       );
//     } catch (e) {
//       debugPrint('❌ Unexpected error: $e');
//       throw Exception('An unexpected error occurred');
//     }
//   }

//   // Get Expert's Linked Parents/Children
//   Future<LinkedExpertsModel> getExpertLinks() async {
//     try {
//       final token = await SharedPreferencesService.getAccessToken();

//       if (token == null || token.isEmpty) {
//         throw Exception('No authentication token found');
//       }

//       debugPrint('🔐 Fetching expert links');

//       final response = await _dio.get(
//         APIEndPoints.expertLinks,
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer $token',
//             'Content-Type': 'application/json',
//           },
//         ),
//       );

//       debugPrint('✅ Expert links fetched successfully');
//       return LinkedExpertsModel.fromJson(response.data);
//     } on DioException catch (e) {
//       debugPrint('❌ Fetch expert links error: ${e.message}');

//       if (e.response?.statusCode == 401) {
//         throw Exception('Unauthorized - Please login again');
//       }

//       throw Exception(
//         e.response?.data['message'] ?? 'Failed to fetch links',
//       );
//     } catch (e) {
//       debugPrint('❌ Unexpected error: $e');
//       throw Exception('An unexpected error occurred');
//     }
//   }
// }

// lib/services/expert_service.dart
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:speechspectrum/models/expert_model.dart';
import 'package:speechspectrum/routes/app_urls.dart';
import 'package:speechspectrum/services/shared_preferences_service.dart';

class ExpertConsultationService {
  final Dio _dio = Dio();

  // Get Expert Consultations
  Future<ExpertConsultationsModel> getExpertConsultations() async {
    try {
      final token = await SharedPreferencesService.getAccessToken();

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      debugPrint('🔐 Fetching expert consultations');

      final response = await _dio.get(
        APIEndPoints.expertConsultations,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      debugPrint('✅ Expert consultations fetched successfully');
      return ExpertConsultationsModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Fetch expert consultations error: ${e.message}');

      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized - Please login again');
      }

      throw Exception(
        e.response?.data['message'] ?? 'Failed to fetch consultations',
      );
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  // Respond to Consultation
  Future<RespondConsultationModel> respondToConsultation({
    required String requestId,
    required String status,
    required String responseMessage,
  }) async {
    try {
      final token = await SharedPreferencesService.getAccessToken();

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      debugPrint('🔐 Responding to consultation');

      final data = {
        'request_id': requestId,
        'status': status,
        'response_message': responseMessage,
      };

      debugPrint('📤 Response data: $data');

      final response = await _dio.post(
        APIEndPoints.respondConsultation,
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      debugPrint('✅ Consultation responded successfully');
      return RespondConsultationModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Respond consultation error: ${e.message}');
      debugPrint('❌ Response: ${e.response?.data}');

      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized - Please login again');
      }

      throw Exception(
        e.response?.data['message'] ?? 'Failed to respond to consultation',
      );
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  // Create Link
  Future<CreateLinkModel> createLink({
    required String parentUserId,
    required String childId,
  }) async {
    try {
      final token = await SharedPreferencesService.getAccessToken();

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      debugPrint('🔐 Creating link');

      final data = {
        'parent_user_id': parentUserId,
        'child_id': childId,
      };

      debugPrint('📤 Create link data: $data');

      final response = await _dio.post(
        APIEndPoints.createLink,
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      debugPrint('✅ Link created successfully');
      return CreateLinkModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Create link error: ${e.message}');
      debugPrint('❌ Response: ${e.response?.data}');

      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized - Please login again');
      }

      throw Exception(
        e.response?.data['message'] ?? 'Failed to create link',
      );
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  // Get Expert Linked Parents
  Future<ExpertLinkedParentsModel> getExpertLinkedParents() async {
    try {
      final token = await SharedPreferencesService.getAccessToken();

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      debugPrint('🔐 Fetching expert linked parents');

      final response = await _dio.get(
        APIEndPoints.expertLinks,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      debugPrint('✅ Expert linked parents fetched successfully');
      return ExpertLinkedParentsModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Fetch expert linked parents error: ${e.message}');

      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized - Please login again');
      }

      throw Exception(
        e.response?.data['message'] ?? 'Failed to fetch linked parents',
      );
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }
}