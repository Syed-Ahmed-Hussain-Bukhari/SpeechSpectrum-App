// // // lib/view/questionnaire/questionnaire_result_screen.dart
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:speechspectrum/constants/app_colors.dart';
// // import 'package:speechspectrum/constants/custom_size.dart';
// // import 'package:speechspectrum/models/questionnaire_model.dart';
// // import 'package:intl/intl.dart';

// // class QuestionnaireResultScreen extends StatelessWidget {
// //   const QuestionnaireResultScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     final size = CustomSize();
// //     final QuestionnaireResult result = Get.arguments as QuestionnaireResult;
    
// //     // Parse probability percentage
// //     final probabilityStr = result.probability.replaceAll('%', '');
// //     final probability = double.tryParse(probabilityStr) ?? 0.0;
// //     final isLowRisk = result.prediction.toLowerCase().contains('low');
    
// //     final Color riskColor = isLowRisk ? AppColors.successColor : AppColors.warningColor;
    
// //     return Scaffold(
// //       backgroundColor: AppColors.lightGreyColor,
// //       appBar: AppBar(
// //         backgroundColor: AppColors.whiteColor,
// //         elevation: 0,
// //         leading: IconButton(
// //           icon: Icon(Icons.arrow_back, color: AppColors.textPrimaryColor),
// //           onPressed: () => Get.back(),
// //         ),
// //         title: Text(
// //           'Assessment Results',
// //           style: GoogleFonts.poppins(
// //             color: AppColors.textPrimaryColor,
// //             fontSize: 18,
// //             fontWeight: FontWeight.w600,
// //           ),
// //         ),
// //         actions: [
// //           IconButton(
// //             icon: Icon(Icons.share_outlined, color: AppColors.textPrimaryColor),
// //             onPressed: () {},
// //           ),
// //         ],
// //       ),
// //       body: SingleChildScrollView(
// //         padding: EdgeInsets.all(size.customWidth(context) * 0.05),
// //         child: Column(
// //           children: [
// //             // Date Badge
// //             Container(
// //               padding: EdgeInsets.symmetric(
// //                 horizontal: size.customWidth(context) * 0.04,
// //                 vertical: size.customHeight(context) * 0.01,
// //               ),
// //               decoration: BoxDecoration(
// //                 color: AppColors.whiteColor,
// //                 borderRadius: BorderRadius.circular(25),
// //               ),
// //               child: Row(
// //                 mainAxisSize: MainAxisSize.min,
// //                 children: [
// //                   Icon(Icons.calendar_today, size: 14, color: AppColors.textSecondaryColor),
// //                   SizedBox(width: 6),
// //                   Text(
// //                     'Assessment Date: ${DateFormat('MMMM d, y').format(DateTime.parse(result.generatedAt))}',
// //                     style: GoogleFonts.poppins(
// //                       fontSize: 12,
// //                       color: AppColors.textSecondaryColor,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
            
// //             SizedBox(height: size.customHeight(context) * 0.02),
            
// //             // Risk Score Card
// //             Container(
// //               padding: EdgeInsets.all(size.customWidth(context) * 0.06),
// //               decoration: BoxDecoration(
// //                 gradient: LinearGradient(
// //                   colors: isLowRisk 
// //                       ? [AppColors.successColor, Colors.green.shade600]
// //                       : [AppColors.warningColor, Colors.orange.shade400],
// //                   begin: Alignment.topLeft,
// //                   end: Alignment.bottomRight,
// //                 ),
// //                 borderRadius: BorderRadius.circular(25),
// //                 boxShadow: [
// //                   BoxShadow(
// //                     color: riskColor.withOpacity(0.3),
// //                     blurRadius: 20,
// //                     offset: Offset(0, 10),
// //                   ),
// //                 ],
// //               ),
// //               child: Column(
// //                 children: [
// //                   Stack(
// //                     alignment: Alignment.center,
// //                     children: [
// //                       SizedBox(
// //                         height: size.customHeight(context) * 0.18,
// //                         width: size.customHeight(context) * 0.18,
// //                         child: CircularProgressIndicator(
// //                           value: probability / 100,
// //                           strokeWidth: 12,
// //                           backgroundColor: AppColors.whiteColor.withOpacity(0.3),
// //                           valueColor: AlwaysStoppedAnimation<Color>(AppColors.whiteColor),
// //                         ),
// //                       ),
// //                       Column(
// //                         children: [
// //                           Text(
// //                             result.probability,
// //                             style: GoogleFonts.poppins(
// //                               color: AppColors.whiteColor,
// //                               fontSize: 56,
// //                               fontWeight: FontWeight.bold,
// //                               height: 1,
// //                             ),
// //                           ),
// //                           Text(
// //                             'probability',
// //                             style: GoogleFonts.poppins(
// //                               color: AppColors.whiteColor.withOpacity(0.9),
// //                               fontSize: 14,
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ],
// //                   ),
// //                   SizedBox(height: size.customHeight(context) * 0.025),
// //                   Container(
// //                     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
// //                     decoration: BoxDecoration(
// //                       color: AppColors.whiteColor.withOpacity(0.2),
// //                       borderRadius: BorderRadius.circular(20),
// //                     ),
// //                     child: Text(
// //                       result.prediction,
// //                       style: GoogleFonts.poppins(
// //                         color: AppColors.whiteColor,
// //                         fontSize: 16,
// //                         fontWeight: FontWeight.w600,
// //                         letterSpacing: 0.5,
// //                       ),
// //                     ),
// //                   ),
// //                   SizedBox(height: size.customHeight(context) * 0.015),
// //                   Text(
// //                     'Based on questionnaire responses',
// //                     style: GoogleFonts.poppins(
// //                       color: AppColors.whiteColor.withOpacity(0.85),
// //                       fontSize: 12,
// //                       height: 1.4,
// //                     ),
// //                     textAlign: TextAlign.center,
// //                   ),
// //                 ],
// //               ),
// //             ),
            
