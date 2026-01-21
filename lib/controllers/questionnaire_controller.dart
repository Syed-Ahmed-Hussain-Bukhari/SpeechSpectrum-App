// // lib/controllers/questionnaire_controller.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/models/questionnaire_model.dart';
// import 'package:speechspectrum/services/questionnaire_service.dart';

// class QuestionnaireController extends GetxController {
//   final QuestionnaireService _questionnaireService = QuestionnaireService();

//   var isLoading = false.obs;
//   var isSubmitting = false.obs;
//   var isDeleting = false.obs;

//   var submissions = <SubmissionHistoryItem>[].obs;
//   var selectedSubmission = Rxn<SubmissionHistoryItem>();
//   var currentResult = Rxn<QuestionnaireResult>();

//   // Current questionnaire answers
//   var questionnaireAnswers = <String, int>{}.obs;
  
//   // Patient info
//   var selectedChildId = ''.obs;
//   var ageInMonths = 0.obs;
//   var gender = 0.obs; // 1 for male, 0 for female
//   var hasJaundice = 0.obs; // 1 for yes, 0 for no
//   var familyHistoryASD = 0.obs; // 1 for yes, 0 for no

//   @override
//   void onInit() {
//     super.onInit();
//     fetchAllSubmissions();
//   }

//   // Submit Questionnaire
//   Future<void> submitQuestionnaire() async {
//     try {
//       if (selectedChildId.value.isEmpty) {
//         Get.snackbar(
//           'Error',
//           'Please select a child',
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: AppColors.errorColor,
//           colorText: AppColors.whiteColor,
//         );
//         return;
//       }

//       // Validate all 10 questions are answered
//       if (questionnaireAnswers.length < 10) {
//         Get.snackbar(
//           'Error',
//           'Please answer all questions',
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: AppColors.errorColor,
//           colorText: AppColors.whiteColor,
//         );
//         return;
//       }

//       isSubmitting.value = true;

//       // Build responses map
//       final responses = {
//         'A1': questionnaireAnswers['A1'] ?? 0,
//         'A2': questionnaireAnswers['A2'] ?? 0,
//         'A3': questionnaireAnswers['A3'] ?? 0,
//         'A4': questionnaireAnswers['A4'] ?? 0,
//         'A5': questionnaireAnswers['A5'] ?? 0,
//         'A6': questionnaireAnswers['A6'] ?? 0,
//         'A7': questionnaireAnswers['A7'] ?? 0,
//         'A8': questionnaireAnswers['A8'] ?? 0,
//         'A9': questionnaireAnswers['A9'] ?? 0,
//         'A10': questionnaireAnswers['A10'] ?? 0,
//         'Age_Mons': ageInMonths.value,
//         'Sex': gender.value,
//         'Family_mem_with_ASD': familyHistoryASD.value,
//         'Jaundice': hasJaundice.value,
//       };

//       final response = await _questionnaireService.submitQuestionnaire(
//         childId: selectedChildId.value,
//         responses: responses,
//       );

//       if (response.status) {
//         currentResult.value = response.result;
        
//         Get.snackbar(
//           'Success',
//           response.message,
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: AppColors.successColor,
//           colorText: AppColors.whiteColor,
//         );

//         // Navigate to results screen
//         Get.toNamed('/questionnaire-result', arguments: response.result);
        
//         // Refresh submissions list
//         await fetchAllSubmissions();
        
//         // Clear form
//         clearForm();
//       } else {
//         Get.snackbar(
//           'Error',
//           response.message,
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: AppColors.errorColor,
//           colorText: AppColors.whiteColor,
//         );
//       }
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         e.toString(),
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: AppColors.errorColor,
//         colorText: AppColors.whiteColor,
//       );
//     } finally {
//       isSubmitting.value = false;
//     }
//   }

//   // Fetch All Submissions
//   Future<void> fetchAllSubmissions() async {
//     try {
//       isLoading.value = true;
//       final response = await _questionnaireService.getAllSubmissions();

//       if (response.status) {
//         submissions.value = response.data;
//       } else {
//         Get.snackbar(
//           'Error',
//           response.message,
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: AppColors.errorColor,
//           colorText: AppColors.whiteColor,
//         );
//       }
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         e.toString(),
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: AppColors.errorColor,
//         colorText: AppColors.whiteColor,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // Fetch Submissions for Specific Child
//   Future<void> fetchChildSubmissions(String childId) async {
//     try {
//       isLoading.value = true;
//       final response = await _questionnaireService.getChildSubmissions(childId);

