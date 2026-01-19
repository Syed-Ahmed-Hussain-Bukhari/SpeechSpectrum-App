// lib/app/routes/app_urls.dart
class APIEndPoints {
  static const String baseUrl = 'https://speech-spectrum-fyp-backend.vercel.app';
 // Auth endpoints
  static const String login = '$baseUrl/api/user/login';
  static const String signup = '$baseUrl/api/user/signup';
  static const String logout = '$baseUrl/api/user/logout';
  
  // Profile endpoints
  static const String profile = '$baseUrl/api/user/profile';
  static const String updateProfile = '$baseUrl/api/user/profile';
  static const String deleteProfile = '$baseUrl/api/user/profile';
}