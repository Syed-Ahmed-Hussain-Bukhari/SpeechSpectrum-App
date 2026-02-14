// // lib/app/models/login_response.dart
// class LoginResponse {
//   final bool status;
//   final String message;
//   final LoginData? data;
//   final String? error;

//   LoginResponse({
//     required this.status,
//     required this.message,
//     this.data,
//     this.error,
//   });

//   factory LoginResponse.fromJson(Map<String, dynamic> json) {
//     return LoginResponse(
//       status: json['status'] as bool? ?? false,
//       message: json['message'] as String? ?? '',
//       error: json['error'] as String?,
//       data: json['data'] != null 
//           ? LoginData.fromJson(json['data'] as Map<String, dynamic>)
//           : null,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'status': status,
//       'message': message,
//       'error': error,
//       'data': data?.toJson(),
//     };
//   }
// }

// class LoginData {
//   final LoginUser user;
//   final LoginSession session;

//   LoginData({
//     required this.user,
//     required this.session,
//   });

//   factory LoginData.fromJson(Map<String, dynamic> json) {
//     return LoginData(
//       user: LoginUser.fromJson(json['user'] as Map<String, dynamic>),
//       session: LoginSession.fromJson(json['session'] as Map<String, dynamic>),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'user': user.toJson(),
//       'session': session.toJson(),
//     };
//   }
// }

// class LoginUser {
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

//   LoginUser({
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
//   });

//   factory LoginUser.fromJson(Map<String, dynamic> json) {
//     return LoginUser(
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
//     };
//   }
// }

// class LoginSession {
//   final String accessToken;
//   final String tokenType;
//   final int expiresIn;
//   final int expiresAt;
//   final String refreshToken;

//   LoginSession({
//     required this.accessToken,
//     required this.tokenType,
//     required this.expiresIn,
//     required this.expiresAt,
//     required this.refreshToken,
//   });

//   factory LoginSession.fromJson(Map<String, dynamic> json) {
//     return LoginSession(
//       accessToken: json['access_token'] as String? ?? '',
//       tokenType: json['token_type'] as String? ?? '',
//       expiresIn: json['expires_in'] as int? ?? 0,
//       expiresAt: json['expires_at'] as int? ?? 0,
//       refreshToken: json['refresh_token'] as String? ?? '',
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'access_token': accessToken,
//       'token_type': tokenType,
//       'expires_in': expiresIn,
//       'expires_at': expiresAt,
//       'refresh_token': refreshToken,
//     };
//   }
// }


// lib/app/models/login_response.dart
class LoginResponse {
  final bool status;
  final String message;
  final LoginData? data;
  final String? error;

  LoginResponse({
    required this.status,
    required this.message,
    this.data,
    this.error,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      error: json['error'] as String?,
      data: json['data'] != null 
          ? LoginData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'error': error,
      'data': data?.toJson(),
    };
  }
}

class LoginData {
  final LoginUser user;
  final LoginSession session;
  final String role;
  final dynamic profile; // Can be ExpertProfile or ParentProfile

  LoginData({
    required this.user,
    required this.session,
    required this.role,
    this.profile,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    final role = json['role'] as String? ?? '';
    dynamic profile;

    if (json['profile'] != null) {
      if (role.toLowerCase() == 'expert') {
        profile = ExpertProfile.fromJson(json['profile'] as Map<String, dynamic>);
      } else if (role.toLowerCase() == 'parent') {
        profile = ParentProfile.fromJson(json['profile'] as Map<String, dynamic>);
      }
    }

    return LoginData(
      user: LoginUser.fromJson(json['user'] as Map<String, dynamic>),
      session: LoginSession.fromJson(json['session'] as Map<String, dynamic>),
      role: role,
      profile: profile,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'session': session.toJson(),
      'role': role,
      'profile': profile is ExpertProfile 
          ? (profile as ExpertProfile).toJson()
          : profile is ParentProfile
              ? (profile as ParentProfile).toJson()
              : null,
    };
  }
}

class LoginUser {
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

  LoginUser({
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
  });

  factory LoginUser.fromJson(Map<String, dynamic> json) {
    return LoginUser(
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
    };
  }
}

class LoginSession {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final int expiresAt;
  final String refreshToken;

  LoginSession({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.expiresAt,
    required this.refreshToken,
  });

  factory LoginSession.fromJson(Map<String, dynamic> json) {
    return LoginSession(
      accessToken: json['access_token'] as String? ?? '',
      tokenType: json['token_type'] as String? ?? '',
      expiresIn: json['expires_in'] as int? ?? 0,
      expiresAt: json['expires_at'] as int? ?? 0,
      refreshToken: json['refresh_token'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'token_type': tokenType,
      'expires_in': expiresIn,
      'expires_at': expiresAt,
      'refresh_token': refreshToken,
    };
  }
}

// Expert Profile Model
class ExpertProfile {
  final String expertId;
  final String fullName;
  final String specialization;
  final String organization;
  final String contactEmail;
  final String phone;
  final String pmdcNumber;
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
    required this.specialization,
    required this.organization,
    required this.contactEmail,
    required this.phone,
    required this.pmdcNumber,
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
      expertId: json['expert_id'] as String? ?? '',
      fullName: json['full_name'] as String? ?? '',
      specialization: json['specialization'] as String? ?? '',
      organization: json['organization'] as String? ?? '',
      contactEmail: json['contact_email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      pmdcNumber: json['pmdc_number'] as String? ?? '',
      profileImagePublicId: json['profile_image_public_id'] as String?,
      degreeDocPublicId: json['degree_doc_public_id'] as String?,
      certificateDocPublicId: json['certificate_doc_public_id'] as String?,
      approvalStatus: json['approval_status'] as String? ?? '',
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

// Parent Profile Model
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
      userId: json['user_id'] as String? ?? '',
      fullName: json['full_name'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      createdAt: json['created_at'] as String? ?? '',
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