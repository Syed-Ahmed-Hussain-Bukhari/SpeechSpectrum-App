// lib/models/expert_profile_model.dart

class ExpertProfileModel {
  final bool status;
  final String message;
  final ExpertProfileData data;

  ExpertProfileModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ExpertProfileModel.fromJson(Map<String, dynamic> json) {
    return ExpertProfileModel(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: ExpertProfileData.fromJson(json['data'] ?? {}),
    );
  }
}

class ExpertProfileData {
  final String role;
  final ExpertProfile profile;

  ExpertProfileData({
    required this.role,
    required this.profile,
  });

  factory ExpertProfileData.fromJson(Map<String, dynamic> json) {
    return ExpertProfileData(
      role: json['role'] ?? 'expert',
      profile: ExpertProfile.fromJson(json['profile'] ?? {}),
    );
  }
}

class ExpertProfile {
  final String expertId;
  final String fullName;
  final String? specialization;
  final String? organization;
  final String? contactEmail;
  final String phone;
  final String? pmdcNumber;
  final String? profileImagePublicId;
  final String? degreeDocPublicId;
  final String? certificateDocPublicId;
  final String approvalStatus;
  final String? approvedBy;
  final String? approvedAt;
  final String createdAt;

  ExpertProfile({
    required this.expertId,
    required this.fullName,
    this.specialization,
    this.organization,
    this.contactEmail,
    required this.phone,
    this.pmdcNumber,
    this.profileImagePublicId,
    this.degreeDocPublicId,
    this.certificateDocPublicId,
    required this.approvalStatus,
    this.approvedBy,
    this.approvedAt,
    required this.createdAt,
  });

  factory ExpertProfile.fromJson(Map<String, dynamic> json) {
    return ExpertProfile(
      expertId: json['expert_id'] ?? '',
      fullName: json['full_name'] ?? '',
      specialization: json['specialization'],
      organization: json['organization'],
      contactEmail: json['contact_email'],
      phone: json['phone'] ?? '',
      pmdcNumber: json['pmdc_number'],
      profileImagePublicId: json['profile_image_public_id'],
      degreeDocPublicId: json['degree_doc_public_id'],
      certificateDocPublicId: json['certificate_doc_public_id'],
      approvalStatus: json['approval_status'] ?? 'pending',
      approvedBy: json['approved_by'],
      approvedAt: json['approved_at'],
      createdAt: json['created_at'] ?? '',
    );
  }
}

// ── Update Profile Response ──────────────────────────────────────
class ExpertUpdateProfileResponse {
  final bool status;
  final String message;
  final ExpertProfile? data;

  ExpertUpdateProfileResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory ExpertUpdateProfileResponse.fromJson(Map<String, dynamic> json) {
    return ExpertUpdateProfileResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? ExpertProfile.fromJson(json['data']) : null,
    );
  }
}

// ── Delete Profile Response ──────────────────────────────────────
class ExpertDeleteProfileResponse {
  final bool status;
  final String message;
  final String? error;

  ExpertDeleteProfileResponse({
    required this.status,
    required this.message,
    this.error,
  });

  factory ExpertDeleteProfileResponse.fromJson(Map<String, dynamic> json) {
    return ExpertDeleteProfileResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      error: json['error'],
    );
  }
}