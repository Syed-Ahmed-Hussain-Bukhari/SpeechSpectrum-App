// view/auth/name_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/registration_controller.dart';
import '../../routes/app_routes.dart';
import '../../constants/app_colors.dart';
import '../../constants/custom_size.dart';

class NameScreen extends StatelessWidget {
  NameScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final RegistrationController regController = Get.find();

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
            LinearProgressIndicator(
              value: 2 / 4,
              backgroundColor: AppColors.greyColor.withOpacity(0.3),
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
              minHeight: size.customHeight(context) * 0.008,
            ),
            SizedBox(height: size.customHeight(context) * 0.008),
            Text(
              'STEP 2/4',
              style: GoogleFonts.poppins(
                fontSize: size.customWidth(context) * 0.03,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.customWidth(context) * 0.05),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.customHeight(context) * 0.03),

                /// Title
                Center(
                  child: Text(
                    'What\'s Your Name?',
                    style: GoogleFonts.poppins(
                      fontSize: size.customWidth(context) * 0.06,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimaryColor,
                    ),
                  ),
                ),

                SizedBox(height: size.customHeight(context) * 0.01),

                /// Subtitle
                Center(
                  child: Text(
                    'Please enter your full name to continue',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: size.customWidth(context) * 0.038,
                      color: AppColors.textSecondaryColor,
                    ),
                  ),
                ),

                SizedBox(height: size.customHeight(context) * 0.05),

                /// First Name Field
                _buildTextField(
                  context: context,
                  controller: _firstNameController,
                  hintText: 'First Name',
                  icon: Icons.person_outline,
                  validator: (val) =>
                      val == null || val.trim().isEmpty ? 'First name is required' : null,
                ),

                SizedBox(height: size.customHeight(context) * 0.02),

                /// Last Name Field
                _buildTextField(
                  context: context,
                  controller: _lastNameController,
                  hintText: 'Last Name',
                  icon: Icons.person_outline,
                  validator: (val) =>
                      val == null || val.trim().isEmpty ? 'Last name is required' : null,
                ),

                const Spacer(),

                /// Continue Button
                SizedBox(
                  width: double.infinity,
                  height: size.customHeight(context) * 0.065,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        regController.setNames(
                          _firstNameController.text.trim(),
                          _lastNameController.text.trim(),
                        );
                        Get.toNamed(AppRoutes.phoneScreen);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(size.customHeight(context) * 0.2),
                      ),
                      elevation: 3,
                    ),
                    child: Text(
                      'Continue',
                      style: GoogleFonts.poppins(
                        fontSize: size.customWidth(context) * 0.045,
                        fontWeight: FontWeight.w600,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: size.customHeight(context) * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required BuildContext context,
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    String? Function(String?)? validator,
  }) {
    final size = CustomSize();

    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(size.customHeight(context) * 0.2),
        boxShadow: [
          BoxShadow(
            color: AppColors.greyColor.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        cursorColor: AppColors.primaryColor,
        style: GoogleFonts.poppins(
          fontSize: size.customWidth(context) * 0.04,
          color: AppColors.textPrimaryColor,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: AppColors.primaryColor),
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            fontSize: size.customWidth(context) * 0.04,
            color: AppColors.greyColor,
          ),
          filled: true,
          fillColor: AppColors.whiteColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(size.customHeight(context) * 0.2),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(size.customHeight(context) * 0.2),
            borderSide: BorderSide(color: AppColors.greyColor.withOpacity(0.3), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(size.customHeight(context) * 0.2),
            borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(size.customHeight(context) * 0.2),
            borderSide: BorderSide(color: AppColors.errorColor, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(size.customHeight(context) * 0.2),
            borderSide: BorderSide(color: AppColors.errorColor, width: 2),
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: size.customHeight(context) * 0.02,
            horizontal: size.customWidth(context) * 0.04,
          ),
        ),
      ),
    );
  }
}