//       if (response.status) {
//         submissions.value = response.data;
//       } else {
//         Get.snackbar(
//           'Error',
//           response.message,
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: AppColors.errorColor,
//           colorText: AppColors.whiteColor,
//         );
//       }
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         e.toString(),
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: AppColors.errorColor,
//         colorText: AppColors.whiteColor,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // Fetch Single Submission
//   Future<void> fetchSingleSubmission(String submissionId) async {
//     try {
//       isLoading.value = true;
//       final response =
//           await _questionnaireService.getSingleSubmission(submissionId);

//       if (response.status && response.data != null) {
//         selectedSubmission.value = response.data;
//       } else {
//         Get.snackbar(
//           'Error',
//           response.message,
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: AppColors.errorColor,
//           colorText: AppColors.whiteColor,
//         );
//       }
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         e.toString(),
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: AppColors.errorColor,
//         colorText: AppColors.whiteColor,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // Delete Submission
//   Future<void> deleteSubmission(String submissionId) async {
//     try {
//       isDeleting.value = true;

//       final response =
//           await _questionnaireService.deleteSubmission(submissionId);

//       if (response.status) {
//         Get.back(); // Close dialog
//         Get.snackbar(
//           'Success',
//           response.message,
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: AppColors.successColor,
//           colorText: AppColors.whiteColor,
//         );
//         await fetchAllSubmissions();
//       } else {
//         Get.snackbar(
//           'Error',
//           response.message,
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: AppColors.errorColor,
//           colorText: AppColors.whiteColor,
//         );
//       }
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         e.toString(),
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: AppColors.errorColor,
//         colorText: AppColors.whiteColor,
//       );
//     } finally {
//       isDeleting.value = false;
//     }
//   }

//   // Set questionnaire answer
//   void setAnswer(String questionKey, int value) {
//     questionnaireAnswers[questionKey] = value;
//   }

//   // Clear form
//   void clearForm() {
//     questionnaireAnswers.clear();
//     selectedChildId.value = '';
//     ageInMonths.value = 0;
//     gender.value = 0;
//     hasJaundice.value = 0;
//     familyHistoryASD.value = 0;
//   }
// }


// // lib/controllers/questionnaire_controller.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/models/questionnaire_model.dart';
// import 'package:speechspectrum/services/questionnaire_service.dart';
// import 'package:speechspectrum/routes/app_routes.dart';

// class QuestionnaireController extends GetxController {
//   final QuestionnaireService _questionnaireService = QuestionnaireService();

//   var isSubmitting = false.obs;
//   var currentQuestion = 0.obs;
//   var answers = <int, int>{}.obs;
//   var selectedChildId = ''.obs;
//   var ageMonths = 0.obs;
//   var selectedGender = 1.obs; // 1 = male, 0 = female
//   var hasJaundice = 0.obs; // 0 = no, 1 = yes
//   var hasFamilyASD = 0.obs; // 0 = no, 1 = yes

//   Rxn<QuestionnaireResultModel> resultModel = Rxn<QuestionnaireResultModel>();

//   final List<Map<String, dynamic>> questions = [
//     {
//       'question': 'Does your child look at you when you call his/her name?',
//       'key': 'A1',
//       'options': ['Always', 'Usually', 'Sometimes', 'Rarely', 'Never'],
//     },
//     {
//       'question': 'How easy is it for you to get eye contact with your child?',
//       'key': 'A2',
//       'options': ['Very easy', 'Quite easy', 'Quite difficult', 'Very difficult', 'Impossible'],
//     },
//     {
//       'question': 'Does your child point to indicate that s/he wants something? (e.g. a toy that is out of reach)',
//       'key': 'A3',
//       'options': ['Many times a day', 'A few times a day', 'A few times a week', 'Less than once a week', 'Never'],
//     },
//     {
//       'question': 'Does your child point to share interest with you? (e.g. pointing at an interesting sight)',
//       'key': 'A4',
//       'options': ['Many times a day', 'A few times a day', 'A few times a week', 'Less than once a week', 'Never'],
//     },
//     {
//       'question': 'Does your child pretend? (e.g. care for dolls, talk on a toy phone)',
//       'key': 'A5',
//       'options': ['Many times a day', 'A few times a day', 'A few times a week', 'Less than once a week', 'Never'],
//     },
//     {
//       'question': 'Does your child follow where you\'re looking?',
//       'key': 'A6',
//       'options': ['Many times a day', 'A few times a day', 'A few times a week', 'Less than once a week', 'Never'],
//     },
//     {
//       'question': 'If you or someone else in the family is visibly upset, does your child show signs of wanting to comfort them? (e.g. stroking hair, hugging them)',
//       'key': 'A7',
//       'options': ['Always', 'Usually', 'Sometimes', 'Rarely', 'Never'],
//     },
//     {
//       'question': 'Would you describe your child\'s first words as:',
//       'key': 'A8',
//       'options': ['Very typical', 'Quite typical', 'Slightly unusual', 'Very unusual', 'My child doesn\'t speak'],
//     },
//     {
//       'question': 'Does your child use simple gestures? (e.g. wave goodbye)',
//       'key': 'A9',
//       'options': ['Many times a day', 'A few times a day', 'A few times a week', 'Less than once a week', 'Never'],
//     },
//     {
//       'question': 'Does your child stare at nothing with no apparent purpose?',
//       'key': 'A10',
//       'options': ['Never', 'Less than once a week', 'A few times a week', 'A few times a day', 'Many times a day'],
//     },
//   ];

