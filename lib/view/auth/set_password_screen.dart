import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/components/custom_button.dart';
import '../../controllers/password_controller.dart';
import '../../routes/app_routes.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';


class SetPasswordScreen extends StatelessWidget {
  SetPasswordScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();
    final passwordController = Get.put(PasswordController());

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimaryColor),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: size.customWidth(context) * 0.05,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.customHeight(context) * 0.02),
                
                // Illustration
                Center(
                  child: Container(
                    height: size.customHeight(context) * 0.2,
                    width: size.customHeight(context) * 0.2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.successColor, Color(0xFF27AE60)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(size.customHeight(context) * 0.1),
                    ),
                    child: Icon(
                      Icons.lock_open,
                      size: size.customHeight(context) * 0.1,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
                
                SizedBox(height: size.customHeight(context) * 0.04),
                
                // Title
                Center(
                  child: Text(
                    'Set New Password',
                    style: GoogleFonts.poppins(
                      fontSize: size.customWidth(context) * 0.07,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimaryColor,
                    ),
                  ),
                ),
                
                SizedBox(height: size.customHeight(context) * 0.015),
                
                // Description
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.customWidth(context) * 0.05,
                    ),
                    child: Text(
                      'Create a strong password for your account. Make sure it\'s at least 6 characters long.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: size.customWidth(context) * 0.038,
                        color: AppColors.textSecondaryColor,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
                
                SizedBox(height: size.customHeight(context) * 0.05),
                
                // New password field
                Obx(() => _buildPasswordField(
                      context: context,
                      controller: _passwordController,
                      hintText: 'New Password',
                      obscureText: passwordController.isPasswordHidden.value,
                      onToggle: passwordController.togglePasswordVisibility,
                      validator: (val) {
                        if (val == null || val.isEmpty) return 'Password is required';
                        if (val.length < 6) return 'Minimum 6 characters required';
                        return null;
                      },
                    )),
                
                SizedBox(height: size.customHeight(context) * 0.02),
                
                // Confirm password field
                Obx(() => _buildPasswordField(
                      context: context,
                      controller: _confirmPasswordController,
                      hintText: 'Confirm Password',
                      obscureText: passwordController.isConfirmPasswordHidden.value,
                      onToggle: passwordController.toggleConfirmPasswordVisibility,
                      validator: (val) {
                        if (val == null || val.isEmpty)
                          return 'Please confirm password';
                        if (val != _passwordController.text)
                          return 'Passwords do not match';
                        return null;
                      },
                    )),
                
                SizedBox(height: size.customHeight(context) * 0.03),
                
                // Password requirements
                Container(
                  padding: EdgeInsets.all(size.customWidth(context) * 0.04),
                  decoration: BoxDecoration(
                    color: AppColors.lightGreyColor,
                    borderRadius: BorderRadius.circular(size.customHeight(context) * 0.015),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Password must contain:',
                        style: GoogleFonts.poppins(
                          fontSize: size.customWidth(context) * 0.035,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimaryColor,
                        ),
                      ),
                      SizedBox(height: size.customHeight(context) * 0.01),
                      _buildRequirement(context, 'At least 6 characters'),
                      _buildRequirement(context, 'Mix of letters and numbers (recommended)'),
                      _buildRequirement(context, 'At least one special character (recommended)'),
                    ],
                  ),
                ),
                
                SizedBox(height: size.customHeight(context) * 0.04),
                
                // Set password button
                CustomButton(
                  title: 'Set Password',
                  height: size.customHeight(context) * 0.065,
                  width: double.infinity,
                  radius: size.customHeight(context) * 0.2,
                  color: AppColors.primaryColor,
                  loading: false,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      // Handle set password
                      print('Password set successfully');
                      // Show success dialog or navigate to login
                      _showSuccessDialog(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required BuildContext context,
    required TextEditingController controller,
    required String hintText,
    required bool obscureText,
    required VoidCallback onToggle,
    String? Function(String?)? validator,
  }) {
    final size = CustomSize();
    
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      cursorColor: AppColors.primaryColor,
      style: GoogleFonts.poppins(
        fontSize: size.customWidth(context) * 0.04,
        color: AppColors.textPrimaryColor,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock_outline, color: AppColors.primaryColor),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            color: AppColors.greyColor,
          ),
          onPressed: onToggle,
        ),
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
          fontSize: size.customWidth(context) * 0.04,
          color: AppColors.greyColor,
        ),
        filled: true,
        fillColor: AppColors.lightGreyColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(size.customHeight(context) * 0.015),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(size.customHeight(context) * 0.015),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(size.customHeight(context) * 0.015),
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(size.customHeight(context) * 0.015),
          borderSide: BorderSide(color: AppColors.errorColor, width: 1.5),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: size.customHeight(context) * 0.02,
          horizontal: size.customWidth(context) * 0.04,
        ),
      ),
    );
  }

  Widget _buildRequirement(BuildContext context, String text) {
    final size = CustomSize();
    
    return Padding(
      padding: EdgeInsets.only(bottom: size.customHeight(context) * 0.005),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline,
            size: size.customWidth(context) * 0.04,
            color: AppColors.primaryColor,
          ),
          SizedBox(width: size.customWidth(context) * 0.02),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: size.customWidth(context) * 0.033,
                color: AppColors.textSecondaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    final size = CustomSize();
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(size.customHeight(context) * 0.02),
          ),
          child: Padding(
            padding: EdgeInsets.all(size.customWidth(context) * 0.05),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: size.customHeight(context) * 0.1,
                  width: size.customHeight(context) * 0.1,
                  decoration: BoxDecoration(
                    color: AppColors.successColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check,
                    color: AppColors.whiteColor,
                    size: size.customHeight(context) * 0.06,
                  ),
                ),
                SizedBox(height: size.customHeight(context) * 0.02),
                Text(
                  'Success!',
                  style: GoogleFonts.poppins(
                    fontSize: size.customWidth(context) * 0.055,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimaryColor,
                  ),
                ),
                SizedBox(height: size.customHeight(context) * 0.01),
                Text(
                  'Your password has been reset successfully.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: size.customWidth(context) * 0.038,
                    color: AppColors.textSecondaryColor,
                  ),
                ),
                SizedBox(height: size.customHeight(context) * 0.03),
                CustomButton(
                  title: 'Go to Log In',
                  height: size.customHeight(context) * 0.055,
                  width: double.infinity,
                  radius: size.customHeight(context) * 0.2,
                  color: AppColors.primaryColor,
                  loading: false,
                  onTap: () {
                    Get.offAllNamed(AppRoutes.login);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}