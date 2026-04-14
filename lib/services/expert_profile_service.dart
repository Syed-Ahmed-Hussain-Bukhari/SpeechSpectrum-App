// lib/services/expert_profile_service.dart
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:speechspectrum/models/expert_profile_model.dart';
import 'package:speechspectrum/routes/app_urls.dart';
import 'package:speechspectrum/services/shared_preferences_service.dart';

class ExpertProfileService {
  final Dio _dio = Dio();

  // ── GET /api/user/profile ──────────────────────────────────────
  Future<ExpertProfileModel> getProfile() async {
    try {
      final token = await SharedPreferencesService.getAccessToken();
      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      debugPrint('🔐 [Expert] Fetching profile');

      final response = await _dio.get(
        APIEndPoints.profile,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        }),
      );

      debugPrint('✅ [Expert] Profile fetched');
      return ExpertProfileModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ [Expert] Profile fetch error: ${e.message}');
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized - Please login again');
      }
      throw Exception(
          e.response?.data['message'] ?? 'Failed to fetch profile');
    } catch (e) {
      debugPrint('❌ [Expert] Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  // ── PUT /api/user/profile ──────────────────────────────────────
  Future<ExpertUpdateProfileResponse> updateProfile({
    String? fullName,
    String? specialization,
    String? organization,
    String? contactEmail,
    String? phone,
  }) async {
    try {
      final token = await SharedPreferencesService.getAccessToken();
      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      final Map<String, dynamic> data = {};
      if (fullName != null && fullName.isNotEmpty) data['full_name'] = fullName;
      if (specialization != null && specialization.isNotEmpty) {
        data['specialization'] = specialization;
      }
      if (organization != null && organization.isNotEmpty) {
        data['organization'] = organization;
      }
      if (contactEmail != null && contactEmail.isNotEmpty) {
        data['contact_email'] = contactEmail;
      }
      if (phone != null && phone.isNotEmpty) data['phone'] = phone;

      debugPrint('📤 [Expert] Update data: $data');

      final response = await _dio.put(
        APIEndPoints.updateProfile,
        data: data,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        }),
      );

      debugPrint('✅ [Expert] Profile updated');
      return ExpertUpdateProfileResponse.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ [Expert] Profile update error: ${e.response?.data}');
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized - Please login again');
      }
      throw Exception(
          e.response?.data['message'] ?? 'Failed to update profile');
    } catch (e) {
      debugPrint('❌ [Expert] Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  // ── DELETE /api/user/profile ───────────────────────────────────
  Future<ExpertDeleteProfileResponse> deleteProfile() async {
    try {
      final token = await SharedPreferencesService.getAccessToken();
      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      debugPrint('🔐 [Expert] Deleting profile');

      final response = await _dio.delete(
        APIEndPoints.deleteProfile,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        }),
      );

      debugPrint('✅ [Expert] Profile deleted');
      await SharedPreferencesService.clearUserData();
      return ExpertDeleteProfileResponse.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ [Expert] Profile deletion error: ${e.response?.data}');
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized - Please login again');
      }
      final errorMessage = e.response?.data['error'] ??
          e.response?.data['message'] ??
          'Failed to delete profile';
      throw Exception(errorMessage);
    } catch (e) {
      debugPrint('❌ [Expert] Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }
}