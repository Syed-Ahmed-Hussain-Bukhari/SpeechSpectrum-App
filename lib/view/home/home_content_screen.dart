import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../routes/app_routes.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';

class HomeContentScreen extends StatelessWidget {
  const HomeContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();
    
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(size.customWidth(context) * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Container(
              width: double.infinity,
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
                  Text(
                    'Empowering Parents Through',
                    style: GoogleFonts.poppins(
                      color: AppColors.whiteColor,
                      fontSize: size.customWidth(context) * 0.045,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Early Autism Screening',
                    style: GoogleFonts.poppins(
                      color: AppColors.whiteColor,
                      fontSize: size.customWidth(context) * 0.055,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: size.customHeight(context) * 0.01),
                  Text(
                    'An AI-powered tool for early screening of autism-linked speech delays in children',
                    style: GoogleFonts.poppins(
                      color: AppColors.whiteColor.withOpacity(0.9),
                      fontSize: size.customWidth(context) * 0.035,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: size.customHeight(context) * 0.03),
            
            Text(
              'Complete Both Steps for Accurate Screening',
              style: GoogleFonts.poppins(
                fontSize: size.customWidth(context) * 0.045,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimaryColor,
              ),
            ),
            SizedBox(height: size.customHeight(context) * 0.02),
            
            _buildScreeningCard(
              context: context,
              icon: Icons.assignment_outlined,
              title: 'Structured Questionnaire',
              subtitle: 'Answer behavioral questions',
              number: '1',
              // onTap: () => Get.toNamed(AppRoutes.questionnaire),
              onTap: () => Get.toNamed(AppRoutes.patientInfo),
            ),
            
            SizedBox(height: size.customHeight(context) * 0.02),
            
            _buildScreeningCard(
              context: context,
              icon: Icons.mic_outlined,
              title: 'Voice Sample Analysis',
              subtitle: 'Submit short voice recordings',
              number: '2',
              onTap: () => Get.toNamed(AppRoutes.voiceUpload),
            ),
            
            SizedBox(height: size.customHeight(context) * 0.03),
            
            // Quick Actions
            Text(
              'Quick Actions',
              style: GoogleFonts.poppins(
                fontSize: size.customWidth(context) * 0.045,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimaryColor,
              ),
            ),
            SizedBox(height: size.customHeight(context) * 0.02),
            
            Row(
              children: [
                Expanded(
                  child: _buildQuickActionCard(
                    context: context,
                    icon: Icons.bar_chart,
                    title: 'View Results',
                    onTap: () => Get.toNamed(AppRoutes.results),
                  ),
                ),
                SizedBox(width: size.customWidth(context) * 0.04),
                Expanded(
                  child: _buildQuickActionCard(
                    context: context,
                    icon: Icons.info_outline,
                    title: 'Learn More',
                    onTap: () => Get.toNamed(AppRoutes.learn),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScreeningCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required String number,
    required VoidCallback onTap,
  }) {
    final size = CustomSize();
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(size.customWidth(context) * 0.04),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  number,
                  style: GoogleFonts.poppins(
                    color: AppColors.primaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: size.customWidth(context) * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: size.customWidth(context) * 0.042,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimaryColor,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: size.customWidth(context) * 0.035,
                      color: AppColors.textSecondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              icon,
              color: AppColors.primaryColor,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    final size = CustomSize();
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(size.customWidth(context) * 0.04),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primaryColor, size: 35),
            SizedBox(height: size.customHeight(context) * 0.01),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: size.customWidth(context) * 0.035,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}