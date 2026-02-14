// // lib/app/services/shared_preferences_service.dart
// import 'package:shared_preferences/shared_preferences.dart';

// class SharedPreferencesService {
//   static const String _keyUserId = 'user_id';
//   static const String _keyEmail = 'user_email';
//   static const String _keyFullName = 'user_full_name';
//   static const String _keyPhone = 'user_phone';
//   static const String _keyAccessToken = 'access_token';
//   static const String _keyRefreshToken = 'refresh_token';
//   static const String _keyRole = 'user_role';
//   static const String _keyExpiresAt = 'expires_at';

//   // Save user data
//   static Future<void> saveUserData({
//     required String userId,
//     required String email,
//     required String fullName,
//     required String phone,
//     required String accessToken,
//     required String refreshToken,
//     required String role,
//     required int expiresAt,
//   }) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_keyUserId, userId);
//     await prefs.setString(_keyEmail, email);
//     await prefs.setString(_keyFullName, fullName);
//     await prefs.setString(_keyPhone, phone);
//     await prefs.setString(_keyAccessToken, accessToken);
//     await prefs.setString(_keyRefreshToken, refreshToken);
//     await prefs.setString(_keyRole, role);
//     await prefs.setInt(_keyExpiresAt, expiresAt);
//   }

//   // Get access token (use this everywhere you need authentication)
//   static Future<String?> getAccessToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyAccessToken);
//   }

//   // Get user ID
//   static Future<String?> getUserId() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyUserId);
//   }

//   // Get user email
//   static Future<String?> getEmail() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyEmail);
//   }

//   // Get user full name
//   static Future<String?> getFullName() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyFullName);
//   }

//   // Get user phone
//   static Future<String?> getPhone() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyPhone);
//   }

//   // Get user role
//   static Future<String?> getRole() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyRole);
//   }

//   // Check if user is logged in
//   static Future<bool> isLoggedIn() async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString(_keyAccessToken);
//     return token != null && token.isNotEmpty;
//   }

//   // Clear all user data (for logout)
//   static Future<void> clearUserData() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(_keyUserId);
//     await prefs.remove(_keyEmail);
//     await prefs.remove(_keyFullName);
//     await prefs.remove(_keyPhone);
//     await prefs.remove(_keyAccessToken);
//     await prefs.remove(_keyRefreshToken);
//     await prefs.remove(_keyRole);
//     await prefs.remove(_keyExpiresAt);
//   }
// }


// // lib/app/services/shared_preferences_service.dart
// import 'package:shared_preferences/shared_preferences.dart';

// class SharedPreferencesService {
//   static const String _keyUserId = 'user_id';
//   static const String _keyEmail = 'user_email';
//   static const String _keyFullName = 'user_full_name';
//   static const String _keyPhone = 'user_phone';
//   static const String _keyAccessToken = 'access_token';
//   static const String _keyRefreshToken = 'refresh_token';
//   static const String _keyRole = 'user_role';
//   static const String _keyExpiresAt = 'expires_at';
//   static const String _keyIsLoggedIn = 'is_logged_in';

//   // Save user data after login/signup
//   static Future<void> saveUserData({
//     required String userId,
//     required String email,
//     String? fullName,
//     String? phone,
//     required String accessToken,
//     required String refreshToken,
//     String? role,
//     required int expiresAt,
//   }) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_keyUserId, userId);
//     await prefs.setString(_keyEmail, email);
//     if (fullName != null) await prefs.setString(_keyFullName, fullName);
//     if (phone != null) await prefs.setString(_keyPhone, phone);
//     await prefs.setString(_keyAccessToken, accessToken);
//     await prefs.setString(_keyRefreshToken, refreshToken);
//     if (role != null) await prefs.setString(_keyRole, role);
//     await prefs.setInt(_keyExpiresAt, expiresAt);
//     await prefs.setBool(_keyIsLoggedIn, true);
//   }

//   // Get access token (use this everywhere you need authentication)
//   static Future<String?> getAccessToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyAccessToken);
//   }

//   // Get refresh token
//   static Future<String?> getRefreshToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyRefreshToken);
//   }

//   // Get user ID
//   static Future<String?> getUserId() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyUserId);
//   }

//   // Get user email
//   static Future<String?> getEmail() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyEmail);
//   }

//   // Get user full name
//   static Future<String?> getFullName() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyFullName);
//   }

