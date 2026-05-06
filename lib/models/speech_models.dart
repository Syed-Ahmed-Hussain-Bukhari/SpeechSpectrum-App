// // // // lib/models/speech_models.dart

// // // class ChildrenListResponse {
// // //   final String message;
// // //   final List<Child> data;
// // //   final bool status;

// // //   ChildrenListResponse({
// // //     required this.message,
// // //     required this.data,
// // //     required this.status,
// // //   });

// // //   factory ChildrenListResponse.fromJson(Map<String, dynamic> json) {
// // //     return ChildrenListResponse(
// // //       message: json['message'] ?? '',
// // //       data: (json['data'] as List<dynamic>?)
// // //               ?.map((child) => Child.fromJson(child))
// // //               .toList() ??
// // //           [],
// // //       status: json['status'] ?? false,
// // //     );
// // //   }
// // // }

// // // class Child {
// // //   final String childId;
// // //   final String parentUserId;
// // //   final String childName;
// // //   final String dateOfBirth;
// // //   final String gender;
// // //   final String createdAt;

// // //   Child({
// // //     required this.childId,
// // //     required this.parentUserId,
// // //     required this.childName,
// // //     required this.dateOfBirth,
// // //     required this.gender,
// // //     required this.createdAt,
// // //   });

// // //   factory Child.fromJson(Map<String, dynamic> json) {
// // //     return Child(
// // //       childId: json['child_id'] ?? '',
// // //       parentUserId: json['parent_user_id'] ?? '',
// // //       childName: json['child_name'] ?? '',
// // //       dateOfBirth: json['date_of_birth'] ?? '',
// // //       gender: json['gender'] ?? '',
// // //       createdAt: json['created_at'] ?? '',
// // //     );
// // //   }

// // //   String getAge() {
// // //     try {
// // //       final dob = DateTime.parse(dateOfBirth);
// // //       final now = DateTime.now();
// // //       final age = now.year - dob.year;
// // //       if (now.month < dob.month ||
// // //           (now.month == dob.month && now.day < dob.day)) {
// // //         return '${age - 1} years';
// // //       }
// // //       return '$age years';
// // //     } catch (e) {
// // //       return 'N/A';
// // //     }
// // //   }

// // //   String getFormattedDOB() {
// // //     try {
// // //       final dob = DateTime.parse(dateOfBirth);
// // //       return '${dob.day}/${dob.month}/${dob.year}';
// // //     } catch (e) {
// // //       return dateOfBirth;
// // //     }
// // //   }
// // // }

// // // class SpeechSubmissionResponse {
// // //   final String message;
// // //   final SpeechSubmission data;
// // //   final bool status;

// // //   SpeechSubmissionResponse({
// // //     required this.message,
// // //     required this.data,
// // //     required this.status,
// // //   });

// // //   factory SpeechSubmissionResponse.fromJson(Map<String, dynamic> json) {
// // //     return SpeechSubmissionResponse(
// // //       message: json['message'] ?? '',
// // //       data: SpeechSubmission.fromJson(json['data'] ?? {}),
// // //       status: json['status'] ?? false,
// // //     );
// // //   }
// // // }

// // // class AllSpeechSubmissionsResponse {
// // //   final String message;
// // //   final List<SpeechSubmissionDetail> data;
// // //   final bool status;

// // //   AllSpeechSubmissionsResponse({
// // //     required this.message,
// // //     required this.data,
// // //     required this.status,
// // //   });

// // //   factory AllSpeechSubmissionsResponse.fromJson(Map<String, dynamic> json) {
// // //     return AllSpeechSubmissionsResponse(
// // //       message: json['message'] ?? '',
// // //       data: (json['data'] as List<dynamic>?)
// // //               ?.map((submission) => SpeechSubmissionDetail.fromJson(submission))
// // //               .toList() ??
// // //           [],
// // //       status: json['status'] ?? false,
// // //     );
// // //   }
// // // }

// // // class SpeechSubmission {
// // //   final String speechSubmissionId;
// // //   final String parentUserId;
// // //   final String childId;
// // //   final String recordingPublicId;
// // //   final int recordingDurationSeconds;
// // //   final String? recordingFormat;
// // //   final String submittedAt;

// // //   SpeechSubmission({
// // //     required this.speechSubmissionId,
// // //     required this.parentUserId,
// // //     required this.childId,
// // //     required this.recordingPublicId,
// // //     required this.recordingDurationSeconds,
// // //     this.recordingFormat,
// // //     required this.submittedAt,
// // //   });

// // //   factory SpeechSubmission.fromJson(Map<String, dynamic> json) {
// // //     return SpeechSubmission(
// // //       speechSubmissionId: json['speech_submission_id'] ?? '',
// // //       parentUserId: json['parent_user_id'] ?? '',
// // //       childId: json['child_id'] ?? '',
// // //       recordingPublicId: json['recording_public_id'] ?? '',
// // //       recordingDurationSeconds: json['recording_duration_seconds'] ?? 0,
// // //       recordingFormat: json['recording_format'],
// // //       submittedAt: json['submitted_at'] ?? '',
// // //     );
// // //   }

// // //   String getFormattedDate() {
// // //     try {
// // //       final date = DateTime.parse(submittedAt);
// // //       return '${date.day}/${date.month}/${date.year}';
// // //     } catch (e) {
// // //       return submittedAt;
// // //     }
// // //   }

// // //   String getFormattedTime() {
// // //     try {
// // //       final date = DateTime.parse(submittedAt);
// // //       final hour = date.hour > 12 ? date.hour - 12 : date.hour;
// // //       final period = date.hour >= 12 ? 'PM' : 'AM';
// // //       return '${hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')} $period';
// // //     } catch (e) {
// // //       return '';
// // //     }
// // //   }
// // // }

// // // class SpeechSubmissionDetail {
// // //   final String speechSubmissionId;
// // //   final String parentUserId;
// // //   final String childId;
// // //   final String recordingPublicId;
// // //   final int recordingDurationSeconds;
// // //   final String? recordingFormat;
// // //   final String submittedAt;
// // //   final ChildInfo? children;
// // //   final List<SpeechResult> speechResults;

// // //   SpeechSubmissionDetail({
// // //     required this.speechSubmissionId,
// // //     required this.parentUserId,
// // //     required this.childId,
// // //     required this.recordingPublicId,
// // //     required this.recordingDurationSeconds,
// // //     this.recordingFormat,
// // //     required this.submittedAt,
// // //     this.children,
// // //     required this.speechResults,
// // //   });

