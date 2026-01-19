// // lib/services/profile_service.dart
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:speechspectrum/models/profile_model.dart';
// import 'package:speechspectrum/routes/app_urls.dart';
// import 'package:speechspectrum/services/shared_preferences_service.dart';

// class ProfileService {
//   final Dio _dio = Dio();

//   Future<ProfileModel> getProfile() async {
//     try {
//       final token = await SharedPreferencesService.getAccessToken();

//       if (token == null || token.isEmpty) {
//         throw Exception('No authentication token found');
//       }

//       debugPrint('🔐 Fetching profile with token');

//       final response = await _dio.get(
//         APIEndPoints.profile,
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer $token',
//             'Content-Type': 'application/json',
//           },
//         ),
//       );

//       debugPrint('✅ Profile fetched successfully');
//       return ProfileModel.fromJson(response.data);
      
//     } on DioException catch (e) {
//       debugPrint('❌ Profile fetch error: ${e.message}');
      
//       if (e.response?.statusCode == 401) {
//         throw Exception('Unauthorized - Please login again');
//       }
      
//       throw Exception(
//         e.response?.data['message'] ?? 'Failed to fetch profile',
//       );
//     } catch (e) {
//       debugPrint('❌ Unexpected error: $e');
//       throw Exception('An unexpected error occurred');
//     }
//   }

//   Future<ProfileModel> updateProfile({
//     required String fullName,
//     required String phone,
//     String? specialization,
//     String? organization,
//     String? contactEmail,
//   }) async {
//     try {
//       final token = await SharedPreferencesService.getAccessToken();

//       if (token == null || token.isEmpty) {
//         throw Exception('No authentication token found');
//       }

//       debugPrint('🔐 Updating profile with token');

//       final Map<String, dynamic> data = {
//         'full_name': fullName,
//         'phone': phone,
//       };

//       // Add expert-specific fields if provided
//       if (specialization != null) data['specialization'] = specialization;
//       if (organization != null) data['organization'] = organization;
//       if (contactEmail != null) data['contact_email'] = contactEmail;

//       final response = await _dio.put(
//         APIEndPoints.updateProfile,
//         data: data,
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer $token',
//             'Content-Type': 'application/json',
//           },
//         ),
//       );

//       debugPrint('✅ Profile updated successfully');
//       return ProfileModel.fromJson(response.data);
      
//     } on DioException catch (e) {
//       debugPrint('❌ Profile update error: ${e.message}');
      
//       if (e.response?.statusCode == 401) {
//         throw Exception('Unauthorized - Please login again');
//       }
      
//       throw Exception(
//         e.response?.data['message'] ?? 'Failed to update profile',
//       );
//     } catch (e) {
//       debugPrint('❌ Unexpected error: $e');
//       throw Exception('An unexpected error occurred');
//     }
//   }
// }


// lib/services/profile_service.dart
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:speechspectrum/models/profile_model.dart';
import 'package:speechspectrum/routes/app_urls.dart';
import 'package:speechspectrum/services/shared_preferences_service.dart';

class ProfileService {
  final Dio _dio = Dio();

  Future<ProfileModel> getProfile() async {
    try {
      final token = await SharedPreferencesService.getAccessToken();

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      debugPrint('🔐 Fetching profile with token');

      final response = await _dio.get(
        APIEndPoints.profile,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      debugPrint('✅ Profile fetched successfully');
      return ProfileModel.fromJson(response.data);
      
    } on DioException catch (e) {
      debugPrint('❌ Profile fetch error: ${e.message}');
      
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized - Please login again');
      }
      
      throw Exception(
        e.response?.data['message'] ?? 'Failed to fetch profile',
      );
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  Future<UpdateProfileResponse> updateProfile({
    required String fullName,
    required String phone,
    String? specialization,
    String? organization,
    String? contactEmail,
  }) async {
    try {
      final token = await SharedPreferencesService.getAccessToken();

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      debugPrint('🔐 Updating profile with token');

      final Map<String, dynamic> data = {
        'full_name': fullName,
        'phone': phone,
      };

      // Add expert-specific fields if provided and not empty
      if (specialization != null && specialization.isNotEmpty) {
        data['specialization'] = specialization;
      }
      if (organization != null && organization.isNotEmpty) {
        data['organization'] = organization;
      }
      if (contactEmail != null && contactEmail.isNotEmpty) {
        data['contact_email'] = contactEmail;
      }

      debugPrint('📤 Update data: $data');

      final response = await _dio.put(
        APIEndPoints.updateProfile,
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      debugPrint('✅ Profile updated successfully');
      return UpdateProfileResponse.fromJson(response.data);
      
    } on DioException catch (e) {
      debugPrint('❌ Profile update error: ${e.message}');
      debugPrint('❌ Response: ${e.response?.data}');
      
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized - Please login again');
      }
      
      throw Exception(
        e.response?.data['message'] ?? 'Failed to update profile',
      );
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  Future<DeleteProfileResponse> deleteProfile() async {
    try {
      final token = await SharedPreferencesService.getAccessToken();

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      debugPrint('🔐 Deleting profile with token');

      final response = await _dio.delete(
        APIEndPoints.deleteProfile,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      debugPrint('✅ Profile deleted successfully');
      
      // Clear local data after successful deletion
      await SharedPreferencesService.clearUserData();
      
      return DeleteProfileResponse.fromJson(response.data);
      
    } on DioException catch (e) {
      debugPrint('❌ Profile deletion error: ${e.message}');
      debugPrint('❌ Response: ${e.response?.data}');
      
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized - Please login again');
      }
      
      // Check if there's an error message in response
      final errorMessage = e.response?.data['error'] ?? 
                          e.response?.data['message'] ?? 
                          'Failed to delete profile';
      
      throw Exception(errorMessage);
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }
}