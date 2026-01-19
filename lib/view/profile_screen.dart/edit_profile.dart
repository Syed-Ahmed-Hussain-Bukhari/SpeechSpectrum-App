// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/components/custom_button.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';


// class EditProfileScreen extends StatefulWidget {
//   const EditProfileScreen({super.key});

//   @override
//   State<EditProfileScreen> createState() => _EditProfileScreenState();
// }

// class _EditProfileScreenState extends State<EditProfileScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController(text: 'Samantha Williams');
//   final _emailController = TextEditingController(text: 'samantha@email.com');
//   final _phoneController = TextEditingController(text: '+92 300 1234567');

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();
    
//     return Scaffold(
//       backgroundColor: AppColors.lightGreyColor,
//       appBar: AppBar(
//         backgroundColor: AppColors.whiteColor,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: AppColors.textPrimaryColor),
//           onPressed: () => Get.back(),
//         ),
//         title: Text(
//           'Edit Profile',
//           style: GoogleFonts.poppins(
//             color: AppColors.textPrimaryColor,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(size.customWidth(context) * 0.05),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               // Profile Picture
//               Stack(
//                 children: [
//                   Container(
//                     width: 120,
//                     height: 120,
//                     decoration: BoxDecoration(
//                       color: AppColors.primaryColor.withOpacity(0.1),
//                       shape: BoxShape.circle,
//                     ),
//                     child: Icon(
//                       Icons.person,
//                       size: 60,
//                       color: AppColors.primaryColor,
//                     ),
//                   ),
//                   Positioned(
//                     bottom: 0,
//                     right: 0,
//                     child: Container(
//                       width: 40,
//                       height: 40,
//                       decoration: BoxDecoration(
//                         color: AppColors.primaryColor,
//                         shape: BoxShape.circle,
//                       ),
//                       child: Icon(Icons.camera_alt, color: AppColors.whiteColor, size: 20),
//                     ),
//                   ),
//                 ],
//               ),
              
//               SizedBox(height: size.customHeight(context) * 0.03),
              
//               _buildTextField(
//                 context: context,
//                 controller: _nameController,
//                 hintText: 'Full Name',
//                 icon: Icons.person_outline,
//               ),
              
//               SizedBox(height: size.customHeight(context) * 0.02),
              
//               _buildTextField(
//                 context: context,
//                 controller: _emailController,
//                 hintText: 'Email',
//                 icon: Icons.email_outlined,
//               ),
              
//               SizedBox(height: size.customHeight(context) * 0.02),
              
//               _buildTextField(
//                 context: context,
//                 controller: _phoneController,
//                 hintText: 'Phone',
//                 icon: Icons.phone_outlined,
//               ),
              
//               SizedBox(height: size.customHeight(context) * 0.04),
              
//               CustomButton(
//                 title: 'Save Changes',
//                 height: size.customHeight(context) * 0.065,
//                 width: double.infinity,
//                 radius: size.customHeight(context) * 0.2,
//                 color: AppColors.primaryColor,
//                 loading: false,
//                 onTap: () {
//                   if (_formKey.currentState!.validate()) {
//                     Get.snackbar(
//                       'Success',
//                       'Profile updated successfully!',
//                       backgroundColor: AppColors.successColor,
//                       colorText: AppColors.whiteColor,
//                     );
//                     Get.back();
//                   }
//                 },
//               ),
//             ],
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
//   }) {
//     final size = CustomSize();
    
//     return TextFormField(
//       controller: controller,
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
//         fillColor: AppColors.whiteColor,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(size.customHeight(context) * 0.015),
//           borderSide: BorderSide.none,
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(size.customHeight(context) * 0.015),
//           borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
//         ),
//       ),
//     );
//   }
// }



// // lib/view/profile/edit_profile_screen.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/components/custom_button.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/profile_controller.dart';
// import 'package:speechspectrum/models/profile_model.dart';

// class EditProfileScreen extends StatefulWidget {
//   const EditProfileScreen({super.key});

//   @override
//   State<EditProfileScreen> createState() => _EditProfileScreenState();
// }

