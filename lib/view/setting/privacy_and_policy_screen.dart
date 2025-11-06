import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';


class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        padding: EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Privacy Policy',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryColor,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Last updated: November 2025',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: AppColors.textSecondaryColor,
                ),
              ),
              SizedBox(height: 20),
              _buildSection(
                'Information We Collect',
                'We collect information you provide directly, including child demographics, questionnaire responses, and voice samples for analysis.',
              ),
              _buildSection(
                'How We Use Your Information',
                'Your data is used to provide screening services, improve our AI models, and deliver personalized recommendations. All data is encrypted and stored securely.',
              ),
              _buildSection(
                'Data Security',
                'We implement industry-standard security measures to protect your data. Voice samples and personal information are encrypted both in transit and at rest.',
              ),
              _buildSection(
                'Your Rights',
                'You have the right to access, modify, or delete your data at any time. Contact us for data-related requests.',
              ),
              _buildSection(
                'Sharing Information',
                'We do not sell or share your personal information with third parties except as required by law or with your explicit consent.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimaryColor,
            ),
          ),
          SizedBox(height: 8),
          Text(
            content,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: AppColors.textSecondaryColor,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}