// // // lib/models/questionnaire_model.dart

// // class QuestionnaireSubmission {
// //   final String? submissionId;
// //   final String parentUserId;
// //   final String childId;
// //   final Map<String, dynamic> responses;
// //   final String submittedAt;

// //   QuestionnaireSubmission({
// //     this.submissionId,
// //     required this.parentUserId,
// //     required this.childId,
// //     required this.responses,
// //     required this.submittedAt,
// //   });

// //   factory QuestionnaireSubmission.fromJson(Map<String, dynamic> json) {
// //     return QuestionnaireSubmission(
// //       submissionId: json['submission_id'],
// //       parentUserId: json['parent_user_id'],
// //       childId: json['child_id'],
// //       responses: json['responses'],
// //       submittedAt: json['submitted_at'],
// //     );
// //   }

// //   Map<String, dynamic> toJson() {
// //     return {
// //       'child_id': childId,
// //       'responses': responses,
// //     };
// //   }
// // }

// // class QuestionnaireResult {
// //   final String qResultId;
// //   final String submissionId;
// //   final String parentUserId;
// //   final String childId;
// //   final Map<String, dynamic> result;
// //   final String generatedAt;

// //   QuestionnaireResult({
// //     required this.qResultId,
// //     required this.submissionId,
// //     required this.parentUserId,
// //     required this.childId,
// //     required this.result,
// //     required this.generatedAt,
// //   });

// //   factory QuestionnaireResult.fromJson(Map<String, dynamic> json) {
// //     return QuestionnaireResult(
// //       qResultId: json['q_result_id'],
// //       submissionId: json['submission_id'],
// //       parentUserId: json['parent_user_id'],
// //       childId: json['child_id'],
// //       result: json['result'],
// //       generatedAt: json['generated_at'],
// //     );
// //   }

// //   String get prediction => result['prediction'] ?? '';
// //   String get probability => result['probability'] ?? '';
// // }

// // class QuestionnaireSubmitResponse {
// //   final bool status;
// //   final String message;
// //   final QuestionnaireSubmission? submission;
// //   final QuestionnaireResult? result;

// //   QuestionnaireSubmitResponse({
// //     required this.status,
// //     required this.message,
// //     this.submission,
// //     this.result,
// //   });

// //   factory QuestionnaireSubmitResponse.fromJson(Map<String, dynamic> json) {
// //     return QuestionnaireSubmitResponse(
// //       status: json['status'] ?? false,
// //       message: json['message'] ?? '',
// //       submission: json['submission'] != null
// //           ? QuestionnaireSubmission.fromJson(json['submission'])
// //           : null,
// //       result: json['result'] != null
// //           ? QuestionnaireResult.fromJson(json['result'])
// //           : null,
// //     );
// //   }
// // }

// // class SubmissionHistoryItem {
// //   final String submissionId;
// //   final String parentUserId;
// //   final String childId;
// //   final Map<String, dynamic> responses;
// //   final String submittedAt;
// //   final Map<String, dynamic>? children;
// //   final List<QuestionnaireResult> questionnaireResults;

// //   SubmissionHistoryItem({
// //     required this.submissionId,
// //     required this.parentUserId,
// //     required this.childId,
// //     required this.responses,
// //     required this.submittedAt,
// //     this.children,
// //     required this.questionnaireResults,
// //   });

// //   factory SubmissionHistoryItem.fromJson(Map<String, dynamic> json) {
// //     return SubmissionHistoryItem(
// //       submissionId: json['submission_id'],
// //       parentUserId: json['parent_user_id'],
// //       childId: json['child_id'],
// //       responses: json['responses'],
// //       submittedAt: json['submitted_at'],
// //       children: json['children'],
// //       questionnaireResults: (json['questionnaire_results'] as List?)
// //               ?.map((e) => QuestionnaireResult.fromJson(e))
// //               .toList() ??
// //           [],
// //     );
// //   }

// //   String get childName => children?['child_name'] ?? 'Unknown';
  
// //   bool get hasResult => questionnaireResults.isNotEmpty;
  
// //   QuestionnaireResult? get latestResult => 
// //       questionnaireResults.isNotEmpty ? questionnaireResults.first : null;
// // }

// // class SubmissionHistoryResponse {
// //   final bool status;
// //   final String message;
// //   final List<SubmissionHistoryItem> data;

// //   SubmissionHistoryResponse({
// //     required this.status,
// //     required this.message,
// //     required this.data,
// //   });

