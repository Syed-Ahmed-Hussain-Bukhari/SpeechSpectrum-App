// lib/services/child_profile_service.dart
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:speechspectrum/models/child_profile_model.dart';
import 'package:speechspectrum/routes/app_urls.dart';
import 'package:speechspectrum/services/shared_preferences_service.dart';

class ChildProfileService {
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
          return 'You do not have permission to view this profile.';
        case 404:
          return 'Child profile not found.';
        default:
          return fallback;
      }
    }
    return fallback;
  }

  // GET /api/children/:childId
  Future<ChildProfileModel> getChildProfile(String childId) async {
    try {
      debugPrint('👶 [Service] GET child profile: $childId');
      final resp = await _dio.get(
        APIEndPoints.child(childId),
        options: await _authOptions(),
      );
      return ChildProfileModel.fromJson(
          Map<String, dynamic>.from(resp.data as Map));
    } on DioException catch (e) {
      debugPrint('❌ [Service] getChildProfile: ${e.message}');
      throw Exception(_errorMessage(e, 'Failed to load child profile'));
    }
  }

  // GET /api/children/health/:childId
  Future<ChildHealthModel> getChildHealth(String childId) async {
    try {
      debugPrint('🏥 [Service] GET child health: $childId');
      final resp = await _dio.get(
        APIEndPoints.childHealth(childId),
        options: await _authOptions(),
      );
      return ChildHealthModel.fromJson(
          Map<String, dynamic>.from(resp.data as Map));
    } on DioException catch (e) {
      debugPrint('❌ [Service] getChildHealth: ${e.message}');
      throw Exception(_errorMessage(e, 'Failed to load health profile'));
    }
  }
}