//   // Get user phone
//   static Future<String?> getPhone() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyPhone);
//   }

//   // Get user role
//   static Future<String?> getRole() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyRole);
//   }

//   // Get expires at
//   static Future<int?> getExpiresAt() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getInt(_keyExpiresAt);
//   }

//   // Check if user is logged in
//   static Future<bool> isLoggedIn() async {
//     final prefs = await SharedPreferences.getInstance();
//     final isLogged = prefs.getBool(_keyIsLoggedIn) ?? false;
//     final token = prefs.getString(_keyAccessToken);
    
//     // Return true only if both flag is set and token exists
//     return isLogged && token != null && token.isNotEmpty;
//   }

//   // Clear all user data (for logout)
//   static Future<void> clearUserData() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(_keyUserId);
//     await prefs.remove(_keyEmail);
//     await prefs.remove(_keyFullName);
//     await prefs.remove(_keyPhone);
//     await prefs.remove(_keyAccessToken);
//     await prefs.remove(_keyRefreshToken);
//     await prefs.remove(_keyRole);
//     await prefs.remove(_keyExpiresAt);
//     await prefs.setBool(_keyIsLoggedIn, false);
//   }

//   // Get all user data at once
//   static Future<Map<String, dynamic>> getAllUserData() async {
//     return {
//       'userId': await getUserId(),
//       'email': await getEmail(),
//       'fullName': await getFullName(),
//       'phone': await getPhone(),
//       'accessToken': await getAccessToken(),
//       'refreshToken': await getRefreshToken(),
//       'role': await getRole(),
//       'expiresAt': await getExpiresAt(),
//       'isLoggedIn': await isLoggedIn(),
//     };
//   }
// }

// // // Example: Making authenticated API calls
// // final token = await SharedPreferencesService.getAccessToken();

// // final response = await dio.get(
// //   'your-api-endpoint',
// //   options: Options(
// //     headers: {
// //       'Authorization': 'Bearer $token',
// //       'Content-Type': 'application/json',
// //     },
// //   ),
// // );

// // lib/app/services/shared_preferences_service.dart
// import 'package:shared_preferences/shared_preferences.dart';

// class SharedPreferencesService {
//   static const String _keyUserId = 'user_id';
//   static const String _keyEmail = 'user_email';
//   static const String _keyFullName = 'user_full_name';
//   static const String _keyPhone = 'user_phone';
//   static const String _keyAccessToken = 'access_token';
//   static const String _keyRefreshToken = 'refresh_token';
//   static const String _keyRole = 'user_role';
//   static const String _keyExpiresAt = 'expires_at';
//   static const String _keyIsLoggedIn = 'is_logged_in';

//   /* ----------------------------------------------------
//    SAVE USER DATA
//   ---------------------------------------------------- */
//   static Future<void> saveUserData({
//     required String userId,
//     required String email,
//     String? fullName,
//     String? phone,
//     required String accessToken,
//     required String refreshToken,
//     String? role,
//     required int expiresAt,
//   }) async {
//     final prefs = await SharedPreferences.getInstance();

//     await prefs.setString(_keyUserId, userId);
//     await prefs.setString(_keyEmail, email);
//     if (fullName != null) await prefs.setString(_keyFullName, fullName);
//     if (phone != null) await prefs.setString(_keyPhone, phone);
//     await prefs.setString(_keyAccessToken, accessToken);
//     await prefs.setString(_keyRefreshToken, refreshToken);
//     if (role != null) await prefs.setString(_keyRole, role);
//     await prefs.setInt(_keyExpiresAt, expiresAt);
//     await prefs.setBool(_keyIsLoggedIn, true);
//   }

//   /* ----------------------------------------------------
//    BASIC GETTERS
//   ---------------------------------------------------- */
//   static Future<String?> getAccessToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyAccessToken);
//   }

//   static Future<String?> getRefreshToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyRefreshToken);
//   }

//   static Future<String?> getUserId() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyUserId);
//   }

//   static Future<String?> getEmail() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyEmail);
//   }

//   static Future<String?> getFullName() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyFullName);
//   }

//   static Future<String?> getPhone() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyPhone);
//   }

//   static Future<String?> getRole() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyRole);
//   }

//   static Future<int?> getExpiresAt() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getInt(_keyExpiresAt);
//   }

