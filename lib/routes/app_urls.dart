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

  // Storage endpoints
  static const String uploadImage = '$baseUrl/api/storage/images';
  static const String uploadDocument = '$baseUrl/api/storage/documents';
  
  // Expert endpoints
  static const String experts = '$baseUrl/api/experts';
  static const String consultations = '$baseUrl/api/consultations/request';
  static const String parentConsultations = '$baseUrl/api/consultations/parent';
  static const String parentLinks = '$baseUrl/api/links/parent';
  
  // Expert-specific endpoints
  static const String expertConsultations ='$baseUrl/api/consultations/expert';
  static const String respondConsultation = '$baseUrl/api/consultations/respond';
  static const String createLink = '$baseUrl/api/links/create';
  static const String expertLinks = '$baseUrl/api/links/expert';

  // Appointment endpoints
  static const String generateZoomLink = '$baseUrl/api/appointments/generate-zoom-link';
  static const String createAppointment = '$baseUrl/api/appointments/create';
  static const String expertAppointments = '$baseUrl/api/appointments/expert';
  static const String appointmentNotes = '$baseUrl/api/appointments';  // Base for notes/feedback/details
 
  static const String parentAppointments = '$baseUrl/api/appointments/parent';  // Base for notes/feedback/details

  // ✅ NEW: Chat endpoints
  static const String chatBase = '$baseUrl/api/chat';
  static const String createChat = '$baseUrl/api/chat/create';
  static const String expertChats = '$baseUrl/api/chat/expert';
  static const String parentChats = '$baseUrl/api/chat/parent';
  

  // Note: For specific appointment operations, append the appointment_id:
// - Save notes: '$baseUrl/api/appointments/{appointment_id}/notes'
// - Save feedback: '$baseUrl/api/appointments/{appointment_id}/feedback'  
// - Get details: '$baseUrl/api/appointments/{appointment_id}/details'
}