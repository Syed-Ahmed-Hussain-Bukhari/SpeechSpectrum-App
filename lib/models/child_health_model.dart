// lib/models/child_health_model.dart

class ChildHealthModel {
  final String message;
  final ChildHealthData? data;
  final bool status;

  ChildHealthModel({
    required this.message,
    this.data,
    required this.status,
  });

  factory ChildHealthModel.fromJson(Map<String, dynamic> json) {
    return ChildHealthModel(
      message: json['message'] ?? '',
      data: json['data'] != null ? ChildHealthData.fromJson(json['data']) : null,
      status: json['status'] ?? false,
    );
  }
}

class ChildHealthData {
  final String profileId;
  final String childId;
  final String? bloodGroup;
  final String? knownAllergies;
  final bool familyHistoryAsd;
  final bool familyHistorysSpeechDisorders;
  final bool familyHistoryHearingLoss;
  final String? geneticDisorders;
  final String? chronicConditions;
  final double? weightKg;
  final double? heightCm;
  final double? bmi;
  final List<MedicalRecord>? medicalRecords;
  final dynamic currentPrescriptions;
  final String createdAt;
  final String updatedAt;

  ChildHealthData({
    required this.profileId,
    required this.childId,
    this.bloodGroup,
    this.knownAllergies,
    required this.familyHistoryAsd,
    required this.familyHistorysSpeechDisorders,
    required this.familyHistoryHearingLoss,
    this.geneticDisorders,
    this.chronicConditions,
    this.weightKg,
    this.heightCm,
    this.bmi,
    this.medicalRecords,
    this.currentPrescriptions,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChildHealthData.fromJson(Map<String, dynamic> json) {
    return ChildHealthData(
      profileId: json['profile_id'] ?? '',
      childId: json['child_id'] ?? '',
      bloodGroup: json['blood_group'],
      knownAllergies: json['known_allergies'],
      familyHistoryAsd: json['family_history_asd'] ?? false,
      familyHistorysSpeechDisorders: json['family_history_speech_disorders'] ?? false,
      familyHistoryHearingLoss: json['family_history_hearing_loss'] ?? false,
      geneticDisorders: json['genetic_disorders'],
      chronicConditions: json['chronic_conditions'],
      weightKg: json['weight_kg'] != null ? (json['weight_kg'] as num).toDouble() : null,
      heightCm: json['height_cm'] != null ? (json['height_cm'] as num).toDouble() : null,
      bmi: json['bmi'] != null ? (json['bmi'] as num).toDouble() : null,
      medicalRecords: json['medical_records'] != null
          ? (json['medical_records'] as List<dynamic>)
              .map((r) => MedicalRecord.fromJson(r))
              .toList()
          : null,
      currentPrescriptions: json['current_prescriptions'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}

class MedicalRecord {
  final String fileName;
  final String publicId;
  final String documentId;
  final String uploadedAt;
  final String documentType;

  MedicalRecord({
    required this.fileName,
    required this.publicId,
    required this.documentId,
    required this.uploadedAt,
    required this.documentType,
  });

  factory MedicalRecord.fromJson(Map<String, dynamic> json) {
    return MedicalRecord(
      fileName: json['file_name'] ?? '',
      publicId: json['public_id'] ?? '',
      documentId: json['document_id'] ?? '',
      uploadedAt: json['uploaded_at'] ?? '',
      documentType: json['document_type'] ?? '',
    );
  }

  String getDocumentTypeDisplay() {
    switch (documentType) {
      case 'lab_result':
        return 'Lab Result';
      case 'prescription':
        return 'Prescription';
      case 'hearing_test':
        return 'Hearing Test';
      case 'vision_test':
        return 'Vision Test';
      case 'previous_report':
        return 'Previous Report';
      case 'referral_letter':
        return 'Referral Letter';
      case 'school_report':
        return 'School Report';
      case 'other':
        return 'Other';
      default:
        return documentType;
    }
  }
}

class DeleteRecordResponse {
  final String message;
  final bool status;

  DeleteRecordResponse({required this.message, required this.status});

  factory DeleteRecordResponse.fromJson(Map<String, dynamic> json) {
    return DeleteRecordResponse(
      message: json['message'] ?? '',
      status: json['status'] ?? false,
    );
  }
}