// // lib/view/questionnaire/patient_info_screen.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/child_controller.dart';
// import 'package:speechspectrum/controllers/questionnaire_controller.dart';
// import 'package:speechspectrum/routes/app_routes.dart';

// class PatientInfoScreen extends StatefulWidget {
//   const PatientInfoScreen({super.key});

//   @override
//   State<PatientInfoScreen> createState() => _PatientInfoScreenState();
// }

// class _PatientInfoScreenState extends State<PatientInfoScreen> {
//   final childController = Get.put(ChildController());
//   final questionnaireController = Get.put(QuestionnaireController());
  
//   String? selectedChildId;
//   int ageInMonths = 12;
//   String selectedGender = 'Male';
//   String hasJaundice = 'No';
//   String familyHistoryASD = 'No';
  
//   @override
//   void initState() {
//     super.initState();
//     childController.fetchChildren();
//   }

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
//           'Patient Information',
//           style: GoogleFonts.poppins(
//             color: AppColors.textPrimaryColor,
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(size.customWidth(context) * 0.05),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // Header Card
//             Container(
//               padding: EdgeInsets.all(size.customWidth(context) * 0.05),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [AppColors.primaryColor, AppColors.secondaryColor],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Column(
//                 children: [
//                   Icon(
//                     Icons.assignment_outlined,
//                     size: 50,
//                     color: AppColors.whiteColor,
//                   ),
//                   SizedBox(height: size.customHeight(context) * 0.015),
//                   Text(
//                     'Patient Information',
//                     style: GoogleFonts.poppins(
//                       color: AppColors.whiteColor,
//                       fontSize: size.customWidth(context) * 0.055,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: size.customHeight(context) * 0.008),
//                   Text(
//                     'Please provide accurate details for the best assessment experience',
//                     style: GoogleFonts.poppins(
//                       color: AppColors.whiteColor.withOpacity(0.9),
//                       fontSize: size.customWidth(context) * 0.035,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//             ),
            
//             SizedBox(height: size.customHeight(context) * 0.025),
            
//             // Form Container
//             Container(
//               padding: EdgeInsets.all(size.customWidth(context) * 0.05),
//               decoration: BoxDecoration(
//                 color: AppColors.whiteColor,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Child Selection
//                   Text(
//                     'Child\'s Name *',
//                     style: GoogleFonts.poppins(
//                       fontSize: size.customWidth(context) * 0.04,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.textPrimaryColor,
//                     ),
//                   ),
//                   SizedBox(height: size.customHeight(context) * 0.01),
//                   Obx(() {
//                     if (childController.isLoading.value) {
//                       return Container(
//                         padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//                         decoration: BoxDecoration(
//                           color: AppColors.lightGreyColor,
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Center(
//                           child: CircularProgressIndicator(
//                             color: AppColors.primaryColor,
//                             strokeWidth: 2,
//                           ),
//                         ),
//                       );
//                     }

//                     if (childController.children.isEmpty) {
//                       return Container(
//                         padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//                         decoration: BoxDecoration(
//                           color: AppColors.lightGreyColor,
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Text(
//                           'No children found. Please add a child first.',
//                           style: GoogleFonts.poppins(
//                             color: AppColors.textSecondaryColor,
//                           ),
//                         ),
//                       );
//                     }

//                     return Container(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: size.customWidth(context) * 0.04,
//                       ),
//                       decoration: BoxDecoration(
//                         color: AppColors.lightGreyColor,
//                         borderRadius: BorderRadius.circular(12),
//                         border: Border.all(
//                           color: AppColors.greyColor.withOpacity(0.3),
//                         ),
//                       ),
//                       child: DropdownButtonHideUnderline(
//                         child: DropdownButton<String>(
//                           isExpanded: true,
//                           hint: Text(
//                             'Select child',
//                             style: GoogleFonts.poppins(
//                               color: AppColors.greyColor,
//                             ),
//                           ),
//                           value: selectedChildId,
//                           icon: Icon(Icons.arrow_drop_down, color: AppColors.primaryColor),
//                           items: childController.children.map((child) {
//                             return DropdownMenuItem<String>(
//                               value: child.childId,
//                               child: Text(
//                                 child.childName,
//                                 style: GoogleFonts.poppins(
//                                   color: AppColors.textPrimaryColor,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             );
//                           }).toList(),
//                           onChanged: (value) {
//                             setState(() {
//                               selectedChildId = value;
//                               questionnaireController.selectedChildId.value = value ?? '';
//                             });
//                           },
//                         ),
//                       ),
//                     );
//                   }),
                  
//                   SizedBox(height: size.customHeight(context) * 0.025),
                  
//                   // Age and Gender Row
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Age (Months)',
//                               style: GoogleFonts.poppins(
//                                 fontSize: size.customWidth(context) * 0.04,
//                                 fontWeight: FontWeight.w600,
//                                 color: AppColors.textPrimaryColor,
//                               ),
//                             ),
//                             SizedBox(height: size.customHeight(context) * 0.01),
//                             Container(
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: size.customWidth(context) * 0.04,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: AppColors.lightGreyColor,
//                                 borderRadius: BorderRadius.circular(12),
//                                 border: Border.all(
//                                   color: AppColors.greyColor.withOpacity(0.3),
//                                 ),
//                               ),
//                               child: TextField(
//                                 keyboardType: TextInputType.number,
//                                 style: GoogleFonts.poppins(
//                                   color: AppColors.textPrimaryColor,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                                 decoration: InputDecoration(
//                                   border: InputBorder.none,
//                                   hintText: '12',
//                                   hintStyle: GoogleFonts.poppins(
//                                     color: AppColors.greyColor,
//                                   ),
//                                 ),
//                                 onChanged: (value) {
//                                   ageInMonths = int.tryParse(value) ?? 12;
//                                   questionnaireController.ageInMonths.value = ageInMonths;
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(width: size.customWidth(context) * 0.04),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Gender',
//                               style: GoogleFonts.poppins(
//                                 fontSize: size.customWidth(context) * 0.04,
//                                 fontWeight: FontWeight.w600,
//                                 color: AppColors.textPrimaryColor,
//                               ),
//                             ),
//                             SizedBox(height: size.customHeight(context) * 0.01),
//                             Container(
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: size.customWidth(context) * 0.04,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: AppColors.lightGreyColor,
//                                 borderRadius: BorderRadius.circular(12),
//                                 border: Border.all(
//                                   color: AppColors.greyColor.withOpacity(0.3),
//                                 ),
//                               ),
//                               child: DropdownButtonHideUnderline(
//                                 child: DropdownButton<String>(
//                                   isExpanded: true,
//                                   value: selectedGender,
//                                   icon: Icon(Icons.arrow_drop_down, color: AppColors.primaryColor),
//                                   items: ['Male', 'Female'].map((gender) {
//                                     return DropdownMenuItem<String>(
//                                       value: gender,
//                                       child: Text(
//                                         gender,
//                                         style: GoogleFonts.poppins(
//                                           color: AppColors.textPrimaryColor,
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                       ),
//                                     );
//                                   }).toList(),
//                                   onChanged: (value) {
//                                     setState(() {
//                                       selectedGender = value!;
//                                       questionnaireController.gender.value =
//                                           value == 'Male' ? 1 : 0;
//                                     });
//                                   },
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
                  
//                   SizedBox(height: size.customHeight(context) * 0.025),
                  
//                   // Jaundice
//                   _buildDropdownField(
//                     context: context,
//                     label: 'Has the child experienced jaundice?',
//                     value: hasJaundice,
//                     items: ['Yes', 'No'],
//                     onChanged: (value) {
//                       setState(() {
//                         hasJaundice = value!;
//                         questionnaireController.hasJaundice.value =
//                             value == 'Yes' ? 6 : 0;
//                       });
//                     },
//                   ),
                  
//                   SizedBox(height: size.customHeight(context) * 0.025),
                  
//                   // Family History
//                   _buildDropdownField(
//                     context: context,
//                     label: 'Family history of ASD?',
//                     value: familyHistoryASD,
//                     items: ['Yes', 'No'],
//                     onChanged: (value) {
//                       setState(() {
//                         familyHistoryASD = value!;
//                         questionnaireController.familyHistoryASD.value =
//                             value == 'Yes' ? 3 : 0;
//                       });
//                     },
//                   ),
//                 ],
//               ),
//             ),
            
//             SizedBox(height: size.customHeight(context) * 0.03),
            
//             // Begin Screening Button
//             SizedBox(
//               width: double.infinity,
//               height: size.customHeight(context) * 0.065,
//               child: ElevatedButton(
//                 onPressed: selectedChildId == null
//                     ? null
//                     : () {
//                         Get.toNamed(AppRoutes.questionnaire);
//                       },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.primaryColor,
//                   disabledBackgroundColor: AppColors.greyColor,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   elevation: 0,
//                 ),
//                 child: Text(
//                   'Begin Screening',
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.045,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.whiteColor,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDropdownField({
//     required BuildContext context,
//     required String label,
//     required String value,
//     required List<String> items,
//     required ValueChanged<String?> onChanged,
//   }) {
//     final size = CustomSize();
    
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: GoogleFonts.poppins(
//             fontSize: size.customWidth(context) * 0.04,
//             fontWeight: FontWeight.w600,
//             color: AppColors.textPrimaryColor,
//           ),
//         ),
//         SizedBox(height: size.customHeight(context) * 0.01),
//         Container(
//           padding: EdgeInsets.symmetric(
//             horizontal: size.customWidth(context) * 0.04,
//           ),
//           decoration: BoxDecoration(
//             color: AppColors.lightGreyColor,
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(
//               color: AppColors.greyColor.withOpacity(0.3),
//             ),
//           ),
//           child: DropdownButtonHideUnderline(
//             child: DropdownButton<String>(
//               isExpanded: true,
//               value: value,
//               icon: Icon(Icons.arrow_drop_down, color: AppColors.primaryColor),
//               items: items.map((item) {
//                 return DropdownMenuItem<String>(
//                   value: item,
//                   child: Text(
//                     item,
//                     style: GoogleFonts.poppins(
//                       color: AppColors.textPrimaryColor,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 );
//               }).toList(),
//               onChanged: onChanged,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }


// lib/view/questionnaire/patient_info_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import 'package:speechspectrum/controllers/child_controller.dart';
import 'package:speechspectrum/controllers/questionnaire_controller.dart';
import 'package:speechspectrum/routes/app_routes.dart';

class PatientInfoScreen extends StatefulWidget {
  const PatientInfoScreen({super.key});

  @override
  State<PatientInfoScreen> createState() => _PatientInfoScreenState();
}

class _PatientInfoScreenState extends State<PatientInfoScreen> {
  final childController = Get.put(ChildController());
  final questionnaireController = Get.put(QuestionnaireController());
  final ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    questionnaireController.resetQuestionnaire();
  }

  @override
  void dispose() {
    ageController.dispose();
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimaryColor),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Patient Information',
          style: GoogleFonts.poppins(
            color: AppColors.textPrimaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Obx(() {
        if (childController.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(size.customWidth(context) * 0.05),
          child: Column(
            children: [
              // Header Card
              Container(
                padding: EdgeInsets.all(size.customWidth(context) * 0.05),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primaryColor, AppColors.secondaryColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.assignment_outlined,
                      size: 50,
                      color: AppColors.whiteColor,
                    ),
                    SizedBox(height: size.customHeight(context) * 0.015),
                    Text(
                      'Patient Information',
                      style: GoogleFonts.poppins(
                        fontSize: size.customWidth(context) * 0.055,
                        fontWeight: FontWeight.bold,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    SizedBox(height: size.customHeight(context) * 0.008),
                    Text(
                      'Please provide accurate details for the best assessment experience',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: size.customWidth(context) * 0.035,
                        color: AppColors.whiteColor.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: size.customHeight(context) * 0.03),

              // Form Container
              Container(
                padding: EdgeInsets.all(size.customWidth(context) * 0.05),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Child Name Selection
                    Text(
                      'Child\'s Name',
                      style: GoogleFonts.poppins(
                        fontSize: size.customWidth(context) * 0.04,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimaryColor,
                      ),
                    ),
                    Text(
                      '*',
                      style: GoogleFonts.poppins(
                        fontSize: size.customWidth(context) * 0.04,
                        color: AppColors.errorColor,
                      ),
                    ),
                    SizedBox(height: size.customHeight(context) * 0.01),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.lightGreyColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.greyColor.withOpacity(0.2),
                        ),
                      ),
                      child: DropdownButtonFormField<String>(
                         dropdownColor: AppColors.whiteColor,
                        icon: Icon(Icons.arrow_drop_down, color: AppColors.primaryColor),
                       
                        decoration: InputDecoration(
                          
                          hintText: 'Select child',
                          hintStyle: GoogleFonts.poppins(
                            color: AppColors.greyColor,
                            fontSize: size.customWidth(context) * 0.038,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: size.customWidth(context) * 0.04,
                            vertical: size.customHeight(context) * 0.018,
                          ),
                        ),
                        items: childController.children.map((child) {
                          return DropdownMenuItem<String>(
                            value: child.childId,
                            child: Text(
                              child.childName,
                              style: GoogleFonts.poppins(
                                fontSize: size.customWidth(context) * 0.038,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            questionnaireController.selectedChildId.value = value;
                            final selectedChild = childController.children
                                .firstWhere((child) => child.childId == value);
                            
                            // Auto-fill gender
                            questionnaireController.selectedGender.value =
                                selectedChild.gender.toLowerCase() == 'male' ? 1 : 0;
                          }
                        },
                      ),
                    ),

                    SizedBox(height: size.customHeight(context) * 0.025),

                    // Age in Months
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Age (Months)',
                                style: GoogleFonts.poppins(
                                  fontSize: size.customWidth(context) * 0.04,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimaryColor,
                                ),
                              ),
                              SizedBox(height: size.customHeight(context) * 0.01),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.lightGreyColor,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: AppColors.greyColor.withOpacity(0.2),
                                  ),
                                ),
                                child: TextField(
                                  controller: ageController,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    questionnaireController.ageMonths.value =
                                        int.tryParse(value) ?? 0;
                                  },
                                  style: GoogleFonts.poppins(
                                    fontSize: size.customWidth(context) * 0.038,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: '36',
                                    hintStyle: GoogleFonts.poppins(
                                      color: AppColors.greyColor,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: size.customWidth(context) * 0.04,
                                      vertical: size.customHeight(context) * 0.018,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: size.customWidth(context) * 0.04),

                        // Gender
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Gender',
                                style: GoogleFonts.poppins(
                                  fontSize: size.customWidth(context) * 0.04,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimaryColor,
                                ),
                              ),
                              SizedBox(height: size.customHeight(context) * 0.01),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.lightGreyColor,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: AppColors.greyColor.withOpacity(0.2),
                                  ),
                                ),
                                child: Obx(() => DropdownButtonFormField<int>(
                                  dropdownColor: AppColors.whiteColor,
                        icon: Icon(Icons.arrow_drop_down, color: AppColors.primaryColor),
                       
                                      value: questionnaireController.selectedGender.value,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: size.customWidth(context) * 0.04,
                                          vertical: size.customHeight(context) * 0.018,
                                        ),
                                      ),
                                      items: [
                                        DropdownMenuItem(
                                          value: 1,
                                          child: Text(
                                            'Male',
                                            style: GoogleFonts.poppins(
                                              fontSize: size.customWidth(context) * 0.038,
                                            ),
                                          ),
                                        ),
                                        DropdownMenuItem(
                                          value: 0,
                                          child: Text(
                                            'Female',
                                            style: GoogleFonts.poppins(
                                              fontSize: size.customWidth(context) * 0.038,
                                            ),
                                          ),
                                        ),
                                      ],
                                      onChanged: (value) {
                                        if (value != null) {
                                          questionnaireController.selectedGender.value = value;
                                        }
                                      },
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: size.customHeight(context) * 0.025),

                    // Jaundice
                    Text(
                      'Has the child experienced jaundice?',
                      style: GoogleFonts.poppins(
                        fontSize: size.customWidth(context) * 0.04,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimaryColor,
                      ),
                    ),
                    SizedBox(height: size.customHeight(context) * 0.01),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.lightGreyColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.greyColor.withOpacity(0.2),
                        ),
                      ),
                      child: Obx(() => DropdownButtonFormField<int>(
                        dropdownColor: AppColors.whiteColor,
                        icon: Icon(Icons.arrow_drop_down, color: AppColors.primaryColor),
                       
                            value: questionnaireController.hasJaundice.value,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: size.customWidth(context) * 0.04,
                                vertical: size.customHeight(context) * 0.018,
                              ),
                            ),
                            items: [
                              DropdownMenuItem(
                                value: 0,
                                child: Text(
                                  'No',
                                  style: GoogleFonts.poppins(
                                    fontSize: size.customWidth(context) * 0.038,
                                  ),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 1,
                                child: Text(
                                  'Yes',
                                  style: GoogleFonts.poppins(
                                    fontSize: size.customWidth(context) * 0.038,
                                  ),
                                ),
                              ),
                            ],
                            onChanged: (value) {
                              if (value != null) {
                                questionnaireController.hasJaundice.value = value;
                              }
                            },
                          )),
                    ),

                    SizedBox(height: size.customHeight(context) * 0.025),

                    // Family History of ASD
                    Text(
                      'Family history of ASD?',
                      style: GoogleFonts.poppins(
                        fontSize: size.customWidth(context) * 0.04,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimaryColor,
                      ),
                    ),
                    SizedBox(height: size.customHeight(context) * 0.01),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.lightGreyColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.greyColor.withOpacity(0.2),
                        ),
                      ),
                      child: Obx(() => DropdownButtonFormField<int>(
                        dropdownColor: AppColors.whiteColor,
                        icon: Icon(Icons.arrow_drop_down, color: AppColors.primaryColor),
                       
                            value: questionnaireController.hasFamilyASD.value,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: size.customWidth(context) * 0.04,
                                vertical: size.customHeight(context) * 0.018,
                              ),
                            ),
                            items: [
                              DropdownMenuItem(
                                value: 0,
                                child: Text(
                                  'No',
                                  style: GoogleFonts.poppins(
                                    fontSize: size.customWidth(context) * 0.038,
                                  ),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 1,
                                child: Text(
                                  'Yes',
                                  style: GoogleFonts.poppins(
                                    fontSize: size.customWidth(context) * 0.038,
                                  ),
                                ),
                              ),
                            ],
                            onChanged: (value) {
                              if (value != null) {
                                questionnaireController.hasFamilyASD.value = value;
                              }
                            },
                          )),
                    ),
                  ],
                ),
              ),

              SizedBox(height: size.customHeight(context) * 0.03),

              // Begin Screening Button
              SizedBox(
                width: double.infinity,
                height: size.customHeight(context) * 0.06,
                child: Obx(() => ElevatedButton(
                      onPressed: questionnaireController.selectedChildId.value.isEmpty ||
                              questionnaireController.ageMonths.value == 0
                          ? null
                          : () => Get.toNamed(AppRoutes.questionnaire),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        disabledBackgroundColor: AppColors.greyColor.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Begin Screening',
                        style: GoogleFonts.poppins(
                          fontSize: size.customWidth(context) * 0.042,
                          fontWeight: FontWeight.w600,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    )),
              ),

              SizedBox(height: size.customHeight(context) * 0.02),
            ],
          ),
        );
      }),
    );
  }
}