// // // // lib/view/speech/speech_detail_screen.dart

// // // import 'package:flutter/material.dart';
// // // import 'package:get/get.dart';
// // // import 'package:google_fonts/google_fonts.dart';
// // // import 'package:speechspectrum/constants/app_colors.dart';
// // // import 'package:speechspectrum/constants/custom_size.dart';
// // // import 'package:speechspectrum/controllers/speech_controller.dart';

// // // class SpeechDetailScreen extends StatefulWidget {
// // //   const SpeechDetailScreen({super.key});

// // //   @override
// // //   State<SpeechDetailScreen> createState() => _SpeechDetailScreenState();
// // // }

// // // class _SpeechDetailScreenState extends State<SpeechDetailScreen> {
// // //   late final SpeechController controller;
// // //   late String submissionId;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     submissionId = Get.arguments as String;
// // //     controller = Get.put(SpeechController());

// // //     // Fetch submission details
// // //     WidgetsBinding.instance.addPostFrameCallback((_) {
// // //       _loadSubmissionDetails();
// // //     });
// // //   }

// // //   void _loadSubmissionDetails() {
// // //     // Find in existing submissions
// // //     final existing = controller.speechSubmissions.firstWhereOrNull(
// // //       (s) => s.speechSubmissionId == submissionId,
// // //     );

// // //     if (existing != null) {
// // //       controller.currentSubmission.value = existing;
// // //     } else {
// // //       controller.fetchSubmissionDetail(submissionId);
// // //     }
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final size = CustomSize();

// // //     return Scaffold(
// // //       backgroundColor: AppColors.lightGreyColor,
// // //       body: Obx(() {
// // //         if (controller.isLoadingDetail.value &&
// // //             controller.currentSubmission.value == null) {
// // //           return Center(
// // //             child: Column(
// // //               mainAxisAlignment: MainAxisAlignment.center,
// // //               children: [
// // //                 const CircularProgressIndicator(
// // //                   color: AppColors.primaryColor,
// // //                   strokeWidth: 3,
// // //                 ),
// // //                 SizedBox(height: size.customHeight(context) * 0.02),
// // //                 Text(
// // //                   'Loading details...',
// // //                   style: GoogleFonts.poppins(
// // //                     color: AppColors.textSecondaryColor,
// // //                     fontSize: size.customWidth(context) * 0.035,
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //           );
// // //         }

// // //         final submission = controller.currentSubmission.value;
// // //         if (submission == null) {
// // //           return Center(
// // //             child: Column(
// // //               mainAxisAlignment: MainAxisAlignment.center,
// // //               children: [
// // //                 Icon(
// // //                   Icons.error_outline_rounded,
// // //                   size: 64,
// // //                   color: AppColors.errorColor,
// // //                 ),
// // //                 SizedBox(height: size.customHeight(context) * 0.02),
// // //                 Text(
// // //                   'Failed to load submission',
// // //                   style: GoogleFonts.poppins(
// // //                     fontSize: size.customWidth(context) * 0.04,
// // //                     color: AppColors.textSecondaryColor,
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //           );
// // //         }

// // //         return CustomScrollView(
// // //           slivers: [
// // //             _buildAppBar(context, submission),
// // //             SliverToBoxAdapter(
// // //               child: Padding(
// // //                 padding: EdgeInsets.all(size.customWidth(context) * 0.05),
// // //                 child: Column(
// // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // //                   children: [
// // //                     _buildInfoCard(context, submission),
// // //                     SizedBox(height: size.customHeight(context) * 0.02),
// // //                     _buildResultsSection(context, submission),
// // //                     SizedBox(height: size.customHeight(context) * 0.02),
// // //                     _buildActionsSection(context, submission),
// // //                   ],
// // //                 ),
// // //               ),
// // //             ),
// // //           ],
// // //         );
// // //       }),
// // //     );
// // //   }

// // //   Widget _buildAppBar(BuildContext context, submission) {
// // //     final size = CustomSize();

// // //     return SliverAppBar(
// // //       expandedHeight: size.customHeight(context) * 0.25,
// // //       pinned: true,
// // //       backgroundColor: AppColors.primaryColor,
// // //       flexibleSpace: FlexibleSpaceBar(
// // //         background: Container(
// // //           decoration: const BoxDecoration(
// // //             gradient: LinearGradient(
// // //               colors: [AppColors.primaryColor, AppColors.secondaryColor],
// // //               begin: Alignment.topLeft,
// // //               end: Alignment.bottomRight,
// // //             ),
// // //           ),
// // //           child: SafeArea(
// // //             child: Column(
// // //               mainAxisAlignment: MainAxisAlignment.center,
// // //               children: [
// // //                 Container(
// // //                   width: 70,
// // //                   height: 70,
// // //                   decoration: BoxDecoration(
// // //                     color: AppColors.whiteColor.withOpacity(0.2),
// // //                     shape: BoxShape.circle,
// // //                   ),
// // //                   child: Icon(
// // //                     submission.hasResults()
// // //                         ? Icons.check_circle_rounded
// // //                         : Icons.pending_rounded,
// // //                     size: 40,
// // //                     color: AppColors.whiteColor,
// // //                   ),
// // //                 ),
// // //                 SizedBox(height: size.customHeight(context) * 0.015),
// // //                 Text(
// // //                   'Speech Analysis',
// // //                   style: GoogleFonts.poppins(
// // //                     color: AppColors.whiteColor,
// // //                     fontSize: size.customWidth(context) * 0.06,
// // //                     fontWeight: FontWeight.bold,
// // //                   ),
// // //                 ),
// // //                 SizedBox(height: size.customHeight(context) * 0.005),
// // //                 Text(
// // //                   submission.getChildName(),
// // //                   style: GoogleFonts.poppins(
// // //                     color: AppColors.whiteColor.withOpacity(0.9),
// // //                     fontSize: size.customWidth(context) * 0.035,
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //           ),
// // //         ),
// // //       ),
// // //       leading: IconButton(
// // //         icon: const Icon(Icons.arrow_back, color: AppColors.whiteColor),
// // //         onPressed: () => Get.back(),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildInfoCard(BuildContext context, submission) {
// // //     final size = CustomSize();

