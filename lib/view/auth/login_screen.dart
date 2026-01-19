import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/components/custom_button.dart';
import 'package:speechspectrum/view/home/home_screen.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/password_controller.dart';
import '../../routes/app_routes.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();
    final passwordController = Get.put(PasswordController());
    final authController = Get.put(AuthController());

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
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
                SizedBox(height: size.customHeight(context) * 0.06),
                
                // Logo and title
                Center(
                  child: Column(
                    children: [
                      Container(
                        height: size.customHeight(context) * 0.12,
                        width: size.customHeight(context) * 0.12,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [AppColors.primaryColor, AppColors.secondaryColor],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(size.customHeight(context) * 0.03),
                        ),
                        child: Icon(
                          Icons.waves_outlined,
                          size: size.customHeight(context) * 0.07,
                          color: AppColors.whiteColor,
                        ),
                      ),
                      SizedBox(height: size.customHeight(context) * 0.02),
                      Text(
                        'Welcome Back',
                        style: GoogleFonts.poppins(
                          fontSize: size.customWidth(context) * 0.07,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimaryColor,
                        ),
                      ),
                      SizedBox(height: size.customHeight(context) * 0.01),
                      Text(
                        'Continue your child\'s development journey',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: size.customWidth(context) * 0.038,
                          color: AppColors.textSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: size.customHeight(context) * 0.05),
                
                // Email field
                _buildTextField(
                  context: context,
                  controller: _emailController,
                  hintText: 'Email Address',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) return 'Email is required';
                    if (!val.contains('@') || !val.contains('.'))
                      return 'Enter a valid email';
                    return null;
                  },
                ),
                
                SizedBox(height: size.customHeight(context) * 0.02),
                
                // Password field
                Obx(() => _buildPasswordField(
                      context: context,
                      controller: _passwordController,
                      hintText: 'Password',
                      obscureText: passwordController.isPasswordHidden.value,
                      onToggle: passwordController.togglePasswordVisibility,
                      validator: (val) =>
                          val == null || val.isEmpty ? 'Password is required' : null,
                    )),
                
                SizedBox(height: size.customHeight(context) * 0.015),
                
                // Forgot password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Get.toNamed(AppRoutes.resetPassword),
                    child: Text(
                      'Forgot Password?',
                      style: GoogleFonts.poppins(
                        fontSize: size.customWidth(context) * 0.038,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                
                SizedBox(height: size.customHeight(context) * 0.02),
                
                // Login button
                CustomButton(
                  title: 'Log In',
                  height: size.customHeight(context) * 0.065,
                  width: double.infinity,
                  radius: size.customHeight(context) * 0.2,
                  color: AppColors.primaryColor,
                  loading: false,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                       Get.to(HomeScreen());
                      print('Login with: ${_emailController.text}');
                    }
                  },
                ),
                
                SizedBox(height: size.customHeight(context) * 0.03),
                
                // Divider
                _buildDivider(context),
                
                SizedBox(height: size.customHeight(context) * 0.03),
                
                // Social login buttons
                _buildSocialButton(
                  context: context,
                  icon: Icons.g_mobiledata,
                  label: 'Continue with Google',
                  onTap: () => print('Google login'),
                ),
                
                SizedBox(height: size.customHeight(context) * 0.02),
                
                _buildSocialButton(
                  context: context,
                  icon: Icons.facebook,
                  label: 'Continue with Facebook',
                  onTap: () => print('Facebook login'),
                ),
                
                SizedBox(height: size.customHeight(context) * 0.04),
                
                // Sign up link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account? ',
                      style: GoogleFonts.poppins(
                        fontSize: size.customWidth(context) * 0.038,
                        color: AppColors.textSecondaryColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.roleSelection),
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.poppins(
                          fontSize: size.customWidth(context) * 0.038,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
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
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    final size = CustomSize();
    
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
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

  Widget _buildDivider(BuildContext context) {
    final size = CustomSize();
    
    return Row(
      children: [
        Expanded(
          child: Divider(color: AppColors.greyColor.withOpacity(0.3), thickness: 1),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.customWidth(context) * 0.03),
          child: Text(
            'or',
            style: GoogleFonts.poppins(
              color: AppColors.textSecondaryColor,
              fontSize: size.customWidth(context) * 0.035,
            ),
          ),
        ),
        Expanded(
          child: Divider(color: AppColors.greyColor.withOpacity(0.3), thickness: 1),
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final size = CustomSize();
    
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        minimumSize: Size(double.infinity, size.customHeight(context) * 0.065),
        side: BorderSide(color: AppColors.greyColor.withOpacity(0.3)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(size.customHeight(context) * 0.015),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.textPrimaryColor, size: size.customWidth(context) * 0.06),
          SizedBox(width: size.customWidth(context) * 0.02),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: size.customWidth(context) * 0.04,
              color: AppColors.textPrimaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}