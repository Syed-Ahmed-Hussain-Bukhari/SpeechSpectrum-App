// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';

// class ResultsScreen extends StatelessWidget {
//   const ResultsScreen({super.key});

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
//           onPressed: (){
//             Navigator.pop(context);
//           },
//         ),
//         title: Text(
//           'Screening Results',
//           style: GoogleFonts.poppins(
//             color: AppColors.textPrimaryColor,
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(size.customWidth(context) * 0.05),
//         child: Column(
//           children: [
//             // Risk Score Card
//             Container(
//               padding: EdgeInsets.all(size.customWidth(context) * 0.05),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [AppColors.warningColor, Colors.orange.shade300],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Column(
//                 children: [
//                   Icon(Icons.analytics, color: AppColors.whiteColor, size: 50),
//                   SizedBox(height: 16),
//                   Text(
//                     'Autism Risk Score',
//                     style: GoogleFonts.poppins(
//                       color: AppColors.whiteColor,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     '5 / 10',
//                     style: GoogleFonts.poppins(
//                       color: AppColors.whiteColor,
//                       fontSize: 48,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     'Moderate Risk',
//                     style: GoogleFonts.poppins(
//                       color: AppColors.whiteColor,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
            
//             SizedBox(height: size.customHeight(context) * 0.03),
            
