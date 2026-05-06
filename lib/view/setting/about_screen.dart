// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:speechspectrum/constants/app_colors.dart';
// // import 'package:speechspectrum/constants/custom_size.dart';


// // class AboutScreen extends StatelessWidget {
// //   const AboutScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     final size = CustomSize();
    
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
// //           'About',
// //           style: GoogleFonts.poppins(
// //             color: AppColors.textPrimaryColor,
// //             fontWeight: FontWeight.w600,
// //           ),
// //         ),
// //       ),
// //       body: SingleChildScrollView(
// //         padding: EdgeInsets.all(size.customWidth(context) * 0.05),
// //         child: Column(
// //           children: [
// //             Container(
// //               padding: EdgeInsets.all(size.customWidth(context) * 0.06),
// //               decoration: BoxDecoration(
// //                 gradient: LinearGradient(
// //                   colors: [AppColors.primaryColor, AppColors.secondaryColor],
// //                   begin: Alignment.topLeft,
// //                   end: Alignment.bottomRight,
// //                 ),
// //                 borderRadius: BorderRadius.circular(20),
// //               ),
// //               child: Column(
// //                 children: [
// //                   Icon(Icons.waves_outlined, size: 80, color: AppColors.whiteColor),
// //                   SizedBox(height: 16),
// //                   Text(
// //                     'Speech Spectrum',
// //                     style: GoogleFonts.poppins(
// //                       fontSize: 28,
// //                       fontWeight: FontWeight.bold,
// //                       color: AppColors.whiteColor,
// //                     ),
// //                   ),
// //                   Text(
// //                     'Version 1.0.0',
// //                     style: GoogleFonts.poppins(
// //                       fontSize: 14,
// //                       color: AppColors.whiteColor.withOpacity(0.9),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
            
// //             SizedBox(height: size.customHeight(context) * 0.03),
            
// //             Container(
// //               padding: EdgeInsets.all(size.customWidth(context) * 0.05),
// //               decoration: BoxDecoration(
// //                 color: AppColors.whiteColor,
// //                 borderRadius: BorderRadius.circular(15),
// //               ),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(
// //                     'About Speech Spectrum',
// //                     style: GoogleFonts.poppins(
// //                       fontSize: 18,
// //                       fontWeight: FontWeight.bold,
// //                       color: AppColors.textPrimaryColor,
// //                     ),
// //                   ),
// //                   SizedBox(height: 12),
// //                   Text(
// //                     'Speech Spectrum is an AI-powered application designed to help parents identify potential speech delays linked to Autism Spectrum Disorder in young children aged 1-5 years.',
// //                     style: GoogleFonts.poppins(
// //                       fontSize: 14,
// //                       color: AppColors.textSecondaryColor,
// //                       height: 1.6,
// //                     ),
// //                   ),
// //                   SizedBox(height: 16),
// //                   Text(
// //                     'Our mission is to empower parents through early screening, awareness, and timely intervention, making autism detection accessible and simple for families everywhere.',
// //                     style: GoogleFonts.poppins(
// //                       fontSize: 14,
// //                       color: AppColors.textSecondaryColor,
// //                       height: 1.6,
// //                     ),
// //                   ),
// //                   SizedBox(height: 20),
// //                   Divider(),
// //                   SizedBox(height: 12),
// //                   _buildInfoRow(Icons.email, 'support@speechspectrum.com'),
// //                   _buildInfoRow(Icons.language, 'www.speechspectrum.com'),
// //                   _buildInfoRow(Icons.location_on, 'Karachi, Pakistan'),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildInfoRow(IconData icon, String text) {
// //     return Padding(
// //       padding: EdgeInsets.symmetric(vertical: 8),
// //       child: Row(
// //         children: [
// //           Icon(icon, color: AppColors.primaryColor, size: 20),
// //           SizedBox(width: 12),
// //           Text(
// //             text,
// //             style: GoogleFonts.poppins(
// //               fontSize: 14,
// //               color: AppColors.textSecondaryColor,
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

