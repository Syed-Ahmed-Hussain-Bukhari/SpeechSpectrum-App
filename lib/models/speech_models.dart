// // lib/models/speech_models.dart

// class ChildrenListResponse {
//   final String message;
//   final List<Child> data;
//   final bool status;

//   ChildrenListResponse({
//     required this.message,
//     required this.data,
//     required this.status,
//   });

//   factory ChildrenListResponse.fromJson(Map<String, dynamic> json) {
//     return ChildrenListResponse(
//       message: json['message'] ?? '',
//       data: (json['data'] as List<dynamic>?)
//               ?.map((child) => Child.fromJson(child))
//               .toList() ??
//           [],
//       status: json['status'] ?? false,
//     );
//   }
// }

// class Child {
//   final String childId;
//   final String parentUserId;
//   final String childName;
//   final String dateOfBirth;
//   final String gender;
//   final String createdAt;

//   Child({
//     required this.childId,
//     required this.parentUserId,
//     required this.childName,
//     required this.dateOfBirth,
//     required this.gender,
//     required this.createdAt,
//   });

//   factory Child.fromJson(Map<String, dynamic> json) {
//     return Child(
//       childId: json['child_id'] ?? '',
//       parentUserId: json['parent_user_id'] ?? '',
//       childName: json['child_name'] ?? '',
//       dateOfBirth: json['date_of_birth'] ?? '',
//       gender: json['gender'] ?? '',
//       createdAt: json['created_at'] ?? '',
//     );
//   }

//   String getAge() {
//     try {
//       final dob = DateTime.parse(dateOfBirth);
//       final now = DateTime.now();
//       final age = now.year - dob.year;
//       if (now.month < dob.month ||
//           (now.month == dob.month && now.day < dob.day)) {
//         return '${age - 1} years';
//       }
//       return '$age years';
//     } catch (e) {
//       return 'N/A';
//     }
//   }

//   String getFormattedDOB() {
//     try {
//       final dob = DateTime.parse(dateOfBirth);
//       return '${dob.day}/${dob.month}/${dob.year}';
//     } catch (e) {
//       return dateOfBirth;
//     }
//   }
// }

// class SpeechSubmissionResponse {
//   final String message;
//   final SpeechSubmission data;
//   final bool status;

//   SpeechSubmissionResponse({
//     required this.message,
//     required this.data,
//     required this.status,
//   });

//   factory SpeechSubmissionResponse.fromJson(Map<String, dynamic> json) {
//     return SpeechSubmissionResponse(
//       message: json['message'] ?? '',
//       data: SpeechSubmission.fromJson(json['data'] ?? {}),
//       status: json['status'] ?? false,
//     );
//   }
// }

// class AllSpeechSubmissionsResponse {
//   final String message;
//   final List<SpeechSubmissionDetail> data;
//   final bool status;

//   AllSpeechSubmissionsResponse({
//     required this.message,
//     required this.data,
//     required this.status,
//   });

//   factory AllSpeechSubmissionsResponse.fromJson(Map<String, dynamic> json) {
//     return AllSpeechSubmissionsResponse(
//       message: json['message'] ?? '',
//       data: (json['data'] as List<dynamic>?)
//               ?.map((submission) => SpeechSubmissionDetail.fromJson(submission))
//               .toList() ??
//           [],
//       status: json['status'] ?? false,
//     );
//   }
// }

// class SpeechSubmission {
//   final String speechSubmissionId;
//   final String parentUserId;
//   final String childId;
//   final String recordingPublicId;
//   final int recordingDurationSeconds;
//   final String? recordingFormat;
//   final String submittedAt;

//   SpeechSubmission({
//     required this.speechSubmissionId,
//     required this.parentUserId,
//     required this.childId,
//     required this.recordingPublicId,
//     required this.recordingDurationSeconds,
//     this.recordingFormat,
//     required this.submittedAt,
//   });

//   factory SpeechSubmission.fromJson(Map<String, dynamic> json) {
//     return SpeechSubmission(
//       speechSubmissionId: json['speech_submission_id'] ?? '',
//       parentUserId: json['parent_user_id'] ?? '',
//       childId: json['child_id'] ?? '',
//       recordingPublicId: json['recording_public_id'] ?? '',
//       recordingDurationSeconds: json['recording_duration_seconds'] ?? 0,
//       recordingFormat: json['recording_format'],
//       submittedAt: json['submitted_at'] ?? '',
//     );
//   }

