// view/auth/role_selection_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/role_selection_controller.dart';
import '../../controllers/registration_controller.dart';
import '../../components/custom_button.dart';
import '../../constants/app_colors.dart';
import '../../constants/custom_size.dart';

class RoleSelectionScreen extends StatelessWidget {
  RoleSelectionScreen({super.key});

  final RoleSelectionController controller = Get.put(RoleSelectionController());
  final RegistrationController regController = Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.blackColor),
          onPressed: () => Get.back(),
        ),
        title: Column(
          children: [
            SizedBox(height: size.customHeight(context) * 0.025),
            // LinearProgressIndicator(
            //   value: 1 / 4,
            //   backgroundColor: AppColors.greyColor.withOpacity(0.3),
            //   valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
            //   minHeight: size.customHeight(context) * 0.008,
            // ),
                  Obx(() {
              // Calculate progress based on role
              final isExpert = regController.role.value == 'expert';
              final currentStep = isExpert ? 1 : 1;
              final totalSteps = isExpert ? 6 : 4;
              final progress = currentStep / totalSteps;

              return LinearProgressIndicator(
                value: progress,
                backgroundColor: AppColors.greyColor.withOpacity(0.3),
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                minHeight: size.customHeight(context) * 0.008,
              );
            }),

            SizedBox(height: size.customHeight(context) * 0.008),
             Obx(() {
              final isExpert = regController.role.value == 'expert';
              final stepText = isExpert ? 'STEP 1/6' : 'STEP 1/4';
              
              return Text(
                stepText,
                style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.03,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
              );
            }),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.customWidth(context) * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.customHeight(context) * 0.04),

              /// Title
              Center(
                child: Text(
                  'Who Are You?',
                  style: GoogleFonts.poppins(
                    fontSize: size.customWidth(context) * 0.065,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimaryColor,
                  ),
                ),
              ),

              SizedBox(height: size.customHeight(context) * 0.01),

              /// Subtitle
              Center(
                child: Text(
                  'Please select your role to continue',
                  style: GoogleFonts.poppins(
                    fontSize: size.customWidth(context) * 0.04,
                    color: AppColors.textSecondaryColor,
                  ),
                ),
              ),

              SizedBox(height: size.customHeight(context) * 0.05),

              /// Parent Option
              Obx(
                () => _buildRoleCard(
                  context,
                  size: size,
                  title: 'Parent',
                  description: 'I am a parent looking for help',
                  imagePath: 'assets/images/parent_role.jpg',
                  isSelected: controller.selectedRole.value == 'parent',
                  onTap: () {
                    controller.selectRole('parent');
                    regController.setRole('parent');
                  },
                ),
              ),

              SizedBox(height: size.customHeight(context) * 0.02),

              /// Expert Option
              Obx(
                () => _buildRoleCard(
                  context,
                  size: size,
                  title: 'Therapist',
                  description: 'I am a therapist',
                  imagePath: 'assets/images/therapist_role.jpg',
                  isSelected: controller.selectedRole.value == 'expert',
                  onTap: () {
                    controller.selectRole('expert');
                    regController.setRole('expert');
                  },
                ),
              ),

              const Spacer(),

              /// Continue Button
              Obx(
                () => CustomButton(
                  title: 'Continue',
                  height: size.customHeight(context) * 0.065,
                  width: double.infinity,
                  radius: size.customHeight(context) * 0.2,
                  color: AppColors.primaryColor,
                  loading: false,
                  onTap: controller.selectedRole.value.isNotEmpty
                      ? controller.continueNext
                      : null,
                ),
              ),

              SizedBox(height: size.customHeight(context) * 0.04),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard(
  BuildContext context, {
  required CustomSize size,
  required String title,
  required String description,
  required String imagePath,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.all(size.customWidth(context) * 0.04),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(size.customHeight(context) * 0.015),
        border: Border.all(
          color: isSelected
              ? AppColors.primaryColor
              : AppColors.greyColor.withOpacity(0.3),
          width: isSelected ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isSelected
                ? AppColors.primaryColor.withOpacity(0.2)
                : AppColors.greyColor.withOpacity(0.1),
            blurRadius: isSelected ? 8 : 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          /// IMAGE (instead of icon)
          Container(
            // padding: EdgeInsets.all(size.customWidth(context) * 0.025),
           
            child: Image.asset(
              imagePath,
              height: size.customHeight(context) * 0.13,
              fit: BoxFit.contain,
            ),
          ),

          SizedBox(width: size.customWidth(context) * 0.04),

          /// TEXT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: size.customWidth(context) * 0.045,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimaryColor,
                  ),
                ),
                SizedBox(height: size.customHeight(context) * 0.005),
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

          /// CHECK ICON
          if (isSelected)
            Icon(
              Icons.check_circle,
              color: AppColors.primaryColor,
              size: size.customWidth(context) * 0.06,
            ),
        ],
      ),
    ),
  );
}

}