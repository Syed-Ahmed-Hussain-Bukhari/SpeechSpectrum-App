// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:speechspectrum/constants/app_colors.dart';


// // class PrivacyPolicyScreen extends StatelessWidget {
// //   const PrivacyPolicyScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
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
// //           'Privacy Policy',
// //           style: GoogleFonts.poppins(
// //             color: AppColors.textPrimaryColor,
// //             fontWeight: FontWeight.w600,
// //           ),
// //         ),
// //       ),
// //       body: SingleChildScrollView(
// //         padding: EdgeInsets.all(20),
// //         child: Container(
// //           padding: EdgeInsets.all(20),
// //           decoration: BoxDecoration(
// //             color: AppColors.whiteColor,
// //             borderRadius: BorderRadius.circular(15),
// //           ),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Text(
// //                 'Privacy Policy',
// //                 style: GoogleFonts.poppins(
// //                   fontSize: 24,
// //                   fontWeight: FontWeight.bold,
// //                   color: AppColors.textPrimaryColor,
// //                 ),
// //               ),
// //               SizedBox(height: 8),
// //               Text(
// //                 'Last updated: November 2025',
// //                 style: GoogleFonts.poppins(
// //                   fontSize: 12,
// //                   color: AppColors.textSecondaryColor,
// //                 ),
// //               ),
// //               SizedBox(height: 20),
// //               _buildSection(
// //                 'Information We Collect',
// //                 'We collect information you provide directly, including child demographics, questionnaire responses, and voice samples for analysis.',
// //               ),
// //               _buildSection(
// //                 'How We Use Your Information',
// //                 'Your data is used to provide screening services, improve our AI models, and deliver personalized recommendations. All data is encrypted and stored securely.',
// //               ),
// //               _buildSection(
// //                 'Data Security',
// //                 'We implement industry-standard security measures to protect your data. Voice samples and personal information are encrypted both in transit and at rest.',
// //               ),
// //               _buildSection(
// //                 'Your Rights',
// //                 'You have the right to access, modify, or delete your data at any time. Contact us for data-related requests.',
// //               ),
// //               _buildSection(
// //                 'Sharing Information',
// //                 'We do not sell or share your personal information with third parties except as required by law or with your explicit consent.',
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildSection(String title, String content) {
// //     return Padding(
// //       padding: EdgeInsets.only(bottom: 16),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Text(
// //             title,
// //             style: GoogleFonts.poppins(
// //               fontSize: 16,
// //               fontWeight: FontWeight.bold,
// //               color: AppColors.textPrimaryColor,
// //             ),
// //           ),
// //           SizedBox(height: 8),
// //           Text(
// //             content,
// //             style: GoogleFonts.poppins(
// //               fontSize: 14,
// //               color: AppColors.textSecondaryColor,
// //               height: 1.6,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';

// class PrivacyPolicyScreen extends StatelessWidget {
//   const PrivacyPolicyScreen({super.key});

//   static const _sections = [
//     _PolicySection(
//       icon: Icons.info_outline,
//       title: '1. Overview',
//       content:
//           'SpeechSpectrum is committed to protecting the privacy and security of all users. This Privacy Policy explains how we collect, use, store, and protect information provided through the SpeechSpectrum mobile and web application. By using our services, you agree to the practices described in this policy.',
//     ),
//     _PolicySection(
//       icon: Icons.data_usage_outlined,
//       title: '2. Information We Collect',
//       content:
//           'We collect information you provide directly, including: account registration details (name, email, password); child profile data (name, date of birth, gender); questionnaire responses used for ASD risk assessment; voice/speech audio recordings submitted for speech analysis; screening results and generated risk reports; and appointment and communication records with therapists.',
//     ),
//     _PolicySection(
//       icon: Icons.psychology_outlined,
//       title: '3. How We Use Your Information',
//       content:
//           'Your data is used exclusively to: deliver the two-phase screening service (questionnaire + speech analysis); generate combined risk reports and intervention recommendations; facilitate appointment booking with verified therapists; improve the accuracy of our Random Forest and CNN machine learning models; and provide a secure, personalized user experience. We do not use your data for advertising or sell it to third parties.',
//     ),
//     _PolicySection(
//       icon: Icons.lock_outline,
//       title: '4. Data Security',
//       content:
//           'SpeechSpectrum implements industry-standard security measures as specified in our system architecture. All Personal Identifiable Information (PII) and stored speech recordings are encrypted both in transit (HTTPS/TLS) and at rest. User authentication relies on secure token-based mechanisms (OAuth 2.0 / JWT). Role-Based Access Control (RBAC) and Row-Level Security on our Supabase database ensure that each user can only access their own data.',
//     ),
//     _PolicySection(
//       icon: Icons.child_care_outlined,
//       title: '5. Children\'s Data',
//       content:
//           'SpeechSpectrum handles data relating to children aged 1–10 years. All child-related data is stored under the parent or guardian\'s account. Parents/guardians are the sole authorized parties to create, edit, and delete their child\'s profile and screening records. We do not knowingly collect any data directly from children.',
//     ),
//     _PolicySection(
//       icon: Icons.share_outlined,
//       title: '6. Data Sharing',
//       content:
//           'We do not sell, rent, or trade your personal information. Data may be shared only: with therapists you explicitly connect with through the appointment system; with backend infrastructure providers (Supabase, Vercel) under strict data processing agreements; or as required by applicable law or legal process. Screening results are shared with healthcare professionals only upon your explicit consent.',
//     ),
//     _PolicySection(
//       icon: Icons.manage_accounts_outlined,
//       title: '7. Your Rights',
//       content:
//           'You have the right to access all data we hold about you and your child at any time through your account dashboard. You may update or correct your personal information, request deletion of your account and all associated data, withdraw consent for data processing, and download your screening history and generated reports. To exercise these rights, use the account settings or contact our support team.',
//     ),
//     _PolicySection(
//       icon: Icons.cloud_outlined,
//       title: '8. Data Retention',
//       content:
//           'Your data is retained for as long as your account remains active, or as required to provide the service. If you delete your account, all associated personal data, child profiles, screening results, and audio recordings will be permanently removed from our systems within 30 days, except where retention is required by law.',
//     ),
//     _PolicySection(
//       icon: Icons.update_outlined,
//       title: '9. Changes to This Policy',
//       content:
//           'We may update this Privacy Policy periodically to reflect changes in our practices or applicable regulations. We will notify you of any material changes via the app or by email. Continued use of SpeechSpectrum after changes are posted constitutes your acceptance of the updated policy.',
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();
//     final sw = size.customWidth(context);
//     final sh = size.customHeight(context);

//     return Scaffold(
//       backgroundColor: AppColors.lightGreyColor,
//       appBar: AppBar(
//         backgroundColor: AppColors.whiteColor,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios_new_rounded,
//               color: AppColors.textPrimaryColor, size: 20),
//           onPressed: () => Get.back(),
//         ),
//         title: Text(
//           'Privacy Policy',
//           style: GoogleFonts.poppins(
//             color: AppColors.textPrimaryColor,
//             fontWeight: FontWeight.w600,
//             fontSize: sw * 0.045,
//           ),
//         ),
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(1),
//           child: Container(height: 1, color: Colors.grey.shade100),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(sw * 0.05),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // ── Header card ────────────────────────────────────────────────
//             Container(
//               width: double.infinity,
//               padding: EdgeInsets.all(sw * 0.05),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [AppColors.primaryColor, AppColors.secondaryColor],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Row(
//                 children: [
//                   Container(
//                     padding: EdgeInsets.all(sw * 0.03),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.2),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Icon(Icons.privacy_tip_outlined,
//                         color: Colors.white, size: sw * 0.07),
//                   ),
//                   SizedBox(width: sw * 0.04),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Privacy Policy',
//                           style: GoogleFonts.poppins(
//                             color: Colors.white,
//                             fontSize: sw * 0.048,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(
//                           'Last updated: August 2025',
//                           style: GoogleFonts.poppins(
//                             color: Colors.white.withOpacity(0.85),
//                             fontSize: sw * 0.03,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             SizedBox(height: sh * 0.025),

//             // ── Policy sections ────────────────────────────────────────────
//             ..._sections.map((section) => _buildSection(section, sw, sh)),

//             SizedBox(height: sh * 0.015),

//             // ── Footer note ────────────────────────────────────────────────
//             Container(
//               width: double.infinity,
//               padding: EdgeInsets.all(sw * 0.045),
//               decoration: BoxDecoration(
//                 color: AppColors.primaryColor.withOpacity(0.06),
//                 borderRadius: BorderRadius.circular(14),
//                 border: Border.all(
//                     color: AppColors.primaryColor.withOpacity(0.15)),
//               ),
//               child: Text(
//                 'For privacy-related questions or data requests, please reach out through the app\'s support section. SpeechSpectrum is operated under NED University of Engineering & Technology, Karachi, Pakistan.',
//                 style: GoogleFonts.poppins(
//                   fontSize: sw * 0.031,
//                   color: AppColors.primaryColor,
//                   height: 1.6,
//                 ),
//               ),
//             ),

//             SizedBox(height: sh * 0.03),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSection(_PolicySection section, double sw, double sh) {
//     return Container(
//       width: double.infinity,
//       margin: EdgeInsets.only(bottom: sh * 0.015),
//       padding: EdgeInsets.all(sw * 0.045),
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withOpacity(0.04),
//               blurRadius: 8,
//               offset: const Offset(0, 2))
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(sw * 0.02),
//                 decoration: BoxDecoration(
//                   color: AppColors.primaryColor.withOpacity(0.08),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Icon(section.icon,
//                     color: AppColors.primaryColor, size: sw * 0.045),
//               ),
//               SizedBox(width: sw * 0.03),
//               Expanded(
//                 child: Text(
//                   section.title,
//                   style: GoogleFonts.poppins(
//                     fontSize: sw * 0.038,
//                     fontWeight: FontWeight.w700,
//                     color: AppColors.textPrimaryColor,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: sh * 0.012),
//           Divider(color: Colors.grey.shade100, height: 1),
//           SizedBox(height: sh * 0.012),
//           Text(
//             section.content,
//             style: GoogleFonts.poppins(
//               fontSize: sw * 0.033,
//               color: AppColors.textSecondaryColor,
//               height: 1.65,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _PolicySection {
//   final IconData icon;
//   final String title;
//   final String content;
//   const _PolicySection(
//       {required this.icon, required this.title, required this.content});
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
          'Privacy Policy',
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
                'Privacy Policy',
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
                'At Speech Spectrum, the privacy and security of your family\'s data is our highest priority. This Privacy Policy explains how we collect, use, store, and protect your information when you use our application.',
                screenWidth,
              ),
              Divider(height: screenHeight * 0.035, color: Colors.grey.shade200),
              _buildSection(
                icon: Icons.folder_open_outlined,
                title: '1. Information We Collect',
                content:
                    'We collect information that you provide directly during registration and use of the app. This includes:\n\n'
                    '• Child profile details (age, gender, developmental milestones)\n'
                    '• Responses to behavioral screening questionnaires\n'
                    '• Voice samples recorded within the app for AI-based speech analysis\n'
                    '• Device information and usage data to improve app performance',
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              _buildSection(
                icon: Icons.settings_suggest_outlined,
                title: '2. How We Use Your Information',
                content:
                    'Your data is used solely to deliver and improve the Speech Spectrum service:\n\n'
                    '• To perform AI-powered speech and behavioral screening\n'
                    '• To generate screening results and personalised recommendations\n'
                    '• To improve the accuracy and performance of our AI models\n'
                    '• To send important app updates or safety notifications\n\n'
                    'We do not use your data for advertising or marketing purposes.',
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              _buildSection(
                icon: Icons.lock_outline,
                title: '3. Data Security',
                content:
                    'We implement industry-standard security measures to safeguard your data at every stage:\n\n'
                    '• All voice samples and personal information are encrypted in transit (TLS) and at rest (AES-256)\n'
                    '• Access to stored data is restricted to authorised personnel only\n'
                    '• Regular security audits and vulnerability assessments are conducted\n'
                    '• Data is stored on secure, compliant cloud infrastructure',
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              _buildSection(
                icon: Icons.share_outlined,
                title: '4. Sharing of Information',
                content:
                    'We do not sell, trade, or rent your personal information to third parties. Information may only be shared in the following limited circumstances:\n\n'
                    '• With your explicit written consent\n'
                    '• As required by applicable law or regulatory authority\n'
                    '• With trusted service providers who assist in app operations, under strict confidentiality agreements',
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              _buildSection(
                icon: Icons.child_care_outlined,
                title: '5. Children\'s Data',
                content:
                    'Speech Spectrum is designed specifically to support the screening of young children. We treat all child-related data with heightened sensitivity and care. We do not knowingly collect identifiable personal data from children directly. All data related to a child is provided and managed by the parent or guardian.',
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              _buildSection(
                icon: Icons.manage_accounts_outlined,
                title: '6. Your Rights',
                content:
                    'As a user of Speech Spectrum, you retain full control over your data:\n\n'
                    '• Right to access: Request a copy of all data held about you\n'
                    '• Right to rectification: Correct any inaccurate personal information\n'
                    '• Right to deletion: Request permanent deletion of your account and data\n'
                    '• Right to withdraw consent: Opt out of data processing at any time\n\n'
                    'To exercise any of these rights, please contact us through the app\'s support section.',
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              _buildSection(
                icon: Icons.update_outlined,
                title: '7. Changes to This Policy',
                content:
                    'We may update this Privacy Policy periodically to reflect changes in our practices or applicable law. We will notify you of significant changes via the app. Continued use of Speech Spectrum after any update constitutes acceptance of the revised policy.',
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
    required IconData icon,
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
            children: [
              Icon(icon, color: AppColors.primaryColor, size: screenWidth * 0.048),
              SizedBox(width: screenWidth * 0.025),
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
          Text(
            content,
            style: GoogleFonts.poppins(
              fontSize: screenWidth * 0.034,
              color: AppColors.textSecondaryColor,
              height: 1.7,
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