// //             SizedBox(height: size.customHeight(context) * 0.025),
            
// //             // Important Notice
// //             Container(
// //               padding: EdgeInsets.all(size.customWidth(context) * 0.04),
// //               decoration: BoxDecoration(
// //                 color: AppColors.accentColor.withOpacity(0.1),
// //                 borderRadius: BorderRadius.circular(15),
// //                 border: Border.all(
// //                   color: AppColors.accentColor.withOpacity(0.3),
// //                   width: 1,
// //                 ),
// //               ),
// //               child: Row(
// //                 children: [
// //                   Icon(Icons.info_outline, color: AppColors.accentColor, size: 22),
// //                   SizedBox(width: 12),
// //                   Expanded(
// //                     child: Text(
// //                       'This is a screening tool, not a diagnostic assessment. Professional evaluation is recommended.',
// //                       style: GoogleFonts.poppins(
// //                         fontSize: 12,
// //                         color: AppColors.textPrimaryColor,
// //                         height: 1.4,
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
            
// //             SizedBox(height: size.customHeight(context) * 0.025),
            
// //             // Recommendation Card
// //             Container(
// //               padding: EdgeInsets.all(size.customWidth(context) * 0.05),
// //               decoration: BoxDecoration(
// //                 gradient: LinearGradient(
// //                   colors: [AppColors.primaryColor, AppColors.secondaryColor],
// //                   begin: Alignment.topLeft,
// //                   end: Alignment.bottomRight,
// //                 ),
// //                 borderRadius: BorderRadius.circular(20),
// //               ),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Row(
// //                     children: [
// //                       Icon(Icons.medical_services_outlined, 
// //                         color: AppColors.whiteColor, size: 24),
// //                       SizedBox(width: 12),
// //                       Text(
// //                         'Our Recommendation',
// //                         style: GoogleFonts.poppins(
// //                           fontSize: 18,
// //                           fontWeight: FontWeight.bold,
// //                           color: AppColors.whiteColor,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                   SizedBox(height: 16),
// //                   Text(
// //                     isLowRisk
// //                         ? 'Your child shows low indicators for autism spectrum concerns. Continue monitoring developmental milestones and maintain regular pediatric check-ups.'
// //                         : 'Based on the screening results, we recommend consulting with a qualified healthcare professional for a comprehensive developmental evaluation.',
// //                     style: GoogleFonts.poppins(
// //                       fontSize: 14,
// //                       color: AppColors.whiteColor.withOpacity(0.95),
// //                       height: 1.6,
// //                     ),
// //                   ),
// //                   SizedBox(height: 12),
// //                   Text(
// //                     'Early intervention can significantly improve developmental outcomes and provide your child with the support they need to thrive.',
// //                     style: GoogleFonts.poppins(
// //                       fontSize: 13,
// //                       color: AppColors.whiteColor.withOpacity(0.9),
// //                       height: 1.5,
// //                     ),
// //                   ),
// //                   SizedBox(height: 20),
// //                   SizedBox(
// //                     width: double.infinity,
// //                     height: size.customHeight(context) * 0.06,
// //                     child: ElevatedButton.icon(
// //                       onPressed: () {},
// //                       icon: Icon(Icons.search, size: 20),
// //                       label: Text(
// //                         'Find Specialists Near You',
// //                         style: GoogleFonts.poppins(
// //                           fontSize: 15,
// //                           fontWeight: FontWeight.w600,
// //                         ),
// //                       ),
// //                       style: ElevatedButton.styleFrom(
// //                         backgroundColor: AppColors.whiteColor,
// //                         foregroundColor: AppColors.primaryColor,
// //                         shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(15),
// //                         ),
// //                         elevation: 0,
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
            
// //             SizedBox(height: size.customHeight(context) * 0.02),
            
