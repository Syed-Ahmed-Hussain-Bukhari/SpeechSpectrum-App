// // lib/models/profile_model.dart
// class ProfileModel {
//   final bool status;
//   final String message;
//   final ProfileData data;

//   ProfileModel({
//     required this.status,
//     required this.message,
//     required this.data,
//   });

//   factory ProfileModel.fromJson(Map<String, dynamic> json) {
//     return ProfileModel(
//       status: json['status'] ?? false,
//       message: json['message'] ?? '',
//       data: ProfileData.fromJson(json['data'] ?? {}),
//     );
//   }
// }

// class ProfileData {
//   final String role;
//   final dynamic profile; // Can be ParentProfile or ExpertProfile

//   ProfileData({
//     required this.role,
//     required this.profile,
//   });

//   factory ProfileData.fromJson(Map<String, dynamic> json) {
//     final role = json['role'] ?? '';
    
//     if (role == 'parent') {
//       return ProfileData(
//         role: role,
//         profile: ParentProfile.fromJson(json['profile'] ?? {}),
//       );
//     } else if (role == 'expert') {
//       return ProfileData(
//         role: role,
//         profile: ExpertProfile.fromJson(json['profile'] ?? {}),
//       );
//     }
    
//     return ProfileData(role: role, profile: null);
//   }

//   bool isParent() => role == 'parent';
//   bool isExpert() => role == 'expert';
// }

// class ParentProfile {
//   final String userId;
//   final String fullName;
//   final String phone;
//   final String createdAt;

//   ParentProfile({
//     required this.userId,
//     required this.fullName,
//     required this.phone,
//     required this.createdAt,
//   });

//   factory ParentProfile.fromJson(Map<String, dynamic> json) {
//     return ParentProfile(
//       userId: json['user_id'] ?? '',
//       fullName: json['full_name'] ?? '',
//       phone: json['phone'] ?? '',
//       createdAt: json['created_at'] ?? '',
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'user_id': userId,
//       'full_name': fullName,
//       'phone': phone,
//       'created_at': createdAt,
//     };
//   }
// }

// class ExpertProfile {
//   final String expertId;
//   final String fullName;
//   final String? specialization;
//   final String? organization;
//   final String? contactEmail;
//   final String phone;
//   final String createdAt;

//   ExpertProfile({
//     required this.expertId,
//     required this.fullName,
//     this.specialization,
//     this.organization,
//     this.contactEmail,
//     required this.phone,
//     required this.createdAt,
//   });

//   factory ExpertProfile.fromJson(Map<String, dynamic> json) {
//     return ExpertProfile(
//       expertId: json['expert_id'] ?? '',
//       fullName: json['full_name'] ?? '',
//       specialization: json['specialization'],
//       organization: json['organization'],
//       contactEmail: json['contact_email'],
//       phone: json['phone'] ?? '',
//       createdAt: json['created_at'] ?? '',
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'expert_id': expertId,
//       'full_name': fullName,
//       'specialization': specialization,
//       'organization': organization,
//       'contact_email': contactEmail,
//       'phone': phone,
//       'created_at': createdAt,
//     };
//   }
// }


// lib/models/profile_model.dart
class ProfileModel {
  final bool status;
  final String message;
  final ProfileData data;

  ProfileModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: ProfileData.fromJson(json['data'] ?? {}),
    );
  }
}

class ProfileData {
  final String role;
  final dynamic profile; // Can be ParentProfile or ExpertProfile

  ProfileData({
    required this.role,
    required this.profile,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    final role = json['role'] ?? '';
    
    if (role == 'parent') {
      return ProfileData(
        role: role,
        profile: ParentProfile.fromJson(json['profile'] ?? {}),
      );
    } else if (role == 'expert') {
      return ProfileData(
        role: role,
        profile: ExpertProfile.fromJson(json['profile'] ?? {}),
      );
    }
    
    return ProfileData(role: role, profile: null);
  }

  bool isParent() => role == 'parent';
  bool isExpert() => role == 'expert';
}

class ParentProfile {
  final String userId;
  final String fullName;
  final String phone;
  final String createdAt;

  ParentProfile({
    required this.userId,
    required this.fullName,
    required this.phone,
    required this.createdAt,
  });

  factory ParentProfile.fromJson(Map<String, dynamic> json) {
    return ParentProfile(
      userId: json['user_id'] ?? '',
      fullName: json['full_name'] ?? '',
      phone: json['phone'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'full_name': fullName,
      'phone': phone,
      'created_at': createdAt,
    };
  }
}

class ExpertProfile {
  final String expertId;
  final String fullName;
  final String? specialization;
  final String? organization;
  final String? contactEmail;
  final String phone;
  final String createdAt;

  ExpertProfile({
    required this.expertId,
    required this.fullName,
    this.specialization,
    this.organization,
    this.contactEmail,
    required this.phone,
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
      createdAt: json['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'expert_id': expertId,
      'full_name': fullName,
      'specialization': specialization,
      'organization': organization,
      'contact_email': contactEmail,
      'phone': phone,
      'created_at': createdAt,
    };
  }
}

// Update Profile Response Model
class UpdateProfileResponse {
  final bool status;
  final String message;
  final dynamic data; // Can be parent or expert data

  UpdateProfileResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) {
    return UpdateProfileResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: json['data'],
    );
  }
}

// Delete Profile Response Model
class DeleteProfileResponse {
  final bool status;
  final String message;
  final String? error;

  DeleteProfileResponse({
    required this.status,
    required this.message,
    this.error,
  });

  factory DeleteProfileResponse.fromJson(Map<String, dynamic> json) {
    return DeleteProfileResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      error: json['error'],
    );
  }
}