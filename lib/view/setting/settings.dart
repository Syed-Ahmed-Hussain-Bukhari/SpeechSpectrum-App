import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../routes/app_routes.dart';
import 'package:speechspectrum/constants/app_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
          'Settings',
          style: GoogleFonts.poppins(
            color: AppColors.textPrimaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildSettingsSection(
            'Account',
            [
              _buildSettingsTile(Icons.person_outline, 'Edit Profile', () => Get.toNamed(AppRoutes.editProfile)),
              _buildSettingsTile(Icons.lock_outline, 'Change Password', () {}),
            ],
          ),
          _buildSettingsSection(
            'Preferences',
            [
              _buildSettingsTile(Icons.notifications_outlined, 'Notifications', () {}),
              _buildSettingsTile(Icons.language, 'Language', () {}),
            ],
          ),
          _buildSettingsSection(
            'Legal',
            [
              _buildSettingsTile(Icons.description_outlined, 'Terms & Conditions', () => Get.toNamed(AppRoutes.termsAndConditions)),
              _buildSettingsTile(Icons.privacy_tip_outlined, 'Privacy Policy', () => Get.toNamed(AppRoutes.privacyPolicy)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondaryColor,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(children: children),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSettingsTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primaryColor),
      title: Text(title, style: GoogleFonts.poppins()),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.greyColor),
      onTap: onTap,
    );
  }
}