// //             // Action Buttons
// //             Row(
// //               children: [
// //                 Expanded(
// //                   child: OutlinedButton.icon(
// //                     onPressed: () => Get.toNamed('/questionnaire-history'),
// //                     icon: Icon(Icons.history, size: 20),
// //                     label: Text(
// //                       'View History',
// //                       style: GoogleFonts.poppins(
// //                         fontSize: 14,
// //                         fontWeight: FontWeight.w600,
// //                       ),
// //                     ),
// //                     style: OutlinedButton.styleFrom(
// //                       foregroundColor: AppColors.primaryColor,
// //                       side: BorderSide(color: AppColors.primaryColor, width: 1.5),
// //                       padding: EdgeInsets.symmetric(
// //                         vertical: size.customHeight(context) * 0.018,
// //                       ),
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(12),
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //                 SizedBox(width: 12),
// //                 Expanded(
// //                   child: ElevatedButton.icon(
// //                     onPressed: () => Get.back(),
// //                     icon: Icon(Icons.home, size: 20),
// //                     label: Text(
// //                       'Go Home',
// //                       style: GoogleFonts.poppins(
// //                         fontSize: 14,
// //                         fontWeight: FontWeight.w600,
// //                       ),
// //                     ),
// //                     style: ElevatedButton.styleFrom(
// //                       backgroundColor: AppColors.primaryColor,
// //                       foregroundColor: AppColors.whiteColor,
// //                       padding: EdgeInsets.symmetric(
// //                         vertical: size.customHeight(context) * 0.018,
// //                       ),
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(12),
// //                       ),
// //                       elevation: 0,
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
            
// //             SizedBox(height: size.customHeight(context) * 0.03),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }


// // lib/view/questionnaire/questionnaire_results_screen.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/questionnaire_controller.dart';
// import 'package:intl/intl.dart';

// class QuestionnaireResultsScreen extends StatelessWidget {
//   const QuestionnaireResultsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();
//     final controller = Get.find<QuestionnaireController>();

//     return Scaffold(
//       backgroundColor: AppColors.lightGreyColor,
//       appBar: AppBar(
//         backgroundColor: AppColors.whiteColor,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.home_outlined, color: AppColors.textPrimaryColor),
//           onPressed: () => Get.offAllNamed('/home'),
//         ),
//         title: Text(
//           'Screening Results',
//           style: GoogleFonts.poppins(
//             color: AppColors.textPrimaryColor,
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.share_outlined, color: AppColors.textPrimaryColor),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: Icon(Icons.download_outlined, color: AppColors.textPrimaryColor),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Obx(() {
//         final result = controller.resultModel.value;

//         if (result == null) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.error_outline,
//                   size: 64,
//                   color: AppColors.errorColor,
//                 ),
//                 SizedBox(height: 16),
//                 Text(
//                   'No results available',
//                   style: GoogleFonts.poppins(
//                     fontSize: 16,
//                     color: AppColors.textSecondaryColor,
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: () => Get.offAllNamed('/home'),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.primaryColor,
//                   ),
//                   child: Text(
//                     'Go Home',
//                     style: GoogleFonts.poppins(
//                       color: AppColors.whiteColor,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }

//         return SingleChildScrollView(
//           padding: EdgeInsets.all(size.customWidth(context) * 0.05),
//           child: Column(
//             children: [
//               // Date Badge
//               Container(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: size.customWidth(context) * 0.04,
//                   vertical: size.customHeight(context) * 0.01,
//                 ),
//                 decoration: BoxDecoration(
//                   color: AppColors.whiteColor,
//                   borderRadius: BorderRadius.circular(25),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(Icons.calendar_today,
//                         size: 14, color: AppColors.textSecondaryColor),
//                     SizedBox(width: 6),
//                     Text(
//                       'Assessment Date: ${DateFormat('MMMM dd, yyyy').format(DateTime.now())}',
//                       style: GoogleFonts.poppins(
//                         fontSize: 12,
//                         color: AppColors.textSecondaryColor,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               SizedBox(height: size.customHeight(context) * 0.02),

//               // Main Result Card
//               Container(
//                 padding: EdgeInsets.all(size.customWidth(context) * 0.06),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       result.result.result.getRiskColor(),
//                       result.result.result.getRiskColor().withOpacity(0.7),
//                     ],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   borderRadius: BorderRadius.circular(25),
//                   boxShadow: [
//                     BoxShadow(
//                       color: result.result.result.getRiskColor().withOpacity(0.3),
//                       blurRadius: 20,
//                       offset: Offset(0, 10),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   children: [
//                     // Circular Progress
//                     // Stack(
//                     //   alignment: Alignment.center,
//                     //   children: [
//                     //     SizedBox(
//                     //       height: size.customHeight(context) * 0.18,
//                     //       width: size.customHeight(context) * 0.35,
//                     //       child: CircularProgressIndicator(
//                     //         value: double.parse(result.result.result.probability
//                     //                 .replaceAll('%', '')) /
//                     //             100,
//                     //         strokeWidth: 12,
//                     //         backgroundColor:
//                     //             AppColors.whiteColor.withOpacity(0.3),
//                     //         valueColor: AlwaysStoppedAnimation<Color>(
//                     //             AppColors.whiteColor),
//                     //       ),
//                     //     ),
//                     //     Column(
//                     //       children: [
//                     //         Text(
//                     //           result.result.result.probability,
//                     //           style: GoogleFonts.poppins(
//                     //             color: AppColors.whiteColor,
//                     //             fontSize: 56,
//                     //             fontWeight: FontWeight.bold,
//                     //             height: 1,
//                     //           ),
//                     //         ),
//                     //         Text(
//                     //           'probability',
//                     //           style: GoogleFonts.poppins(
//                     //             color: AppColors.whiteColor.withOpacity(0.9),
//                     //             fontSize: 14,
//                     //           ),
//                     //         ),
//                     //       ],
//                     //     ),
//                     //   ],
//                     // ),

//                     // Circular Progress (UPDATED – no overlap)
//                   Column(
//                     children: [
//                       SizedBox(
//                         height: size.customHeight(context) * 0.18,
//                         width: size.customHeight(context) * 0.18,
//                         child: CircularProgressIndicator(
//                           value: double.parse(
//                                   result.result.result.probability.replaceAll('%', '')) /
//                               100,
//                           strokeWidth: 12,
//                           backgroundColor:
//                               AppColors.whiteColor.withOpacity(0.3),
//                           valueColor: AlwaysStoppedAnimation<Color>(
//                             AppColors.whiteColor,
//                           ),
//                         ),
//                       ),

//                       SizedBox(height: size.customHeight(context) * 0.015),

//                       // Percentage OUTSIDE the circle
//                       Text(
//                         result.result.result.probability,
//                         style: GoogleFonts.poppins(
//                           color: AppColors.whiteColor,
//                           fontSize: size.customWidth(context) * 0.12,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),

//                       Text(
//                         'Probability',
//                         style: GoogleFonts.poppins(
//                           color: AppColors.whiteColor.withOpacity(0.9),
//                           fontSize: 14,
//                           letterSpacing: 0.8,
//                         ),
//                       ),
//                     ],
//                   ),

//                     SizedBox(height: size.customHeight(context) * 0.025),
//                     Container(
//                       padding: EdgeInsets.symmetric(
//                           horizontal: 20, vertical: 8),
//                       decoration: BoxDecoration(
//                         color: AppColors.whiteColor.withOpacity(0.2),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Text(
//                         result.result.result.prediction,
//                         style: GoogleFonts.poppins(
//                           color: AppColors.whiteColor,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                           letterSpacing: 0.5,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                     SizedBox(height: size.customHeight(context) * 0.015),
//                     Text(
//                       'Based on questionnaire responses and analysis',
//                       style: GoogleFonts.poppins(
//                         color: AppColors.whiteColor.withOpacity(0.85),
//                         fontSize: 12,
//                         height: 1.4,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ],
//                 ),
//               ),

//               SizedBox(height: size.customHeight(context) * 0.025),

//               // Important Notice
//               Container(
//                 padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//                 decoration: BoxDecoration(
//                   color: AppColors.accentColor.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(15),
//                   border: Border.all(
//                     color: AppColors.accentColor.withOpacity(0.3),
//                     width: 1,
//                   ),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(Icons.info_outline,
//                         color: AppColors.accentColor, size: 22),
//                     SizedBox(width: 12),
//                     Expanded(
//                       child: Text(
//                         'This is a screening tool, not a diagnostic assessment. Professional evaluation is recommended.',
//                         style: GoogleFonts.poppins(
//                           fontSize: 12,
//                           color: AppColors.textPrimaryColor,
//                           height: 1.4,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               SizedBox(height: size.customHeight(context) * 0.025),

//               // Detailed Information
//               Container(
//                 padding: EdgeInsets.all(size.customWidth(context) * 0.05),
//                 decoration: BoxDecoration(
//                   color: AppColors.whiteColor,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Container(
//                           padding: EdgeInsets.all(8),
//                           decoration: BoxDecoration(
//                             color: AppColors.primaryColor.withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Icon(Icons.assessment_outlined,
//                               color: AppColors.primaryColor, size: 20),
//                         ),
//                         SizedBox(width: 12),
//                         Text(
//                           'Assessment Details',
//                           style: GoogleFonts.poppins(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: AppColors.textPrimaryColor,
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 20),
//                     _buildInfoRow(
//                       context,
//                       'Questions Answered',
//                       '${controller.questions.length}/${controller.questions.length}',
//                       Icons.quiz_outlined,
//                     ),
//                     _buildInfoRow(
//                       context,
//                       'Assessment Type',
//                       'ASD Screening Questionnaire',
//                       Icons.medical_services_outlined,
//                     ),
//                     _buildInfoRow(
//                       context,
//                       'Completed On',
//                       DateFormat('MMM dd, yyyy - hh:mm a')
//                           .format(DateTime.now()),
//                       Icons.access_time,
//                     ),
//                   ],
//                 ),
//               ),

//               SizedBox(height: size.customHeight(context) * 0.025),

//               // Recommendation Card
//               Container(
//                 padding: EdgeInsets.all(size.customWidth(context) * 0.05),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       AppColors.primaryColor,
//                       AppColors.secondaryColor
//                     ],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Icon(Icons.medical_services_outlined,
//                             color: AppColors.whiteColor, size: 24),
//                         SizedBox(width: 12),
//                         Text(
//                           'Our Recommendation',
//                           style: GoogleFonts.poppins(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: AppColors.whiteColor,
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 16),
//                     Text(
//                       result.result.result.getRiskLevel() == 'Low'
//                           ? 'The screening indicates low likelihood. However, if you have concerns, we recommend consulting with a qualified healthcare professional for peace of mind.'
//                           : 'Based on the screening results, we strongly recommend consulting with a qualified healthcare professional for a comprehensive developmental evaluation.',
//                       style: GoogleFonts.poppins(
//                         fontSize: 14,
//                         color: AppColors.whiteColor.withOpacity(0.95),
//                         height: 1.6,
//                       ),
//                     ),
//                     SizedBox(height: 12),
//                     Text(
//                       'Early intervention can significantly improve developmental outcomes and provide your child with the support they need to thrive.',
//                       style: GoogleFonts.poppins(
//                         fontSize: 13,
//                         color: AppColors.whiteColor.withOpacity(0.9),
//                         height: 1.5,
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     SizedBox(
//                       width: double.infinity,
//                       height: size.customHeight(context) * 0.06,
//                       child: ElevatedButton.icon(
//                         onPressed: () {},
//                         icon: Icon(Icons.search, size: 20),
//                         label: Text(
//                           'Find Specialists Near You',
//                           style: GoogleFonts.poppins(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: AppColors.whiteColor,
//                           foregroundColor: AppColors.primaryColor,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           elevation: 0,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               SizedBox(height: size.customHeight(context) * 0.025),

//               // Action Buttons
//               Row(
//                 children: [
//                   Expanded(
//                     child: OutlinedButton.icon(
//                       onPressed: () {},
//                       icon: Icon(Icons.print_outlined, size: 20),
//                       label: Text(
//                         'Print Report',
//                         style: GoogleFonts.poppins(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       style: OutlinedButton.styleFrom(
//                         foregroundColor: AppColors.primaryColor,
//                         side: BorderSide(
//                             color: AppColors.primaryColor, width: 1.5),
//                         padding: EdgeInsets.symmetric(
//                           vertical: size.customHeight(context) * 0.018,
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 12),
//                   Expanded(
//                     child: ElevatedButton.icon(
//                       onPressed: () {},
//                       icon: Icon(Icons.email_outlined, size: 20),
//                       label: Text(
//                         'Email Report',
//                         style: GoogleFonts.poppins(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.primaryColor,
//                         foregroundColor: AppColors.whiteColor,
//                         padding: EdgeInsets.symmetric(
//                           vertical: size.customHeight(context) * 0.018,
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         elevation: 0,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),