//   /* ----------------------------------------------------
//    AUTH VALIDATION (USED IN SPLASH)
//   ---------------------------------------------------- */

//   /// Check if user is logged in
//   static Future<bool> isLoggedIn() async {
//     final prefs = await SharedPreferences.getInstance();
//     final isLogged = prefs.getBool(_keyIsLoggedIn) ?? false;
//     final token = prefs.getString(_keyAccessToken);

//     return isLogged && token != null && token.isNotEmpty;
//   }

//   /// Check if access token is expired
//   static Future<bool> isTokenExpired() async {
//     final prefs = await SharedPreferences.getInstance();
//     final expiresAt = prefs.getInt(_keyExpiresAt);

//     if (expiresAt == null) return true;

//     final currentTimestamp =
//         DateTime.now().millisecondsSinceEpoch ~/ 1000;

//     return currentTimestamp >= expiresAt;
//   }

//   /* ----------------------------------------------------
//    CLEAR DATA (LOGOUT)
//   ---------------------------------------------------- */
//   static Future<void> clearUserData() async {
//     final prefs = await SharedPreferences.getInstance();

//     await prefs.remove(_keyUserId);
//     await prefs.remove(_keyEmail);
//     await prefs.remove(_keyFullName);
//     await prefs.remove(_keyPhone);
//     await prefs.remove(_keyAccessToken);
//     await prefs.remove(_keyRefreshToken);
//     await prefs.remove(_keyRole);
//     await prefs.remove(_keyExpiresAt);
//     await prefs.setBool(_keyIsLoggedIn, false);
//   }

//   /* ----------------------------------------------------
//    DEBUG / HELPER
//   ---------------------------------------------------- */
//   static Future<Map<String, dynamic>> getAllUserData() async {
//     return {
//       'userId': await getUserId(),
//       'email': await getEmail(),
//       'fullName': await getFullName(),
//       'phone': await getPhone(),
//       'accessToken': await getAccessToken(),
//       'refreshToken': await getRefreshToken(),
//       'role': await getRole(),
//       'expiresAt': await getExpiresAt(),
//       'isLoggedIn': await isLoggedIn(),
//     };
//   }
// }



