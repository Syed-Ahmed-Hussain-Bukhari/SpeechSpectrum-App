// // lib/services/speech_service.dart

// import 'package:get/get.dart';
// import '../models/parent_speech_model.dart';
// import '../utils/api_constants.dart'; // adjust import to your project

// class ParentParentSpeechService extends GetConnect {
//   // ─── GET ALL SPEECHES BY SUBMISSION ID ───────────────────────────────────────
//   // Calls: GET {{baseURL}}/api/speech?submissionId=xxx
//   // or    GET {{baseURL}}/api/speech (filtered by submissionId in query)
//   Future<List<ParentSpeechModel>> getSpeechesBySubmissionId(
//       String submissionId) async {
//     try {
//       // Try query param approach first
//       final response = await get(
//         '${ApiConstants.baseUrl}/api/speech',
//         query: {'submissionId': submissionId},
//         headers: await _authHeaders(),
//       );

//       if (response.statusCode == 200 && response.body != null) {
//         final body = response.body;

//         List<dynamic> list = [];

//         if (body is List) {
//           list = body;
//         } else if (body is Map) {
//           // Handle wrapped response: { data: [...] } or { speeches: [...] }
//           list = body['data'] ??
//               body['speeches'] ??
//               body['results'] ??
//               body['recordings'] ??
//               [];
//         }

//         return list
//             .map((e) => ParentSpeechModel.fromJson(e as Map<String, dynamic>))
//             .where(
//               (s) =>
//                   s.submissionId == submissionId ||
//                   s.submissionId == null, // include if backend already filtered
//             )
//             .toList();
//       }

//       return [];
//     } catch (e) {
//       print('ParentSpeechService.getSpeechesBySubmissionId error: $e');
//       return [];
//     }
//   }

//   // ─── GET ALL RECORDINGS (no filter) ─────────────────────────────────────────
//   // Calls: GET {{baseURL}}/api/speech
//   Future<List<ParentSpeechModel>> getAllSpeeches() async {
//     try {
//       final response = await get(
//         '${ApiConstants.baseUrl}/api/speech',
//         headers: await _authHeaders(),
//       );

//       if (response.statusCode == 200 && response.body != null) {
//         final body = response.body;
//         List<dynamic> list = [];

//         if (body is List) {
//           list = body;
//         } else if (body is Map) {
//           list = body['data'] ??
//               body['speeches'] ??
//               body['results'] ??
//               body['recordings'] ??
//               [];
//         }

//         return list
//             .map((e) => ParentSpeechModel.fromJson(e as Map<String, dynamic>))
//             .toList();
//       }

//       return [];
//     } catch (e) {
//       print('ParentSpeechService.getAllSpeeches error: $e');
//       return [];
//     }
//   }

//   // ─── GET SINGLE SPEECH DETAIL ────────────────────────────────────────────────
//   // Calls: GET {{baseURL}}/api/speech/:id
//   Future<ParentSpeechModel?> getSpeechById(String speechId) async {
//     try {
//       final response = await get(
//         '${ApiConstants.baseUrl}/api/speech/$speechId',
//         headers: await _authHeaders(),
//       );

//       if (response.statusCode == 200 && response.body != null) {
//         final body = response.body;
//         if (body is Map) {
//           final data = body['data'] ?? body['speech'] ?? body;
//           return ParentSpeechModel.fromJson(data as Map<String, dynamic>);
//         }
//       }

//       return null;
//     } catch (e) {
//       print('ParentSpeechService.getSpeechById error: $e');
//       return null;
//     }
//   }

//   // ─── AUTH HEADERS ─────────────────────────────────────────────────────────────
//   Future<Map<String, String>> _authHeaders() async {
//     // Replace with your actual token retrieval
//     // e.g. from SharedPreferences, GetStorage, or a UserController
//     final token = _getStoredToken();
//     return {
//       'Content-Type': 'application/json',
//       if (token != null) 'Authorization': 'Bearer $token',
//     };
//   }

//   String? _getStoredToken() {
//     // ── adjust this to wherever your app stores the auth token ──
//     // Example with GetStorage:
//     // return GetStorage().read('token');
//     // Example with shared_preferences (use async version in _authHeaders):
//     // return prefs.getString('token');
//     try {
//       // Try GetStorage if available
//       // ignore: unnecessary_import
//       final box = Get.find(); // fallback — replace with actual storage call
//       return null;
//     } catch (_) {
//       return null;
//     }
//   }
// }

// // lib/services/parent_speech_service.dart
// //
// // SEPARATE service ONLY for parent-side speech fetching.
// // Does NOT touch expert_child_data_service.dart or any other existing file.
// //
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:speechspectrum/routes/app_urls.dart';
// import 'package:speechspectrum/services/shared_preferences_service.dart';

// // ─────────────────────────────────────────────────────────────────────────────
// //  Re-usable models (self-contained so no cross-file dependency issues)
// // ─────────────────────────────────────────────────────────────────────────────

// class ParentSpeechListResponse {
//   final bool status;
//   final String message;
//   final List<ParentSpeechItem> data;

//   ParentSpeechListResponse({
//     required this.status,
//     required this.message,
//     required this.data,
//   });

