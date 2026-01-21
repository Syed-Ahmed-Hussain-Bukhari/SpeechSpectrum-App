// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../../routes/app_routes.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';

// class QuestionnaireScreen extends StatefulWidget {
//   const QuestionnaireScreen({super.key});

//   @override
//   State<QuestionnaireScreen> createState() => _QuestionnaireScreenState();
// }

// class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
//   int currentQuestion = 0;
//   Map<int, String> answers = {};
  
//   final List<Map<String, dynamic>> questions = [
//     {
//       'question': 'Does your child look at you when you call his/her name?',
//       'options': ['Always', 'Usually', 'Sometimes', 'Rarely', 'Never'],
//     },
//     {
//       'question': 'How easy is it for you to get eye contact with your child?',
//       'options': ['Very easy', 'Quite easy', 'Quite difficult', 'Very difficult', 'Impossible'],
//     },
//     {
//       'question': 'Does your child point to indicate that s/he wants something? (e.g. a toy that is out of reach)',
//       'options': ['Many times a day', 'A few times a day', 'A few times a week', 'Less than once a week', 'Never'],
//     },
//     {
//       'question': 'Does your child point to share interest with you? (e.g. pointing at an interesting sight)',
//       'options': ['Many times a day', 'A few times a day', 'A few times a week', 'Less than once a week', 'Never'],
//     },
//     {
//       'question': 'Does your child pretend? (e.g. care for dolls, talk on a toy phone)',
//       'options': ['Many times a day', 'A few times a day', 'A few times a week', 'Less than once a week', 'Never'],
//     },
//     {
//       'question': 'Does your child follow where you\'re looking?',
//       'options': ['Many times a day', 'A few times a day', 'A few times a week', 'Less than once a week', 'Never'],
//     },
//     {
//       'question': 'If you or someone else in the family is visibly upset, does your child show signs of wanting to comfort them? (e.g. stroking hair, hugging them)',
//       'options': ['Always', 'Usually', 'Sometimes', 'Rarely', 'Never'],
//     },
//     {
//       'question': 'Would you describe your child\'s first words as:',
//       'options': ['Very typical', 'Quite typical', 'Slightly unusual', 'Very unusual', 'My child doesn\'t speak'],
//     },
//     {
//       'question': 'Does your child use simple gestures? (e.g. wave goodbye)',
//       'options': ['Many times a day', 'A few times a day', 'A few times a week', 'Less than once a week', 'Never'],
//     },
//     {
//       'question': 'Does your child stare at nothing with no apparent purpose?',
//       'options': ['Never', 'Less than once a week', 'A few times a week', 'A few times a day', 'Many times a day'],
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();
//     final progress = (currentQuestion + 1) / questions.length;
    
//     return Scaffold(
//       backgroundColor: AppColors.lightGreyColor,
//       appBar: AppBar(
//         backgroundColor: AppColors.whiteColor,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: AppColors.textPrimaryColor),
//           onPressed: () => Get.back(),
//         ),
//         title: Row(
//           children: [
//             Icon(Icons.psychology, color: AppColors.primaryColor, size: 28),
//             SizedBox(width: 8),
//             Text(
//               'Structured Questionnaire',
//               style: GoogleFonts.poppins(
//                 color: AppColors.textPrimaryColor,
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Progress Bar
//             Container(
//               color: AppColors.whiteColor,
//               padding: EdgeInsets.all(size.customWidth(context) * 0.05),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Step ${currentQuestion + 1} of ${questions.length}',
//                         style: GoogleFonts.poppins(
//                           fontSize: 14,
//                           color: AppColors.textSecondaryColor,
//                         ),
//                       ),
//                       Text(
//                         '${(progress * 100).toInt()}%',
//                         style: GoogleFonts.poppins(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                           color: AppColors.primaryColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 8),
//                   LinearProgressIndicator(
//                     value: progress,
//                     backgroundColor: AppColors.lightGreyColor,
//                     valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
//                     minHeight: 8,
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                 ],
//               ),
//             ),
            
//             // Question Content
//             Expanded(
//               child: SingleChildScrollView(
//                 padding: EdgeInsets.all(size.customWidth(context) * 0.05),
//                 child: Container(
//                   padding: EdgeInsets.all(size.customWidth(context) * 0.05),
//                   decoration: BoxDecoration(
//                     color: AppColors.whiteColor,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         questions[currentQuestion]['question'],
//                         style: GoogleFonts.poppins(
//                           fontSize: size.customWidth(context) * 0.048,
//                           fontWeight: FontWeight.w600,
//                           color: AppColors.textPrimaryColor,
//                           height: 1.5,
//                         ),
//                       ),
//                       SizedBox(height: size.customHeight(context) * 0.03),
//                       ...List.generate(
//                         questions[currentQuestion]['options'].length,
//                         (index) => _buildOptionButton(
//                           context: context,
//                           option: questions[currentQuestion]['options'][index],
//                           isSelected: answers[currentQuestion] == questions[currentQuestion]['options'][index],
//                           onTap: () {
//                             setState(() {
//                               answers[currentQuestion] = questions[currentQuestion]['options'][index];
//                             });
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
            