//   String getFormattedDate() {
//     try {
//       final date = DateTime.parse(submittedAt);
//       return '${date.day}/${date.month}/${date.year}';
//     } catch (e) {
//       return submittedAt;
//     }
//   }

//   String getFormattedTime() {
//     try {
//       final date = DateTime.parse(submittedAt);
//       final hour = date.hour > 12 ? date.hour - 12 : date.hour;
//       final period = date.hour >= 12 ? 'PM' : 'AM';
//       return '${hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')} $period';
//     } catch (e) {
//       return '';
//     }
//   }
// }

// class SpeechSubmissionDetail {
//   final String speechSubmissionId;
//   final String parentUserId;
//   final String childId;
//   final String recordingPublicId;
//   final int recordingDurationSeconds;
//   final String? recordingFormat;
//   final String submittedAt;
//   final ChildInfo? children;
//   final List<SpeechResult> speechResults;

//   SpeechSubmissionDetail({
//     required this.speechSubmissionId,
//     required this.parentUserId,
//     required this.childId,
//     required this.recordingPublicId,
//     required this.recordingDurationSeconds,
//     this.recordingFormat,
//     required this.submittedAt,
//     this.children,
//     required this.speechResults,
//   });

//   factory SpeechSubmissionDetail.fromJson(Map<String, dynamic> json) {
//     return SpeechSubmissionDetail(
//       speechSubmissionId: json['speech_submission_id'] ?? '',
//       parentUserId: json['parent_user_id'] ?? '',
//       childId: json['child_id'] ?? '',
//       recordingPublicId: json['recording_public_id'] ?? '',
//       recordingDurationSeconds: json['recording_duration_seconds'] ?? 0,
//       recordingFormat: json['recording_format'],
//       submittedAt: json['submitted_at'] ?? '',
//       children: json['children'] != null
//           ? ChildInfo.fromJson(json['children'])
//           : null,
//       speechResults: (json['speech_results'] as List<dynamic>?)
//               ?.map((result) => SpeechResult.fromJson(result))
//               .toList() ??
//           [],
//     );
//   }

//   String getFormattedDate() {
//     try {
//       final date = DateTime.parse(submittedAt);
//       return '${date.day}/${date.month}/${date.year}';
//     } catch (e) {
//       return submittedAt;
//     }
//   }

//   String getFormattedTime() {
//     try {
//       final date = DateTime.parse(submittedAt);
//       final hour = date.hour > 12 ? date.hour - 12 : date.hour;
//       final period = date.hour >= 12 ? 'PM' : 'AM';
//       return '${hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')} $period';
//     } catch (e) {
//       return '';
//     }
//   }

//   String getChildName() {
//     return children?.childName ?? 'Unknown';
//   }

//   bool hasResults() {
//     return speechResults.isNotEmpty;
//   }

//   SpeechResult? getLatestResult() {
//     if (speechResults.isEmpty) return null;
//     return speechResults.first;
//   }
// }

// class ChildInfo {
//   final String childName;

//   ChildInfo({required this.childName});

//   factory ChildInfo.fromJson(Map<String, dynamic> json) {
//     return ChildInfo(
//       childName: json['child_name'] ?? '',
//     );
//   }
// }

// class SpeechResult {
//   final ResultData result;
//   final String childId;
//   final String generatedAt;
//   final String parentUserId;
//   final String speechResultId;
//   final String speechSubmissionId;

//   SpeechResult({
//     required this.result,
//     required this.childId,
//     required this.generatedAt,
//     required this.parentUserId,
//     required this.speechResultId,
//     required this.speechSubmissionId,
//   });

//   factory SpeechResult.fromJson(Map<String, dynamic> json) {
//     return SpeechResult(
//       result: ResultData.fromJson(json['result'] ?? {}),
//       childId: json['child_id'] ?? '',
//       generatedAt: json['generated_at'] ?? '',
//       parentUserId: json['parent_user_id'] ?? '',
//       speechResultId: json['speech_result_id'] ?? '',
//       speechSubmissionId: json['speech_submission_id'] ?? '',
//     );
//   }
// }