//   // Convert option to score (0 or 1)
//   int getScoreForOption(int questionIndex, int optionIndex) {
//     // For most questions: Always/Usually/Many times = 1, Sometimes/Rarely/Never = 0
//     // For question A10 (stare at nothing): inverted scoring
//     if (questionIndex == 9) {
//       // A10 - reversed
//       return optionIndex >= 3 ? 1 : 0;
//     }
//     // For other questions
//     return optionIndex <= 1 ? 1 : 0;
//   }

//   void nextQuestion() {
//     if (currentQuestion.value < questions.length - 1) {
//       currentQuestion.value++;
//     }
//   }

//   void previousQuestion() {
//     if (currentQuestion.value > 0) {
//       currentQuestion.value--;
//     }
//   }

//   void selectAnswer(int optionIndex) {
//     final score = getScoreForOption(currentQuestion.value, optionIndex);
//     answers[currentQuestion.value] = score;
//   }

//   bool get canProceed => answers.containsKey(currentQuestion.value);

//   bool get isLastQuestion => currentQuestion.value == questions.length - 1;

//   double get progress => (currentQuestion.value + 1) / questions.length;

//   void resetQuestionnaire() {
//     currentQuestion.value = 0;
//     answers.clear();
//     selectedChildId.value = '';
//     ageMonths.value = 0;
//     selectedGender.value = 1;
//     hasJaundice.value = 0;
//     hasFamilyASD.value = 0;
//     resultModel.value = null;
//   }

//   Future<void> submitQuestionnaire() async {
//     if (selectedChildId.value.isEmpty) {
//       Get.snackbar(
//         'Error',
//         'Please select a child',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: AppColors.errorColor,
//         colorText: AppColors.whiteColor,
//       );
//       return;
//     }

//     if (answers.length < questions.length) {
//       Get.snackbar(
//         'Error',
//         'Please answer all questions',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: AppColors.errorColor,
//         colorText: AppColors.whiteColor,
//       );
//       return;
//     }

//     try {
//       isSubmitting.value = true;

//       // Build responses map
//       final Map<String, int> responses = {};
//       for (int i = 0; i < questions.length; i++) {
//         final key = questions[i]['key'];
//         responses[key] = answers[i] ?? 0;
//       }

//       final result = await _questionnaireService.submitQuestionnaire(
//         childId: selectedChildId.value,
//         responses: responses,
//         ageMonths: ageMonths.value,
//         sex: selectedGender.value,
//         familyMemWithASD: hasFamilyASD.value,
//         jaundice: hasJaundice.value,
//       );

//       resultModel.value = result;

//       Get.snackbar(
//         'Success',
//         'Questionnaire submitted successfully!',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: AppColors.successColor,
//         colorText: AppColors.whiteColor,
//       );

//       // Navigate to results screen
//       Get.offAllNamed(AppRoutes.questionnaireResults);
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         e.toString().replaceAll('Exception: ', ''),
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: AppColors.errorColor,
//         colorText: AppColors.whiteColor,
//         duration: const Duration(seconds: 4),
//       );
//     } finally {
//       isSubmitting.value = false;
//     }
//   }
// }

// lib/controllers/questionnaire_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/models/questionnaire_model.dart';
import 'package:speechspectrum/services/questionnaire_service.dart';
import 'package:speechspectrum/routes/app_routes.dart';

class QuestionnaireController extends GetxController {
  final QuestionnaireService _questionnaireService = QuestionnaireService();

  var isSubmitting = false.obs;
  var currentQuestion = 0.obs;
  var answers = <int, int>{}.obs; // stores the selected option index
  var selectedChildId = ''.obs;
  var ageMonths = 0.obs;
  var selectedGender = 1.obs; // 1 = male, 0 = female
  var hasJaundice = 0.obs; // 0 = no, 1 = yes
  var hasFamilyASD = 0.obs; // 0 = no, 1 = yes