// //   factory SubmissionHistoryResponse.fromJson(Map<String, dynamic> json) {
// //     return SubmissionHistoryResponse(
// //       status: json['status'] ?? false,
// //       message: json['message'] ?? '',
// //       data: (json['data'] as List?)
// //               ?.map((e) => SubmissionHistoryItem.fromJson(e))
// //               .toList() ??
// //           [],
// //     );
// //   }
// // }

// // class SingleSubmissionResponse {
// //   final bool status;
// //   final String message;
// //   final SubmissionHistoryItem? data;

// //   SingleSubmissionResponse({
// //     required this.status,
// //     required this.message,
// //     this.data,
// //   });

// //   factory SingleSubmissionResponse.fromJson(Map<String, dynamic> json) {
// //     return SingleSubmissionResponse(
// //       status: json['status'] ?? false,
// //       message: json['message'] ?? '',
// //       data: json['data'] != null
// //           ? SubmissionHistoryItem.fromJson(json['data'])
// //           : null,
// //     );
// //   }
// // }

// // class DeleteSubmissionResponse {
// //   final bool status;
// //   final String message;

// //   DeleteSubmissionResponse({
// //     required this.status,
// //     required this.message,
// //   });

// //   factory DeleteSubmissionResponse.fromJson(Map<String, dynamic> json) {
// //     return DeleteSubmissionResponse(
// //       status: json['status'] ?? false,
// //       message: json['message'] ?? '',
// //     );
// //   }
// // }

// // // lib/models/questionnaire_model.dart

// // import 'dart:ui';

// // class QuestionnaireResultModel {
// //   final String message;
// //   final SubmissionData submission;
// //   final ResultData result;
// //   final bool status;

// //   QuestionnaireResultModel({
// //     required this.message,
// //     required this.submission,
// //     required this.result,
// //     required this.status,
// //   });

// //   factory QuestionnaireResultModel.fromJson(Map<String, dynamic> json) {
// //     return QuestionnaireResultModel(
// //       message: json['message'] ?? '',
// //       submission: SubmissionData.fromJson(json['submission'] ?? {}),
// //       result: ResultData.fromJson(json['result'] ?? {}),
// //       status: json['status'] ?? false,
// //     );
// //   }

// //   Map<String, dynamic> toJson() {
// //     return {
// //       'message': message,
// //       'submission': submission.toJson(),
// //       'result': result.toJson(),
// //       'status': status,
// //     };
// //   }
// // }

// // class SubmissionData {
// //   final String submissionId;
// //   final String parentUserId;
// //   final String childId;
// //   final Map<String, dynamic> responses;
// //   final String submittedAt;

// //   SubmissionData({
// //     required this.submissionId,
// //     required this.parentUserId,
// //     required this.childId,
// //     required this.responses,
// //     required this.submittedAt,
// //   });

// //   factory SubmissionData.fromJson(Map<String, dynamic> json) {
// //     return SubmissionData(
// //       submissionId: json['submission_id'] ?? '',
// //       parentUserId: json['parent_user_id'] ?? '',
// //       childId: json['child_id'] ?? '',
// //       responses: json['responses'] ?? {},
// //       submittedAt: json['submitted_at'] ?? '',
// //     );
// //   }

// //   Map<String, dynamic> toJson() {
// //     return {
// //       'submission_id': submissionId,
// //       'parent_user_id': parentUserId,
// //       'child_id': childId,
// //       'responses': responses,
// //       'submitted_at': submittedAt,
// //     };
// //   }
// // }

// // class ResultData {
// //   final String qResultId;
// //   final String submissionId;
// //   final String parentUserId;
// //   final String childId;
// //   final PredictionResult result;
// //   final String generatedAt;

// //   ResultData({
// //     required this.qResultId,
// //     required this.submissionId,
// //     required this.parentUserId,
// //     required this.childId,
// //     required this.result,
// //     required this.generatedAt,
// //   });

// //   factory ResultData.fromJson(Map<String, dynamic> json) {
// //     return ResultData(
// //       qResultId: json['q_result_id'] ?? '',
// //       submissionId: json['submission_id'] ?? '',
// //       parentUserId: json['parent_user_id'] ?? '',
// //       childId: json['child_id'] ?? '',
// //       result: PredictionResult.fromJson(json['result'] ?? {}),
// //       generatedAt: json['generated_at'] ?? '',
// //     );
// //   }