// class AboutScreen extends StatelessWidget {
//   const AboutScreen({super.key});

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
//           'About',
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
//           children: [
//             // ── Hero gradient card ──────────────────────────────────────────
//             Container(
//               width: double.infinity,
//               padding: EdgeInsets.symmetric(
//                   vertical: sh * 0.04, horizontal: sw * 0.06),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [AppColors.primaryColor, AppColors.secondaryColor],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.circular(24),
//               ),
//               child: Column(
//                 children: [
//                   // Logo
//                   Container(
//                     height: sw * 0.2,
//                     width: sw * 0.2,
//                     decoration: BoxDecoration(
//                       color: AppColors.whiteColor.withOpacity(0.25),
//                       borderRadius: BorderRadius.circular(sw * 0.05),
//                     ),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(sw * 0.05),
//                       child: Image.asset(
//                         'assets/images/logo.jpeg',
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: sh * 0.02),
//                   Text(
//                     'SpeechSpectrum',
//                     style: GoogleFonts.poppins(
//                       fontSize: sw * 0.06,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.whiteColor,
//                       letterSpacing: 0.5,
//                     ),
//                   ),
//                   SizedBox(height: sh * 0.005),
//                   Text(
//                     'Early ASD & Speech Delay Detection',
//                     style: GoogleFonts.poppins(
//                       fontSize: sw * 0.032,
//                       color: AppColors.whiteColor.withOpacity(0.85),
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: sh * 0.025),
//                   // Stat chips row
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       _statChip('AI-Powered', Icons.psychology_outlined, sw),
//                       SizedBox(width: sw * 0.03),
//                       _statChip('2-Phase Screening', Icons.layers_outlined, sw),
//                       SizedBox(width: sw * 0.03),
//                       _statChip('Ages 1–10', Icons.child_care_outlined, sw),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             SizedBox(height: sh * 0.025),

//             // ── About section ───────────────────────────────────────────────
//             _infoCard(
//               sw: sw,
//               sh: sh,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _sectionTitle('About SpeechSpectrum', sw),
//                   SizedBox(height: sh * 0.015),
//                   _bodyText(
//                     'SpeechSpectrum is an AI-powered platform designed to address the challenge of early detection of speech delays and Autism Spectrum Disorder (ASD) in children aged 1–10 years. It was developed to bridge the gap caused by delayed diagnosis, limited access to specialists, and the limitations of traditional screening methods that are often time-consuming and inaccessible for many families.',
//                     sw,
//                   ),
//                   SizedBox(height: sh * 0.015),
//                   _bodyText(
//                     'The platform delivers a two-phase hybrid screening process: a questionnaire-based assessment powered by a Random Forest machine learning model, combined with a CNN-based speech analysis module that extracts 49 acoustic features from a child\'s voice recording. Together, these produce a combined risk report with actionable intervention recommendations.',
//                     sw,
//                   ),
//                 ],
//               ),
//             ),

//             SizedBox(height: sh * 0.02),

//             // ── Mission section ─────────────────────────────────────────────
//             _infoCard(
//               sw: sw,
//               sh: sh,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _sectionTitle('Our Mission', sw),
//                   SizedBox(height: sh * 0.015),
//                   _bodyText(
//                     'Our mission is to empower parents and caregivers through early, accessible, and affordable ASD screening. By leveraging machine learning and cloud technologies, SpeechSpectrum reduces dependency on manual assessments, supports timely intervention during the most critical developmental window, and contributes to improving diagnostic practices in child development.',
//                     sw,
//                   ),
//                 ],
//               ),
//             ),

//             SizedBox(height: sh * 0.02),