  Rxn<QuestionnaireResultModel> resultModel = Rxn<QuestionnaireResultModel>();

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'Does your child look at you when you call his/her name?',
      'key': 'A1',
      'options': ['Always', 'Usually', 'Sometimes', 'Rarely', 'Never'],
    },
    {
      'question': 'How easy is it for you to get eye contact with your child?',
      'key': 'A2',
      'options': ['Very easy', 'Quite easy', 'Quite difficult', 'Very difficult', 'Impossible'],
    },
    {
      'question': 'Does your child point to indicate that s/he wants something? (e.g. a toy that is out of reach)',
      'key': 'A3',
      'options': ['Many times a day', 'A few times a day', 'A few times a week', 'Less than once a week', 'Never'],
    },
    {
      'question': 'Does your child point to share interest with you? (e.g. pointing at an interesting sight)',
      'key': 'A4',
      'options': ['Many times a day', 'A few times a day', 'A few times a week', 'Less than once a week', 'Never'],
    },
    {
      'question': 'Does your child pretend? (e.g. care for dolls, talk on a toy phone)',
      'key': 'A5',
      'options': ['Many times a day', 'A few times a day', 'A few times a week', 'Less than once a week', 'Never'],
    },
    {
      'question': 'Does your child follow where you\'re looking?',
      'key': 'A6',
      'options': ['Many times a day', 'A few times a day', 'A few times a week', 'Less than once a week', 'Never'],
    },
    {
      'question': 'If you or someone else in the family is visibly upset, does your child show signs of wanting to comfort them? (e.g. stroking hair, hugging them)',
      'key': 'A7',
      'options': ['Always', 'Usually', 'Sometimes', 'Rarely', 'Never'],
    },
    {
      'question': 'Would you describe your child\'s first words as:',
      'key': 'A8',
      'options': ['Very typical', 'Quite typical', 'Slightly unusual', 'Very unusual', 'My child doesn\'t speak'],
    },
    {
      'question': 'Does your child use simple gestures? (e.g. wave goodbye)',
      'key': 'A9',
      'options': ['Many times a day', 'A few times a day', 'A few times a week', 'Less than once a week', 'Never'],
    },
    {
      'question': 'Does your child stare at nothing with no apparent purpose?',
      'key': 'A10',
      'options': ['Never', 'Less than once a week', 'A few times a week', 'A few times a day', 'Many times a day'],
    },
  ];

  // Convert option to score (0 or 1)
  int getScoreForOption(int questionIndex, int optionIndex) {
    // For most questions: Always/Usually/Many times = 1, Sometimes/Rarely/Never = 0
    // For question A10 (stare at nothing): inverted scoring
    if (questionIndex == 9) {
      // A10 - reversed
      return optionIndex >= 3 ? 1 : 0;
    }
    // For other questions
    return optionIndex <= 1 ? 1 : 0;
  }

  void nextQuestion() {
    if (currentQuestion.value < questions.length - 1) {
      currentQuestion.value++;
    }
  }

  void previousQuestion() {
    if (currentQuestion.value > 0) {
      currentQuestion.value--;
    }
  }

  void selectAnswer(int optionIndex) {
    // Store the option index that was selected
    answers[currentQuestion.value] = optionIndex;
  }

  bool get canProceed => answers.containsKey(currentQuestion.value);

  bool get isLastQuestion => currentQuestion.value == questions.length - 1;

  double get progress => (currentQuestion.value + 1) / questions.length;

  void resetQuestionnaire() {
    currentQuestion.value = 0;
    answers.clear();
    selectedChildId.value = '';
    ageMonths.value = 0;
    selectedGender.value = 1;
    hasJaundice.value = 0;
    hasFamilyASD.value = 0;
    resultModel.value = null;
  }

  Future<void> submitQuestionnaire() async {
    if (selectedChildId.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Please select a child',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.errorColor,
        colorText: AppColors.whiteColor,
      );
      return;
    }

    if (answers.length < questions.length) {
      Get.snackbar(
        'Error',
        'Please answer all questions',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.errorColor,
        colorText: AppColors.whiteColor,
      );
      return;
    }

    try {
      isSubmitting.value = true;

      // Build responses map
      final Map<String, int> responses = {};
      for (int i = 0; i < questions.length; i++) {
        final key = questions[i]['key'];
        final optionIndex = answers[i] ?? 0;
        // Convert option index to score (0 or 1)
        final score = getScoreForOption(i, optionIndex);
        responses[key] = score;
      }

      final result = await _questionnaireService.submitQuestionnaire(
        childId: selectedChildId.value,
        responses: responses,
        ageMonths: ageMonths.value,
        sex: selectedGender.value,
        familyMemWithASD: hasFamilyASD.value,
        jaundice: hasJaundice.value,
      );

      resultModel.value = result;

      Get.snackbar(
        'Success',
        'Questionnaire submitted successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.successColor,
        colorText: AppColors.whiteColor,
      );

      // Navigate to results screen
      Get.offAllNamed(AppRoutes.questionnaireResults);
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString().replaceAll('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.errorColor,
        colorText: AppColors.whiteColor,
        duration: const Duration(seconds: 4),
      );
    } finally {
      isSubmitting.value = false;
    }
  }
}