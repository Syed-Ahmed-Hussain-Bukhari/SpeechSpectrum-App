// lib/models/child_profile_model.dart

class ChildProfileModel {
  final bool status;
  final String message;
  final ChildData data;

  ChildProfileModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ChildProfileModel.fromJson(Map<String, dynamic> json) {
    return ChildProfileModel(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: ChildData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

class ChildData {
  final String childId;
  final String parentUserId;
  final String childName;
  final String dateOfBirth;
  final String gender;
  final String createdAt;

  ChildData({
    required this.childId,
    required this.parentUserId,
    required this.childName,
    required this.dateOfBirth,
    required this.gender,
    required this.createdAt,
  });

  factory ChildData.fromJson(Map<String, dynamic> json) {
    return ChildData(
      childId: (json['child_id'] ?? '').toString(),
      parentUserId: (json['parent_user_id'] ?? '').toString(),
      childName: (json['child_name'] ?? '').toString(),
      dateOfBirth: (json['date_of_birth'] ?? '').toString(),
      gender: (json['gender'] ?? '').toString(),
      createdAt: (json['created_at'] ?? '').toString(),
    );
  }

  /// Age from date_of_birth
  String get age {
    try {
      final dob = DateTime.parse(dateOfBirth);
      final now = DateTime.now();
      int years = now.year - dob.year;
      int months = now.month - dob.month;
      if (months < 0) {
        years--;
        months += 12;
      }
      if (now.day < dob.day) months--;
      if (years == 0) return '$months months';
      if (months == 0) return '$years yrs';
      return '$years yrs $months mo';
    } catch (_) {
      return 'N/A';
    }
  }

  String get formattedDob {
    try {
      final dt = DateTime.parse(dateOfBirth);
      const months = [
        '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
      ];
      return '${dt.day} ${months[dt.month]} ${dt.year}';
    } catch (_) {
      return dateOfBirth;
    }
  }

  String get initials {
    final parts = childName.trim().split(' ');
    if (parts.length >= 2 && parts[0].isNotEmpty && parts[1].isNotEmpty) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return childName.isNotEmpty ? childName[0].toUpperCase() : 'C';
  }
}

// ── Child Health Profile ──────────────────────────────────────

class ChildHealthModel {
  final bool status;
  final String message;
  final ChildHealthData data;

  ChildHealthModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ChildHealthModel.fromJson(Map<String, dynamic> json) {
    return ChildHealthModel(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: ChildHealthData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

class ChildHealthData {
  final String profileId;
  final String childId;
  final String? bloodGroup;
  final String? knownAllergies;
  final bool familyHistoryAsd;
  final bool familyHistorySpeechDisorders;
  final bool familyHistoryHearingLoss;
  final String? geneticDisorders;
  final String? chronicConditions;
  final double? weightKg;
  final double? heightCm;
  final double? bmi;
  final List<MedicalRecord> medicalRecords;
  final dynamic currentPrescriptions;
  final String createdAt;
  final String updatedAt;
  final ChildData? children;

  ChildHealthData({
    required this.profileId,
    required this.childId,
    this.bloodGroup,
    this.knownAllergies,
    required this.familyHistoryAsd,
    required this.familyHistorySpeechDisorders,
    required this.familyHistoryHearingLoss,
    this.geneticDisorders,
    this.chronicConditions,
    this.weightKg,
    this.heightCm,
    this.bmi,
    required this.medicalRecords,
    this.currentPrescriptions,
    required this.createdAt,
    required this.updatedAt,
    this.children,
  });

  factory ChildHealthData.fromJson(Map<String, dynamic> json) {
    return ChildHealthData(
      profileId: (json['profile_id'] ?? '').toString(),
      childId: (json['child_id'] ?? '').toString(),
      bloodGroup: json['blood_group']?.toString(),
      knownAllergies: json['known_allergies']?.toString(),
      familyHistoryAsd: json['family_history_asd'] as bool? ?? false,
      familyHistorySpeechDisorders:
          json['family_history_speech_disorders'] as bool? ?? false,
      familyHistoryHearingLoss:
          json['family_history_hearing_loss'] as bool? ?? false,
      geneticDisorders: json['genetic_disorders']?.toString(),
      chronicConditions: json['chronic_conditions']?.toString(),
      weightKg: (json['weight_kg'] as num?)?.toDouble(),
      heightCm: (json['height_cm'] as num?)?.toDouble(),
      bmi: (json['bmi'] as num?)?.toDouble(),
      medicalRecords: (json['medical_records'] as List<dynamic>?)
              ?.map((e) => MedicalRecord.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      currentPrescriptions: json['current_prescriptions'],
      createdAt: (json['created_at'] ?? '').toString(),
      updatedAt: (json['updated_at'] ?? '').toString(),
      children: json['children'] != null
          ? ChildData.fromJson(json['children'] as Map<String, dynamic>)
          : null,
    );
  }

  bool get hasAnyFamilyHistory =>
      familyHistoryAsd || familyHistorySpeechDisorders || familyHistoryHearingLoss;
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
      fileName: (json['file_name'] ?? '').toString(),
      publicId: (json['public_id'] ?? '').toString(),
      documentId: (json['document_id'] ?? '').toString(),
      uploadedAt: (json['uploaded_at'] ?? '').toString(),
      documentType: (json['document_type'] ?? 'other').toString(),
    );
  }

  String get formattedUploadDate {
    try {
      final dt = DateTime.parse(uploadedAt).toLocal();
      const months = [
        '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
      ];
      return '${dt.day} ${months[dt.month]} ${dt.year}';
    } catch (_) {
      return uploadedAt;
    }
  }

  String get displayName {
    if (fileName.length > 30) {
      return '${fileName.substring(0, 27)}...';
    }
    return fileName;
  }
}