// // lib/app/models/expert_signup_response.dart
// class ExpertSignupResponse {
//   final bool status;
//   final String message;
//   final ExpertSignupData? data;

//   ExpertSignupResponse({
//     required this.status,
//     required this.message,
//     this.data,
//   });

//   factory ExpertSignupResponse.fromJson(Map<String, dynamic> json) {
//     return ExpertSignupResponse(
//       status: json['status'] as bool? ?? false,
//       message: json['message'] as String? ?? '',
//       data: json['data'] != null
//           ? ExpertSignupData.fromJson(json['data'] as Map<String, dynamic>)
//           : null,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'status': status,
//       'message': message,
//       'data': data?.toJson(),
//     };
//   }
// }

// class ExpertSignupData {
//   final ExpertUser user;
//   final ExpertProfile profile;

//   ExpertSignupData({
//     required this.user,
//     required this.profile,
//   });

//   factory ExpertSignupData.fromJson(Map<String, dynamic> json) {
//     return ExpertSignupData(
//       user: ExpertUser.fromJson(json['user'] as Map<String, dynamic>),
//       profile: ExpertProfile.fromJson(json['profile'] as Map<String, dynamic>),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'user': user.toJson(),
//       'profile': profile.toJson(),
//     };
//   }
// }

// class ExpertUser {
//   final String id;
//   final String aud;
//   final String role;
//   final String email;
//   final String? emailConfirmedAt;
//   final String phone;
//   final String? confirmedAt;
//   final String? lastSignInAt;
//   final String createdAt;
//   final String updatedAt;
//   final bool isAnonymous;
//   final Map<String, dynamic>? appMetadata;
//   final Map<String, dynamic>? userMetadata;
//   final List<Identity>? identities;

//   ExpertUser({
//     required this.id,
//     required this.aud,
//     required this.role,
//     required this.email,
//     this.emailConfirmedAt,
//     required this.phone,
//     this.confirmedAt,
//     this.lastSignInAt,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.isAnonymous,
//     this.appMetadata,
//     this.userMetadata,
//     this.identities,
//   });

//   factory ExpertUser.fromJson(Map<String, dynamic> json) {
//     return ExpertUser(
//       id: json['id'] as String? ?? '',
//       aud: json['aud'] as String? ?? '',
//       role: json['role'] as String? ?? '',
//       email: json['email'] as String? ?? '',
//       emailConfirmedAt: json['email_confirmed_at'] as String?,
//       phone: json['phone'] as String? ?? '',
//       confirmedAt: json['confirmed_at'] as String?,
//       lastSignInAt: json['last_sign_in_at'] as String?,
//       createdAt: json['created_at'] as String? ?? '',
//       updatedAt: json['updated_at'] as String? ?? '',
//       isAnonymous: json['is_anonymous'] as bool? ?? false,
//       appMetadata: json['app_metadata'] as Map<String, dynamic>?,
//       userMetadata: json['user_metadata'] as Map<String, dynamic>?,
//       identities: json['identities'] != null
//           ? (json['identities'] as List)
//               .map((i) => Identity.fromJson(i as Map<String, dynamic>))
//               .toList()
//           : null,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'aud': aud,
//       'role': role,
//       'email': email,
//       'email_confirmed_at': emailConfirmedAt,
//       'phone': phone,
//       'confirmed_at': confirmedAt,
//       'last_sign_in_at': lastSignInAt,
//       'created_at': createdAt,
//       'updated_at': updatedAt,
//       'is_anonymous': isAnonymous,
//       'app_metadata': appMetadata,
//       'user_metadata': userMetadata,
//       'identities': identities?.map((i) => i.toJson()).toList(),
//     };
//   }
// }

// class Identity {
//   final String identityId;
//   final String id;
//   final String userId;
//   final Map<String, dynamic>? identityData;
//   final String provider;
//   final String? lastSignInAt;
//   final String createdAt;
//   final String updatedAt;
//   final String? email;

//   Identity({
//     required this.identityId,
//     required this.id,
//     required this.userId,
//     this.identityData,
//     required this.provider,
//     this.lastSignInAt,
//     required this.createdAt,
//     required this.updatedAt,
//     this.email,
//   });