// class _EditProfileScreenState extends State<EditProfileScreen> {
//   final _formKey = GlobalKey<FormState>();
//   late TextEditingController _nameController;
//   late TextEditingController _phoneController;
//   late TextEditingController _emailController;
//   late TextEditingController _specializationController;
//   late TextEditingController _organizationController;

//   final controller = Get.find<ProfileController>();

//   @override
//   void initState() {
//     super.initState();
//     _initializeControllers();
//   }

//   void _initializeControllers() {
//     final profileData = controller.profileModel.value?.data;

//     if (profileData?.isParent() == true) {
//       final profile = profileData!.profile as ParentProfile;
//       _nameController = TextEditingController(text: profile.fullName);
//       _phoneController = TextEditingController(text: profile.phone);
//       _emailController = TextEditingController();
//       _specializationController = TextEditingController();
//       _organizationController = TextEditingController();
//     } else if (profileData?.isExpert() == true) {
//       final profile = profileData!.profile as ExpertProfile;
//       _nameController = TextEditingController(text: profile.fullName);
//       _phoneController = TextEditingController(text: profile.phone);
//       _emailController = TextEditingController(text: profile.contactEmail ?? '');
//       _specializationController = TextEditingController(text: profile.specialization ?? '');
//       _organizationController = TextEditingController(text: profile.organization ?? '');
//     } else {
//       _nameController = TextEditingController();
//       _phoneController = TextEditingController();
//       _emailController = TextEditingController();
//       _specializationController = TextEditingController();
//       _organizationController = TextEditingController();
//     }
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _phoneController.dispose();
//     _emailController.dispose();
//     _specializationController.dispose();
//     _organizationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();
//     final profileData = controller.profileModel.value?.data;
//     final isExpert = profileData?.isExpert() ?? false;

//     return Scaffold(
//       backgroundColor: AppColors.lightGreyColor,
//       appBar: AppBar(
//         backgroundColor: AppColors.whiteColor,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: AppColors.textPrimaryColor),
//           onPressed: () => Get.back(),
//         ),
//         title: Text(
//           'Edit Profile',
//           style: GoogleFonts.poppins(
//             color: AppColors.textPrimaryColor,
//             fontWeight: FontWeight.w600,
//             fontSize: size.customWidth(context) * 0.045,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(size.customWidth(context) * 0.05),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               // Profile Picture Section
//               Stack(
//                 children: [
//                   Container(
//                     width: 120,
//                     height: 120,
//                     decoration: BoxDecoration(
//                       color: AppColors.whiteColor,
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                         color: AppColors.primaryColor.withOpacity(0.2),
//                         width: 3,
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.1),
//                           blurRadius: 20,
//                           offset: Offset(0, 10),
//                         ),
//                       ],
//                     ),
//                     alignment: Alignment.center,
//                     child: Text(
//                       controller.userInitial,
//                       style: GoogleFonts.poppins(
//                         fontSize: 48,
//                         fontWeight: FontWeight.bold,
//                         color: AppColors.primaryColor,
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     bottom: 0,
//                     right: 0,
//                     child: Container(
//                       width: 45,
//                       height: 45,
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: [AppColors.primaryColor, AppColors.secondaryColor],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                         shape: BoxShape.circle,
//                         border: Border.all(
//                           color: AppColors.whiteColor,
//                           width: 3,
//                         ),
//                         boxShadow: [
//                           BoxShadow(
//                             color: AppColors.primaryColor.withOpacity(0.3),
//                             blurRadius: 8,
//                             offset: Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                       child: Icon(
//                         Icons.camera_alt,
//                         color: AppColors.whiteColor,
//                         size: 20,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),

//               SizedBox(height: size.customHeight(context) * 0.01),

//               Text(
//                 'Change Photo',
//                 style: GoogleFonts.poppins(
//                   fontSize: size.customWidth(context) * 0.035,
//                   color: AppColors.primaryColor,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),

//               SizedBox(height: size.customHeight(context) * 0.04),

//               // Form Fields
//               _buildTextField(
//                 context: context,
//                 controller: _nameController,
//                 hintText: 'Full Name',
//                 icon: Icons.person_outline,
//                 validator: (val) =>
//                     val == null || val.trim().isEmpty ? 'Name is required' : null,
//               ),

