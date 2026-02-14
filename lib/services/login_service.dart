// // lib/app/services/login_service.dart
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import '../routes/app_urls.dart';
// import '../models/login_response.dart';

// class LoginService {
//   final Dio dio = Dio();

//   Future<LoginResponse> login({
//     required String email,
//     required String password,
//   }) async {
//     final apiEndPoint = APIEndPoints.login;

//     try {
//       final response = await dio.post(
//         apiEndPoint,
//         data: {
//           'email': email,
//           'password': password,
//         },
//         options: Options(
//           headers: {'Content-Type': 'application/json'},
//         ),
//       );

//       debugPrint('Login API Response Status: ${response.statusCode}');
//       debugPrint('Login API Response Data: ${response.data}');

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final loginResponse = LoginResponse.fromJson(
//           response.data as Map<String, dynamic>,
//         );

//         return loginResponse;
//       } else {
//         return LoginResponse(
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
//             } else if (errorData.containsKey('error')) {
//               errorMessage = errorData['error'].toString();
//             } else if (errorData.containsKey('Message')) {
//               errorMessage = errorData['Message'].toString();
//             } else {
//               errorMessage = 'Login Failed: Status ${e.response!.statusCode}';
//             }
//           } else {
//             errorMessage = 'Login Failed: Status ${e.response!.statusCode}';
//           }
//         } catch (_) {
//           errorMessage = 'Login Failed: Status ${e.response!.statusCode}';
//         }
//       } else if (e.type == DioExceptionType.connectionTimeout) {
//         errorMessage = 'Connection timeout. Please try again.';
//       } else if (e.type == DioExceptionType.receiveTimeout) {
//         errorMessage = 'Server is taking too long to respond.';
//       } else {
//         errorMessage = 'Connection Error: Please check your internet connection.';
//       }
      
//       debugPrint('Dio Error: $errorMessage');
//       return LoginResponse(
//         status: false,
//         message: errorMessage,
//       );
//     } catch (e) {
//       debugPrint('An unexpected error occurred: $e');
//       return LoginResponse(
//         status: false,
//         message: 'An unexpected error occurred during login.',
//       );
//     }
//   }
// }

// // lib/services/login_service.dart
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:speechspectrum/models/login_response.dart';
// import 'package:speechspectrum/routes/app_urls.dart';
// import 'package:speechspectrum/services/shared_preferences_service.dart';
// import 'package:speechspectrum/services/storage_service.dart';


// class LoginService {
//   final Dio _dio = Dio();


//   Future<LoginResponse> login(String email, String password) async {
//     try {
//       debugPrint('Login Request - Email: $email');
      
//       final response = await _dio.post(
//         APIEndPoints.login,
//         data: {
//           'email': email,
//           'password': password,
//         },
//         options: Options(
//           headers: {'Content-Type': 'application/json'},
//         ),
//       );

//       debugPrint('Login Response Status: ${response.statusCode}');
//       debugPrint('Login Response Data: ${response.data}');

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final loginResponse = LoginResponse.fromJson(
//           response.data as Map<String, dynamic>,
//         );

//         // Save login data to shared preferences if successful
//         if (loginResponse.status && loginResponse.data != null) {
//            final user = loginResponse.data!.user;
//           final session = loginResponse.data!.session;

//           // ✅ SAVE LOGIN DATA
//           await SharedPreferencesService.saveUserData(
//             userId: user.id,
//             email: user.email,
//             phone: user.phone,
//             role: user.role,
//             accessToken: session.accessToken,
//             refreshToken: session.refreshToken,
//             expiresAt: session.expiresAt,
//           );

//           debugPrint('✅ Login data saved to SharedPreferences');
//         }

//         return loginResponse;
//       } else {
//         return LoginResponse(
//           message: 'Server Error: Status ${response.statusCode}',
//           status: false,
//         );
//       }
//     } on DioException catch (e) {
//       String errorMessage = 'Network Error: Failed to connect.';
      
//       if (e.response != null) {
//         debugPrint('Error Response Status: ${e.response!.statusCode}');
//         debugPrint('Error Response Data: ${e.response!.data}');
        
//         try {
//           final errorData = e.response!.data;
          
//           if (errorData is Map<String, dynamic>) {
//             if (errorData.containsKey('message')) {
//               errorMessage = errorData['message'].toString();
//             } else if (errorData.containsKey('error')) {
//               errorMessage = errorData['error'].toString();
//             }
//           }
//         } catch (_) {
//           errorMessage = 'Login Failed: Status ${e.response!.statusCode}';
//         }
//       } else if (e.type == DioExceptionType.connectionTimeout) {
//         errorMessage = 'Connection timeout. Please try again.';
//       } else if (e.type == DioExceptionType.receiveTimeout) {
//         errorMessage = 'Server is taking too long to respond.';
//       } else {
//         errorMessage = 'Connection Error: Please check your internet connection.';
//       }
      
//       debugPrint('Login Error: $errorMessage');
      
//       return LoginResponse(
//         message: errorMessage,
//         status: false,
//       );
//     } catch (e) {
//       debugPrint('Unexpected Login Error: $e');
//       return LoginResponse(
//         message: 'An unexpected error occurred during login.',
//         status: false,
//       );
//     }
//   }
// }


// lib/services/login_service.dart
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:speechspectrum/models/login_response.dart';
import 'package:speechspectrum/routes/app_urls.dart';
import 'package:speechspectrum/services/shared_preferences_service.dart';

class LoginService {
  final Dio _dio = Dio();

  Future<LoginResponse> login(String email, String password) async {
    try {
      debugPrint('Login Request - Email: $email');
      
      final response = await _dio.post(
        APIEndPoints.login,
        data: {
          'email': email,
          'password': password,
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      debugPrint('Login Response Status: ${response.statusCode}');
      debugPrint('Login Response Data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final loginResponse = LoginResponse.fromJson(
          response.data as Map<String, dynamic>,
        );

        // Save login data to shared preferences if successful
        if (loginResponse.status && loginResponse.data != null) {
          final user = loginResponse.data!.user;
          final session = loginResponse.data!.session;
          final role = loginResponse.data!.role;
          final profile = loginResponse.data!.profile;

          // Prepare profile data based on role
          Map<String, dynamic>? profileData;
          String? fullName;
          String? phone;

          if (role.toLowerCase() == 'expert' && profile is ExpertProfile) {
            fullName = profile.fullName;
            phone = profile.phone;
            profileData = {
              'expert_id': profile.expertId,
              'full_name': profile.fullName,
              'specialization': profile.specialization,
              'organization': profile.organization,
              'contact_email': profile.contactEmail,
              'phone': profile.phone,
              'pmdc_number': profile.pmdcNumber,
              'profile_image_public_id': profile.profileImagePublicId,
              'degree_doc_public_id': profile.degreeDocPublicId,
              'certificate_doc_public_id': profile.certificateDocPublicId,
              'approval_status': profile.approvalStatus,
              'approved_by': profile.approvedBy,
              'approved_at': profile.approvedAt,
              'created_at': profile.createdAt,
            };
            
            debugPrint('✅ Expert Profile Data Prepared');
          } else if (role.toLowerCase() == 'parent' && profile is ParentProfile) {
            fullName = profile.fullName;
            phone = profile.phone;
            profileData = {
              'user_id': profile.userId,
              'full_name': profile.fullName,
              'phone': profile.phone,
              'created_at': profile.createdAt,
            };
            
            debugPrint('✅ Parent Profile Data Prepared');
          }

          // ✅ SAVE LOGIN DATA WITH PROFILE
          await SharedPreferencesService.saveUserData(
            userId: user.id,
            email: user.email,
            fullName: fullName,
            phone: phone ?? user.phone,
            role: role,
            accessToken: session.accessToken,
            refreshToken: session.refreshToken,
            expiresAt: session.expiresAt,
            profileData: profileData,
          );

          debugPrint('✅ Login data saved to SharedPreferences');
          debugPrint('✅ Role: $role');
          debugPrint('✅ Full Name: $fullName');
        }

        return loginResponse;
      } else {
        return LoginResponse(
          message: 'Server Error: Status ${response.statusCode}',
          status: false,
        );
      }
    } on DioException catch (e) {
      String errorMessage = 'Network Error: Failed to connect.';
      
      if (e.response != null) {
        debugPrint('Error Response Status: ${e.response!.statusCode}');
        debugPrint('Error Response Data: ${e.response!.data}');
        
        try {
          final errorData = e.response!.data;
          
          if (errorData is Map<String, dynamic>) {
            if (errorData.containsKey('message')) {
              errorMessage = errorData['message'].toString();
            } else if (errorData.containsKey('error')) {
              errorMessage = errorData['error'].toString();
            }
          }
        } catch (_) {
          errorMessage = 'Login Failed: Status ${e.response!.statusCode}';
        }
      } else if (e.type == DioExceptionType.connectionTimeout) {
        errorMessage = 'Connection timeout. Please try again.';
      } else if (e.type == DioExceptionType.receiveTimeout) {
        errorMessage = 'Server is taking too long to respond.';
      } else {
        errorMessage = 'Connection Error: Please check your internet connection.';
      }
      
      debugPrint('Login Error: $errorMessage');
      
      return LoginResponse(
        message: errorMessage,
        status: false,
      );
    } catch (e) {
      debugPrint('Unexpected Login Error: $e');
      return LoginResponse(
        message: 'An unexpected error occurred during login.',
        status: false,
      );
    }
  }
}