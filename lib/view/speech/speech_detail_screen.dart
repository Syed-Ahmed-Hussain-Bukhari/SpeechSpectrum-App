// // lib/view/speech/speech_detail_screen.dart

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/speech_controller.dart';

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

//     // Fetch submission details
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _loadSubmissionDetails();
//     });
//   }

//   void _loadSubmissionDetails() {
//     // Find in existing submissions
//     final existing = controller.speechSubmissions.firstWhereOrNull(
//       (s) => s.speechSubmissionId == submissionId,
//     );

//     if (existing != null) {
//       controller.currentSubmission.value = existing;
//     } else {
//       controller.fetchSubmissionDetail(submissionId);
//     }
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
//                   color: AppColors.primaryColor,
//                   strokeWidth: 3,
//                 ),
//                 SizedBox(height: size.customHeight(context) * 0.02),
//                 Text(
//                   'Loading details...',
//                   style: GoogleFonts.poppins(
//                     color: AppColors.textSecondaryColor,
//                     fontSize: size.customWidth(context) * 0.035,
//                   ),
//                 ),
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
//                 Icon(
//                   Icons.error_outline_rounded,
//                   size: 64,
//                   color: AppColors.errorColor,
//                 ),
//                 SizedBox(height: size.customHeight(context) * 0.02),
//                 Text(
//                   'Failed to load submission',
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.04,
//                     color: AppColors.textSecondaryColor,
//                   ),
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
//                 padding: EdgeInsets.all(size.customWidth(context) * 0.05),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _buildInfoCard(context, submission),
//                     SizedBox(height: size.customHeight(context) * 0.02),
//                     _buildResultsSection(context, submission),
//                     SizedBox(height: size.customHeight(context) * 0.02),
//                     _buildActionsSection(context, submission),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         );
//       }),
//     );
//   }

//   Widget _buildAppBar(BuildContext context, submission) {
//     final size = CustomSize();

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
//                     submission.hasResults()
//                         ? Icons.check_circle_rounded
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

//   Widget _buildInfoCard(BuildContext context, submission) {
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
//           Text(
//             'Recording Information',
//             style: GoogleFonts.poppins(
//               fontSize: size.customWidth(context) * 0.045,
//               fontWeight: FontWeight.bold,
//               color: AppColors.textPrimaryColor,
//             ),
//           ),
//           SizedBox(height: size.customHeight(context) * 0.02),
//           _buildInfoRow(
//             context,
//             Icons.person_rounded,
//             'Child',
//             submission.getChildName(),
//           ),
//           SizedBox(height: size.customHeight(context) * 0.015),
//           _buildInfoRow(
//             context,
//             Icons.access_time_rounded,
//             'Duration',
//             '${submission.recordingDurationSeconds} seconds',
//           ),
//           SizedBox(height: size.customHeight(context) * 0.015),
//           _buildInfoRow(
//             context,
//             Icons.calendar_today_outlined,
//             'Date',
//             submission.getFormattedDate(),
//           ),
//           SizedBox(height: size.customHeight(context) * 0.015),
//           _buildInfoRow(
//             context,
//             Icons.schedule_rounded,
//             'Time',
//             submission.getFormattedTime(),
//           ),
//           if (submission.recordingFormat != null) ...[
//             SizedBox(height: size.customHeight(context) * 0.015),
//             _buildInfoRow(
//               context,
//               Icons.audio_file_rounded,
//               'Format',
//               submission.recordingFormat!.toUpperCase(),
//             ),
//           ],
//         ],
//       ),
//     );
//   }

//   Widget _buildInfoRow(
//       BuildContext context, IconData icon, String label, String value) {
//     final size = CustomSize();

