// lib/services/reg_child_health_service.dart
//
// Separate from your existing ChildHealthService (child_health_service.dart).
// This one is used ONLY during the registration/signup flow where we pass
// the token explicitly (SharedPreferences is not yet populated at that point).
//
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:speechspectrum/routes/app_urls.dart';
import 'package:speechspectrum/models/child_health_model.dart';

class RegChildHealthService {
  final Dio _dio = Dio();

  // ── Save health profile ───────────────────────────────────────────────────
  // POST {{baseUrl}}/api/children/health/:childId
  // Body: JSON  { blood_group, known_allergies, weight_kg, height_cm, ... }
  Future<ChildHealthModel> saveHealthProfile({
    required String childId,
    required String token,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await _dio.post(
        '${APIEndPoints.baseUrl}/api/children/health/$childId',
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      debugPrint('✅ [RegChildHealthService] Health profile saved for $childId');
      return ChildHealthModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      debugPrint('❌ [RegChildHealthService] saveHealthProfile: ${e.response?.data}');
      final msg = (e.response?.data as Map?)?['message'] as String?;
      throw Exception(msg ?? 'Failed to save health profile');
    } catch (e) {
      debugPrint('❌ [RegChildHealthService] saveHealthProfile unexpected: $e');
      throw Exception('Failed to save health profile');
    }
  }

  // ── Upload ONE medical record ─────────────────────────────────────────────
  // POST {{baseUrl}}/api/children/health/:childId/records
  // Body: multipart/form-data  { document: <file>, document_type: <string> }
  //
  // Call this once per document. If user adds 3 docs → call 3 times.
  Future<ChildHealthModel> uploadMedicalRecord({
    required String childId,
    required String token,
    required String filePath,
    required String documentType,
  }) async {
    try {
      final formData = FormData.fromMap({
        'document': await MultipartFile.fromFile(
          filePath,
          filename: filePath.split('/').last,
        ),
        'document_type': documentType,
      });

      final response = await _dio.post(
        '${APIEndPoints.baseUrl}/api/children/health/$childId/records',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            // Do NOT manually set Content-Type for multipart — Dio sets it
            // automatically with the correct boundary.
          },
        ),
      );
      debugPrint('✅ [RegChildHealthService] Medical record uploaded for $childId');
      return ChildHealthModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      debugPrint('❌ [RegChildHealthService] uploadMedicalRecord: ${e.response?.data}');
      final msg = (e.response?.data as Map?)?['message'] as String?;
      throw Exception(msg ?? 'Failed to upload medical record');
    } catch (e) {
      debugPrint('❌ [RegChildHealthService] uploadMedicalRecord unexpected: $e');
      throw Exception('Failed to upload medical record');
    }
  }
}