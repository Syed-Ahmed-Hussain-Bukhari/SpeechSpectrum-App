// // lib/services/speech_service.dart

// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:speechspectrum/models/speech_models.dart';
// import 'package:speechspectrum/routes/app_urls.dart';
// import 'package:speechspectrum/services/shared_preferences_service.dart';

// class SpeechService {
//   final Dio _dio = Dio();

//   // Get all children
//   Future<ChildrenListResponse> getChildren() async {
//     try {
//       final token = await SharedPreferencesService.getAccessToken();

//       if (token == null || token.isEmpty) {
//         throw Exception('No authentication token found');
//       }

//       debugPrint('🔐 Fetching children with token');

//       final response = await _dio.get(
//         APIEndPoints.children,
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer $token',
//             'Content-Type': 'application/json',
//           },
//         ),
//       );

//       debugPrint('✅ Children fetched successfully');
//       return ChildrenListResponse.fromJson(response.data);
//     } on DioException catch (e) {
//       debugPrint('❌ Children fetch error: ${e.message}');

//       if (e.response?.statusCode == 401) {
//         throw Exception('Unauthorized - Please login again');
//       }

//       throw Exception(
//         e.response?.data['message'] ?? 'Failed to fetch children',
//       );
//     } catch (e) {
//       debugPrint('❌ Unexpected error: $e');
//       throw Exception('An unexpected error occurred');
//     }
//   }

//   // Submit speech recording
//   Future<SpeechSubmissionResponse> submitSpeech({
//     required File audioFile,
//     required String childId,
//     required int recordingDurationSeconds,
//     required String recordingFormat,
//   }) async {
//     try {
//       final token = await SharedPreferencesService.getAccessToken();

//       if (token == null || token.isEmpty) {
//         throw Exception('No authentication token found');
//       }

//       debugPrint('🔐 Submitting speech with token');
//       debugPrint('📤 Child ID: $childId');
//       debugPrint('📤 Duration: $recordingDurationSeconds seconds');
//       debugPrint('📤 Format: $recordingFormat');

//       // Create form data
//       FormData formData = FormData.fromMap({
//         'audio': await MultipartFile.fromFile(
//           audioFile.path,
//           filename: 'speech_recording.$recordingFormat',
//         ),
//         'child_id': childId,
//         'recording_duration_seconds': recordingDurationSeconds,
//         'recording_format': recordingFormat,
//       });

//       final response = await _dio.post(
//         '${APIEndPoints.baseUrl}/api/speech',
//         data: formData,
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer $token',
//           },
//         ),
//       );

//       debugPrint('✅ Speech submitted successfully');
//       return SpeechSubmissionResponse.fromJson(response.data);
//     } on DioException catch (e) {
//       debugPrint('❌ Speech submission error: ${e.message}');
//       debugPrint('❌ Response: ${e.response?.data}');

//       if (e.response?.statusCode == 401) {
//         throw Exception('Unauthorized - Please login again');
//       }

//       throw Exception(
//         e.response?.data['message'] ?? 'Failed to submit speech',
//       );
//     } catch (e) {
//       debugPrint('❌ Unexpected error: $e');
//       throw Exception('An unexpected error occurred');
//     }
//   }

//   // Get all speech submissions
//   Future<AllSpeechSubmissionsResponse> getAllSpeechSubmissions() async {
//     try {
//       final token = await SharedPreferencesService.getAccessToken();

//       if (token == null || token.isEmpty) {
//         throw Exception('No authentication token found');
//       }

//       debugPrint('🔐 Fetching all speech submissions');

//       final response = await _dio.get(
//         '${APIEndPoints.baseUrl}/api/speech',
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer $token',
//             'Content-Type': 'application/json',
//           },
//         ),
//       );

//       debugPrint('✅ Speech submissions fetched successfully');
//       return AllSpeechSubmissionsResponse.fromJson(response.data);
//     } on DioException catch (e) {
//       debugPrint('❌ Speech submissions fetch error: ${e.message}');

//       if (e.response?.statusCode == 401) {
//         throw Exception('Unauthorized - Please login again');
//       }

//       throw Exception(
//         e.response?.data['message'] ?? 'Failed to fetch speech submissions',
//       );
//     } catch (e) {
//       debugPrint('❌ Unexpected error: $e');
//       throw Exception('An unexpected error occurred');
//     }
//   }

//   // Get single speech submission
//   Future<SpeechSubmissionResponse> getSpeechSubmission(
//       String speechSubmissionId) async {
//     try {
//       final token = await SharedPreferencesService.getAccessToken();

//       if (token == null || token.isEmpty) {
//         throw Exception('No authentication token found');
//       }

//       debugPrint('🔐 Fetching speech submission: $speechSubmissionId');

//       final response = await _dio.get(
//         '${APIEndPoints.baseUrl}/api/speech/$speechSubmissionId',
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer $token',
//             'Content-Type': 'application/json',
//           },
//         ),
//       );

//       debugPrint('✅ Speech submission fetched successfully');
//       return SpeechSubmissionResponse.fromJson(response.data);
//     } on DioException catch (e) {
//       debugPrint('❌ Speech submission fetch error: ${e.message}');

//       if (e.response?.statusCode == 401) {
//         throw Exception('Unauthorized - Please login again');
//       }

//       throw Exception(
//         e.response?.data['message'] ?? 'Failed to fetch speech submission',
//       );
//     } catch (e) {
//       debugPrint('❌ Unexpected error: $e');
//       throw Exception('An unexpected error occurred');
//     }
//   }