//               SizedBox(height: size.customHeight(context) * 0.03),
//             ],
//           ),
//         );
//       }),
//     );
//   }

//   Widget _buildInfoRow(
//       BuildContext context, String label, String value, IconData icon) {
//     final size = CustomSize();

//     return Padding(
//       padding: EdgeInsets.only(bottom: 16),
//       child: Row(
//         children: [
//           Container(
//             padding: EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: AppColors.primaryColor.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Icon(icon, size: 20, color: AppColors.primaryColor),
//           ),
//           SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   label,
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.032,
//                     color: AppColors.textSecondaryColor,
//                   ),
//                 ),
//                 Text(
//                   value,
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.038,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.textPrimaryColor,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// lib/view/questionnaire/questionnaire_results_screen.dart
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import 'package:speechspectrum/controllers/questionnaire_controller.dart';
import 'package:speechspectrum/routes/app_routes.dart';

class QuestionnaireResultsScreen extends StatelessWidget {
  const QuestionnaireResultsScreen({super.key});

  // ─── helpers ────────────────────────────────────────────────────────────────

  bool _isHighProbability(String probability) {
    try {
      final value = double.parse(probability.replaceAll('%', ''));
      return value >= 30.0;
    } catch (_) {
      return false;
    }
  }

  // Returns a human-readable label for each A1-A10 key
  String _questionLabel(String key) {
    const map = {
      'A1': 'Does your child look at you when called?',
      'A2': 'How easy is eye contact with your child?',
      'A3': 'Does your child point to indicate wants?',
      'A4': 'Does your child point to share interest?',
      'A5': 'Does your child pretend play?',
      'A6': 'Does your child follow where you\'re looking?',
      'A7': 'Does your child show signs of comforting others?',
      'A8': 'How would you describe first words?',
      'A9': 'Does your child use simple gestures?',
      'A10': 'Does your child stare at nothing?',
    };
    return map[key] ?? key;
  }

  // ─── PDF generation ─────────────────────────────────────────────────────────