// //   Map<String, dynamic> toJson() {
// //     return {
// //       'q_result_id': qResultId,
// //       'submission_id': submissionId,
// //       'parent_user_id': parentUserId,
// //       'child_id': childId,
// //       'result': result.toJson(),
// //       'generated_at': generatedAt,
// //     };
// //   }
// // }

// // class PredictionResult {
// //   final String prediction;
// //   final String probability;

// //   PredictionResult({
// //     required this.prediction,
// //     required this.probability,
// //   });

// //   factory PredictionResult.fromJson(Map<String, dynamic> json) {
// //     return PredictionResult(
// //       prediction: json['prediction'] ?? '',
// //       probability: json['probability'] ?? '',
// //     );
// //   }

// //   Map<String, dynamic> toJson() {
// //     return {
// //       'prediction': prediction,
// //       'probability': probability,
// //     };
// //   }

// //   // Helper method to get risk level based on probability
// //   String getRiskLevel() {
// //     final prob = double.tryParse(probability.replaceAll('%', '')) ?? 0.0;
// //     if (prob < 30) return 'Low';
// //     if (prob < 60) return 'Moderate';
// //     return 'High';
// //   }

// //   // Helper method to get risk color
// //   Color getRiskColor() {
// //     final level = getRiskLevel();
// //     switch (level) {
// //       case 'Low':
// //         return const Color(0xFF4CAF50); // Green
// //       case 'Moderate':
// //         return const Color(0xFFFF9800); // Orange
// //       case 'High':
// //         return const Color(0xFFE74C3C); // Red
// //       default:
// //         return const Color(0xFF636E72); // Grey
// //     }
// //   }
// // }


// // lib/models/questionnaire_model.dart
// import 'package:flutter/material.dart';

// // Main Questionnaire Result Model (for submission response)
// class QuestionnaireResultModel {
//   final String message;
//   final SubmissionData submission;
//   final ResultData result;
//   final bool status;

//   QuestionnaireResultModel({
//     required this.message,
//     required this.submission,
//     required this.result,
//     required this.status,
//   });

//   factory QuestionnaireResultModel.fromJson(Map<String, dynamic> json) {
//     return QuestionnaireResultModel(
//       message: json['message'] ?? '',
//       submission: SubmissionData.fromJson(json['submission'] ?? {}),
//       result: ResultData.fromJson(json['result'] ?? {}),
//       status: json['status'] ?? false,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'message': message,
//       'submission': submission.toJson(),
//       'result': result.toJson(),
//       'status': status,
//     };
//   }
// }

// // Submission Data (for initial submission response)
// class SubmissionData {
//   final String submissionId;
//   final String parentUserId;
//   final String childId;
//   final Map<String, dynamic> responses;
//   final String submittedAt;

//   SubmissionData({
//     required this.submissionId,
//     required this.parentUserId,
//     required this.childId,
//     required this.responses,
//     required this.submittedAt,
//   });

//   factory SubmissionData.fromJson(Map<String, dynamic> json) {
//     return SubmissionData(
//       submissionId: json['submission_id'] ?? '',
//       parentUserId: json['parent_user_id'] ?? '',
//       childId: json['child_id'] ?? '',
//       responses: json['responses'] ?? {},
//       submittedAt: json['submitted_at'] ?? '',
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'submission_id': submissionId,
//       'parent_user_id': parentUserId,
//       'child_id': childId,
//       'responses': responses,
//       'submitted_at': submittedAt,
//     };
//   }
// }

// // Result Data (for prediction result)
// class ResultData {
//   final String qResultId;
//   final String submissionId;
//   final String parentUserId;
//   final String childId;
//   final PredictionResult result;
//   final String generatedAt;

//   ResultData({
//     required this.qResultId,
//     required this.submissionId,
//     required this.parentUserId,
//     required this.childId,
//     required this.result,
//     required this.generatedAt,
//   });

//   factory ResultData.fromJson(Map<String, dynamic> json) {
//     return ResultData(
//       qResultId: json['q_result_id'] ?? '',
//       submissionId: json['submission_id'] ?? '',
//       parentUserId: json['parent_user_id'] ?? '',
//       childId: json['child_id'] ?? '',
//       result: PredictionResult.fromJson(json['result'] ?? {}),
//       generatedAt: json['generated_at'] ?? '',
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'q_result_id': qResultId,
//       'submission_id': submissionId,
//       'parent_user_id': parentUserId,
//       'child_id': childId,
//       'result': result.toJson(),
//       'generated_at': generatedAt,
//     };
//   }
// }

// // Prediction Result
// class PredictionResult {
//   final String prediction;
//   final String probability;

