// // lib/view/questionnaire/questionnaire_history_screen.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/questionnaire_controller.dart';
// import 'package:speechspectrum/models/questionnaire_model.dart';
// import 'package:intl/intl.dart';

// class QuestionnaireHistoryScreen extends StatelessWidget {
//   const QuestionnaireHistoryScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();
//     final controller = Get.put(QuestionnaireController());

//     return Scaffold(
//       backgroundColor: AppColors.lightGreyColor,
//       body: CustomScrollView(
//         slivers: [
//           // App Bar with gradient
//           SliverAppBar(
//             expandedHeight: MediaQuery.of(context).size.height * 0.25,
//             pinned: true,
//             elevation: 0,
//             backgroundColor: AppColors.primaryColor,
//             flexibleSpace: FlexibleSpaceBar(
//               background: _buildHeader(context),
//             ),
//             leading: IconButton(
//               icon: const Icon(Icons.arrow_back, color: AppColors.whiteColor),
//               onPressed: () => Get.back(),
//             ),
//           ),

//           // Submissions List
//           Obx(() {
//             if (controller.isLoading.value) {
//               return SliverFillRemaining(
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const CircularProgressIndicator(
//                         color: AppColors.primaryColor,
//                         strokeWidth: 3,
//                       ),
//                       SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//                       Text(
//                         'Loading history...',
//                         style: GoogleFonts.poppins(
//                           color: AppColors.textSecondaryColor,
//                           fontSize: MediaQuery.of(context).size.width * 0.035,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             }

//             if (controller.submissions.isEmpty) {
//               return SliverFillRemaining(
//                 child: _buildEmptyState(context),
//               );
//             }

//             return SliverPadding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: MediaQuery.of(context).size.width * 0.05,
//               ),
//               sliver: SliverList(
//                 delegate: SliverChildBuilderDelegate(
//                   (context, index) {
//                     final submission = controller.submissions[index];
//                     return _buildSubmissionCard(context, controller, submission);
//                   },
//                   childCount: controller.submissions.length,
//                 ),
//               ),
//             );
//           }),

//           SliverToBoxAdapter(
//             child: SizedBox(height: MediaQuery.of(context).size.height * 0.1),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () => Get.toNamed('/patient-info'),
//         backgroundColor: AppColors.primaryColor,
//         elevation: 4,
//         icon: const Icon(Icons.add, color: AppColors.whiteColor),
//         label: Text(
//           'New Assessment',
//           style: GoogleFonts.poppins(
//             color: AppColors.whiteColor,
//             fontWeight: FontWeight.w600,
//             fontSize: 15,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [AppColors.primaryColor, AppColors.secondaryColor],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       child: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 width: 70,
//                 height: 70,
//                 decoration: BoxDecoration(
//                   color: AppColors.whiteColor.withOpacity(0.2),
//                   shape: BoxShape.circle,
//                 ),
//                 child: const Icon(
//                   Icons.history,
//                   size: 40,
//                   color: AppColors.whiteColor,
//                 ),
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height * 0.015),
//               Text(
//                 'Assessment History',
//                 style: GoogleFonts.poppins(
//                   color: AppColors.whiteColor,
//                   fontSize: MediaQuery.of(context).size.width * 0.06,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 0.5,
//                 ),
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height * 0.005),
//               Text(
//                 'View your past screening results',
//                 style: GoogleFonts.poppins(
//                   color: AppColors.whiteColor.withOpacity(0.9),
//                   fontSize: MediaQuery.of(context).size.width * 0.035,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSubmissionCard(
//     BuildContext context,
//     QuestionnaireController controller,
//     SubmissionHistoryItem submission,
//   ) {
//     final hasResult = submission.hasResult;
//     final result = submission.latestResult;
//     final isLowRisk = result?.prediction.toLowerCase().contains('low') ?? false;
    
