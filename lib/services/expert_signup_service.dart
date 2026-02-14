// // lib/app/services/expert_signup_service.dart
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:speechspectrum/routes/app_urls.dart';
// import '../models/expert_signup_response.dart';

// class ExpertSignupService {
//   final Dio dio = Dio();

//   Future<ExpertSignupResponse> signup({
//     required String email,
//     required String password,
//     required String fullName,
//     required String phone,
//     required String specialization,
//     required String organization,
//     required String contactEmail,
//     required String pmdcNumber,
//     required String profileImagePublicId,
//     required String degreeDocPublicId,
//     required String certificateDocPublicId,
//   }) async {
//     final apiEndPoint = APIEndPoints.signup;

//     try {
//       final response = await dio.post(
//         apiEndPoint,
//         data: {
//           'email': email,
//           'password': password,
//           'full_name': fullName,
//           'phone': phone,
//           'specialization': specialization,
//           'organization': organization,
//           'contact_email': contactEmail,
//           'pmdc_number': pmdcNumber,
//           'profile_image_public_id': profileImagePublicId,
//           'degree_doc_public_id': degreeDocPublicId,
//           'certificate_doc_public_id': certificateDocPublicId,
//           'role': 'expert',
//         },
//         options: Options(
//           headers: {'Content-Type': 'application/json'},
//         ),
//       );

//       debugPrint('Expert Signup API Response Status: ${response.statusCode}');
//       debugPrint('Expert Signup API Response Data: ${response.data}');

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final signupResponse = ExpertSignupResponse.fromJson(
//           response.data as Map<String, dynamic>,
//         );

//         return signupResponse;
//       } else {
//         return ExpertSignupResponse(
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
//               errorMessage = 'Signup Failed: Status ${e.response!.statusCode}';
//             }
//           } else {
//             errorMessage = 'Signup Failed: Status ${e.response!.statusCode}';
//           }
//         } catch (_) {
//           errorMessage = 'Signup Failed: Status ${e.response!.statusCode}';
//         }
//       } else if (e.type == DioExceptionType.connectionTimeout) {
//         errorMessage = 'Connection timeout. Please try again.';
//       } else if (e.type == DioExceptionType.receiveTimeout) {
//         errorMessage = 'Server is taking too long to respond.';
//       } else {
//         errorMessage = 'Connection Error: Please check your internet connection.';
//       }
      
//       debugPrint('Dio Error: $errorMessage');
//       return ExpertSignupResponse(
//         status: false,
//         message: errorMessage,
//       );
//     } catch (e) {
//       debugPrint('An unexpected error occurred: $e');
//       return ExpertSignupResponse(
//         status: false,
//         message: 'An unexpected error occurred during signup.',
//       );
//     }
//   }
// }

// lib/app/services/expert_signup_service.dart
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:speechspectrum/routes/app_urls.dart';
import 'package:speechspectrum/services/shared_preferences_service.dart';
import '../models/expert_signup_response.dart';

class ExpertSignupService {
  final Dio dio = Dio();

  Future<ExpertSignupResponse> signup({
    required String email,
    required String password,
    required String fullName,
    required String phone,
    required String specialization,
    required String organization,
    required String contactEmail,
    required String pmdcNumber,
    required String profileImagePublicId,
    required String degreeDocPublicId,
    required String certificateDocPublicId,
  }) async {
    final apiEndPoint = APIEndPoints.signup;

    try {
      debugPrint('Expert Signup Request - Email: $email');
      
      final response = await dio.post(
        apiEndPoint,
        data: {
          'email': email,
          'password': password,
          'full_name': fullName,
          'phone': phone,
          'specialization': specialization,
          'organization': organization,
          'contact_email': contactEmail,
          'pmdc_number': pmdcNumber,
          'profile_image_public_id': profileImagePublicId,
          'degree_doc_public_id': degreeDocPublicId,
          'certificate_doc_public_id': certificateDocPublicId,
          'role': 'expert',
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      debugPrint('Expert Signup API Response Status: ${response.statusCode}');
      debugPrint('Expert Signup API Response Data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final signupResponse = ExpertSignupResponse.fromJson(
          response.data as Map<String, dynamic>,
        );

        // Save expert signup data to shared preferences if successful
        // Note: Experts don't get session tokens until approved
        if (signupResponse.status && signupResponse.data != null) {
          final user = signupResponse.data!.user;
          final userRole = signupResponse.data!.role;
          final profile = signupResponse.data!.profile;

          // Prepare expert profile data
          Map<String, dynamic> profileData = {
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

          // ✅ SAVE EXPERT SIGNUP DATA WITH PROFILE
          // Note: No access token until admin approves
          await SharedPreferencesService.saveUserData(
            userId: user.id,
            email: user.email,
            fullName: profile.fullName,
            phone: profile.phone,
            role: userRole,
            accessToken: '', // Empty until approved
            refreshToken: '', // Empty until approved
            expiresAt: 0, // 0 until approved
            profileData: profileData,
          );

          debugPrint('✅ Expert signup data saved to SharedPreferences');
          debugPrint('✅ Role: $userRole');
          debugPrint('✅ Full Name: ${profile.fullName}');
          debugPrint('✅ Approval Status: ${profile.approvalStatus}');
        }

        return signupResponse;
      } else {
        return ExpertSignupResponse(
          status: false,
          message: 'Server Error: Status ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      String errorMessage = 'Network Error: Failed to connect.';
      
      if (e.response != null) {
        debugPrint('Error Response Data: ${e.response!.data}');
        
        try {
          final errorData = e.response!.data;
          
          if (errorData is Map<String, dynamic>) {
            if (errorData.containsKey('message')) {
              errorMessage = errorData['message'].toString();
            } else if (errorData.containsKey('error')) {
              errorMessage = errorData['error'].toString();
            } else if (errorData.containsKey('Message')) {
              errorMessage = errorData['Message'].toString();
            } else {
              errorMessage = 'Signup Failed: Status ${e.response!.statusCode}';
            }
          } else {
            errorMessage = 'Signup Failed: Status ${e.response!.statusCode}';
          }
        } catch (_) {
          errorMessage = 'Signup Failed: Status ${e.response!.statusCode}';
        }
      } else if (e.type == DioExceptionType.connectionTimeout) {
        errorMessage = 'Connection timeout. Please try again.';
      } else if (e.type == DioExceptionType.receiveTimeout) {
        errorMessage = 'Server is taking too long to respond.';
      } else {
        errorMessage = 'Connection Error: Please check your internet connection.';
      }
      
      debugPrint('Dio Error: $errorMessage');
      return ExpertSignupResponse(
        status: false,
        message: errorMessage,
      );
    } catch (e) {
      debugPrint('An unexpected error occurred: $e');
      return ExpertSignupResponse(
        status: false,
        message: 'An unexpected error occurred during signup.',
      );
    }
  }
}