// class ResultData {
//   final AnalysisResult result;
//   final String filename;

//   ResultData({
//     required this.result,
//     required this.filename,
//   });

//   factory ResultData.fromJson(Map<String, dynamic> json) {
//     return ResultData(
//       result: AnalysisResult.fromJson(json['result'] ?? {}),
//       filename: json['filename'] ?? '',
//     );
//   }
// }

// class AnalysisResult {
//   final String label;
//   final int score;

//   AnalysisResult({
//     required this.label,
//     required this.score,
//   });

//   factory AnalysisResult.fromJson(Map<String, dynamic> json) {
//     return AnalysisResult(
//       label: json['label'] ?? '',
//       score: json['score'] ?? 0,
//     );
//   }

//   bool isTypical() => label.toLowerCase() == 'typical';
//   bool isAtypical() => label.toLowerCase() == 'atypical';

//   String getScorePercentage() {
//     return '${score}%';
//   }
// }

// class DeleteSpeechResponse {
//   final String message;
//   final bool status;

//   DeleteSpeechResponse({
//     required this.message,
//     required this.status,
//   });

//   factory DeleteSpeechResponse.fromJson(Map<String, dynamic> json) {
//     return DeleteSpeechResponse(
//       message: json['message'] ?? '',
//       status: json['status'] ?? false,
//     );
//   }
// }
// lib/models/speech_models.dart

class ChildrenListResponse {
  final String message;
  final List<Child> data;
  final bool status;

  ChildrenListResponse({
    required this.message,
    required this.data,
    required this.status,
  });

  factory ChildrenListResponse.fromJson(Map<String, dynamic> json) {
    return ChildrenListResponse(
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map((child) => Child.fromJson(child))
              .toList() ??
          [],
      status: json['status'] ?? false,
    );
  }
}

class Child {
  final String childId;
  final String parentUserId;
  final String childName;
  final String dateOfBirth;
  final String gender;
  final String createdAt;

  Child({
    required this.childId,
    required this.parentUserId,
    required this.childName,
    required this.dateOfBirth,
    required this.gender,
    required this.createdAt,
  });

  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(
      childId: json['child_id'] ?? '',
      parentUserId: json['parent_user_id'] ?? '',
      childName: json['child_name'] ?? '',
      dateOfBirth: json['date_of_birth'] ?? '',
      gender: json['gender'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }

  String getAge() {
    try {
      final dob = DateTime.parse(dateOfBirth);
      final now = DateTime.now();
      final age = now.year - dob.year;
      if (now.month < dob.month ||
          (now.month == dob.month && now.day < dob.day)) {
        return '${age - 1} years';
      }
      return '$age years';
    } catch (e) {
      return 'N/A';
    }
  }

  String getFormattedDOB() {
    try {
      final dob = DateTime.parse(dateOfBirth);
      return '${dob.day}/${dob.month}/${dob.year}';
    } catch (e) {
      return dateOfBirth;
    }
  }
}

// ─── NEW: Bio Markers ────────────────────────────────────────────────────────
class BioMarkers {
  final double resonanceJitterF1;
  final double resonanceJitterF2;
  final double pitchInstability;

  BioMarkers({
    required this.resonanceJitterF1,
    required this.resonanceJitterF2,
    required this.pitchInstability,
  });

  factory BioMarkers.fromJson(Map<String, dynamic> json) {
    return BioMarkers(
      resonanceJitterF1: (json['resonance_jitter_f1'] ?? 0).toDouble(),
      resonanceJitterF2: (json['resonance_jitter_f2'] ?? 0).toDouble(),
      pitchInstability: (json['pitch_instability'] ?? 0).toDouble(),
    );
  }
}

// ─── NEW: Analysis Result (replaces old label/score system) ──────────────────
class AnalysisResult {
  final String filename;
  final int severityScore;
  final int maxScore;
  final String riskInterpretation;
  final BioMarkers? bioMarkers;

  AnalysisResult({
    required this.filename,
    required this.severityScore,
    required this.maxScore,
    required this.riskInterpretation,
    this.bioMarkers,
  });

