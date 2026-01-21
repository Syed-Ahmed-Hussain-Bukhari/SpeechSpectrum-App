// // lib/view/history/submission_details_screen.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/history_controller.dart';
// import 'package:speechspectrum/models/questionnaire_model.dart';
// import 'package:intl/intl.dart';

// class SubmissionDetailsScreen extends StatefulWidget {
//   const SubmissionDetailsScreen({super.key});

//   @override
//   State<SubmissionDetailsScreen> createState() =>
//       _SubmissionDetailsScreenState();
// }

// class _SubmissionDetailsScreenState extends State<SubmissionDetailsScreen> {
//   final controller = Get.find<HistoryController>();
//   final Rxn<SubmissionItem> submission = Rxn<SubmissionItem>();

//   late String submissionId;

//   @override
//   void initState() {
//     super.initState();
//     submissionId = Get.arguments as String;
//     _fetchSubmission();
//   }

//   Future<void> _fetchSubmission() async {
//     final data = await controller.fetchSubmission(submissionId);
//     submission.value = data;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();

//     return Scaffold(
//       backgroundColor: AppColors.lightGreyColor,
//       appBar: AppBar(
//         backgroundColor: AppColors.whiteColor,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: AppColors.textPrimaryColor),
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
//           IconButton(
//             icon: Icon(Icons.delete_outline, color: AppColors.errorColor),
//             onPressed: () => _showDeleteDialog(context),
//           ),
//         ],
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value || submission.value == null) {
//           return Center(
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
//           padding: EdgeInsets.all(size.customWidth(context) * 0.05),
//           child: Column(
//             children: [
//               // Header Card with Result
//               if (result != null) _buildResultCard(context, result),

//               SizedBox(height: size.customHeight(context) * 0.025),

//               // Submission Info
//               _buildInfoCard(context, data),

//               SizedBox(height: size.customHeight(context) * 0.025),

//               // Responses Details
//               _buildResponsesCard(context, data.responses),

//               SizedBox(height: size.customHeight(context) * 0.03),
//             ],
//           ),
//         );
//       }),
//     );
//   }

//   Widget _buildResultCard(BuildContext context, QuestionnaireResult result) {
//     final size = CustomSize();

//     return Container(
//       padding: EdgeInsets.all(size.customWidth(context) * 0.06),
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
//             offset: Offset(0, 10),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Stack(
//             alignment: Alignment.center,
//             children: [
//               SizedBox(
//                 height: size.customHeight(context) * 0.18,
//                 width: size.customHeight(context) * 0.18,
//                 child: CircularProgressIndicator(
//                   value: double.parse(
//                           result.result.probability.replaceAll('%', '')) /
//                       100,
//                   strokeWidth: 12,
//                   backgroundColor: AppColors.whiteColor.withOpacity(0.3),
//                   valueColor:
//                       AlwaysStoppedAnimation<Color>(AppColors.whiteColor),
//                 ),
//               ),
//               Column(
//                 children: [
//                   Text(
//                     result.result.probability,
//                     style: GoogleFonts.poppins(
//                       color: AppColors.whiteColor,
//                       fontSize: 56,
//                       fontWeight: FontWeight.bold,
//                       height: 1,
//                     ),
//                   ),
//                   Text(
//                     'probability',
//                     style: GoogleFonts.poppins(
//                       color: AppColors.whiteColor.withOpacity(0.9),
//                       fontSize: 14,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           SizedBox(height: size.customHeight(context) * 0.025),
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
//         ],
//       ),
//     );
//   }

//   Widget _buildInfoCard(BuildContext context, SubmissionItem data) {
//     final size = CustomSize();

//     return Container(
//       padding: EdgeInsets.all(size.customWidth(context) * 0.05),
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
//                 padding: EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: AppColors.primaryColor.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Icon(Icons.info_outline,
//                     color: AppColors.primaryColor, size: 20),
//               ),
//               SizedBox(width: 12),
//               Text(
//                 'Submission Information',
//                 style: GoogleFonts.poppins(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.textPrimaryColor,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 20),
//           _buildInfoRow(
//             context,
//             'Child Name',
//             data.children.childName,
//             Icons.person_outline,
//           ),
//           _buildInfoRow(
//             context,
//             'Submission Date',
//             DateFormat('MMMM dd, yyyy').format(DateTime.parse(data.submittedAt)),
//             Icons.calendar_today_outlined,
//           ),
//           _buildInfoRow(
//             context,
//             'Submission Time',
//             data.getFormattedTime(),
//             Icons.access_time_outlined,
//           ),
//           _buildInfoRow(
//             context,
//             'Age (Months)',
//             '${data.responses['Age_Mons'] ?? 'N/A'}',
//             Icons.cake_outlined,
//           ),
//           _buildInfoRow(
//             context,
//             'Gender',
//             data.responses['Sex'] == 1 ? 'Male' : 'Female',
//             Icons.wc_outlined,
//           ),
//           _buildInfoRow(
//             context,
//             'Jaundice History',
//             data.responses['Jaundice'] == 1 ? 'Yes' : 'No',
//             Icons.medical_information_outlined,
//           ),
//           _buildInfoRow(
//             context,
//             'Family History of ASD',
//             data.responses['Family_mem_with_ASD'] == 1 ? 'Yes' : 'No',
//             Icons.family_restroom_outlined,
//             isLast: true,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildResponsesCard(BuildContext context, Map<String, dynamic> responses) {
//     final size = CustomSize();

//     final questions = {
//       'A1': 'Does your child look at you when you call their name?',
//       'A2': 'How easy is it for you to get eye contact?',
//       'A3': 'Does your child point to indicate wants?',
//       'A4': 'Does your child point to share interest?',
//       'A5': 'Does your child pretend?',
//       'A6': 'Does your child follow where you\'re looking?',
//       'A7': 'Does your child show signs of wanting to comfort?',
//       'A8': 'How would you describe first words?',
//       'A9': 'Does your child use simple gestures?',
//       'A10': 'Does your child stare at nothing?',
//     };

//     return Container(
//       padding: EdgeInsets.all(size.customWidth(context) * 0.05),
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
//                 padding: EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: AppColors.accentColor.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Icon(Icons.quiz_outlined,
//                     color: AppColors.accentColor, size: 20),
//               ),
//               SizedBox(width: 12),
//               Text(
//                 'Questionnaire Responses',
//                 style: GoogleFonts.poppins(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.textPrimaryColor,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 16),
//           ...questions.entries.map((entry) {
//             final value = responses[entry.key];
//             return _buildResponseItem(
//               context,
//               entry.value,
//               value == 1 ? 'Positive' : 'Negative',
//               value == 1,
//             );
//           }).toList(),
//         ],
//       ),
//     );
//   }

//   Widget _buildInfoRow(
//     BuildContext context,
//     String label,
//     String value,
//     IconData icon, {
//     bool isLast = false,
//   }) {
//     final size = CustomSize();

//     return Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.symmetric(vertical: size.customHeight(context) * 0.01),
//           child: Row(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: AppColors.primaryColor.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Icon(icon, size: 20, color: AppColors.primaryColor),
//               ),
//               SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       label,
//                       style: GoogleFonts.poppins(
//                         fontSize: size.customWidth(context) * 0.032,
//                         color: AppColors.textSecondaryColor,
//                       ),
//                     ),
//                     Text(
//                       value,
//                       style: GoogleFonts.poppins(
//                         fontSize: size.customWidth(context) * 0.038,
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
//         if (!isLast) Divider(color: AppColors.greyColor.withOpacity(0.2)),
//       ],
//     );
//   }

//   Widget _buildResponseItem(
//     BuildContext context,
//     String question,
//     String answer,
//     bool isPositive,
//   ) {
//     final size = CustomSize();

//     return Container(
//       margin: EdgeInsets.only(bottom: 12),
//       padding: EdgeInsets.all(size.customWidth(context) * 0.04),
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
//             isPositive ? Icons.check_circle_outline : Icons.cancel_outlined,
//             color: isPositive ? AppColors.successColor : AppColors.errorColor,
//             size: 24,
//           ),
//           SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   question,
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.035,
//                     color: AppColors.textPrimaryColor,
//                   ),
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   answer,
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.032,
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
//           borderRadius: BorderRadius.circular(25),
//         ),
//         child: Container(
//           padding: EdgeInsets.all(size.customWidth(context) * 0.05),
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
//               SizedBox(height: size.customHeight(context) * 0.025),
//               Text(
//                 'Delete Submission',
//                 style: GoogleFonts.poppins(
//                   fontWeight: FontWeight.bold,
//                   fontSize: size.customWidth(context) * 0.05,
//                   color: AppColors.textPrimaryColor,
//                 ),
//               ),
//               SizedBox(height: size.customHeight(context) * 0.015),
//               Text(
//                 'Are you sure you want to delete this submission?',
//                 textAlign: TextAlign.center,
//                 style: GoogleFonts.poppins(
//                   fontSize: size.customWidth(context) * 0.038,
//                   color: AppColors.textSecondaryColor,
//                   height: 1.4,
//                 ),
//               ),
//               SizedBox(height: size.customHeight(context) * 0.01),
//               Text(
//                 'This action cannot be undone.',
//                 textAlign: TextAlign.center,
//                 style: GoogleFonts.poppins(
//                   fontSize: size.customWidth(context) * 0.034,
//                   color: AppColors.errorColor,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               SizedBox(height: size.customHeight(context) * 0.03),
//               Row(
//                 children: [
//                   Expanded(
//                     child: OutlinedButton(
//                       onPressed: () => Get.back(),
//                       style: OutlinedButton.styleFrom(
//                         padding: EdgeInsets.symmetric(
//                           vertical: size.customHeight(context) * 0.015,
//                         ),
//                         side: BorderSide(
//                             color: AppColors.greyColor.withOpacity(0.5)),
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
//                   SizedBox(width: size.customWidth(context) * 0.03),
//                   Expanded(
//                     child: Obx(() => ElevatedButton(
//                           onPressed: controller.isDeleting.value
//                               ? null
//                               : () {
//                                   controller
//                                       .deleteSubmission(submissionId)
//                                       .then((_) {
//                                     Get.back(); // Close details screen
//                                   });
//                                 },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: AppColors.errorColor,
//                             padding: EdgeInsets.symmetric(
//                               vertical: size.customHeight(context) * 0.015,
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


// lib/view/history/submission_details_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import 'package:speechspectrum/controllers/history_controller.dart';
import 'package:speechspectrum/models/questionnaire_model.dart';
import 'package:intl/intl.dart';

class SubmissionDetailsScreen extends StatefulWidget {
  const SubmissionDetailsScreen({super.key});

  @override
  State<SubmissionDetailsScreen> createState() => _SubmissionDetailsScreenState();
}

class _SubmissionDetailsScreenState extends State<SubmissionDetailsScreen> {
  late final HistoryController controller;
  final Rxn<SubmissionItem> submission = Rxn<SubmissionItem>();
  final RxBool isLoading = false.obs;

  late String submissionId;

  @override
  void initState() {
    super.initState();
    submissionId = Get.arguments as String;
    
    // Get or create controller
    if (Get.isRegistered<HistoryController>()) {
      controller = Get.find<HistoryController>();
    } else {
      controller = Get.put(HistoryController());
    }
    
    // Fetch submission after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchSubmission();
    });
  }

  Future<void> _fetchSubmission() async {
    isLoading.value = true;
    final data = await controller.fetchSubmission(submissionId);
    submission.value = data;
    isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();

    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimaryColor),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Submission Details',
          style: GoogleFonts.poppins(
            color: AppColors.textPrimaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: AppColors.errorColor),
            onPressed: () => _showDeleteDialog(context),
          ),
        ],
      ),
      body: Obx(() {
        if (isLoading.value || submission.value == null) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
        }

        final data = submission.value!;
        final result = data.questionnaireResults.isNotEmpty
            ? data.questionnaireResults.first
            : null;

        return SingleChildScrollView(
          padding: EdgeInsets.all(size.customWidth(context) * 0.05),
          child: Column(
            children: [
              if (result != null) _buildResultCard(context, result),
              SizedBox(height: size.customHeight(context) * 0.025),
              _buildInfoCard(context, data),
              SizedBox(height: size.customHeight(context) * 0.025),
              _buildResponsesCard(context, data.responses),
              SizedBox(height: size.customHeight(context) * 0.03),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildResultCard(BuildContext context, QuestionnaireResult result) {
    final size = CustomSize();

    return Container(
      padding: EdgeInsets.all(size.customWidth(context) * 0.06),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            result.result.getRiskColor(),
            result.result.getRiskColor().withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: result.result.getRiskColor().withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // Stack(
          //   alignment: Alignment.center,
          //   children: [
          //     SizedBox(
          //       height: size.customHeight(context) * 0.18,
          //       width: size.customHeight(context) * 0.18,
          //       child: CircularProgressIndicator(
          //         value: double.parse(result.result.probability.replaceAll('%', '')) / 100,
          //         strokeWidth: 12,
          //         backgroundColor: AppColors.whiteColor.withOpacity(0.3),
          //         valueColor: const AlwaysStoppedAnimation<Color>(AppColors.whiteColor),
          //       ),
          //     ),
          //     Column(
          //       children: [
          //         Text(
          //           result.result.probability,
          //           style: GoogleFonts.poppins(
          //             color: AppColors.whiteColor,
          //             fontSize: 56,
          //             fontWeight: FontWeight.bold,
          //             height: 1,
          //           ),
          //         ),
          //         Text(
          //           'probability',
          //           style: GoogleFonts.poppins(
          //             color: AppColors.whiteColor.withOpacity(0.9),
          //             fontSize: 14,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ],
          // ),

          Column(
  mainAxisSize: MainAxisSize.min,
  children: [
    // PROGRESS INDICATOR (TOP)
    SizedBox(
      height: size.customHeight(context) * 0.15,
      width: size.customHeight(context) * 0.15,
      child: CircularProgressIndicator(
        value: double.parse(
                result.result.probability.replaceAll('%', '')) /
            100,
        strokeWidth: 12,
        backgroundColor: AppColors.whiteColor.withOpacity(0.3),
        valueColor: const AlwaysStoppedAnimation<Color>(
          AppColors.whiteColor,
        ),
      ),
    ),

    SizedBox(height: size.customHeight(context) * 0.02),

    // PROBABILITY TEXT (BOTTOM)
    Text(
      result.result.probability,
      style: GoogleFonts.poppins(
        color: AppColors.whiteColor,
        fontSize: 40,
        fontWeight: FontWeight.bold,
        height: 1,
      ),
    ),

    SizedBox(height: 6),

    Text(
      'probability',
      style: GoogleFonts.poppins(
        color: AppColors.whiteColor.withOpacity(0.9),
        fontSize: 14,
      ),
    ),
  ],
),

          SizedBox(height: size.customHeight(context) * 0.025),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.whiteColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              result.result.prediction,
              style: GoogleFonts.poppins(
                color: AppColors.whiteColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, SubmissionItem data) {
    final size = CustomSize();

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
                child: const Icon(Icons.info_outline, color: AppColors.primaryColor, size: 20),
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
          _buildInfoRow(context, 'Child Name', data.children.childName, Icons.person_outline),
          _buildInfoRow(context, 'Submission Date', DateFormat('MMMM dd, yyyy').format(DateTime.parse(data.submittedAt)), Icons.calendar_today_outlined),
          _buildInfoRow(context, 'Submission Time', data.getFormattedTime(), Icons.access_time_outlined),
          _buildInfoRow(context, 'Age (Months)', '${data.responses['Age_Mons'] ?? 'N/A'}', Icons.cake_outlined),
          _buildInfoRow(context, 'Gender', data.responses['Sex'] == 1 ? 'Male' : 'Female', Icons.wc_outlined),
          _buildInfoRow(context, 'Jaundice History', data.responses['Jaundice'] == 1 ? 'Yes' : 'No', Icons.medical_information_outlined),
          _buildInfoRow(context, 'Family History of ASD', data.responses['Family_mem_with_ASD'] == 1 ? 'Yes' : 'No', Icons.family_restroom_outlined, isLast: true),
        ],
      ),
    );
  }

  Widget _buildResponsesCard(BuildContext context, Map<String, dynamic> responses) {
    final size = CustomSize();

    final questions = {
      'A1': 'Does your child look at you when you call their name?',
      'A2': 'How easy is it for you to get eye contact?',
      'A3': 'Does your child point to indicate wants?',
      'A4': 'Does your child point to share interest?',
      'A5': 'Does your child pretend?',
      'A6': 'Does your child follow where you\'re looking?',
      'A7': 'Does your child show signs of wanting to comfort?',
      'A8': 'How would you describe first words?',
      'A9': 'Does your child use simple gestures?',
      'A10': 'Does your child stare at nothing?',
    };

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
                child: const Icon(Icons.quiz_outlined, color: AppColors.accentColor, size: 20),
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
          ...questions.entries.map((entry) {
            final value = responses[entry.key];
            return _buildResponseItem(context, entry.value, value == 1 ? 'Positive' : 'Negative', value == 1);
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value, IconData icon, {bool isLast = false}) {
    final size = CustomSize();

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: size.customHeight(context) * 0.01),
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

  Widget _buildResponseItem(BuildContext context, String question, String answer, bool isPositive) {
    final size = CustomSize();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(size.customWidth(context) * 0.04),
      decoration: BoxDecoration(
        color: isPositive ? AppColors.successColor.withOpacity(0.05) : AppColors.errorColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isPositive ? AppColors.successColor.withOpacity(0.2) : AppColors.errorColor.withOpacity(0.2),
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
                    color: isPositive ? AppColors.successColor : AppColors.errorColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    final size = CustomSize();

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Container(
          padding: EdgeInsets.all(size.customWidth(context) * 0.05),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.errorColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.warning_amber_rounded, color: AppColors.errorColor, size: 45),
              ),
              SizedBox(height: size.customHeight(context) * 0.025),
              Text(
                'Delete Submission',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: size.customWidth(context) * 0.05,
                  color: AppColors.textPrimaryColor,
                ),
              ),
              SizedBox(height: size.customHeight(context) * 0.015),
              Text(
                'Are you sure you want to delete this submission?',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.038,
                  color: AppColors.textSecondaryColor,
                  height: 1.4,
                ),
              ),
              SizedBox(height: size.customHeight(context) * 0.01),
              Text(
                'This action cannot be undone.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.034,
                  color: AppColors.errorColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: size.customHeight(context) * 0.03),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: size.customHeight(context) * 0.015),
                        side: BorderSide(color: AppColors.greyColor.withOpacity(0.5)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text('Cancel', style: GoogleFonts.poppins(color: AppColors.textSecondaryColor, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  SizedBox(width: size.customWidth(context) * 0.03),
                  Expanded(
                    child: Obx(() => ElevatedButton(
                          onPressed: controller.isDeleting.value
                              ? null
                              : () {
                                  controller.deleteSubmission(submissionId).then((_) {
                                    if (!controller.isDeleting.value) {
                                      Get.back(); // Close details screen
                                    }
                                  });
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.errorColor,
                            padding: EdgeInsets.symmetric(vertical: size.customHeight(context) * 0.015),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: controller.isDeleting.value
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(color: AppColors.whiteColor, strokeWidth: 2),
                                )
                              : Text('Delete', style: GoogleFonts.poppins(color: AppColors.whiteColor, fontWeight: FontWeight.w600)),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}