//     return Row(
//       children: [
//         Container(
//           width: 40,
//           height: 40,
//           decoration: BoxDecoration(
//             color: AppColors.primaryColor.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Icon(icon, color: AppColors.primaryColor, size: 20),
//         ),
//         SizedBox(width: size.customWidth(context) * 0.03),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 label,
//                 style: GoogleFonts.poppins(
//                   fontSize: size.customWidth(context) * 0.032,
//                   color: AppColors.textSecondaryColor,
//                 ),
//               ),
//               Text(
//                 value,
//                 style: GoogleFonts.poppins(
//                   fontSize: size.customWidth(context) * 0.038,
//                   fontWeight: FontWeight.w600,
//                   color: AppColors.textPrimaryColor,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildResultsSection(BuildContext context, submission) {
//     final size = CustomSize();

//     if (!submission.hasResults()) {
//       return Container(
//         padding: EdgeInsets.all(size.customWidth(context) * 0.05),
//         decoration: BoxDecoration(
//           color: AppColors.warningColor.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(
//             color: AppColors.warningColor.withOpacity(0.3),
//           ),
//         ),
//         child: Column(
//           children: [
//             Icon(
//               Icons.pending_rounded,
//               size: 50,
//               color: AppColors.warningColor,
//             ),
//             SizedBox(height: size.customHeight(context) * 0.02),
//             Text(
//               'Analysis Pending',
//               style: GoogleFonts.poppins(
//                 fontSize: size.customWidth(context) * 0.045,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.warningColor,
//               ),
//             ),
//             SizedBox(height: size.customHeight(context) * 0.01),
//             Text(
//               'The speech analysis is being processed.\nPlease check back later.',
//               textAlign: TextAlign.center,
//               style: GoogleFonts.poppins(
//                 fontSize: size.customWidth(context) * 0.035,
//                 color: AppColors.textSecondaryColor,
//               ),
//             ),
//           ],
//         ),
//       );
//     }