//             // Navigation Buttons
//             Container(
//               color: AppColors.whiteColor,
//               padding: EdgeInsets.all(size.customWidth(context) * 0.05),
//               child: Row(
//                 children: [
//                   if (currentQuestion > 0)
//                     Expanded(
//                       child: OutlinedButton(
//                         onPressed: () {
//                           setState(() => currentQuestion--);
//                         },
//                         style: OutlinedButton.styleFrom(
//                           padding: EdgeInsets.symmetric(vertical: 15),
//                           side: BorderSide(color: AppColors.primaryColor),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(Icons.arrow_back, color: AppColors.primaryColor),
//                             SizedBox(width: 8),
//                             Text(
//                               'Back',
//                               style: GoogleFonts.poppins(
//                                 color: AppColors.primaryColor,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   if (currentQuestion > 0) SizedBox(width: 16),
//                   Expanded(
//                     flex: currentQuestion == 0 ? 1 : 1,
//                     child: ElevatedButton(
//                       onPressed: answers.containsKey(currentQuestion)
//                           ? () {
//                               if (currentQuestion < questions.length - 1) {
//                                 setState(() => currentQuestion++);
//                               } else {
//                                 _showReviewDialog(context);
//                               }
//                             }
//                           : null,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.primaryColor,
//                         padding: EdgeInsets.symmetric(vertical: 15),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         disabledBackgroundColor: AppColors.greyColor,
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             currentQuestion < questions.length - 1 ? 'Next' : 'Submit',
//                             style: GoogleFonts.poppins(
//                               color: AppColors.whiteColor,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           SizedBox(width: 8),
//                           Icon(Icons.arrow_forward, color: AppColors.whiteColor),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildOptionButton({
//     required BuildContext context,
//     required String option,
//     required bool isSelected,
//     required VoidCallback onTap,
//   }) {
//     final size = CustomSize();
    
//     return Container(
//       margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.015),
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(12),
//         child: Container(
//           padding: EdgeInsets.symmetric(
//             horizontal: size.customWidth(context) * 0.04,
//             vertical: size.customHeight(context) * 0.02,
//           ),
//           decoration: BoxDecoration(
//             color: isSelected ? AppColors.primaryColor : AppColors.lightGreyColor,
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(
//               color: isSelected ? AppColors.primaryColor : Colors.transparent,
//               width: 2,
//             ),
//           ),
//           child: Row(
//             children: [
//               Icon(
//                 isSelected ? Icons.check_circle : Icons.circle_outlined,
//                 color: isSelected ? AppColors.whiteColor : AppColors.greyColor,
//               ),
//               SizedBox(width: 12),
//               Expanded(
//                 child: Text(
//                   option,
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.04,
//                     color: isSelected ? AppColors.whiteColor : AppColors.textPrimaryColor,
//                     fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _showReviewDialog(BuildContext context) {
//     Get.dialog(
//       AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         title: Text(
//           'Review Your Answers',
//           style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
//         ),
//         content: Text(
//           'Would you like to review your answers before submitting?',
//           style: GoogleFonts.poppins(),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Get.back();
//               _submitQuestionnaire();
//             },
//             child: Text('Submit Now', style: GoogleFonts.poppins(color: AppColors.primaryColor)),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Get.back();
//               _showReviewScreen();
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: AppColors.primaryColor,
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//             ),
//             child: Text('Review', style: GoogleFonts.poppins(color: AppColors.whiteColor)),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showReviewScreen() {
//     // Navigate to review screen
//     Get.snackbar(
//       'Success',
//       'Questionnaire completed! Proceeding to results...',
//       backgroundColor: AppColors.successColor,
//       colorText: AppColors.whiteColor,
//     );
//     Get.offAllNamed(AppRoutes.results);
//   }

//   void _submitQuestionnaire() {
//     Get.snackbar(
//       'Success',
//       'Questionnaire submitted successfully!',
//       backgroundColor: AppColors.successColor,
//       colorText: AppColors.whiteColor,
//     );
//     Get.offAllNamed(AppRoutes.results);
//   }
// }