  Future<void> _downloadPdf(BuildContext context, QuestionnaireController controller) async {
    try {
      final result = controller.resultModel.value;
      if (result == null) return;

      final childName = controller.selectedChildName.value;
      final probability = result.result.result.probability;
      final prediction = result.result.result.prediction;
      final responses = result.submission.responses;
      final submittedAt = result.submission.submittedAt;

      final pdf = pw.Document();

      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(40),
          build: (pw.Context ctx) => [
            // Header
            pw.Container(
              padding: const pw.EdgeInsets.all(20),
              decoration: pw.BoxDecoration(
                color: PdfColor.fromHex('6C63FF'),
                borderRadius: const pw.BorderRadius.all(pw.Radius.circular(12)),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'ASD Screening Report',
                    style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.white,
                    ),
                  ),
                  pw.SizedBox(height: 6),
                  pw.Text(
                    'SpeechSpectrum — Confidential Assessment',
                    style: const pw.TextStyle(fontSize: 12, color: PdfColors.white),
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 20),

            // Result summary
            pw.Container(
              padding: const pw.EdgeInsets.all(16),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColor.fromHex('E0E0E0')),
                borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('Screening Result',
                      style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
                  pw.SizedBox(height: 10),
                  pw.Row(children: [
                    pw.Text('Child Name: ', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text(childName.isNotEmpty ? childName : 'N/A'),
                  ]),
                  pw.SizedBox(height: 4),
                  pw.Row(children: [
                    pw.Text('Prediction: ', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text(prediction),
                  ]),
                  pw.SizedBox(height: 4),
                  pw.Row(children: [
                    pw.Text('Probability: ', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text(probability),
                  ]),
                  pw.SizedBox(height: 4),
                  pw.Row(children: [
                    pw.Text('Assessment Date: ', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text(() {
                      try {
                        return DateFormat('MMMM dd, yyyy').format(DateTime.parse(submittedAt));
                      } catch (_) {
                        return DateFormat('MMMM dd, yyyy').format(DateTime.now());
                      }
                    }()),
                  ]),
                ],
              ),
            ),
            pw.SizedBox(height: 20),

            // Submission info
            pw.Text('Submission Information',
                style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 8),
            pw.Container(
              padding: const pw.EdgeInsets.all(12),
              decoration: pw.BoxDecoration(
                color: PdfColor.fromHex('F8F9FA'),
                borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  _pdfInfoRow('Age (Months)', '${responses['Age_Mons'] ?? 'N/A'}'),
                  _pdfInfoRow('Gender', responses['Sex'] == 1 ? 'Male' : 'Female'),
                  _pdfInfoRow('Jaundice History', responses['Jaundice'] == 1 ? 'Yes' : 'No'),
                  _pdfInfoRow('Family History of ASD', responses['Family_mem_with_ASD'] == 1 ? 'Yes' : 'No'),
                ],
              ),
            ),
            pw.SizedBox(height: 20),

            // Questionnaire responses
            pw.Text('Questionnaire Responses',
                style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 8),
            ...['A1','A2','A3','A4','A5','A6','A7','A8','A9','A10'].map((key) {
              final val = responses[key];
              final isPositive = val == 1;
              return pw.Container(
                margin: const pw.EdgeInsets.only(bottom: 6),
                padding: const pw.EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: pw.BoxDecoration(
                  color: isPositive ? PdfColor.fromHex('E8F5E9') : PdfColor.fromHex('FFEBEE'),
                  borderRadius: const pw.BorderRadius.all(pw.Radius.circular(6)),
                ),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Expanded(
                      child: pw.Text(
                        _questionLabel(key),
                        style: const pw.TextStyle(fontSize: 11),
                      ),
                    ),
                    pw.SizedBox(width: 10),
                    pw.Text(
                      isPositive ? 'Positive' : 'Negative',
                      style: pw.TextStyle(
                        fontSize: 11,
                        fontWeight: pw.FontWeight.bold,
                        color: isPositive ? PdfColor.fromHex('388E3C') : PdfColor.fromHex('D32F2F'),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),

            pw.SizedBox(height: 20),
            pw.Container(
              padding: const pw.EdgeInsets.all(12),
              decoration: pw.BoxDecoration(
                color: PdfColor.fromHex('FFF8E1'),
                borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
              ),
              child: pw.Text(
                'Disclaimer: This is a screening tool, not a diagnostic assessment. '
                'Professional evaluation by a qualified healthcare provider is recommended.',
                style: const pw.TextStyle(fontSize: 10),
              ),
            ),
          ],
        ),
      );

      final Uint8List bytes = await pdf.save();

      final dir = await getApplicationDocumentsDirectory();
      final childSafe = childName.isNotEmpty
          ? childName.replaceAll(RegExp(r'[^\w]'), '_')
          : 'report';
      final file = File('${dir.path}/ASD_Report_$childSafe.pdf');
      await file.writeAsBytes(bytes);

      await OpenFile.open(file.path);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Could not generate PDF: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.errorColor,
        colorText: AppColors.whiteColor,
      );
    }
  }

  pw.Widget _pdfInfoRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 4),
      child: pw.Row(children: [
        pw.Text('$label: ', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11)),
        pw.Text(value, style: const pw.TextStyle(fontSize: 11)),
      ]),
    );
  }

  // ─── build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();
    final controller = Get.find<QuestionnaireController>();

    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.home_outlined, color: AppColors.textPrimaryColor),
          onPressed: () => Get.offAllNamed('/home'),
        ),
        title: Text(
          'Screening Results',
          style: GoogleFonts.poppins(
            color: AppColors.textPrimaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Obx(() {
            final result = controller.resultModel.value;
            if (result == null) return const SizedBox.shrink();
            return IconButton(
              icon: Icon(Icons.download_outlined, color: AppColors.textPrimaryColor),
              onPressed: () => _downloadPdf(context, controller),
              tooltip: 'Download PDF Report',
            );
          }),
        ],
      ),
      body: Obx(() {
        final result = controller.resultModel.value;

        if (result == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: AppColors.errorColor),
                const SizedBox(height: 16),
                Text(
                  'No results available',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: AppColors.textSecondaryColor,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => Get.offAllNamed('/home'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                  ),
                  child: Text(
                    'Go Home',
                    style: GoogleFonts.poppins(color: AppColors.whiteColor),
                  ),
                ),
              ],
            ),
          );
        }

        final prediction = result.result.result;
        final submission = result.submission;
        final responses = submission.responses;
        final childName = controller.selectedChildName.value;
        final childId = controller.selectedChildId.value;
        final isHighProb = _isHighProbability(prediction.probability);

        return SingleChildScrollView(
          padding: EdgeInsets.all(size.customWidth(context) * 0.05),
          child: Column(
            children: [
              // ── Result Card (same style as submission_details_screen) ──────
              _buildResultCard(context, prediction, size),
              SizedBox(height: size.customHeight(context) * 0.025),

              // ── Expert Recommendation (if high probability) ───────────────
              if (isHighProb) ...[
                _buildExpertRecommendationCard(context, childId, childName, size),
                SizedBox(height: size.customHeight(context) * 0.025),
              ],

              // ── Submission Info Card ──────────────────────────────────────
              _buildInfoCard(context, submission, childName, size),
              SizedBox(height: size.customHeight(context) * 0.025),

              // ── Responses Card ────────────────────────────────────────────
              _buildResponsesCard(context, responses, size),
              SizedBox(height: size.customHeight(context) * 0.025),

              // ── Download PDF Button ───────────────────────────────────────
              SizedBox(
                width: double.infinity,
                height: size.customHeight(context) * 0.065,
                child: ElevatedButton.icon(
                  onPressed: () => _downloadPdf(context, controller),
                  icon: const Icon(Icons.picture_as_pdf_outlined, size: 20),
                  label: Text(
                    'Download PDF Report',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: AppColors.whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                ),
              ),

              SizedBox(height: size.customHeight(context) * 0.03),
            ],
          ),
        );
      }),
    );
  }

  // ─── sub-widgets ────────────────────────────────────────────────────────────

  Widget _buildResultCard(BuildContext context, dynamic prediction, CustomSize size) {
    return Container(
      padding: EdgeInsets.all(size.customWidth(context) * 0.06),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            prediction.getRiskColor(),
            prediction.getRiskColor().withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: prediction.getRiskColor().withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // Circular progress
          SizedBox(
            height: size.customHeight(context) * 0.15,
            width: size.customHeight(context) * 0.15,
            child: CircularProgressIndicator(
              value: double.parse(
                      prediction.probability.replaceAll('%', '')) /
                  100,
              strokeWidth: 12,
              backgroundColor: AppColors.whiteColor.withOpacity(0.3),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.whiteColor),
            ),
          ),
          SizedBox(height: size.customHeight(context) * 0.02),
          // Probability
          Text(
            prediction.probability,
            style: GoogleFonts.poppins(
              color: AppColors.whiteColor,
              fontSize: 40,
              fontWeight: FontWeight.bold,
              height: 1,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'probability',
            style: GoogleFonts.poppins(
              color: AppColors.whiteColor.withOpacity(0.9),
              fontSize: 14,
            ),
          ),
          SizedBox(height: size.customHeight(context) * 0.025),
          // Prediction badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.whiteColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              prediction.prediction,
              style: GoogleFonts.poppins(
                color: AppColors.whiteColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: size.customHeight(context) * 0.015),
          Text(
            'Based on questionnaire responses and analysis',
            style: GoogleFonts.poppins(
              color: AppColors.whiteColor.withOpacity(0.85),
              fontSize: 12,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildExpertRecommendationCard(
    BuildContext context,
    String childId,
    String childName,
    CustomSize size,
  ) {
    return Container(
      padding: EdgeInsets.all(size.customWidth(context) * 0.05),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.accentColor.withOpacity(0.1),
            AppColors.primaryColor.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.accentColor.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.accentColor, AppColors.primaryColor],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accentColor.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.medical_services_rounded,
                  color: AppColors.whiteColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Expert Consultation Recommended',
                      style: GoogleFonts.poppins(
                        fontSize: size.customWidth(context) * 0.042,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimaryColor,
                      ),
                    ),
                    SizedBox(height: size.customHeight(context) * 0.004),
                    Text(
                      'Consider consulting with a specialist',
                      style: GoogleFonts.poppins(
                        fontSize: size.customWidth(context) * 0.032,
                        color: AppColors.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: size.customHeight(context) * 0.02),
          Container(
            padding: EdgeInsets.all(size.customWidth(context) * 0.04),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              childName.isNotEmpty
                  ? 'Based on the assessment results, we recommend consulting with a qualified expert for $childName. Early professional guidance can be very beneficial.'
                  : 'Based on the assessment results, we recommend consulting with a qualified expert. Early professional guidance can be very beneficial.',
              style: GoogleFonts.poppins(
                fontSize: size.customWidth(context) * 0.036,
                color: AppColors.textPrimaryColor,
                height: 1.6,
              ),
            ),
          ),
          SizedBox(height: size.customHeight(context) * 0.02),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                Get.toNamed(
                  AppRoutes.expertsList,
                  arguments: {
                    'childId': childId,
                    'childName': childName,
                  },
                );
              },
              icon: const Icon(Icons.person_search_rounded, size: 20),
              label: Text(
                'View All Experts',
                style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.04,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentColor,
                foregroundColor: AppColors.whiteColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: size.customHeight(context) * 0.018,
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    dynamic submission,
    String childName,
    CustomSize size,
  ) {
    final responses = submission.responses as Map<String, dynamic>;

    String formattedDate = 'N/A';
    String formattedTime = 'N/A';
    try {
      final dt = DateTime.parse(submission.submittedAt);
      formattedDate = DateFormat('MMMM dd, yyyy').format(dt);
      final hour = dt.hour > 12
          ? dt.hour - 12
          : (dt.hour == 0 ? 12 : dt.hour);
      final period = dt.hour >= 12 ? 'PM' : 'AM';
      formattedTime =
          '${hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')} $period';
    } catch (_) {}

    return Container(
      padding: EdgeInsets.all(size.customWidth(context) * 0.05),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.info_outline,
                    color: AppColors.primaryColor, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                'Submission Information',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildInfoRow(context, 'Child Name',
              childName.isNotEmpty ? childName : 'N/A', Icons.person_outline, size),
          _buildInfoRow(context, 'Submission Date', formattedDate,
              Icons.calendar_today_outlined, size),
          _buildInfoRow(context, 'Submission Time', formattedTime,
              Icons.access_time_outlined, size),
          _buildInfoRow(context, 'Age (Months)',
              '${responses['Age_Mons'] ?? 'N/A'}', Icons.cake_outlined, size),
          _buildInfoRow(
              context,
              'Gender',
              responses['Sex'] == 1 ? 'Male' : 'Female',
              Icons.wc_outlined,
              size),
          _buildInfoRow(
              context,
              'Jaundice History',
              responses['Jaundice'] == 1 ? 'Yes' : 'No',
              Icons.medical_information_outlined,
              size),
          _buildInfoRow(
              context,
              'Family History of ASD',
              responses['Family_mem_with_ASD'] == 1 ? 'Yes' : 'No',
              Icons.family_restroom_outlined,
              size,
              isLast: true),
        ],
      ),
    );
  }

  Widget _buildResponsesCard(
    BuildContext context,
    Map<String, dynamic> responses,
    CustomSize size,
  ) {
    const questionKeys = ['A1','A2','A3','A4','A5','A6','A7','A8','A9','A10'];

    return Container(
      padding: EdgeInsets.all(size.customWidth(context) * 0.05),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.accentColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.quiz_outlined,
                    color: AppColors.accentColor, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                'Questionnaire Responses',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...questionKeys.map((key) {
            final val = responses[key];
            final isPositive = val == 1;
            return _buildResponseItem(
                context, _questionLabel(key), isPositive ? 'Positive' : 'Negative', isPositive, size);
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    CustomSize size, {
    bool isLast = false,
  }) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: size.customHeight(context) * 0.01),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 20, color: AppColors.primaryColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: GoogleFonts.poppins(
                        fontSize: size.customWidth(context) * 0.032,
                        color: AppColors.textSecondaryColor,
                      ),
                    ),
                    Text(
                      value,
                      style: GoogleFonts.poppins(
                        fontSize: size.customWidth(context) * 0.038,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (!isLast) Divider(color: AppColors.greyColor.withOpacity(0.2)),
      ],
    );
  }

  Widget _buildResponseItem(
    BuildContext context,
    String question,
    String answer,
    bool isPositive,
    CustomSize size,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(size.customWidth(context) * 0.04),
      decoration: BoxDecoration(
        color: isPositive
            ? AppColors.successColor.withOpacity(0.05)
            : AppColors.errorColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isPositive
              ? AppColors.successColor.withOpacity(0.2)
              : AppColors.errorColor.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(
            isPositive ? Icons.check_circle_outline : Icons.cancel_outlined,
            color: isPositive ? AppColors.successColor : AppColors.errorColor,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  question,
                  style: GoogleFonts.poppins(
                    fontSize: size.customWidth(context) * 0.035,
                    color: AppColors.textPrimaryColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  answer,
                  style: GoogleFonts.poppins(
                    fontSize: size.customWidth(context) * 0.032,
                    fontWeight: FontWeight.w600,
                    color: isPositive
                        ? AppColors.successColor
                        : AppColors.errorColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}