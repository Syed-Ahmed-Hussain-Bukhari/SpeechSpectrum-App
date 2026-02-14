// lib/view/expert/expert_home_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import 'package:speechspectrum/routes/app_routes.dart';

class ExpertHomeScreen extends StatelessWidget {
  const ExpertHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();

    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        title: Text(
          'Expert Dashboard',
          style: GoogleFonts.poppins(
            color: AppColors.textPrimaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          // Consultations Icon
          IconButton(
            icon: const Icon(
              Icons.medical_services_outlined,
              color: AppColors.primaryColor,
            ),
            tooltip: 'View Consultations',
            onPressed: () {
              Get.toNamed(AppRoutes.expertConsultations);
            },
          ),
          // Linked Families Icon
          IconButton(
            icon: const Icon(
              Icons.link_outlined,
              color: AppColors.primaryColor,
            ),
            tooltip: 'Linked Families',
            onPressed: () {
              Get.toNamed(AppRoutes.expertLinkedParents);
            },
          ),
          SizedBox(width: size.customWidth(context) * 0.02),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(size.customWidth(context) * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Welcome Icon
              Container(
                width: size.customWidth(context) * 0.4,
                height: size.customWidth(context) * 0.4,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primaryColor.withOpacity(0.1),
                      AppColors.secondaryColor.withOpacity(0.1),
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.medical_information_outlined,
                  size: size.customWidth(context) * 0.2,
                  color: AppColors.primaryColor,
                ),
              ),

              SizedBox(height: size.customHeight(context) * 0.04),

              // Welcome Text
              Text(
                'Welcome, Expert!',
                style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.06,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryColor,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: size.customHeight(context) * 0.015),

              Text(
                'Your dashboard is under construction',
                style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.04,
                  color: AppColors.textSecondaryColor,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: size.customHeight(context) * 0.05),

              // Quick Action Cards
              _buildQuickActionCard(
                context: context,
                icon: Icons.medical_services_outlined,
                title: 'View Consultations',
                subtitle: 'Manage consultation requests',
                color: AppColors.primaryColor,
                onTap: () => Get.toNamed(AppRoutes.expertConsultations),
                size: size,
              ),

              SizedBox(height: size.customHeight(context) * 0.02),

              _buildQuickActionCard(
                context: context,
                icon: Icons.link_outlined,
                title: 'Linked Families',
                subtitle: 'View your linked families',
                color: AppColors.accentColor,
                onTap: () => Get.toNamed(AppRoutes.expertLinkedParents),
                size: size,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActionCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
    required CustomSize size,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: EdgeInsets.all(size.customWidth(context) * 0.04),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        color.withOpacity(0.8),
                        color,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    icon,
                    color: AppColors.whiteColor,
                    size: 28,
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
                      SizedBox(height: size.customHeight(context) * 0.004),
                      Text(
                        subtitle,
                        style: GoogleFonts.poppins(
                          fontSize: size.customWidth(context) * 0.034,
                          color: AppColors.textSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18,
                  color: AppColors.greyColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}