//   PredictionResult({
//     required this.prediction,
//     required this.probability,
//   });

//   factory PredictionResult.fromJson(Map<String, dynamic> json) {
//     return PredictionResult(
//       prediction: json['prediction'] ?? '',
//       probability: json['probability'] ?? '',
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'prediction': prediction,
//       'probability': probability,
//     };
//   }

//   // Helper method to get risk level based on probability
//   String getRiskLevel() {
//     final prob = double.tryParse(probability.replaceAll('%', '')) ?? 0.0;
//     if (prob < 30) return 'Low';
//     if (prob < 60) return 'Moderate';
//     return 'High';
//   }

//   // Helper method to get risk color
//   Color getRiskColor() {
//     final level = getRiskLevel();
//     switch (level) {
//       case 'Low':
//         return const Color(0xFF4CAF50); // Green
//       case 'Moderate':
//         return const Color(0xFFFF9800); // Orange
//       case 'High':
//         return const Color(0xFFE74C3C); // Red
//       default:
//         return const Color(0xFF636E72); // Grey
//     }
//   }
// }

// // ============== HISTORY MODELS ==============

// // Submissions List Model (for GET all submissions)
// class SubmissionsListModel {
//   final String message;
//   final List<SubmissionItem> data;
//   final bool status;

//   SubmissionsListModel({
//     required this.message,
//     required this.data,
//     required this.status,
//   });

//   factory SubmissionsListModel.fromJson(Map<String, dynamic> json) {
//     return SubmissionsListModel(
//       message: json['message'] ?? '',
//       data: (json['data'] as List<dynamic>?)
//               ?.map((item) => SubmissionItem.fromJson(item))
//               .toList() ??
//           [],
//       status: json['status'] ?? false,
//     );
//   }
// }

// // Single Submission Model (for GET single submission)
// class SingleSubmissionModel {
//   final String message;
//   final SubmissionItem data;
//   final bool status;

//   SingleSubmissionModel({
//     required this.message,
//     required this.data,
//     required this.status,
//   });

//   factory SingleSubmissionModel.fromJson(Map<String, dynamic> json) {
//     return SingleSubmissionModel(
//       message: json['message'] ?? '',
//       data: SubmissionItem.fromJson(json['data'] ?? {}),
//       status: json['status'] ?? false,
//     );
//   }
// }

// // Submission Item (for history list)
// class SubmissionItem {
//   final String submissionId;
//   final String parentUserId;
//   final String childId;
//   final Map<String, dynamic> responses;
//   final String submittedAt;
//   final ChildInfo children;
//   final List<QuestionnaireResult> questionnaireResults;

//   SubmissionItem({
//     required this.submissionId,
//     required this.parentUserId,
//     required this.childId,
//     required this.responses,
//     required this.submittedAt,
//     required this.children,
//     required this.questionnaireResults,
//   });

//   factory SubmissionItem.fromJson(Map<String, dynamic> json) {
//     return SubmissionItem(
//       submissionId: json['submission_id'] ?? '',
//       parentUserId: json['parent_user_id'] ?? '',
//       childId: json['child_id'] ?? '',
//       responses: json['responses'] ?? {},
//       submittedAt: json['submitted_at'] ?? '',
//       children: ChildInfo.fromJson(json['children'] ?? {}),
//       questionnaireResults: (json['questionnaire_results'] as List<dynamic>?)
//               ?.map((item) => QuestionnaireResult.fromJson(item))
//               .toList() ??
//           [],
//     );
//   }

//   String getFormattedDate() {
//     try {
//       final date = DateTime.parse(submittedAt);
//       return '${date.day}/${date.month}/${date.year}';
//     } catch (e) {
//       return 'Unknown';
//     }
//   }

//   String getFormattedTime() {
//     try {
//       final date = DateTime.parse(submittedAt);
//       final hour = date.hour > 12 ? date.hour - 12 : (date.hour == 0 ? 12 : date.hour);
//       final period = date.hour >= 12 ? 'PM' : 'AM';
//       return '${hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')} $period';
//     } catch (e) {
//       return 'Unknown';
//     }
//   }
// }

// // Child Info (for submission items)
// class ChildInfo {
//   final String childName;

//   ChildInfo({required this.childName});

//   factory ChildInfo.fromJson(Map<String, dynamic> json) {
//     return ChildInfo(
//       childName: json['child_name'] ?? 'Unknown',
//     );
//   }
// }