//             // ── Key features ────────────────────────────────────────────────
//             _infoCard(
//               sw: sw,
//               sh: sh,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _sectionTitle('Key Features', sw),
//                   SizedBox(height: sh * 0.015),
//                   _featureRow(Icons.quiz_outlined,
//                       'Questionnaire Screening', 'Q-CHAT–based Random Forest model', sw, sh),
//                   _featureRow(Icons.mic_outlined,
//                       'Speech Analysis', 'CNN model with 49 acoustic features', sw, sh),
//                   _featureRow(Icons.bar_chart_outlined,
//                       'Combined Risk Report', 'Unified score with intervention guidance', sw, sh),
//                   _featureRow(Icons.person_search_outlined,
//                       'Find Therapists', 'Connect with verified specialists', sw, sh),
//                   _featureRow(Icons.play_lesson_outlined,
//                       'Therapy Exercises', '12 guided video sessions', sw, sh),
//                   _featureRow(Icons.lock_outline,
//                       'Secure & Private', 'Encrypted data, JWT authentication', sw, sh),
//                 ],
//               ),
//             ),

//             SizedBox(height: sh * 0.02),

//             // ── Built by ────────────────────────────────────────────────────
//             _infoCard(
//               sw: sw,
//               sh: sh,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _sectionTitle('Built At', sw),
//                   SizedBox(height: sh * 0.015),
//                   Row(
//                     children: [
//                       Container(
//                         padding: EdgeInsets.all(sw * 0.025),
//                         decoration: BoxDecoration(
//                           color: AppColors.primaryColor.withOpacity(0.08),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Icon(Icons.school_outlined,
//                             color: AppColors.primaryColor, size: sw * 0.06),
//                       ),
//                       SizedBox(width: sw * 0.04),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'NED University of Engineering & Technology',
//                               style: GoogleFonts.poppins(
//                                 fontSize: sw * 0.035,
//                                 fontWeight: FontWeight.w600,
//                                 color: AppColors.textPrimaryColor,
//                               ),
//                             ),
//                             Text(
//                               'Karachi, Pakistan · 2025',
//                               style: GoogleFonts.poppins(
//                                 fontSize: sw * 0.031,
//                                 color: AppColors.textSecondaryColor,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: sh * 0.015),
//                   _infoRow(Icons.language, 'www.speechspectrum.com', sw, sh),
//                   _infoRow(Icons.location_on_outlined, 'Karachi, Pakistan', sw, sh),
//                 ],
//               ),
//             ),

//             SizedBox(height: sh * 0.02),