//   factory ParentSpeechListResponse.fromJson(Map<String, dynamic> json) {
//     return ParentSpeechListResponse(
//       status: json['status'] as bool? ?? false,
//       message: (json['message'] ?? '').toString(),
//       data: (json['data'] as List<dynamic>?)
//               ?.map((e) =>
//                   ParentSpeechItem.fromJson(e as Map<String, dynamic>))
//               .toList() ??
//           [],
//     );
//   }
// }

// class ParentSpeechDetailResponse {
//   final bool status;
//   final String message;
//   final ParentSpeechItem data;

//   ParentSpeechDetailResponse({
//     required this.status,
//     required this.message,
//     required this.data,
//   });

//   factory ParentSpeechDetailResponse.fromJson(Map<String, dynamic> json) {
//     return ParentSpeechDetailResponse(
//       status: json['status'] as bool? ?? false,
//       message: (json['message'] ?? '').toString(),
//       data: ParentSpeechItem.fromJson(
//           json['data'] as Map<String, dynamic>),
//     );
//   }
// }

// class ParentSpeechItem {
//   final String speechSubmissionId;
//   final String parentUserId;
//   final String childId;
//   final String recordingPublicId;
//   final int recordingDurationSeconds;
//   final String? recordingFormat;
//   final String submittedAt;
//   final ParentSpeechChild children;
//   final List<ParentSpeechResult> speechResults;

//   ParentSpeechItem({
//     required this.speechSubmissionId,
//     required this.parentUserId,
//     required this.childId,
//     required this.recordingPublicId,
//     required this.recordingDurationSeconds,
//     this.recordingFormat,
//     required this.submittedAt,
//     required this.children,
//     required this.speechResults,
//   });

//   factory ParentSpeechItem.fromJson(Map<String, dynamic> json) {
//     // ── KEY FIX: read 'speech_submission_id' correctly ──────────────────────
//     // The API returns the field as 'speech_submission_id'.
//     // Previously the wrong field name caused an empty submissionId to be
//     // passed to the detail endpoint → 400 / no data.
//     final rawId = json['speech_submission_id'] ??
//         json['submission_id'] ?? // fallback just in case
//         '';

//     return ParentSpeechItem(
//       speechSubmissionId: rawId.toString(),
//       parentUserId: (json['parent_user_id'] ?? '').toString(),
//       childId: (json['child_id'] ?? '').toString(),
//       recordingPublicId: (json['recording_public_id'] ?? '').toString(),
//       recordingDurationSeconds:
//           (json['recording_duration_seconds'] as num?)?.toInt() ?? 0,
//       recordingFormat: json['recording_format']?.toString(),
//       submittedAt: (json['submitted_at'] ?? '').toString(),
//       children: ParentSpeechChild.fromJson(
//           json['children'] as Map<String, dynamic>? ?? {}),
//       speechResults: (json['speech_results'] as List<dynamic>?)
//               ?.map((e) => ParentSpeechResult.fromJson(
//                   e as Map<String, dynamic>))
//               .toList() ??
//           [],
//     );
//   }

//   bool get hasResults => speechResults.isNotEmpty;
//   ParentSpeechResult? get latestResult =>
//       speechResults.isNotEmpty ? speechResults.first : null;

//   String get formattedDate {
//     try {
//       final dt = DateTime.parse(submittedAt).toLocal();
//       const months = [
//         '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
//         'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
//       ];
//       return '${dt.day} ${months[dt.month]} ${dt.year}';
//     } catch (_) {
//       return submittedAt;
//     }
//   }

//   String get formattedTime {
//     try {
//       final dt = DateTime.parse(submittedAt).toLocal();
//       int h = dt.hour;
//       final m = dt.minute.toString().padLeft(2, '0');
//       final ampm = h >= 12 ? 'PM' : 'AM';
//       if (h > 12) h -= 12;
//       if (h == 0) h = 12;
//       return '$h:$m $ampm';
//     } catch (_) {
//       return '';
//     }
//   }
// }

// class ParentSpeechChild {
//   final String childName;

//   ParentSpeechChild({required this.childName});

//   factory ParentSpeechChild.fromJson(Map<String, dynamic> json) =>
//       ParentSpeechChild(
//           childName: (json['child_name'] ?? '').toString());
// }

// class ParentSpeechResult {
//   final ParentSpeechAnalysis result;
//   final String childId;
//   final String generatedAt;
//   final String parentUserId;
//   final String speechResultId;
//   final String speechSubmissionId;

//   ParentSpeechResult({
//     required this.result,
//     required this.childId,
//     required this.generatedAt,
//     required this.parentUserId,
//     required this.speechResultId,
//     required this.speechSubmissionId,
//   });

//   factory ParentSpeechResult.fromJson(Map<String, dynamic> json) {
//     return ParentSpeechResult(
//       result: ParentSpeechAnalysis.fromJson(
//           json['result'] as Map<String, dynamic>? ?? {}),
//       childId: (json['child_id'] ?? '').toString(),
//       generatedAt: (json['generated_at'] ?? '').toString(),
//       parentUserId: (json['parent_user_id'] ?? '').toString(),
//       speechResultId: (json['speech_result_id'] ?? '').toString(),
//       speechSubmissionId:
//           (json['speech_submission_id'] ?? '').toString(),
//     );
//   }
// }

