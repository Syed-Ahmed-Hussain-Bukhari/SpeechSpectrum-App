// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/components/custom_button.dart';
// import 'package:speechspectrum/view/home/home_screen.dart';
// import '../../controllers/auth_controller.dart';
// import '../../controllers/password_controller.dart';
// import '../../routes/app_routes.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';


// class SignUpScreen extends StatelessWidget {
//   SignUpScreen({super.key});

//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();
//   final _nameController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();
//     final passwordController = Get.put(PasswordController());
//     final authController = Get.put(AuthController());

//     return Scaffold(
//       backgroundColor: AppColors.whiteColor,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(
//             horizontal: size.customWidth(context) * 0.05,
//           ),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: size.customHeight(context) * 0.04),
                
//                 // Logo and title
//                 Center(
//                   child: Column(
//                     children: [
//                       Container(
//                         height: size.customHeight(context) * 0.1,
//                         width: size.customHeight(context) * 0.1,
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [AppColors.primaryColor, AppColors.secondaryColor],
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                           ),
//                           borderRadius: BorderRadius.circular(size.customHeight(context) * 0.025),
//                         ),
//                         child: Icon(
//                           Icons.waves_outlined,
//                           size: size.customHeight(context) * 0.06,
//                           color: AppColors.whiteColor,
//                         ),
//                       ),
//                       SizedBox(height: size.customHeight(context) * 0.02),
//                       Text(
//                         'Create Account',
//                         style: GoogleFonts.poppins(
//                           fontSize: size.customWidth(context) * 0.07,
//                           fontWeight: FontWeight.bold,
//                           color: AppColors.textPrimaryColor,
//                         ),
//                       ),
//                       SizedBox(height: size.customHeight(context) * 0.01),
//                       Text(
//                         'Join us to help your child thrive',
//                         style: GoogleFonts.poppins(
//                           fontSize: size.customWidth(context) * 0.038,
//                           color: AppColors.textSecondaryColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
                
//                 SizedBox(height: size.customHeight(context) * 0.04),
                
//                 // Name field
//                 _buildTextField(
//                   context: context,
//                   controller: _nameController,
//                   hintText: 'Full Name',
//                   icon: Icons.person_outline,
//                   validator: (val) =>
//                       val == null || val.trim().isEmpty ? 'Name is required' : null,
//                 ),
                
//                 SizedBox(height: size.customHeight(context) * 0.02),
                
//                 // Email field
//                 _buildTextField(
//                   context: context,
//                   controller: _emailController,
//                   hintText: 'Email Address',
//                   icon: Icons.email_outlined,
//                   keyboardType: TextInputType.emailAddress,
//                   validator: (val) {
//                     if (val == null || val.trim().isEmpty) return 'Email is required';
//                     if (!val.contains('@') || !val.contains('.'))
//                       return 'Enter a valid email';
//                     return null;
//                   },
//                 ),
                
//                 SizedBox(height: size.customHeight(context) * 0.02),
                
//                 // Password field
//                 Obx(() => _buildPasswordField(
//                       context: context,
//                       controller: _passwordController,
//                       hintText: 'Password',
//                       obscureText: passwordController.isPasswordHidden.value,
//                       onToggle: passwordController.togglePasswordVisibility,
//                       validator: (val) {
//                         if (val == null || val.isEmpty) return 'Password is required';
//                         if (val.length < 6) return 'Minimum 6 characters required';
//                         return null;
//                       },
//                     )),
                
//                 SizedBox(height: size.customHeight(context) * 0.02),
                
//                 // Confirm password field
//                 Obx(() => _buildPasswordField(
//                       context: context,
//                       controller: _confirmPasswordController,
//                       hintText: 'Confirm Password',
//                       obscureText: passwordController.isConfirmPasswordHidden.value,
//                       onToggle: passwordController.toggleConfirmPasswordVisibility,
//                       validator: (val) {
//                         if (val == null || val.isEmpty)
//                           return 'Please confirm password';
//                         if (val != _passwordController.text)
//                           return 'Passwords do not match';
//                         return null;
//                       },
//                     )),
                
//                 SizedBox(height: size.customHeight(context) * 0.03),
                
//                 // Sign up button
//                 CustomButton(
//                   title: 'Sign Up',
//                   height: size.customHeight(context) * 0.065,
//                   width: double.infinity,
//                   radius: size.customHeight(context) * 0.2,
//                   color: AppColors.primaryColor,
//                   loading: false,
//                   onTap: () {
//                     if (_formKey.currentState!.validate()) {
//                       Get.to(HomeScreen());
//                       print('Sign up with: ${_emailController.text}');
//                     }
//                   },
//                 ),
                
