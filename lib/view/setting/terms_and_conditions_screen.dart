// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/constants/app_colors.dart';

// class TermsAndConditionsScreen extends StatelessWidget {
//   const TermsAndConditionsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
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
//           'Terms & Conditions',
//           style: GoogleFonts.poppins(
//             color: AppColors.textPrimaryColor,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(20),
//         child: Container(
//           padding: EdgeInsets.all(20),
//           decoration: BoxDecoration(
//             color: AppColors.whiteColor,
//             borderRadius: BorderRadius.circular(15),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Terms & Conditions',
//                 style: GoogleFonts.poppins(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.textPrimaryColor,
//                 ),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 'Last updated: November 2025',
//                 style: GoogleFonts.poppins(
//                   fontSize: 12,
//                   color: AppColors.textSecondaryColor,
//                 ),
//               ),
//               SizedBox(height: 20),
//               _buildSection(
//                 '1. Acceptance of Terms',
//                 'By accessing and using Speech Spectrum, you accept and agree to be bound by the terms and provision of this agreement.',
//               ),
//               _buildSection(
//                 '2. Use of Service',
//                 'Speech Spectrum is a screening tool designed to help parents identify potential speech delays linked to autism. It is not a diagnostic tool and should not replace professional medical advice.',
//               ),
//               _buildSection(
//                 '3. User Responsibilities',
//                 'You agree to provide accurate information and use the service responsibly. You understand that the results are preliminary and require professional evaluation.',
//               ),
//               _buildSection(
//                 '4. Privacy and Data',
//                 'We are committed to protecting your privacy. All data collected is handled according to our Privacy Policy and applicable laws.',
//               ),
//               _buildSection(
//                 '5. Disclaimer',
//                 'The app provides screening results based on AI analysis but does not constitute medical diagnosis. Always consult qualified healthcare professionals.',
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSection(String title, String content) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: GoogleFonts.poppins(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: AppColors.textPrimaryColor,
//             ),
//           ),
//           SizedBox(height: 8),
//           Text(
//             content,
//             style: GoogleFonts.poppins(
//               fontSize: 14,
//               color: AppColors.textSecondaryColor,
//               height: 1.6,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimaryColor),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Terms & Conditions',
          style: GoogleFonts.poppins(
            color: AppColors.textPrimaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.025,
        ),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(screenWidth * 0.05),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Terms & Conditions',
                style: GoogleFonts.poppins(
                  fontSize: screenWidth * 0.058,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryColor,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Last updated: November 2025',
                style: GoogleFonts.poppins(
                  fontSize: screenWidth * 0.032,
                  color: AppColors.textSecondaryColor,
                ),
              ),
              SizedBox(height: screenHeight * 0.012),
              _buildIntroText(
                'Please read these Terms & Conditions carefully before using Speech Spectrum. By accessing or using our application, you agree to be bound by the terms described below.',
                screenWidth,
              ),
              Divider(height: screenHeight * 0.035, color: Colors.grey.shade200),
              _buildSection(
                number: '1',
                title: 'Acceptance of Terms',
                content:
                    'By downloading, installing, or using Speech Spectrum, you confirm that you are at least 18 years of age and have full legal capacity to enter into this agreement. If you do not agree to these terms, you must discontinue use of the application immediately.',
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              _buildSection(
                number: '2',
                title: 'Nature of the Service',
                content:
                    'Speech Spectrum is an AI-assisted screening application designed to help parents and caregivers identify potential speech and language delays in children aged 1–5 years that may be linked to Autism Spectrum Disorder (ASD).\n\n'
                    'This application is a preliminary screening tool only. It does not constitute a medical diagnosis and must not be treated as a substitute for professional clinical evaluation. Results generated by the app are indicative and require follow-up with a qualified healthcare professional.',
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              _buildSection(
                number: '3',
                title: 'User Responsibilities',
                content:
                    'By using Speech Spectrum, you agree to:\n\n'
                    '• Provide accurate and truthful information when completing questionnaires and child profiles\n'
                    '• Use the application solely for its intended personal, non-commercial purpose\n'
                    '• Not attempt to reverse-engineer, copy, or redistribute any part of the app or its AI models\n'
                    '• Understand that screening results are preliminary and require professional validation\n'
                    '• Keep your account credentials secure and not share access with unauthorised individuals',
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              _buildSection(
                number: '4',
                title: 'Medical Disclaimer',
                content:
                    'Speech Spectrum does not provide medical advice, diagnosis, or treatment. All content, screening results, and recommendations within the app are for informational purposes only.\n\n'
                    'Never disregard professional medical advice or delay seeking treatment based on the results of this application. If you believe your child may have a developmental disorder, please consult a licensed paediatrician, developmental specialist, or speech-language pathologist without delay.',
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              _buildSection(
                number: '5',
                title: 'Intellectual Property',
                content:
                    'All content, features, and functionality within Speech Spectrum — including but not limited to AI models, algorithms, UI design, text, graphics, and branding — are the exclusive intellectual property of the Speech Spectrum development team and are protected by applicable copyright and intellectual property laws.\n\n'
                    'Unauthorised reproduction, modification, or distribution of any part of this application is strictly prohibited.',
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              _buildSection(
                number: '6',
                title: 'Privacy and Data',
                content:
                    'Your use of Speech Spectrum is also governed by our Privacy Policy, which is incorporated into these Terms & Conditions by reference. By using the app, you consent to the collection and use of your data as described in the Privacy Policy.\n\n'
                    'We are committed to handling all data responsibly and in compliance with applicable data protection regulations.',
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              _buildSection(
                number: '7',
                title: 'Limitation of Liability',
                content:
                    'To the maximum extent permitted by applicable law, Speech Spectrum and its developers shall not be held liable for:\n\n'
                    '• Any misinterpretation or misuse of screening results\n'
                    '• Delays in seeking professional medical advice based on app results\n'
                    '• Any indirect, incidental, or consequential damages arising from app use\n\n'
                    'Use of this application is entirely at the user\'s own discretion and risk.',
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              _buildSection(
                number: '8',
                title: 'Modifications to Terms',
                content:
                    'We reserve the right to revise these Terms & Conditions at any time. Updated terms will be posted within the app and will take effect immediately upon publication. Your continued use of Speech Spectrum following any update constitutes your acceptance of the revised terms.',
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              _buildSection(
                number: '9',
                title: 'Governing Law',
                content:
                    'These Terms & Conditions shall be governed by and construed in accordance with the laws of Pakistan. Any disputes arising from or related to the use of this application shall be subject to the exclusive jurisdiction of the courts of Karachi, Pakistan.',
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                isLast: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIntroText(String text, double screenWidth) => Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: screenWidth * 0.034,
          color: AppColors.textSecondaryColor,
          height: 1.7,
        ),
      );

  Widget _buildSection({
    required String number,
    required String title,
    required String content,
    required double screenWidth,
    required double screenHeight,
    bool isLast = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : screenHeight * 0.022),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: screenWidth * 0.075,
                height: screenWidth * 0.075,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    number,
                    style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.035,
                      fontWeight: FontWeight.bold,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ),
              SizedBox(width: screenWidth * 0.03),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimaryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.01),
          Padding(
            padding: EdgeInsets.only(left: screenWidth * 0.015),
            child: Text(
              content,
              style: GoogleFonts.poppins(
                fontSize: screenWidth * 0.034,
                color: AppColors.textSecondaryColor,
                height: 1.7,
              ),
            ),
          ),
          if (!isLast) ...[
            SizedBox(height: screenHeight * 0.018),
            Divider(height: 1, color: Colors.grey.shade200),
          ],
        ],
      ),
    );
  }
}