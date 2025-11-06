import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/components/custom_button.dart';
import '../../routes/app_routes.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';


class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();

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
                        colors: [AppColors.accentColor, AppColors.primaryColor],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(size.customHeight(context) * 0.1),
                    ),
                    child: Icon(
                      Icons.lock_reset,
                      size: size.customHeight(context) * 0.1,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
                
                SizedBox(height: size.customHeight(context) * 0.04),
                
                // Title
                Center(
                  child: Text(
                    'Forgot Password?',
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
                      'Don\'t worry! Enter your email address and we\'ll send you a link to reset your password.',
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
                
                // Email field
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) return 'Email is required';
                    if (!val.contains('@') || !val.contains('.'))
                      return 'Enter a valid email';
                    return null;
                  },
                  cursorColor: AppColors.primaryColor,
                  style: GoogleFonts.poppins(
                    fontSize: size.customWidth(context) * 0.04,
                    color: AppColors.textPrimaryColor,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined, color: AppColors.primaryColor),
                    hintText: 'Email Address',
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
                ),
                
                SizedBox(height: size.customHeight(context) * 0.04),
                
                // Send reset link button
                CustomButton(
                  title: 'Send Reset Link',
                  height: size.customHeight(context) * 0.065,
                  width: double.infinity,
                  radius: size.customHeight(context) * 0.2,
                  color: AppColors.primaryColor,
                  loading: false,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      // Handle send reset link
                      print('Send reset link to: ${_emailController.text}');
                      // Navigate to set password screen
                      Get.toNamed(AppRoutes.setPassword);
                    }
                  },
                ),
                
                SizedBox(height: size.customHeight(context) * 0.03),
                
                // Back to login
                Center(
                  child: TextButton(
                    onPressed: () => Get.back(),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.arrow_back,
                          size: size.customWidth(context) * 0.045,
                          color: AppColors.primaryColor,
                        ),
                        SizedBox(width: size.customWidth(context) * 0.02),
                        Text(
                          'Back to Log In',
                          style: GoogleFonts.poppins(
                            fontSize: size.customWidth(context) * 0.04,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}