//               SizedBox(height: size.customHeight(context) * 0.02),

//               _buildTextField(
//                 context: context,
//                 controller: _phoneController,
//                 hintText: 'Phone Number',
//                 icon: Icons.phone_outlined,
//                 keyboardType: TextInputType.phone,
//                 validator: (val) =>
//                     val == null || val.trim().isEmpty ? 'Phone is required' : null,
//               ),

//               if (isExpert) ...[
//                 SizedBox(height: size.customHeight(context) * 0.02),

//                 _buildTextField(
//                   context: context,
//                   controller: _emailController,
//                   hintText: 'Email Address',
//                   icon: Icons.email_outlined,
//                   keyboardType: TextInputType.emailAddress,
//                 ),

//                 SizedBox(height: size.customHeight(context) * 0.02),

//                 _buildTextField(
//                   context: context,
//                   controller: _specializationController,
//                   hintText: 'Specialization',
//                   icon: Icons.medical_services_outlined,
//                 ),

//                 SizedBox(height: size.customHeight(context) * 0.02),

//                 _buildTextField(
//                   context: context,
//                   controller: _organizationController,
//                   hintText: 'Organization',
//                   icon: Icons.business_outlined,
//                 ),
//               ],

//               SizedBox(height: size.customHeight(context) * 0.04),

//               // Save Button
//               Obx(() => CustomButton(
//                     title: 'Save Changes',
//                     height: size.customHeight(context) * 0.065,
//                     width: double.infinity,
//                     radius: size.customHeight(context) * 0.2,
//                     color: AppColors.primaryColor,
//                     loading: controller.isUpdating.value,
//                     onTap: _handleSave,
//                   )),

//               SizedBox(height: size.customHeight(context) * 0.02),

//               // Delete Account Button (Future Implementation)
//               OutlinedButton.icon(
//                 onPressed: () => _showDeleteAccountDialog(context),
//                 style: OutlinedButton.styleFrom(
//                   minimumSize: Size(
//                     double.infinity,
//                     size.customHeight(context) * 0.065,
//                   ),
//                   side: BorderSide(color: AppColors.errorColor),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(size.customHeight(context) * 0.2),
//                   ),
//                 ),
//                 icon: Icon(Icons.delete_outline, color: AppColors.errorColor),
//                 label: Text(
//                   'Delete Account',
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.04,
//                     color: AppColors.errorColor,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ],
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
//         fillColor: AppColors.whiteColor,
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
//         focusedErrorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(size.customHeight(context) * 0.015),
//           borderSide: BorderSide(color: AppColors.errorColor, width: 2),
//         ),
//         contentPadding: EdgeInsets.symmetric(
//           vertical: size.customHeight(context) * 0.02,
//           horizontal: size.customWidth(context) * 0.04,
//         ),
//       ),
//     );
//   }

//   void _handleSave() {
//     if (_formKey.currentState!.validate()) {
//       final profileData = controller.profileModel.value?.data;
//       final isExpert = profileData?.isExpert() ?? false;

//       controller.updateProfile(
//         fullName: _nameController.text.trim(),
//         phone: _phoneController.text.trim(),
//         specialization: isExpert ? _specializationController.text.trim() : null,
//         organization: isExpert ? _organizationController.text.trim() : null,
//         contactEmail: isExpert ? _emailController.text.trim() : null,
//       );
//     }
//   }

//   void _showDeleteAccountDialog(BuildContext context) {
//     final size = CustomSize();

