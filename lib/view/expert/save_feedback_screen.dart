// // lib/view/expert/save_feedback_screen.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/appointment_controller.dart';

// class SaveFeedbackScreen extends StatefulWidget {
//   const SaveFeedbackScreen({super.key});

//   @override
//   State<SaveFeedbackScreen> createState() => _SaveFeedbackScreenState();
// }

// class _SaveFeedbackScreenState extends State<SaveFeedbackScreen> {
//   late final AppointmentController controller;
//   late String appointmentId;
//   late String childName;

//   @override
//   void initState() {
//     super.initState();

//     final args = Get.arguments as Map<String, dynamic>;
//     appointmentId = args['appointmentId'];
//     childName = args['childName'];

//     // Get or create controller
//     if (Get.isRegistered<AppointmentController>()) {
//       controller = Get.find<AppointmentController>();
//     } else {
//       controller = Get.put(AppointmentController());
//     }
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
//           icon: const Icon(Icons.arrow_back, color: AppColors.textPrimaryColor),
//           onPressed: () => Get.back(),
//         ),
//         title: Text(
//           'Progress Feedback',
//           style: GoogleFonts.poppins(
//             color: AppColors.textPrimaryColor,
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Success Icon
//             Center(
//               child: Container(
//                 width: 100,
//                 height: 100,
//                 decoration: BoxDecoration(
//                   color: AppColors.successColor.withOpacity(0.1),
//                   shape: BoxShape.circle,
//                 ),
//                 child: const Icon(
//                   Icons.check_circle_outline,
//                   color: AppColors.successColor,
//                   size: 50,
//                 ),
//               ),
//             ),

//             SizedBox(height: size.customHeight(context) * 0.025),

//             // Success Message
//             Center(
//               child: Column(
//                 children: [
//                   Text(
//                     'Notes Saved Successfully!',
//                     style: GoogleFonts.poppins(
//                       fontSize: size.customWidth(context) * 0.052,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.textPrimaryColor,
//                     ),
//                   ),
//                   SizedBox(height: size.customHeight(context) * 0.008),
//                   Text(
//                     'Now add progress feedback for $childName',
//                     textAlign: TextAlign.center,
//                     style: GoogleFonts.poppins(
//                       fontSize: size.customWidth(context) * 0.038,
//                       color: AppColors.textSecondaryColor,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             SizedBox(height: size.customHeight(context) * 0.04),

//             // Feedback Input
//             Text(
//               'Progress Feedback',
//               style: GoogleFonts.poppins(
//                 fontSize: size.customWidth(context) * 0.04,
//                 fontWeight: FontWeight.w600,
//                 color: AppColors.textPrimaryColor,
//               ),
//             ),
//             SizedBox(height: size.customHeight(context) * 0.01),

//             TextField(
//               controller: controller.feedbackController,
//               maxLines: 6,
//               style: GoogleFonts.poppins(
//                 fontSize: size.customWidth(context) * 0.038,
//                 color: AppColors.textPrimaryColor,
//               ),
//               decoration: InputDecoration(
//                 hintText:
//                     'Describe the child\'s progress, improvements, areas to focus on...',
//                 hintStyle: GoogleFonts.poppins(
//                   color: AppColors.greyColor,
//                   fontSize: size.customWidth(context) * 0.036,
//                 ),
//                 filled: true,
//                 fillColor: AppColors.whiteColor,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: BorderSide.none,
//                 ),
//                 contentPadding: const EdgeInsets.all(16),
//               ),
//             ),

//             SizedBox(height: size.customHeight(context) * 0.03),

//             // Info Box
//             Container(
//               padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//               decoration: BoxDecoration(
//                 color: AppColors.primaryColor.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(12),
//                 border:
//                     Border.all(color: AppColors.primaryColor.withOpacity(0.3)),
//               ),
//               child: Row(
//                 children: [
//                   Icon(
//                     Icons.info_outline,
//                     color: AppColors.primaryColor,
//                     size: 20,
//                   ),
//                   SizedBox(width: size.customWidth(context) * 0.03),
//                   Expanded(
//                     child: Text(
//                       'This feedback will be shared with the parent to track progress',
//                       style: GoogleFonts.poppins(
//                         fontSize: size.customWidth(context) * 0.032,
//                         color: AppColors.primaryColor,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             SizedBox(height: size.customHeight(context) * 0.03),

//             // Save Button
//             Obx(() => SizedBox(
//                   width: double.infinity,
//                   height: size.customHeight(context) * 0.06,
//                   child: ElevatedButton(
//                     onPressed: controller.isSaving.value
//                         ? null
//                         : () => _saveFeedback(),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.successColor,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                     ),
//                     child: controller.isSaving.value
//                         ? const SizedBox(
//                             width: 24,
//                             height: 24,
//                             child: CircularProgressIndicator(
//                               color: AppColors.whiteColor,
//                               strokeWidth: 2,
//                             ),
//                           )
//                         : Text(
//                             'Save Feedback & Complete',
//                             style: GoogleFonts.poppins(
//                               fontSize: size.customWidth(context) * 0.042,
//                               fontWeight: FontWeight.w600,
//                               color: AppColors.whiteColor,
//                             ),
//                           ),
//                   ),
//                 )),

//             SizedBox(height: size.customHeight(context) * 0.015),