// // //   factory SpeechSubmissionDetail.fromJson(Map<String, dynamic> json) {
// // //     return SpeechSubmissionDetail(
// // //       speechSubmissionId: json['speech_submission_id'] ?? '',
// // //       parentUserId: json['parent_user_id'] ?? '',
// // //       childId: json['child_id'] ?? '',
// // //       recordingPublicId: json['recording_public_id'] ?? '',
// // //       recordingDurationSeconds: json['recording_duration_seconds'] ?? 0,
// // //       recordingFormat: json['recording_format'],
// // //       submittedAt: json['submitted_at'] ?? '',
// // //       children: json['children'] != null
// // //           ? ChildInfo.fromJson(json['children'])
// // //           : null,
// // //       speechResults: (json['speech_results'] as List<dynamic>?)
// // //               ?.map((result) => SpeechResult.fromJson(result))
// // //               .toList() ??
// // //           [],
// // //     );
// // //   }

// // //   String getFormattedDate() {
// // //     try {
// // //       final date = DateTime.parse(submittedAt);
// // //       return '${date.day}/${date.month}/${date.year}';
// // //     } catch (e) {
// // //       return submittedAt;
// // //     }
// // //   }

// // //   String getFormattedTime() {
// // //     try {
// // //       final date = DateTime.parse(submittedAt);
// // //       final hour = date.hour > 12 ? date.hour - 12 : date.hour;
// // //       final period = date.hour >= 12 ? 'PM' : 'AM';
// // //       return '${hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')} $period';
// // //     } catch (e) {
// // //       return '';
// // //     }
// // //   }

// // //   String getChildName() {
// // //     return children?.childName ?? 'Unknown';
// // //   }

// // //   bool hasResults() {
// // //     return speechResults.isNotEmpty;
// // //   }

// // //   SpeechResult? getLatestResult() {
// // //     if (speechResults.isEmpty) return null;
// // //     return speechResults.first;
// // //   }
// // // }

// // // class ChildInfo {
// // //   final String childName;

// // //   ChildInfo({required this.childName});

// // //   factory ChildInfo.fromJson(Map<String, dynamic> json) {
// // //     return ChildInfo(
// // //       childName: json['child_name'] ?? '',
// // //     );
// // //   }
// // // }

// // // class SpeechResult {
// // //   final ResultData result;
// // //   final String childId;
// // //   final String generatedAt;
// // //   final String parentUserId;
// // //   final String speechResultId;
// // //   final String speechSubmissionId;

// // //   SpeechResult({
// // //     required this.result,
// // //     required this.childId,
// // //     required this.generatedAt,
// // //     required this.parentUserId,
// // //     required this.speechResultId,
// // //     required this.speechSubmissionId,
// // //   });

// // //   factory SpeechResult.fromJson(Map<String, dynamic> json) {
// // //     return SpeechResult(
// // //       result: ResultData.fromJson(json['result'] ?? {}),
// // //       childId: json['child_id'] ?? '',
// // //       generatedAt: json['generated_at'] ?? '',
// // //       parentUserId: json['parent_user_id'] ?? '',
// // //       speechResultId: json['speech_result_id'] ?? '',
// // //       speechSubmissionId: json['speech_submission_id'] ?? '',
// // //     );
// // //   }
// // // }

// // // class ResultData {
// // //   final AnalysisResult result;
// // //   final String filename;

// // //   ResultData({
// // //     required this.result,
// // //     required this.filename,
// // //   });

// // //   factory ResultData.fromJson(Map<String, dynamic> json) {
// // //     return ResultData(
// // //       result: AnalysisResult.fromJson(json['result'] ?? {}),
// // //       filename: json['filename'] ?? '',
// // //     );
// // //   }
// // // }

// // // class AnalysisResult {
// // //   final String label;
// // //   final int score;

// // //   AnalysisResult({
// // //     required this.label,
// // //     required this.score,
// // //   });

// // //   factory AnalysisResult.fromJson(Map<String, dynamic> json) {
// // //     return AnalysisResult(
// // //       label: json['label'] ?? '',
// // //       score: json['score'] ?? 0,
// // //     );
// // //   }

// // //   bool isTypical() => label.toLowerCase() == 'typical';
// // //   bool isAtypical() => label.toLowerCase() == 'atypical';

// // //   String getScorePercentage() {
// // //     return '${score}%';
// // //   }
// // // }

// // // class DeleteSpeechResponse {
// // //   final String message;
// // //   final bool status;

// // //   DeleteSpeechResponse({
// // //     required this.message,
// // //     required this.status,
// // //   });

// // //   factory DeleteSpeechResponse.fromJson(Map<String, dynamic> json) {
// // //     return DeleteSpeechResponse(
// // //       message: json['message'] ?? '',
// // //       status: json['status'] ?? false,
// // //     );
// // //   }
// // // }
// // // lib/models/speech_models.dart

// // class ChildrenListResponse {
// //   final String message;
// //   final List<Child> data;
// //   final bool status;

// //   ChildrenListResponse({
// //     required this.message,
// //     required this.data,
// //     required this.status,
// //   });

// //   factory ChildrenListResponse.fromJson(Map<String, dynamic> json) {
// //     return ChildrenListResponse(
// //       message: json['message'] ?? '',
// //       data: (json['data'] as List<dynamic>?)
// //               ?.map((child) => Child.fromJson(child))
// //               .toList() ??
// //           [],
// //       status: json['status'] ?? false,
// //     );
// //   }
// // }

// // class Child {
// //   final String childId;
// //   final String parentUserId;
// //   final String childName;
// //   final String dateOfBirth;
// //   final String gender;
// //   final String createdAt;

// //   Child({
// //     required this.childId,
// //     required this.parentUserId,
// //     required this.childName,
// //     required this.dateOfBirth,
// //     required this.gender,
// //     required this.createdAt,
// //   });

// //   factory Child.fromJson(Map<String, dynamic> json) {
// //     return Child(
// //       childId: json['child_id'] ?? '',
// //       parentUserId: json['parent_user_id'] ?? '',
// //       childName: json['child_name'] ?? '',
// //       dateOfBirth: json['date_of_birth'] ?? '',
// //       gender: json['gender'] ?? '',
// //       createdAt: json['created_at'] ?? '',
// //     );
// //   }

// //   String getAge() {
// //     try {
// //       final dob = DateTime.parse(dateOfBirth);
// //       final now = DateTime.now();
// //       final age = now.year - dob.year;
// //       if (now.month < dob.month ||
// //           (now.month == dob.month && now.day < dob.day)) {
// //         return '${age - 1} years';
// //       }
// //       return '$age years';
// //     } catch (e) {
// //       return 'N/A';
// //     }
// //   }

// //   String getFormattedDOB() {
// //     try {
// //       final dob = DateTime.parse(dateOfBirth);
// //       return '${dob.day}/${dob.month}/${dob.year}';
// //     } catch (e) {
// //       return dateOfBirth;
// //     }
// //   }
// // }

// // // ─── NEW: Bio Markers ────────────────────────────────────────────────────────
// // class BioMarkers {
// //   final double resonanceJitterF1;
// //   final double resonanceJitterF2;
// //   final double pitchInstability;

// //   BioMarkers({
// //     required this.resonanceJitterF1,
// //     required this.resonanceJitterF2,
// //     required this.pitchInstability,
// //   });

