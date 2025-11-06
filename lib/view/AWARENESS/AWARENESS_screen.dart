import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';

class AwarenessScreen extends StatelessWidget {
  const AwarenessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(size.customWidth(context) * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Autism Awareness',
            style: GoogleFonts.poppins(
              fontSize: size.customWidth(context) * 0.06,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimaryColor,
            ),
          ),
          SizedBox(height: size.customHeight(context) * 0.01),
          Text(
            'Learn about early signs and developmental milestones',
            style: GoogleFonts.poppins(
              fontSize: size.customWidth(context) * 0.038,
              color: AppColors.textSecondaryColor,
            ),
          ),
          
          SizedBox(height: size.customHeight(context) * 0.03),
          
          _buildAwarenessCard(
            context: context,
            icon: Icons.warning_amber_outlined,
            title: 'Early Signs of Autism',
            description: 'Understanding the early indicators in speech and behavior',
            color: AppColors.warningColor,
          ),
          _buildAwarenessCard(
            context: context,
            icon: Icons.child_care,
            title: 'Developmental Milestones',
            description: 'Age-appropriate speech and communication milestones',
            color: AppColors.primaryColor,
          ),
          _buildAwarenessCard(
            context: context,
            icon: Icons.tips_and_updates,
            title: 'Supporting Your Child',
            description: 'Tips for encouraging language and social development',
            color: AppColors.successColor,
          ),
          _buildAwarenessCard(
            context: context,
            icon: Icons.local_hospital_outlined,
            title: 'When to Seek Help',
            description: 'Guidance on consulting healthcare professionals',
            color: AppColors.errorColor,
          ),
        ],
      ),
    );
  }

  Widget _buildAwarenessCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    final size = CustomSize();
    
    return Container(
      margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.02),
      padding: EdgeInsets.all(size.customWidth(context) * 0.04),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 30),
          ),
          SizedBox(width: 16),
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
                SizedBox(height: 4),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: size.customWidth(context) * 0.035,
                    color: AppColors.textSecondaryColor,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.greyColor),
        ],
      ),
    );
  }
}