// // Questionnaire Result (in history)
// class QuestionnaireResult {
//   final PredictionResult result;
//   final String childId;
//   final String qResultId;
//   final String generatedAt;
//   final String submissionId;
//   final String parentUserId;

//   QuestionnaireResult({
//     required this.result,
//     required this.childId,
//     required this.qResultId,
//     required this.generatedAt,
//     required this.submissionId,
//     required this.parentUserId,
//   });

//   factory QuestionnaireResult.fromJson(Map<String, dynamic> json) {
//     return QuestionnaireResult(
//       result: PredictionResult.fromJson(json['result'] ?? {}),
//       childId: json['child_id'] ?? '',
//       qResultId: json['q_result_id'] ?? '',
//       generatedAt: json['generated_at'] ?? '',
//       submissionId: json['submission_id'] ?? '',
//       parentUserId: json['parent_user_id'] ?? '',
//     );
//   }
// }

// // Delete Submission Response
// class DeleteSubmissionResponse {
//   final String message;
//   final bool status;

//   DeleteSubmissionResponse({
//     required this.message,
//     required this.status,
//   });

//   factory DeleteSubmissionResponse.fromJson(Map<String, dynamic> json) {
//     return DeleteSubmissionResponse(
//       message: json['message'] ?? '',
//       status: json['status'] ?? false,
//     );
//   }
// }


// lib/models/questionnaire_model.dart
import 'package:flutter/material.dart';

// Main Result Model for Submission
class QuestionnaireResultModel {
  final String message;
  final SubmissionData submission;
  final ResultData result;
  final bool status;

  QuestionnaireResultModel({
    required this.message,
    required this.submission,
    required this.result,
    required this.status,
  });

  factory QuestionnaireResultModel.fromJson(Map<String, dynamic> json) {
    return QuestionnaireResultModel(
      message: json['message'] ?? '',
      submission: SubmissionData.fromJson(json['submission'] ?? {}),
      result: ResultData.fromJson(json['result'] ?? {}),
      status: json['status'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'submission': submission.toJson(),
      'result': result.toJson(),
      'status': status,
    };
  }
}

// Submissions List Model
class SubmissionsListModel {
  final String message;
  final List<SubmissionItem> data;
  final bool status;

  SubmissionsListModel({
    required this.message,
    required this.data,
    required this.status,
  });

  factory SubmissionsListModel.fromJson(Map<String, dynamic> json) {
    return SubmissionsListModel(
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map((item) => SubmissionItem.fromJson(item))
              .toList() ??
          [],
      status: json['status'] ?? false,
    );
  }
}

// Single Submission Model
class SingleSubmissionModel {
  final String message;
  final SubmissionItem data;
  final bool status;

  SingleSubmissionModel({
    required this.message,
    required this.data,
    required this.status,
  });

  factory SingleSubmissionModel.fromJson(Map<String, dynamic> json) {
    return SingleSubmissionModel(
      message: json['message'] ?? '',
      data: SubmissionItem.fromJson(json['data'] ?? {}),
      status: json['status'] ?? false,
    );
  }
}

// Submission Item (used in lists and single submission)
class SubmissionItem {
  final String submissionId;
  final String parentUserId;
  final String childId;
  final Map<String, dynamic> responses;
  final String submittedAt;
  final ChildInfo children;
  final List<QuestionnaireResult> questionnaireResults;

  SubmissionItem({
    required this.submissionId,
    required this.parentUserId,
    required this.childId,
    required this.responses,
    required this.submittedAt,
    required this.children,
    required this.questionnaireResults,
  });

  factory SubmissionItem.fromJson(Map<String, dynamic> json) {
    return SubmissionItem(
      submissionId: json['submission_id'] ?? '',
      parentUserId: json['parent_user_id'] ?? '',
      childId: json['child_id'] ?? '',
      responses: json['responses'] ?? {},
      submittedAt: json['submitted_at'] ?? '',
      children: ChildInfo.fromJson(json['children'] ?? {}),
      questionnaireResults: (json['questionnaire_results'] as List<dynamic>?)
              ?.map((item) => QuestionnaireResult.fromJson(item))
              .toList() ??
          [],
    );
  }

  String getFormattedDate() {
    try {
      final date = DateTime.parse(submittedAt);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return 'Unknown';
    }
  }

  String getFormattedTime() {
    try {
      final date = DateTime.parse(submittedAt);
      final hour = date.hour > 12 ? date.hour - 12 : (date.hour == 0 ? 12 : date.hour);
      final period = date.hour >= 12 ? 'PM' : 'AM';
      return '${hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')} $period';
    } catch (e) {
      return 'Unknown';
    }
  }
}

