// // lib/app/models/signup_response.dart
// class SignupResponse {
//   final bool status;
//   final String message;
//   final SignupData? data;

//   SignupResponse({
//     required this.status,
//     required this.message,
//     this.data,
//   });

//   factory SignupResponse.fromJson(Map<String, dynamic> json) {
//     return SignupResponse(
//       status: json['status'] as bool? ?? false,
//       message: json['message'] as String? ?? '',
//       data: json['data'] != null 
//           ? SignupData.fromJson(json['data'] as Map<String, dynamic>)
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

// class SignupData {
//   final User user;
//   final Session session;
//   final Profile profile;

//   SignupData({
//     required this.user,
//     required this.session,
//     required this.profile,
//   });

//   factory SignupData.fromJson(Map<String, dynamic> json) {
//     return SignupData(
//       user: User.fromJson(json['user'] as Map<String, dynamic>),
//       session: Session.fromJson(json['session'] as Map<String, dynamic>),
//       profile: Profile.fromJson(json['profile'] as Map<String, dynamic>),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'user': user.toJson(),
//       'session': session.toJson(),
//       'profile': profile.toJson(),
//     };
//   }
// }

// class User {
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

//   User({
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

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
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

// class Session {
//   final String accessToken;
//   final String tokenType;
//   final int expiresIn;
//   final int expiresAt;
//   final String refreshToken;

//   Session({
//     required this.accessToken,
//     required this.tokenType,
//     required this.expiresIn,
//     required this.expiresAt,
//     required this.refreshToken,
//   });

//   factory Session.fromJson(Map<String, dynamic> json) {
//     return Session(
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

// class Profile {
//   final String userId;
//   final String fullName;
//   final String phone;
//   final String createdAt;

//   Profile({
//     required this.userId,
//     required this.fullName,
//     required this.phone,
//     required this.createdAt,
//   });

//   factory Profile.fromJson(Map<String, dynamic> json) {
//     return Profile(
//       userId: json['user_id'] as String? ?? '',
//       fullName: json['full_name'] as String? ?? '',
//       phone: json['phone'] as String? ?? '',
//       createdAt: json['created_at'] as String? ?? '',
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

// lib/app/models/signup_response.dart
class SignupResponse {
  final bool status;
  final String message;
  final SignupData? data;

  SignupResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) {
    return SignupResponse(
      status: json['status'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      data: json['data'] != null 
          ? SignupData.fromJson(json['data'] as Map<String, dynamic>)
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

class SignupData {
  final User user;
  final Session session;
  final String role;
  final ParentProfile profile;

  SignupData({
    required this.user,
    required this.session,
    required this.role,
    required this.profile,
  });

  factory SignupData.fromJson(Map<String, dynamic> json) {
    return SignupData(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      session: Session.fromJson(json['session'] as Map<String, dynamic>),
      role: json['role'] as String? ?? 'parent',
      profile: ParentProfile.fromJson(json['profile'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'session': session.toJson(),
      'role': role,
      'profile': profile.toJson(),
    };
  }
}

class User {
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

  User({
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

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
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

class Session {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final int expiresAt;
  final String refreshToken;

  Session({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.expiresAt,
    required this.refreshToken,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
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