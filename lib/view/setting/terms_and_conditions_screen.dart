import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

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
          'Terms & Conditions',
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
                'Terms & Conditions',
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
                '1. Acceptance of Terms',
                'By accessing and using Speech Spectrum, you accept and agree to be bound by the terms and provision of this agreement.',
              ),
              _buildSection(
                '2. Use of Service',
                'Speech Spectrum is a screening tool designed to help parents identify potential speech delays linked to autism. It is not a diagnostic tool and should not replace professional medical advice.',
              ),
              _buildSection(
                '3. User Responsibilities',
                'You agree to provide accurate information and use the service responsibly. You understand that the results are preliminary and require professional evaluation.',
              ),
              _buildSection(
                '4. Privacy and Data',
                'We are committed to protecting your privacy. All data collected is handled according to our Privacy Policy and applicable laws.',
              ),
              _buildSection(
                '5. Disclaimer',
                'The app provides screening results based on AI analysis but does not constitute medical diagnosis. Always consult qualified healthcare professionals.',
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