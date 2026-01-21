// // // lib/services/questionnaire_service.dart
// // import 'package:dio/dio.dart';
// // import 'package:flutter/foundation.dart';
// // import 'package:speechspectrum/models/questionnaire_model.dart';
// // import 'package:speechspectrum/routes/app_urls.dart';
// // import 'package:speechspectrum/services/shared_preferences_service.dart';

// // class QuestionnaireService {
// //   final Dio _dio = Dio();

// //   // Submit Questionnaire
// //   Future<QuestionnaireSubmitResponse> submitQuestionnaire({
// //     required String childId,
// //     required Map<String, dynamic> responses,
// //   }) async {
// //     try {
// //       final token = await SharedPreferencesService.getAccessToken();

// //       if (token == null || token.isEmpty) {
// //         throw Exception('No authentication token found');
// //       }

// //       debugPrint('🔐 Submitting questionnaire with token');

// //       final Map<String, dynamic> data = {
// //         'child_id': childId,
// //         'responses': responses,
// //       };

// //       debugPrint('📤 Questionnaire data: $data');

// //       final response = await _dio.post(
// //         '${APIEndPoints.baseUrl}/api/questionnaire',
// //         data: data,
// //         options: Options(
// //           headers: {
// //             'Authorization': 'Bearer $token',
// //             'Content-Type': 'application/json',
// //           },
// //         ),
// //       );

// //       debugPrint('✅ Questionnaire submitted successfully');
// //       return QuestionnaireSubmitResponse.fromJson(response.data);
// //     } on DioException catch (e) {
// //       debugPrint('❌ Submit questionnaire error: ${e.message}');
// //       debugPrint('❌ Response: ${e.response?.data}');

// //       if (e.response?.statusCode == 401) {
// //         throw Exception('Unauthorized - Please login again');
// //       }

// //       throw Exception(
// //         e.response?.data['message'] ?? 'Failed to submit questionnaire',
// //       );
// //     } catch (e) {
// //       debugPrint('❌ Unexpected error: $e');
// //       throw Exception('An unexpected error occurred');
// //     }
// //   }

// //   // Get All Submissions
// //   Future<SubmissionHistoryResponse> getAllSubmissions() async {
// //     try {
// //       final token = await SharedPreferencesService.getAccessToken();

// //       if (token == null || token.isEmpty) {
// //         throw Exception('No authentication token found');
// //       }

// //       debugPrint('🔐 Fetching all submissions with token');

// //       final response = await _dio.get(
// //         '${APIEndPoints.baseUrl}/api/questionnaire',
// //         options: Options(
// //           headers: {
// //             'Authorization': 'Bearer $token',
// //             'Content-Type': 'application/json',
// //           },
// //         ),
// //       );

// //       debugPrint('✅ Submissions fetched successfully');
// //       return SubmissionHistoryResponse.fromJson(response.data);
// //     } on DioException catch (e) {
// //       debugPrint('❌ Fetch submissions error: ${e.message}');

// //       if (e.response?.statusCode == 401) {
// //         throw Exception('Unauthorized - Please login again');
// //       }

// //       throw Exception(
// //         e.response?.data['message'] ?? 'Failed to fetch submissions',
// //       );
// //     } catch (e) {
// //       debugPrint('❌ Unexpected error: $e');
// //       throw Exception('An unexpected error occurred');
// //     }
// //   }

// //   // Get Submissions for Specific Child
// //   Future<SubmissionHistoryResponse> getChildSubmissions(String childId) async {
// //     try {
// //       final token = await SharedPreferencesService.getAccessToken();

// //       if (token == null || token.isEmpty) {
// //         throw Exception('No authentication token found');
// //       }

// //       debugPrint('🔐 Fetching submissions for child $childId');

// //       final response = await _dio.get(
// //         '${APIEndPoints.baseUrl}/api/questionnaire',
// //         queryParameters: {'child_id': childId},
// //         options: Options(
// //           headers: {
// //             'Authorization': 'Bearer $token',
// //             'Content-Type': 'application/json',
// //           },
// //         ),
// //       );

// //       debugPrint('✅ Child submissions fetched successfully');
// //       return SubmissionHistoryResponse.fromJson(response.data);
// //     } on DioException catch (e) {
// //       debugPrint('❌ Fetch child submissions error: ${e.message}');

// //       if (e.response?.statusCode == 401) {
// //         throw Exception('Unauthorized - Please login again');
// //       }

