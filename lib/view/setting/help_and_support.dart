import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

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
          'Help & Support',
          style: GoogleFonts.poppins(
            color: AppColors.textPrimaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: AppColors.textPrimaryColor),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(size.customWidth(context) * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quick Actions Card
            Container(
              padding: EdgeInsets.all(size.customWidth(context) * 0.04),
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
                  Icon(Icons.support_agent, color: AppColors.whiteColor, size: 48),
                  SizedBox(height: 12),
                  Text(
                    'How can we help you today?',
                    style: GoogleFonts.poppins(
                      color: AppColors.whiteColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildQuickActionButton(
                          context,
                          Icons.chat_bubble_outline,
                          'Chat',
                          () {},
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: _buildQuickActionButton(
                          context,
                          Icons.phone_outlined,
                          'Call',
                          () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: size.customHeight(context) * 0.03),
            
            // FAQ Section
            Text(
              'Frequently Asked Questions',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimaryColor,
              ),
            ),
            SizedBox(height: 16),
            
            _buildFAQItem(
              context,
              'What is Autism Care?',
              'Autism Care is an AI-powered screening tool designed to help parents identify potential early signs of Autism Spectrum Disorder (ASD) in children aged 1-5 years through questionnaires and voice analysis.',
            ),
            _buildFAQItem(
              context,
              'How accurate is the screening?',
              'Our screening tool uses advanced machine learning models trained on validated datasets. However, it is not a diagnostic tool. We recommend consulting healthcare professionals for comprehensive evaluation.',
            ),
            _buildFAQItem(
              context,
              'Is my child\'s data secure?',
              'Yes. We prioritize your privacy and security. All data is encrypted and stored securely. We never share personal information without explicit consent.',
            ),
            _buildFAQItem(
              context,
              'How do I interpret the results?',
              'Results are presented as a risk score with detailed breakdown. Higher scores indicate greater concern and recommend professional consultation. Our app provides guidance but is not a replacement for medical diagnosis.',
            ),
            
            SizedBox(height: size.customHeight(context) * 0.03),
            
            // Contact Support
            Text(
              'Contact Support',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimaryColor,
              ),
            ),
            SizedBox(height: 16),
            
            _buildContactCard(
              context,
              Icons.email_outlined,
              'Email Support',
              'support@autismcare.com',
              () {},
            ),
            SizedBox(height: 12),
            _buildContactCard(
              context,
              Icons.phone_outlined,
              'Phone Support',
              '+1 (800) 123-4567',
              () {},
            ),
            SizedBox(height: 12),
            _buildContactCard(
              context,
              Icons.language,
              'Visit Website',
              'www.autismcare.com',
              () {},
            ),
            
            SizedBox(height: size.customHeight(context) * 0.03),
            
            // Report Issue Button
            SizedBox(
              width: double.infinity,
              height: size.customHeight(context) * 0.06,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.bug_report_outlined),
                label: Text(
                  'Report an Issue',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: AppColors.whiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionButton(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onTap,
  ) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.whiteColor,
        foregroundColor: AppColors.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        children: [
          Icon(icon, size: 24),
          SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQItem(BuildContext context, String question, String answer) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(
            question,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimaryColor,
            ),
          ),
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                answer,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: AppColors.textSecondaryColor,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.primaryColor, size: 24),
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
                  SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: AppColors.textSecondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: AppColors.greyColor),
          ],
        ),
      ),
    );
  }
}