// Child Info
class ChildInfo {
  final String childName;

  ChildInfo({required this.childName});

  factory ChildInfo.fromJson(Map<String, dynamic> json) {
    return ChildInfo(
      childName: json['child_name'] ?? 'Unknown',
    );
  }
}

// Questionnaire Result
class QuestionnaireResult {
  final PredictionResult result;
  final String childId;
  final String qResultId;
  final String generatedAt;
  final String submissionId;
  final String parentUserId;

  QuestionnaireResult({
    required this.result,
    required this.childId,
    required this.qResultId,
    required this.generatedAt,
    required this.submissionId,
    required this.parentUserId,
  });

  factory QuestionnaireResult.fromJson(Map<String, dynamic> json) {
    return QuestionnaireResult(
      result: PredictionResult.fromJson(json['result'] ?? {}),
      childId: json['child_id'] ?? '',
      qResultId: json['q_result_id'] ?? '',
      generatedAt: json['generated_at'] ?? '',
      submissionId: json['submission_id'] ?? '',
      parentUserId: json['parent_user_id'] ?? '',
    );
  }
}

// Delete Response
class DeleteSubmissionResponse {
  final String message;
  final bool status;

  DeleteSubmissionResponse({
    required this.message,
    required this.status,
  });

  factory DeleteSubmissionResponse.fromJson(Map<String, dynamic> json) {
    return DeleteSubmissionResponse(
      message: json['message'] ?? '',
      status: json['status'] ?? false,
    );
  }
}

// Submission Data (for create/update operations)
class SubmissionData {
  final String submissionId;
  final String parentUserId;
  final String childId;
  final Map<String, dynamic> responses;
  final String submittedAt;

  SubmissionData({
    required this.submissionId,
    required this.parentUserId,
    required this.childId,
    required this.responses,
    required this.submittedAt,
  });

  factory SubmissionData.fromJson(Map<String, dynamic> json) {
    return SubmissionData(
      submissionId: json['submission_id'] ?? '',
      parentUserId: json['parent_user_id'] ?? '',
      childId: json['child_id'] ?? '',
      responses: json['responses'] ?? {},
      submittedAt: json['submitted_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'submission_id': submissionId,
      'parent_user_id': parentUserId,
      'child_id': childId,
      'responses': responses,
      'submitted_at': submittedAt,
    };
  }
}

// Result Data
class ResultData {
  final String qResultId;
  final String submissionId;
  final String parentUserId;
  final String childId;
  final PredictionResult result;
  final String generatedAt;

  ResultData({
    required this.qResultId,
    required this.submissionId,
    required this.parentUserId,
    required this.childId,
    required this.result,
    required this.generatedAt,
  });

  factory ResultData.fromJson(Map<String, dynamic> json) {
    return ResultData(
      qResultId: json['q_result_id'] ?? '',
      submissionId: json['submission_id'] ?? '',
      parentUserId: json['parent_user_id'] ?? '',
      childId: json['child_id'] ?? '',
      result: PredictionResult.fromJson(json['result'] ?? {}),
      generatedAt: json['generated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'q_result_id': qResultId,
      'submission_id': submissionId,
      'parent_user_id': parentUserId,
      'child_id': childId,
      'result': result.toJson(),
      'generated_at': generatedAt,
    };
  }
}

// Prediction Result
class PredictionResult {
  final String prediction;
  final String probability;

  PredictionResult({
    required this.prediction,
    required this.probability,
  });

  factory PredictionResult.fromJson(Map<String, dynamic> json) {
    return PredictionResult(
      prediction: json['prediction'] ?? '',
      probability: json['probability'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'prediction': prediction,
      'probability': probability,
    };
  }

  // Helper method to get risk level based on probability
  String getRiskLevel() {
    final prob = double.tryParse(probability.replaceAll('%', '')) ?? 0.0;
    if (prob < 30) return 'Low';
    if (prob < 60) return 'Moderate';
    return 'High';
  }

  // Helper method to get risk color
  Color getRiskColor() {
    final level = getRiskLevel();
    switch (level) {
      case 'Low':
        return const Color(0xFF4CAF50); // Green
      case 'Moderate':
        return const Color(0xFFFF9800); // Orange
      case 'High':
        return const Color(0xFFE74C3C); // Red
      default:
        return const Color(0xFF636E72); // Grey
    }
  }
}