// //       throw Exception(
// //         e.response?.data['message'] ?? 'Failed to fetch child submissions',
// //       );
// //     } catch (e) {
// //       debugPrint('❌ Unexpected error: $e');
// //       throw Exception('An unexpected error occurred');
// //     }
// //   }

// //   // Get Single Submission
// //   Future<SingleSubmissionResponse> getSingleSubmission(
// //       String submissionId) async {
// //     try {
// //       final token = await SharedPreferencesService.getAccessToken();

// //       if (token == null || token.isEmpty) {
// //         throw Exception('No authentication token found');
// //       }

// //       debugPrint('🔐 Fetching submission $submissionId');

// //       final response = await _dio.get(
// //         '${APIEndPoints.baseUrl}/api/questionnaire/$submissionId',
// //         options: Options(
// //           headers: {
// //             'Authorization': 'Bearer $token',
// //             'Content-Type': 'application/json',
// //           },
// //         ),
// //       );

// //       debugPrint('✅ Submission fetched successfully');
// //       return SingleSubmissionResponse.fromJson(response.data);
// //     } on DioException catch (e) {
// //       debugPrint('❌ Fetch submission error: ${e.message}');

// //       if (e.response?.statusCode == 401) {
// //         throw Exception('Unauthorized - Please login again');
// //       }

// //       throw Exception(
// //         e.response?.data['message'] ?? 'Failed to fetch submission',
// //       );
// //     } catch (e) {
// //       debugPrint('❌ Unexpected error: $e');
// //       throw Exception('An unexpected error occurred');
// //     }
// //   }

// //   // Delete Submission
// //   Future<DeleteSubmissionResponse> deleteSubmission(
// //       String submissionId) async {
// //     try {
// //       final token = await SharedPreferencesService.getAccessToken();

// //       if (token == null || token.isEmpty) {
// //         throw Exception('No authentication token found');
// //       }

// //       debugPrint('🔐 Deleting submission $submissionId');

// //       final response = await _dio.delete(
// //         '${APIEndPoints.baseUrl}/api/questionnaire/$submissionId',
// //         options: Options(
// //           headers: {
// //             'Authorization': 'Bearer $token',
// //             'Content-Type': 'application/json',
// //           },
// //         ),
// //       );

// //       debugPrint('✅ Submission deleted successfully');
// //       return DeleteSubmissionResponse.fromJson(response.data);
// //     } on DioException catch (e) {
// //       debugPrint('❌ Delete submission error: ${e.message}');

// //       if (e.response?.statusCode == 401) {
// //         throw Exception('Unauthorized - Please login again');
// //       }

// //       throw Exception(
// //         e.response?.data['message'] ?? 'Failed to delete submission',
// //       );
// //     } catch (e) {
// //       debugPrint('❌ Unexpected error: $e');
// //       throw Exception('An unexpected error occurred');
// //     }
// //   }
// // }


// // lib/services/questionnaire_service.dart
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:speechspectrum/models/questionnaire_model.dart';
// import 'package:speechspectrum/routes/app_urls.dart';
// import 'package:speechspectrum/services/shared_preferences_service.dart';

// class QuestionnaireService {
//   final Dio _dio = Dio();

//   // Submit Questionnaire
//   Future<QuestionnaireResultModel> submitQuestionnaire({
//     required String childId,
//     required Map<String, int> responses,
//     required int ageMonths,
//     required int sex,
//     required int familyMemWithASD,
//     required int jaundice,
//   }) async {
//     try {
//       final token = await SharedPreferencesService.getAccessToken();

//       if (token == null || token.isEmpty) {
//         throw Exception('No authentication token found');
//       }

//       debugPrint('🔐 Submitting questionnaire with token');

//       final Map<String, dynamic> data = {
//         'child_id': childId,
//         'responses': {
//           ...responses,
//           'Age_Mons': ageMonths,
//           'Sex': sex,
//           'Family_mem_with_ASD': familyMemWithASD,
//           'Jaundice': jaundice,
//         },
//       };

//       debugPrint('📤 Questionnaire data: $data');

//       final response = await _dio.post(
//         APIEndPoints.questionnaire,
//         data: data,
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer $token',
//             'Content-Type': 'application/json',
//           },
//         ),
//       );