// //   factory BioMarkers.fromJson(Map<String, dynamic> json) {
// //     return BioMarkers(
// //       resonanceJitterF1: (json['resonance_jitter_f1'] ?? 0).toDouble(),
// //       resonanceJitterF2: (json['resonance_jitter_f2'] ?? 0).toDouble(),
// //       pitchInstability: (json['pitch_instability'] ?? 0).toDouble(),
// //     );
// //   }
// // }

// // // ─── NEW: Analysis Result (replaces old label/score system) ──────────────────
// // class AnalysisResult {
// //   final String filename;
// //   final int severityScore;
// //   final int maxScore;
// //   final String riskInterpretation;
// //   final BioMarkers? bioMarkers;

// //   AnalysisResult({
// //     required this.filename,
// //     required this.severityScore,
// //     required this.maxScore,
// //     required this.riskInterpretation,
// //     this.bioMarkers,
// //   });

// //   factory AnalysisResult.fromJson(Map<String, dynamic> json) {
// //     return AnalysisResult(
// //       filename: json['filename'] ?? '',
// //       severityScore: json['severity_score'] ?? 0,
// //       maxScore: json['max_score'] ?? 30,
// //       riskInterpretation: json['risk_interpretation'] ?? '',
// //       bioMarkers: json['bio_markers'] != null
// //           ? BioMarkers.fromJson(json['bio_markers'])
// //           : null,
// //     );
// //   }

// //   /// Returns a normalised 0–100 percentage for progress indicators
// //   double getScorePercentage() {
// //     if (maxScore == 0) return 0;
// //     return (severityScore / maxScore) * 100;
// //   }

// //   /// Low risk   0–10 | Moderate 11–20 | High 21–30
// //   bool isLowRisk() =>
// //       riskInterpretation.toUpperCase().contains('LOW');

// //   bool isModerateRisk() =>
// //       riskInterpretation.toUpperCase().contains('MODERATE');

// //   bool isHighRisk() =>
// //       riskInterpretation.toUpperCase().contains('HIGH');

// //   /// Convenience: colour key for UI
// //   String getRiskLevel() => riskInterpretation;
// // }

// // // ─── Speech Submission (create response) ─────────────────────────────────────
// // class SpeechSubmissionResponse {
// //   final String message;
// //   final SpeechSubmissionWithResult data;
// //   final bool status;

// //   SpeechSubmissionResponse({
// //     required this.message,
// //     required this.data,
// //     required this.status,
// //   });

// //   factory SpeechSubmissionResponse.fromJson(Map<String, dynamic> json) {
// //     return SpeechSubmissionResponse(
// //       message: json['message'] ?? '',
// //       data: SpeechSubmissionWithResult.fromJson(json['data'] ?? {}),
// //       status: json['status'] ?? false,
// //     );
// //   }
// // }

// // /// Used for the POST /api/speech create response (has prediction_result inline)
// // class SpeechSubmissionWithResult {
// //   final String speechSubmissionId;
// //   final String parentUserId;
// //   final String childId;
// //   final String recordingPublicId;
// //   final int recordingDurationSeconds;
// //   final String? recordingFormat;
// //   final String submittedAt;
// //   final AnalysisResult? predictionResult;
// //   final SpeechResult? speechResult;

// //   SpeechSubmissionWithResult({
// //     required this.speechSubmissionId,
// //     required this.parentUserId,
// //     required this.childId,
// //     required this.recordingPublicId,
// //     required this.recordingDurationSeconds,
// //     this.recordingFormat,
// //     required this.submittedAt,
// //     this.predictionResult,
// //     this.speechResult,
// //   });

// //   factory SpeechSubmissionWithResult.fromJson(Map<String, dynamic> json) {
// //     return SpeechSubmissionWithResult(
// //       speechSubmissionId: json['speech_submission_id'] ?? '',
// //       parentUserId: json['parent_user_id'] ?? '',
// //       childId: json['child_id'] ?? '',
// //       recordingPublicId: json['recording_public_id'] ?? '',
// //       recordingDurationSeconds: json['recording_duration_seconds'] ?? 0,
// //       recordingFormat: json['recording_format'],
// //       submittedAt: json['submitted_at'] ?? '',
// //       predictionResult: json['prediction_result'] != null
// //           ? AnalysisResult.fromJson(json['prediction_result'])
// //           : null,
// //       speechResult: json['speech_result'] != null
// //           ? SpeechResult.fromJson(json['speech_result'])
// //           : null,
// //     );
// //   }
// // }

// // // ─── All Submissions (GET /api/speech list) ───────────────────────────────────
// // class AllSpeechSubmissionsResponse {
// //   final String message;
// //   final List<SpeechSubmissionDetail> data;
// //   final bool status;

// //   AllSpeechSubmissionsResponse({
// //     required this.message,
// //     required this.data,
// //     required this.status,
// //   });

// //   factory AllSpeechSubmissionsResponse.fromJson(Map<String, dynamic> json) {
// //     return AllSpeechSubmissionsResponse(
// //       message: json['message'] ?? '',
// //       data: (json['data'] as List<dynamic>?)
// //               ?.map((s) => SpeechSubmissionDetail.fromJson(s))
// //               .toList() ??
// //           [],
// //       status: json['status'] ?? false,
// //     );
// //   }
// // }

// // // ─── Single Submission Detail (GET /api/speech/:id) ──────────────────────────
// // class SingleSpeechSubmissionResponse {
// //   final String message;
// //   final SpeechSubmissionDetail data;
// //   final bool status;

// //   SingleSpeechSubmissionResponse({
// //     required this.message,
// //     required this.data,
// //     required this.status,
// //   });

// //   factory SingleSpeechSubmissionResponse.fromJson(Map<String, dynamic> json) {
// //     return SingleSpeechSubmissionResponse(
// //       message: json['message'] ?? '',
// //       data: SpeechSubmissionDetail.fromJson(json['data'] ?? {}),
// //       status: json['status'] ?? false,
// //     );
// //   }
// // }

// // class SpeechSubmissionDetail {
// //   final String speechSubmissionId;
// //   final String parentUserId;
// //   final String childId;
// //   final String recordingPublicId;
// //   final int recordingDurationSeconds;
// //   final String? recordingFormat;
// //   final String submittedAt;
// //   final ChildInfo? children;
// //   final List<SpeechResult> speechResults;

// //   SpeechSubmissionDetail({
// //     required this.speechSubmissionId,
// //     required this.parentUserId,
// //     required this.childId,
// //     required this.recordingPublicId,
// //     required this.recordingDurationSeconds,
// //     this.recordingFormat,
// //     required this.submittedAt,
// //     this.children,
// //     required this.speechResults,
// //   });

