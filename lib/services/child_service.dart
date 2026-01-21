// lib/services/child_service.dart
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:speechspectrum/models/child_model.dart';
import 'package:speechspectrum/routes/app_urls.dart';
import 'package:speechspectrum/services/shared_preferences_service.dart';

class ChildService {
  final Dio _dio = Dio();

  // Create Child
  Future<ChildModel> createChild({
    required String childName,
    required String dateOfBirth,
    required String gender,
  }) async {
    try {
      final token = await SharedPreferencesService.getAccessToken();

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      debugPrint('🔐 Creating child with token');

      final Map<String, dynamic> data = {
        'child_name': childName,
        'date_of_birth': dateOfBirth,
        'gender': gender,
      };

      debugPrint('📤 Create child data: $data');

      final response = await _dio.post(
        APIEndPoints.children,
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      debugPrint('✅ Child created successfully');
      return ChildModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Create child error: ${e.message}');
      debugPrint('❌ Response: ${e.response?.data}');

      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized - Please login again');
      }

      throw Exception(
        e.response?.data['message'] ?? 'Failed to create child profile',
      );
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  // Get All Children
  Future<ChildrenListModel> getAllChildren() async {
    try {
      final token = await SharedPreferencesService.getAccessToken();

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      debugPrint('🔐 Fetching all children with token');

      final response = await _dio.get(
        APIEndPoints.children,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      debugPrint('✅ Children fetched successfully');
      return ChildrenListModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Fetch children error: ${e.message}');

      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized - Please login again');
      }

      throw Exception(
        e.response?.data['message'] ?? 'Failed to fetch children',
      );
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  // Get Single Child
  Future<ChildModel> getChild(String childId) async {
    try {
      final token = await SharedPreferencesService.getAccessToken();

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      debugPrint('🔐 Fetching child $childId with token');

      final response = await _dio.get(
        '${APIEndPoints.children}/$childId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      debugPrint('✅ Child fetched successfully');
      return ChildModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Fetch child error: ${e.message}');

      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized - Please login again');
      }

      throw Exception(
        e.response?.data['message'] ?? 'Failed to fetch child',
      );
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  // Update Child
  Future<ChildModel> updateChild({
    required String childId,
    required String childName,
    required String dateOfBirth,
    required String gender,
  }) async {
    try {
      final token = await SharedPreferencesService.getAccessToken();

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      debugPrint('🔐 Updating child $childId with token');

      final Map<String, dynamic> data = {
        'child_name': childName,
        'date_of_birth': dateOfBirth,
        'gender': gender,
      };

      debugPrint('📤 Update child data: $data');

      final response = await _dio.put(
        '${APIEndPoints.children}/$childId',
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      debugPrint('✅ Child updated successfully');
      return ChildModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Update child error: ${e.message}');
      debugPrint('❌ Response: ${e.response?.data}');

      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized - Please login again');
      }

      throw Exception(
        e.response?.data['message'] ?? 'Failed to update child profile',
      );
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  // Delete Child
  Future<DeleteChildResponse> deleteChild(String childId) async {
    try {
      final token = await SharedPreferencesService.getAccessToken();

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      debugPrint('🔐 Deleting child $childId with token');

      final response = await _dio.delete(
        '${APIEndPoints.children}/$childId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      debugPrint('✅ Child deleted successfully');
      return DeleteChildResponse.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Delete child error: ${e.message}');
      debugPrint('❌ Response: ${e.response?.data}');

      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized - Please login again');
      }

      final errorMessage = e.response?.data['error'] ??
          e.response?.data['message'] ??
          'Failed to delete child profile';

      throw Exception(errorMessage);
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }
}