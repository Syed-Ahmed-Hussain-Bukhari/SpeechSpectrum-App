// view/auth/expert_info_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/registration_controller.dart';
import '../../routes/app_routes.dart';
import '../../constants/app_colors.dart';
import '../../constants/custom_size.dart';

class ExpertInfoScreen extends StatelessWidget {
  ExpertInfoScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _specializationController = TextEditingController();
  final _organizationController = TextEditingController();
  final _contactEmailController = TextEditingController();
  final _pmdcNumberController = TextEditingController();
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
              value: 4 / 6,
              backgroundColor: AppColors.greyColor.withOpacity(0.3),
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
              minHeight: size.customHeight(context) * 0.008,
            ),
            SizedBox(height: size.customHeight(context) * 0.008),
            Text(
              'STEP 4/6',
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
                    'Professional Information',
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
                    'Please provide your professional details',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: size.customWidth(context) * 0.038,
                      color: AppColors.textSecondaryColor,
                    ),
                  ),
                ),

                SizedBox(height: size.customHeight(context) * 0.04),

                /// Specialization Field
                _buildTextField(
                  context: context,
                  controller: _specializationController,
                  hintText: 'Specialization (e.g., Speech Therapy)',
                  icon: Icons.medical_services_outlined,
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'Specialization is required';
                    }
                    return null;
                  },
                ),

                SizedBox(height: size.customHeight(context) * 0.02),

                /// Organization Field
                _buildTextField(
                  context: context,
                  controller: _organizationController,
                  hintText: 'Organization (e.g., Medical Center)',
                  icon: Icons.business_outlined,
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'Organization is required';
                    }
                    return null;
                  },
                ),

                SizedBox(height: size.customHeight(context) * 0.02),

                /// Contact Email Field
                _buildTextField(
                  context: context,
                  controller: _contactEmailController,
                  hintText: 'Contact Email',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'Contact email is required';
                    }
                    if (!val.contains('@') || !val.contains('.')) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),

                SizedBox(height: size.customHeight(context) * 0.02),

                /// PMDC Number Field
                _buildTextField(
                  context: context,
                  controller: _pmdcNumberController,
                  hintText: 'PMDC Number',
                  icon: Icons.badge_outlined,
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'PMDC number is required';
                    }
                    return null;
                  },
                ),

                SizedBox(height: size.customHeight(context) * 0.05),

                /// Continue Button
                SizedBox(
                  width: double.infinity,
                  height: size.customHeight(context) * 0.065,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        regController.setExpertInfo(
                          specialization: _specializationController.text.trim(),
                          organization: _organizationController.text.trim(),
                          contactEmail: _contactEmailController.text.trim(),
                          pmdcNumber: _pmdcNumberController.text.trim(),
                        );
                        Get.toNamed(AppRoutes.expertDocuments);
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
}