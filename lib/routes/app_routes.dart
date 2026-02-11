import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speechspectrum/view/AWARENESS/AWARENESS_screen.dart';
import 'package:speechspectrum/view/auth/expert_documents_screen.dart';
import 'package:speechspectrum/view/auth/expert_info_screen.dart';
import 'package:speechspectrum/view/auth/name_screen.dart';
import 'package:speechspectrum/view/auth/phone_screen.dart';
import 'package:speechspectrum/view/auth/role_selection_screen.dart';
import 'package:speechspectrum/view/children/child_details_screen.dart';
import 'package:speechspectrum/view/children/children_list_screen.dart';
import 'package:speechspectrum/view/children/create_edit_child_screen.dart';
import 'package:speechspectrum/view/history/child_history_screen.dart';
import 'package:speechspectrum/view/history/history_screen.dart';
import 'package:speechspectrum/view/history/submission_details_screen.dart';
import 'package:speechspectrum/view/home/QUESTIONNAIRE_screen.dart';
import 'package:speechspectrum/view/home/home_screen.dart';
import 'package:speechspectrum/view/home/voice_upload_screen.dart';
import 'package:speechspectrum/view/learnScreen/learnScreen.dart';
import 'package:speechspectrum/view/notification/notification.dart';
import 'package:speechspectrum/view/profile_screen.dart/edit_profile.dart';
import 'package:speechspectrum/view/profile_screen.dart/profile.dart';
import 'package:speechspectrum/view/questionnaire/patient_info_screen.dart';
import 'package:speechspectrum/view/questionnaire/questionnaire_history_screen.dart';
import 'package:speechspectrum/view/questionnaire/questionnaire_result_screen.dart';
import 'package:speechspectrum/view/questionnaire/questionnaire_screen.dart';
import 'package:speechspectrum/view/result/result_screen.dart';
import 'package:speechspectrum/view/setting/about_screen.dart';
import 'package:speechspectrum/view/setting/help_and_support.dart';
import 'package:speechspectrum/view/setting/privacy_and_policy_screen.dart';
import 'package:speechspectrum/view/setting/settings.dart';
import 'package:speechspectrum/view/setting/terms_and_conditions_screen.dart';
import '../view/splash_screen.dart';
import '../view/onboarding_screen.dart';
import '../view/auth/login_screen.dart';
import '../view/auth/signup_screen.dart';
import '../view/auth/reset_password_screen.dart';
import '../view/auth/set_password_screen.dart';

class AppRoutes {
  static String splashScreen = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String resetPassword = '/reset-password';
  static const String setPassword = '/set-password';
  static const String home = '/home';
  static const String questionnaire = '/questionnaire';
  static const String voiceUpload = '/voice-upload';
  static const String results = '/results';
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  static const String settings = '/settings';
  static const String termsAndConditions = '/terms';
  static const String privacyPolicy = '/privacy';
  static const String about = '/about';
  static const String awareness = '/awareness';
  static const String notification = '/notification';
  static const String help = '/help';
  static const String learn = '/learn';

  static const String roleSelection = '/role-selection';
  static const String nameScreen = '/name-screen';
  static const String phoneScreen = '/phone-screen';
  // static const String emailPasswordScreen = '/email-password-screen';
  static const String childrenList = '/children-list';
  static const String createChild = '/create-child';
  static const String editChild = '/edit-child';
  static const String childDetails = '/child-details';
  
  static const String questionnaireResults = '/questionnaireResults';
  // static const String questionnaireHistory = '/questionnaireHistory';
  static const String patientInfo = '/patientInfo';

  // History routes
  static const String history = '/history';
  static const String childHistory = '/child-history';
  static const String submissionDetails = '/submission-details';

   // Expert-specific routes
  static const String expertInfo = '/expert-info';
  static const String expertDocuments = '/expert-documents';
  
  // Main app routes
  // static const String pendingApproval = '/pending-approval';
 
  



  static final List<GetPage> routes = [
    GetPage<Route<dynamic>>(
      name: splashScreen,
      page: () => SplashScreen(),
    ),

    GetPage<Route<dynamic>>(
      name: home,
      page: () => HomeScreen(),
    ),

    GetPage<Route<dynamic>>(
      name:questionnaire,
      page: () => QuestionnaireScreen(),
    ),

    GetPage<Route<dynamic>>(
      name: onboarding,
      page: () => OnboardingScreen(),
    ),
    GetPage<Route<dynamic>>(
      name: login,
      page: () => LoginScreen(),
    ),
    //
    GetPage<Route<dynamic>>(
      name: roleSelection,
      page: () => RoleSelectionScreen(),
    ),
     GetPage<Route<dynamic>>(
      name: nameScreen,
      page: () => NameScreen(),
    ),
     GetPage<Route<dynamic>>(
      name: phoneScreen,
      page: () => PhoneScreen(),
    ),
     GetPage<Route<dynamic>>(
      name: signup,
      page: () => EmailPasswordScreen(),
    ),

    GetPage<Route<dynamic>>(
      name: resetPassword,
      page: () => ResetPasswordScreen(),
    ),
    GetPage<Route<dynamic>>(
      name: setPassword,
      page: () => SetPasswordScreen(),
    ),

      GetPage<Route<dynamic>>(
      name: voiceUpload,
      page: () => VoiceUploadScreen(),
    ),

    
      GetPage<Route<dynamic>>(
      name: results,
      page: () => ResultsScreen(),
    ),

     GetPage<Route<dynamic>>(
      name: profile,
      page: () => ProfileScreen(),
    ),

     GetPage<Route<dynamic>>(
      name: editProfile,
      page: () => EditProfileScreen(),
    ),

     GetPage<Route<dynamic>>(
      name: settings,
      page: () => SettingsScreen(),
    ),

     GetPage<Route<dynamic>>(
      name: termsAndConditions,
      page: () => TermsAndConditionsScreen(),
    ),

    GetPage<Route<dynamic>>(
      name: termsAndConditions,
      page: () => TermsAndConditionsScreen(),
    ),

      GetPage<Route<dynamic>>(
      name: privacyPolicy,
      page: () => PrivacyPolicyScreen(),
    ),

    GetPage<Route<dynamic>>(
      name: about,
      page: () => AboutScreen(),
    ),

     GetPage<Route<dynamic>>(
      name: awareness,
      page: () => AwarenessScreen(),
    ),

    GetPage<Route<dynamic>>(
      name: notification,
      page: () => NotificationsScreen(),
    ),

    GetPage<Route<dynamic>>(
      name: help,
      page: () => HelpScreen(),
    ),

    GetPage<Route<dynamic>>(
      name: learn,
      page: () => LearnScreen(),
    ),

     GetPage(
      name: AppRoutes.childrenList,
      page: () => const ChildrenListScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.createChild,
      page: () => const CreateEditChildScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.editChild,
      page: () => const CreateEditChildScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.childDetails,
      page: () => const ChildDetailsScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
  name: AppRoutes.patientInfo,
  page: () => const PatientInfoScreen(),
),
GetPage(
  name: AppRoutes.questionnaire,
  page: () => const QuestionnaireScreen(),
),
GetPage(
  name: AppRoutes.questionnaireResults,
  page: () => const QuestionnaireResultsScreen(),
),
// GetPage(
//   name: AppRoutes.questionnaireHistory,
//   page: () => const QuestionnaireHistoryScreen(),
// ),

GetPage(name: AppRoutes.history, page: () => const HistoryScreen()),
GetPage(name: AppRoutes.childHistory, page: () => const ChildHistoryScreen()),
GetPage(name: AppRoutes.submissionDetails, page: () => const SubmissionDetailsScreen()),

GetPage(name: AppRoutes.expertInfo, page: () =>  ExpertInfoScreen()),
GetPage(name: AppRoutes.expertDocuments, page: () =>  ExpertDocumentsScreen()),
  ];
}