// lib/services/child_health_service.dart
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:speechspectrum/models/child_health_model.dart';
import 'package:speechspectrum/routes/app_urls.dart';
import 'package:speechspectrum/services/shared_preferences_service.dart';

class ChildHealthService {
  final Dio _dio = Dio();

  Future<Options> _authOptions() async {
    final token = await SharedPreferencesService.getAccessToken();
    if (token == null || token.isEmpty) throw Exception('No authentication token found');
    return Options(headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'});
  }

  // ─── Save / Update Health Profile (POST = create, PUT = update) ───────────
  Future<ChildHealthModel> saveHealthProfile({
    required String childId,
    required Map<String, dynamic> data,
    bool isUpdate = false,
  }) async {
    try {
      final token = await SharedPreferencesService.getAccessToken();
      if (token == null || token.isEmpty) throw Exception('No authentication token found');

      debugPrint('${isUpdate ? '🔄 Updating' : '➕ Creating'} health profile for $childId');

      final response = isUpdate
          ? await _dio.put(
              '${APIEndPoints.baseUrl}/api/children/health/$childId',
              data: data,
              options: Options(headers: {
                'Authorization': 'Bearer $token',
                'Content-Type': 'application/json',
              }),
            )
          : await _dio.post(
              '${APIEndPoints.baseUrl}/api/children/health/$childId',
              data: data,
              options: Options(headers: {
                'Authorization': 'Bearer $token',
                'Content-Type': 'application/json',
              }),
            );

      debugPrint('✅ Health profile saved');
      return ChildHealthModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Health profile error: ${e.message}');
      throw Exception(e.response?.data['message'] ?? 'Failed to save health profile');
    }
  }

  // ─── Get Health Profile ───────────────────────────────────────────────────
  Future<ChildHealthModel> getHealthProfile(String childId) async {
    try {
      final token = await SharedPreferencesService.getAccessToken();
      if (token == null || token.isEmpty) throw Exception('No authentication token found');

      final response = await _dio.get(
        '${APIEndPoints.baseUrl}/api/children/health/$childId',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        }),
      );

      return ChildHealthModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Get health profile error: ${e.message} | status: ${e.response?.statusCode}');
      if (e.response?.statusCode == 404) {
        // No health profile yet — return empty model
        return ChildHealthModel(message: 'Not found', data: null, status: false);
      }
      throw Exception(e.response?.data['message'] ?? 'Failed to fetch health profile');
    }
  }

  // ─── Upload Medical Record ────────────────────────────────────────────────
  Future<ChildHealthModel> uploadMedicalRecord({
    required String childId,
    required String filePath,
    required String documentType,
  }) async {
    try {
      final token = await SharedPreferencesService.getAccessToken();
      if (token == null || token.isEmpty) throw Exception('No authentication token found');

      debugPrint('📎 Uploading medical record for $childId | type: $documentType');

      final formData = FormData.fromMap({
        'document': await MultipartFile.fromFile(filePath),
        'document_type': documentType,
      });

      final response = await _dio.post(
        '${APIEndPoints.baseUrl}/api/children/health/$childId/records',
        data: formData,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      debugPrint('✅ Medical record uploaded');
      return ChildHealthModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Upload record error: ${e.message}');
      throw Exception(e.response?.data['message'] ?? 'Failed to upload medical record');
    }
  }

  // ─── Update Medical Record ────────────────────────────────────────────────
  Future<ChildHealthModel> updateMedicalRecord({
    required String childId,
    required String documentId,
    required String filePath,
    required String documentType,
  }) async {
    try {
      final token = await SharedPreferencesService.getAccessToken();
      if (token == null || token.isEmpty) throw Exception('No authentication token found');

      final formData = FormData.fromMap({
        'document': await MultipartFile.fromFile(filePath),
        'document_type': documentType,
      });

      final response = await _dio.put(
        '${APIEndPoints.baseUrl}/api/children/health/$childId/records/$documentId',
        data: formData,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return ChildHealthModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Update record error: ${e.message}');
      throw Exception(e.response?.data['message'] ?? 'Failed to update medical record');
    }
  }

  // ─── Delete Medical Record ────────────────────────────────────────────────
  Future<DeleteRecordResponse> deleteMedicalRecord(String documentId) async {
    try {
      final token = await SharedPreferencesService.getAccessToken();
      if (token == null || token.isEmpty) throw Exception('No authentication token found');

      debugPrint('🗑️ Deleting medical record $documentId');

      final response = await _dio.delete(
        '${APIEndPoints.baseUrl}/api/children/health/$documentId/records',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        }),
      );

      return DeleteRecordResponse.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Delete record error: ${e.message}');
      throw Exception(e.response?.data['message'] ?? 'Failed to delete medical record');
    }
  }
}