//   // Delete speech submission
//   Future<DeleteSpeechResponse> deleteSpeechSubmission(
//       String speechSubmissionId) async {
//     try {
//       final token = await SharedPreferencesService.getAccessToken();

//       if (token == null || token.isEmpty) {
//         throw Exception('No authentication token found');
//       }

//       debugPrint('🔐 Deleting speech submission: $speechSubmissionId');

//       final response = await _dio.delete(
//         '${APIEndPoints.baseUrl}/api/speech/$speechSubmissionId',
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer $token',
//             'Content-Type': 'application/json',
//           },
//         ),
//       );

//       debugPrint('✅ Speech submission deleted successfully');
//       return DeleteSpeechResponse.fromJson(response.data);
//     } on DioException catch (e) {
//       debugPrint('❌ Speech deletion error: ${e.message}');

//       if (e.response?.statusCode == 401) {
//         throw Exception('Unauthorized - Please login again');
//       }

//       throw Exception(
//         e.response?.data['message'] ?? 'Failed to delete speech submission',
//       );
//     } catch (e) {
//       debugPrint('❌ Unexpected error: $e');
//       throw Exception('An unexpected error occurred');
//     }
//   }
// }


// lib/services/speech_service.dart

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:speechspectrum/models/speech_models.dart';
import 'package:speechspectrum/routes/app_urls.dart';
import 'package:speechspectrum/services/shared_preferences_service.dart';

class SpeechService {
  final Dio _dio = Dio();

  // ─── Get all children ────────────────────────────────────────────────────
  Future<ChildrenListResponse> getChildren() async {
    try {
      final token = await SharedPreferencesService.getAccessToken();
      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      final response = await _dio.get(
        APIEndPoints.children,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        }),
      );

      debugPrint('✅ Children fetched successfully');
      return ChildrenListResponse.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Children fetch error: ${e.message}');
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized - Please login again');
      }
      throw Exception(
          e.response?.data['message'] ?? 'Failed to fetch children');
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  // ─── Submit speech recording ─────────────────────────────────────────────
  /// Sends audio as multipart/form-data.
  /// The file is always sent with a .wav filename so the backend recognises it.
  Future<SpeechSubmissionResponse> submitSpeech({
    required File audioFile,
    required String childId,
    required int recordingDurationSeconds,
    required String recordingFormat, // always 'wav'
  }) async {
    try {
      final token = await SharedPreferencesService.getAccessToken();
      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      debugPrint('📤 Submitting speech — child: $childId  '
          'duration: ${recordingDurationSeconds}s  format: $recordingFormat');

      // Force .wav extension so the server's ML model can parse it
      final formData = FormData.fromMap({
        'audio': await MultipartFile.fromFile(
          audioFile.path,
          filename: 'speech_recording.wav', // always wav
          contentType: DioMediaType('audio', 'wav'),
        ),
        'child_id': childId,
        'recording_duration_seconds': recordingDurationSeconds,
        'recording_format': 'wav',
      });

      final response = await _dio.post(
        '${APIEndPoints.baseUrl}/api/speech',
        data: formData,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      debugPrint('✅ Speech submitted: '
          '${response.data['data']?['speech_submission_id']}');
      return SpeechSubmissionResponse.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Speech submission error: ${e.message}');
      debugPrint('❌ Response body: ${e.response?.data}');
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized - Please login again');
      }
      throw Exception(
          e.response?.data['message'] ?? 'Failed to submit speech');
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  // ─── Get all speech submissions ──────────────────────────────────────────
  Future<AllSpeechSubmissionsResponse> getAllSpeechSubmissions() async {
    try {
      final token = await SharedPreferencesService.getAccessToken();
      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      final response = await _dio.get(
        '${APIEndPoints.baseUrl}/api/speech',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        }),
      );

      debugPrint('✅ All speech submissions fetched');
      return AllSpeechSubmissionsResponse.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Submissions fetch error: ${e.message}');
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized - Please login again');
      }
      throw Exception(e.response?.data['message'] ??
          'Failed to fetch speech submissions');
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  // ─── Get single speech submission detail ─────────────────────────────────
  Future<SingleSpeechSubmissionResponse> getSpeechSubmission(
      String speechSubmissionId) async {
    try {
      final token = await SharedPreferencesService.getAccessToken();
      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      debugPrint('🔐 Fetching speech submission: $speechSubmissionId');

      final response = await _dio.get(
        '${APIEndPoints.baseUrl}/api/speech/$speechSubmissionId',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        }),
      );

      debugPrint('✅ Single submission fetched');
      return SingleSpeechSubmissionResponse.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Submission fetch error: ${e.message}');
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized - Please login again');
      }
      throw Exception(e.response?.data['message'] ??
          'Failed to fetch speech submission');
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  // ─── Delete speech submission ─────────────────────────────────────────────
  Future<DeleteSpeechResponse> deleteSpeechSubmission(
      String speechSubmissionId) async {
    try {
      final token = await SharedPreferencesService.getAccessToken();
      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      debugPrint('🗑 Deleting speech submission: $speechSubmissionId');

      final response = await _dio.delete(
        '${APIEndPoints.baseUrl}/api/speech/$speechSubmissionId',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        }),
      );

      debugPrint('✅ Submission deleted');
      return DeleteSpeechResponse.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Delete error: ${e.message}');
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized - Please login again');
      }
      throw Exception(e.response?.data['message'] ??
          'Failed to delete speech submission');
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }
}