// class ParentSpeechAnalysis {
//   final String filename;
//   final int maxScore;
//   final int severityScore;
//   final String riskInterpretation;
//   final ParentBioMarkers? bioMarkers;

//   ParentSpeechAnalysis({
//     required this.filename,
//     required this.maxScore,
//     required this.severityScore,
//     required this.riskInterpretation,
//     this.bioMarkers,
//   });

//   factory ParentSpeechAnalysis.fromJson(Map<String, dynamic> json) {
//     return ParentSpeechAnalysis(
//       filename: (json['filename'] ?? '').toString(),
//       maxScore: (json['max_score'] as num?)?.toInt() ?? 30,
//       severityScore: (json['severity_score'] as num?)?.toInt() ?? 0,
//       riskInterpretation:
//           (json['risk_interpretation'] ?? 'UNKNOWN').toString(),
//       bioMarkers: json['bio_markers'] != null
//           ? ParentBioMarkers.fromJson(
//               json['bio_markers'] as Map<String, dynamic>)
//           : null,
//     );
//   }

//   bool get isHighRisk =>
//       riskInterpretation.toUpperCase().contains('HIGH');
//   bool get isModerateRisk =>
//       riskInterpretation.toUpperCase().contains('MODERATE');
//   bool get isLowRisk =>
//       riskInterpretation.toUpperCase().contains('LOW') && !isHighRisk;
// }

// class ParentBioMarkers {
//   final double pitchInstability;
//   final double resonanceJitterF1;
//   final double resonanceJitterF2;

//   ParentBioMarkers({
//     required this.pitchInstability,
//     required this.resonanceJitterF1,
//     required this.resonanceJitterF2,
//   });

//   factory ParentBioMarkers.fromJson(Map<String, dynamic> json) =>
//       ParentBioMarkers(
//         pitchInstability:
//             (json['pitch_instability'] as num?)?.toDouble() ?? 0.0,
//         resonanceJitterF1:
//             (json['resonance_jitter_f1'] as num?)?.toDouble() ?? 0.0,
//         resonanceJitterF2:
//             (json['resonance_jitter_f2'] as num?)?.toDouble() ?? 0.0,
//       );
// }

// // ─────────────────────────────────────────────────────────────────────────────
// //  Service
// // ─────────────────────────────────────────────────────────────────────────────

// class ParentSpeechService {
//   final Dio _dio = Dio();

//   Future<Options> _authOptions() async {
//     final token = await SharedPreferencesService.getAccessToken();
//     if (token == null || token.isEmpty) {
//       throw Exception('No authentication token found. Please login again.');
//     }
//     return Options(headers: {
//       'Authorization': 'Bearer $token',
//       'Content-Type': 'application/json',
//     });
//   }

//   String _errorMessage(dynamic e, String fallback) {
//     if (e is DioException) {
//       final data = e.response?.data;
//       if (data is Map && data['message'] != null) {
//         return data['message'].toString();
//       }
//       switch (e.response?.statusCode) {
//         case 400:
//           return 'Bad request — invalid submission ID.';
//         case 401:
//           return 'Unauthorized. Please login again.';
//         case 403:
//           return 'Access restricted.';
//         case 404:
//           return 'Speech record not found.';
//         default:
//           return fallback;
//       }
//     }
//     return fallback;
//   }

//   // ── GET /api/speech  →  filter by childId client-side ─────────────────────
//   Future<List<ParentSpeechItem>> getSpeechByChild(String childId) async {
//     try {
//       debugPrint('🎙️ [ParentSpeechService] GET /api/speech (child=$childId)');
//       final resp = await _dio.get(
//         '${APIEndPoints.baseUrl}/api/speech',
//         options: await _authOptions(),
//       );

//       debugPrint('📦 [ParentSpeechService] raw response: ${resp.data}');

//       final list = ParentSpeechListResponse.fromJson(
//           Map<String, dynamic>.from(resp.data as Map));

//       final filtered =
//           list.data.where((s) => s.childId == childId).toList();

//       // ── DEBUG: print each item's submissionId ──────────────────────────────
//       for (final item in filtered) {
//         debugPrint(
//             '   → speechSubmissionId="${item.speechSubmissionId}"  childId="${item.childId}"');
//       }

//       return filtered;
//     } on DioException catch (e) {
//       debugPrint('❌ [ParentSpeechService] getSpeechByChild: ${e.message}');
//       debugPrint('   status=${e.response?.statusCode}  body=${e.response?.data}');
//       throw Exception(_errorMessage(e, 'Failed to load speech data'));
//     }
//   }

//   // ── GET /api/speech/:speechSubmissionId ───────────────────────────────────
//   Future<ParentSpeechDetailResponse> getSpeechDetail(
//       String speechSubmissionId) async {
//     if (speechSubmissionId.trim().isEmpty) {
//       throw Exception(
//           'speechSubmissionId is empty — cannot fetch speech detail.');
//     }
//     try {
//       final url = '${APIEndPoints.baseUrl}/api/speech/$speechSubmissionId';
//       debugPrint('🎙️ [ParentSpeechService] GET $url');

//       final resp = await _dio.get(url, options: await _authOptions());

//       debugPrint(
//           '✅ [ParentSpeechService] getSpeechDetail OK: ${resp.data}');