//     Get.dialog(
//       AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         title: Row(
//           children: [
//             Icon(Icons.warning_amber_rounded, color: AppColors.errorColor, size: 28),
//             SizedBox(width: 10),
//             Text(
//               'Delete Account',
//               style: GoogleFonts.poppins(
//                 fontWeight: FontWeight.bold,
//                 fontSize: size.customWidth(context) * 0.048,
//                 color: AppColors.errorColor,
//               ),
//             ),
//           ],
//         ),
//         content: Text(
//           'This action cannot be undone. All your data will be permanently deleted.\n\nAre you sure you want to delete your account?',
//           style: GoogleFonts.poppins(
//             fontSize: size.customWidth(context) * 0.038,
//             color: AppColors.textSecondaryColor,
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Get.back(),
//             child: Text(
//               'Cancel',
//               style: GoogleFonts.poppins(
//                 color: AppColors.textSecondaryColor,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Get.back();
//               Get.snackbar(
//                 'Coming Soon',
//                 'Account deletion feature will be available soon',
//                 backgroundColor: AppColors.warningColor,
//                 colorText: AppColors.whiteColor,
//                 snackPosition: SnackPosition.TOP,
//               );
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: AppColors.errorColor,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//             child: Text(
//               'Delete',
//               style: GoogleFonts.poppins(
//                 color: AppColors.whiteColor,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// lib/view/profile/edit_profile_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/components/custom_button.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import 'package:speechspectrum/controllers/profile_controller.dart';
import 'package:speechspectrum/models/profile_model.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _specializationController;
  late TextEditingController _organizationController;

  final controller = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    final profileData = controller.profileModel.value?.data;

    if (profileData?.isParent() == true) {
      final profile = profileData!.profile as ParentProfile;
      _nameController = TextEditingController(text: profile.fullName);
      _phoneController = TextEditingController(text: profile.phone);
      _emailController = TextEditingController();
      _specializationController = TextEditingController();
      _organizationController = TextEditingController();
    } else if (profileData?.isExpert() == true) {
      final profile = profileData!.profile as ExpertProfile;
      _nameController = TextEditingController(text: profile.fullName);
      _phoneController = TextEditingController(text: profile.phone);
      _emailController = TextEditingController(text: profile.contactEmail ?? '');
      _specializationController = TextEditingController(text: profile.specialization ?? '');
      _organizationController = TextEditingController(text: profile.organization ?? '');
    } else {
      _nameController = TextEditingController();
      _phoneController = TextEditingController();
      _emailController = TextEditingController();
      _specializationController = TextEditingController();
      _organizationController = TextEditingController();
    }
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
    final profileData = controller.profileModel.value?.data;
    final isExpert = profileData?.isExpert() ?? false;

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
            fontSize: size.customWidth(context) * 0.045,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(size.customWidth(context) * 0.05),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Profile Picture Section
              Stack(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primaryColor.withOpacity(0.2),
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      controller.userInitial,
                      style: GoogleFonts.poppins(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.primaryColor, AppColors.secondaryColor],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.whiteColor,
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryColor.withOpacity(0.3),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        color: AppColors.whiteColor,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: size.customHeight(context) * 0.01),

              Text(
                'Change Photo',
                style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.035,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: size.customHeight(context) * 0.04),

              // Form Fields
              _buildTextField(
                context: context,
                controller: _nameController,
                hintText: 'Full Name',
                icon: Icons.person_outline,
                validator: (val) =>
                    val == null || val.trim().isEmpty ? 'Name is required' : null,
              ),

              SizedBox(height: size.customHeight(context) * 0.02),

              _buildTextField(
                context: context,
                controller: _phoneController,
                hintText: 'Phone Number',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                validator: (val) =>
                    val == null || val.trim().isEmpty ? 'Phone is required' : null,
              ),

              if (isExpert) ...[
                SizedBox(height: size.customHeight(context) * 0.02),

                _buildTextField(
                  context: context,
                  controller: _emailController,
                  hintText: 'Email Address',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),

                SizedBox(height: size.customHeight(context) * 0.02),

                _buildTextField(
                  context: context,
                  controller: _specializationController,
                  hintText: 'Specialization',
                  icon: Icons.medical_services_outlined,
                ),

                SizedBox(height: size.customHeight(context) * 0.02),

                _buildTextField(
                  context: context,
                  controller: _organizationController,
                  hintText: 'Organization',
                  icon: Icons.business_outlined,
                ),
              ],

              SizedBox(height: size.customHeight(context) * 0.04),

              // Save Button
              Obx(() => CustomButton(
                    title: 'Save Changes',
                    height: size.customHeight(context) * 0.065,
                    width: double.infinity,
                    radius: size.customHeight(context) * 0.2,
                    color: AppColors.primaryColor,
                    loading: controller.isUpdating.value,
                    onTap: _handleSave,
                  )),

              SizedBox(height: size.customHeight(context) * 0.02),

              // Delete Account Button (Future Implementation)
              OutlinedButton.icon(
                onPressed: () => _showDeleteAccountDialog(context),
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(
                    double.infinity,
                    size.customHeight(context) * 0.065,
                  ),
                  side: BorderSide(color: AppColors.errorColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(size.customHeight(context) * 0.2),
                  ),
                ),
                icon: Icon(Icons.delete_outline, color: AppColors.errorColor),
                label: Text(
                  'Delete Account',
                  style: GoogleFonts.poppins(
                    fontSize: size.customWidth(context) * 0.04,
                    color: AppColors.errorColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
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
        fillColor: AppColors.whiteColor,
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
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(size.customHeight(context) * 0.015),
          borderSide: BorderSide(color: AppColors.errorColor, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: size.customHeight(context) * 0.02,
          horizontal: size.customWidth(context) * 0.04,
        ),
      ),
    );
  }

  void _handleSave() {
    if (_formKey.currentState!.validate()) {
      final profileData = controller.profileModel.value?.data;
      final isExpert = profileData?.isExpert() ?? false;

      controller.updateProfile(
        fullName: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
        specialization: isExpert ? _specializationController.text.trim() : null,
        organization: isExpert ? _organizationController.text.trim() : null,
        contactEmail: isExpert ? _emailController.text.trim() : null,
      );
    }
  }

  void _showDeleteAccountDialog(BuildContext context) {
    final size = CustomSize();

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Container(
          padding: EdgeInsets.all(size.customWidth(context) * 0.05),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Warning Icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.errorColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.warning_amber_rounded,
                  color: AppColors.errorColor,
                  size: 45,
                ),
              ),

              SizedBox(height: size.customHeight(context) * 0.025),

              // Title
              Text(
                'Delete Account',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: size.customWidth(context) * 0.055,
                  color: AppColors.textPrimaryColor,
                ),
              ),

              SizedBox(height: size.customHeight(context) * 0.015),

              // Description
              Text(
                'This action is permanent and cannot be undone.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.038,
                  color: AppColors.textSecondaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: size.customHeight(context) * 0.01),

              // Warning Points
              Container(
                padding: EdgeInsets.all(size.customWidth(context) * 0.04),
                decoration: BoxDecoration(
                  color: AppColors.errorColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.errorColor.withOpacity(0.2),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildWarningPoint(
                      context,
                      'All your personal data will be permanently deleted',
                    ),
                    SizedBox(height: size.customHeight(context) * 0.008),
                    _buildWarningPoint(
                      context,
                      'Your screening history will be lost',
                    ),
                    SizedBox(height: size.customHeight(context) * 0.008),
                    _buildWarningPoint(
                      context,
                      'You will be logged out immediately',
                    ),
                    SizedBox(height: size.customHeight(context) * 0.008),
                    _buildWarningPoint(
                      context,
                      'This action cannot be reversed',
                    ),
                  ],
                ),
              ),

              SizedBox(height: size.customHeight(context) * 0.03),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: size.customHeight(context) * 0.015,
                        ),
                        side: BorderSide(
                          color: AppColors.greyColor.withOpacity(0.5),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.poppins(
                          color: AppColors.textSecondaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: size.customWidth(context) * 0.04,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: size.customWidth(context) * 0.03),
                  Expanded(
                    child: Obx(() => ElevatedButton(
                          onPressed: controller.isDeleting.value
                              ? null
                              : () {
                                  Get.back();
                                  controller.deleteProfile();
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.errorColor,
                            padding: EdgeInsets.symmetric(
                              vertical: size.customHeight(context) * 0.015,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: controller.isDeleting.value
                              ? SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: AppColors.whiteColor,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  'Delete',
                                  style: GoogleFonts.poppins(
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: size.customWidth(context) * 0.04,
                                  ),
                                ),
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

  Widget _buildWarningPoint(BuildContext context, String text) {
    final size = CustomSize();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.close,
          color: AppColors.errorColor,
          size: 16,
        ),
        SizedBox(width: size.customWidth(context) * 0.02),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: size.customWidth(context) * 0.034,
              color: AppColors.textPrimaryColor,
              height: 1.3,
            ),
          ),
        ),
      ],
    );
  }
}