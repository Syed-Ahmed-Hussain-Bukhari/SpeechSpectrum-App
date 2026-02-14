// lib/services/expert_service.dart
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:speechspectrum/models/parent_expert_model.dart';
import 'package:speechspectrum/routes/app_urls.dart';
import 'package:speechspectrum/services/shared_preferences_service.dart';

class ExpertService {
  final Dio _dio = Dio();

  // Get All Experts
  Future<ExpertListModel> getAllExperts({
    int page = 1,
    int limit = 10,
    String? specialization,
  }) async {
    try {
      final token = await SharedPreferencesService.getAccessToken();

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      debugPrint('🔐 Fetching experts with token');

      // Build query parameters
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
      };

      if (specialization != null && specialization.isNotEmpty) {
        queryParams['specialization'] = specialization;
      }

      final response = await _dio.get(
        APIEndPoints.experts,
        queryParameters: queryParams,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      debugPrint('✅ Experts fetched successfully');
      return ExpertListModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Fetch experts error: ${e.message}');

      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized - Please login again');
      }

      throw Exception(
        e.response?.data['message'] ?? 'Failed to fetch experts',
      );
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  // Request Consultation
  Future<ConsultationRequestModel> requestConsultation({
    required String expertId,
    required String childId,
  }) async {
    try {
      final token = await SharedPreferencesService.getAccessToken();

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      debugPrint('🔐 Requesting consultation');

      final data = {
        'expert_id': expertId,
        'child_id': childId,
      };

      debugPrint('📤 Consultation request data: $data');

      final response = await _dio.post(
        APIEndPoints.consultations,
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      debugPrint('✅ Consultation requested successfully');
      return ConsultationRequestModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Request consultation error: ${e.message}');
      debugPrint('❌ Response: ${e.response?.data}');

      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized - Please login again');
      }

      // Handle specific error messages
      final errorMessage = e.response?.data['message'];
      if (errorMessage != null && errorMessage.toString().contains('already')) {
        throw Exception(errorMessage);
      }

      throw Exception(
        e.response?.data['message'] ?? 'Failed to request consultation',
      );
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  // Get Parent Consultations
  Future<ConsultationListModel> getParentConsultations() async {
    try {
      final token = await SharedPreferencesService.getAccessToken();

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      debugPrint('🔐 Fetching parent consultations');

      final response = await _dio.get(
        APIEndPoints.parentConsultations,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      debugPrint('✅ Consultations fetched successfully');
      return ConsultationListModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Fetch consultations error: ${e.message}');

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

  // Get Linked Experts
  Future<LinkedExpertsModel> getLinkedExperts() async {
    try {
      final token = await SharedPreferencesService.getAccessToken();

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      debugPrint('🔐 Fetching linked experts');

      final response = await _dio.get(
        APIEndPoints.parentLinks,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      debugPrint('✅ Linked experts fetched successfully');
      return LinkedExpertsModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Fetch linked experts error: ${e.message}');

      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized - Please login again');
      }

      throw Exception(
        e.response?.data['message'] ?? 'Failed to fetch linked experts',
      );
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }
}