//             // Recommendation Card
//             Container(
//               padding: EdgeInsets.all(size.customWidth(context) * 0.05),
//               decoration: BoxDecoration(
//                 color: AppColors.whiteColor,
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Icon(Icons.info_outline, color: AppColors.primaryColor),
//                       SizedBox(width: 8),
//                       Text(
//                         'Recommendation',
//                         style: GoogleFonts.poppins(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: AppColors.textPrimaryColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 12),
//                   Text(
//                     'Based on the screening results, we recommend consulting with a healthcare professional for a comprehensive evaluation. Early intervention can significantly improve outcomes.',
//                     style: GoogleFonts.poppins(
//                       fontSize: 14,
//                       color: AppColors.textSecondaryColor,
//                       height: 1.5,
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.primaryColor,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     child: Text(
//                       'Find Specialists Near You',
//                       style: GoogleFonts.poppins(color: AppColors.whiteColor),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
            
//             SizedBox(height: size.customHeight(context) * 0.02),
            
//             // Analysis Breakdown
//             Container(
//               padding: EdgeInsets.all(size.customWidth(context) * 0.05),
//               decoration: BoxDecoration(
//                 color: AppColors.whiteColor,
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Analysis Breakdown',
//                     style: GoogleFonts.poppins(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.textPrimaryColor,
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   _buildAnalysisItem('Questionnaire Score', '4/10', AppColors.warningColor),
//                   _buildAnalysisItem('Voice Analysis', 'Moderate concerns', AppColors.warningColor),
//                   _buildAnalysisItem('Social Interaction', 'Needs attention', AppColors.errorColor),
//                   _buildAnalysisItem('Communication', 'Some concerns', AppColors.warningColor),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAnalysisItem(String label, String value, Color color) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 12),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: GoogleFonts.poppins(
//               fontSize: 14,
//               color: AppColors.textSecondaryColor,
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//             decoration: BoxDecoration(
//               color: color.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Text(
//               value,
//               style: GoogleFonts.poppins(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w600,
//                 color: color,
//               ),
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
import 'package:speechspectrum/constants/custom_size.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();
    
    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimaryColor),
          onPressed: () => Navigator.pop(context),
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(size.customWidth(context) * 0.05),
        child: Column(
          children: [
            // Date & Status Badge
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
                  Icon(Icons.calendar_today, size: 14, color: AppColors.textSecondaryColor),
                  SizedBox(width: 6),
                  Text(
                    'Assessment Date: November 6, 2025',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: AppColors.textSecondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: size.customHeight(context) * 0.02),
            
            // Risk Score Card with Circular Progress
            Container(
              padding: EdgeInsets.all(size.customWidth(context) * 0.06),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.warningColor, Colors.orange.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.warningColor.withOpacity(0.3),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Circular Progress Indicator
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: size.customHeight(context) * 0.18,
                        width: size.customHeight(context) * 0.18,
                        child: CircularProgressIndicator(
                          value: 0.5,
                          strokeWidth: 12,
                          backgroundColor: AppColors.whiteColor.withOpacity(0.3),
                          valueColor: AlwaysStoppedAnimation<Color>(AppColors.whiteColor),
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            '5',
                            style: GoogleFonts.poppins(
                              color: AppColors.whiteColor,
                              fontSize: 56,
                              fontWeight: FontWeight.bold,
                              height: 1,
                            ),
                          ),
                          Text(
                            'out of 10',
                            style: GoogleFonts.poppins(
                              color: AppColors.whiteColor.withOpacity(0.9),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: size.customHeight(context) * 0.025),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Moderate Risk Level',
                      style: GoogleFonts.poppins(
                        color: AppColors.whiteColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  SizedBox(height: size.customHeight(context) * 0.015),
                  Text(
                    'Based on questionnaire responses and speech analysis',
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
                  Icon(Icons.info_outline, color: AppColors.accentColor, size: 22),
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
            
            // Analysis Breakdown
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
                        'Detailed Analysis',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  _buildAnalysisItem(
                    context,
                    'Behavioral Questionnaire',
                    '4/10',
                    0.4,
                    AppColors.warningColor,
                    'Moderate indicators present',
                  ),
                  _buildAnalysisItem(
                    context,
                    'Speech Pattern Analysis',
                    'Moderate',
                    0.5,
                    AppColors.warningColor,
                    'Vocal features show some concerns',
                  ),
                  _buildAnalysisItem(
                    context,
                    'Social Interaction',
                    'High',
                    0.7,
                    AppColors.errorColor,
                    'Needs professional attention',
                  ),
                  _buildAnalysisItem(
                    context,
                    'Communication Skills',
                    'Moderate',
                    0.45,
                    AppColors.warningColor,
                    'Some developmental concerns',
                  ),
                ],
              ),
            ),
            
            SizedBox(height: size.customHeight(context) * 0.025),
            
            // Key Observations
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
                          color: AppColors.accentColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.visibility_outlined, 
                          color: AppColors.accentColor, size: 20),
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Key Observations',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  _buildObservationPoint(
                    'Limited eye contact during social interactions',
                    Icons.remove_red_eye_outlined,
                  ),
                  _buildObservationPoint(
                    'Delayed response to verbal communication',
                    Icons.chat_bubble_outline,
                  ),
                  _buildObservationPoint(
                    'Repetitive speech patterns detected',
                    Icons.repeat,
                  ),
                  _buildObservationPoint(
                    'Difficulty with reciprocal conversation',
                    Icons.people_outline,
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
                  colors: [AppColors.primaryColor, AppColors.secondaryColor],
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
                    'Based on the screening results, we strongly recommend consulting with a qualified healthcare professional for a comprehensive developmental evaluation.',
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
            
            // Next Steps
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
                          color: AppColors.successColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.list_alt, 
                          color: AppColors.successColor, size: 20),
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Suggested Next Steps',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  _buildNextStepItem(
                    '1',
                    'Schedule consultation',
                    'Book an appointment with a pediatric specialist or developmental pediatrician',
                  ),
                  _buildNextStepItem(
                    '2',
                    'Document observations',
                    'Keep a diary of your child\'s behaviors, communication patterns, and social interactions',
                  ),
                  _buildNextStepItem(
                    '3',
                    'Explore resources',
                    'Review educational materials and support groups in our Learn section',
                  ),
                  _buildNextStepItem(
                    '4',
                    'Follow-up screening',
                    'Complete another assessment in 3 months to track developmental progress',
                  ),
                ],
              ),
            ),
            
            SizedBox(height: size.customHeight(context) * 0.02),
            
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
                      side: BorderSide(color: AppColors.primaryColor, width: 1.5),
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
      ),
    );
  }

  Widget _buildAnalysisItem(
    BuildContext context,
    String label,
    String value,
    double progress,
    Color color,
    String description,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: color.withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 8,
            ),
          ),
          SizedBox(height: 6),
          Text(
            description,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: AppColors.textSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildObservationPoint(String text, IconData icon) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 2),
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: AppColors.primaryColor),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: AppColors.textPrimaryColor,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextStepItem(String number, String title, String description) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.successColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimaryColor,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColors.textSecondaryColor,
                    height: 1.4,
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