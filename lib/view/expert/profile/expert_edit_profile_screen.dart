// lib/view/expert/profile/expert_edit_profile_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/components/custom_button.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import 'package:speechspectrum/controllers/expert_profile_controller.dart';

class ExpertEditProfileScreen extends StatefulWidget {
  const ExpertEditProfileScreen({super.key});

  @override
  State<ExpertEditProfileScreen> createState() =>
      _ExpertEditProfileScreenState();
}

class _ExpertEditProfileScreenState extends State<ExpertEditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _specializationController;
  late TextEditingController _organizationController;

  late final ExpertProfileController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = Get.find<ExpertProfileController>();
    _nameController = TextEditingController(text: _ctrl.fullName);
    _phoneController = TextEditingController(text: _ctrl.phone);
    _emailController = TextEditingController(text: _ctrl.contactEmail);
    _specializationController =
        TextEditingController(text: _ctrl.specialization);
    _organizationController =
        TextEditingController(text: _ctrl.organization);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _specializationController.dispose();
    _organizationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();

    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: AppColors.textPrimaryColor, size: 20),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Edit Profile',
          style: GoogleFonts.poppins(
              color: AppColors.textPrimaryColor,
              fontWeight: FontWeight.w600,
              fontSize: size.customWidth(context) * 0.045),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(size.customWidth(context) * 0.05),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Avatar
              Stack(
                children: [
                  Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: AppColors.primaryColor.withOpacity(0.2),
                          width: 3),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10))
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      _ctrl.userInitial,
                      style: GoogleFonts.poppins(
                          fontSize: 44,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.primaryColor,
                            AppColors.secondaryColor
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.whiteColor, width: 3),
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.primaryColor.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4))
                        ],
                      ),
                      child: const Icon(Icons.camera_alt,
                          color: Colors.white, size: 18),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.customHeight(context) * 0.01),
              Text(
                'Change Photo',
                style: GoogleFonts.poppins(
                    fontSize: size.customWidth(context) * 0.033,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: size.customHeight(context) * 0.035),

              // Section: Basic Info
              _sectionLabel(context, size, 'Basic Information'),
              SizedBox(height: size.customHeight(context) * 0.014),

              _buildField(
                context: context,
                size: size,
                ctrl: _nameController,
                hint: 'Full Name',
                icon: Icons.person_outline,
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Name is required' : null,
              ),
              SizedBox(height: size.customHeight(context) * 0.016),
              _buildField(
                context: context,
                size: size,
                ctrl: _phoneController,
                hint: 'Phone Number',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Phone is required' : null,
              ),
              SizedBox(height: size.customHeight(context) * 0.016),
              _buildField(
                context: context,
                size: size,
                ctrl: _emailController,
                hint: 'Contact Email',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: size.customHeight(context) * 0.028),

              // Section: Professional Info
              _sectionLabel(context, size, 'Professional Information'),
              SizedBox(height: size.customHeight(context) * 0.014),

              _buildField(
                context: context,
                size: size,
                ctrl: _specializationController,
                hint: 'Specialization',
                icon: Icons.medical_services_outlined,
              ),
              SizedBox(height: size.customHeight(context) * 0.016),
              _buildField(
                context: context,
                size: size,
                ctrl: _organizationController,
                hint: 'Organization / Clinic',
                icon: Icons.business_outlined,
              ),
              SizedBox(height: size.customHeight(context) * 0.035),

              // Save
              Obx(() => CustomButton(
                    title: 'Save Changes',
                    height: size.customHeight(context) * 0.065,
                    width: double.infinity,
                    radius: size.customHeight(context) * 0.2,
                    color: AppColors.primaryColor,
                    loading: _ctrl.isUpdating.value,
                    onTap: _handleSave,
                  )),
              SizedBox(height: size.customHeight(context) * 0.02),

              // Delete account
              OutlinedButton.icon(
                onPressed: () => _showDeleteDialog(context),
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(
                      double.infinity, size.customHeight(context) * 0.065),
                  side: const BorderSide(color: AppColors.errorColor),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          size.customHeight(context) * 0.2)),
                ),
                icon: const Icon(Icons.delete_outline,
                    color: AppColors.errorColor),
                label: Text(
                  'Delete Account',
                  style: GoogleFonts.poppins(
                      fontSize: size.customWidth(context) * 0.04,
                      color: AppColors.errorColor,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: size.customHeight(context) * 0.03),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionLabel(
      BuildContext context, CustomSize size, String label) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 18,
          decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(2)),
        ),
        SizedBox(width: size.customWidth(context) * 0.025),
        Text(
          label,
          style: GoogleFonts.poppins(
              fontSize: size.customWidth(context) * 0.04,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimaryColor),
        ),
      ],
    );
  }

  Widget _buildField({
    required BuildContext context,
    required CustomSize size,
    required TextEditingController ctrl,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: ctrl,
      keyboardType: keyboardType,
      validator: validator,
      cursorColor: AppColors.primaryColor,
      style: GoogleFonts.poppins(
          fontSize: size.customWidth(context) * 0.04,
          color: AppColors.textPrimaryColor),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: AppColors.primaryColor),
        hintText: hint,
        hintStyle: GoogleFonts.poppins(
            fontSize: size.customWidth(context) * 0.038,
            color: AppColors.greyColor),
        filled: true,
        fillColor: AppColors.whiteColor,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                size.customHeight(context) * 0.016),
            borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                size.customHeight(context) * 0.016),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                size.customHeight(context) * 0.016),
            borderSide:
                const BorderSide(color: AppColors.primaryColor, width: 2)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                size.customHeight(context) * 0.016),
            borderSide:
                const BorderSide(color: AppColors.errorColor, width: 1.5)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                size.customHeight(context) * 0.016),
            borderSide:
                const BorderSide(color: AppColors.errorColor, width: 2)),
        contentPadding: EdgeInsets.symmetric(
            vertical: size.customHeight(context) * 0.02,
            horizontal: size.customWidth(context) * 0.04),
      ),
    );
  }

  void _handleSave() {
    if (_formKey.currentState!.validate()) {
      _ctrl.updateProfile(
        fullName: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
        contactEmail: _emailController.text.trim(),
        specialization: _specializationController.text.trim(),
        organization: _organizationController.text.trim(),
      );
    }
  }

  void _showDeleteDialog(BuildContext context) {
    final size = CustomSize();
    Get.dialog(
      Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Container(
          padding: EdgeInsets.all(size.customWidth(context) * 0.05),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    color: AppColors.errorColor.withOpacity(0.1),
                    shape: BoxShape.circle),
                child: const Icon(Icons.warning_amber_rounded,
                    color: AppColors.errorColor, size: 45),
              ),
              SizedBox(height: size.customHeight(context) * 0.02),
              Text('Delete Account',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: size.customWidth(context) * 0.052,
                      color: AppColors.textPrimaryColor)),
              SizedBox(height: size.customHeight(context) * 0.012),
              Text(
                'This action is permanent and cannot be undone. All your data, slots and appointments will be deleted.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: size.customWidth(context) * 0.036,
                    color: AppColors.textSecondaryColor),
              ),
              SizedBox(height: size.customHeight(context) * 0.025),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: size.customHeight(context) * 0.015),
                        side: BorderSide(
                            color: AppColors.greyColor.withOpacity(0.5)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text('Cancel',
                          style: GoogleFonts.poppins(
                              color: AppColors.textSecondaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: size.customWidth(context) * 0.038)),
                    ),
                  ),
                  SizedBox(width: size.customWidth(context) * 0.03),
                  Expanded(
                    child: Obx(() => ElevatedButton(
                          onPressed: _ctrl.isDeleting.value
                              ? null
                              : () {
                                  Get.back();
                                  _ctrl.deleteProfile();
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.errorColor,
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    size.customHeight(context) * 0.015),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            elevation: 0,
                          ),
                          child: _ctrl.isDeleting.value
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                      color: Colors.white, strokeWidth: 2))
                              : Text('Delete',
                                  style: GoogleFonts.poppins(
                                      color: AppColors.whiteColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize:
                                          size.customWidth(context) * 0.038)),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}