  factory AnalysisResult.fromJson(Map<String, dynamic> json) {
    return AnalysisResult(
      filename: json['filename'] ?? '',
      severityScore: json['severity_score'] ?? 0,
      maxScore: json['max_score'] ?? 30,
      riskInterpretation: json['risk_interpretation'] ?? '',
      bioMarkers: json['bio_markers'] != null
          ? BioMarkers.fromJson(json['bio_markers'])
          : null,
    );
  }

  /// Returns a normalised 0–100 percentage for progress indicators
  double getScorePercentage() {
    if (maxScore == 0) return 0;
    return (severityScore / maxScore) * 100;
  }

  /// Low risk   0–10 | Moderate 11–20 | High 21–30
  bool isLowRisk() =>
      riskInterpretation.toUpperCase().contains('LOW');

  bool isModerateRisk() =>
      riskInterpretation.toUpperCase().contains('MODERATE');

  bool isHighRisk() =>
      riskInterpretation.toUpperCase().contains('HIGH');

  /// Convenience: colour key for UI
  String getRiskLevel() => riskInterpretation;
}

// ─── Speech Submission (create response) ─────────────────────────────────────
class SpeechSubmissionResponse {
  final String message;
  final SpeechSubmissionWithResult data;
  final bool status;

  SpeechSubmissionResponse({
    required this.message,
    required this.data,
    required this.status,
  });

  factory SpeechSubmissionResponse.fromJson(Map<String, dynamic> json) {
    return SpeechSubmissionResponse(
      message: json['message'] ?? '',
      data: SpeechSubmissionWithResult.fromJson(json['data'] ?? {}),
      status: json['status'] ?? false,
    );
  }
}

/// Used for the POST /api/speech create response (has prediction_result inline)
class SpeechSubmissionWithResult {
  final String speechSubmissionId;
  final String parentUserId;
  final String childId;
  final String recordingPublicId;
  final int recordingDurationSeconds;
  final String? recordingFormat;
  final String submittedAt;
  final AnalysisResult? predictionResult;
  final SpeechResult? speechResult;

  SpeechSubmissionWithResult({
    required this.speechSubmissionId,
    required this.parentUserId,
    required this.childId,
    required this.recordingPublicId,
    required this.recordingDurationSeconds,
    this.recordingFormat,
    required this.submittedAt,
    this.predictionResult,
    this.speechResult,
  });

  factory SpeechSubmissionWithResult.fromJson(Map<String, dynamic> json) {
    return SpeechSubmissionWithResult(
      speechSubmissionId: json['speech_submission_id'] ?? '',
      parentUserId: json['parent_user_id'] ?? '',
      childId: json['child_id'] ?? '',
      recordingPublicId: json['recording_public_id'] ?? '',
      recordingDurationSeconds: json['recording_duration_seconds'] ?? 0,
      recordingFormat: json['recording_format'],
      submittedAt: json['submitted_at'] ?? '',
      predictionResult: json['prediction_result'] != null
          ? AnalysisResult.fromJson(json['prediction_result'])
          : null,
      speechResult: json['speech_result'] != null
          ? SpeechResult.fromJson(json['speech_result'])
          : null,
    );
  }
}

// ─── All Submissions (GET /api/speech list) ───────────────────────────────────
class AllSpeechSubmissionsResponse {
  final String message;
  final List<SpeechSubmissionDetail> data;
  final bool status;

  AllSpeechSubmissionsResponse({
    required this.message,
    required this.data,
    required this.status,
  });

  factory AllSpeechSubmissionsResponse.fromJson(Map<String, dynamic> json) {
    return AllSpeechSubmissionsResponse(
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map((s) => SpeechSubmissionDetail.fromJson(s))
              .toList() ??
          [],
      status: json['status'] ?? false,
    );
  }
}

// ─── Single Submission Detail (GET /api/speech/:id) ──────────────────────────
class SingleSpeechSubmissionResponse {
  final String message;
  final SpeechSubmissionDetail data;
  final bool status;

  SingleSpeechSubmissionResponse({
    required this.message,
    required this.data,
    required this.status,
  });