//       debugPrint('✅ Questionnaire submitted successfully');
//       return QuestionnaireResultModel.fromJson(response.data);
//     } on DioException catch (e) {
//       debugPrint('❌ Submit questionnaire error: ${e.message}');
//       debugPrint('❌ Response: ${e.response?.data}');

//       if (e.response?.statusCode == 401) {
//         throw Exception('Unauthorized - Please login again');
//       }

//       throw Exception(
//         e.response?.data['message'] ?? 'Failed to submit questionnaire',
//       );
//     } catch (e) {
//       debugPrint('❌ Unexpected error: $e');
//       throw Exception('An unexpected error occurred');
//     }
//   }
// }


// lib/services/questionnaire_service.dart
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:speechspectrum/models/questionnaire_model.dart';
import 'package:speechspectrum/routes/app_urls.dart';
import 'package:speechspectrum/services/shared_preferences_service.dart';

class QuestionnaireService {
  final Dio _dio = Dio();

  // Get All Submissions
  Future<SubmissionsListModel> getAllSubmissions() async {
    try {
      final token = await SharedPreferencesService.getAccessToken();

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      debugPrint('🔐 Fetching all submissions with token');

      final response = await _dio.get(
        APIEndPoints.questionnaire,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      debugPrint('✅ Submissions fetched successfully');
      return SubmissionsListModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Fetch submissions error: ${e.message}');

      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized - Please login again');
      }

      throw Exception(
        e.response?.data['message'] ?? 'Failed to fetch submissions',
      );
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  // Get Submissions by Child ID
  Future<SubmissionsListModel> getSubmissionsByChildId(String childId) async {
    try {
      final token = await SharedPreferencesService.getAccessToken();

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      debugPrint('🔐 Fetching submissions for child $childId');

      final response = await _dio.get(
        '${APIEndPoints.questionnaire}?child_id=$childId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      debugPrint('✅ Child submissions fetched successfully');
      return SubmissionsListModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Fetch child submissions error: ${e.message}');

      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized - Please login again');
      }

      throw Exception(
        e.response?.data['message'] ?? 'Failed to fetch submissions',
      );
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  // Get Single Submission
  Future<SingleSubmissionModel> getSubmission(String submissionId) async {
    try {
      final token = await SharedPreferencesService.getAccessToken();

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      debugPrint('🔐 Fetching submission $submissionId');

      final response = await _dio.get(
        '${APIEndPoints.questionnaire}/$submissionId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      debugPrint('✅ Submission fetched successfully');
      return SingleSubmissionModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Fetch submission error: ${e.message}');

      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized - Please login again');
      }

      throw Exception(
        e.response?.data['message'] ?? 'Failed to fetch submission',
      );
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  // Delete Submission
  Future<DeleteSubmissionResponse> deleteSubmission(String submissionId) async {
    try {
      final token = await SharedPreferencesService.getAccessToken();

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      debugPrint('🔐 Deleting submission $submissionId');

      final response = await _dio.delete(
        '${APIEndPoints.questionnaire}/$submissionId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      debugPrint('✅ Submission deleted successfully');
      return DeleteSubmissionResponse.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Delete submission error: ${e.message}');

      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized - Please login again');
      }

      throw Exception(
        e.response?.data['message'] ?? 'Failed to delete submission',
      );
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  // Submit Questionnaire
  Future<QuestionnaireResultModel> submitQuestionnaire({
    required String childId,
    required Map<String, int> responses,
    required int ageMonths,
    required int sex,
    required int familyMemWithASD,
    required int jaundice,
  }) async {
    try {
      final token = await SharedPreferencesService.getAccessToken();

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      debugPrint('🔐 Submitting questionnaire with token');

      final Map<String, dynamic> data = {
        'child_id': childId,
        'responses': {
          ...responses,
          'Age_Mons': ageMonths,
          'Sex': sex,
          'Family_mem_with_ASD': familyMemWithASD,
          'Jaundice': jaundice,
        },
      };

      debugPrint('📤 Questionnaire data: $data');

      final response = await _dio.post(
        APIEndPoints.questionnaire,
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      debugPrint('✅ Questionnaire submitted successfully');
      return QuestionnaireResultModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Submit questionnaire error: ${e.message}');
      debugPrint('❌ Response: ${e.response?.data}');

      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized - Please login again');
      }

      throw Exception(
        e.response?.data['message'] ?? 'Failed to submit questionnaire',
      );
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }
}