// //   factory SpeechSubmissionDetail.fromJson(Map<String, dynamic> json) {
// //     return SpeechSubmissionDetail(
// //       speechSubmissionId: json['speech_submission_id'] ?? '',
// //       parentUserId: json['parent_user_id'] ?? '',
// //       childId: json['child_id'] ?? '',
// //       recordingPublicId: json['recording_public_id'] ?? '',
// //       recordingDurationSeconds: json['recording_duration_seconds'] ?? 0,
// //       recordingFormat: json['recording_format'],
// //       submittedAt: json['submitted_at'] ?? '',
// //       children: json['children'] != null
// //           ? ChildInfo.fromJson(json['children'])
// //           : null,
// //       speechResults: (json['speech_results'] as List<dynamic>?)
// //               ?.map((r) => SpeechResult.fromJson(r))
// //               .toList() ??
// //           [],
// //     );
// //   }

// //   String getFormattedDate() {
// //     try {
// //       final date = DateTime.parse(submittedAt);
// //       return '${date.day}/${date.month}/${date.year}';
// //     } catch (_) {
// //       return submittedAt;
// //     }
// //   }

// //   String getFormattedTime() {
// //     try {
// //       final date = DateTime.parse(submittedAt);
// //       final hour = date.hour > 12 ? date.hour - 12 : date.hour;
// //       final period = date.hour >= 12 ? 'PM' : 'AM';
// //       return '${hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')} $period';
// //     } catch (_) {
// //       return '';
// //     }
// //   }

// //   String getChildName() => children?.childName ?? 'Unknown';

// //   bool hasResults() => speechResults.isNotEmpty;

// //   SpeechResult? getLatestResult() =>
// //       speechResults.isEmpty ? null : speechResults.first;
// // }

// // class ChildInfo {
// //   final String childName;

// //   ChildInfo({required this.childName});

// //   factory ChildInfo.fromJson(Map<String, dynamic> json) =>
// //       ChildInfo(childName: json['child_name'] ?? '');
// // }

// // // ─── Speech Result ────────────────────────────────────────────────────────────
// // class SpeechResult {
// //   final AnalysisResult result;
// //   final String childId;
// //   final String generatedAt;
// //   final String parentUserId;
// //   final String speechResultId;
// //   final String speechSubmissionId;

// //   SpeechResult({
// //     required this.result,
// //     required this.childId,
// //     required this.generatedAt,
// //     required this.parentUserId,
// //     required this.speechResultId,
// //     required this.speechSubmissionId,
// //   });

// //   factory SpeechResult.fromJson(Map<String, dynamic> json) {
// //     return SpeechResult(
// //       result: AnalysisResult.fromJson(json['result'] ?? {}),
// //       childId: json['child_id'] ?? '',
// //       generatedAt: json['generated_at'] ?? '',
// //       parentUserId: json['parent_user_id'] ?? '',
// //       speechResultId: json['speech_result_id'] ?? '',
// //       speechSubmissionId: json['speech_submission_id'] ?? '',
// //     );
// //   }

// //   String getFormattedDate() {
// //     try {
// //       final date = DateTime.parse(generatedAt);
// //       return '${date.day}/${date.month}/${date.year}';
// //     } catch (_) {
// //       return generatedAt;
// //     }
// //   }
// // }

// // // ─── Delete Response ──────────────────────────────────────────────────────────
// // class DeleteSpeechResponse {
// //   final String message;
// //   final bool status;

// //   DeleteSpeechResponse({required this.message, required this.status});

// //   factory DeleteSpeechResponse.fromJson(Map<String, dynamic> json) =>
// //       DeleteSpeechResponse(
// //         message: json['message'] ?? '',
// //         status: json['status'] ?? false,
// //       );
// // }

// // lib/models/speech_models.dart

// // ─── Child models ─────────────────────────────────────────────────────────────

// class Child {
//   final String childId;
//   final String childName;
//   final String? dateOfBirth;
//   final String? gender;

//   Child({
//     required this.childId,
//     required this.childName,
//     this.dateOfBirth,
//     this.gender,
//   });

//   factory Child.fromJson(Map<String, dynamic> json) {
//     return Child(
//       childId: json['child_id']?.toString() ?? json['id']?.toString() ?? '',
//       childName: json['child_name']?.toString() ??
//           json['name']?.toString() ??
//           'Unknown',
//       dateOfBirth: json['date_of_birth']?.toString(),
//       gender: json['gender']?.toString(),
//     );
//   }
// }

// class ChildrenListResponse {
//   final bool status;
//   final String message;
//   final List<Child> data;

//   ChildrenListResponse({
//     required this.status,
//     required this.message,
//     required this.data,
//   });

//   factory ChildrenListResponse.fromJson(Map<String, dynamic> json) {
//     final dataJson = json['data'];
//     List<Child> children = [];
//     if (dataJson is List) {
//       children = dataJson
//           .map((e) => Child.fromJson(e as Map<String, dynamic>))
//           .toList();
//     }
//     return ChildrenListResponse(
//       status: json['status'] == true,
//       message: json['message']?.toString() ?? '',
//       data: children,
//     );
//   }
// }

// // ─── ChildInfo (embedded in submission list) ──────────────────────────────────

// class ChildInfo {
//   final String childName;

//   ChildInfo({required this.childName});

//   factory ChildInfo.fromJson(Map<String, dynamic> json) {
//     return ChildInfo(
//       childName: json['child_name']?.toString() ??
//           json['name']?.toString() ??
//           'Unknown',
//     );
//   }
// }

// // ─── BioMarkers ───────────────────────────────────────────────────────────────

// class BioMarkers {
//   final double pitchInstability;
//   final double resonanceJitterF1;
//   final double resonanceJitterF2;

//   BioMarkers({
//     required this.pitchInstability,
//     required this.resonanceJitterF1,
//     required this.resonanceJitterF2,
//   });

//   factory BioMarkers.fromJson(Map<String, dynamic> json) {
//     return BioMarkers(
//       pitchInstability:
//           (json['pitch_instability'] as num?)?.toDouble() ?? 0.0,
//       resonanceJitterF1:
//           (json['resonance_jitter_f1'] as num?)?.toDouble() ?? 0.0,
//       resonanceJitterF2:
//           (json['resonance_jitter_f2'] as num?)?.toDouble() ?? 0.0,
//     );
//   }
// }

// // ─── AnalysisResult ───────────────────────────────────────────────────────────
// /// Unified model that handles BOTH response formats:
// ///
// /// **Old format** (from GET /api/speech/:id  ➜  speech_results array):
// /// ```json
// /// {
// ///   "severity_score": 7,
// ///   "max_score": 22,
// ///   "risk_interpretation": "Low Risk",
// ///   "bio_markers": { ... }
// /// }
// /// ```
// ///
// /// **New format** (from POST /api/speech  ➜  speech_result.result):
// /// ```json
// /// {
// ///   "filename": "file_example_WAV_1MG.wav",
// ///   "sa_score": 11.18,
// ///   "severity_percentage": "50.8%",
// ///   "risk_level": "Low",
// ///   "model_type": "Mega-Ensemble (25-fold)"
// /// }
// /// ```

