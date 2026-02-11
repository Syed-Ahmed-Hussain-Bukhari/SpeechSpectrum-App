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

// lib/app/services/storage_service.dart
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:speechspectrum/routes/app_urls.dart';

class StorageService {
  final Dio dio = Dio();

  /// Upload image and get public_id
  Future<String?> uploadImage(File imageFile) async {
    final apiEndPoint = APIEndPoints.uploadImage;

    try {
      String fileName = imageFile.path.split('/').last;
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
        ),
      });

      debugPrint('Uploading image: $fileName');

      final response = await dio.post(
        apiEndPoint,
        data: formData,
        options: Options(
          headers: {'Content-Type': 'multipart/form-data'},
        ),
      );

      debugPrint('Image Upload Response Status: ${response.statusCode}');
      debugPrint('Image Upload Response Data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data as Map<String, dynamic>;
        
        if (responseData['status'] == true && responseData['data'] != null) {
          final imagePublicId = responseData['data']['image_public_id'] as String?;
          
          if (imagePublicId != null) {
            debugPrint('Image uploaded successfully: $imagePublicId');
            return imagePublicId;
          }
        }
      }

      debugPrint('Failed to upload image: Invalid response');
      return null;
    } on DioException catch (e) {
      debugPrint('Dio Error uploading image: ${e.message}');
      
      if (e.response != null) {
        debugPrint('Error Response Data: ${e.response!.data}');
      }
      
      return null;
    } catch (e) {
      debugPrint('Error uploading image: $e');
      return null;
    }
  }

  /// Upload document (PDF only) and get public_id
  Future<String?> uploadDocument(File documentFile) async {
    final apiEndPoint = APIEndPoints.uploadDocument;

    try {
      String fileName = documentFile.path.split('/').last;
      
      // Check if file is PDF
      if (!fileName.toLowerCase().endsWith('.pdf')) {
        debugPrint('Only PDF files are allowed');
        return null;
      }

      FormData formData = FormData.fromMap({
        'document': await MultipartFile.fromFile(
          documentFile.path,
          filename: fileName,
        ),
      });

      debugPrint('Uploading document: $fileName');

      final response = await dio.post(
        apiEndPoint,
        data: formData,
        options: Options(
          headers: {'Content-Type': 'multipart/form-data'},
        ),
      );

      debugPrint('Document Upload Response Status: ${response.statusCode}');
      debugPrint('Document Upload Response Data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data as Map<String, dynamic>;
        
        if (responseData['status'] == true && responseData['data'] != null) {
          final documentPublicId = responseData['data']['document_public_id'] as String?;
          
          if (documentPublicId != null) {
            debugPrint('Document uploaded successfully: $documentPublicId');
            return documentPublicId;
          }
        }
      }

      debugPrint('Failed to upload document: Invalid response');
      return null;
    } on DioException catch (e) {
      debugPrint('Dio Error uploading document: ${e.message}');
      
      if (e.response != null) {
        debugPrint('Error Response Data: ${e.response!.data}');
        
        // Check for file format error
        final errorData = e.response!.data;
        if (errorData is Map<String, dynamic> && errorData['message'] != null) {
          debugPrint('Upload Error: ${errorData['message']}');
        }
      }
      
      return null;
    } catch (e) {
      debugPrint('Error uploading document: $e');
      return null;
    }
  }
}