//     return Container(
//       margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.015),
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.06),
//             blurRadius: 15,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: hasResult
//               ? () => Get.toNamed('/questionnaire-result', arguments: result)
//               : null,
//           borderRadius: BorderRadius.circular(20),
//           child: Padding(
//             padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       width: 60,
//                       height: 60,
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: hasResult
//                               ? (isLowRisk
//                                   ? [AppColors.successColor, Colors.green.shade600]
//                                   : [AppColors.warningColor, Colors.orange.shade400])
//                               : [AppColors.greyColor, Colors.grey.shade600],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                         borderRadius: BorderRadius.circular(15),
//                         boxShadow: [
//                           BoxShadow(
//                             color: (hasResult
//                                     ? (isLowRisk ? AppColors.successColor : AppColors.warningColor)
//                                     : AppColors.greyColor)
//                                 .withOpacity(0.3),
//                             blurRadius: 10,
//                             offset: const Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                       child: Icon(
//                         hasResult ? Icons.check_circle : Icons.pending,
//                         size: 32,
//                         color: AppColors.whiteColor,
//                       ),
//                     ),
//                     SizedBox(width: MediaQuery.of(context).size.width * 0.04),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             submission.childName,
//                             style: GoogleFonts.poppins(
//                               fontSize: MediaQuery.of(context).size.width * 0.045,
//                               fontWeight: FontWeight.w600,
//                               color: AppColors.textPrimaryColor,
//                             ),
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           SizedBox(height: MediaQuery.of(context).size.height * 0.006),
//                           Row(
//                             children: [
//                               const Icon(
//                                 Icons.calendar_today,
//                                 size: 14,
//                                 color: AppColors.textSecondaryColor,
//                               ),
//                               SizedBox(width: MediaQuery.of(context).size.width * 0.015),
//                               Text(
//                                 DateFormat('MMM d, y').format(
//                                   DateTime.parse(submission.submittedAt),
//                                 ),
//                                 style: GoogleFonts.poppins(
//                                   fontSize: MediaQuery.of(context).size.width * 0.032,
//                                   color: AppColors.textSecondaryColor,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           if (hasResult) ...[
//                             SizedBox(height: MediaQuery.of(context).size.height * 0.006),
//                             Container(
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: 10,
//                                 vertical: 4,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: (isLowRisk
//                                         ? AppColors.successColor
//                                         : AppColors.warningColor)
//                                     .withOpacity(0.1),
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               child: Text(
//                                 result!.probability,
//                                 style: GoogleFonts.poppins(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w600,
//                                   color: isLowRisk
//                                       ? AppColors.successColor
//                                       : AppColors.warningColor,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ],
//                       ),
//                     ),
//                     Column(
//                       children: [
//                         if (hasResult)
//                           IconButton(
//                             onPressed: () => Get.toNamed('/questionnaire-result', arguments: result),
//                             icon: const Icon(
//                               Icons.visibility_outlined,
//                               color: AppColors.primaryColor,
//                               size: 22,
//                             ),
//                             tooltip: 'View Result',
//                           ),
//                         IconButton(
//                           onPressed: () => _showDeleteDialog(context, controller, submission),
//                           icon: const Icon(
//                             Icons.delete_outline,
//                             color: AppColors.errorColor,
//                             size: 22,
//                           ),
//                           tooltip: 'Delete',
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 if (hasResult) ...[
//                   SizedBox(height: MediaQuery.of(context).size.height * 0.015),
//                   Container(
//                     padding: EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: AppColors.lightGreyColor,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Row(
//                       children: [
//                         Icon(
//                           isLowRisk ? Icons.check_circle : Icons.warning_amber_rounded,
//                           color: isLowRisk ? AppColors.successColor : AppColors.warningColor,
//                           size: 18,
//                         ),
//                         SizedBox(width: 8),
//                         Expanded(
//                           child: Text(
//                             result!.prediction,
//                             style: GoogleFonts.poppins(
//                               fontSize: 13,
//                               fontWeight: FontWeight.w500,
//                               color: AppColors.textPrimaryColor,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ] else ...[
//                   SizedBox(height: MediaQuery.of(context).size.height * 0.015),
//                   Container(
//                     padding: EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: AppColors.lightGreyColor,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.pending_outlined,
//                           color: AppColors.greyColor,
//                           size: 18,
//                         ),
//                         SizedBox(width: 8),
//                         Expanded(
//                           child: Text(
//                             'Result pending',
//                             style: GoogleFonts.poppins(
//                               fontSize: 13,
//                               fontWeight: FontWeight.w500,
//                               color: AppColors.textSecondaryColor,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildEmptyState(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.08),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: 160,
//               height: 160,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     AppColors.primaryColor.withOpacity(0.1),
//                     AppColors.secondaryColor.withOpacity(0.1),
//                   ],
//                 ),
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(
//                 Icons.history,
//                 size: 85,
//                 color: AppColors.primaryColor,
//               ),
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height * 0.03),
//             Text(
//               'No Assessments Yet',
//               style: GoogleFonts.poppins(
//                 fontSize: MediaQuery.of(context).size.width * 0.052,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.textPrimaryColor,
//               ),
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height * 0.015),
//             Text(
//               'Start your first screening assessment\nto track developmental milestones',
//               textAlign: TextAlign.center,
//               style: GoogleFonts.poppins(
//                 fontSize: MediaQuery.of(context).size.width * 0.038,
//                 color: AppColors.textSecondaryColor,
//                 height: 1.5,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showDeleteDialog(
//     BuildContext context,
//     QuestionnaireController controller,
//     SubmissionHistoryItem submission,
//   ) {
//     Get.dialog(
//       Dialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(25),
//         ),
//         child: Container(
//           padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 width: 80,
//                 height: 80,
//                 decoration: BoxDecoration(
//                   color: AppColors.errorColor.withOpacity(0.1),
//                   shape: BoxShape.circle,
//                 ),
//                 child: const Icon(
//                   Icons.warning_amber_rounded,
//                   color: AppColors.errorColor,
//                   size: 45,
//                 ),
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height * 0.025),
//               Text(
//                 'Delete Assessment',
//                 style: GoogleFonts.poppins(
//                   fontWeight: FontWeight.bold,
//                   fontSize: MediaQuery.of(context).size.width * 0.05,
//                   color: AppColors.textPrimaryColor,
//                 ),
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height * 0.015),
//               Text(
//                 'Are you sure you want to delete this assessment for ${submission.childName}?',
//                 textAlign: TextAlign.center,
//                 style: GoogleFonts.poppins(
//                   fontSize: MediaQuery.of(context).size.width * 0.038,
//                   color: AppColors.textSecondaryColor,
//                   height: 1.4,
//                 ),
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height * 0.01),
//               Text(
//                 'This action cannot be undone.',
//                 textAlign: TextAlign.center,
//                 style: GoogleFonts.poppins(
//                   fontSize: MediaQuery.of(context).size.width * 0.034,
//                   color: AppColors.errorColor,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height * 0.03),
//               Row(
//                 children: [
//                   Expanded(
//                     child: OutlinedButton(
//                       onPressed: () => Get.back(),
//                       style: OutlinedButton.styleFrom(
//                         padding: EdgeInsets.symmetric(
//                           vertical: MediaQuery.of(context).size.height * 0.015,
//                         ),
//                         side: BorderSide(color: AppColors.greyColor.withOpacity(0.5)),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: Text(
//                         'Cancel',
//                         style: GoogleFonts.poppins(
//                           color: AppColors.textSecondaryColor,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: MediaQuery.of(context).size.width * 0.03),
//                   Expanded(
//                     child: Obx(() => ElevatedButton(
//                           onPressed: controller.isDeleting.value
//                               ? null
//                               : () => controller.deleteSubmission(submission.submissionId),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: AppColors.errorColor,
//                             padding: EdgeInsets.symmetric(
//                               vertical: MediaQuery.of(context).size.height * 0.015,
//                             ),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                           child: controller.isDeleting.value
//                               ? const SizedBox(
//                                   width: 20,
//                                   height: 20,
//                                   child: CircularProgressIndicator(
//                                     color: AppColors.whiteColor,
//                                     strokeWidth: 2,
//                                   ),
//                                 )
//                               : Text(
//                                   'Delete',
//                                   style: GoogleFonts.poppins(
//                                     color: AppColors.whiteColor,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                         )),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }