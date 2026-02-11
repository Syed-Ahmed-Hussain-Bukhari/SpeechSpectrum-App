// // view/auth/phone_screen.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../../controllers/registration_controller.dart';
// import '../../routes/app_routes.dart';
// import '../../constants/app_colors.dart';
// import '../../constants/custom_size.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';

// class PhoneScreen extends StatelessWidget {
//   PhoneScreen({super.key});

//   final _formKey = GlobalKey<FormState>();
//   final _phoneController = TextEditingController();
//   final RegistrationController regController = Get.find();
//   String? _fullPhoneNumber;

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();

//     return Scaffold(
//       backgroundColor: AppColors.whiteColor,
//       appBar: AppBar(
//         backgroundColor: AppColors.whiteColor,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: AppColors.blackColor),
//           onPressed: () => Get.back(),
//         ),
//         title: Column(
//           children: [
//             SizedBox(height: size.customHeight(context) * 0.025),
//             LinearProgressIndicator(
//               value: 3 / 4,
//               backgroundColor: AppColors.greyColor.withOpacity(0.3),
//               valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
//               minHeight: size.customHeight(context) * 0.008,
//             ),
//             SizedBox(height: size.customHeight(context) * 0.008),
//             Text(
//               'STEP 3/4',
//               style: GoogleFonts.poppins(
//                 fontSize: size.customWidth(context) * 0.03,
//                 fontWeight: FontWeight.w600,
//                 color: AppColors.primaryColor,
//               ),
//             ),
//           ],
//         ),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: size.customWidth(context) * 0.05),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: size.customHeight(context) * 0.03),

//                 /// Title
//                 Center(
//                   child: Text(
//                     'Phone Number',
//                     style: GoogleFonts.poppins(
//                       fontSize: size.customWidth(context) * 0.06,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.textPrimaryColor,
//                     ),
//                   ),
//                 ),

//                 SizedBox(height: size.customHeight(context) * 0.01),

//                 /// Subtitle
//                 Center(
//                   child: Text(
//                     'Please enter your phone number',
//                     textAlign: TextAlign.center,
//                     style: GoogleFonts.poppins(
//                       fontSize: size.customWidth(context) * 0.038,
//                       color: AppColors.textSecondaryColor,
//                     ),
//                   ),
//                 ),

//                 SizedBox(height: size.customHeight(context) * 0.05),

//                 /// Phone Number Field
//                 Container(
//                   // decoration: BoxDecoration(
//                   //   color: AppColors.whiteColor,
//                   //   borderRadius: BorderRadius.circular(size.customHeight(context) * 0.2),
//                   //   boxShadow: [
//                   //     BoxShadow(
//                   //       color: AppColors.greyColor.withOpacity(0.15),
//                   //       spreadRadius: 1,
//                   //       blurRadius: 5,
//                   //       offset: const Offset(0, 2),
//                   //     ),
//                   //   ],
//                   // ),
//                   child: IntlPhoneField(
//                     controller: _phoneController,
//                     decoration: InputDecoration(
//                       hintText: 'Phone Number',
//                       hintStyle: GoogleFonts.poppins(
//                         fontSize: size.customWidth(context) * 0.04,
//                         color: AppColors.greyColor,
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(size.customHeight(context) * 0.2),
//                         borderSide: BorderSide.none,
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(size.customHeight(context) * 0.2),
//                         borderSide: BorderSide(color: AppColors.greyColor.withOpacity(0.3), width: 1),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(size.customHeight(context) * 0.2),
//                         borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
//                       ),
//                       errorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(size.customHeight(context) * 0.2),
//                         borderSide: BorderSide(color: AppColors.errorColor, width: 1.5),
//                       ),
//                       focusedErrorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(size.customHeight(context) * 0.2),
//                         borderSide: BorderSide(color: AppColors.errorColor, width: 2),
//                       ),
//                       contentPadding: EdgeInsets.symmetric(
//                         vertical: size.customHeight(context) * 0.02,
//                         horizontal: size.customWidth(context) * 0.04,
//                       ),
//                     ),
//                     initialCountryCode: 'PK',
//                     onChanged: (phone) {
//                       _fullPhoneNumber = phone.completeNumber;
//                     },
//                     validator: (phone) {
//                       if (phone == null || phone.number.trim().isEmpty) {
//                         return 'Phone number is required';
//                       }
//                       return null;
//                     },
//                     dropdownIcon: Icon(
//                       Icons.arrow_drop_down,
//                       color: AppColors.greyColor,
//                     ),
//                     keyboardType: TextInputType.phone,
//                     cursorColor: AppColors.primaryColor,
//                     style: GoogleFonts.poppins(
//                       fontSize: size.customWidth(context) * 0.04,
//                       color: AppColors.textPrimaryColor,
//                     ),
//                     dropdownTextStyle: GoogleFonts.poppins(
//                       fontSize: size.customWidth(context) * 0.04,
//                       color: AppColors.textPrimaryColor,
//                     ),
//                     flagsButtonPadding: EdgeInsets.only(left: size.customWidth(context) * 0.04),
//                   ),
//                 ),

//                 const Spacer(),

//                 /// Continue Button
//                 SizedBox(
//                   width: double.infinity,
//                   height: size.customHeight(context) * 0.065,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       if (_formKey.currentState!.validate()) {
//                         regController.setPhoneNumber(_fullPhoneNumber ?? '');
//                         Get.toNamed(AppRoutes.signup);
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.primaryColor,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(size.customHeight(context) * 0.2),
//                       ),
//                       elevation: 3,
//                     ),
//                     child: Text(
//                       'Continue',
//                       style: GoogleFonts.poppins(
//                         fontSize: size.customWidth(context) * 0.045,
//                         fontWeight: FontWeight.w600,
//                         color: AppColors.whiteColor,
//                       ),
//                     ),
//                   ),
//                 ),

//                 SizedBox(height: size.customHeight(context) * 0.03),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


// view/auth/phone_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/registration_controller.dart';
import '../../routes/app_routes.dart';
import '../../constants/app_colors.dart';
import '../../constants/custom_size.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneScreen extends StatelessWidget {
  PhoneScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final RegistrationController regController = Get.find();
  String? _fullPhoneNumber;

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
            // Obx(() {
            //   // Calculate progress based on role
            //   final isExpert = regController.role.value == 'expert';
            //   final currentStep = isExpert ? 2 : 3;
            //   final totalSteps = isExpert ? 6 : 4;
            //   final progress = currentStep / totalSteps;

            //   return LinearProgressIndicator(
            //     value: progress,
            //     backgroundColor: AppColors.greyColor.withOpacity(0.3),
            //     valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
            //     minHeight: size.customHeight(context) * 0.008,
            //   );
            // }),
            // SizedBox(height: size.customHeight(context) * 0.008),
            // Obx(() {
            //   final isExpert = regController.role.value == 'expert';
            //   final stepText = isExpert ? 'STEP 2/6' : 'STEP 3/4';
              
            //   return Text(
            //     stepText,
            //     style: GoogleFonts.poppins(
            //       fontSize: size.customWidth(context) * 0.03,
            //       fontWeight: FontWeight.w600,
            //       color: AppColors.primaryColor,
            //     ),
            //   );
            // }),
               Obx(() {
              // Calculate progress based on role
              final isExpert = regController.role.value == 'expert';
              final currentStep = isExpert ? 3 : 3;
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
              final stepText = isExpert ? 'STEP 3/6' : 'STEP 3/4';
              
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.customHeight(context) * 0.03),

                /// Title
                Center(
                  child: Text(
                    'Phone Number',
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
                    'Please enter your phone number',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: size.customWidth(context) * 0.038,
                      color: AppColors.textSecondaryColor,
                    ),
                  ),
                ),

                SizedBox(height: size.customHeight(context) * 0.05),

                /// Phone Number Field
                Container(
                  child: IntlPhoneField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      hintText: 'Phone Number',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: size.customWidth(context) * 0.04,
                        color: AppColors.greyColor,
                      ),
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
                    initialCountryCode: 'PK',
                    onChanged: (phone) {
                      _fullPhoneNumber = phone.completeNumber;
                    },
                    validator: (phone) {
                      if (phone == null || phone.number.trim().isEmpty) {
                        return 'Phone number is required';
                      }
                      return null;
                    },
                    dropdownIcon: Icon(
                      Icons.arrow_drop_down,
                      color: AppColors.greyColor,
                    ),
                    keyboardType: TextInputType.phone,
                    cursorColor: AppColors.primaryColor,
                    style: GoogleFonts.poppins(
                      fontSize: size.customWidth(context) * 0.04,
                      color: AppColors.textPrimaryColor,
                    ),
                    dropdownTextStyle: GoogleFonts.poppins(
                      fontSize: size.customWidth(context) * 0.04,
                      color: AppColors.textPrimaryColor,
                    ),
                    flagsButtonPadding: EdgeInsets.only(left: size.customWidth(context) * 0.04),
                  ),
                ),

                const Spacer(),

                /// Continue Button
                SizedBox(
                  width: double.infinity,
                  height: size.customHeight(context) * 0.065,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        regController.setPhoneNumber(_fullPhoneNumber ?? '');
                        
                        // Navigate based on role
                        if (regController.role.value == 'expert') {
                          Get.toNamed(AppRoutes.expertInfo);
                        } else {
                          // Parent role - go directly to signup
                          Get.toNamed(AppRoutes.signup);
                        }
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
}