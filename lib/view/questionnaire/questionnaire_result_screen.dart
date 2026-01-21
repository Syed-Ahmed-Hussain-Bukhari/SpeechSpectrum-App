// // lib/view/questionnaire/questionnaire_result_screen.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/models/questionnaire_model.dart';
// import 'package:intl/intl.dart';

// class QuestionnaireResultScreen extends StatelessWidget {
//   const QuestionnaireResultScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();
//     final QuestionnaireResult result = Get.arguments as QuestionnaireResult;
    
//     // Parse probability percentage
//     final probabilityStr = result.probability.replaceAll('%', '');
//     final probability = double.tryParse(probabilityStr) ?? 0.0;
//     final isLowRisk = result.prediction.toLowerCase().contains('low');
    
//     final Color riskColor = isLowRisk ? AppColors.successColor : AppColors.warningColor;
    
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
//           'Assessment Results',
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
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(size.customWidth(context) * 0.05),
//         child: Column(
//           children: [
//             // Date Badge
//             Container(
//               padding: EdgeInsets.symmetric(
//                 horizontal: size.customWidth(context) * 0.04,
//                 vertical: size.customHeight(context) * 0.01,
//               ),
//               decoration: BoxDecoration(
//                 color: AppColors.whiteColor,
//                 borderRadius: BorderRadius.circular(25),
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(Icons.calendar_today, size: 14, color: AppColors.textSecondaryColor),
//                   SizedBox(width: 6),
//                   Text(
//                     'Assessment Date: ${DateFormat('MMMM d, y').format(DateTime.parse(result.generatedAt))}',
//                     style: GoogleFonts.poppins(
//                       fontSize: 12,
//                       color: AppColors.textSecondaryColor,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
            
//             SizedBox(height: size.customHeight(context) * 0.02),
            
//             // Risk Score Card
//             Container(
//               padding: EdgeInsets.all(size.customWidth(context) * 0.06),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: isLowRisk 
//                       ? [AppColors.successColor, Colors.green.shade600]
//                       : [AppColors.warningColor, Colors.orange.shade400],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.circular(25),
//                 boxShadow: [
//                   BoxShadow(
//                     color: riskColor.withOpacity(0.3),
//                     blurRadius: 20,
//                     offset: Offset(0, 10),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       SizedBox(
//                         height: size.customHeight(context) * 0.18,
//                         width: size.customHeight(context) * 0.18,
//                         child: CircularProgressIndicator(
//                           value: probability / 100,
//                           strokeWidth: 12,
//                           backgroundColor: AppColors.whiteColor.withOpacity(0.3),
//                           valueColor: AlwaysStoppedAnimation<Color>(AppColors.whiteColor),
//                         ),
//                       ),
//                       Column(
//                         children: [
//                           Text(
//                             result.probability,
//                             style: GoogleFonts.poppins(
//                               color: AppColors.whiteColor,
//                               fontSize: 56,
//                               fontWeight: FontWeight.bold,
//                               height: 1,
//                             ),
//                           ),
//                           Text(
//                             'probability',
//                             style: GoogleFonts.poppins(
//                               color: AppColors.whiteColor.withOpacity(0.9),
//                               fontSize: 14,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: size.customHeight(context) * 0.025),
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//                     decoration: BoxDecoration(
//                       color: AppColors.whiteColor.withOpacity(0.2),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       result.prediction,
//                       style: GoogleFonts.poppins(
//                         color: AppColors.whiteColor,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         letterSpacing: 0.5,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: size.customHeight(context) * 0.015),
//                   Text(
//                     'Based on questionnaire responses',
//                     style: GoogleFonts.poppins(
//                       color: AppColors.whiteColor.withOpacity(0.85),
//                       fontSize: 12,
//                       height: 1.4,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//             ),
            
//             SizedBox(height: size.customHeight(context) * 0.025),
            
//             // Important Notice
//             Container(
//               padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//               decoration: BoxDecoration(
//                 color: AppColors.accentColor.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(15),
//                 border: Border.all(
//                   color: AppColors.accentColor.withOpacity(0.3),
//                   width: 1,
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   Icon(Icons.info_outline, color: AppColors.accentColor, size: 22),
//                   SizedBox(width: 12),
//                   Expanded(
//                     child: Text(
//                       'This is a screening tool, not a diagnostic assessment. Professional evaluation is recommended.',
//                       style: GoogleFonts.poppins(
//                         fontSize: 12,
//                         color: AppColors.textPrimaryColor,
//                         height: 1.4,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
            
//             SizedBox(height: size.customHeight(context) * 0.025),
            