//       return ParentSpeechDetailResponse.fromJson(
//           Map<String, dynamic>.from(resp.data as Map));
//     } on DioException catch (e) {
//       debugPrint('❌ [ParentSpeechService] getSpeechDetail: ${e.message}');
//       debugPrint('   status=${e.response?.statusCode}  body=${e.response?.data}');
//       throw Exception(_errorMessage(e, 'Failed to load speech detail'));
//     }
//   }
// }

// // lib/services/parent_speech_service.dart
// //
// // Updated for new API response format:
// //   result: { sa_score, severity_percentage, risk_level, model_type }
// // No bio_markers, no severity_score/max_score in new format.
// //
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:speechspectrum/routes/app_urls.dart';
// import 'package:speechspectrum/services/shared_preferences_service.dart';

// // ─────────────────────────────────────────────────────────────────────────────
// //  Models
// // ─────────────────────────────────────────────────────────────────────────────

// class ParentSpeechListResponse {
//   final bool status;
//   final String message;
//   final List<ParentSpeechItem> data;

//   ParentSpeechListResponse({
//     required this.status,
//     required this.message,
//     required this.data,
//   });

//   factory ParentSpeechListResponse.fromJson(Map<String, dynamic> json) {
//     return ParentSpeechListResponse(
//       status: json['status'] as bool? ?? false,
//       message: (json['message'] ?? '').toString(),
//       data: (json['data'] as List<dynamic>?)
//               ?.map((e) =>
//                   ParentSpeechItem.fromJson(e as Map<String, dynamic>))
//               .toList() ??
//           [],
//     );
//   }
// }

// class ParentSpeechDetailResponse {
//   final bool status;
//   final String message;
//   final ParentSpeechItem data;

//   ParentSpeechDetailResponse({
//     required this.status,
//     required this.message,
//     required this.data,
//   });

//   factory ParentSpeechDetailResponse.fromJson(Map<String, dynamic> json) {
//     return ParentSpeechDetailResponse(
//       status: json['status'] as bool? ?? false,
//       message: (json['message'] ?? '').toString(),
//       data: ParentSpeechItem.fromJson(
//           json['data'] as Map<String, dynamic>),
//     );
//   }
// }

// // ─── ParentSpeechItem ─────────────────────────────────────────────────────────

// class ParentSpeechItem {
//   final String speechSubmissionId;
//   final String parentUserId;
//   final String childId;
//   final String recordingPublicId;
//   final int recordingDurationSeconds;
//   final String? recordingFormat;
//   final String submittedAt;
//   final ParentSpeechChild children;
//   final List<ParentSpeechResult> speechResults;

//   ParentSpeechItem({
//     required this.speechSubmissionId,
//     required this.parentUserId,
//     required this.childId,
//     required this.recordingPublicId,
//     required this.recordingDurationSeconds,
//     this.recordingFormat,
//     required this.submittedAt,
//     required this.children,
//     required this.speechResults,
//   });

//   factory ParentSpeechItem.fromJson(Map<String, dynamic> json) {
//     final rawId = json['speech_submission_id'] ??
//         json['submission_id'] ??
//         '';

//     // Results can come as array "speech_results" or singular "speech_result"
//     List<ParentSpeechResult> results = [];

//     if (json['speech_results'] is List &&
//         (json['speech_results'] as List).isNotEmpty) {
//       results = (json['speech_results'] as List)
//           .map((e) =>
//               ParentSpeechResult.fromJson(e as Map<String, dynamic>))
//           .toList();
//     } else if (json['speech_result'] is Map) {
//       results = [
//         ParentSpeechResult.fromJson(
//             json['speech_result'] as Map<String, dynamic>)
//       ];
//     }

//     return ParentSpeechItem(
//       speechSubmissionId: rawId.toString(),
//       parentUserId: (json['parent_user_id'] ?? '').toString(),
//       childId: (json['child_id'] ?? '').toString(),
//       recordingPublicId: (json['recording_public_id'] ?? '').toString(),
//       recordingDurationSeconds:
//           (json['recording_duration_seconds'] as num?)?.toInt() ?? 0,
//       recordingFormat: json['recording_format']?.toString(),
//       submittedAt: (json['submitted_at'] ?? '').toString(),
//       children: ParentSpeechChild.fromJson(
//           json['children'] as Map<String, dynamic>? ?? {}),
//       speechResults: results,
//     );
//   }

//   bool get hasResults => speechResults.isNotEmpty;
//   ParentSpeechResult? get latestResult =>
//       speechResults.isNotEmpty ? speechResults.first : null;

//   String get formattedDate {
//     try {
//       final dt = DateTime.parse(submittedAt).toLocal();
//       const months = [
//         '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
//         'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
//       ];
//       return '${dt.day} ${months[dt.month]} ${dt.year}';
//     } catch (_) {
//       return submittedAt;
//     }
//   }

//   String get formattedTime {
//     try {
//       final dt = DateTime.parse(submittedAt).toLocal();
//       int h = dt.hour;
//       final m = dt.minute.toString().padLeft(2, '0');
//       final ampm = h >= 12 ? 'PM' : 'AM';
//       if (h > 12) h -= 12;
//       if (h == 0) h = 12;
//       return '$h:$m $ampm';
//     } catch (_) {
//       return '';
//     }
//   }
// }

// // ─── ParentSpeechChild ────────────────────────────────────────────────────────