//   factory Identity.fromJson(Map<String, dynamic> json) {
//     return Identity(
//       identityId: json['identity_id'] as String? ?? '',
//       id: json['id'] as String? ?? '',
//       userId: json['user_id'] as String? ?? '',
//       identityData: json['identity_data'] as Map<String, dynamic>?,
//       provider: json['provider'] as String? ?? '',
//       lastSignInAt: json['last_sign_in_at'] as String?,
//       createdAt: json['created_at'] as String? ?? '',
//       updatedAt: json['updated_at'] as String? ?? '',
//       email: json['email'] as String?,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'identity_id': identityId,
//       'id': id,
//       'user_id': userId,
//       'identity_data': identityData,
//       'provider': provider,
//       'last_sign_in_at': lastSignInAt,
//       'created_at': createdAt,
//       'updated_at': updatedAt,
//       'email': email,
//     };
//   }
// }

// class ExpertProfile {
//   final String expertId;
//   final String fullName;
//   final String specialization;
//   final String organization;
//   final String contactEmail;
//   final String phone;
//   final String pmdcNumber;
//   final String profileImagePublicId;
//   final String degreeDocPublicId;
//   final String certificateDocPublicId;
//   final String approvalStatus;
//   final String? approvedBy;
//   final String? approvedAt;
//   final String createdAt;

//   ExpertProfile({
//     required this.expertId,
//     required this.fullName,
//     required this.specialization,
//     required this.organization,
//     required this.contactEmail,
//     required this.phone,
//     required this.pmdcNumber,
//     required this.profileImagePublicId,
//     required this.degreeDocPublicId,
//     required this.certificateDocPublicId,
//     required this.approvalStatus,
//     this.approvedBy,
//     this.approvedAt,
//     required this.createdAt,
//   });

//   factory ExpertProfile.fromJson(Map<String, dynamic> json) {
//     return ExpertProfile(
//       expertId: json['expert_id'] as String? ?? '',
//       fullName: json['full_name'] as String? ?? '',
//       specialization: json['specialization'] as String? ?? '',
//       organization: json['organization'] as String? ?? '',
//       contactEmail: json['contact_email'] as String? ?? '',
//       phone: json['phone'] as String? ?? '',
//       pmdcNumber: json['pmdc_number'] as String? ?? '',
//       profileImagePublicId: json['profile_image_public_id'] as String? ?? '',
//       degreeDocPublicId: json['degree_doc_public_id'] as String? ?? '',
//       certificateDocPublicId: json['certificate_doc_public_id'] as String? ?? '',
//       approvalStatus: json['approval_status'] as String? ?? 'pending',
//       approvedBy: json['approved_by'] as String?,
//       approvedAt: json['approved_at'] as String?,
//       createdAt: json['created_at'] as String? ?? '',
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
//       'pmdc_number': pmdcNumber,
//       'profile_image_public_id': profileImagePublicId,
//       'degree_doc_public_id': degreeDocPublicId,
//       'certificate_doc_public_id': certificateDocPublicId,
//       'approval_status': approvalStatus,
//       'approved_by': approvedBy,
//       'approved_at': approvedAt,
//       'created_at': createdAt,
//     };
//   }
// }


// lib/app/models/expert_signup_response.dart
class ExpertSignupResponse {
  final bool status;
  final String message;
  final ExpertSignupData? data;

  ExpertSignupResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory ExpertSignupResponse.fromJson(Map<String, dynamic> json) {
    return ExpertSignupResponse(
      status: json['status'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      data: json['data'] != null
          ? ExpertSignupData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class ExpertSignupData {
  final ExpertUser user;
  final String role;
  final ExpertProfile profile;

  ExpertSignupData({
    required this.user,
    required this.role,
    required this.profile,
  });

  factory ExpertSignupData.fromJson(Map<String, dynamic> json) {
    return ExpertSignupData(
      user: ExpertUser.fromJson(json['user'] as Map<String, dynamic>),
      role: json['role'] as String? ?? 'expert',
      profile: ExpertProfile.fromJson(json['profile'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'role': role,
      'profile': profile.toJson(),
    };
  }
}

class ExpertUser {
  final String id;
  final String aud;
  final String role;
  final String email;
  final String? emailConfirmedAt;
  final String phone;
  final String? confirmedAt;
  final String? lastSignInAt;
  final String createdAt;
  final String updatedAt;
  final bool isAnonymous;
  final Map<String, dynamic>? appMetadata;
  final Map<String, dynamic>? userMetadata;
  final List<Identity>? identities;

  ExpertUser({
    required this.id,
    required this.aud,
    required this.role,
    required this.email,
    this.emailConfirmedAt,
    required this.phone,
    this.confirmedAt,
    this.lastSignInAt,
    required this.createdAt,
    required this.updatedAt,
    required this.isAnonymous,
    this.appMetadata,
    this.userMetadata,
    this.identities,
  });

  factory ExpertUser.fromJson(Map<String, dynamic> json) {
    return ExpertUser(
      id: json['id'] as String? ?? '',
      aud: json['aud'] as String? ?? '',
      role: json['role'] as String? ?? '',
      email: json['email'] as String? ?? '',
      emailConfirmedAt: json['email_confirmed_at'] as String?,
      phone: json['phone'] as String? ?? '',
      confirmedAt: json['confirmed_at'] as String?,
      lastSignInAt: json['last_sign_in_at'] as String?,
      createdAt: json['created_at'] as String? ?? '',
      updatedAt: json['updated_at'] as String? ?? '',
      isAnonymous: json['is_anonymous'] as bool? ?? false,
      appMetadata: json['app_metadata'] as Map<String, dynamic>?,
      userMetadata: json['user_metadata'] as Map<String, dynamic>?,
      identities: json['identities'] != null
          ? (json['identities'] as List)
              .map((i) => Identity.fromJson(i as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'aud': aud,
      'role': role,
      'email': email,
      'email_confirmed_at': emailConfirmedAt,
      'phone': phone,
      'confirmed_at': confirmedAt,
      'last_sign_in_at': lastSignInAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'is_anonymous': isAnonymous,
      'app_metadata': appMetadata,
      'user_metadata': userMetadata,
      'identities': identities?.map((i) => i.toJson()).toList(),
    };
  }
}

class Identity {
  final String identityId;
  final String id;
  final String userId;
  final Map<String, dynamic>? identityData;
  final String provider;
  final String? lastSignInAt;
  final String createdAt;
  final String updatedAt;
  final String? email;

  Identity({
    required this.identityId,
    required this.id,
    required this.userId,
    this.identityData,
    required this.provider,
    this.lastSignInAt,
    required this.createdAt,
    required this.updatedAt,
    this.email,
  });

  factory Identity.fromJson(Map<String, dynamic> json) {
    return Identity(
      identityId: json['identity_id'] as String? ?? '',
      id: json['id'] as String? ?? '',
      userId: json['user_id'] as String? ?? '',
      identityData: json['identity_data'] as Map<String, dynamic>?,
      provider: json['provider'] as String? ?? '',
      lastSignInAt: json['last_sign_in_at'] as String?,
      createdAt: json['created_at'] as String? ?? '',
      updatedAt: json['updated_at'] as String? ?? '',
      email: json['email'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'identity_id': identityId,
      'id': id,
      'user_id': userId,
      'identity_data': identityData,
      'provider': provider,
      'last_sign_in_at': lastSignInAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'email': email,
    };
  }
}

class ExpertProfile {
  final String expertId;
  final String fullName;
  final String specialization;
  final String organization;
  final String contactEmail;
  final String phone;
  final String pmdcNumber;
  final String profileImagePublicId;
  final String degreeDocPublicId;
  final String certificateDocPublicId;
  final String approvalStatus;
  final String? approvedBy;
  final String? approvedAt;
  final String createdAt;

  ExpertProfile({
    required this.expertId,
    required this.fullName,
    required this.specialization,
    required this.organization,
    required this.contactEmail,
    required this.phone,
    required this.pmdcNumber,
    required this.profileImagePublicId,
    required this.degreeDocPublicId,
    required this.certificateDocPublicId,
    required this.approvalStatus,
    this.approvedBy,
    this.approvedAt,
    required this.createdAt,
  });

  factory ExpertProfile.fromJson(Map<String, dynamic> json) {
    return ExpertProfile(
      expertId: json['expert_id'] as String? ?? '',
      fullName: json['full_name'] as String? ?? '',
      specialization: json['specialization'] as String? ?? '',
      organization: json['organization'] as String? ?? '',
      contactEmail: json['contact_email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      pmdcNumber: json['pmdc_number'] as String? ?? '',
      profileImagePublicId: json['profile_image_public_id'] as String? ?? '',
      degreeDocPublicId: json['degree_doc_public_id'] as String? ?? '',
      certificateDocPublicId: json['certificate_doc_public_id'] as String? ?? '',
      approvalStatus: json['approval_status'] as String? ?? 'pending',
      approvedBy: json['approved_by'] as String?,
      approvedAt: json['approved_at'] as String?,
      createdAt: json['created_at'] as String? ?? '',
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
      'pmdc_number': pmdcNumber,
      'profile_image_public_id': profileImagePublicId,
      'degree_doc_public_id': degreeDocPublicId,
      'certificate_doc_public_id': certificateDocPublicId,
      'approval_status': approvalStatus,
      'approved_by': approvedBy,
      'approved_at': approvedAt,
      'created_at': createdAt,
    };
  }
}