//             // Skip Button
//             SizedBox(
//               width: double.infinity,
//               height: size.customHeight(context) * 0.06,
//               child: OutlinedButton(
//                 onPressed: () {
//                   Get.back();
//                   Get.back(); // Go back to appointments list
//                 },
//                 style: OutlinedButton.styleFrom(
//                   foregroundColor: AppColors.textSecondaryColor,
//                   side: BorderSide(color: AppColors.greyColor.withOpacity(0.5)),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                 ),
//                 child: Text(
//                   'Skip for Now',
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.04,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _saveFeedback() async {
//     if (controller.feedbackController.text.trim().isEmpty) {
//       Get.snackbar(
//         'Error',
//         'Please enter progress feedback',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: AppColors.errorColor,
//         colorText: AppColors.whiteColor,
//       );
//       return;
//     }

//     final success = await controller.saveAppointmentFeedback(
//       appointmentId: appointmentId,
//     );

//     if (success) {
//       // Go back to appointments list
//       Get.back();
//       Get.back();
//       // Refresh appointments list
//       controller.fetchExpertAppointments();
//     }
//   }
// }

// lib/view/expert/save_feedback_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import 'package:speechspectrum/controllers/appointment_controller.dart';
import 'package:speechspectrum/routes/app_routes.dart';

class SaveFeedbackScreen extends StatefulWidget {
  const SaveFeedbackScreen({super.key});

  @override
  State<SaveFeedbackScreen> createState() => _SaveFeedbackScreenState();
}

class _SaveFeedbackScreenState extends State<SaveFeedbackScreen> {
  late final AppointmentController controller;
  late String appointmentId;
  late String childName;

  @override
  void initState() {
    super.initState();

    final args = Get.arguments as Map<String, dynamic>;
    appointmentId = args['appointmentId'];
    childName = args['childName'];

    // Get or create controller
    if (Get.isRegistered<AppointmentController>()) {
      controller = Get.find<AppointmentController>();
    } else {
      controller = Get.put(AppointmentController());
    }
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
          'Progress Feedback',
          style: GoogleFonts.poppins(
            color: AppColors.textPrimaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(size.customWidth(context) * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Success Icon
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.successColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_outline,
                  color: AppColors.successColor,
                  size: 50,
                ),
              ),
            ),

            SizedBox(height: size.customHeight(context) * 0.025),

            // Success Message
            Center(
              child: Column(
                children: [
                  Text(
                    'Notes Saved Successfully!',
                    style: GoogleFonts.poppins(
                      fontSize: size.customWidth(context) * 0.052,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimaryColor,
                    ),
                  ),
                  SizedBox(height: size.customHeight(context) * 0.008),
                  Text(
                    'Now add progress feedback for $childName',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: size.customWidth(context) * 0.038,
                      color: AppColors.textSecondaryColor,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: size.customHeight(context) * 0.04),

            // Feedback Input
            Text(
              'Progress Feedback',
              style: GoogleFonts.poppins(
                fontSize: size.customWidth(context) * 0.04,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimaryColor,
              ),
            ),
            SizedBox(height: size.customHeight(context) * 0.01),

            TextField(
              controller: controller.feedbackController,
              maxLines: 6,
              style: GoogleFonts.poppins(
                fontSize: size.customWidth(context) * 0.038,
                color: AppColors.textPrimaryColor,
              ),
              decoration: InputDecoration(
                hintText:
                    'Describe the child\'s progress, improvements, areas to focus on...',
                hintStyle: GoogleFonts.poppins(
                  color: AppColors.greyColor,
                  fontSize: size.customWidth(context) * 0.036,
                ),
                filled: true,
                fillColor: AppColors.whiteColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.all(16),
              ),
            ),

            SizedBox(height: size.customHeight(context) * 0.03),

            // Info Box
            Container(
              padding: EdgeInsets.all(size.customWidth(context) * 0.04),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border:
                    Border.all(color: AppColors.primaryColor.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: AppColors.primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: size.customWidth(context) * 0.03),
                  Expanded(
                    child: Text(
                      'This feedback will be shared with the parent to track progress',
                      style: GoogleFonts.poppins(
                        fontSize: size.customWidth(context) * 0.032,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: size.customHeight(context) * 0.03),

            // Save Button
            Obx(() => SizedBox(
                  width: double.infinity,
                  height: size.customHeight(context) * 0.06,
                  child: ElevatedButton(
                    onPressed: controller.isSaving.value
                        ? null
                        : () => _saveFeedback(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.successColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: controller.isSaving.value
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: AppColors.whiteColor,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Save Feedback & Complete',
                            style: GoogleFonts.poppins(
                              fontSize: size.customWidth(context) * 0.042,
                              fontWeight: FontWeight.w600,
                              color: AppColors.whiteColor,
                            ),
                          ),
                  ),
                )),

            SizedBox(height: size.customHeight(context) * 0.015),

            // Skip Button
            SizedBox(
              width: double.infinity,
              height: size.customHeight(context) * 0.06,
              child: OutlinedButton(
                onPressed: () {
                  // Navigate to home
                  Get.offAllNamed(AppRoutes.expertHome);
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.textSecondaryColor,
                  side: BorderSide(color: AppColors.greyColor.withOpacity(0.5)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  'Skip for Now',
                  style: GoogleFonts.poppins(
                    fontSize: size.customWidth(context) * 0.04,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveFeedback() async {
    if (controller.feedbackController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter progress feedback',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.errorColor,
        colorText: AppColors.whiteColor,
      );
      return;
    }

    final success = await controller.saveAppointmentFeedback(
      appointmentId: appointmentId,
    );

    if (success) {
      // Show success message
      Get.snackbar(
        'Success',
        'Session notes and feedback saved successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.successColor,
        colorText: AppColors.whiteColor,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        duration: const Duration(seconds: 2),
      );

      // Wait a moment for user to see the success message
      await Future.delayed(const Duration(milliseconds: 500));

      // Navigate to expert home and refresh appointments
      Get.offAllNamed(AppRoutes.expertHome);
      
      // Refresh appointments list in background
      controller.fetchExpertAppointments();
    }
  }
}