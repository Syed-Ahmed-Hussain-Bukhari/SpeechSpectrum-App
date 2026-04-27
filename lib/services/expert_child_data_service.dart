// lib/services/expert_child_data_service.dart
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:speechspectrum/routes/app_urls.dart';
import 'package:speechspectrum/services/shared_preferences_service.dart';

// ── Screening Models ───────────────────────────────────────────────────────

class ExpertScreeningListModel {
  final bool status;
  final String message;
  final List<ExpertScreeningItem> data;

  ExpertScreeningListModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ExpertScreeningListModel.fromJson(Map<String, dynamic> json) {
    return ExpertScreeningListModel(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map((e) =>
                  ExpertScreeningItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class ExpertScreeningItem {
  final String submissionId;
  final String parentUserId;
  final String childId;
  final Map<String, dynamic> responses;
  final String submittedAt;
  final ExpertScreeningChild children;
  final List<ExpertScreeningResult> questionnaireResults;

  ExpertScreeningItem({
    required this.submissionId,
    required this.parentUserId,
    required this.childId,
    required this.responses,
    required this.submittedAt,
    required this.children,
    required this.questionnaireResults,
  });

  factory ExpertScreeningItem.fromJson(Map<String, dynamic> json) {
    return ExpertScreeningItem(
      submissionId: (json['submission_id'] ?? '').toString(),
      parentUserId: (json['parent_user_id'] ?? '').toString(),
      childId: (json['child_id'] ?? '').toString(),
      responses: Map<String, dynamic>.from(
          json['responses'] as Map? ?? {}),
      submittedAt: (json['submitted_at'] ?? '').toString(),
      children: ExpertScreeningChild.fromJson(
          json['children'] as Map<String, dynamic>? ?? {}),
      questionnaireResults: (json['questionnaire_results'] as List<dynamic>?)
              ?.map((e) => ExpertScreeningResult.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  String get formattedDate {
    try {
      final dt = DateTime.parse(submittedAt).toLocal();
      const months = [
        '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
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

class ExpertScreeningChild {
  final String childName;

  ExpertScreeningChild({required this.childName});

  factory ExpertScreeningChild.fromJson(Map<String, dynamic> json) {
    return ExpertScreeningChild(
      childName: (json['child_name'] ?? '').toString(),
    );
  }
}

class ExpertScreeningResult {
  final ExpertScreeningResultData result;
  final String childId;
  final String qResultId;
  final String generatedAt;
  final String submissionId;
  final String parentUserId;

  ExpertScreeningResult({
    required this.result,
    required this.childId,
    required this.qResultId,
    required this.generatedAt,
    required this.submissionId,
    required this.parentUserId,
  });

  factory ExpertScreeningResult.fromJson(Map<String, dynamic> json) {
    return ExpertScreeningResult(
      result: ExpertScreeningResultData.fromJson(
          json['result'] as Map<String, dynamic>? ?? {}),
      childId: (json['child_id'] ?? '').toString(),
      qResultId: (json['q_result_id'] ?? '').toString(),
      generatedAt: (json['generated_at'] ?? '').toString(),
      submissionId: (json['submission_id'] ?? '').toString(),
      parentUserId: (json['parent_user_id'] ?? '').toString(),
    );
  }
}

class ExpertScreeningResultData {
  final String prediction;
  final String probability;

  ExpertScreeningResultData({
    required this.prediction,
    required this.probability,
  });

  factory ExpertScreeningResultData.fromJson(Map<String, dynamic> json) {
    return ExpertScreeningResultData(
      prediction: (json['prediction'] ?? '').toString(),
      probability: (json['probability'] ?? '0%').toString(),
    );
  }

  double get probabilityValue {
    try {
      return double.parse(probability.replaceAll('%', ''));
    } catch (_) {
      return 0.0;
    }
  }

  bool get isHighRisk => probabilityValue >= 70.0;
  bool get isMediumRisk => probabilityValue >= 40.0 && probabilityValue < 70.0;
  bool get isLowRisk => probabilityValue < 40.0;
}

// ── Speech Models ──────────────────────────────────────────────────────────

class ExpertSpeechListModel {
  final bool status;
  final String message;
  final List<ExpertSpeechItem> data;

  ExpertSpeechListModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ExpertSpeechListModel.fromJson(Map<String, dynamic> json) {
    return ExpertSpeechListModel(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map((e) =>
                  ExpertSpeechItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class ExpertSpeechItem {
  final String speechSubmissionId;
  final String parentUserId;
  final String childId;
  final String recordingPublicId;
  final int recordingDurationSeconds;
  final String? recordingFormat;
  final String submittedAt;
  final ExpertSpeechChild children;
  final List<ExpertSpeechResult> speechResults;

  ExpertSpeechItem({
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

  factory ExpertSpeechItem.fromJson(Map<String, dynamic> json) {
    return ExpertSpeechItem(
      speechSubmissionId: (json['speech_submission_id'] ?? '').toString(),
      parentUserId: (json['parent_user_id'] ?? '').toString(),
      childId: (json['child_id'] ?? '').toString(),
      recordingPublicId: (json['recording_public_id'] ?? '').toString(),
      recordingDurationSeconds:
          (json['recording_duration_seconds'] as num?)?.toInt() ?? 0,
      recordingFormat: json['recording_format']?.toString(),
      submittedAt: (json['submitted_at'] ?? '').toString(),
      children: ExpertSpeechChild.fromJson(
          json['children'] as Map<String, dynamic>? ?? {}),
      speechResults: (json['speech_results'] as List<dynamic>?)
              ?.map((e) =>
                  ExpertSpeechResult.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  bool get hasResults => speechResults.isNotEmpty;

  ExpertSpeechResult? get latestResult =>
      speechResults.isNotEmpty ? speechResults.first : null;

  String get formattedDate {
    try {
      final dt = DateTime.parse(submittedAt).toLocal();
      const months = [
        '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
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

class ExpertSpeechChild {
  final String childName;

  ExpertSpeechChild({required this.childName});

  factory ExpertSpeechChild.fromJson(Map<String, dynamic> json) {
    return ExpertSpeechChild(
      childName: (json['child_name'] ?? '').toString(),
    );
  }
}

class ExpertSpeechResult {
  final ExpertSpeechAnalysis result;
  final String childId;
  final String generatedAt;
  final String parentUserId;
  final String speechResultId;
  final String speechSubmissionId;

  ExpertSpeechResult({
    required this.result,
    required this.childId,
    required this.generatedAt,
    required this.parentUserId,
    required this.speechResultId,
    required this.speechSubmissionId,
  });

  factory ExpertSpeechResult.fromJson(Map<String, dynamic> json) {
    return ExpertSpeechResult(
      result: ExpertSpeechAnalysis.fromJson(
          json['result'] as Map<String, dynamic>? ?? {}),
      childId: (json['child_id'] ?? '').toString(),
      generatedAt: (json['generated_at'] ?? '').toString(),
      parentUserId: (json['parent_user_id'] ?? '').toString(),
      speechResultId: (json['speech_result_id'] ?? '').toString(),
      speechSubmissionId: (json['speech_submission_id'] ?? '').toString(),
    );
  }
}

class ExpertSpeechAnalysis {
  final String filename;
  final int maxScore;
  final int severityScore;
  final String riskInterpretation;
  final ExpertBioMarkers? bioMarkers;

  ExpertSpeechAnalysis({
    required this.filename,
    required this.maxScore,
    required this.severityScore,
    required this.riskInterpretation,
    this.bioMarkers,
  });

  factory ExpertSpeechAnalysis.fromJson(Map<String, dynamic> json) {
    return ExpertSpeechAnalysis(
      filename: (json['filename'] ?? '').toString(),
      maxScore: (json['max_score'] as num?)?.toInt() ?? 30,
      severityScore: (json['severity_score'] as num?)?.toInt() ?? 0,
      riskInterpretation:
          (json['risk_interpretation'] ?? 'UNKNOWN').toString(),
      bioMarkers: json['bio_markers'] != null
          ? ExpertBioMarkers.fromJson(
              json['bio_markers'] as Map<String, dynamic>)
          : null,
    );
  }

  bool get isHighRisk =>
      riskInterpretation.toUpperCase().contains('HIGH');
  bool get isModerateRisk =>
      riskInterpretation.toUpperCase().contains('MODERATE');
  bool get isLowRisk =>
      riskInterpretation.toUpperCase().contains('LOW') && !isHighRisk;
}

class ExpertBioMarkers {
  final double pitchInstability;
  final double resonanceJitterF1;
  final double resonanceJitterF2;

  ExpertBioMarkers({
    required this.pitchInstability,
    required this.resonanceJitterF1,
    required this.resonanceJitterF2,
  });

  factory ExpertBioMarkers.fromJson(Map<String, dynamic> json) {
    return ExpertBioMarkers(
      pitchInstability:
          (json['pitch_instability'] as num?)?.toDouble() ?? 0.0,
      resonanceJitterF1:
          (json['resonance_jitter_f1'] as num?)?.toDouble() ?? 0.0,
      resonanceJitterF2:
          (json['resonance_jitter_f2'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

// ── Single Speech Detail Model ─────────────────────────────────────────────

class ExpertSpeechDetailModel {
  final bool status;
  final String message;
  final ExpertSpeechItem data;

  ExpertSpeechDetailModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ExpertSpeechDetailModel.fromJson(Map<String, dynamic> json) {
    return ExpertSpeechDetailModel(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: ExpertSpeechItem.fromJson(
          json['data'] as Map<String, dynamic>),
    );
  }
}

// ── Single Screening Detail Model ──────────────────────────────────────────

class ExpertScreeningDetailModel {
  final bool status;
  final String message;
  final ExpertScreeningItem data;

  ExpertScreeningDetailModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ExpertScreeningDetailModel.fromJson(Map<String, dynamic> json) {
    return ExpertScreeningDetailModel(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: ExpertScreeningItem.fromJson(
          json['data'] as Map<String, dynamic>),
    );
  }
}

// ── Service ────────────────────────────────────────────────────────────────

class ExpertChildDataService {
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
          return 'Access restricted to scheduled or confirmed appointments.';
        case 404:
          return 'Data not found.';
        default:
          return fallback;
      }
    }
    return fallback;
  }

  // GET /api/questionnaire?child_id=xxx
  Future<ExpertScreeningListModel> getScreeningByChild(
      String childId) async {
    try {
      debugPrint('🔍 [Service] GET screening for child: $childId');
      final resp = await _dio.get(
        '${APIEndPoints.questionnaire}?child_id=$childId',
        options: await _authOptions(),
      );
      return ExpertScreeningListModel.fromJson(
          Map<String, dynamic>.from(resp.data as Map));
    } on DioException catch (e) {
      debugPrint('❌ [Service] getScreeningByChild: ${e.message}');
      throw Exception(
          _errorMessage(e, 'Failed to load screening data'));
    }
  }

  // GET /api/questionnaire/:submissionId
  Future<ExpertScreeningDetailModel> getScreeningDetail(
      String submissionId) async {
    try {
      debugPrint('🔍 [Service] GET screening detail: $submissionId');
      final resp = await _dio.get(
        '${APIEndPoints.questionnaire}/$submissionId',
        options: await _authOptions(),
      );
      return ExpertScreeningDetailModel.fromJson(
          Map<String, dynamic>.from(resp.data as Map));
    } on DioException catch (e) {
      debugPrint('❌ [Service] getScreeningDetail: ${e.message}');
      throw Exception(
          _errorMessage(e, 'Failed to load screening detail'));
    }
  }

  // GET /api/speech  (fetch all then filter by childId)
  Future<List<ExpertSpeechItem>> getSpeechByChild(String childId) async {
    try {
      debugPrint('🎙️ [Service] GET all speech, filter by child: $childId');
      final resp = await _dio.get(
        '${APIEndPoints.baseUrl}/api/speech',
        options: await _authOptions(),
      );
      final model = ExpertSpeechListModel.fromJson(
          Map<String, dynamic>.from(resp.data as Map));
      return model.data
          .where((s) => s.childId == childId)
          .toList();
    } on DioException catch (e) {
      debugPrint('❌ [Service] getSpeechByChild: ${e.message}');
      throw Exception(_errorMessage(e, 'Failed to load speech data'));
    }
  }

  // GET /api/speech/:submissionId
  Future<ExpertSpeechDetailModel> getSpeechDetail(
      String submissionId) async {
    try {
      debugPrint('🎙️ [Service] GET speech detail: $submissionId');
      final resp = await _dio.get(
        '${APIEndPoints.baseUrl}/api/speech/$submissionId',
        options: await _authOptions(),
      );
      return ExpertSpeechDetailModel.fromJson(
          Map<String, dynamic>.from(resp.data as Map));
    } on DioException catch (e) {
      debugPrint('❌ [Service] getSpeechDetail: ${e.message}');
      throw Exception(
          _errorMessage(e, 'Failed to load speech detail'));
    }
  }
}