// class ParentSpeechChild {
//   final String childName;

//   ParentSpeechChild({required this.childName});

//   factory ParentSpeechChild.fromJson(Map<String, dynamic> json) =>
//       ParentSpeechChild(
//           childName: (json['child_name'] ?? '').toString());
// }

// // ─── ParentSpeechResult ───────────────────────────────────────────────────────

// class ParentSpeechResult {
//   final ParentSpeechAnalysis result;
//   final String childId;
//   final String generatedAt;
//   final String parentUserId;
//   final String speechResultId;
//   final String speechSubmissionId;

//   ParentSpeechResult({
//     required this.result,
//     required this.childId,
//     required this.generatedAt,
//     required this.parentUserId,
//     required this.speechResultId,
//     required this.speechSubmissionId,
//   });

//   factory ParentSpeechResult.fromJson(Map<String, dynamic> json) {
//     return ParentSpeechResult(
//       result: ParentSpeechAnalysis.fromJson(
//           json['result'] as Map<String, dynamic>? ?? {}),
//       childId: (json['child_id'] ?? '').toString(),
//       generatedAt: (json['generated_at'] ?? '').toString(),
//       parentUserId: (json['parent_user_id'] ?? '').toString(),
//       speechResultId: (json['speech_result_id'] ?? '').toString(),
//       speechSubmissionId:
//           (json['speech_submission_id'] ?? '').toString(),
//     );
//   }
// }

// // ─── ParentSpeechAnalysis ─────────────────────────────────────────────────────
// /// Handles both new format (sa_score, risk_level, severity_percentage)
// /// and old format (severity_score, max_score, risk_interpretation, bio_markers).

// class ParentSpeechAnalysis {
//   // New format fields
//   final double? saScore;
//   final String? severityPercentage;
//   final String? riskLevel;
//   final String? modelType;
//   final String? filename;

//   // Old format fields
//   final int? severityScore;
//   final int? maxScore;
//   final String? riskInterpretation;
//   final ParentBioMarkers? bioMarkers;

//   ParentSpeechAnalysis({
//     this.saScore,
//     this.severityPercentage,
//     this.riskLevel,
//     this.modelType,
//     this.filename,
//     this.severityScore,
//     this.maxScore,
//     this.riskInterpretation,
//     this.bioMarkers,
//   });

//   // Whether this is the new format response
//   bool get isNewFormat => saScore != null || riskLevel != null;

//   // Unified risk label for display
//   String get displayRiskLabel {
//     if (isNewFormat) {
//       final level = (riskLevel ?? '').toLowerCase();
//       if (level == 'high') return 'High Risk';
//       if (level == 'moderate') return 'Moderate Risk';
//       return 'Low Risk';
//     }
//     return riskInterpretation ?? 'Low Risk';
//   }

//   // Unified score for circular progress (0.0–1.0)
//   double get progressValue {
//     if (isNewFormat) {
//       return ((saScore ?? 0) / 22.0).clamp(0.0, 1.0);
//     }
//     final max = maxScore ?? 22;
//     if (max == 0) return 0.0;
//     return ((severityScore ?? 0) / max).clamp(0.0, 1.0);
//   }

//   // Score label for the circle center
//   String get scoreDisplay {
//     if (isNewFormat) return (saScore ?? 0).toStringAsFixed(1);
//     return '${severityScore ?? 0}';
//   }

//   // Sub-label under score
//   String get scoreSubLabel {
//     if (isNewFormat) return 'out of 22';
//     return 'out of ${maxScore ?? 22}';
//   }

//   // Score label for list card badge
//   String get scoreBadgeLabel {
//     if (isNewFormat) return '${(saScore ?? 0).toStringAsFixed(1)} / 22';
//     return '${severityScore ?? 0}/${maxScore ?? 22}';
//   }

//   bool get isHighRisk {
//     if (isNewFormat) {
//       return (riskLevel ?? '').toLowerCase() == 'high';
//     }
//     return (riskInterpretation ?? '').toUpperCase().contains('HIGH');
//   }

//   bool get isModerateRisk {
//     if (isNewFormat) {
//       return (riskLevel ?? '').toLowerCase() == 'moderate';
//     }
//     return (riskInterpretation ?? '').toUpperCase().contains('MODERATE');
//   }

//   bool get isLowRisk => !isHighRisk && !isModerateRisk;

//   factory ParentSpeechAnalysis.fromJson(Map<String, dynamic> json) {
//     final hasNewFormat =
//         json.containsKey('sa_score') || json.containsKey('risk_level');

//     if (hasNewFormat) {
//       return ParentSpeechAnalysis(
//         saScore: (json['sa_score'] as num?)?.toDouble(),
//         severityPercentage: json['severity_percentage']?.toString(),
//         riskLevel: json['risk_level']?.toString(),
//         modelType: json['model_type']?.toString(),
//         filename: json['filename']?.toString(),
//       );
//     } else {
//       return ParentSpeechAnalysis(
//         severityScore: (json['severity_score'] as num?)?.toInt() ?? 0,
//         maxScore: (json['max_score'] as num?)?.toInt() ?? 22,
//         riskInterpretation:
//             (json['risk_interpretation'] ?? 'Low Risk').toString(),
//         bioMarkers: json['bio_markers'] != null
//             ? ParentBioMarkers.fromJson(
//                 json['bio_markers'] as Map<String, dynamic>)
//             : null,
//         filename: json['filename']?.toString(),
//       );
//     }
//   }
// }

