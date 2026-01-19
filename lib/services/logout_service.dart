// // lib/app/services/logout_service.dart
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import '../routes/app_urls.dart';
// import '../models/logout_response.dart';
// import 'shared_preferences_service.dart';

// class LogoutService {
//   final Dio dio = Dio();

//   Future<LogoutResponse> logout() async {
//     final apiEndPoint = APIEndPoints.logout;

//     try {
//       // Get access token for authentication
//       final token = await SharedPreferencesService.getAccessToken();

//       final response = await dio.post(
//         apiEndPoint,
//         options: Options(
//           headers: {
//             'Content-Type': 'application/json',
//             if (token != null) 'Authorization': 'Bearer $token',
//           },
//         ),
//       );

//       debugPrint('Logout API Response Status: ${response.statusCode}');
//       debugPrint('Logout API Response Data: ${response.data}');

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final logoutResponse = LogoutResponse.fromJson(
//           response.data as Map<String, dynamic>,
//         );

//         return logoutResponse;
//       } else {
//         return LogoutResponse(
//           status: false,
//           message: 'Server Error: Status ${response.statusCode}',
//         );
//       }
//     } on DioException catch (e) {
//       String errorMessage = 'Network Error: Failed to connect.';
      
//       if (e.response != null) {
//         debugPrint('Error Response Data: ${e.response!.data}');
        
//         try {
//           final errorData = e.response!.data;
          
//           if (errorData is Map<String, dynamic>) {
//             if (errorData.containsKey('message')) {
//               errorMessage = errorData['message'].toString();
//             } else if (errorData.containsKey('Message')) {
//               errorMessage = errorData['Message'].toString();
//             } else {
//               errorMessage = 'Logout Failed: Status ${e.response!.statusCode}';
//             }
//           } else {
//             errorMessage = 'Logout Failed: Status ${e.response!.statusCode}';
//           }
//         } catch (_) {
//           errorMessage = 'Logout Failed: Status ${e.response!.statusCode}';
//         }
//       } else if (e.type == DioExceptionType.connectionTimeout) {
//         errorMessage = 'Connection timeout. Please try again.';
//       } else if (e.type == DioExceptionType.receiveTimeout) {
//         errorMessage = 'Server is taking too long to respond.';
//       } else {
//         errorMessage = 'Connection Error: Please check your internet connection.';
//       }
      
//       debugPrint('Dio Error: $errorMessage');
//       return LogoutResponse(
//         status: false,
//         message: errorMessage,
//       );
//     } catch (e) {
//       debugPrint('An unexpected error occurred: $e');
//       return LogoutResponse(
//         status: false,
//         message: 'An unexpected error occurred during logout.',
//       );
//     }
//   }
// }


// // lib/services/logout_service.dart
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:speechspectrum/models/logout_response.dart';
// import 'package:speechspectrum/routes/app_urls.dart';
// import 'package:speechspectrum/services/shared_preferences_service.dart';
// import 'package:speechspectrum/services/storage_service.dart';


// class LogoutService {
//   final Dio _dio = Dio();
  

//   Future<LogoutResponse> logout() async {
//     try {
//       // // Get authorization token
//       // final authHeader = await _storageService.getAuthorizationHeader();
      
//       final token = await SharedPreferencesService.getAccessToken();

//       // if (authHeader == null) {
//       //   debugPrint('No authorization token found');
//       //   // Still clear local data even if no token
//       //   await _storageService.clearAllData();
//       //   return LogoutResponse(
//       //     message: 'Logged out locally',
//       //     status: true,
//       //   );
//       // }
       

//       debugPrint('Logout Request with Bearer token');
      
//       final response = await _dio.post(
//         APIEndPoints.logout,
//         options: Options(
//           headers: {
//             'Content-Type': 'application/json',
//             'Authorization': authHeader,
//           },
//         ),
//       );

//       debugPrint('Logout Response Status: ${response.statusCode}');
//       debugPrint('Logout Response Data: ${response.data}');

//       // Clear local data regardless of API response
//       await _storageService.clearAllData();
//       debugPrint('Local data cleared successfully');

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final logoutResponse = LogoutResponse.fromJson(
//           response.data as Map<String, dynamic>,
//         );
//         return logoutResponse;
//       } else {
//         // Data is already cleared, so still return success
//         return LogoutResponse(
//           message: 'Logged out successfully',
//           status: true,
//         );
//       }
//     } on DioException catch (e) {
//       // Clear local data even on error
//       await _storageService.clearAllData();
      
//       String errorMessage = 'Logged out locally';
      
//       if (e.response != null) {
//         debugPrint('Logout Error Response Status: ${e.response!.statusCode}');
//         debugPrint('Logout Error Response Data: ${e.response!.data}');
        
//         // Even if API fails, we cleared local data, so it's a success
//         return LogoutResponse(
//           message: 'Logged out successfully',
//           status: true,
//         );
//       } else {
//         debugPrint('Logout Network Error: ${e.message}');
//       }
      
//       // Return success since local data is cleared
//       return LogoutResponse(
//         message: errorMessage,
//         status: true,
//       );
//     } catch (e) {
//       debugPrint('Unexpected Logout Error: $e');
//       // Clear data anyway
//       await _storageService.clearAllData();
      
//       return LogoutResponse(
//         message: 'Logged out successfully',
//         status: true,
//       );
//     }
//   }
// }

// lib/services/logout_service.dart
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:speechspectrum/models/logout_response.dart';
import 'package:speechspectrum/routes/app_urls.dart';
import 'package:speechspectrum/services/shared_preferences_service.dart';

class LogoutService {
  final Dio _dio = Dio();

  Future<LogoutResponse> logout() async {
    try {
      // Get access token
      final token = await SharedPreferencesService.getAccessToken();

      // Call logout API only if token exists
      if (token != null && token.isNotEmpty) {
        debugPrint('🔐 Logout API called with token');

        await _dio.post(
          APIEndPoints.logout,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
          ),
        );
      } else {
        debugPrint('⚠️ No token found, skipping API call');
      }

      // ✅ Always clear local data
      await SharedPreferencesService.clearUserData();
      debugPrint('🧹 Local user data cleared');

      return LogoutResponse(
        status: true,
        message: 'Logged out successfully',
      );
    } on DioException catch (e) {
      debugPrint('❌ Logout API error: ${e.message}');

      // Even if API fails, clear local data
      await SharedPreferencesService.clearUserData();

      return LogoutResponse(
        status: true,
        message: 'Logged out successfully',
      );
    } catch (e) {
      debugPrint('❌ Unexpected logout error: $e');

      await SharedPreferencesService.clearUserData();

      return LogoutResponse(
        status: true,
        message: 'Logged out successfully',
      );
    }
  }
}