// // //     return Container(
// // //       padding: EdgeInsets.all(size.customWidth(context) * 0.04),
// // //       decoration: BoxDecoration(
// // //         color: AppColors.whiteColor,
// // //         borderRadius: BorderRadius.circular(20),
// // //         boxShadow: [
// // //           BoxShadow(
// // //             color: Colors.black.withOpacity(0.06),
// // //             blurRadius: 15,
// // //             offset: const Offset(0, 4),
// // //           ),
// // //         ],
// // //       ),
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           Text(
// // //             'Recording Information',
// // //             style: GoogleFonts.poppins(
// // //               fontSize: size.customWidth(context) * 0.045,
// // //               fontWeight: FontWeight.bold,
// // //               color: AppColors.textPrimaryColor,
// // //             ),
// // //           ),
// // //           SizedBox(height: size.customHeight(context) * 0.02),
// // //           _buildInfoRow(
// // //             context,
// // //             Icons.person_rounded,
// // //             'Child',
// // //             submission.getChildName(),
// // //           ),
// // //           SizedBox(height: size.customHeight(context) * 0.015),
// // //           _buildInfoRow(
// // //             context,
// // //             Icons.access_time_rounded,
// // //             'Duration',
// // //             '${submission.recordingDurationSeconds} seconds',
// // //           ),
// // //           SizedBox(height: size.customHeight(context) * 0.015),
// // //           _buildInfoRow(
// // //             context,
// // //             Icons.calendar_today_outlined,
// // //             'Date',
// // //             submission.getFormattedDate(),
// // //           ),
// // //           SizedBox(height: size.customHeight(context) * 0.015),
// // //           _buildInfoRow(
// // //             context,
// // //             Icons.schedule_rounded,
// // //             'Time',
// // //             submission.getFormattedTime(),
// // //           ),
// // //           if (submission.recordingFormat != null) ...[
// // //             SizedBox(height: size.customHeight(context) * 0.015),
// // //             _buildInfoRow(
// // //               context,
// // //               Icons.audio_file_rounded,
// // //               'Format',
// // //               submission.recordingFormat!.toUpperCase(),
// // //             ),
// // //           ],
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildInfoRow(
// // //       BuildContext context, IconData icon, String label, String value) {
// // //     final size = CustomSize();

// // //     return Row(
// // //       children: [
// // //         Container(
// // //           width: 40,
// // //           height: 40,
// // //           decoration: BoxDecoration(
// // //             color: AppColors.primaryColor.withOpacity(0.1),
// // //             borderRadius: BorderRadius.circular(10),
// // //           ),
// // //           child: Icon(icon, color: AppColors.primaryColor, size: 20),
// // //         ),
// // //         SizedBox(width: size.customWidth(context) * 0.03),
// // //         Expanded(
// // //           child: Column(
// // //             crossAxisAlignment: CrossAxisAlignment.start,
// // //             children: [
// // //               Text(
// // //                 label,
// // //                 style: GoogleFonts.poppins(
// // //                   fontSize: size.customWidth(context) * 0.032,
// // //                   color: AppColors.textSecondaryColor,
// // //                 ),
// // //               ),
// // //               Text(
// // //                 value,
// // //                 style: GoogleFonts.poppins(
// // //                   fontSize: size.customWidth(context) * 0.038,
// // //                   fontWeight: FontWeight.w600,
// // //                   color: AppColors.textPrimaryColor,
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ],
// // //     );
// // //   }

// // //   Widget _buildResultsSection(BuildContext context, submission) {
// // //     final size = CustomSize();

// // //     if (!submission.hasResults()) {
// // //       return Container(
// // //         padding: EdgeInsets.all(size.customWidth(context) * 0.05),
// // //         decoration: BoxDecoration(
// // //           color: AppColors.warningColor.withOpacity(0.1),
// // //           borderRadius: BorderRadius.circular(20),
// // //           border: Border.all(
// // //             color: AppColors.warningColor.withOpacity(0.3),
// // //           ),
// // //         ),
// // //         child: Column(
// // //           children: [
// // //             Icon(
// // //               Icons.pending_rounded,
// // //               size: 50,
// // //               color: AppColors.warningColor,
// // //             ),
// // //             SizedBox(height: size.customHeight(context) * 0.02),
// // //             Text(
// // //               'Analysis Pending',
// // //               style: GoogleFonts.poppins(
// // //                 fontSize: size.customWidth(context) * 0.045,
// // //                 fontWeight: FontWeight.bold,
// // //                 color: AppColors.warningColor,
// // //               ),
// // //             ),
// // //             SizedBox(height: size.customHeight(context) * 0.01),
// // //             Text(
// // //               'The speech analysis is being processed.\nPlease check back later.',
// // //               textAlign: TextAlign.center,
// // //               style: GoogleFonts.poppins(
// // //                 fontSize: size.customWidth(context) * 0.035,
// // //                 color: AppColors.textSecondaryColor,
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //       );
// // //     }

// // //     final result = submission.getLatestResult()!;

// // //     return Container(
// // //       padding: EdgeInsets.all(size.customWidth(context) * 0.04),
// // //       decoration: BoxDecoration(
// // //         color: AppColors.whiteColor,
// // //         borderRadius: BorderRadius.circular(20),
// // //         boxShadow: [
// // //           BoxShadow(
// // //             color: Colors.black.withOpacity(0.06),
// // //             blurRadius: 15,
// // //             offset: const Offset(0, 4),
// // //           ),
// // //         ],
// // //       ),
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           Text(
// // //             'Analysis Results',
// // //             style: GoogleFonts.poppins(
// // //               fontSize: size.customWidth(context) * 0.045,
// // //               fontWeight: FontWeight.bold,
// // //               color: AppColors.textPrimaryColor,
// // //             ),
// // //           ),
// // //           SizedBox(height: size.customHeight(context) * 0.02),
// // //           Center(
// // //             child: Column(
// // //               children: [
// // //                 Container(
// // //                   width: size.customWidth(context) * 0.35,
// // //                   height: size.customWidth(context) * 0.35,
// // //                   decoration: BoxDecoration(
// // //                     shape: BoxShape.circle,
// // //                     gradient: LinearGradient(
// // //                       colors: result.result.isTypical()
// // //                           ? [
// // //                               AppColors.successColor.withOpacity(0.8),
// // //                               AppColors.successColor
// // //                             ]
// // //                           : [
// // //                               AppColors.warningColor.withOpacity(0.8),
// // //                               AppColors.warningColor
// // //                             ],
// // //                       begin: Alignment.topLeft,
// // //                       end: Alignment.bottomRight,
// // //                     ),
// // //                     boxShadow: [
// // //                       BoxShadow(
// // //                         color: (result.result.isTypical()
// // //                                 ? AppColors.successColor
// // //                                 : AppColors.warningColor)
// // //                             .withOpacity(0.3),
// // //                         blurRadius: 20,
// // //                         offset: const Offset(0, 10),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                   child: Column(
// // //                     mainAxisAlignment: MainAxisAlignment.center,
// // //                     children: [
// // //                       Text(
// // //                         '${result.result.score}',
// // //                         style: GoogleFonts.poppins(
// // //                           fontSize: size.customWidth(context) * 0.12,
// // //                           fontWeight: FontWeight.bold,
// // //                           color: AppColors.whiteColor,
// // //                         ),
// // //                       ),
// // //                       Text(
// // //                         'Score',
// // //                         style: GoogleFonts.poppins(
// // //                           fontSize: size.customWidth(context) * 0.035,
// // //                           color: AppColors.whiteColor.withOpacity(0.9),
// // //                         ),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                 ),
// // //                 SizedBox(height: size.customHeight(context) * 0.03),
// // //                 Container(
// // //                   padding: EdgeInsets.symmetric(
// // //                     horizontal: size.customWidth(context) * 0.06,
// // //                     vertical: size.customHeight(context) * 0.015,
// // //                   ),
// // //                   decoration: BoxDecoration(
// // //                     color: (result.result.isTypical()
// // //                             ? AppColors.successColor
// // //                             : AppColors.warningColor)
// // //                         .withOpacity(0.1),
// // //                     borderRadius: BorderRadius.circular(25),
// // //                     border: Border.all(
// // //                       color: (result.result.isTypical()
// // //                               ? AppColors.successColor
// // //                               : AppColors.warningColor)
// // //                           .withOpacity(0.3),
// // //                       width: 2,
// // //                     ),
// // //                   ),
// // //                   child: Text(
// // //                     result.result.label,
// // //                     style: GoogleFonts.poppins(
// // //                       fontSize: size.customWidth(context) * 0.05,
// // //                       fontWeight: FontWeight.bold,
// // //                       color: result.result.isTypical()
// // //                           ? AppColors.successColor
// // //                           : AppColors.warningColor,
// // //                     ),
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //           ),
// // //           SizedBox(height: size.customHeight(context) * 0.03),
// // //           Container(
// // //             padding: EdgeInsets.all(size.customWidth(context) * 0.04),
// // //             decoration: BoxDecoration(
// // //               color: AppColors.primaryColor.withOpacity(0.05),
// // //               borderRadius: BorderRadius.circular(15),
// // //             ),
// // //             child: Row(
// // //               children: [
// // //                 Icon(
// // //                   Icons.info_outline_rounded,
// // //                   color: AppColors.primaryColor,
// // //                   size: 20,
// // //                 ),
// // //                 SizedBox(width: size.customWidth(context) * 0.02),
// // //                 Expanded(
// // //                   child: Text(
// // //                     result.result.isTypical()
// // //                         ? 'The speech pattern appears to be within typical development range.'
// // //                         : 'The speech pattern shows some atypical characteristics. Consider consulting a speech therapist for professional assessment.',
// // //                     style: GoogleFonts.poppins(
// // //                       fontSize: size.customWidth(context) * 0.032,
// // //                       color: AppColors.textPrimaryColor,
// // //                       height: 1.4,
// // //                     ),
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildActionsSection(BuildContext context, submission) {
// // //     final size = CustomSize();

// // //     return Column(
// // //       children: [
// // //         SizedBox(
// // //           width: double.infinity,
// // //           child: ElevatedButton.icon(
// // //             onPressed: () => _showDeleteConfirmation(context),
// // //             style: ElevatedButton.styleFrom(
// // //               backgroundColor: AppColors.errorColor,
// // //               padding: EdgeInsets.symmetric(
// // //                 vertical: size.customHeight(context) * 0.018,
// // //               ),
// // //               shape: RoundedRectangleBorder(
// // //                 borderRadius: BorderRadius.circular(15),
// // //               ),
// // //             ),
// // //             icon: const Icon(Icons.delete_rounded, color: AppColors.whiteColor),
// // //             label: Text(
// // //               'Delete Submission',
// // //               style: GoogleFonts.poppins(
// // //                 color: AppColors.whiteColor,
// // //                 fontWeight: FontWeight.w600,
// // //                 fontSize: size.customWidth(context) * 0.04,
// // //               ),
// // //             ),
// // //           ),
// // //         ),
// // //       ],
// // //     );
// // //   }

// // //   void _showDeleteConfirmation(BuildContext context) {
// // //     final size = CustomSize();

// // //     Get.dialog(
// // //       AlertDialog(
// // //         shape: RoundedRectangleBorder(
// // //           borderRadius: BorderRadius.circular(20),
// // //         ),
// // //         title: Row(
// // //           children: [
// // //             Icon(Icons.warning_rounded,
// // //                 color: AppColors.errorColor, size: 28),
// // //             SizedBox(width: size.customWidth(context) * 0.02),
// // //             Text(
// // //               'Delete Submission',
// // //               style: GoogleFonts.poppins(
// // //                 fontWeight: FontWeight.bold,
// // //                 fontSize: size.customWidth(context) * 0.045,
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //         content: Text(
// // //           'Are you sure you want to delete this speech recording? This action cannot be undone.',
// // //           style: GoogleFonts.poppins(
// // //             fontSize: size.customWidth(context) * 0.038,
// // //             color: AppColors.textSecondaryColor,
// // //           ),
// // //         ),
// // //         actions: [
// // //           TextButton(
// // //             onPressed: () => Get.back(),
// // //             child: Text(
// // //               'Cancel',
// // //               style: GoogleFonts.poppins(
// // //                 color: AppColors.textSecondaryColor,
// // //                 fontWeight: FontWeight.w600,
// // //               ),
// // //             ),
// // //           ),
// // //           ElevatedButton(
// // //             onPressed: () async {
// // //               Get.back();
// // //               final success = await controller.deleteSubmission(submissionId);
// // //               if (success) {
// // //                 Get.back(); // Go back to submissions list
// // //               }
// // //             },
// // //             style: ElevatedButton.styleFrom(
// // //               backgroundColor: AppColors.errorColor,
// // //               shape: RoundedRectangleBorder(
// // //                 borderRadius: BorderRadius.circular(10),
// // //               ),
// // //             ),
// // //             child: Text(
// // //               'Delete',
// // //               style: GoogleFonts.poppins(
// // //                 color: AppColors.whiteColor,
// // //                 fontWeight: FontWeight.w600,
// // //               ),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }


// // // lib/view/speech/speech_detail_screen.dart - FIXED VERSION

// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:speechspectrum/constants/app_colors.dart';
// // import 'package:speechspectrum/constants/custom_size.dart';
// // import 'package:speechspectrum/controllers/speech_controller.dart';

// // class SpeechDetailScreen extends StatefulWidget {
// //   const SpeechDetailScreen({super.key});

// //   @override
// //   State<SpeechDetailScreen> createState() => _SpeechDetailScreenState();
// // }

// // class _SpeechDetailScreenState extends State<SpeechDetailScreen> {
// //   late final SpeechController controller;
// //   late String submissionId;

// //   @override
// //   void initState() {
// //     super.initState();
// //     submissionId = Get.arguments as String;
// //     controller = Get.put(SpeechController());

// //     // Fetch submission details
// //     WidgetsBinding.instance.addPostFrameCallback((_) {
// //       _loadSubmissionDetails();
// //     });
// //   }

// //   void _loadSubmissionDetails() {
// //     // Find in existing submissions
// //     final existing = controller.speechSubmissions.firstWhereOrNull(
// //       (s) => s.speechSubmissionId == submissionId,
// //     );

// //     if (existing != null) {
// //       controller.currentSubmission.value = existing;
// //     } else {
// //       controller.fetchSubmissionDetail(submissionId);
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final size = CustomSize();

// //     return Scaffold(
// //       backgroundColor: AppColors.lightGreyColor,
// //       body: Obx(() {
// //         if (controller.isLoadingDetail.value &&
// //             controller.currentSubmission.value == null) {
// //           return Center(
// //             child: Column(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 const CircularProgressIndicator(
// //                   color: AppColors.primaryColor,
// //                   strokeWidth: 3,
// //                 ),
// //                 SizedBox(height: size.customHeight(context) * 0.02),
// //                 Text(
// //                   'Loading details...',
// //                   style: GoogleFonts.poppins(
// //                     color: AppColors.textSecondaryColor,
// //                     fontSize: size.customWidth(context) * 0.035,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           );
// //         }

// //         final submission = controller.currentSubmission.value;
// //         if (submission == null) {
// //           return Center(
// //             child: Column(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 Icon(
// //                   Icons.error_outline_rounded,
// //                   size: 64,
// //                   color: AppColors.errorColor,
// //                 ),
// //                 SizedBox(height: size.customHeight(context) * 0.02),
// //                 Text(
// //                   'Failed to load submission',
// //                   style: GoogleFonts.poppins(
// //                     fontSize: size.customWidth(context) * 0.04,
// //                     color: AppColors.textSecondaryColor,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           );
// //         }

// //         return CustomScrollView(
// //           slivers: [
// //             _buildAppBar(context, submission),
// //             SliverToBoxAdapter(
// //               child: Padding(
// //                 padding: EdgeInsets.all(size.customWidth(context) * 0.05),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     _buildInfoCard(context, submission),
// //                     SizedBox(height: size.customHeight(context) * 0.02),
// //                     _buildResultsSection(context, submission),
// //                     SizedBox(height: size.customHeight(context) * 0.02),
// //                     _buildActionsSection(context, submission),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ],
// //         );
// //       }),
// //     );
// //   }

// //   Widget _buildAppBar(BuildContext context, submission) {
// //     final size = CustomSize();

// //     return SliverAppBar(
// //       expandedHeight: size.customHeight(context) * 0.25,
// //       pinned: true,
// //       backgroundColor: AppColors.primaryColor,
// //       flexibleSpace: FlexibleSpaceBar(
// //         background: Container(
// //           decoration: const BoxDecoration(
// //             gradient: LinearGradient(
// //               colors: [AppColors.primaryColor, AppColors.secondaryColor],
// //               begin: Alignment.topLeft,
// //               end: Alignment.bottomRight,
// //             ),
// //           ),
// //           child: SafeArea(
// //             child: Column(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 Container(
// //                   width: 70,
// //                   height: 70,
// //                   decoration: BoxDecoration(
// //                     color: AppColors.whiteColor.withOpacity(0.2),
// //                     shape: BoxShape.circle,
// //                   ),
// //                   child: Icon(
// //                     submission.hasResults()
// //                         ? Icons.check_circle_rounded
// //                         : Icons.pending_rounded,
// //                     size: 40,
// //                     color: AppColors.whiteColor,
// //                   ),
// //                 ),
// //                 SizedBox(height: size.customHeight(context) * 0.015),
// //                 Text(
// //                   'Speech Analysis',
// //                   style: GoogleFonts.poppins(
// //                     color: AppColors.whiteColor,
// //                     fontSize: size.customWidth(context) * 0.06,
// //                     fontWeight: FontWeight.bold,
// //                   ),
// //                 ),
// //                 SizedBox(height: size.customHeight(context) * 0.005),
// //                 Text(
// //                   submission.getChildName(),
// //                   style: GoogleFonts.poppins(
// //                     color: AppColors.whiteColor.withOpacity(0.9),
// //                     fontSize: size.customWidth(context) * 0.035,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //       leading: IconButton(
// //         icon: const Icon(Icons.arrow_back, color: AppColors.whiteColor),
// //         onPressed: () => Get.back(),
// //       ),
// //     );
// //   }

// //   Widget _buildInfoCard(BuildContext context, submission) {
// //     final size = CustomSize();

// //     return Container(
// //       padding: EdgeInsets.all(size.customWidth(context) * 0.04),
// //       decoration: BoxDecoration(
// //         color: AppColors.whiteColor,
// //         borderRadius: BorderRadius.circular(20),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.06),
// //             blurRadius: 15,
// //             offset: const Offset(0, 4),
// //           ),
// //         ],
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Text(
// //             'Recording Information',
// //             style: GoogleFonts.poppins(
// //               fontSize: size.customWidth(context) * 0.045,
// //               fontWeight: FontWeight.bold,
// //               color: AppColors.textPrimaryColor,
// //             ),
// //           ),
// //           SizedBox(height: size.customHeight(context) * 0.02),
// //           _buildInfoRow(
// //             context,
// //             Icons.person_rounded,
// //             'Child',
// //             submission.getChildName(),
// //           ),
// //           SizedBox(height: size.customHeight(context) * 0.015),
// //           _buildInfoRow(
// //             context,
// //             Icons.access_time_rounded,
// //             'Duration',
// //             '${submission.recordingDurationSeconds} seconds',
// //           ),
// //           SizedBox(height: size.customHeight(context) * 0.015),
// //           _buildInfoRow(
// //             context,
// //             Icons.calendar_today_outlined,
// //             'Date',
// //             submission.getFormattedDate(),
// //           ),
// //           SizedBox(height: size.customHeight(context) * 0.015),
// //           _buildInfoRow(
// //             context,
// //             Icons.schedule_rounded,
// //             'Time',
// //             submission.getFormattedTime(),
// //           ),
// //           if (submission.recordingFormat != null) ...[
// //             SizedBox(height: size.customHeight(context) * 0.015),
// //             _buildInfoRow(
// //               context,
// //               Icons.audio_file_rounded,
// //               'Format',
// //               submission.recordingFormat!.toUpperCase(),
// //             ),
// //           ],
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildInfoRow(
// //       BuildContext context, IconData icon, String label, String value) {
// //     final size = CustomSize();

// //     return Row(
// //       children: [
// //         Container(
// //           width: 40,
// //           height: 40,
// //           decoration: BoxDecoration(
// //             color: AppColors.primaryColor.withOpacity(0.1),
// //             borderRadius: BorderRadius.circular(10),
// //           ),
// //           child: Icon(icon, color: AppColors.primaryColor, size: 20),
// //         ),
// //         SizedBox(width: size.customWidth(context) * 0.03),
// //         Expanded(
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Text(
// //                 label,
// //                 style: GoogleFonts.poppins(
// //                   fontSize: size.customWidth(context) * 0.032,
// //                   color: AppColors.textSecondaryColor,
// //                 ),
// //               ),
// //               Text(
// //                 value,
// //                 style: GoogleFonts.poppins(
// //                   fontSize: size.customWidth(context) * 0.038,
// //                   fontWeight: FontWeight.w600,
// //                   color: AppColors.textPrimaryColor,
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   Widget _buildResultsSection(BuildContext context, submission) {
// //     final size = CustomSize();

// //     if (!submission.hasResults()) {
// //       return Container(
// //         padding: EdgeInsets.all(size.customWidth(context) * 0.05),
// //         decoration: BoxDecoration(
// //           color: AppColors.warningColor.withOpacity(0.1),
// //           borderRadius: BorderRadius.circular(20),
// //           border: Border.all(
// //             color: AppColors.warningColor.withOpacity(0.3),
// //           ),
// //         ),
// //         child: Column(
// //           children: [
// //             Icon(
// //               Icons.pending_rounded,
// //               size: 50,
// //               color: AppColors.warningColor,
// //             ),
// //             SizedBox(height: size.customHeight(context) * 0.02),
// //             Text(
// //               'Analysis Pending',
// //               style: GoogleFonts.poppins(
// //                 fontSize: size.customWidth(context) * 0.045,
// //                 fontWeight: FontWeight.bold,
// //                 color: AppColors.warningColor,
// //               ),
// //             ),
// //             SizedBox(height: size.customHeight(context) * 0.01),
// //             Text(
// //               'The speech analysis is being processed.\nPlease check back later.',
// //               textAlign: TextAlign.center,
// //               style: GoogleFonts.poppins(
// //                 fontSize: size.customWidth(context) * 0.035,
// //                 color: AppColors.textSecondaryColor,
// //               ),
// //             ),
// //           ],
// //         ),
// //       );
// //     }

// //     final result = submission.getLatestResult()!;
// //     final analysisResult = result.result.result;

// //     return Container(
// //       padding: EdgeInsets.all(size.customWidth(context) * 0.04),
// //       decoration: BoxDecoration(
// //         color: AppColors.whiteColor,
// //         borderRadius: BorderRadius.circular(20),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.06),
// //             blurRadius: 15,
// //             offset: const Offset(0, 4),
// //           ),
// //         ],
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Text(
// //             'Analysis Results',
// //             style: GoogleFonts.poppins(
// //               fontSize: size.customWidth(context) * 0.045,
// //               fontWeight: FontWeight.bold,
// //               color: AppColors.textPrimaryColor,
// //             ),
// //           ),
// //           SizedBox(height: size.customHeight(context) * 0.02),
// //           Center(
// //             child: Column(
// //               children: [
// //                 Container(
// //                   width: size.customWidth(context) * 0.35,
// //                   height: size.customWidth(context) * 0.35,
// //                   decoration: BoxDecoration(
// //                     shape: BoxShape.circle,
// //                     gradient: LinearGradient(
// //                       colors: analysisResult.isTypical()
// //                           ? [
// //                               AppColors.successColor.withOpacity(0.8),
// //                               AppColors.successColor
// //                             ]
// //                           : [
// //                               AppColors.warningColor.withOpacity(0.8),
// //                               AppColors.warningColor
// //                             ],
// //                       begin: Alignment.topLeft,
// //                       end: Alignment.bottomRight,
// //                     ),
// //                     boxShadow: [
// //                       BoxShadow(
// //                         color: (analysisResult.isTypical()
// //                                 ? AppColors.successColor
// //                                 : AppColors.warningColor)
// //                             .withOpacity(0.3),
// //                         blurRadius: 20,
// //                         offset: const Offset(0, 10),
// //                       ),
// //                     ],
// //                   ),
// //                   child: Column(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: [
// //                       Text(
// //                         '${analysisResult.score}',
// //                         style: GoogleFonts.poppins(
// //                           fontSize: size.customWidth(context) * 0.12,
// //                           fontWeight: FontWeight.bold,
// //                           color: AppColors.whiteColor,
// //                         ),
// //                       ),
// //                       Text(
// //                         'Score',
// //                         style: GoogleFonts.poppins(
// //                           fontSize: size.customWidth(context) * 0.035,
// //                           color: AppColors.whiteColor.withOpacity(0.9),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //                 SizedBox(height: size.customHeight(context) * 0.03),
// //                 Container(
// //                   padding: EdgeInsets.symmetric(
// //                     horizontal: size.customWidth(context) * 0.06,
// //                     vertical: size.customHeight(context) * 0.015,
// //                   ),
// //                   decoration: BoxDecoration(
// //                     color: (analysisResult.isTypical()
// //                             ? AppColors.successColor
// //                             : AppColors.warningColor)
// //                         .withOpacity(0.1),
// //                     borderRadius: BorderRadius.circular(25),
// //                     border: Border.all(
// //                       color: (analysisResult.isTypical()
// //                               ? AppColors.successColor
// //                               : AppColors.warningColor)
// //                           .withOpacity(0.3),
// //                       width: 2,
// //                     ),
// //                   ),
// //                   child: Text(
// //                     analysisResult.label,
// //                     style: GoogleFonts.poppins(
// //                       fontSize: size.customWidth(context) * 0.05,
// //                       fontWeight: FontWeight.bold,
// //                       color: analysisResult.isTypical()
// //                           ? AppColors.successColor
// //                           : AppColors.warningColor,
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           SizedBox(height: size.customHeight(context) * 0.03),
// //           Container(
// //             padding: EdgeInsets.all(size.customWidth(context) * 0.04),
// //             decoration: BoxDecoration(
// //               color: AppColors.primaryColor.withOpacity(0.05),
// //               borderRadius: BorderRadius.circular(15),
// //             ),
// //             child: Row(
// //               children: [
// //                 Icon(
// //                   Icons.info_outline_rounded,
// //                   color: AppColors.primaryColor,
// //                   size: 20,
// //                 ),
// //                 SizedBox(width: size.customWidth(context) * 0.02),
// //                 Expanded(
// //                   child: Text(
// //                     analysisResult.isTypical()
// //                         ? 'The speech pattern appears to be within typical development range.'
// //                         : 'The speech pattern shows some atypical characteristics. Consider consulting a speech therapist for professional assessment.',
// //                     style: GoogleFonts.poppins(
// //                       fontSize: size.customWidth(context) * 0.032,
// //                       color: AppColors.textPrimaryColor,
// //                       height: 1.4,
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildActionsSection(BuildContext context, submission) {
// //     final size = CustomSize();

// //     return Column(
// //       children: [
// //         SizedBox(
// //           width: double.infinity,
// //           child: ElevatedButton.icon(
// //             onPressed: () => _showDeleteConfirmation(context),
// //             style: ElevatedButton.styleFrom(
// //               backgroundColor: AppColors.errorColor,
// //               padding: EdgeInsets.symmetric(
// //                 vertical: size.customHeight(context) * 0.018,
// //               ),
// //               shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.circular(15),
// //               ),
// //             ),
// //             icon: const Icon(Icons.delete_rounded, color: AppColors.whiteColor),
// //             label: Text(
// //               'Delete Submission',
// //               style: GoogleFonts.poppins(
// //                 color: AppColors.whiteColor,
// //                 fontWeight: FontWeight.w600,
// //                 fontSize: size.customWidth(context) * 0.04,
// //               ),
// //             ),
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   void _showDeleteConfirmation(BuildContext context) {
// //     final size = CustomSize();

// //     Get.dialog(
// //       AlertDialog(
// //         shape: RoundedRectangleBorder(
// //           borderRadius: BorderRadius.circular(20),
// //         ),
// //         title: Row(
// //           children: [
// //             Icon(Icons.warning_rounded,
// //                 color: AppColors.errorColor, size: 28),
// //             SizedBox(width: size.customWidth(context) * 0.02),
// //             Text(
// //               'Delete Submission',
// //               style: GoogleFonts.poppins(
// //                 fontWeight: FontWeight.bold,
// //                 fontSize: size.customWidth(context) * 0.045,
// //               ),
// //             ),
// //           ],
// //         ),
// //         content: Text(
// //           'Are you sure you want to delete this speech recording? This action cannot be undone.',
// //           style: GoogleFonts.poppins(
// //             fontSize: size.customWidth(context) * 0.038,
// //             color: AppColors.textSecondaryColor,
// //           ),
// //         ),
// //         actions: [
// //           TextButton(
// //             onPressed: () => Get.back(),
// //             child: Text(
// //               'Cancel',
// //               style: GoogleFonts.poppins(
// //                 color: AppColors.textSecondaryColor,
// //                 fontWeight: FontWeight.w600,
// //               ),
// //             ),
// //           ),
// //           ElevatedButton(
// //             onPressed: () async {
// //               Get.back();
// //               Get.back();
// //               final success = await controller.deleteSubmission(submissionId);
// //               if (success) {
// //                 Get.back(); // Go back to submissions list
// //               }
// //             },
// //             style: ElevatedButton.styleFrom(
// //               backgroundColor: AppColors.errorColor,
// //               shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.circular(10),
// //               ),
// //             ),
// //             child: Text(
// //               'Delete',
// //               style: GoogleFonts.poppins(
// //                 color: AppColors.whiteColor,
// //                 fontWeight: FontWeight.w600,
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }


// // lib/view/speech/speech_detail_screen.dart

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/speech_controller.dart';
// import 'package:speechspectrum/models/speech_models.dart';

// class SpeechDetailScreen extends StatefulWidget {
//   const SpeechDetailScreen({super.key});

//   @override
//   State<SpeechDetailScreen> createState() => _SpeechDetailScreenState();
// }

// class _SpeechDetailScreenState extends State<SpeechDetailScreen> {
//   late final SpeechController controller;
//   late String submissionId;

//   @override
//   void initState() {
//     super.initState();
//     submissionId = Get.arguments as String;
//     controller = Get.put(SpeechController());

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _loadDetails();
//     });
//   }

//   void _loadDetails() {
//     // Try cache first, fall back to API
//     final cached = controller.speechSubmissions.firstWhereOrNull(
//       (s) => s.speechSubmissionId == submissionId,
//     );
//     if (cached != null) {
//       controller.currentSubmission.value = cached;
//     }
//     // Always re-fetch to get freshest result data
//     controller.fetchSubmissionDetail(submissionId);
//   }

//   // ── Risk colour helpers ───────────────────────────────────────────────────
//   Color _riskColor(AnalysisResult r) {
//     if (r.isHighRisk()) return AppColors.errorColor;
//     if (r.isModerateRisk()) return AppColors.warningColor;
//     return AppColors.successColor;
//   }

//   IconData _riskIcon(AnalysisResult r) {
//     if (r.isHighRisk()) return Icons.warning_rounded;
//     if (r.isModerateRisk()) return Icons.info_rounded;
//     return Icons.check_circle_rounded;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();

//     return Scaffold(
//       backgroundColor: AppColors.lightGreyColor,
//       body: Obx(() {
//         if (controller.isLoadingDetail.value &&
//             controller.currentSubmission.value == null) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const CircularProgressIndicator(
//                     color: AppColors.primaryColor, strokeWidth: 3),
//                 SizedBox(height: size.customHeight(context) * 0.02),
//                 Text('Loading details...',
//                     style: GoogleFonts.poppins(
//                         color: AppColors.textSecondaryColor,
//                         fontSize: size.customWidth(context) * 0.035)),
//               ],
//             ),
//           );
//         }

//         final submission = controller.currentSubmission.value;
//         if (submission == null) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Icon(Icons.error_outline_rounded,
//                     size: 64, color: AppColors.errorColor),
//                 SizedBox(height: size.customHeight(context) * 0.02),
//                 Text('Failed to load submission',
//                     style: GoogleFonts.poppins(
//                         fontSize: size.customWidth(context) * 0.04,
//                         color: AppColors.textSecondaryColor)),
//               ],
//             ),
//           );
//         }

//         return CustomScrollView(
//           slivers: [
//             _buildAppBar(context, submission),
//             SliverToBoxAdapter(
//               child: Padding(
//                 padding:
//                     EdgeInsets.all(size.customWidth(context) * 0.05),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _buildInfoCard(context, submission),
//                     SizedBox(height: size.customHeight(context) * 0.02),
//                     _buildResultsSection(context, submission),
//                     SizedBox(height: size.customHeight(context) * 0.02),
//                     _buildDeleteButton(context),
//                     SizedBox(height: size.customHeight(context) * 0.04),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         );
//       }),
//     );
//   }

//   // ── App Bar ───────────────────────────────────────────────────────────────
//   Widget _buildAppBar(
//       BuildContext context, SpeechSubmissionDetail submission) {
//     final size = CustomSize();
//     final hasResults = submission.hasResults();
//     final result = submission.getLatestResult()?.result;

//     return SliverAppBar(
//       expandedHeight: size.customHeight(context) * 0.25,
//       pinned: true,
//       backgroundColor: AppColors.primaryColor,
//       flexibleSpace: FlexibleSpaceBar(
//         background: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [AppColors.primaryColor, AppColors.secondaryColor],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//           child: SafeArea(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   width: 70,
//                   height: 70,
//                   decoration: BoxDecoration(
//                     color: AppColors.whiteColor.withOpacity(0.2),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(
//                     hasResults && result != null
//                         ? _riskIcon(result)
//                         : Icons.pending_rounded,
//                     size: 40,
//                     color: AppColors.whiteColor,
//                   ),
//                 ),
//                 SizedBox(height: size.customHeight(context) * 0.015),
//                 Text(
//                   'Speech Analysis',
//                   style: GoogleFonts.poppins(
//                     color: AppColors.whiteColor,
//                     fontSize: size.customWidth(context) * 0.06,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: size.customHeight(context) * 0.005),
//                 Text(
//                   submission.getChildName(),
//                   style: GoogleFonts.poppins(
//                     color: AppColors.whiteColor.withOpacity(0.9),
//                     fontSize: size.customWidth(context) * 0.035,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       leading: IconButton(
//         icon: const Icon(Icons.arrow_back, color: AppColors.whiteColor),
//         onPressed: () => Get.back(),
//       ),
//     );
//   }

//   // ── Info Card ─────────────────────────────────────────────────────────────
//   Widget _buildInfoCard(
//       BuildContext context, SpeechSubmissionDetail submission) {
//     final size = CustomSize();
//     return Container(
//       padding: EdgeInsets.all(size.customWidth(context) * 0.04),
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
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('Recording Information',
//               style: GoogleFonts.poppins(
//                   fontSize: size.customWidth(context) * 0.045,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.textPrimaryColor)),
//           SizedBox(height: size.customHeight(context) * 0.02),
//           _infoRow(context, Icons.person_rounded, 'Child',
//               submission.getChildName()),
//           SizedBox(height: size.customHeight(context) * 0.015),
//           _infoRow(context, Icons.access_time_rounded, 'Duration',
//               '${submission.recordingDurationSeconds} seconds'),
//           SizedBox(height: size.customHeight(context) * 0.015),
//           _infoRow(context, Icons.calendar_today_outlined, 'Date',
//               submission.getFormattedDate()),
//           SizedBox(height: size.customHeight(context) * 0.015),
//           _infoRow(context, Icons.schedule_rounded, 'Time',
//               submission.getFormattedTime()),
//           if (submission.recordingFormat != null) ...[
//             SizedBox(height: size.customHeight(context) * 0.015),
//             _infoRow(context, Icons.audio_file_rounded, 'Format',
//                 submission.recordingFormat!.toUpperCase()),
//           ],
//         ],
//       ),
//     );
//   }

//   Widget _infoRow(BuildContext context, IconData icon, String label,
//       String value) {
//     final size = CustomSize();
//     return Row(children: [
//       Container(
//         width: 40,
//         height: 40,
//         decoration: BoxDecoration(
//           color: AppColors.primaryColor.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Icon(icon, color: AppColors.primaryColor, size: 20),
//       ),
//       SizedBox(width: size.customWidth(context) * 0.03),
//       Expanded(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(label,
//                 style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.032,
//                     color: AppColors.textSecondaryColor)),
//             Text(value,
//                 style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.038,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.textPrimaryColor)),
//           ],
//         ),
//       ),
//     ]);
//   }

//   // ── Results Section ───────────────────────────────────────────────────────
//   Widget _buildResultsSection(
//       BuildContext context, SpeechSubmissionDetail submission) {
//     final size = CustomSize();

//     if (!submission.hasResults()) {
//       return Container(
//         padding: EdgeInsets.all(size.customWidth(context) * 0.05),
//         decoration: BoxDecoration(
//           color: AppColors.warningColor.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(
//               color: AppColors.warningColor.withOpacity(0.3)),
//         ),
//         child: Column(children: [
//           const Icon(Icons.pending_rounded,
//               size: 50, color: AppColors.warningColor),
//           SizedBox(height: size.customHeight(context) * 0.02),
//           Text('Analysis Pending',
//               style: GoogleFonts.poppins(
//                   fontSize: size.customWidth(context) * 0.045,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.warningColor)),
//           SizedBox(height: size.customHeight(context) * 0.01),
//           Text(
//             'The speech analysis is being processed.\nPlease check back later.',
//             textAlign: TextAlign.center,
//             style: GoogleFonts.poppins(
//                 fontSize: size.customWidth(context) * 0.035,
//                 color: AppColors.textSecondaryColor),
//           ),
//         ]),
//       );
//     }

//     final analysisResult = submission.getLatestResult()!.result;
//     final riskColor = _riskColor(analysisResult);

//     return Column(
//       children: [
//         // ── Score circle card ─────────────────────────────────────────
//         Container(
//           padding: EdgeInsets.all(size.customWidth(context) * 0.05),
//           decoration: BoxDecoration(
//             color: AppColors.whiteColor,
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(
//                   color: Colors.black.withOpacity(0.06),
//                   blurRadius: 15,
//                   offset: const Offset(0, 4))
//             ],
//           ),
//           child: Column(
//             children: [
//               Text('Analysis Results',
//                   style: GoogleFonts.poppins(
//                       fontSize: size.customWidth(context) * 0.045,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.textPrimaryColor)),
//               SizedBox(height: size.customHeight(context) * 0.025),

//               // Score circle
//               Center(
//                 child: Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     SizedBox(
//                       width: size.customWidth(context) * 0.42,
//                       height: size.customWidth(context) * 0.42,
//                       child: CircularProgressIndicator(
//                         value: analysisResult.severityScore /
//                             analysisResult.maxScore,
//                         strokeWidth: 10,
//                         backgroundColor:
//                             riskColor.withOpacity(0.15),
//                         valueColor:
//                             AlwaysStoppedAnimation<Color>(riskColor),
//                       ),
//                     ),
//                     Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           '${analysisResult.severityScore}',
//                           style: GoogleFonts.poppins(
//                             fontSize:
//                                 size.customWidth(context) * 0.13,
//                             fontWeight: FontWeight.bold,
//                             color: riskColor,
//                           ),
//                         ),
//                         Text(
//                           'out of ${analysisResult.maxScore}',
//                           style: GoogleFonts.poppins(
//                             fontSize:
//                                 size.customWidth(context) * 0.03,
//                             color: AppColors.textSecondaryColor,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),

//               SizedBox(height: size.customHeight(context) * 0.025),

//               // Risk label badge
//               Container(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: size.customWidth(context) * 0.06,
//                   vertical: size.customHeight(context) * 0.012,
//                 ),
//                 decoration: BoxDecoration(
//                   color: riskColor.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(25),
//                   border: Border.all(
//                       color: riskColor.withOpacity(0.4), width: 2),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(_riskIcon(analysisResult),
//                         color: riskColor, size: 20),
//                     SizedBox(
//                         width: size.customWidth(context) * 0.02),
//                     Text(
//                       analysisResult.riskInterpretation,
//                       style: GoogleFonts.poppins(
//                         fontSize: size.customWidth(context) * 0.042,
//                         fontWeight: FontWeight.bold,
//                         color: riskColor,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               SizedBox(height: size.customHeight(context) * 0.02),

//               // Interpretation text
//               Container(
//                 padding:
//                     EdgeInsets.all(size.customWidth(context) * 0.04),
//                 decoration: BoxDecoration(
//                   color: AppColors.primaryColor.withOpacity(0.05),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Row(children: [
//                   const Icon(Icons.info_outline_rounded,
//                       color: AppColors.primaryColor, size: 18),
//                   SizedBox(width: size.customWidth(context) * 0.02),
//                   Expanded(
//                     child: Text(
//                       _interpretationText(analysisResult),
//                       style: GoogleFonts.poppins(
//                         fontSize: size.customWidth(context) * 0.032,
//                         color: AppColors.textPrimaryColor,
//                         height: 1.4,
//                       ),
//                     ),
//                   ),
//                 ]),
//               ),
//             ],
//           ),
//         ),

//         SizedBox(height: size.customHeight(context) * 0.02),

//         // ── Bio-markers card ──────────────────────────────────────────
//         if (analysisResult.bioMarkers != null)
//           _buildBioMarkersCard(context, analysisResult.bioMarkers!),
//       ],
//     );
//   }

//   String _interpretationText(AnalysisResult r) {
//     if (r.isLowRisk()) {
//       return 'The speech pattern shows low-risk indicators and appears within a typical developmental range.';
//     } else if (r.isModerateRisk()) {
//       return 'The speech pattern shows moderate-risk characteristics. Consider consulting a speech therapist for a professional assessment.';
//     } else {
//       return 'The speech pattern shows high-risk indicators. We strongly recommend consulting a qualified speech therapist as soon as possible.';
//     }
//   }

//   // ── Bio-markers Card ──────────────────────────────────────────────────────
//   Widget _buildBioMarkersCard(
//       BuildContext context, BioMarkers bioMarkers) {
//     final size = CustomSize();
//     return Container(
//       padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withOpacity(0.06),
//               blurRadius: 15,
//               offset: const Offset(0, 4))
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(children: [
//             Container(
//               width: 36,
//               height: 36,
//               decoration: BoxDecoration(
//                 color: AppColors.primaryColor.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: const Icon(Icons.analytics_rounded,
//                   color: AppColors.primaryColor, size: 20),
//             ),
//             SizedBox(width: size.customWidth(context) * 0.03),
//             Text('Bio-markers',
//                 style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.042,
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.textPrimaryColor)),
//           ]),
//           SizedBox(height: size.customHeight(context) * 0.02),
//           _bioMarkerRow(
//             context,
//             label: 'Pitch Instability',
//             value: bioMarkers.pitchInstability,
//             unit: 'Hz',
//             icon: Icons.graphic_eq_rounded,
//           ),
//           SizedBox(height: size.customHeight(context) * 0.015),
//           _bioMarkerRow(
//             context,
//             label: 'Resonance Jitter F1',
//             value: bioMarkers.resonanceJitterF1,
//             unit: 'Hz',
//             icon: Icons.waves_rounded,
//           ),
//           SizedBox(height: size.customHeight(context) * 0.015),
//           _bioMarkerRow(
//             context,
//             label: 'Resonance Jitter F2',
//             value: bioMarkers.resonanceJitterF2,
//             unit: 'Hz',
//             icon: Icons.waves_rounded,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _bioMarkerRow(
//     BuildContext context, {
//     required String label,
//     required double value,
//     required String unit,
//     required IconData icon,
//   }) {
//     final size = CustomSize();
//     return Container(
//       padding: EdgeInsets.all(size.customWidth(context) * 0.035),
//       decoration: BoxDecoration(
//         color: AppColors.lightGreyColor,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(children: [
//         Icon(icon, color: AppColors.primaryColor, size: 20),
//         SizedBox(width: size.customWidth(context) * 0.03),
//         Expanded(
//           child: Text(label,
//               style: GoogleFonts.poppins(
//                   fontSize: size.customWidth(context) * 0.035,
//                   color: AppColors.textSecondaryColor)),
//         ),
//         Text(
//           '${value.toStringAsFixed(1)} $unit',
//           style: GoogleFonts.poppins(
//             fontSize: size.customWidth(context) * 0.036,
//             fontWeight: FontWeight.w600,
//             color: AppColors.textPrimaryColor,
//           ),
//         ),
//       ]),
//     );
//   }

//   // ── Delete Button ─────────────────────────────────────────────────────────
//   Widget _buildDeleteButton(BuildContext context) {
//     final size = CustomSize();
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton.icon(
//         onPressed: () => _showDeleteConfirmation(context),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: AppColors.errorColor,
//           padding: EdgeInsets.symmetric(
//               vertical: size.customHeight(context) * 0.018),
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15)),
//         ),
//         icon: const Icon(Icons.delete_rounded,
//             color: AppColors.whiteColor),
//         label: Text('Delete Submission',
//             style: GoogleFonts.poppins(
//                 color: AppColors.whiteColor,
//                 fontWeight: FontWeight.w600,
//                 fontSize: size.customWidth(context) * 0.04)),
//       ),
//     );
//   }

//   // ── Delete Dialog ─────────────────────────────────────────────────────────
//   void _showDeleteConfirmation(BuildContext context) {
//     final size = CustomSize();
//     Get.dialog(AlertDialog(
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20)),
//       title: Row(children: [
//         const Icon(Icons.warning_rounded,
//             color: AppColors.errorColor, size: 28),
//         SizedBox(width: size.customWidth(context) * 0.02),
//         Text('Delete Submission',
//             style: GoogleFonts.poppins(
//                 fontWeight: FontWeight.bold,
//                 fontSize: size.customWidth(context) * 0.045)),
//       ]),
//       content: Text(
//         'Are you sure you want to delete this speech recording? '
//         'This action cannot be undone.',
//         style: GoogleFonts.poppins(
//             fontSize: size.customWidth(context) * 0.038,
//             color: AppColors.textSecondaryColor),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Get.back(),
//           child: Text('Cancel',
//               style: GoogleFonts.poppins(
//                   color: AppColors.textSecondaryColor,
//                   fontWeight: FontWeight.w600)),
//         ),
//         ElevatedButton(
//           onPressed: () async {
//             Get.back(); // close dialog
//             final success =
//                 await controller.deleteSubmission(submissionId);
//             if (success) {
//               Get.back(); // back to list
//             }
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: AppColors.errorColor,
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10)),
//           ),
//           child: Text('Delete',
//               style: GoogleFonts.poppins(
//                   color: AppColors.whiteColor,
//                   fontWeight: FontWeight.w600)),
//         ),
//       ],
//     ));
//   }
// }

// // lib/view/speech/speech_detail_screen.dart

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/speech_controller.dart';
// import 'package:speechspectrum/models/speech_models.dart';
// import 'package:speechspectrum/routes/app_routes.dart';

// class SpeechDetailScreen extends StatefulWidget {
//   const SpeechDetailScreen({super.key});

//   @override
//   State<SpeechDetailScreen> createState() => _SpeechDetailScreenState();
// }

// class _SpeechDetailScreenState extends State<SpeechDetailScreen> {
//   // Always reuse the permanent singleton
//   final SpeechController controller = SpeechController.instance;
//   late String submissionId;

//   @override
//   void initState() {
//     super.initState();
//     submissionId = Get.arguments as String;

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _loadDetails();
//     });
//   }

//   void _loadDetails() {
//     // Try cache first — covers the case where we navigated directly from
//     // the recording screen (currentSubmission already populated by controller)
//     final cached = controller.speechSubmissions.firstWhereOrNull(
//       (s) => s.speechSubmissionId == submissionId,
//     );
//     if (cached != null) {
//       controller.currentSubmission.value = cached;
//     }
//     // If the controller already has currentSubmission with matching id,
//     // it means we just uploaded — no need to wait for the network.
//     // We still fetch in background to get the freshest result data.
//     controller.fetchSubmissionDetail(submissionId);
//   }

//   // ── Risk colour helpers ────────────────────────────────────────────────────
//   Color _riskColor(AnalysisResult r) {
//     if (r.isHighRisk()) return AppColors.errorColor;
//     if (r.isModerateRisk()) return AppColors.warningColor;
//     return AppColors.successColor;
//   }

//   IconData _riskIcon(AnalysisResult r) {
//     if (r.isHighRisk()) return Icons.warning_rounded;
//     if (r.isModerateRisk()) return Icons.info_rounded;
//     return Icons.check_circle_rounded;
//   }

//   // ─────────────────────────────────────────────────────────────────────────
//   // BUILD
//   // ─────────────────────────────────────────────────────────────────────────

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();

//     return Scaffold(
//       backgroundColor: AppColors.lightGreyColor,
//       body: Obx(() {
//         // Show spinner only when we have nothing cached yet
//         if (controller.isLoadingDetail.value &&
//             controller.currentSubmission.value == null) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const CircularProgressIndicator(
//                     color: AppColors.primaryColor, strokeWidth: 3),
//                 SizedBox(height: size.customHeight(context) * 0.02),
//                 Text('Loading details...',
//                     style: GoogleFonts.poppins(
//                         color: AppColors.textSecondaryColor,
//                         fontSize: size.customWidth(context) * 0.035)),
//               ],
//             ),
//           );
//         }

//         final submission = controller.currentSubmission.value;
//         if (submission == null) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Icon(Icons.error_outline_rounded,
//                     size: 64, color: AppColors.errorColor),
//                 SizedBox(height: size.customHeight(context) * 0.02),
//                 Text('Failed to load submission',
//                     style: GoogleFonts.poppins(
//                         fontSize: size.customWidth(context) * 0.04,
//                         color: AppColors.textSecondaryColor)),
//                 SizedBox(height: size.customHeight(context) * 0.02),
//                 ElevatedButton(
//                   onPressed: _loadDetails,
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.primaryColor),
//                   child: Text('Retry',
//                       style: GoogleFonts.poppins(
//                           color: AppColors.whiteColor,
//                           fontWeight: FontWeight.w600)),
//                 ),
//               ],
//             ),
//           );
//         }

//         return CustomScrollView(
//           slivers: [
//             _buildAppBar(context, submission),
//             SliverToBoxAdapter(
//               child: Padding(
//                 padding:
//                     EdgeInsets.all(size.customWidth(context) * 0.05),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Show subtle refresh indicator if still loading fresh data
//                     if (controller.isLoadingDetail.value)
//                       Padding(
//                         padding: EdgeInsets.only(
//                             bottom: size.customHeight(context) * 0.015),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             SizedBox(
//                               width: 14,
//                               height: 14,
//                               child: CircularProgressIndicator(
//                                 color: AppColors.primaryColor
//                                     .withOpacity(0.6),
//                                 strokeWidth: 2,
//                               ),
//                             ),
//                             SizedBox(
//                                 width: size.customWidth(context) * 0.02),
//                             Text(
//                               'Refreshing results...',
//                               style: GoogleFonts.poppins(
//                                   fontSize:
//                                       size.customWidth(context) * 0.03,
//                                   color: AppColors.textSecondaryColor),
//                             ),
//                           ],
//                         ),
//                       ),

//                     _buildInfoCard(context, submission),
//                     SizedBox(height: size.customHeight(context) * 0.02),
//                     _buildResultsSection(context, submission),
//                     SizedBox(height: size.customHeight(context) * 0.02),

//                     // ── Find Therapist button — shown when results exist ──
//                     if (submission.hasResults())
//                       _buildFindTherapistButton(context, submission),
//                     if (submission.hasResults())
//                       SizedBox(
//                           height: size.customHeight(context) * 0.015),

//                     _buildDeleteButton(context),
//                     SizedBox(height: size.customHeight(context) * 0.04),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         );
//       }),
//     );
//   }

//   // ─────────────────────────────────────────────────────────────────────────
//   // APP BAR
//   // ─────────────────────────────────────────────────────────────────────────

//   Widget _buildAppBar(
//       BuildContext context, SpeechSubmissionDetail submission) {
//     final size = CustomSize();
//     final hasResults = submission.hasResults();
//     final result = submission.getLatestResult()?.result;

//     return SliverAppBar(
//       expandedHeight: size.customHeight(context) * 0.25,
//       pinned: true,
//       backgroundColor: AppColors.primaryColor,
//       flexibleSpace: FlexibleSpaceBar(
//         background: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [AppColors.primaryColor, AppColors.secondaryColor],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//           child: SafeArea(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   width: 70,
//                   height: 70,
//                   decoration: BoxDecoration(
//                     color: AppColors.whiteColor.withOpacity(0.2),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(
//                     hasResults && result != null
//                         ? _riskIcon(result)
//                         : Icons.pending_rounded,
//                     size: 40,
//                     color: AppColors.whiteColor,
//                   ),
//                 ),
//                 SizedBox(height: size.customHeight(context) * 0.015),
//                 Text(
//                   'Speech Analysis',
//                   style: GoogleFonts.poppins(
//                     color: AppColors.whiteColor,
//                     fontSize: size.customWidth(context) * 0.06,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: size.customHeight(context) * 0.005),
//                 Text(
//                   submission.getChildName(),
//                   style: GoogleFonts.poppins(
//                     color: AppColors.whiteColor.withOpacity(0.9),
//                     fontSize: size.customWidth(context) * 0.035,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       leading: IconButton(
//         icon: const Icon(Icons.arrow_back, color: AppColors.whiteColor),
//         onPressed: () => Get.back(),
//       ),
//     );
//   }

//   // ─────────────────────────────────────────────────────────────────────────
//   // INFO CARD
//   // ─────────────────────────────────────────────────────────────────────────

//   Widget _buildInfoCard(
//       BuildContext context, SpeechSubmissionDetail submission) {
//     final size = CustomSize();
//     return Container(
//       padding: EdgeInsets.all(size.customWidth(context) * 0.04),
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
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('Recording Information',
//               style: GoogleFonts.poppins(
//                   fontSize: size.customWidth(context) * 0.045,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.textPrimaryColor)),
//           SizedBox(height: size.customHeight(context) * 0.02),
//           _infoRow(context, Icons.person_rounded, 'Child',
//               submission.getChildName()),
//           SizedBox(height: size.customHeight(context) * 0.015),
//           _infoRow(context, Icons.access_time_rounded, 'Duration',
//               '${submission.recordingDurationSeconds} seconds'),
//           SizedBox(height: size.customHeight(context) * 0.015),
//           _infoRow(context, Icons.calendar_today_outlined, 'Date',
//               submission.getFormattedDate()),
//           SizedBox(height: size.customHeight(context) * 0.015),
//           _infoRow(context, Icons.schedule_rounded, 'Time',
//               submission.getFormattedTime()),
//           if (submission.recordingFormat != null) ...[
//             SizedBox(height: size.customHeight(context) * 0.015),
//             _infoRow(context, Icons.audio_file_rounded, 'Format',
//                 submission.recordingFormat!.toUpperCase()),
//           ],
//         ],
//       ),
//     );
//   }

//   Widget _infoRow(BuildContext context, IconData icon, String label,
//       String value) {
//     final size = CustomSize();
//     return Row(children: [
//       Container(
//         width: 40,
//         height: 40,
//         decoration: BoxDecoration(
//           color: AppColors.primaryColor.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Icon(icon, color: AppColors.primaryColor, size: 20),
//       ),
//       SizedBox(width: size.customWidth(context) * 0.03),
//       Expanded(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(label,
//                 style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.032,
//                     color: AppColors.textSecondaryColor)),
//             Text(value,
//                 style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.038,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.textPrimaryColor)),
//           ],
//         ),
//       ),
//     ]);
//   }

//   // ─────────────────────────────────────────────────────────────────────────
//   // RESULTS SECTION
//   // ─────────────────────────────────────────────────────────────────────────

//   Widget _buildResultsSection(
//       BuildContext context, SpeechSubmissionDetail submission) {
//     final size = CustomSize();

//     if (!submission.hasResults()) {
//       return Container(
//         padding: EdgeInsets.all(size.customWidth(context) * 0.05),
//         decoration: BoxDecoration(
//           color: AppColors.warningColor.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(20),
//           border:
//               Border.all(color: AppColors.warningColor.withOpacity(0.3)),
//         ),
//         child: Column(children: [
//           const Icon(Icons.pending_rounded,
//               size: 50, color: AppColors.warningColor),
//           SizedBox(height: size.customHeight(context) * 0.02),
//           Text('Analysis Pending',
//               style: GoogleFonts.poppins(
//                   fontSize: size.customWidth(context) * 0.045,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.warningColor)),
//           SizedBox(height: size.customHeight(context) * 0.01),
//           Text(
//             'The speech analysis is being processed.\nPlease check back later.',
//             textAlign: TextAlign.center,
//             style: GoogleFonts.poppins(
//                 fontSize: size.customWidth(context) * 0.035,
//                 color: AppColors.textSecondaryColor),
//           ),
//         ]),
//       );
//     }

//     final analysisResult = submission.getLatestResult()!.result;
//     final riskColor = _riskColor(analysisResult);

//     return Column(
//       children: [
//         // ── Score circle card ──────────────────────────────────────────────
//         Container(
//           padding: EdgeInsets.all(size.customWidth(context) * 0.05),
//           decoration: BoxDecoration(
//             color: AppColors.whiteColor,
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(
//                   color: Colors.black.withOpacity(0.06),
//                   blurRadius: 15,
//                   offset: const Offset(0, 4))
//             ],
//           ),
//           child: Column(
//             children: [
//               Text('Analysis Results',
//                   style: GoogleFonts.poppins(
//                       fontSize: size.customWidth(context) * 0.045,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.textPrimaryColor)),
//               SizedBox(height: size.customHeight(context) * 0.025),

//               // Score circle
//               Center(
//                 child: Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     SizedBox(
//                       width: size.customWidth(context) * 0.42,
//                       height: size.customWidth(context) * 0.42,
//                       child: CircularProgressIndicator(
//                         value: analysisResult.severityScore /
//                             analysisResult.maxScore,
//                         strokeWidth: 10,
//                         backgroundColor:
//                             riskColor.withOpacity(0.15),
//                         valueColor:
//                             AlwaysStoppedAnimation<Color>(riskColor),
//                       ),
//                     ),
//                     Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           '${analysisResult.severityScore}',
//                           style: GoogleFonts.poppins(
//                             fontSize: size.customWidth(context) * 0.13,
//                             fontWeight: FontWeight.bold,
//                             color: riskColor,
//                           ),
//                         ),
//                         Text(
//                           'out of ${analysisResult.maxScore}',
//                           style: GoogleFonts.poppins(
//                             fontSize: size.customWidth(context) * 0.03,
//                             color: AppColors.textSecondaryColor,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),

//               SizedBox(height: size.customHeight(context) * 0.025),

//               // Risk label badge
//               Container(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: size.customWidth(context) * 0.06,
//                   vertical: size.customHeight(context) * 0.012,
//                 ),
//                 decoration: BoxDecoration(
//                   color: riskColor.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(25),
//                   border: Border.all(
//                       color: riskColor.withOpacity(0.4), width: 2),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(_riskIcon(analysisResult),
//                         color: riskColor, size: 20),
//                     SizedBox(width: size.customWidth(context) * 0.02),
//                     Text(
//                       analysisResult.riskInterpretation,
//                       style: GoogleFonts.poppins(
//                         fontSize: size.customWidth(context) * 0.042,
//                         fontWeight: FontWeight.bold,
//                         color: riskColor,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               SizedBox(height: size.customHeight(context) * 0.02),

//               // Interpretation text
//               Container(
//                 padding:
//                     EdgeInsets.all(size.customWidth(context) * 0.04),
//                 decoration: BoxDecoration(
//                   color: AppColors.primaryColor.withOpacity(0.05),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Row(children: [
//                   const Icon(Icons.info_outline_rounded,
//                       color: AppColors.primaryColor, size: 18),
//                   SizedBox(width: size.customWidth(context) * 0.02),
//                   Expanded(
//                     child: Text(
//                       _interpretationText(analysisResult),
//                       style: GoogleFonts.poppins(
//                         fontSize: size.customWidth(context) * 0.032,
//                         color: AppColors.textPrimaryColor,
//                         height: 1.4,
//                       ),
//                     ),
//                   ),
//                 ]),
//               ),
//             ],
//           ),
//         ),

//         SizedBox(height: size.customHeight(context) * 0.02),

//         // ── Bio-markers card ───────────────────────────────────────────────
//         if (analysisResult.bioMarkers != null)
//           _buildBioMarkersCard(context, analysisResult.bioMarkers!),
//       ],
//     );
//   }

//   String _interpretationText(AnalysisResult r) {
//     if (r.isLowRisk()) {
//       return 'The speech pattern shows low-risk indicators and appears within a typical developmental range.';
//     } else if (r.isModerateRisk()) {
//       return 'The speech pattern shows moderate-risk characteristics. Consider consulting a speech therapist for a professional assessment.';
//     } else {
//       return 'The speech pattern shows high-risk indicators. We strongly recommend consulting a qualified speech therapist as soon as possible.';
//     }
//   }

//   // ─────────────────────────────────────────────────────────────────────────
//   // BIO-MARKERS CARD
//   // ─────────────────────────────────────────────────────────────────────────

//   Widget _buildBioMarkersCard(
//       BuildContext context, BioMarkers bioMarkers) {
//     final size = CustomSize();
//     return Container(
//       padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withOpacity(0.06),
//               blurRadius: 15,
//               offset: const Offset(0, 4))
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(children: [
//             Container(
//               width: 36,
//               height: 36,
//               decoration: BoxDecoration(
//                 color: AppColors.primaryColor.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: const Icon(Icons.analytics_rounded,
//                   color: AppColors.primaryColor, size: 20),
//             ),
//             SizedBox(width: size.customWidth(context) * 0.03),
//             Text('Bio-markers',
//                 style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.042,
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.textPrimaryColor)),
//           ]),
//           SizedBox(height: size.customHeight(context) * 0.02),
//           _bioMarkerRow(
//             context,
//             label: 'Pitch Instability',
//             value: bioMarkers.pitchInstability,
//             unit: 'Hz',
//             icon: Icons.graphic_eq_rounded,
//           ),
//           SizedBox(height: size.customHeight(context) * 0.015),
//           _bioMarkerRow(
//             context,
//             label: 'Resonance Jitter F1',
//             value: bioMarkers.resonanceJitterF1,
//             unit: 'Hz',
//             icon: Icons.waves_rounded,
//           ),
//           SizedBox(height: size.customHeight(context) * 0.015),
//           _bioMarkerRow(
//             context,
//             label: 'Resonance Jitter F2',
//             value: bioMarkers.resonanceJitterF2,
//             unit: 'Hz',
//             icon: Icons.waves_rounded,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _bioMarkerRow(
//     BuildContext context, {
//     required String label,
//     required double value,
//     required String unit,
//     required IconData icon,
//   }) {
//     final size = CustomSize();
//     return Container(
//       padding: EdgeInsets.all(size.customWidth(context) * 0.035),
//       decoration: BoxDecoration(
//         color: AppColors.lightGreyColor,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(children: [
//         Icon(icon, color: AppColors.primaryColor, size: 20),
//         SizedBox(width: size.customWidth(context) * 0.03),
//         Expanded(
//           child: Text(label,
//               style: GoogleFonts.poppins(
//                   fontSize: size.customWidth(context) * 0.035,
//                   color: AppColors.textSecondaryColor)),
//         ),
//         Text(
//           '${value.toStringAsFixed(1)} $unit',
//           style: GoogleFonts.poppins(
//             fontSize: size.customWidth(context) * 0.036,
//             fontWeight: FontWeight.w600,
//             color: AppColors.textPrimaryColor,
//           ),
//         ),
//       ]),
//     );
//   }

//   // ─────────────────────────────────────────────────────────────────────────
//   // FIND THERAPIST BUTTON
//   // ─────────────────────────────────────────────────────────────────────────

//   Widget _buildFindTherapistButton(
//       BuildContext context, SpeechSubmissionDetail submission) {
//     final size = CustomSize();
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton.icon(
//         onPressed: () {
//           Get.toNamed(
//             AppRoutes.expertsList,
//             arguments: {
//               'childId': submission.childId,
//               'childName': submission.getChildName(),
//             },
//           );
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: AppColors.primaryColor,
//           padding: EdgeInsets.symmetric(
//               vertical: size.customHeight(context) * 0.018),
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15)),
//           elevation: 2,
//         ),
//         icon: const Icon(Icons.person_search_rounded,
//             color: AppColors.whiteColor),
//         label: Text(
//           'Find Therapist for Consultation',
//           style: GoogleFonts.poppins(
//               color: AppColors.whiteColor,
//               fontWeight: FontWeight.w600,
//               fontSize: size.customWidth(context) * 0.04),
//         ),
//       ),
//     );
//   }

//   // ─────────────────────────────────────────────────────────────────────────
//   // DELETE BUTTON
//   // ─────────────────────────────────────────────────────────────────────────

//   Widget _buildDeleteButton(BuildContext context) {
//     final size = CustomSize();
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton.icon(
//         onPressed: () => _showDeleteConfirmation(context),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: AppColors.errorColor,
//           padding: EdgeInsets.symmetric(
//               vertical: size.customHeight(context) * 0.018),
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15)),
//         ),
//         icon: const Icon(Icons.delete_rounded,
//             color: AppColors.whiteColor),
//         label: Text('Delete Submission',
//             style: GoogleFonts.poppins(
//                 color: AppColors.whiteColor,
//                 fontWeight: FontWeight.w600,
//                 fontSize: size.customWidth(context) * 0.04)),
//       ),
//     );
//   }

//   // ─────────────────────────────────────────────────────────────────────────
//   // DELETE DIALOG
//   // ─────────────────────────────────────────────────────────────────────────

//   void _showDeleteConfirmation(BuildContext context) {
//     final size = CustomSize();
//     Get.dialog(AlertDialog(
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20)),
//       title: Row(children: [
//         const Icon(Icons.warning_rounded,
//             color: AppColors.errorColor, size: 28),
//         SizedBox(width: size.customWidth(context) * 0.02),
//         Text('Delete Submission',
//             style: GoogleFonts.poppins(
//                 fontWeight: FontWeight.bold,
//                 fontSize: size.customWidth(context) * 0.045)),
//       ]),
//       content: Text(
//         'Are you sure you want to delete this speech recording? '
//         'This action cannot be undone.',
//         style: GoogleFonts.poppins(
//             fontSize: size.customWidth(context) * 0.038,
//             color: AppColors.textSecondaryColor),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Get.back(),
//           child: Text('Cancel',
//               style: GoogleFonts.poppins(
//                   color: AppColors.textSecondaryColor,
//                   fontWeight: FontWeight.w600)),
//         ),
//         ElevatedButton(
//           onPressed: () async {
//             Get.back(); // close dialog
//             final success =
//                 await controller.deleteSubmission(submissionId);
//             if (success) {
//               // Clear current so the detail screen doesn't show stale data
//               controller.currentSubmission.value = null;
//               // Go back to the submissions list
//               Get.back();
//             }
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: AppColors.errorColor,
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10)),
//           ),
//           child: Text('Delete',
//               style: GoogleFonts.poppins(
//                   color: AppColors.whiteColor,
//                   fontWeight: FontWeight.w600)),
//         ),
//       ],
//     ));
//   }
// }


// // lib/view/history/submission_details_screen.dart
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/history_controller.dart';
// import 'package:speechspectrum/models/questionnaire_model.dart';
// import 'package:speechspectrum/routes/app_routes.dart';
// import 'package:intl/intl.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:open_file/open_file.dart';

// class SubmissionDetailsScreen extends StatefulWidget {
//   const SubmissionDetailsScreen({super.key});

//   @override
//   State<SubmissionDetailsScreen> createState() =>
//       _SubmissionDetailsScreenState();
// }

// class _SubmissionDetailsScreenState extends State<SubmissionDetailsScreen> {
//   late final HistoryController controller;
//   final Rxn<SubmissionItem> submission = Rxn<SubmissionItem>();
//   final RxBool isLoading = false.obs;

//   late String submissionId;

//   @override
//   void initState() {
//     super.initState();
//     submissionId = Get.arguments as String;

//     if (Get.isRegistered<HistoryController>()) {
//       controller = Get.find<HistoryController>();
//     } else {
//       controller = Get.put(HistoryController());
//     }

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _fetchSubmission();
//     });
//   }

//   Future<void> _fetchSubmission() async {
//     isLoading.value = true;
//     final data = await controller.fetchSubmission(submissionId);
//     submission.value = data;
//     isLoading.value = false;
//   }

//   bool _isHighProbability(String probability) {
//     try {
//       final value = double.parse(probability.replaceAll('%', ''));
//       return value >= 30.0;
//     } catch (_) {
//       return false;
//     }
//   }

//   // ─── question label helper ───────────────────────────────────────────────
//   String _questionLabel(String key) {
//     const map = {
//       'A1': 'Does your child look at you when called?',
//       'A2': 'How easy is eye contact with your child?',
//       'A3': 'Does your child point to indicate wants?',
//       'A4': 'Does your child point to share interest?',
//       'A5': 'Does your child pretend play?',
//       'A6': 'Does your child follow where you\'re looking?',
//       'A7': 'Does your child show signs of comforting others?',
//       'A8': 'How would you describe first words?',
//       'A9': 'Does your child use simple gestures?',
//       'A10': 'Does your child stare at nothing?',
//     };
//     return map[key] ?? key;
//   }

//   // ─── PDF generation (same as questionnaire_results_screen) ───────────────
//   Future<void> _downloadPdf(BuildContext context, SubmissionItem data) async {
//     try {
//       final result = data.questionnaireResults.isNotEmpty
//           ? data.questionnaireResults.first
//           : null;
//       if (result == null) return;

//       final childName = data.children.childName;
//       final probability = result.result.probability;
//       final prediction = result.result.prediction;
//       final responses = data.responses;
//       final submittedAt = data.submittedAt;

//       final pdf = pw.Document();

//       pdf.addPage(
//         pw.MultiPage(
//           pageFormat: PdfPageFormat.a4,
//           margin: const pw.EdgeInsets.all(40),
//           build: (pw.Context ctx) => [
//             // Header
//             pw.Container(
//               padding: const pw.EdgeInsets.all(20),
//               decoration: pw.BoxDecoration(
//                 color: PdfColor.fromHex('6C63FF'),
//                 borderRadius:
//                     const pw.BorderRadius.all(pw.Radius.circular(12)),
//               ),
//               child: pw.Column(
//                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 children: [
//                   pw.Text(
//                     'ASD Screening Report',
//                     style: pw.TextStyle(
//                       fontSize: 24,
//                       fontWeight: pw.FontWeight.bold,
//                       color: PdfColors.white,
//                     ),
//                   ),
//                   pw.SizedBox(height: 6),
//                   pw.Text(
//                     'SpeechSpectrum — Confidential Assessment',
//                     style: const pw.TextStyle(
//                         fontSize: 12, color: PdfColors.white),
//                   ),
//                 ],
//               ),
//             ),
//             pw.SizedBox(height: 20),

//             // Result summary
//             pw.Container(
//               padding: const pw.EdgeInsets.all(16),
//               decoration: pw.BoxDecoration(
//                 border: pw.Border.all(color: PdfColor.fromHex('E0E0E0')),
//                 borderRadius:
//                     const pw.BorderRadius.all(pw.Radius.circular(8)),
//               ),
//               child: pw.Column(
//                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 children: [
//                   pw.Text('Screening Result',
//                       style: pw.TextStyle(
//                           fontSize: 16,
//                           fontWeight: pw.FontWeight.bold)),
//                   pw.SizedBox(height: 10),
//                   pw.Row(children: [
//                     pw.Text('Child Name: ',
//                         style: pw.TextStyle(
//                             fontWeight: pw.FontWeight.bold)),
//                     pw.Text(
//                         childName.isNotEmpty ? childName : 'N/A'),
//                   ]),
//                   pw.SizedBox(height: 4),
//                   pw.Row(children: [
//                     pw.Text('Prediction: ',
//                         style: pw.TextStyle(
//                             fontWeight: pw.FontWeight.bold)),
//                     pw.Text(prediction),
//                   ]),
//                   pw.SizedBox(height: 4),
//                   pw.Row(children: [
//                     pw.Text('Probability: ',
//                         style: pw.TextStyle(
//                             fontWeight: pw.FontWeight.bold)),
//                     pw.Text(probability),
//                   ]),
//                   pw.SizedBox(height: 4),
//                   pw.Row(children: [
//                     pw.Text('Assessment Date: ',
//                         style: pw.TextStyle(
//                             fontWeight: pw.FontWeight.bold)),
//                     pw.Text(() {
//                       try {
//                         return DateFormat('MMMM dd, yyyy')
//                             .format(DateTime.parse(submittedAt));
//                       } catch (_) {
//                         return DateFormat('MMMM dd, yyyy')
//                             .format(DateTime.now());
//                       }
//                     }()),
//                   ]),
//                 ],
//               ),
//             ),
//             pw.SizedBox(height: 20),

//             // Submission info
//             pw.Text('Submission Information',
//                 style: pw.TextStyle(
//                     fontSize: 14, fontWeight: pw.FontWeight.bold)),
//             pw.SizedBox(height: 8),
//             pw.Container(
//               padding: const pw.EdgeInsets.all(12),
//               decoration: pw.BoxDecoration(
//                 color: PdfColor.fromHex('F8F9FA'),
//                 borderRadius:
//                     const pw.BorderRadius.all(pw.Radius.circular(8)),
//               ),
//               child: pw.Column(
//                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 children: [
//                   _pdfInfoRow('Age (Months)',
//                       '${responses['Age_Mons'] ?? 'N/A'}'),
//                   _pdfInfoRow('Gender',
//                       responses['Sex'] == 1 ? 'Male' : 'Female'),
//                   _pdfInfoRow('Jaundice History',
//                       responses['Jaundice'] == 1 ? 'Yes' : 'No'),
//                   _pdfInfoRow('Family History of ASD',
//                       responses['Family_mem_with_ASD'] == 1
//                           ? 'Yes'
//                           : 'No'),
//                 ],
//               ),
//             ),
//             pw.SizedBox(height: 20),

//             // Questionnaire responses
//             pw.Text('Questionnaire Responses',
//                 style: pw.TextStyle(
//                     fontSize: 14, fontWeight: pw.FontWeight.bold)),
//             pw.SizedBox(height: 8),
//             ...[
//               'A1',
//               'A2',
//               'A3',
//               'A4',
//               'A5',
//               'A6',
//               'A7',
//               'A8',
//               'A9',
//               'A10'
//             ].map((key) {
//               final val = responses[key];
//               final isPositive = val == 1;
//               return pw.Container(
//                 margin: const pw.EdgeInsets.only(bottom: 6),
//                 padding: const pw.EdgeInsets.symmetric(
//                     horizontal: 12, vertical: 8),
//                 decoration: pw.BoxDecoration(
//                   color: isPositive
//                       ? PdfColor.fromHex('E8F5E9')
//                       : PdfColor.fromHex('FFEBEE'),
//                   borderRadius:
//                       const pw.BorderRadius.all(pw.Radius.circular(6)),
//                 ),
//                 child: pw.Row(
//                   mainAxisAlignment:
//                       pw.MainAxisAlignment.spaceBetween,
//                   children: [
//                     pw.Expanded(
//                       child: pw.Text(
//                         _questionLabel(key),
//                         style: const pw.TextStyle(fontSize: 11),
//                       ),
//                     ),
//                     pw.SizedBox(width: 10),
//                     pw.Text(
//                       isPositive ? 'Positive' : 'Negative',
//                       style: pw.TextStyle(
//                         fontSize: 11,
//                         fontWeight: pw.FontWeight.bold,
//                         color: isPositive
//                             ? PdfColor.fromHex('388E3C')
//                             : PdfColor.fromHex('D32F2F'),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             }).toList(),

//             pw.SizedBox(height: 20),
//             pw.Container(
//               padding: const pw.EdgeInsets.all(12),
//               decoration: pw.BoxDecoration(
//                 color: PdfColor.fromHex('FFF8E1'),
//                 borderRadius:
//                     const pw.BorderRadius.all(pw.Radius.circular(8)),
//               ),
//               child: pw.Text(
//                 'Disclaimer: This is a screening tool, not a diagnostic assessment. '
//                 'Professional evaluation by a qualified healthcare provider is recommended.',
//                 style: const pw.TextStyle(fontSize: 10),
//               ),
//             ),
//           ],
//         ),
//       );

//       final Uint8List bytes = await pdf.save();

//       final dir = await getApplicationDocumentsDirectory();
//       final childSafe = childName.isNotEmpty
//           ? childName.replaceAll(RegExp(r'[^\w]'), '_')
//           : 'report';
//       final file =
//           File('${dir.path}/ASD_Report_$childSafe.pdf');
//       await file.writeAsBytes(bytes);

//       await OpenFile.open(file.path);
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Could not generate PDF: $e',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: AppColors.errorColor,
//         colorText: AppColors.whiteColor,
//       );
//     }
//   }

//   pw.Widget _pdfInfoRow(String label, String value) {
//     return pw.Padding(
//       padding: const pw.EdgeInsets.only(bottom: 4),
//       child: pw.Row(children: [
//         pw.Text('$label: ',
//             style: pw.TextStyle(
//                 fontWeight: pw.FontWeight.bold, fontSize: 11)),
//         pw.Text(value, style: const pw.TextStyle(fontSize: 11)),
//       ]),
//     );
//   }

//   // ─── build ───────────────────────────────────────────────────────────────

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();

//     return Scaffold(
//       backgroundColor: AppColors.lightGreyColor,
//       appBar: AppBar(
//         backgroundColor: AppColors.whiteColor,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back,
//               color: AppColors.textPrimaryColor),
//           onPressed: () => Get.back(),
//         ),
//         title: Text(
//           'Submission Details',
//           style: GoogleFonts.poppins(
//             color: AppColors.textPrimaryColor,
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         actions: [
//           // Download PDF icon in app bar
//           Obx(() {
//             final data = submission.value;
//             if (data == null) return const SizedBox.shrink();
//             return IconButton(
//               icon: const Icon(Icons.download_outlined,
//                   color: AppColors.textPrimaryColor),
//               onPressed: () => _downloadPdf(context, data),
//               tooltip: 'Download PDF Report',
//             );
//           }),
//           IconButton(
//             icon: const Icon(Icons.delete_outline,
//                 color: AppColors.errorColor),
//             onPressed: () => _showDeleteDialog(context),
//           ),
//         ],
//       ),
//       body: Obx(() {
//         if (isLoading.value || submission.value == null) {
//           return const Center(
//             child: CircularProgressIndicator(
//               color: AppColors.primaryColor,
//             ),
//           );
//         }

//         final data = submission.value!;
//         final result = data.questionnaireResults.isNotEmpty
//             ? data.questionnaireResults.first
//             : null;

//         return SingleChildScrollView(
//           padding:
//               EdgeInsets.all(size.customWidth(context) * 0.05),
//           child: Column(
//             children: [
//               if (result != null)
//                 _buildResultCard(context, result),
//               SizedBox(
//                   height: size.customHeight(context) * 0.025),

//               // Expert recommendation (same threshold as results screen: >= 30%)
//               if (result != null &&
//                   _isHighProbability(
//                       result.result.probability)) ...[
//                 _buildExpertRecommendationCard(context, data),
//                 SizedBox(
//                     height: size.customHeight(context) * 0.025),
//               ],

//               _buildInfoCard(context, data),
//               SizedBox(
//                   height: size.customHeight(context) * 0.025),
//               _buildResponsesCard(context, data.responses),
//               SizedBox(
//                   height: size.customHeight(context) * 0.025),

//               // ── Download PDF Button (same as results screen) ──────────
//               SizedBox(
//                 width: double.infinity,
//                 height: size.customHeight(context) * 0.065,
//                 child: ElevatedButton.icon(
//                   onPressed: () => _downloadPdf(context, data),
//                   icon: const Icon(
//                       Icons.picture_as_pdf_outlined,
//                       size: 20),
//                   label: Text(
//                     'Download PDF Report',
//                     style: GoogleFonts.poppins(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.primaryColor,
//                     foregroundColor: AppColors.whiteColor,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(14),
//                     ),
//                     elevation: 0,
//                   ),
//                 ),
//               ),

//               SizedBox(
//                   height: size.customHeight(context) * 0.03),
//             ],
//           ),
//         );
//       }),
//     );
//   }

//   // ─── sub-widgets ─────────────────────────────────────────────────────────

//   Widget _buildExpertRecommendationCard(
//       BuildContext context, SubmissionItem data) {
//     final size = CustomSize();

//     return Container(
//       padding: EdgeInsets.all(size.customWidth(context) * 0.05),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             AppColors.accentColor.withOpacity(0.1),
//             AppColors.primaryColor.withOpacity(0.05),
//           ],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(
//           color: AppColors.accentColor.withOpacity(0.3),
//           width: 1.5,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       AppColors.accentColor,
//                       AppColors.primaryColor,
//                     ],
//                   ),
//                   borderRadius: BorderRadius.circular(12),
//                   boxShadow: [
//                     BoxShadow(
//                       color:
//                           AppColors.accentColor.withOpacity(0.3),
//                       blurRadius: 10,
//                       offset: const Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: const Icon(
//                   Icons.medical_services_rounded,
//                   color: AppColors.whiteColor,
//                   size: 24,
//                 ),
//               ),
//               const SizedBox(width: 15),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Expert Consultation Recommended',
//                       style: GoogleFonts.poppins(
//                         fontSize:
//                             size.customWidth(context) * 0.042,
//                         fontWeight: FontWeight.bold,
//                         color: AppColors.textPrimaryColor,
//                       ),
//                     ),
//                     SizedBox(
//                         height:
//                             size.customHeight(context) * 0.004),
//                     Text(
//                       'Consider consulting with a specialist',
//                       style: GoogleFonts.poppins(
//                         fontSize:
//                             size.customWidth(context) * 0.032,
//                         color: AppColors.textSecondaryColor,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: size.customHeight(context) * 0.02),
//           Container(
//             padding:
//                 EdgeInsets.all(size.customWidth(context) * 0.04),
//             decoration: BoxDecoration(
//               color: AppColors.whiteColor,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Text(
//               'Based on the assessment results, we recommend consulting with a qualified expert for ${data.children.childName}. Early professional guidance can be very beneficial.',
//               style: GoogleFonts.poppins(
//                 fontSize: size.customWidth(context) * 0.036,
//                 color: AppColors.textPrimaryColor,
//                 height: 1.6,
//               ),
//             ),
//           ),
//           SizedBox(height: size.customHeight(context) * 0.02),

//           // ── Single "View All Experts" button only ─────────────────
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton.icon(
//               onPressed: () {
//                 Get.toNamed(
//                   AppRoutes.expertsList,
//                   arguments: {
//                     'childId': data.childId,
//                     'childName': data.children.childName,
//                   },
//                 );
//               },
//               icon: const Icon(Icons.person_search_rounded,
//                   size: 20),
//               label: Text(
//                 'View All Experts',
//                 style: GoogleFonts.poppins(
//                   fontSize: size.customWidth(context) * 0.04,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.accentColor,
//                 foregroundColor: AppColors.whiteColor,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 padding: EdgeInsets.symmetric(
//                   vertical:
//                       size.customHeight(context) * 0.018,
//                 ),
//                 elevation: 0,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildResultCard(
//       BuildContext context, QuestionnaireResult result) {
//     final size = CustomSize();

//     return Container(
//       padding:
//           EdgeInsets.all(size.customWidth(context) * 0.06),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             result.result.getRiskColor(),
//             result.result.getRiskColor().withOpacity(0.7),
//           ],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(25),
//         boxShadow: [
//           BoxShadow(
//             color: result.result.getRiskColor().withOpacity(0.3),
//             blurRadius: 20,
//             offset: const Offset(0, 10),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               SizedBox(
//                 height: size.customHeight(context) * 0.15,
//                 width: size.customHeight(context) * 0.15,
//                 child: CircularProgressIndicator(
//                   value: double.parse(result.result.probability
//                           .replaceAll('%', '')) /
//                       100,
//                   strokeWidth: 12,
//                   backgroundColor:
//                       AppColors.whiteColor.withOpacity(0.3),
//                   valueColor:
//                       const AlwaysStoppedAnimation<Color>(
//                     AppColors.whiteColor,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                   height: size.customHeight(context) * 0.02),
//               Text(
//                 result.result.probability,
//                 style: GoogleFonts.poppins(
//                   color: AppColors.whiteColor,
//                   fontSize: 40,
//                   fontWeight: FontWeight.bold,
//                   height: 1,
//                 ),
//               ),
//               const SizedBox(height: 6),
//               Text(
//                 'probability',
//                 style: GoogleFonts.poppins(
//                   color: AppColors.whiteColor.withOpacity(0.9),
//                   fontSize: 14,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: size.customHeight(context) * 0.025),
//           Container(
//             padding: const EdgeInsets.symmetric(
//                 horizontal: 20, vertical: 8),
//             decoration: BoxDecoration(
//               color: AppColors.whiteColor.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Text(
//               result.result.prediction,
//               style: GoogleFonts.poppins(
//                 color: AppColors.whiteColor,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//                 letterSpacing: 0.5,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//           SizedBox(height: size.customHeight(context) * 0.015),
//           Text(
//             'Based on questionnaire responses and analysis',
//             style: GoogleFonts.poppins(
//               color: AppColors.whiteColor.withOpacity(0.85),
//               fontSize: 12,
//               height: 1.4,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildInfoCard(
//       BuildContext context, SubmissionItem data) {
//     final size = CustomSize();

//     return Container(
//       padding:
//           EdgeInsets.all(size.customWidth(context) * 0.05),
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color:
//                       AppColors.primaryColor.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: const Icon(Icons.info_outline,
//                     color: AppColors.primaryColor, size: 20),
//               ),
//               const SizedBox(width: 12),
//               Text(
//                 'Submission Information',
//                 style: GoogleFonts.poppins(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.textPrimaryColor,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           _buildInfoRow(context, 'Child Name',
//               data.children.childName, Icons.person_outline),
//           _buildInfoRow(
//               context,
//               'Submission Date',
//               DateFormat('MMMM dd, yyyy')
//                   .format(DateTime.parse(data.submittedAt)),
//               Icons.calendar_today_outlined),
//           _buildInfoRow(context, 'Submission Time',
//               data.getFormattedTime(),
//               Icons.access_time_outlined),
//           _buildInfoRow(
//               context,
//               'Age (Months)',
//               '${data.responses['Age_Mons'] ?? 'N/A'}',
//               Icons.cake_outlined),
//           _buildInfoRow(
//               context,
//               'Gender',
//               data.responses['Sex'] == 1 ? 'Male' : 'Female',
//               Icons.wc_outlined),
//           _buildInfoRow(
//               context,
//               'Jaundice History',
//               data.responses['Jaundice'] == 1 ? 'Yes' : 'No',
//               Icons.medical_information_outlined),
//           _buildInfoRow(
//               context,
//               'Family History of ASD',
//               data.responses['Family_mem_with_ASD'] == 1
//                   ? 'Yes'
//                   : 'No',
//               Icons.family_restroom_outlined,
//               isLast: true),
//         ],
//       ),
//     );
//   }

//   Widget _buildResponsesCard(BuildContext context,
//       Map<String, dynamic> responses) {
//     final size = CustomSize();

//     const questionKeys = [
//       'A1','A2','A3','A4','A5','A6','A7','A8','A9','A10'
//     ];

//     return Container(
//       padding:
//           EdgeInsets.all(size.customWidth(context) * 0.05),
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color:
//                       AppColors.accentColor.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: const Icon(Icons.quiz_outlined,
//                     color: AppColors.accentColor, size: 20),
//               ),
//               const SizedBox(width: 12),
//               Text(
//                 'Questionnaire Responses',
//                 style: GoogleFonts.poppins(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.textPrimaryColor,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           ...questionKeys.map((key) {
//             final val = responses[key];
//             final isPositive = val == 1;
//             return _buildResponseItem(
//               context,
//               _questionLabel(key),
//               isPositive ? 'Positive' : 'Negative',
//               isPositive,
//             );
//           }).toList(),
//         ],
//       ),
//     );
//   }

//   Widget _buildInfoRow(BuildContext context, String label,
//       String value, IconData icon,
//       {bool isLast = false}) {
//     final size = CustomSize();

//     return Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.symmetric(
//               vertical: size.customHeight(context) * 0.01),
//           child: Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color:
//                       AppColors.primaryColor.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Icon(icon,
//                     size: 20, color: AppColors.primaryColor),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       label,
//                       style: GoogleFonts.poppins(
//                         fontSize:
//                             size.customWidth(context) * 0.032,
//                         color: AppColors.textSecondaryColor,
//                       ),
//                     ),
//                     Text(
//                       value,
//                       style: GoogleFonts.poppins(
//                         fontSize:
//                             size.customWidth(context) * 0.038,
//                         fontWeight: FontWeight.w600,
//                         color: AppColors.textPrimaryColor,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         if (!isLast)
//           Divider(color: AppColors.greyColor.withOpacity(0.2)),
//       ],
//     );
//   }

//   Widget _buildResponseItem(BuildContext context,
//       String question, String answer, bool isPositive) {
//     final size = CustomSize();

//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding:
//           EdgeInsets.all(size.customWidth(context) * 0.04),
//       decoration: BoxDecoration(
//         color: isPositive
//             ? AppColors.successColor.withOpacity(0.05)
//             : AppColors.errorColor.withOpacity(0.05),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           color: isPositive
//               ? AppColors.successColor.withOpacity(0.2)
//               : AppColors.errorColor.withOpacity(0.2),
//         ),
//       ),
//       child: Row(
//         children: [
//           Icon(
//             isPositive
//                 ? Icons.check_circle_outline
//                 : Icons.cancel_outlined,
//             color: isPositive
//                 ? AppColors.successColor
//                 : AppColors.errorColor,
//             size: 24,
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   question,
//                   style: GoogleFonts.poppins(
//                     fontSize:
//                         size.customWidth(context) * 0.035,
//                     color: AppColors.textPrimaryColor,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   answer,
//                   style: GoogleFonts.poppins(
//                     fontSize:
//                         size.customWidth(context) * 0.032,
//                     fontWeight: FontWeight.w600,
//                     color: isPositive
//                         ? AppColors.successColor
//                         : AppColors.errorColor,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showDeleteDialog(BuildContext context) {
//     final size = CustomSize();

//     Get.dialog(
//       Dialog(
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(25)),
//         child: Container(
//           padding:
//               EdgeInsets.all(size.customWidth(context) * 0.05),
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
//                 child: const Icon(Icons.warning_amber_rounded,
//                     color: AppColors.errorColor, size: 45),
//               ),
//               SizedBox(
//                   height: size.customHeight(context) * 0.025),
//               Text(
//                 'Delete Submission',
//                 style: GoogleFonts.poppins(
//                   fontWeight: FontWeight.bold,
//                   fontSize: size.customWidth(context) * 0.05,
//                   color: AppColors.textPrimaryColor,
//                 ),
//               ),
//               SizedBox(
//                   height: size.customHeight(context) * 0.015),
//               Text(
//                 'Are you sure you want to delete this submission?',
//                 textAlign: TextAlign.center,
//                 style: GoogleFonts.poppins(
//                   fontSize: size.customWidth(context) * 0.038,
//                   color: AppColors.textSecondaryColor,
//                   height: 1.4,
//                 ),
//               ),
//               SizedBox(
//                   height: size.customHeight(context) * 0.01),
//               Text(
//                 'This action cannot be undone.',
//                 textAlign: TextAlign.center,
//                 style: GoogleFonts.poppins(
//                   fontSize: size.customWidth(context) * 0.034,
//                   color: AppColors.errorColor,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               SizedBox(
//                   height: size.customHeight(context) * 0.03),
//               Row(
//                 children: [
//                   Expanded(
//                     child: OutlinedButton(
//                       onPressed: () => Get.back(),
//                       style: OutlinedButton.styleFrom(
//                         padding: EdgeInsets.symmetric(
//                             vertical: size.customHeight(context) *
//                                 0.015),
//                         side: BorderSide(
//                             color: AppColors.greyColor
//                                 .withOpacity(0.5)),
//                         shape: RoundedRectangleBorder(
//                             borderRadius:
//                                 BorderRadius.circular(12)),
//                       ),
//                       child: Text('Cancel',
//                           style: GoogleFonts.poppins(
//                               color: AppColors.textSecondaryColor,
//                               fontWeight: FontWeight.w600)),
//                     ),
//                   ),
//                   SizedBox(
//                       width: size.customWidth(context) * 0.03),
//                   Expanded(
//                     child: Obx(() => ElevatedButton(
//                           onPressed: controller.isDeleting.value
//                               ? null
//                               : () {
//                                   controller
//                                       .deleteSubmission(
//                                           submissionId)
//                                       .then((_) {
//                                     if (!controller
//                                         .isDeleting.value) {
//                                       Get.back();
//                                     }
//                                   });
//                                 },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: AppColors.errorColor,
//                             padding: EdgeInsets.symmetric(
//                                 vertical:
//                                     size.customHeight(context) *
//                                         0.015),
//                             shape: RoundedRectangleBorder(
//                                 borderRadius:
//                                     BorderRadius.circular(12)),
//                           ),
//                           child: controller.isDeleting.value
//                               ? const SizedBox(
//                                   width: 20,
//                                   height: 20,
//                                   child: CircularProgressIndicator(
//                                       color: AppColors.whiteColor,
//                                       strokeWidth: 2),
//                                 )
//                               : Text('Delete',
//                                   style: GoogleFonts.poppins(
//                                       color: AppColors.whiteColor,
//                                       fontWeight:
//                                           FontWeight.w600)),
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


// lib/view/speech/speech_detail_screen.dart

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import 'package:speechspectrum/controllers/speech_controller.dart';
import 'package:speechspectrum/models/speech_models.dart';
import 'package:speechspectrum/routes/app_routes.dart';

class SpeechDetailScreen extends StatefulWidget {
  const SpeechDetailScreen({super.key});

  @override
  State<SpeechDetailScreen> createState() => _SpeechDetailScreenState();
}

class _SpeechDetailScreenState extends State<SpeechDetailScreen> {
  final SpeechController controller = SpeechController.instance;
  late String submissionId;

  @override
  void initState() {
    super.initState();
    submissionId = Get.arguments as String;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadDetails();
    });
  }

  void _loadDetails() {
    final cached = controller.speechSubmissions.firstWhereOrNull(
      (s) => s.speechSubmissionId == submissionId,
    );
    if (cached != null) {
      controller.currentSubmission.value = cached;
    }
    controller.fetchSubmissionDetail(submissionId);
  }

  // ── Risk colour helpers ───────────────────────────────────────────────────
  Color _riskColor(AnalysisResult r) {
    if (r.isHighRisk()) return AppColors.errorColor;
    if (r.isModerateRisk()) return AppColors.warningColor;
    return AppColors.successColor;
  }

  IconData _riskIcon(AnalysisResult r) {
    if (r.isHighRisk()) return Icons.warning_rounded;
    if (r.isModerateRisk()) return Icons.info_rounded;
    return Icons.check_circle_rounded;
  }

  // ── PDF generation ────────────────────────────────────────────────────────
  Future<void> _downloadPdf(
      BuildContext context, SpeechSubmissionDetail submission) async {
    try {
      final speechResult = submission.getLatestResult();
      if (speechResult == null) return;

      final analysisResult = speechResult.result;
      final childName = submission.getChildName();
      final bioMarkers = analysisResult.bioMarkers;

      String formattedDate = 'N/A';
      try {
        formattedDate = DateFormat('MMMM dd, yyyy')
            .format(DateTime.parse(submission.submittedAt));
      } catch (_) {
        formattedDate =
            DateFormat('MMMM dd, yyyy').format(DateTime.now());
      }

      final pdf = pw.Document();

      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(40),
          build: (pw.Context ctx) => [
            // ── Header ───────────────────────────────────────────────────
            pw.Container(
              padding: const pw.EdgeInsets.all(20),
              decoration: pw.BoxDecoration(
                color: PdfColor.fromHex('6C63FF'),
                borderRadius:
                    const pw.BorderRadius.all(pw.Radius.circular(12)),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'Speech Analysis Report',
                    style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.white,
                    ),
                  ),
                  pw.SizedBox(height: 6),
                  pw.Text(
                    'SpeechSpectrum — Confidential Assessment',
                    style: const pw.TextStyle(
                        fontSize: 12, color: PdfColors.white),
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 20),

            // ── Result summary ────────────────────────────────────────────
            pw.Container(
              padding: const pw.EdgeInsets.all(16),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColor.fromHex('E0E0E0')),
                borderRadius:
                    const pw.BorderRadius.all(pw.Radius.circular(8)),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('Analysis Result',
                      style: pw.TextStyle(
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold)),
                  pw.SizedBox(height: 10),
                  _pdfRow('Child Name',
                      childName.isNotEmpty ? childName : 'N/A'),
                  pw.SizedBox(height: 4),
                  _pdfRow('Risk Level', analysisResult.riskInterpretation),
                  pw.SizedBox(height: 4),
                  _pdfRow('Severity Score',
                      '${analysisResult.severityScore} / ${analysisResult.maxScore}'),
                  pw.SizedBox(height: 4),
                  _pdfRow('Assessment Date', formattedDate),
                  pw.SizedBox(height: 4),
                  _pdfRow('Duration',
                      '${submission.recordingDurationSeconds} seconds'),
                  if (submission.recordingFormat != null) ...[
                    pw.SizedBox(height: 4),
                    _pdfRow('Format',
                        submission.recordingFormat!.toUpperCase()),
                  ],
                ],
              ),
            ),
            pw.SizedBox(height: 20),

            // ── Bio-markers ───────────────────────────────────────────────
            if (bioMarkers != null) ...[
              pw.Text('Bio-markers',
                  style: pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 8),
              pw.Container(
                padding: const pw.EdgeInsets.all(12),
                decoration: pw.BoxDecoration(
                  color: PdfColor.fromHex('F8F9FA'),
                  borderRadius:
                      const pw.BorderRadius.all(pw.Radius.circular(8)),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    _pdfRow('Pitch Instability',
                        '${bioMarkers.pitchInstability.toStringAsFixed(1)} Hz'),
                    pw.SizedBox(height: 4),
                    _pdfRow('Resonance Jitter F1',
                        '${bioMarkers.resonanceJitterF1.toStringAsFixed(1)} Hz'),
                    pw.SizedBox(height: 4),
                    _pdfRow('Resonance Jitter F2',
                        '${bioMarkers.resonanceJitterF2.toStringAsFixed(1)} Hz'),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),
            ],

            // ── Interpretation ────────────────────────────────────────────
            pw.Text('Interpretation',
                style: pw.TextStyle(
                    fontSize: 14, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 8),
            pw.Container(
              padding: const pw.EdgeInsets.all(12),
              decoration: pw.BoxDecoration(
                color: PdfColor.fromHex('F8F9FA'),
                borderRadius:
                    const pw.BorderRadius.all(pw.Radius.circular(8)),
              ),
              child: pw.Text(
                _interpretationText(analysisResult),
                style: const pw.TextStyle(fontSize: 11),
              ),
            ),
            pw.SizedBox(height: 20),

            // ── Disclaimer ────────────────────────────────────────────────
            pw.Container(
              padding: const pw.EdgeInsets.all(12),
              decoration: pw.BoxDecoration(
                color: PdfColor.fromHex('FFF8E1'),
                borderRadius:
                    const pw.BorderRadius.all(pw.Radius.circular(8)),
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
      final file =
          File('${dir.path}/Speech_Report_$childSafe.pdf');
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

  pw.Widget _pdfRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 4),
      child: pw.Row(children: [
        pw.Text('$label: ',
            style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold, fontSize: 11)),
        pw.Text(value, style: const pw.TextStyle(fontSize: 11)),
      ]),
    );
  }

  String _interpretationText(AnalysisResult r) {
    if (r.isLowRisk()) {
      return 'The speech pattern shows low-risk indicators and appears within a typical developmental range.';
    } else if (r.isModerateRisk()) {
      return 'The speech pattern shows moderate-risk characteristics. Consider consulting a speech therapist for a professional assessment.';
    } else {
      return 'The speech pattern shows high-risk indicators. We strongly recommend consulting a qualified speech therapist as soon as possible.';
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // BUILD
  // ─────────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();

    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      body: Obx(() {
        if (controller.isLoadingDetail.value &&
            controller.currentSubmission.value == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(
                    color: AppColors.primaryColor, strokeWidth: 3),
                SizedBox(height: size.customHeight(context) * 0.02),
                Text('Loading details...',
                    style: GoogleFonts.poppins(
                        color: AppColors.textSecondaryColor,
                        fontSize: size.customWidth(context) * 0.035)),
              ],
            ),
          );
        }

        final submission = controller.currentSubmission.value;
        if (submission == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline_rounded,
                    size: 64, color: AppColors.errorColor),
                SizedBox(height: size.customHeight(context) * 0.02),
                Text('Failed to load submission',
                    style: GoogleFonts.poppins(
                        fontSize: size.customWidth(context) * 0.04,
                        color: AppColors.textSecondaryColor)),
                SizedBox(height: size.customHeight(context) * 0.02),
                ElevatedButton(
                  onPressed: _loadDetails,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor),
                  child: Text('Retry',
                      style: GoogleFonts.poppins(
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          );
        }

        return CustomScrollView(
          slivers: [
            _buildAppBar(context, submission),
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    EdgeInsets.all(size.customWidth(context) * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Subtle refresh indicator
                    if (controller.isLoadingDetail.value)
                      Padding(
                        padding: EdgeInsets.only(
                            bottom:
                                size.customHeight(context) * 0.015),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 14,
                              height: 14,
                              child: CircularProgressIndicator(
                                color: AppColors.primaryColor
                                    .withOpacity(0.6),
                                strokeWidth: 2,
                              ),
                            ),
                            SizedBox(
                                width:
                                    size.customWidth(context) * 0.02),
                            Text(
                              'Refreshing results...',
                              style: GoogleFonts.poppins(
                                  fontSize:
                                      size.customWidth(context) * 0.03,
                                  color: AppColors.textSecondaryColor),
                            ),
                          ],
                        ),
                      ),

                    _buildInfoCard(context, submission),
                    SizedBox(height: size.customHeight(context) * 0.02),
                    _buildResultsSection(context, submission),
                    SizedBox(height: size.customHeight(context) * 0.02),

                    // ── Find Therapist button ─────────────────────────────
                    if (submission.hasResults())
                      _buildFindTherapistButton(context, submission),
                    if (submission.hasResults())
                      SizedBox(
                          height: size.customHeight(context) * 0.015),

                    // ── Download PDF Report button ─────────────────────────
                    if (submission.hasResults())
                      _buildDownloadPdfButton(context, submission),
                    if (submission.hasResults())
                      SizedBox(
                          height: size.customHeight(context) * 0.015),

                    _buildDeleteButton(context),
                    SizedBox(height: size.customHeight(context) * 0.04),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // APP BAR
  // ─────────────────────────────────────────────────────────────────────────

  Widget _buildAppBar(
      BuildContext context, SpeechSubmissionDetail submission) {
    final size = CustomSize();
    final hasResults = submission.hasResults();
    final result = submission.getLatestResult()?.result;

    return SliverAppBar(
      expandedHeight: size.customHeight(context) * 0.25,
      pinned: true,
      backgroundColor: AppColors.primaryColor,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primaryColor, AppColors.secondaryColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    hasResults && result != null
                        ? _riskIcon(result)
                        : Icons.pending_rounded,
                    size: 40,
                    color: AppColors.whiteColor,
                  ),
                ),
                SizedBox(height: size.customHeight(context) * 0.015),
                Text(
                  'Speech Analysis',
                  style: GoogleFonts.poppins(
                    color: AppColors.whiteColor,
                    fontSize: size.customWidth(context) * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: size.customHeight(context) * 0.005),
                Text(
                  submission.getChildName(),
                  style: GoogleFonts.poppins(
                    color: AppColors.whiteColor.withOpacity(0.9),
                    fontSize: size.customWidth(context) * 0.035,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.whiteColor),
        onPressed: () => Get.back(),
      ),
      actions: [
        // Download icon in app bar (only when results exist)
        Obx(() {
          final sub = controller.currentSubmission.value;
          if (sub == null || !sub.hasResults()) {
            return const SizedBox.shrink();
          }
          return IconButton(
            icon: const Icon(Icons.download_outlined,
                color: AppColors.whiteColor),
            onPressed: () => _downloadPdf(context, sub),
            tooltip: 'Download PDF Report',
          );
        }),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // INFO CARD
  // ─────────────────────────────────────────────────────────────────────────

  Widget _buildInfoCard(
      BuildContext context, SpeechSubmissionDetail submission) {
    final size = CustomSize();
    return Container(
      padding: EdgeInsets.all(size.customWidth(context) * 0.04),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recording Information',
              style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.045,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryColor)),
          SizedBox(height: size.customHeight(context) * 0.02),
          _infoRow(context, Icons.person_rounded, 'Child',
              submission.getChildName()),
          SizedBox(height: size.customHeight(context) * 0.015),
          _infoRow(context, Icons.access_time_rounded, 'Duration',
              '${submission.recordingDurationSeconds} seconds'),
          SizedBox(height: size.customHeight(context) * 0.015),
          _infoRow(context, Icons.calendar_today_outlined, 'Date',
              submission.getFormattedDate()),
          SizedBox(height: size.customHeight(context) * 0.015),
          _infoRow(context, Icons.schedule_rounded, 'Time',
              submission.getFormattedTime()),
          if (submission.recordingFormat != null) ...[
            SizedBox(height: size.customHeight(context) * 0.015),
            _infoRow(context, Icons.audio_file_rounded, 'Format',
                submission.recordingFormat!.toUpperCase()),
          ],
        ],
      ),
    );
  }

  Widget _infoRow(BuildContext context, IconData icon, String label,
      String value) {
    final size = CustomSize();
    return Row(children: [
      Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.primaryColor, size: 20),
      ),
      SizedBox(width: size.customWidth(context) * 0.03),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: GoogleFonts.poppins(
                    fontSize: size.customWidth(context) * 0.032,
                    color: AppColors.textSecondaryColor)),
            Text(value,
                style: GoogleFonts.poppins(
                    fontSize: size.customWidth(context) * 0.038,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimaryColor)),
          ],
        ),
      ),
    ]);
  }

  // ─────────────────────────────────────────────────────────────────────────
  // RESULTS SECTION
  // ─────────────────────────────────────────────────────────────────────────

  Widget _buildResultsSection(
      BuildContext context, SpeechSubmissionDetail submission) {
    final size = CustomSize();

    if (!submission.hasResults()) {
      return Container(
        padding: EdgeInsets.all(size.customWidth(context) * 0.05),
        decoration: BoxDecoration(
          color: AppColors.warningColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border:
              Border.all(color: AppColors.warningColor.withOpacity(0.3)),
        ),
        child: Column(children: [
          const Icon(Icons.pending_rounded,
              size: 50, color: AppColors.warningColor),
          SizedBox(height: size.customHeight(context) * 0.02),
          Text('Analysis Pending',
              style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.045,
                  fontWeight: FontWeight.bold,
                  color: AppColors.warningColor)),
          SizedBox(height: size.customHeight(context) * 0.01),
          Text(
            'The speech analysis is being processed.\nPlease check back later.',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontSize: size.customWidth(context) * 0.035,
                color: AppColors.textSecondaryColor),
          ),
        ]),
      );
    }

    final analysisResult = submission.getLatestResult()!.result;
    final riskColor = _riskColor(analysisResult);

    return Column(
      children: [
        // ── Score circle card ──────────────────────────────────────────────
        Container(
          padding: EdgeInsets.all(size.customWidth(context) * 0.05),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 15,
                  offset: const Offset(0, 4))
            ],
          ),
          child: Column(
            children: [
              Text('Analysis Results',
                  style: GoogleFonts.poppins(
                      fontSize: size.customWidth(context) * 0.045,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimaryColor)),
              SizedBox(height: size.customHeight(context) * 0.025),

              // Score circle
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: size.customWidth(context) * 0.42,
                      height: size.customWidth(context) * 0.42,
                      child: CircularProgressIndicator(
                        value: analysisResult.severityScore /
                            analysisResult.maxScore,
                        strokeWidth: 10,
                        backgroundColor:
                            riskColor.withOpacity(0.15),
                        valueColor:
                            AlwaysStoppedAnimation<Color>(riskColor),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${analysisResult.severityScore}',
                          style: GoogleFonts.poppins(
                            fontSize:
                                size.customWidth(context) * 0.13,
                            fontWeight: FontWeight.bold,
                            color: riskColor,
                          ),
                        ),
                        Text(
                          'out of ${analysisResult.maxScore}',
                          style: GoogleFonts.poppins(
                            fontSize:
                                size.customWidth(context) * 0.03,
                            color: AppColors.textSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: size.customHeight(context) * 0.025),

              // Risk label badge
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: size.customWidth(context) * 0.06,
                  vertical: size.customHeight(context) * 0.012,
                ),
                decoration: BoxDecoration(
                  color: riskColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                      color: riskColor.withOpacity(0.4), width: 2),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(_riskIcon(analysisResult),
                        color: riskColor, size: 20),
                    SizedBox(width: size.customWidth(context) * 0.02),
                    Text(
                      analysisResult.riskInterpretation,
                      style: GoogleFonts.poppins(
                        fontSize: size.customWidth(context) * 0.042,
                        fontWeight: FontWeight.bold,
                        color: riskColor,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: size.customHeight(context) * 0.02),

              // Interpretation text
              Container(
                padding:
                    EdgeInsets.all(size.customWidth(context) * 0.04),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(children: [
                  const Icon(Icons.info_outline_rounded,
                      color: AppColors.primaryColor, size: 18),
                  SizedBox(width: size.customWidth(context) * 0.02),
                  Expanded(
                    child: Text(
                      _interpretationText(analysisResult),
                      style: GoogleFonts.poppins(
                        fontSize: size.customWidth(context) * 0.032,
                        color: AppColors.textPrimaryColor,
                        height: 1.4,
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),

        SizedBox(height: size.customHeight(context) * 0.02),

        // ── Bio-markers card ───────────────────────────────────────────────
        if (analysisResult.bioMarkers != null)
          _buildBioMarkersCard(context, analysisResult.bioMarkers!),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // BIO-MARKERS CARD
  // ─────────────────────────────────────────────────────────────────────────

  Widget _buildBioMarkersCard(
      BuildContext context, BioMarkers bioMarkers) {
    final size = CustomSize();
    return Container(
      padding: EdgeInsets.all(size.customWidth(context) * 0.04),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 15,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.analytics_rounded,
                  color: AppColors.primaryColor, size: 20),
            ),
            SizedBox(width: size.customWidth(context) * 0.03),
            Text('Bio-markers',
                style: GoogleFonts.poppins(
                    fontSize: size.customWidth(context) * 0.042,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimaryColor)),
          ]),
          SizedBox(height: size.customHeight(context) * 0.02),
          _bioMarkerRow(
            context,
            label: 'Pitch Instability',
            value: bioMarkers.pitchInstability,
            unit: 'Hz',
            icon: Icons.graphic_eq_rounded,
          ),
          SizedBox(height: size.customHeight(context) * 0.015),
          _bioMarkerRow(
            context,
            label: 'Resonance Jitter F1',
            value: bioMarkers.resonanceJitterF1,
            unit: 'Hz',
            icon: Icons.waves_rounded,
          ),
          SizedBox(height: size.customHeight(context) * 0.015),
          _bioMarkerRow(
            context,
            label: 'Resonance Jitter F2',
            value: bioMarkers.resonanceJitterF2,
            unit: 'Hz',
            icon: Icons.waves_rounded,
          ),
        ],
      ),
    );
  }

  Widget _bioMarkerRow(
    BuildContext context, {
    required String label,
    required double value,
    required String unit,
    required IconData icon,
  }) {
    final size = CustomSize();
    return Container(
      padding: EdgeInsets.all(size.customWidth(context) * 0.035),
      decoration: BoxDecoration(
        color: AppColors.lightGreyColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(children: [
        Icon(icon, color: AppColors.primaryColor, size: 20),
        SizedBox(width: size.customWidth(context) * 0.03),
        Expanded(
          child: Text(label,
              style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.035,
                  color: AppColors.textSecondaryColor)),
        ),
        Text(
          '${value.toStringAsFixed(1)} $unit',
          style: GoogleFonts.poppins(
            fontSize: size.customWidth(context) * 0.036,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimaryColor,
          ),
        ),
      ]),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // FIND THERAPIST BUTTON
  // ─────────────────────────────────────────────────────────────────────────

  Widget _buildFindTherapistButton(
      BuildContext context, SpeechSubmissionDetail submission) {
    final size = CustomSize();
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          Get.toNamed(
            AppRoutes.expertsList,
            arguments: {
              'childId': submission.childId,
              'childName': submission.getChildName(),
            },
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          padding: EdgeInsets.symmetric(
              vertical: size.customHeight(context) * 0.018),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)),
          elevation: 2,
        ),
        icon: const Icon(Icons.person_search_rounded,
            color: AppColors.whiteColor),
        label: Text(
          'Find Therapist for Consultation',
          style: GoogleFonts.poppins(
              color: AppColors.whiteColor,
              fontWeight: FontWeight.w600,
              fontSize: size.customWidth(context) * 0.04),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // DOWNLOAD PDF BUTTON
  // ─────────────────────────────────────────────────────────────────────────

  Widget _buildDownloadPdfButton(
      BuildContext context, SpeechSubmissionDetail submission) {
    final size = CustomSize();
    return SizedBox(
      width: double.infinity,
      height: size.customHeight(context) * 0.065,
      child: ElevatedButton.icon(
        onPressed: () => _downloadPdf(context, submission),
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
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // DELETE BUTTON
  // ─────────────────────────────────────────────────────────────────────────

  Widget _buildDeleteButton(BuildContext context) {
    final size = CustomSize();
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => _showDeleteConfirmation(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.errorColor,
          padding: EdgeInsets.symmetric(
              vertical: size.customHeight(context) * 0.018),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)),
        ),
        icon: const Icon(Icons.delete_rounded,
            color: AppColors.whiteColor),
        label: Text('Delete Submission',
            style: GoogleFonts.poppins(
                color: AppColors.whiteColor,
                fontWeight: FontWeight.w600,
                fontSize: size.customWidth(context) * 0.04)),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // DELETE DIALOG
  // ─────────────────────────────────────────────────────────────────────────

  void _showDeleteConfirmation(BuildContext context) {
    final size = CustomSize();
    Get.dialog(AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)),
      title: Row(children: [
        const Icon(Icons.warning_rounded,
            color: AppColors.errorColor, size: 28),
        SizedBox(width: size.customWidth(context) * 0.02),
        Text('Delete Submission',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: size.customWidth(context) * 0.045)),
      ]),
      content: Text(
        'Are you sure you want to delete this speech recording? '
        'This action cannot be undone.',
        style: GoogleFonts.poppins(
            fontSize: size.customWidth(context) * 0.038,
            color: AppColors.textSecondaryColor),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text('Cancel',
              style: GoogleFonts.poppins(
                  color: AppColors.textSecondaryColor,
                  fontWeight: FontWeight.w600)),
        ),
        ElevatedButton(
          onPressed: () async {
            Get.back();
            final success =
                await controller.deleteSubmission(submissionId);
            if (success) {
              controller.currentSubmission.value = null;
              Get.back();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.errorColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
          ),
          child: Text('Delete',
              style: GoogleFonts.poppins(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.w600)),
        ),
      ],
    ));
  }
}