// class AnalysisResult {
//   // ── Shared fields ──────────────────────────────────────────────────────
//   final String riskInterpretation; // "Low Risk" / "Moderate Risk" / "High Risk"

//   // ── Old-format fields ──────────────────────────────────────────────────
//   final int severityScore;
//   final int maxScore;
//   final BioMarkers? bioMarkers;

//   // ── New-format fields ──────────────────────────────────────────────────
//   final double? saScore;           // sa_score
//   final String? severityPercentage; // "50.8%"
//   final String? riskLevel;          // "Low" / "Moderate" / "High"
//   final String? modelType;          // "Mega-Ensemble (25-fold)"
//   final String? filename;

//   AnalysisResult({
//     required this.riskInterpretation,
//     required this.severityScore,
//     required this.maxScore,
//     this.bioMarkers,
//     this.saScore,
//     this.severityPercentage,
//     this.riskLevel,
//     this.modelType,
//     this.filename,
//   });

//   // ── Risk helpers ───────────────────────────────────────────────────────
//   bool isHighRisk() {
//     final lower = riskInterpretation.toLowerCase();
//     final levelLower = (riskLevel ?? '').toLowerCase();
//     return lower.contains('high') || levelLower == 'high';
//   }

//   bool isModerateRisk() {
//     final lower = riskInterpretation.toLowerCase();
//     final levelLower = (riskLevel ?? '').toLowerCase();
//     return lower.contains('moderate') || levelLower == 'moderate';
//   }

//   bool isLowRisk() {
//     return !isHighRisk() && !isModerateRisk();
//   }

//   // ── Factory — handles both formats ────────────────────────────────────
//   factory AnalysisResult.fromJson(Map<String, dynamic> json) {
//     // Detect format by presence of "sa_score" (new) vs "severity_score" (old)
//     final bool isNewFormat = json.containsKey('sa_score') ||
//         json.containsKey('risk_level');

//     if (isNewFormat) {
//       // ── NEW format ───────────────────────────────────────────────────
//       final riskLevel = json['risk_level']?.toString() ?? '';
//       final saScore = (json['sa_score'] as num?)?.toDouble() ?? 0.0;
//       final severityPct = json['severity_percentage']?.toString() ?? '0%';

//       // Convert risk_level → human-readable interpretation
//       String riskInterpretation;
//       switch (riskLevel.toLowerCase()) {
//         case 'high':
//           riskInterpretation = 'High Risk';
//           break;
//         case 'moderate':
//           riskInterpretation = 'Moderate Risk';
//           break;
//         default:
//           riskInterpretation = 'Low Risk';
//       }

//       // Derive a pseudo severity-score out of 22 from the sa_score
//       // (sa_score appears to be on a 0-22 scale based on the example 11.18/22)
//       final int severityScore = saScore.round().clamp(0, 22);

//       return AnalysisResult(
//         riskInterpretation: riskInterpretation,
//         severityScore: severityScore,
//         maxScore: 22,
//         bioMarkers: null, // new format doesn't include bio-markers
//         saScore: saScore,
//         severityPercentage: severityPct,
//         riskLevel: riskLevel,
//         modelType: json['model_type']?.toString(),
//         filename: json['filename']?.toString(),
//       );
//     } else {
//       // ── OLD format ───────────────────────────────────────────────────
//       BioMarkers? bioMarkers;
//       if (json['bio_markers'] != null) {
//         bioMarkers = BioMarkers.fromJson(
//             json['bio_markers'] as Map<String, dynamic>);
//       }

//       return AnalysisResult(
//         riskInterpretation:
//             json['risk_interpretation']?.toString() ?? 'Low Risk',
//         severityScore: (json['severity_score'] as num?)?.toInt() ?? 0,
//         maxScore: (json['max_score'] as num?)?.toInt() ?? 22,
//         bioMarkers: bioMarkers,
//       );
//     }
//   }
// }

// // ─── SpeechResult (item inside speech_results array) ─────────────────────────

// class SpeechResult {
//   final String speechResultId;
//   final String speechSubmissionId;
//   final AnalysisResult result;
//   final String generatedAt;

//   SpeechResult({
//     required this.speechResultId,
//     required this.speechSubmissionId,
//     required this.result,
//     required this.generatedAt,
//   });

//   factory SpeechResult.fromJson(Map<String, dynamic> json) {
//     // The "result" field contains the actual analysis data
//     final resultJson = json['result'] as Map<String, dynamic>? ?? {};

//     return SpeechResult(
//       speechResultId: json['speech_result_id']?.toString() ?? '',
//       speechSubmissionId: json['speech_submission_id']?.toString() ?? '',
//       result: AnalysisResult.fromJson(resultJson),
//       generatedAt: json['generated_at']?.toString() ?? '',
//     );
//   }
// }

// // ─── SpeechSubmissionDetail (used in list + detail screens) ──────────────────

// class SpeechSubmissionDetail {
//   final String speechSubmissionId;
//   final String parentUserId;
//   final String childId;
//   final String? recordingPublicId;
//   final int recordingDurationSeconds;
//   final String? recordingFormat;
//   final String submittedAt;
//   final ChildInfo? children;
//   final List<SpeechResult> speechResults;

//   SpeechSubmissionDetail({
//     required this.speechSubmissionId,
//     required this.parentUserId,
//     required this.childId,
//     this.recordingPublicId,
//     required this.recordingDurationSeconds,
//     this.recordingFormat,
//     required this.submittedAt,
//     this.children,
//     required this.speechResults,
//   });

//   // ── Convenience helpers ────────────────────────────────────────────────
//   String getChildName() => children?.childName ?? 'Unknown Child';

//   bool hasResults() => speechResults.isNotEmpty;

//   SpeechResult? getLatestResult() =>
//       speechResults.isNotEmpty ? speechResults.last : null;

//   String getFormattedDate() {
//     try {
//       final dt = DateTime.parse(submittedAt).toLocal();
//       return '${dt.day}/${dt.month}/${dt.year}';
//     } catch (_) {
//       return submittedAt;
//     }
//   }

//   String getFormattedTime() {
//     try {
//       final dt = DateTime.parse(submittedAt).toLocal();
//       final h = dt.hour.toString().padLeft(2, '0');
//       final m = dt.minute.toString().padLeft(2, '0');
//       return '$h:$m';
//     } catch (_) {
//       return '';
//     }
//   }

//   factory SpeechSubmissionDetail.fromJson(Map<String, dynamic> json) {
//     ChildInfo? childInfo;
//     if (json['children'] != null) {
//       childInfo =
//           ChildInfo.fromJson(json['children'] as Map<String, dynamic>);
//     }

//     List<SpeechResult> results = [];
//     if (json['speech_results'] != null) {
//       results = (json['speech_results'] as List)
//           .map((e) => SpeechResult.fromJson(e as Map<String, dynamic>))
//           .toList();
//     }

//     return SpeechSubmissionDetail(
//       speechSubmissionId:
//           json['speech_submission_id']?.toString() ?? '',
//       parentUserId: json['parent_user_id']?.toString() ?? '',
//       childId: json['child_id']?.toString() ?? '',
//       recordingPublicId: json['recording_public_id']?.toString(),
//       recordingDurationSeconds:
//           (json['recording_duration_seconds'] as num?)?.toInt() ?? 0,
//       recordingFormat: json['recording_format']?.toString(),
//       submittedAt: json['submitted_at']?.toString() ?? '',
//       children: childInfo,
//       speechResults: results,
//     );
//   }
// }

// // ─── PredictionResult (inline in POST response) ───────────────────────────────

// class PredictionResult {
//   final String filename;
//   final double saScore;
//   final String severityPercentage;
//   final String riskLevel;
//   final String modelType;

//   PredictionResult({
//     required this.filename,
//     required this.saScore,
//     required this.severityPercentage,
//     required this.riskLevel,
//     required this.modelType,
//   });

//   String get riskInterpretation {
//     switch (riskLevel.toLowerCase()) {
//       case 'high':
//         return 'High Risk';
//       case 'moderate':
//         return 'Moderate Risk';
//       default:
//         return 'Low Risk';
//     }
//   }

//   int get severityScore => saScore.round().clamp(0, 22);
//   int get maxScore => 22;

//   factory PredictionResult.fromJson(Map<String, dynamic> json) {
//     return PredictionResult(
//       filename: json['filename']?.toString() ?? '',
//       saScore: (json['sa_score'] as num?)?.toDouble() ?? 0.0,
//       severityPercentage: json['severity_percentage']?.toString() ?? '0%',
//       riskLevel: json['risk_level']?.toString() ?? 'Low',
//       modelType: json['model_type']?.toString() ?? '',
//     );
//   }
// }

// // ─── SpeechSubmissionWithResult (POST /api/speech response data) ───────────────

// class SpeechSubmissionWithResult {
//   final String speechSubmissionId;
//   final String parentUserId;
//   final String childId;
//   final String? recordingPublicId;
//   final int recordingDurationSeconds;
//   final String? recordingFormat;
//   final String submittedAt;
//   final PredictionResult? predictionResult;
//   final SpeechResult? speechResult;

//   SpeechSubmissionWithResult({
//     required this.speechSubmissionId,
//     required this.parentUserId,
//     required this.childId,
//     this.recordingPublicId,
//     required this.recordingDurationSeconds,
//     this.recordingFormat,
//     required this.submittedAt,
//     this.predictionResult,
//     this.speechResult,
//   });

//   factory SpeechSubmissionWithResult.fromJson(Map<String, dynamic> json) {
//     PredictionResult? prediction;
//     if (json['prediction_result'] != null) {
//       prediction = PredictionResult.fromJson(
//           json['prediction_result'] as Map<String, dynamic>);
//     }

//     SpeechResult? speechResult;
//     if (json['speech_result'] != null) {
//       speechResult = SpeechResult.fromJson(
//           json['speech_result'] as Map<String, dynamic>);
//     }

//     return SpeechSubmissionWithResult(
//       speechSubmissionId:
//           json['speech_submission_id']?.toString() ?? '',
//       parentUserId: json['parent_user_id']?.toString() ?? '',
//       childId: json['child_id']?.toString() ?? '',
//       recordingPublicId: json['recording_public_id']?.toString(),
//       recordingDurationSeconds:
//           (json['recording_duration_seconds'] as num?)?.toInt() ?? 0,
//       recordingFormat: json['recording_format']?.toString(),
//       submittedAt: json['submitted_at']?.toString() ?? '',
//       predictionResult: prediction,
//       speechResult: speechResult,
//     );
//   }
// }

// // ─── API Response wrappers ────────────────────────────────────────────────────

// class SpeechSubmissionResponse {
//   final bool status;
//   final String message;
//   final SpeechSubmissionWithResult data;

//   SpeechSubmissionResponse({
//     required this.status,
//     required this.message,
//     required this.data,
//   });

//   factory SpeechSubmissionResponse.fromJson(Map<String, dynamic> json) {
//     return SpeechSubmissionResponse(
//       status: json['status'] == true,
//       message: json['message']?.toString() ?? '',
//       data: SpeechSubmissionWithResult.fromJson(
//           json['data'] as Map<String, dynamic>),
//     );
//   }
// }

// class AllSpeechSubmissionsResponse {
//   final bool status;
//   final String message;
//   final List<SpeechSubmissionDetail> data;

//   AllSpeechSubmissionsResponse({
//     required this.status,
//     required this.message,
//     required this.data,
//   });

//   factory AllSpeechSubmissionsResponse.fromJson(Map<String, dynamic> json) {
//     final dataJson = json['data'];
//     List<SpeechSubmissionDetail> submissions = [];
//     if (dataJson is List) {
//       submissions = dataJson
//           .map((e) =>
//               SpeechSubmissionDetail.fromJson(e as Map<String, dynamic>))
//           .toList();
//     }
//     return AllSpeechSubmissionsResponse(
//       status: json['status'] == true,
//       message: json['message']?.toString() ?? '',
//       data: submissions,
//     );
//   }
// }

// class SingleSpeechSubmissionResponse {
//   final bool status;
//   final String message;
//   final SpeechSubmissionDetail data;

//   SingleSpeechSubmissionResponse({
//     required this.status,
//     required this.message,
//     required this.data,
//   });

//   factory SingleSpeechSubmissionResponse.fromJson(
//       Map<String, dynamic> json) {
//     return SingleSpeechSubmissionResponse(
//       status: json['status'] == true,
//       message: json['message']?.toString() ?? '',
//       data: SpeechSubmissionDetail.fromJson(
//           json['data'] as Map<String, dynamic>),
//     );
//   }
// }

// class DeleteSpeechResponse {
//   final bool status;
//   final String message;

//   DeleteSpeechResponse({required this.status, required this.message});

//   factory DeleteSpeechResponse.fromJson(Map<String, dynamic> json) {
//     return DeleteSpeechResponse(
//       status: json['status'] == true,
//       message: json['message']?.toString() ?? '',
//     );
//   }
// }


// lib/models/speech_models.dart

// ─── Child models ─────────────────────────────────────────────────────────────

class Child {
  final String childId;
  final String childName;
  final String? dateOfBirth;
  final String? gender;

  Child({
    required this.childId,
    required this.childName,
    this.dateOfBirth,
    this.gender,
  });

  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(
      childId: json['child_id']?.toString() ?? json['id']?.toString() ?? '',
      childName: json['child_name']?.toString() ??
          json['name']?.toString() ??
          'Unknown',
      dateOfBirth: json['date_of_birth']?.toString(),
      gender: json['gender']?.toString(),
    );
  }
}

class ChildrenListResponse {
  final bool status;
  final String message;
  final List<Child> data;

  ChildrenListResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ChildrenListResponse.fromJson(Map<String, dynamic> json) {
    final dataJson = json['data'];
    List<Child> children = [];
    if (dataJson is List) {
      children = dataJson
          .map((e) => Child.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return ChildrenListResponse(
      status: json['status'] == true,
      message: json['message']?.toString() ?? '',
      data: children,
    );
  }
}

// ─── ChildInfo ────────────────────────────────────────────────────────────────

class ChildInfo {
  final String childName;

  ChildInfo({required this.childName});

  factory ChildInfo.fromJson(Map<String, dynamic> json) {
    return ChildInfo(
      childName: json['child_name']?.toString() ??
          json['name']?.toString() ??
          'Unknown',
    );
  }
}

// ─── BioMarkers ───────────────────────────────────────────────────────────────

class BioMarkers {
  final double pitchInstability;
  final double resonanceJitterF1;
  final double resonanceJitterF2;

  BioMarkers({
    required this.pitchInstability,
    required this.resonanceJitterF1,
    required this.resonanceJitterF2,
  });

  factory BioMarkers.fromJson(Map<String, dynamic> json) {
    return BioMarkers(
      pitchInstability:
          (json['pitch_instability'] as num?)?.toDouble() ?? 0.0,
      resonanceJitterF1:
          (json['resonance_jitter_f1'] as num?)?.toDouble() ?? 0.0,
      resonanceJitterF2:
          (json['resonance_jitter_f2'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

// ─── AnalysisResult ───────────────────────────────────────────────────────────
/// Handles BOTH response formats:
///
/// NEW format (POST response / GET list items):
/// { "sa_score": 14.91, "severity_percentage": "67.8%",
///   "risk_level": "Moderate", "model_type": "Mega-Ensemble (25-fold)" }
///
/// OLD format (legacy):
/// { "severity_score": 7, "max_score": 22,
///   "risk_interpretation": "Low Risk", "bio_markers": {...} }

class AnalysisResult {
  final String riskInterpretation;
  final int severityScore;
  final int maxScore;
  final BioMarkers? bioMarkers;

  // New-format only
  final double? saScore;
  final String? severityPercentage;
  final String? riskLevel;
  final String? modelType;
  final String? filename;

  AnalysisResult({
    required this.riskInterpretation,
    required this.severityScore,
    required this.maxScore,
    this.bioMarkers,
    this.saScore,
    this.severityPercentage,
    this.riskLevel,
    this.modelType,
    this.filename,
  });

  bool isHighRisk() {
    final lower = riskInterpretation.toLowerCase();
    final levelLower = (riskLevel ?? '').toLowerCase();
    return lower.contains('high') || levelLower == 'high';
  }

  bool isModerateRisk() {
    final lower = riskInterpretation.toLowerCase();
    final levelLower = (riskLevel ?? '').toLowerCase();
    return lower.contains('moderate') || levelLower == 'moderate';
  }

  bool isLowRisk() => !isHighRisk() && !isModerateRisk();

  factory AnalysisResult.fromJson(Map<String, dynamic> json) {
    final bool isNewFormat =
        json.containsKey('sa_score') || json.containsKey('risk_level');

    if (isNewFormat) {
      final riskLevel = json['risk_level']?.toString() ?? '';
      final saScore = (json['sa_score'] as num?)?.toDouble() ?? 0.0;
      final severityPct = json['severity_percentage']?.toString() ?? '0%';

      String riskInterpretation;
      switch (riskLevel.toLowerCase()) {
        case 'high':
          riskInterpretation = 'High Risk';
          break;
        case 'moderate':
          riskInterpretation = 'Moderate Risk';
          break;
        default:
          riskInterpretation = 'Low Risk';
      }

      return AnalysisResult(
        riskInterpretation: riskInterpretation,
        severityScore: saScore.round().clamp(0, 22),
        maxScore: 22,
        bioMarkers: null,
        saScore: saScore,
        severityPercentage: severityPct,
        riskLevel: riskLevel,
        modelType: json['model_type']?.toString(),
        filename: json['filename']?.toString(),
      );
    } else {
      BioMarkers? bioMarkers;
      if (json['bio_markers'] != null) {
        bioMarkers = BioMarkers.fromJson(
            json['bio_markers'] as Map<String, dynamic>);
      }
      return AnalysisResult(
        riskInterpretation:
            json['risk_interpretation']?.toString() ?? 'Low Risk',
        severityScore: (json['severity_score'] as num?)?.toInt() ?? 0,
        maxScore: (json['max_score'] as num?)?.toInt() ?? 22,
        bioMarkers: bioMarkers,
      );
    }
  }
}

// ─── SpeechResult ─────────────────────────────────────────────────────────────

class SpeechResult {
  final String speechResultId;
  final String speechSubmissionId;
  final AnalysisResult result;
  final String generatedAt;

  SpeechResult({
    required this.speechResultId,
    required this.speechSubmissionId,
    required this.result,
    required this.generatedAt,
  });

  factory SpeechResult.fromJson(Map<String, dynamic> json) {
    final resultJson = json['result'] as Map<String, dynamic>? ?? {};
    return SpeechResult(
      speechResultId: json['speech_result_id']?.toString() ?? '',
      speechSubmissionId: json['speech_submission_id']?.toString() ?? '',
      result: AnalysisResult.fromJson(resultJson),
      generatedAt: json['generated_at']?.toString() ?? '',
    );
  }
}

// ─── SpeechSubmissionDetail ───────────────────────────────────────────────────
/// Used in list + detail screens.
///
/// Handles all server shapes:
///   • GET /api/speech  list  → each item has "speech_result" (singular)
///   • GET /api/speech/:id    → has "speech_results" (array)
///   • POST /api/speech       → has "speech_result" (singular)

class SpeechSubmissionDetail {
  final String speechSubmissionId;
  final String parentUserId;
  final String childId;
  final String? recordingPublicId;
  final int recordingDurationSeconds;
  final String? recordingFormat;
  final String submittedAt;
  final ChildInfo? children;
  final List<SpeechResult> speechResults;

  SpeechSubmissionDetail({
    required this.speechSubmissionId,
    required this.parentUserId,
    required this.childId,
    this.recordingPublicId,
    required this.recordingDurationSeconds,
    this.recordingFormat,
    required this.submittedAt,
    this.children,
    required this.speechResults,
  });

  String getChildName() => children?.childName ?? 'Unknown Child';
  bool hasResults() => speechResults.isNotEmpty;
  SpeechResult? getLatestResult() =>
      speechResults.isNotEmpty ? speechResults.last : null;

  String getFormattedDate() {
    try {
      final dt = DateTime.parse(submittedAt).toLocal();
      return '${dt.day}/${dt.month}/${dt.year}';
    } catch (_) {
      return submittedAt;
    }
  }

  String getFormattedTime() {
    try {
      final dt = DateTime.parse(submittedAt).toLocal();
      final h = dt.hour.toString().padLeft(2, '0');
      final m = dt.minute.toString().padLeft(2, '0');
      return '$h:$m';
    } catch (_) {
      return '';
    }
  }

  factory SpeechSubmissionDetail.fromJson(Map<String, dynamic> json) {
    ChildInfo? childInfo;
    if (json['children'] != null) {
      childInfo =
          ChildInfo.fromJson(json['children'] as Map<String, dynamic>);
    }

    List<SpeechResult> results = [];

    // ── Shape A: "speech_results" array (GET /api/speech/:id) ─────────────
    if (json['speech_results'] is List &&
        (json['speech_results'] as List).isNotEmpty) {
      results = (json['speech_results'] as List)
          .map((e) => SpeechResult.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    // ── Shape B: "speech_result" singular (GET list / POST) ───────────────
    if (results.isEmpty && json['speech_result'] is Map) {
      results = [
        SpeechResult.fromJson(
            json['speech_result'] as Map<String, dynamic>)
      ];
    }

    return SpeechSubmissionDetail(
      speechSubmissionId:
          json['speech_submission_id']?.toString() ?? '',
      parentUserId: json['parent_user_id']?.toString() ?? '',
      childId: json['child_id']?.toString() ?? '',
      recordingPublicId: json['recording_public_id']?.toString(),
      recordingDurationSeconds:
          (json['recording_duration_seconds'] as num?)?.toInt() ?? 0,
      recordingFormat: json['recording_format']?.toString(),
      submittedAt: json['submitted_at']?.toString() ?? '',
      children: childInfo,
      speechResults: results,
    );
  }
}

// ─── PredictionResult ─────────────────────────────────────────────────────────

class PredictionResult {
  final String filename;
  final double saScore;
  final String severityPercentage;
  final String riskLevel;
  final String modelType;

  PredictionResult({
    required this.filename,
    required this.saScore,
    required this.severityPercentage,
    required this.riskLevel,
    required this.modelType,
  });

  String get riskInterpretation {
    switch (riskLevel.toLowerCase()) {
      case 'high':
        return 'High Risk';
      case 'moderate':
        return 'Moderate Risk';
      default:
        return 'Low Risk';
    }
  }

  int get severityScore => saScore.round().clamp(0, 22);
  int get maxScore => 22;

  factory PredictionResult.fromJson(Map<String, dynamic> json) {
    return PredictionResult(
      filename: json['filename']?.toString() ?? '',
      saScore: (json['sa_score'] as num?)?.toDouble() ?? 0.0,
      severityPercentage: json['severity_percentage']?.toString() ?? '0%',
      riskLevel: json['risk_level']?.toString() ?? 'Low',
      modelType: json['model_type']?.toString() ?? '',
    );
  }
}

// ─── SpeechSubmissionWithResult (POST /api/speech response data) ───────────────

class SpeechSubmissionWithResult {
  final String speechSubmissionId;
  final String parentUserId;
  final String childId;
  final String? recordingPublicId;
  final int recordingDurationSeconds;
  final String? recordingFormat;
  final String submittedAt;
  final PredictionResult? predictionResult;
  final SpeechResult? speechResult;

  SpeechSubmissionWithResult({
    required this.speechSubmissionId,
    required this.parentUserId,
    required this.childId,
    this.recordingPublicId,
    required this.recordingDurationSeconds,
    this.recordingFormat,
    required this.submittedAt,
    this.predictionResult,
    this.speechResult,
  });

  /// Convert to SpeechSubmissionDetail for use in detail screen
  SpeechSubmissionDetail toDetail({String? childName}) {
    final results = <SpeechResult>[];
    if (speechResult != null) results.add(speechResult!);
    return SpeechSubmissionDetail(
      speechSubmissionId: speechSubmissionId,
      parentUserId: parentUserId,
      childId: childId,
      recordingPublicId: recordingPublicId,
      recordingDurationSeconds: recordingDurationSeconds,
      recordingFormat: recordingFormat,
      submittedAt: submittedAt,
      children: childName != null ? ChildInfo(childName: childName) : null,
      speechResults: results,
    );
  }

  factory SpeechSubmissionWithResult.fromJson(Map<String, dynamic> json) {
    PredictionResult? prediction;
    if (json['prediction_result'] != null) {
      prediction = PredictionResult.fromJson(
          json['prediction_result'] as Map<String, dynamic>);
    }

    SpeechResult? speechResult;
    if (json['speech_result'] != null) {
      speechResult = SpeechResult.fromJson(
          json['speech_result'] as Map<String, dynamic>);
    }

    return SpeechSubmissionWithResult(
      speechSubmissionId:
          json['speech_submission_id']?.toString() ?? '',
      parentUserId: json['parent_user_id']?.toString() ?? '',
      childId: json['child_id']?.toString() ?? '',
      recordingPublicId: json['recording_public_id']?.toString(),
      recordingDurationSeconds:
          (json['recording_duration_seconds'] as num?)?.toInt() ?? 0,
      recordingFormat: json['recording_format']?.toString(),
      submittedAt: json['submitted_at']?.toString() ?? '',
      predictionResult: prediction,
      speechResult: speechResult,
    );
  }
}

// ─── API Response wrappers ────────────────────────────────────────────────────

class SpeechSubmissionResponse {
  final bool status;
  final String message;
  final SpeechSubmissionWithResult data;

  SpeechSubmissionResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SpeechSubmissionResponse.fromJson(Map<String, dynamic> json) {
    return SpeechSubmissionResponse(
      status: json['status'] == true,
      message: json['message']?.toString() ?? '',
      data: SpeechSubmissionWithResult.fromJson(
          json['data'] as Map<String, dynamic>),
    );
  }
}

class AllSpeechSubmissionsResponse {
  final bool status;
  final String message;
  final List<SpeechSubmissionDetail> data;

  AllSpeechSubmissionsResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AllSpeechSubmissionsResponse.fromJson(Map<String, dynamic> json) {
    final dataJson = json['data'];
    List<SpeechSubmissionDetail> submissions = [];
    if (dataJson is List) {
      submissions = dataJson
          .map((e) =>
              SpeechSubmissionDetail.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return AllSpeechSubmissionsResponse(
      status: json['status'] == true,
      message: json['message']?.toString() ?? '',
      data: submissions,
    );
  }
}

class SingleSpeechSubmissionResponse {
  final bool status;
  final String message;
  final SpeechSubmissionDetail data;

  SingleSpeechSubmissionResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SingleSpeechSubmissionResponse.fromJson(
      Map<String, dynamic> json) {
    return SingleSpeechSubmissionResponse(
      status: json['status'] == true,
      message: json['message']?.toString() ?? '',
      data: SpeechSubmissionDetail.fromJson(
          json['data'] as Map<String, dynamic>),
    );
  }
}

class DeleteSpeechResponse {
  final bool status;
  final String message;

  DeleteSpeechResponse({required this.status, required this.message});

  factory DeleteSpeechResponse.fromJson(Map<String, dynamic> json) {
    return DeleteSpeechResponse(
      status: json['status'] == true,
      message: json['message']?.toString() ?? '',
    );
  }
}