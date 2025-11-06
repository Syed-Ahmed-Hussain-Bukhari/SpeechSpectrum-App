import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../routes/app_routes.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(size.customWidth(context) * 0.05),
      child: Column(
        children: [
          // Profile Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top:size.customWidth(context) * 0.05,bottom:size.customWidth(context) * 0.05),
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
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.whiteColor, width: 4),
                  ),
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Syed Ahmed',
                  style: GoogleFonts.poppins(
                    color: AppColors.whiteColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'ahmed@email.com',
                  style: GoogleFonts.poppins(
                    color: AppColors.whiteColor.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => Get.toNamed(AppRoutes.editProfile),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Edit Profile',
                    style: GoogleFonts.poppins(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: size.customHeight(context) * 0.03),
          
          // Profile Options
          _buildProfileOption(
            context: context,
            icon: Icons.child_care,
            title: 'My Children',
            subtitle: '2 children profiles',
            onTap: () {},
          ),
          _buildProfileOption(
            context: context,
            icon: Icons.history,
            title: 'Screening History',
            subtitle: 'View past screenings',
            onTap: () => Get.toNamed(AppRoutes.results),
          ),
          _buildProfileOption(
            context: context,
            icon: Icons.notifications_outlined,
            title: 'Notifications',
            subtitle: 'Manage notifications',
            onTap: () {
              // Get.toNamed(AppRoutes.notification);
            },
          ),
          _buildProfileOption(
            context: context,
            icon: Icons.settings_outlined,
            title: 'Settings',
            subtitle: 'App preferences',
            onTap: () => Get.toNamed(AppRoutes.settings),
          ),
          _buildProfileOption(
            context: context,
            icon: Icons.help_outline,
            title: 'Help & Support',
            subtitle: 'Get help',
            onTap: () {
              Get.toNamed(AppRoutes.help);
            },
          ),
          _buildProfileOption(
            context: context,
            icon: Icons.logout,
            title: 'Logout',
            subtitle: 'Sign out of your account',
            onTap: () => Get.offAllNamed(AppRoutes.login),
            isDestructive: true,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOption({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    final size = CustomSize();
    
    return Container(
      margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.015),
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
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: (isDestructive ? AppColors.errorColor : AppColors.primaryColor).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: isDestructive ? AppColors.errorColor : AppColors.primaryColor,
          ),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: isDestructive ? AppColors.errorColor : AppColors.textPrimaryColor,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: AppColors.textSecondaryColor,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: AppColors.greyColor,
        ),
      ),
    );
  }
}
