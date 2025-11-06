import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/components/custom_button.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';


class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'Samantha Williams');
  final _emailController = TextEditingController(text: 'samantha@email.com');
  final _phoneController = TextEditingController(text: '+92 300 1234567');

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();
    
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
          'Edit Profile',
          style: GoogleFonts.poppins(
            color: AppColors.textPrimaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(size.customWidth(context) * 0.05),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Profile Picture
              Stack(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.camera_alt, color: AppColors.whiteColor, size: 20),
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: size.customHeight(context) * 0.03),
              
              _buildTextField(
                context: context,
                controller: _nameController,
                hintText: 'Full Name',
                icon: Icons.person_outline,
              ),
              
              SizedBox(height: size.customHeight(context) * 0.02),
              
              _buildTextField(
                context: context,
                controller: _emailController,
                hintText: 'Email',
                icon: Icons.email_outlined,
              ),
              
              SizedBox(height: size.customHeight(context) * 0.02),
              
              _buildTextField(
                context: context,
                controller: _phoneController,
                hintText: 'Phone',
                icon: Icons.phone_outlined,
              ),
              
              SizedBox(height: size.customHeight(context) * 0.04),
              
              CustomButton(
                title: 'Save Changes',
                height: size.customHeight(context) * 0.065,
                width: double.infinity,
                radius: size.customHeight(context) * 0.2,
                color: AppColors.primaryColor,
                loading: false,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    Get.snackbar(
                      'Success',
                      'Profile updated successfully!',
                      backgroundColor: AppColors.successColor,
                      colorText: AppColors.whiteColor,
                    );
                    Get.back();
                  }
                },
              ),
            ],
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
  }) {
    final size = CustomSize();
    
    return TextFormField(
      controller: controller,
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
          borderRadius: BorderRadius.circular(size.customHeight(context) * 0.015),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(size.customHeight(context) * 0.015),
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
        ),
      ),
    );
  }
}
