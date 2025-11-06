import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';


class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

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
        padding: EdgeInsets.all(size.customWidth(context) * 0.05),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(size.customWidth(context) * 0.06),
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
                  Icon(Icons.waves_outlined, size: 80, color: AppColors.whiteColor),
                  SizedBox(height: 16),
                  Text(
                    'Speech Spectrum',
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  Text(
                    'Version 1.0.0',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: AppColors.whiteColor.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: size.customHeight(context) * 0.03),
            
            Container(
              padding: EdgeInsets.all(size.customWidth(context) * 0.05),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About Speech Spectrum',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimaryColor,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Speech Spectrum is an AI-powered application designed to help parents identify potential speech delays linked to Autism Spectrum Disorder in young children aged 1-5 years.',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: AppColors.textSecondaryColor,
                      height: 1.6,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Our mission is to empower parents through early screening, awareness, and timely intervention, making autism detection accessible and simple for families everywhere.',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: AppColors.textSecondaryColor,
                      height: 1.6,
                    ),
                  ),
                  SizedBox(height: 20),
                  Divider(),
                  SizedBox(height: 12),
                  _buildInfoRow(Icons.email, 'support@speechspectrum.com'),
                  _buildInfoRow(Icons.language, 'www.speechspectrum.com'),
                  _buildInfoRow(Icons.location_on, 'Karachi, Pakistan'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryColor, size: 20),
          SizedBox(width: 12),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: AppColors.textSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}