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

  // Children CRUD endpoints
  static const String children = '$baseUrl/api/children';
  
  // Helper method to get single child endpoint
  static String getChild(String childId) => '$children/$childId';
  
  // Helper method to update child endpoint
  static String updateChild(String childId) => '$children/$childId';
  
  // Helper method to delete child endpoint
  static String deleteChild(String childId) => '$children/$childId';

  // static const String questionnaire = '/api/questionnaire';
   static const String questionnaire = '$baseUrl/api/questionnaire';
}