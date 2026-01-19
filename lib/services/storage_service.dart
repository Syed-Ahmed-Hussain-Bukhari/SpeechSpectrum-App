// // lib/services/storage_service.dart
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:speechspectrum/models/login_response.dart';
// import 'package:speechspectrum/models/signup_response.dart';

// class StorageService {
//   static const String _keyIsLoggedIn = 'isLoggedIn';
//   static const String _keyAccessToken = 'accessToken';
//   static const String _keyRefreshToken = 'refreshToken';
//   static const String _keyTokenType = 'tokenType';
//   static const String _keyExpiresAt = 'expiresAt';
//   static const String _keyUserData = 'userData';

//   // Save login data
//   Future<void> saveLoginData(LoginResponse loginResponse) async {
//     final prefs = await SharedPreferences.getInstance();
    
//     if (loginResponse.data != null) {
//       await prefs.setBool(_keyIsLoggedIn, true);
//       await prefs.setString(_keyAccessToken, loginResponse.data!.session.accessToken);
//       await prefs.setString(_keyRefreshToken, loginResponse.data!.session.refreshToken);
//       await prefs.setString(_keyTokenType, loginResponse.data!.session.tokenType);
//       await prefs.setInt(_keyExpiresAt, loginResponse.data!.session.expiresAt);
//       await prefs.setString(_keyUserData, jsonEncode(loginResponse.data!.user.toJson()));
//     }
//   }

//   // Check if user is logged in
//   Future<bool> isLoggedIn() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getBool(_keyIsLoggedIn) ?? false;
//   }

//   // Get access token
//   Future<String?> getAccessToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyAccessToken);
//   }

//   // Get token type
//   Future<String?> getTokenType() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyTokenType);
//   }

//   // Get full authorization header
//   Future<String?> getAuthorizationHeader() async {
//     final tokenType = await getTokenType();
//     final accessToken = await getAccessToken();
    
//     if (tokenType != null && accessToken != null) {
//       return '$tokenType $accessToken';
//     }
//     return null;
//   }

//   // Check if token is expired
//   Future<bool> isTokenExpired() async {
//     final prefs = await SharedPreferences.getInstance();
//     final expiresAt = prefs.getInt(_keyExpiresAt);
    
//     if (expiresAt == null) return true;
    
//     final currentTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
//     return currentTimestamp >= expiresAt;
//   }

//   // Get user data
//   Future<User?> getUserData() async {
//     final prefs = await SharedPreferences.getInstance();
//     final userDataString = prefs.getString(_keyUserData);
    
//     if (userDataString != null) {
//       try {
//         final Map<String, dynamic> userJson = jsonDecode(userDataString);
//         return User.fromJson(userJson);
//       } catch (e) {
//         print('Error parsing user data: $e');
//         return null;
//       }
//     }
//     return null;
//   }

//   // Clear all data (logout)
//   Future<void> clearAllData() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(_keyIsLoggedIn);
//     await prefs.remove(_keyAccessToken);
//     await prefs.remove(_keyRefreshToken);
//     await prefs.remove(_keyTokenType);
//     await prefs.remove(_keyExpiresAt);
//     await prefs.remove(_keyUserData);
//   }

//   // Clear all app data (complete reset)
//   Future<void> clearAll() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.clear();
//   }
// }