//     final result = submission.getLatestResult()!;

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
//           Text(
//             'Analysis Results',
//             style: GoogleFonts.poppins(
//               fontSize: size.customWidth(context) * 0.045,
//               fontWeight: FontWeight.bold,
//               color: AppColors.textPrimaryColor,
//             ),
//           ),
//           SizedBox(height: size.customHeight(context) * 0.02),
//           Center(
//             child: Column(
//               children: [
//                 Container(
//                   width: size.customWidth(context) * 0.35,
//                   height: size.customWidth(context) * 0.35,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     gradient: LinearGradient(
//                       colors: result.result.isTypical()
//                           ? [
//                               AppColors.successColor.withOpacity(0.8),
//                               AppColors.successColor
//                             ]
//                           : [
//                               AppColors.warningColor.withOpacity(0.8),
//                               AppColors.warningColor
//                             ],
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         color: (result.result.isTypical()
//                                 ? AppColors.successColor
//                                 : AppColors.warningColor)
//                             .withOpacity(0.3),
//                         blurRadius: 20,
//                         offset: const Offset(0, 10),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         '${result.result.score}',
//                         style: GoogleFonts.poppins(
//                           fontSize: size.customWidth(context) * 0.12,
//                           fontWeight: FontWeight.bold,
//                           color: AppColors.whiteColor,
//                         ),
//                       ),
//                       Text(
//                         'Score',
//                         style: GoogleFonts.poppins(
//                           fontSize: size.customWidth(context) * 0.035,
//                           color: AppColors.whiteColor.withOpacity(0.9),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: size.customHeight(context) * 0.03),
//                 Container(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: size.customWidth(context) * 0.06,
//                     vertical: size.customHeight(context) * 0.015,
//                   ),
//                   decoration: BoxDecoration(
//                     color: (result.result.isTypical()
//                             ? AppColors.successColor
//                             : AppColors.warningColor)
//                         .withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(25),
//                     border: Border.all(
//                       color: (result.result.isTypical()
//                               ? AppColors.successColor
//                               : AppColors.warningColor)
//                           .withOpacity(0.3),
//                       width: 2,
//                     ),
//                   ),
//                   child: Text(
//                     result.result.label,
//                     style: GoogleFonts.poppins(
//                       fontSize: size.customWidth(context) * 0.05,
//                       fontWeight: FontWeight.bold,
//                       color: result.result.isTypical()
//                           ? AppColors.successColor
//                           : AppColors.warningColor,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: size.customHeight(context) * 0.03),
//           Container(
//             padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//             decoration: BoxDecoration(
//               color: AppColors.primaryColor.withOpacity(0.05),
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: Row(
//               children: [
//                 Icon(
//                   Icons.info_outline_rounded,
//                   color: AppColors.primaryColor,
//                   size: 20,
//                 ),
//                 SizedBox(width: size.customWidth(context) * 0.02),
//                 Expanded(
//                   child: Text(
//                     result.result.isTypical()
//                         ? 'The speech pattern appears to be within typical development range.'
//                         : 'The speech pattern shows some atypical characteristics. Consider consulting a speech therapist for professional assessment.',
//                     style: GoogleFonts.poppins(
//                       fontSize: size.customWidth(context) * 0.032,
//                       color: AppColors.textPrimaryColor,
//                       height: 1.4,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildActionsSection(BuildContext context, submission) {
//     final size = CustomSize();

//     return Column(
//       children: [
//         SizedBox(
//           width: double.infinity,
//           child: ElevatedButton.icon(
//             onPressed: () => _showDeleteConfirmation(context),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: AppColors.errorColor,
//               padding: EdgeInsets.symmetric(
//                 vertical: size.customHeight(context) * 0.018,
//               ),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//             ),
//             icon: const Icon(Icons.delete_rounded, color: AppColors.whiteColor),
//             label: Text(
//               'Delete Submission',
//               style: GoogleFonts.poppins(
//                 color: AppColors.whiteColor,
//                 fontWeight: FontWeight.w600,
//                 fontSize: size.customWidth(context) * 0.04,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   void _showDeleteConfirmation(BuildContext context) {
//     final size = CustomSize();

//     Get.dialog(
//       AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         title: Row(
//           children: [
//             Icon(Icons.warning_rounded,
//                 color: AppColors.errorColor, size: 28),
//             SizedBox(width: size.customWidth(context) * 0.02),
//             Text(
//               'Delete Submission',
//               style: GoogleFonts.poppins(
//                 fontWeight: FontWeight.bold,
//                 fontSize: size.customWidth(context) * 0.045,
//               ),
//             ),
//           ],
//         ),
//         content: Text(
//           'Are you sure you want to delete this speech recording? This action cannot be undone.',
//           style: GoogleFonts.poppins(
//             fontSize: size.customWidth(context) * 0.038,
//             color: AppColors.textSecondaryColor,
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Get.back(),
//             child: Text(
//               'Cancel',
//               style: GoogleFonts.poppins(
//                 color: AppColors.textSecondaryColor,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               Get.back();
//               final success = await controller.deleteSubmission(submissionId);
//               if (success) {
//                 Get.back(); // Go back to submissions list
//               }
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: AppColors.errorColor,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//             child: Text(
//               'Delete',
//               style: GoogleFonts.poppins(
//                 color: AppColors.whiteColor,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// lib/view/speech/speech_detail_screen.dart - FIXED VERSION

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import 'package:speechspectrum/controllers/speech_controller.dart';

class SpeechDetailScreen extends StatefulWidget {
  const SpeechDetailScreen({super.key});

  @override
  State<SpeechDetailScreen> createState() => _SpeechDetailScreenState();
}

class _SpeechDetailScreenState extends State<SpeechDetailScreen> {
  late final SpeechController controller;
  late String submissionId;

  @override
  void initState() {
    super.initState();
    submissionId = Get.arguments as String;
    controller = Get.put(SpeechController());

    // Fetch submission details
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadSubmissionDetails();
    });
  }

  void _loadSubmissionDetails() {
    // Find in existing submissions
    final existing = controller.speechSubmissions.firstWhereOrNull(
      (s) => s.speechSubmissionId == submissionId,
    );

    if (existing != null) {
      controller.currentSubmission.value = existing;
    } else {
      controller.fetchSubmissionDetail(submissionId);
    }
  }

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
                  color: AppColors.primaryColor,
                  strokeWidth: 3,
                ),
                SizedBox(height: size.customHeight(context) * 0.02),
                Text(
                  'Loading details...',
                  style: GoogleFonts.poppins(
                    color: AppColors.textSecondaryColor,
                    fontSize: size.customWidth(context) * 0.035,
                  ),
                ),
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
                Icon(
                  Icons.error_outline_rounded,
                  size: 64,
                  color: AppColors.errorColor,
                ),
                SizedBox(height: size.customHeight(context) * 0.02),
                Text(
                  'Failed to load submission',
                  style: GoogleFonts.poppins(
                    fontSize: size.customWidth(context) * 0.04,
                    color: AppColors.textSecondaryColor,
                  ),
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
                padding: EdgeInsets.all(size.customWidth(context) * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoCard(context, submission),
                    SizedBox(height: size.customHeight(context) * 0.02),
                    _buildResultsSection(context, submission),
                    SizedBox(height: size.customHeight(context) * 0.02),
                    _buildActionsSection(context, submission),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildAppBar(BuildContext context, submission) {
    final size = CustomSize();

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
                    submission.hasResults()
                        ? Icons.check_circle_rounded
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
    );
  }

  Widget _buildInfoCard(BuildContext context, submission) {
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
          Text(
            'Recording Information',
            style: GoogleFonts.poppins(
              fontSize: size.customWidth(context) * 0.045,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimaryColor,
            ),
          ),
          SizedBox(height: size.customHeight(context) * 0.02),
          _buildInfoRow(
            context,
            Icons.person_rounded,
            'Child',
            submission.getChildName(),
          ),
          SizedBox(height: size.customHeight(context) * 0.015),
          _buildInfoRow(
            context,
            Icons.access_time_rounded,
            'Duration',
            '${submission.recordingDurationSeconds} seconds',
          ),
          SizedBox(height: size.customHeight(context) * 0.015),
          _buildInfoRow(
            context,
            Icons.calendar_today_outlined,
            'Date',
            submission.getFormattedDate(),
          ),
          SizedBox(height: size.customHeight(context) * 0.015),
          _buildInfoRow(
            context,
            Icons.schedule_rounded,
            'Time',
            submission.getFormattedTime(),
          ),
          if (submission.recordingFormat != null) ...[
            SizedBox(height: size.customHeight(context) * 0.015),
            _buildInfoRow(
              context,
              Icons.audio_file_rounded,
              'Format',
              submission.recordingFormat!.toUpperCase(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(
      BuildContext context, IconData icon, String label, String value) {
    final size = CustomSize();

    return Row(
      children: [
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
    );
  }

  Widget _buildResultsSection(BuildContext context, submission) {
    final size = CustomSize();

    if (!submission.hasResults()) {
      return Container(
        padding: EdgeInsets.all(size.customWidth(context) * 0.05),
        decoration: BoxDecoration(
          color: AppColors.warningColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.warningColor.withOpacity(0.3),
          ),
        ),
        child: Column(
          children: [
            Icon(
              Icons.pending_rounded,
              size: 50,
              color: AppColors.warningColor,
            ),
            SizedBox(height: size.customHeight(context) * 0.02),
            Text(
              'Analysis Pending',
              style: GoogleFonts.poppins(
                fontSize: size.customWidth(context) * 0.045,
                fontWeight: FontWeight.bold,
                color: AppColors.warningColor,
              ),
            ),
            SizedBox(height: size.customHeight(context) * 0.01),
            Text(
              'The speech analysis is being processed.\nPlease check back later.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: size.customWidth(context) * 0.035,
                color: AppColors.textSecondaryColor,
              ),
            ),
          ],
        ),
      );
    }

    final result = submission.getLatestResult()!;
    final analysisResult = result.result.result;

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
          Text(
            'Analysis Results',
            style: GoogleFonts.poppins(
              fontSize: size.customWidth(context) * 0.045,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimaryColor,
            ),
          ),
          SizedBox(height: size.customHeight(context) * 0.02),
          Center(
            child: Column(
              children: [
                Container(
                  width: size.customWidth(context) * 0.35,
                  height: size.customWidth(context) * 0.35,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: analysisResult.isTypical()
                          ? [
                              AppColors.successColor.withOpacity(0.8),
                              AppColors.successColor
                            ]
                          : [
                              AppColors.warningColor.withOpacity(0.8),
                              AppColors.warningColor
                            ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: (analysisResult.isTypical()
                                ? AppColors.successColor
                                : AppColors.warningColor)
                            .withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${analysisResult.score}',
                        style: GoogleFonts.poppins(
                          fontSize: size.customWidth(context) * 0.12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.whiteColor,
                        ),
                      ),
                      Text(
                        'Score',
                        style: GoogleFonts.poppins(
                          fontSize: size.customWidth(context) * 0.035,
                          color: AppColors.whiteColor.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.customHeight(context) * 0.03),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.customWidth(context) * 0.06,
                    vertical: size.customHeight(context) * 0.015,
                  ),
                  decoration: BoxDecoration(
                    color: (analysisResult.isTypical()
                            ? AppColors.successColor
                            : AppColors.warningColor)
                        .withOpacity(0.1),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: (analysisResult.isTypical()
                              ? AppColors.successColor
                              : AppColors.warningColor)
                          .withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: Text(
                    analysisResult.label,
                    style: GoogleFonts.poppins(
                      fontSize: size.customWidth(context) * 0.05,
                      fontWeight: FontWeight.bold,
                      color: analysisResult.isTypical()
                          ? AppColors.successColor
                          : AppColors.warningColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: size.customHeight(context) * 0.03),
          Container(
            padding: EdgeInsets.all(size.customWidth(context) * 0.04),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  color: AppColors.primaryColor,
                  size: 20,
                ),
                SizedBox(width: size.customWidth(context) * 0.02),
                Expanded(
                  child: Text(
                    analysisResult.isTypical()
                        ? 'The speech pattern appears to be within typical development range.'
                        : 'The speech pattern shows some atypical characteristics. Consider consulting a speech therapist for professional assessment.',
                    style: GoogleFonts.poppins(
                      fontSize: size.customWidth(context) * 0.032,
                      color: AppColors.textPrimaryColor,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionsSection(BuildContext context, submission) {
    final size = CustomSize();

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => _showDeleteConfirmation(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.errorColor,
              padding: EdgeInsets.symmetric(
                vertical: size.customHeight(context) * 0.018,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            icon: const Icon(Icons.delete_rounded, color: AppColors.whiteColor),
            label: Text(
              'Delete Submission',
              style: GoogleFonts.poppins(
                color: AppColors.whiteColor,
                fontWeight: FontWeight.w600,
                fontSize: size.customWidth(context) * 0.04,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    final size = CustomSize();

    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: [
            Icon(Icons.warning_rounded,
                color: AppColors.errorColor, size: 28),
            SizedBox(width: size.customWidth(context) * 0.02),
            Text(
              'Delete Submission',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: size.customWidth(context) * 0.045,
              ),
            ),
          ],
        ),
        content: Text(
          'Are you sure you want to delete this speech recording? This action cannot be undone.',
          style: GoogleFonts.poppins(
            fontSize: size.customWidth(context) * 0.038,
            color: AppColors.textSecondaryColor,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(
                color: AppColors.textSecondaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Get.back();
              Get.back();
              final success = await controller.deleteSubmission(submissionId);
              if (success) {
                Get.back(); // Go back to submissions list
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.errorColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'Delete',
              style: GoogleFonts.poppins(
                color: AppColors.whiteColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}