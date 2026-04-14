// // lib/view/payment/payment_success_screen.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/routes/app_routes.dart';

// class PaymentSuccessScreen extends StatelessWidget {
//   const PaymentSuccessScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final args = Get.arguments as Map<String, dynamic>? ?? {};
//     final appointmentId = args['appointment_id'] as String? ?? '';
//     final screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       backgroundColor: AppColors.whiteColor,
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Success animation circle
//               Container(
//                 width: 120,
//                 height: 120,
//                 decoration: BoxDecoration(
//                   color: AppColors.successColor.withOpacity(0.1),
//                   shape: BoxShape.circle,
//                 ),
//                 child: const Icon(
//                   Icons.check_circle_rounded,
//                   size: 72,
//                   color: AppColors.successColor,
//                 ),
//               ),

//               const SizedBox(height: 32),

//               Text(
//                 'Payment Successful!',
//                 style: GoogleFonts.poppins(
//                   fontSize: screenWidth * 0.06,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.textPrimaryColor,
//                 ),
//                 textAlign: TextAlign.center,
//               ),

//               const SizedBox(height: 12),

//               Text(
//                 'Your appointment has been confirmed.\nYou will receive a confirmation shortly.',
//                 style: GoogleFonts.poppins(
//                   fontSize: screenWidth * 0.038,
//                   color: AppColors.textSecondaryColor,
//                   height: 1.6,
//                 ),
//                 textAlign: TextAlign.center,
//               ),

//               if (appointmentId.isNotEmpty) ...[
//                 const SizedBox(height: 16),
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 16, vertical: 10),
//                   decoration: BoxDecoration(
//                     color: AppColors.successColor.withOpacity(0.08),
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(
//                         color: AppColors.successColor.withOpacity(0.3)),
//                   ),
//                   child: Text(
//                     'Appointment ID: ${appointmentId.substring(0, 8).toUpperCase()}...',
//                     style: GoogleFonts.poppins(
//                       fontSize: screenWidth * 0.032,
//                       color: AppColors.successColor,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ],

//               const SizedBox(height: 48),

//               // Primary CTA
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () =>
//                       Get.offAllNamed(AppRoutes.parentMyAppointments),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.primaryColor,
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(14),
//                     ),
//                   ),
//                   child: Text(
//                     'View My Appointments',
//                     style: GoogleFonts.poppins(
//                       color: AppColors.whiteColor,
//                       fontWeight: FontWeight.w600,
//                       fontSize: screenWidth * 0.042,
//                     ),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 14),

//               // Secondary — go home
//               SizedBox(
//                 width: double.infinity,
//                 child: OutlinedButton(
//                   onPressed: () => Get.offAllNamed(AppRoutes.home),
//                   style: OutlinedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     side: BorderSide(color: AppColors.primaryColor),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(14),
//                     ),
//                   ),
//                   child: Text(
//                     'Go to Home',
//                     style: GoogleFonts.poppins(
//                       color: AppColors.primaryColor,
//                       fontWeight: FontWeight.w600,
//                       fontSize: screenWidth * 0.042,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// lib/view/payment/payment_success_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/routes/app_routes.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    final appointmentId = args['appointment_id'] as String? ?? '';
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.successColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_circle_rounded,
                    size: 72, color: AppColors.successColor),
              ),
              const SizedBox(height: 32),
              Text(
                'Payment Successful!',
                style: GoogleFonts.poppins(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'Your appointment has been confirmed.\nYou will receive a confirmation shortly.',
                style: GoogleFonts.poppins(
                  fontSize: screenWidth * 0.038,
                  color: AppColors.textSecondaryColor,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
              if (appointmentId.isNotEmpty) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.successColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: AppColors.successColor.withOpacity(0.3)),
                  ),
                  child: Text(
                    'Appointment ID: ${appointmentId.length > 8 ? appointmentId.substring(0, 8).toUpperCase() : appointmentId.toUpperCase()}...',
                    style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.032,
                      color: AppColors.successColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () =>
                      Get.offAllNamed(AppRoutes.parentMyAppointments),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  child: Text(
                    'View My Appointments',
                    style: GoogleFonts.poppins(
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w600,
                      fontSize: screenWidth * 0.042,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Get.offAllNamed(AppRoutes.home),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: AppColors.primaryColor),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  child: Text(
                    'Go to Home',
                    style: GoogleFonts.poppins(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: screenWidth * 0.042,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}