  factory SingleSpeechSubmissionResponse.fromJson(Map<String, dynamic> json) {
    return SingleSpeechSubmissionResponse(
      message: json['message'] ?? '',
      data: SpeechSubmissionDetail.fromJson(json['data'] ?? {}),
      status: json['status'] ?? false,
    );
  }
}

class SpeechSubmissionDetail {
  final String speechSubmissionId;
  final String parentUserId;
  final String childId;
  final String recordingPublicId;
  final int recordingDurationSeconds;
  final String? recordingFormat;
  final String submittedAt;
  final ChildInfo? children;
  final List<SpeechResult> speechResults;

  SpeechSubmissionDetail({
    required this.speechSubmissionId,
    required this.parentUserId,
    required this.childId,
    required this.recordingPublicId,
    required this.recordingDurationSeconds,
    this.recordingFormat,
    required this.submittedAt,
    this.children,
    required this.speechResults,
  });

  factory SpeechSubmissionDetail.fromJson(Map<String, dynamic> json) {
    return SpeechSubmissionDetail(
      speechSubmissionId: json['speech_submission_id'] ?? '',
      parentUserId: json['parent_user_id'] ?? '',
      childId: json['child_id'] ?? '',
      recordingPublicId: json['recording_public_id'] ?? '',
      recordingDurationSeconds: json['recording_duration_seconds'] ?? 0,
      recordingFormat: json['recording_format'],
      submittedAt: json['submitted_at'] ?? '',
      children: json['children'] != null
          ? ChildInfo.fromJson(json['children'])
          : null,
      speechResults: (json['speech_results'] as List<dynamic>?)
              ?.map((r) => SpeechResult.fromJson(r))
              .toList() ??
          [],
    );
  }

  String getFormattedDate() {
    try {
      final date = DateTime.parse(submittedAt);
      return '${date.day}/${date.month}/${date.year}';
    } catch (_) {
      return submittedAt;
    }
  }

  String getFormattedTime() {
    try {
      final date = DateTime.parse(submittedAt);
      final hour = date.hour > 12 ? date.hour - 12 : date.hour;
      final period = date.hour >= 12 ? 'PM' : 'AM';
      return '${hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')} $period';
    } catch (_) {
      return '';
    }
  }

  String getChildName() => children?.childName ?? 'Unknown';

  bool hasResults() => speechResults.isNotEmpty;

  SpeechResult? getLatestResult() =>
      speechResults.isEmpty ? null : speechResults.first;
}

class ChildInfo {
  final String childName;

  ChildInfo({required this.childName});

  factory ChildInfo.fromJson(Map<String, dynamic> json) =>
      ChildInfo(childName: json['child_name'] ?? '');
}

// ─── Speech Result ────────────────────────────────────────────────────────────
class SpeechResult {
  final AnalysisResult result;
  final String childId;
  final String generatedAt;
  final String parentUserId;
  final String speechResultId;
  final String speechSubmissionId;

  SpeechResult({
    required this.result,
    required this.childId,
    required this.generatedAt,
    required this.parentUserId,
    required this.speechResultId,
    required this.speechSubmissionId,
  });

  factory SpeechResult.fromJson(Map<String, dynamic> json) {
    return SpeechResult(
      result: AnalysisResult.fromJson(json['result'] ?? {}),
      childId: json['child_id'] ?? '',
      generatedAt: json['generated_at'] ?? '',
      parentUserId: json['parent_user_id'] ?? '',
      speechResultId: json['speech_result_id'] ?? '',
      speechSubmissionId: json['speech_submission_id'] ?? '',
    );
  }

  String getFormattedDate() {
    try {
      final date = DateTime.parse(generatedAt);
      return '${date.day}/${date.month}/${date.year}';
    } catch (_) {
      return generatedAt;
    }
  }
}

// ─── Delete Response ──────────────────────────────────────────────────────────
class DeleteSpeechResponse {
  final String message;
  final bool status;

  DeleteSpeechResponse({required this.message, required this.status});

  factory DeleteSpeechResponse.fromJson(Map<String, dynamic> json) =>
      DeleteSpeechResponse(
        message: json['message'] ?? '',
        status: json['status'] ?? false,
      );
}