//             // ── Disclaimer ──────────────────────────────────────────────────
//             Container(
//               width: double.infinity,
//               padding: EdgeInsets.all(sw * 0.045),
//               decoration: BoxDecoration(
//                 color: AppColors.primaryColor.withOpacity(0.06),
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(
//                     color: AppColors.primaryColor.withOpacity(0.15)),
//               ),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Icon(Icons.info_outline,
//                       color: AppColors.primaryColor, size: sw * 0.05),
//                   SizedBox(width: sw * 0.03),
//                   Expanded(
//                     child: Text(
//                       'SpeechSpectrum is a screening tool, not a diagnostic instrument. Results should always be reviewed by a qualified healthcare professional or developmental specialist.',
//                       style: GoogleFonts.poppins(
//                         fontSize: sw * 0.031,
//                         color: AppColors.primaryColor,
//                         height: 1.55,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             SizedBox(height: sh * 0.03),
//           ],
//         ),
//       ),
//     );
//   }

//   // ── Helpers ─────────────────────────────────────────────────────────────────

//   Widget _statChip(String label, IconData icon, double sw) {
//     return Container(
//       padding: EdgeInsets.symmetric(
//           horizontal: sw * 0.025, vertical: sw * 0.015),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.2),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, color: Colors.white, size: sw * 0.035),
//           SizedBox(width: sw * 0.015),
//           Text(
//             label,
//             style: GoogleFonts.poppins(
//               color: Colors.white,
//               fontSize: sw * 0.028,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _infoCard(
//       {required double sw,
//       required double sh,
//       required Widget child}) {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(sw * 0.05),
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(18),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withOpacity(0.04),
//               blurRadius: 10,
//               offset: const Offset(0, 3))
//         ],
//       ),
//       child: child,
//     );
//   }

//   Widget _sectionTitle(String text, double sw) {
//     return Text(
//       text,
//       style: GoogleFonts.poppins(
//         fontSize: sw * 0.043,
//         fontWeight: FontWeight.bold,
//         color: AppColors.textPrimaryColor,
//       ),
//     );
//   }

//   Widget _bodyText(String text, double sw) {
//     return Text(
//       text,
//       style: GoogleFonts.poppins(
//         fontSize: sw * 0.034,
//         color: AppColors.textSecondaryColor,
//         height: 1.65,
//       ),
//     );
//   }

//   Widget _featureRow(IconData icon, String title, String sub,
//       double sw, double sh) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: sh * 0.014),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             padding: EdgeInsets.all(sw * 0.02),
//             decoration: BoxDecoration(
//               color: AppColors.primaryColor.withOpacity(0.08),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Icon(icon,
//                 color: AppColors.primaryColor, size: sw * 0.045),
//           ),
//           SizedBox(width: sw * 0.035),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: GoogleFonts.poppins(
//                     fontSize: sw * 0.036,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.textPrimaryColor,
//                   ),
//                 ),
//                 Text(
//                   sub,
//                   style: GoogleFonts.poppins(
//                     fontSize: sw * 0.03,
//                     color: AppColors.textSecondaryColor,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _infoRow(IconData icon, String text, double sw, double sh) {
//     return Padding(
//       padding: EdgeInsets.only(top: sh * 0.01),
//       child: Row(
//         children: [
//           Icon(icon,
//               color: AppColors.primaryColor, size: sw * 0.045),
//           SizedBox(width: sw * 0.03),
//           Text(
//             text,
//             style: GoogleFonts.poppins(
//               fontSize: sw * 0.034,
//               color: AppColors.textSecondaryColor,
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

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

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
          'About',
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
        child: Column(
          children: [
            // ── Header Card ──────────────────────────────────────────
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.06,
                vertical: screenHeight * 0.035,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primaryColor, AppColors.secondaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Container(
                    height: screenWidth * 0.18,
                    width: screenWidth * 0.18,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                      child: Image.asset(
                        'assets/images/logo.jpeg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    'SpeechSpectrum',
                    style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.bold,
                      color: AppColors.whiteColor,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.006),
                  Text(
                    'Early Detection. Better Futures.',
                    style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.034,
                      color: AppColors.whiteColor.withOpacity(0.88),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: screenHeight * 0.025),

            // ── About the App ────────────────────────────────────────
            _buildCard(
              screenWidth: screenWidth,
              screenHeight: screenHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionTitle('About Speech Spectrum', screenWidth),
                  SizedBox(height: screenHeight * 0.012),
                  _bodyText(
                    'Speech Spectrum is an AI-powered mobile application designed to assist parents and caregivers in the early identification of speech and language delays potentially associated with Autism Spectrum Disorder (ASD) in children aged 1 to 5 years.',
                    screenWidth,
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  _bodyText(
                    'The application combines advanced speech analysis technology with validated behavioral screening tools, delivering accessible at-home preliminary assessments and helping families take the critical first step toward timely professional intervention.',
                    screenWidth,
                  ),
                ],
              ),
            ),

            SizedBox(height: screenHeight * 0.02),

            // ── Our Mission ──────────────────────────────────────────
            _buildCard(
              screenWidth: screenWidth,
              screenHeight: screenHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionTitle('Our Mission', screenWidth),
                  SizedBox(height: screenHeight * 0.012),
                  _bodyText(
                    'Our mission is to bridge the gap between early warning signs and professional diagnosis by placing a reliable screening tool directly in the hands of parents. We believe early awareness and timely action can make a profound difference in every child\'s developmental journey.',
                    screenWidth,
                  ),
                ],
              ),
            ),

            SizedBox(height: screenHeight * 0.02),

            // ── Key Features ─────────────────────────────────────────
            _buildCard(
              screenWidth: screenWidth,
              screenHeight: screenHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionTitle('Key Features', screenWidth),
                  SizedBox(height: screenHeight * 0.014),
                  _featureRow(
                    icon: Icons.record_voice_over_outlined,
                    title: 'Speech Analysis',
                    desc: 'AI-driven analysis of vocal patterns and speech characteristics to detect potential delays.',
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  _featureRow(
                    icon: Icons.quiz_outlined,
                    title: 'Behavioral Questionnaire',
                    desc: 'Structured screening based on established ASD behavioral indicators for children aged 1–5.',
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  _featureRow(
                    icon: Icons.analytics_outlined,
                    title: 'Instant Screening Results',
                    desc: 'Immediate preliminary results with clear risk-level indicators and recommended next steps.',
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  _featureRow(
                    icon: Icons.history_edu_outlined,
                    title: 'Screening History',
                    desc: 'Track your child\'s screening history over time for ongoing progress monitoring.',
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  _featureRow(
                    icon: Icons.medical_information_outlined,
                    title: 'Professional Referral Guidance',
                    desc: 'Personalised guidance to seek qualified healthcare professionals when concern levels are raised.',
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    isLast: true,
                  ),
                ],
              ),
            ),

            SizedBox(height: screenHeight * 0.02),

            // ── Disclaimer Banner ────────────────────────────────────
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(screenWidth * 0.045),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.07),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: AppColors.primaryColor.withOpacity(0.25),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline,
                      color: AppColors.primaryColor, size: screenWidth * 0.055),
                  SizedBox(width: screenWidth * 0.03),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Important Notice',
                          style: GoogleFonts.poppins(
                            fontSize: screenWidth * 0.038,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Speech Spectrum is a screening tool only and does not provide a clinical diagnosis. Always consult a licensed healthcare professional or developmental paediatrician for a comprehensive evaluation.',
                          style: GoogleFonts.poppins(
                            fontSize: screenWidth * 0.033,
                            color: AppColors.textSecondaryColor,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: screenHeight * 0.02),

            // ── Contact ──────────────────────────────────────────────
            _buildCard(
              screenWidth: screenWidth,
              screenHeight: screenHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionTitle('Contact Us', screenWidth),
                  SizedBox(height: screenHeight * 0.012),
                  _infoRow(Icons.location_on_outlined, 'Karachi, Pakistan', screenWidth),
                ],
              ),
            ),

            SizedBox(height: screenHeight * 0.03),
          ],
        ),
      ),
    );
  }

  // ── Helpers ────────────────────────────────────────────────────────

  Widget _buildCard({
    required Widget child,
    required double screenWidth,
    required double screenHeight,
  }) {
    return Container(
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
      child: child,
    );
  }

  Widget _sectionTitle(String title, double screenWidth) => Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: screenWidth * 0.045,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimaryColor,
        ),
      );

  Widget _bodyText(String text, double screenWidth) => Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: screenWidth * 0.035,
          color: AppColors.textSecondaryColor,
          height: 1.7,
        ),
      );

  Widget _featureRow({
    required IconData icon,
    required String title,
    required String desc,
    required double screenWidth,
    required double screenHeight,
    bool isLast = false,
  }) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(screenWidth * 0.022),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppColors.primaryColor, size: screenWidth * 0.05),
            ),
            SizedBox(width: screenWidth * 0.035),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.037,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimaryColor,
                      )),
                  SizedBox(height: 3),
                  Text(desc,
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.033,
                        color: AppColors.textSecondaryColor,
                        height: 1.5,
                      )),
                ],
              ),
            ),
          ],
        ),
        if (!isLast)
          Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.012),
            child: Divider(height: 1, color: Colors.grey.shade200),
          ),
      ],
    );
  }

  Widget _infoRow(IconData icon, String text, double screenWidth) => Row(
        children: [
          Icon(icon, color: AppColors.primaryColor, size: screenWidth * 0.05),
          SizedBox(width: screenWidth * 0.03),
          Text(text,
              style: GoogleFonts.poppins(
                fontSize: screenWidth * 0.035,
                color: AppColors.textSecondaryColor,
              )),
        ],
      );
}