// lib/app/services/shared_preferences_service.dart
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPreferencesService {
  static const String _keyUserId = 'user_id';
  static const String _keyEmail = 'user_email';
  static const String _keyFullName = 'user_full_name';
  static const String _keyPhone = 'user_phone';
  static const String _keyAccessToken = 'access_token';
  static const String _keyRefreshToken = 'refresh_token';
  static const String _keyRole = 'user_role';
  static const String _keyExpiresAt = 'expires_at';
  static const String _keyIsLoggedIn = 'is_logged_in';
  
  // Profile keys
  static const String _keyProfileData = 'profile_data';
  static const String _keySpecialization = 'specialization';
  static const String _keyOrganization = 'organization';
  static const String _keyContactEmail = 'contact_email';
  static const String _keyPmdcNumber = 'pmdc_number';
  static const String _keyApprovalStatus = 'approval_status';
  static const String _keyProfileImagePublicId = 'profile_image_public_id';

  /* ----------------------------------------------------
   SAVE USER DATA (UPDATED)
  ---------------------------------------------------- */
  static Future<void> saveUserData({
    required String userId,
    required String email,
    String? fullName,
    String? phone,
    required String accessToken,
    required String refreshToken,
    String? role,
    required int expiresAt,
    Map<String, dynamic>? profileData,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_keyUserId, userId);
    await prefs.setString(_keyEmail, email);
    if (fullName != null) await prefs.setString(_keyFullName, fullName);
    if (phone != null) await prefs.setString(_keyPhone, phone);
    await prefs.setString(_keyAccessToken, accessToken);
    await prefs.setString(_keyRefreshToken, refreshToken);
    if (role != null) await prefs.setString(_keyRole, role);
    await prefs.setInt(_keyExpiresAt, expiresAt);
    await prefs.setBool(_keyIsLoggedIn, true);

    // Save profile data as JSON string
    if (profileData != null) {
      await prefs.setString(_keyProfileData, json.encode(profileData));
      
      // Save specific profile fields for easy access
      if (role?.toLowerCase() == 'expert') {
        if (profileData['specialization'] != null) {
          await prefs.setString(_keySpecialization, profileData['specialization']);
        }
        if (profileData['organization'] != null) {
          await prefs.setString(_keyOrganization, profileData['organization']);
        }
        if (profileData['contact_email'] != null) {
          await prefs.setString(_keyContactEmail, profileData['contact_email']);
        }
        if (profileData['pmdc_number'] != null) {
          await prefs.setString(_keyPmdcNumber, profileData['pmdc_number']);
        }
        if (profileData['approval_status'] != null) {
          await prefs.setString(_keyApprovalStatus, profileData['approval_status']);
        }
        if (profileData['profile_image_public_id'] != null) {
          await prefs.setString(_keyProfileImagePublicId, profileData['profile_image_public_id']);
        }
      }
    }
  }

  /* ----------------------------------------------------
   BASIC GETTERS
  ---------------------------------------------------- */
  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyAccessToken);
  }

  static Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyRefreshToken);
  }

  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserId);
  }

  static Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyEmail);
  }

  static Future<String?> getFullName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyFullName);
  }

  static Future<String?> getPhone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyPhone);
  }

  static Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyRole);
  }

  static Future<int?> getExpiresAt() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyExpiresAt);
  }

  /* ----------------------------------------------------
   PROFILE GETTERS
  ---------------------------------------------------- */
  static Future<Map<String, dynamic>?> getProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    final profileString = prefs.getString(_keyProfileData);
    
    if (profileString != null) {
      try {
        return json.decode(profileString) as Map<String, dynamic>;
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  static Future<String?> getSpecialization() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keySpecialization);
  }

  static Future<String?> getOrganization() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyOrganization);
  }

  static Future<String?> getContactEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyContactEmail);
  }

  static Future<String?> getPmdcNumber() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyPmdcNumber);
  }

  static Future<String?> getApprovalStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyApprovalStatus);
  }

  static Future<String?> getProfileImagePublicId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyProfileImagePublicId);
  }

  /* ----------------------------------------------------
   AUTH VALIDATION (USED IN SPLASH)
  ---------------------------------------------------- */

  /// Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final isLogged = prefs.getBool(_keyIsLoggedIn) ?? false;
    final token = prefs.getString(_keyAccessToken);

    return isLogged && token != null && token.isNotEmpty;
  }

  /// Check if access token is expired
  static Future<bool> isTokenExpired() async {
    final prefs = await SharedPreferences.getInstance();
    final expiresAt = prefs.getInt(_keyExpiresAt);

    if (expiresAt == null) return true;

    final currentTimestamp =
        DateTime.now().millisecondsSinceEpoch ~/ 1000;

    return currentTimestamp >= expiresAt;
  }

  /* ----------------------------------------------------
   CLEAR DATA (LOGOUT)
  ---------------------------------------------------- */
  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_keyUserId);
    await prefs.remove(_keyEmail);
    await prefs.remove(_keyFullName);
    await prefs.remove(_keyPhone);
    await prefs.remove(_keyAccessToken);
    await prefs.remove(_keyRefreshToken);
    await prefs.remove(_keyRole);
    await prefs.remove(_keyExpiresAt);
    await prefs.remove(_keyProfileData);
    await prefs.remove(_keySpecialization);
    await prefs.remove(_keyOrganization);
    await prefs.remove(_keyContactEmail);
    await prefs.remove(_keyPmdcNumber);
    await prefs.remove(_keyApprovalStatus);
    await prefs.remove(_keyProfileImagePublicId);
    await prefs.setBool(_keyIsLoggedIn, false);
  }

  /* ----------------------------------------------------
   DEBUG / HELPER
  ---------------------------------------------------- */
  static Future<Map<String, dynamic>> getAllUserData() async {
    return {
      'userId': await getUserId(),
      'email': await getEmail(),
      'fullName': await getFullName(),
      'phone': await getPhone(),
      'accessToken': await getAccessToken(),
      'refreshToken': await getRefreshToken(),
      'role': await getRole(),
      'expiresAt': await getExpiresAt(),
      'isLoggedIn': await isLoggedIn(),
      'profileData': await getProfileData(),
      'specialization': await getSpecialization(),
      'organization': await getOrganization(),
      'contactEmail': await getContactEmail(),
      'pmdcNumber': await getPmdcNumber(),
      'approvalStatus': await getApprovalStatus(),
      'profileImagePublicId': await getProfileImagePublicId(),
    };
  }
}