//                 SizedBox(height: size.customHeight(context) * 0.03),
                
//                 // Divider
//                 _buildDivider(context),
                
//                 SizedBox(height: size.customHeight(context) * 0.03),
                
//                 // Social login buttons
//                 _buildSocialButton(
//                   context: context,
//                   icon: Icons.g_mobiledata,
//                   label: 'Continue with Google',
//                   onTap: () => print('Google login'),
//                 ),
                
//                 SizedBox(height: size.customHeight(context) * 0.02),
                
//                 _buildSocialButton(
//                   context: context,
//                   icon: Icons.facebook,
//                   label: 'Continue with Facebook',
//                   onTap: (){
                    
//                      print('Facebook login');
//                      },
//                 ),
                
//                 SizedBox(height: size.customHeight(context) * 0.03),
                
//                 // Login link
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Already have an account? ',
//                       style: GoogleFonts.poppins(
//                         fontSize: size.customWidth(context) * 0.038,
//                         color: AppColors.textSecondaryColor,
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () => Get.toNamed(AppRoutes.login),
//                       child: Text(
//                         'Log In',
//                         style: GoogleFonts.poppins(
//                           fontSize: size.customWidth(context) * 0.038,
//                           fontWeight: FontWeight.w700,
//                           color: AppColors.primaryColor,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
                
//                 SizedBox(height: size.customHeight(context) * 0.03),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField({
//     required BuildContext context,
//     required TextEditingController controller,
//     required String hintText,
//     required IconData icon,
//     TextInputType keyboardType = TextInputType.text,
//     String? Function(String?)? validator,
//   }) {
//     final size = CustomSize();
    
//     return TextFormField(
//       controller: controller,
//       keyboardType: keyboardType,
//       validator: validator,
//       cursorColor: AppColors.primaryColor,
//       style: GoogleFonts.poppins(
//         fontSize: size.customWidth(context) * 0.04,
//         color: AppColors.textPrimaryColor,
//       ),
//       decoration: InputDecoration(
//         prefixIcon: Icon(icon, color: AppColors.primaryColor),
//         hintText: hintText,
//         hintStyle: GoogleFonts.poppins(
//           fontSize: size.customWidth(context) * 0.04,
//           color: AppColors.greyColor,
//         ),
//         filled: true,
//         fillColor: AppColors.lightGreyColor,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(size.customHeight(context) * 0.015),
//           borderSide: BorderSide.none,
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(size.customHeight(context) * 0.015),
//           borderSide: BorderSide.none,
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(size.customHeight(context) * 0.015),
//           borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(size.customHeight(context) * 0.015),
//           borderSide: BorderSide(color: AppColors.errorColor, width: 1.5),
//         ),
//         contentPadding: EdgeInsets.symmetric(
//           vertical: size.customHeight(context) * 0.02,
//           horizontal: size.customWidth(context) * 0.04,
//         ),
//       ),
//     );
//   }

//   Widget _buildPasswordField({
//     required BuildContext context,
//     required TextEditingController controller,
//     required String hintText,
//     required bool obscureText,
//     required VoidCallback onToggle,
//     String? Function(String?)? validator,
//   }) {
//     final size = CustomSize();
    
//     return TextFormField(
//       controller: controller,
//       obscureText: obscureText,
//       validator: validator,
//       cursorColor: AppColors.primaryColor,
//       style: GoogleFonts.poppins(
//         fontSize: size.customWidth(context) * 0.04,
//         color: AppColors.textPrimaryColor,
//       ),
//       decoration: InputDecoration(
//         prefixIcon: Icon(Icons.lock_outline, color: AppColors.primaryColor),
//         suffixIcon: IconButton(
//           icon: Icon(
//             obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
//             color: AppColors.greyColor,
//           ),
//           onPressed: onToggle,
//         ),
//         hintText: hintText,
//         hintStyle: GoogleFonts.poppins(
//           fontSize: size.customWidth(context) * 0.04,
//           color: AppColors.greyColor,
//         ),
//         filled: true,
//         fillColor: AppColors.lightGreyColor,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(size.customHeight(context) * 0.015),
//           borderSide: BorderSide.none,
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(size.customHeight(context) * 0.015),
//           borderSide: BorderSide.none,
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(size.customHeight(context) * 0.015),
//           borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(size.customHeight(context) * 0.015),
//           borderSide: BorderSide(color: AppColors.errorColor, width: 1.5),
//         ),
//         contentPadding: EdgeInsets.symmetric(
//           vertical: size.customHeight(context) * 0.02,
//           horizontal: size.customWidth(context) * 0.04,
//         ),
//       ),
//     );
//   }

//   Widget _buildDivider(BuildContext context) {
//     final size = CustomSize();
    
//     return Row(
//       children: [
//         Expanded(
//           child: Divider(color: AppColors.greyColor.withOpacity(0.3), thickness: 1),
//         ),
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: size.customWidth(context) * 0.03),
//           child: Text(
//             'or',
//             style: GoogleFonts.poppins(
//               color: AppColors.textSecondaryColor,
//               fontSize: size.customWidth(context) * 0.035,
//             ),
//           ),
//         ),
//         Expanded(
//           child: Divider(color: AppColors.greyColor.withOpacity(0.3), thickness: 1),
//         ),
//       ],
//     );
//   }

//   Widget _buildSocialButton({
//     required BuildContext context,
//     required IconData icon,
//     required String label,
//     required VoidCallback onTap,
//   }) {
//     final size = CustomSize();
    
//     return OutlinedButton(
//       onPressed: onTap,
//       style: OutlinedButton.styleFrom(
//         minimumSize: Size(double.infinity, size.customHeight(context) * 0.065),
//         side: BorderSide(color: AppColors.greyColor.withOpacity(0.3)),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(size.customHeight(context) * 0.015),
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, color: AppColors.textPrimaryColor, size: size.customWidth(context) * 0.06),
//           SizedBox(width: size.customWidth(context) * 0.02),
//           Text(
//             label,
//             style: GoogleFonts.poppins(
//               fontSize: size.customWidth(context) * 0.04,
//               color: AppColors.textPrimaryColor,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// view/auth/email_password_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/registration_controller.dart';
import '../../controllers/password_controller.dart';
import '../../constants/app_colors.dart';
import '../../constants/custom_size.dart';

class EmailPasswordScreen extends StatelessWidget {
  EmailPasswordScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final RegistrationController regController = Get.find();
  final PasswordController passwordController = Get.put(PasswordController());

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
            //   value: 4 / 4,
            //   backgroundColor: AppColors.greyColor.withOpacity(0.3),
            //   valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
            //   minHeight: size.customHeight(context) * 0.008,
            // ),
            // SizedBox(height: size.customHeight(context) * 0.008),
            // Text(
            //   'STEP 4/4',
            //   style: GoogleFonts.poppins(
            //     fontSize: size.customWidth(context) * 0.03,
            //     fontWeight: FontWeight.w600,
            //     color: AppColors.primaryColor,
            //   ),
            // ),
               Obx(() {
              // Calculate progress based on role
              final isExpert = regController.role.value == 'expert';
              final currentStep = isExpert ? 6 : 4;
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
              final stepText = isExpert ? 'STEP 6/6' : 'STEP 4/4';
              
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
        child: SingleChildScrollView(
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
                    'Create Account',
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
                    'Set up your email and password',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: size.customWidth(context) * 0.038,
                      color: AppColors.textSecondaryColor,
                    ),
                  ),
                ),

                SizedBox(height: size.customHeight(context) * 0.05),

                /// Email Field
                _buildTextField(
                  context: context,
                  controller: _emailController,
                  hintText: 'Email Address',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) return 'Email is required';
                    if (!val.contains('@') || !val.contains('.')) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),

                SizedBox(height: size.customHeight(context) * 0.02),

                /// Password Field
                Obx(() => _buildPasswordField(
                      context: context,
                      controller: _passwordController,
                      hintText: 'Password',
                      obscureText: passwordController.isPasswordHidden.value,
                      onToggle: passwordController.togglePasswordVisibility,
                      validator: (val) {
                        if (val == null || val.isEmpty) return 'Password is required';
                        if (val.length < 6) return 'Minimum 6 characters required';
                        return null;
                      },
                    )),

                SizedBox(height: size.customHeight(context) * 0.02),

                /// Confirm Password Field
                Obx(() => _buildPasswordField(
                      context: context,
                      controller: _confirmPasswordController,
                      hintText: 'Confirm Password',
                      obscureText: passwordController.isConfirmPasswordHidden.value,
                      onToggle: passwordController.toggleConfirmPasswordVisibility,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Please confirm password';
                        }
                        if (val != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    )),

                SizedBox(height: size.customHeight(context) * 0.05),

                /// Register Button
                SizedBox(
                  width: double.infinity,
                  height: size.customHeight(context) * 0.065,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        regController.setEmailAndPassword(
                          _emailController.text.trim(),
                          _passwordController.text,
                        );
                        regController.registerUser();
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
                      'Register',
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
    TextInputType keyboardType = TextInputType.text,
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

  Widget _buildPasswordField({
    required BuildContext context,
    required TextEditingController controller,
    required String hintText,
    required bool obscureText,
    required VoidCallback onToggle,
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