// // ─── ParentBioMarkers ─────────────────────────────────────────────────────────

// class ParentBioMarkers {
//   final double pitchInstability;
//   final double resonanceJitterF1;
//   final double resonanceJitterF2;

//   ParentBioMarkers({
//     required this.pitchInstability,
//     required this.resonanceJitterF1,
//     required this.resonanceJitterF2,
//   });

//   factory ParentBioMarkers.fromJson(Map<String, dynamic> json) =>
//       ParentBioMarkers(
//         pitchInstability:
//             (json['pitch_instability'] as num?)?.toDouble() ?? 0.0,
//         resonanceJitterF1:
//             (json['resonance_jitter_f1'] as num?)?.toDouble() ?? 0.0,
//         resonanceJitterF2:
//             (json['resonance_jitter_f2'] as num?)?.toDouble() ?? 0.0,
//       );
// }

// // ─────────────────────────────────────────────────────────────────────────────
// //  Service
// // ─────────────────────────────────────────────────────────────────────────────

// class ParentSpeechService {
//   final Dio _dio = Dio();

//   Future<Options> _authOptions() async {
//     final token = await SharedPreferencesService.getAccessToken();
//     if (token == null || token.isEmpty) {
//       throw Exception('No authentication token found. Please login again.');
//     }
//     return Options(headers: {
//       'Authorization': 'Bearer $token',
//       'Content-Type': 'application/json',
//     });
//   }

//   String _errorMessage(dynamic e, String fallback) {
//     if (e is DioException) {
//       final data = e.response?.data;
//       if (data is Map && data['message'] != null) {
//         return data['message'].toString();
//       }
//       switch (e.response?.statusCode) {
//         case 400:
//           return 'Bad request — invalid submission ID.';
//         case 401:
//           return 'Unauthorized. Please login again.';
//         case 403:
//           return 'Access restricted.';
//         case 404:
//           return 'Speech record not found.';
//         default:
//           return fallback;
//       }
//     }
//     return fallback;
//   }

//   // ── GET /api/speech → filter by childId client-side ───────────────────────
//   Future<List<ParentSpeechItem>> getSpeechByChild(String childId) async {
//     try {
//       debugPrint('🎙️ [ParentSpeechService] GET /api/speech (child=$childId)');
//       final resp = await _dio.get(
//         '${APIEndPoints.baseUrl}/api/speech',
//         options: await _authOptions(),
//       );

//       debugPrint('📦 [ParentSpeechService] raw response: ${resp.data}');

//       final list = ParentSpeechListResponse.fromJson(
//           Map<String, dynamic>.from(resp.data as Map));

//       final filtered =
//           list.data.where((s) => s.childId == childId).toList();

//       for (final item in filtered) {
//         debugPrint(
//             '   → id="${item.speechSubmissionId}" hasResults=${item.hasResults}');
//       }

//       return filtered;
//     } on DioException catch (e) {
//       debugPrint('❌ [ParentSpeechService] getSpeechByChild: ${e.message}');
//       throw Exception(_errorMessage(e, 'Failed to load speech data'));
//     }
//   }

//   // ── GET /api/speech/:speechSubmissionId ───────────────────────────────────
//   Future<ParentSpeechDetailResponse> getSpeechDetail(
//       String speechSubmissionId) async {
//     if (speechSubmissionId.trim().isEmpty) {
//       throw Exception(
//           'speechSubmissionId is empty — cannot fetch speech detail.');
//     }
//     try {
//       final url = '${APIEndPoints.baseUrl}/api/speech/$speechSubmissionId';
//       debugPrint('🎙️ [ParentSpeechService] GET $url');

//       final resp = await _dio.get(url, options: await _authOptions());

//       debugPrint(
//           '✅ [ParentSpeechService] getSpeechDetail OK');

//       return ParentSpeechDetailResponse.fromJson(
//           Map<String, dynamic>.from(resp.data as Map));
//     } on DioException catch (e) {
//       debugPrint('❌ [ParentSpeechService] getSpeechDetail: ${e.message}');
//       throw Exception(_errorMessage(e, 'Failed to load speech detail'));
//     }
//   }
// }

// lib/services/parent_speech_service.dart
//
// Updated for new API response format:
//   result: { filename, sa_score, severity_percentage, risk_level, model_type }
// No bio_markers in new format.
// All models are self-contained here (no separate speech_models.dart needed).
//
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:speechspectrum/routes/app_urls.dart';
import 'package:speechspectrum/services/shared_preferences_service.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  Models
// ─────────────────────────────────────────────────────────────────────────────

// ─── ParentSpeechListResponse ─────────────────────────────────────────────────

class ParentSpeechListResponse {
  final bool status;
  final String message;
  final List<ParentSpeechItem> data;

  ParentSpeechListResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ParentSpeechListResponse.fromJson(Map<String, dynamic> json) {
    return ParentSpeechListResponse(
      status: json['status'] as bool? ?? false,
      message: (json['message'] ?? '').toString(),
      data: (json['data'] as List<dynamic>?)
              ?.map((e) =>
                  ParentSpeechItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

// ─── ParentSpeechDetailResponse ───────────────────────────────────────────────

class ParentSpeechDetailResponse {
  final bool status;
  final String message;
  final ParentSpeechItem data;

  ParentSpeechDetailResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ParentSpeechDetailResponse.fromJson(Map<String, dynamic> json) {
    return ParentSpeechDetailResponse(
      status: json['status'] as bool? ?? false,
      message: (json['message'] ?? '').toString(),
      data: ParentSpeechItem.fromJson(
          json['data'] as Map<String, dynamic>),
    );
  }
}

// ─── ParentSpeechItem ─────────────────────────────────────────────────────────
/// Handles all server shapes:
///   • GET /api/speech  list  → each item may have "speech_result" (singular)
///   • GET /api/speech/:id    → may have "speech_results" (array)
///   • POST /api/speech       → has "speech_result" (singular)

class ParentSpeechItem {
  final String speechSubmissionId;
  final String parentUserId;
  final String childId;
  final String recordingPublicId;
  final int recordingDurationSeconds;
  final String? recordingFormat;
  final String submittedAt;
  final ParentSpeechChild children;
  final List<ParentSpeechResult> speechResults;

  ParentSpeechItem({
    required this.speechSubmissionId,
    required this.parentUserId,
    required this.childId,
    required this.recordingPublicId,
    required this.recordingDurationSeconds,
    this.recordingFormat,
    required this.submittedAt,
    required this.children,
    required this.speechResults,
  });

  factory ParentSpeechItem.fromJson(Map<String, dynamic> json) {
    final rawId = json['speech_submission_id'] ??
        json['submission_id'] ??
        '';

    // Collect results from either array or singular field
    List<ParentSpeechResult> results = [];

    // Shape A: "speech_results" array (GET /api/speech/:id)
    if (json['speech_results'] is List &&
        (json['speech_results'] as List).isNotEmpty) {
      results = (json['speech_results'] as List)
          .map((e) =>
              ParentSpeechResult.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    // Shape B: "speech_result" singular (POST / GET list)
    if (results.isEmpty && json['speech_result'] is Map) {
      results = [
        ParentSpeechResult.fromJson(
            json['speech_result'] as Map<String, dynamic>)
      ];
    }

    return ParentSpeechItem(
      speechSubmissionId: rawId.toString(),
      parentUserId: (json['parent_user_id'] ?? '').toString(),
      childId: (json['child_id'] ?? '').toString(),
      recordingPublicId: (json['recording_public_id'] ?? '').toString(),
      recordingDurationSeconds:
          (json['recording_duration_seconds'] as num?)?.toInt() ?? 0,
      recordingFormat: json['recording_format']?.toString(),
      submittedAt: (json['submitted_at'] ?? '').toString(),
      children: ParentSpeechChild.fromJson(
          json['children'] as Map<String, dynamic>? ?? {}),
      speechResults: results,
    );
  }

  bool get hasResults => speechResults.isNotEmpty;
  ParentSpeechResult? get latestResult =>
      speechResults.isNotEmpty ? speechResults.first : null;

  String get formattedDate {
    try {
      final dt = DateTime.parse(submittedAt).toLocal();
      const months = [
        '',
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ];
      return '${dt.day} ${months[dt.month]} ${dt.year}';
    } catch (_) {
      return submittedAt;
    }
  }

  String get formattedTime {
    try {
      final dt = DateTime.parse(submittedAt).toLocal();
      int h = dt.hour;
      final m = dt.minute.toString().padLeft(2, '0');
      final ampm = h >= 12 ? 'PM' : 'AM';
      if (h > 12) h -= 12;
      if (h == 0) h = 12;
      return '$h:$m $ampm';
    } catch (_) {
      return '';
    }
  }
}

// ─── ParentSpeechChild ────────────────────────────────────────────────────────

class ParentSpeechChild {
  final String childName;

  ParentSpeechChild({required this.childName});

  factory ParentSpeechChild.fromJson(Map<String, dynamic> json) =>
      ParentSpeechChild(
          childName: (json['child_name'] ?? '').toString());
}

// ─── ParentSpeechResult ───────────────────────────────────────────────────────

class ParentSpeechResult {
  final String speechResultId;
  final String speechSubmissionId;
  final String parentUserId;
  final String childId;
  final String generatedAt;
  final ParentSpeechAnalysis result;

  ParentSpeechResult({
    required this.speechResultId,
    required this.speechSubmissionId,
    required this.parentUserId,
    required this.childId,
    required this.generatedAt,
    required this.result,
  });

  factory ParentSpeechResult.fromJson(Map<String, dynamic> json) {
    return ParentSpeechResult(
      speechResultId: (json['speech_result_id'] ?? '').toString(),
      speechSubmissionId:
          (json['speech_submission_id'] ?? '').toString(),
      parentUserId: (json['parent_user_id'] ?? '').toString(),
      childId: (json['child_id'] ?? '').toString(),
      generatedAt: (json['generated_at'] ?? '').toString(),
      result: ParentSpeechAnalysis.fromJson(
          json['result'] as Map<String, dynamic>? ?? {}),
    );
  }
}

// ─── ParentSpeechAnalysis ─────────────────────────────────────────────────────
/// New format ONLY:
///   { "filename": "test_audio.wav", "sa_score": 14.91,
///     "severity_percentage": "67.8%", "risk_level": "Moderate",
///     "model_type": "Mega-Ensemble (25-fold)" }

class ParentSpeechAnalysis {
  final String filename;
  final double saScore;
  final String severityPercentage;
  final String riskLevel;
  final String modelType;

  ParentSpeechAnalysis({
    required this.filename,
    required this.saScore,
    required this.severityPercentage,
    required this.riskLevel,
    required this.modelType,
  });

  factory ParentSpeechAnalysis.fromJson(Map<String, dynamic> json) {
    return ParentSpeechAnalysis(
      filename: (json['filename'] ?? '').toString(),
      saScore: (json['sa_score'] as num?)?.toDouble() ?? 0.0,
      severityPercentage:
          (json['severity_percentage'] ?? '0%').toString(),
      riskLevel: (json['risk_level'] ?? 'Low').toString(),
      modelType: (json['model_type'] ?? '').toString(),
    );
  }

  // ── Derived helpers ──────────────────────────────────────────────────────

  bool get isHighRisk =>
      riskLevel.toLowerCase() == 'high';

  bool get isModerateRisk =>
      riskLevel.toLowerCase() == 'moderate';

  bool get isLowRisk => !isHighRisk && !isModerateRisk;

  /// Human-readable risk label e.g. "High Risk"
  String get riskInterpretation {
    if (isHighRisk) return 'High Risk';
    if (isModerateRisk) return 'Moderate Risk';
    return 'Low Risk';
  }

  /// Rounded integer score out of 22 (for progress bars / badge)
  int get severityScore => saScore.round().clamp(0, 22);

  /// Always 22 for the new model
  int get maxScore => 22;

  /// Progress value 0.0–1.0
  double get progressValue => (saScore / 22.0).clamp(0.0, 1.0);

  /// Badge string e.g. "14.9 / 22"
  String get scoreBadgeLabel =>
      '${saScore.toStringAsFixed(1)} / 22';

  /// Center circle display string
  String get scoreDisplay => saScore.toStringAsFixed(1);

  /// Sub-label under circle score
  String get scoreSubLabel => 'out of 22';
}

// ─────────────────────────────────────────────────────────────────────────────
//  Service
// ─────────────────────────────────────────────────────────────────────────────

class ParentSpeechService {
  final Dio _dio = Dio();

  Future<Options> _authOptions() async {
    final token = await SharedPreferencesService.getAccessToken();
    if (token == null || token.isEmpty) {
      throw Exception('No authentication token found. Please login again.');
    }
    return Options(headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    });
  }

  String _errorMessage(dynamic e, String fallback) {
    if (e is DioException) {
      final data = e.response?.data;
      if (data is Map && data['message'] != null) {
        return data['message'].toString();
      }
      switch (e.response?.statusCode) {
        case 400:
          return 'Bad request — invalid submission ID.';
        case 401:
          return 'Unauthorized. Please login again.';
        case 403:
          return 'Access restricted.';
        case 404:
          return 'Speech record not found.';
        default:
          return fallback;
      }
    }
    return fallback;
  }

  // ── GET /api/speech → filter by childId client-side ───────────────────────
  Future<List<ParentSpeechItem>> getSpeechByChild(String childId) async {
    try {
      debugPrint(
          '🎙️ [ParentSpeechService] GET /api/speech (child=$childId)');
      final resp = await _dio.get(
        '${APIEndPoints.baseUrl}/api/speech',
        options: await _authOptions(),
      );

      debugPrint('📦 [ParentSpeechService] raw response: ${resp.data}');

      final list = ParentSpeechListResponse.fromJson(
          Map<String, dynamic>.from(resp.data as Map));

      final filtered =
          list.data.where((s) => s.childId == childId).toList();

      for (final item in filtered) {
        debugPrint(
            '   → id="${item.speechSubmissionId}" hasResults=${item.hasResults}');
      }

      return filtered;
    } on DioException catch (e) {
      debugPrint(
          '❌ [ParentSpeechService] getSpeechByChild: ${e.message}');
      debugPrint(
          '   status=${e.response?.statusCode}  body=${e.response?.data}');
      throw Exception(_errorMessage(e, 'Failed to load speech data'));
    }
  }

  // ── GET /api/speech/:speechSubmissionId ───────────────────────────────────
  Future<ParentSpeechDetailResponse> getSpeechDetail(
      String speechSubmissionId) async {
    if (speechSubmissionId.trim().isEmpty) {
      throw Exception(
          'speechSubmissionId is empty — cannot fetch speech detail.');
    }
    try {
      final url =
          '${APIEndPoints.baseUrl}/api/speech/$speechSubmissionId';
      debugPrint('🎙️ [ParentSpeechService] GET $url');

      final resp = await _dio.get(url, options: await _authOptions());

      debugPrint('✅ [ParentSpeechService] getSpeechDetail OK');

      return ParentSpeechDetailResponse.fromJson(
          Map<String, dynamic>.from(resp.data as Map));
    } on DioException catch (e) {
      debugPrint(
          '❌ [ParentSpeechService] getSpeechDetail: ${e.message}');
      debugPrint(
          '   status=${e.response?.statusCode}  body=${e.response?.data}');
      throw Exception(_errorMessage(e, 'Failed to load speech detail'));
    }
  }
}