//             // Recommendation Card
//             Container(
//               padding: EdgeInsets.all(size.customWidth(context) * 0.05),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [AppColors.primaryColor, AppColors.secondaryColor],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Icon(Icons.medical_services_outlined, 
//                         color: AppColors.whiteColor, size: 24),
//                       SizedBox(width: 12),
//                       Text(
//                         'Our Recommendation',
//                         style: GoogleFonts.poppins(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: AppColors.whiteColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     isLowRisk
//                         ? 'Your child shows low indicators for autism spectrum concerns. Continue monitoring developmental milestones and maintain regular pediatric check-ups.'
//                         : 'Based on the screening results, we recommend consulting with a qualified healthcare professional for a comprehensive developmental evaluation.',
//                     style: GoogleFonts.poppins(
//                       fontSize: 14,
//                       color: AppColors.whiteColor.withOpacity(0.95),
//                       height: 1.6,
//                     ),
//                   ),
//                   SizedBox(height: 12),
//                   Text(
//                     'Early intervention can significantly improve developmental outcomes and provide your child with the support they need to thrive.',
//                     style: GoogleFonts.poppins(
//                       fontSize: 13,
//                       color: AppColors.whiteColor.withOpacity(0.9),
//                       height: 1.5,
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   SizedBox(
//                     width: double.infinity,
//                     height: size.customHeight(context) * 0.06,
//                     child: ElevatedButton.icon(
//                       onPressed: () {},
//                       icon: Icon(Icons.search, size: 20),
//                       label: Text(
//                         'Find Specialists Near You',
//                         style: GoogleFonts.poppins(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.whiteColor,
//                         foregroundColor: AppColors.primaryColor,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         elevation: 0,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
            
//             SizedBox(height: size.customHeight(context) * 0.02),
            
//             // Action Buttons
//             Row(
//               children: [
//                 Expanded(
//                   child: OutlinedButton.icon(
//                     onPressed: () => Get.toNamed('/questionnaire-history'),
//                     icon: Icon(Icons.history, size: 20),
//                     label: Text(
//                       'View History',
//                       style: GoogleFonts.poppins(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     style: OutlinedButton.styleFrom(
//                       foregroundColor: AppColors.primaryColor,
//                       side: BorderSide(color: AppColors.primaryColor, width: 1.5),
//                       padding: EdgeInsets.symmetric(
//                         vertical: size.customHeight(context) * 0.018,
//                       ),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 12),
//                 Expanded(
//                   child: ElevatedButton.icon(
//                     onPressed: () => Get.back(),
//                     icon: Icon(Icons.home, size: 20),
//                     label: Text(
//                       'Go Home',
//                       style: GoogleFonts.poppins(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.primaryColor,
//                       foregroundColor: AppColors.whiteColor,
//                       padding: EdgeInsets.symmetric(
//                         vertical: size.customHeight(context) * 0.018,
//                       ),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       elevation: 0,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
            
//             SizedBox(height: size.customHeight(context) * 0.03),
//           ],
//         ),
//       ),
//     );
//   }
// }


// lib/view/questionnaire/questionnaire_results_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import 'package:speechspectrum/controllers/questionnaire_controller.dart';
import 'package:intl/intl.dart';

class QuestionnaireResultsScreen extends StatelessWidget {
  const QuestionnaireResultsScreen({super.key});

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
          IconButton(
            icon: Icon(Icons.share_outlined, color: AppColors.textPrimaryColor),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.download_outlined, color: AppColors.textPrimaryColor),
            onPressed: () {},
          ),
        ],
      ),
      body: Obx(() {
        final result = controller.resultModel.value;

        if (result == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: AppColors.errorColor,
                ),
                SizedBox(height: 16),
                Text(
                  'No results available',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: AppColors.textSecondaryColor,
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => Get.offAllNamed('/home'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                  ),
                  child: Text(
                    'Go Home',
                    style: GoogleFonts.poppins(
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(size.customWidth(context) * 0.05),
          child: Column(
            children: [
              // Date Badge
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: size.customWidth(context) * 0.04,
                  vertical: size.customHeight(context) * 0.01,
                ),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.calendar_today,
                        size: 14, color: AppColors.textSecondaryColor),
                    SizedBox(width: 6),
                    Text(
                      'Assessment Date: ${DateFormat('MMMM dd, yyyy').format(DateTime.now())}',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: AppColors.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: size.customHeight(context) * 0.02),

              // Main Result Card
              Container(
                padding: EdgeInsets.all(size.customWidth(context) * 0.06),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      result.result.result.getRiskColor(),
                      result.result.result.getRiskColor().withOpacity(0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: result.result.result.getRiskColor().withOpacity(0.3),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Circular Progress
                    // Stack(
                    //   alignment: Alignment.center,
                    //   children: [
                    //     SizedBox(
                    //       height: size.customHeight(context) * 0.18,
                    //       width: size.customHeight(context) * 0.35,
                    //       child: CircularProgressIndicator(
                    //         value: double.parse(result.result.result.probability
                    //                 .replaceAll('%', '')) /
                    //             100,
                    //         strokeWidth: 12,
                    //         backgroundColor:
                    //             AppColors.whiteColor.withOpacity(0.3),
                    //         valueColor: AlwaysStoppedAnimation<Color>(
                    //             AppColors.whiteColor),
                    //       ),
                    //     ),
                    //     Column(
                    //       children: [
                    //         Text(
                    //           result.result.result.probability,
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

                    // Circular Progress (UPDATED – no overlap)
                  Column(
                    children: [
                      SizedBox(
                        height: size.customHeight(context) * 0.18,
                        width: size.customHeight(context) * 0.18,
                        child: CircularProgressIndicator(
                          value: double.parse(
                                  result.result.result.probability.replaceAll('%', '')) /
                              100,
                          strokeWidth: 12,
                          backgroundColor:
                              AppColors.whiteColor.withOpacity(0.3),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.whiteColor,
                          ),
                        ),
                      ),

                      SizedBox(height: size.customHeight(context) * 0.015),

                      // Percentage OUTSIDE the circle
                      Text(
                        result.result.result.probability,
                        style: GoogleFonts.poppins(
                          color: AppColors.whiteColor,
                          fontSize: size.customWidth(context) * 0.12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        'Probability',
                        style: GoogleFonts.poppins(
                          color: AppColors.whiteColor.withOpacity(0.9),
                          fontSize: 14,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),

                    SizedBox(height: size.customHeight(context) * 0.025),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        result.result.result.prediction,
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
              ),

              SizedBox(height: size.customHeight(context) * 0.025),

              // Important Notice
              Container(
                padding: EdgeInsets.all(size.customWidth(context) * 0.04),
                decoration: BoxDecoration(
                  color: AppColors.accentColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: AppColors.accentColor.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline,
                        color: AppColors.accentColor, size: 22),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'This is a screening tool, not a diagnostic assessment. Professional evaluation is recommended.',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: AppColors.textPrimaryColor,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: size.customHeight(context) * 0.025),

              // Detailed Information
              Container(
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
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(Icons.assessment_outlined,
                              color: AppColors.primaryColor, size: 20),
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Assessment Details',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    _buildInfoRow(
                      context,
                      'Questions Answered',
                      '${controller.questions.length}/${controller.questions.length}',
                      Icons.quiz_outlined,
                    ),
                    _buildInfoRow(
                      context,
                      'Assessment Type',
                      'ASD Screening Questionnaire',
                      Icons.medical_services_outlined,
                    ),
                    _buildInfoRow(
                      context,
                      'Completed On',
                      DateFormat('MMM dd, yyyy - hh:mm a')
                          .format(DateTime.now()),
                      Icons.access_time,
                    ),
                  ],
                ),
              ),

              SizedBox(height: size.customHeight(context) * 0.025),

              // Recommendation Card
              Container(
                padding: EdgeInsets.all(size.customWidth(context) * 0.05),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primaryColor,
                      AppColors.secondaryColor
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.medical_services_outlined,
                            color: AppColors.whiteColor, size: 24),
                        SizedBox(width: 12),
                        Text(
                          'Our Recommendation',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      result.result.result.getRiskLevel() == 'Low'
                          ? 'The screening indicates low likelihood. However, if you have concerns, we recommend consulting with a qualified healthcare professional for peace of mind.'
                          : 'Based on the screening results, we strongly recommend consulting with a qualified healthcare professional for a comprehensive developmental evaluation.',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: AppColors.whiteColor.withOpacity(0.95),
                        height: 1.6,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Early intervention can significantly improve developmental outcomes and provide your child with the support they need to thrive.',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: AppColors.whiteColor.withOpacity(0.9),
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: size.customHeight(context) * 0.06,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.search, size: 20),
                        label: Text(
                          'Find Specialists Near You',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.whiteColor,
                          foregroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: size.customHeight(context) * 0.025),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.print_outlined, size: 20),
                      label: Text(
                        'Print Report',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primaryColor,
                        side: BorderSide(
                            color: AppColors.primaryColor, width: 1.5),
                        padding: EdgeInsets.symmetric(
                          vertical: size.customHeight(context) * 0.018,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.email_outlined, size: 20),
                      label: Text(
                        'Email Report',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: AppColors.whiteColor,
                        padding: EdgeInsets.symmetric(
                          vertical: size.customHeight(context) * 0.018,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: size.customHeight(context) * 0.03),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildInfoRow(
      BuildContext context, String label, String value, IconData icon) {
    final size = CustomSize();

    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20, color: AppColors.primaryColor),
          ),
          SizedBox(width: 12),
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
    );
  }
}