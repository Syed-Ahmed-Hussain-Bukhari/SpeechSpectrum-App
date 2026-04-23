// // lib/view/auth/add_children_screen.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/registration_controller.dart';
// import 'package:speechspectrum/controllers/pre_signup_child_controller.dart';
// import 'package:speechspectrum/routes/app_routes.dart';

// class AddChildrenScreen extends StatelessWidget {
//   const AddChildrenScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();
//     final RegistrationController regController = Get.find();
//     final PreSignupChildController childCtrl =
//         Get.isRegistered<PreSignupChildController>()
//             ? Get.find<PreSignupChildController>()
//             : Get.put(PreSignupChildController());

//     return Scaffold(
//       backgroundColor: AppColors.whiteColor,
//       appBar: AppBar(
//         backgroundColor: AppColors.whiteColor,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: AppColors.blackColor),
//           onPressed: () => Get.back(),
//         ),
//         title: Column(
//           children: [
//             SizedBox(height: size.customHeight(context) * 0.025),
//             Obx(() {
//               final isExpert = regController.role.value == 'expert';
//               final currentStep = isExpert ? 4 : 4;
//               final totalSteps = isExpert ? 6 : 5;
//               final progress = currentStep / totalSteps;
//               return LinearProgressIndicator(
//                 value: progress,
//                 backgroundColor: AppColors.greyColor.withOpacity(0.3),
//                 valueColor:
//                     const AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
//                 minHeight: size.customHeight(context) * 0.008,
//               );
//             }),
//             SizedBox(height: size.customHeight(context) * 0.008),
//             Text(
//               'STEP 4/5',
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
//         child: Obx(() {
//           return Column(
//             children: [
//               Expanded(
//                 child: SingleChildScrollView(
//                   padding: EdgeInsets.symmetric(
//                       horizontal: size.customWidth(context) * 0.05),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(height: size.customHeight(context) * 0.03),

//                       // ── Title ──────────────────────────────────────────
//                       Center(
//                         child: Text(
//                           'Add Your Children',
//                           style: GoogleFonts.poppins(
//                             fontSize: size.customWidth(context) * 0.06,
//                             fontWeight: FontWeight.bold,
//                             color: AppColors.textPrimaryColor,
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: size.customHeight(context) * 0.008),
//                       Center(
//                         child: Text(
//                           'How many children would you like to add?',
//                           textAlign: TextAlign.center,
//                           style: GoogleFonts.poppins(
//                             fontSize: size.customWidth(context) * 0.038,
//                             color: AppColors.textSecondaryColor,
//                           ),
//                         ),
//                       ),

//                       SizedBox(height: size.customHeight(context) * 0.03),

//                       // ── Child count selector ───────────────────────────
//                       _buildCountSelector(context, size, childCtrl),

//                       SizedBox(height: size.customHeight(context) * 0.03),

//                       // ── Child forms ────────────────────────────────────
//                       ...List.generate(
//                         childCtrl.childCount.value,
//                         (index) => _ChildFormCard(
//                           index: index,
//                           controller: childCtrl,
//                         ),
//                       ),

//                       SizedBox(height: size.customHeight(context) * 0.02),
//                     ],
//                   ),
//                 ),
//               ),

//               // ── Continue button ────────────────────────────────────────
//               Padding(
//                 padding: EdgeInsets.fromLTRB(
//                   size.customWidth(context) * 0.05,
//                   0,
//                   size.customWidth(context) * 0.05,
//                   size.customHeight(context) * 0.03,
//                 ),
//                 child: SizedBox(
//                   width: double.infinity,
//                   height: size.customHeight(context) * 0.065,
//                   child: ElevatedButton(
//                     onPressed: childCtrl.isLoading.value
//                         ? null
//                         : () => _handleContinue(context, childCtrl),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.primaryColor,
//                       disabledBackgroundColor:
//                           AppColors.primaryColor.withOpacity(0.5),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(
//                             size.customHeight(context) * 0.2),
//                       ),
//                       elevation: 3,
//                     ),
//                     child: childCtrl.isLoading.value
//                         ? const SizedBox(
//                             width: 22,
//                             height: 22,
//                             child: CircularProgressIndicator(
//                                 color: Colors.white, strokeWidth: 2.5),
//                           )
//                         : Text(
//                             'Continue',
//                             style: GoogleFonts.poppins(
//                               fontSize: size.customWidth(context) * 0.045,
//                               fontWeight: FontWeight.w600,
//                               color: AppColors.whiteColor,
//                             ),
//                           ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         }),
//       ),
//     );
//   }

//   // ── Count selector row ─────────────────────────────────────────────────
//   Widget _buildCountSelector(
//       BuildContext context, CustomSize size, PreSignupChildController ctrl) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: List.generate(5, (i) {
//         final count = i + 1;
//         final isSelected = ctrl.childCount.value == count;
//         return GestureDetector(
//           onTap: () => ctrl.setChildCount(count),
//           child: AnimatedContainer(
//             duration: const Duration(milliseconds: 200),
//             margin: EdgeInsets.symmetric(
//                 horizontal: size.customWidth(context) * 0.02),
//             width: size.customWidth(context) * 0.13,
//             height: size.customWidth(context) * 0.13,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: isSelected
//                   ? AppColors.primaryColor
//                   : AppColors.primaryColor.withOpacity(0.08),
//               border: Border.all(
//                 color: isSelected
//                     ? AppColors.primaryColor
//                     : AppColors.primaryColor.withOpacity(0.25),
//                 width: isSelected ? 2.5 : 1.5,
//               ),
//               boxShadow: isSelected
//                   ? [
//                       BoxShadow(
//                         color: AppColors.primaryColor.withOpacity(0.35),
//                         blurRadius: 10,
//                         offset: const Offset(0, 4),
//                       )
//                     ]
//                   : [],
//             ),
//             child: Center(
//               child: Text(
//                 '$count',
//                 style: GoogleFonts.poppins(
//                   fontSize: size.customWidth(context) * 0.048,
//                   fontWeight: FontWeight.bold,
//                   color: isSelected
//                       ? AppColors.whiteColor
//                       : AppColors.primaryColor,
//                 ),
//               ),
//             ),
//           ),
//         );
//       }),
//     );
//   }

//   void _handleContinue(
//       BuildContext context, PreSignupChildController ctrl) {
//     if (!ctrl.validateAll()) return;
//     // Navigate to signup (email/password) — actual API calls happen there
//     Get.toNamed(AppRoutes.signup);
//   }
// }

// // ── Single child form card ─────────────────────────────────────────────────
// class _ChildFormCard extends StatefulWidget {
//   final int index;
//   final PreSignupChildController controller;

//   const _ChildFormCard({required this.index, required this.controller});

//   @override
//   State<_ChildFormCard> createState() => _ChildFormCardState();
// }

// class _ChildFormCardState extends State<_ChildFormCard> {
//   late TextEditingController _nameCtrl;
//   late TextEditingController _dateCtrl;
//   DateTime? _selectedDate;

//   @override
//   void initState() {
//     super.initState();
//     final data = widget.controller.getChildData(widget.index);
//     _nameCtrl = TextEditingController(text: data['name'] ?? '');
//     _dateCtrl = TextEditingController(text: data['dobDisplay'] ?? '');
//     final dobRaw = data['dob'] as String?;
//     if (dobRaw != null && dobRaw.isNotEmpty) {
//       try {
//         _selectedDate = DateTime.parse(dobRaw);
//       } catch (_) {}
//     }
//   }

//   @override
//   void dispose() {
//     _nameCtrl.dispose();
//     _dateCtrl.dispose();
//     super.dispose();
//   }

//   Future<void> _pickDate() async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate:
//           _selectedDate ?? DateTime.now().subtract(const Duration(days: 365 * 3)),
//       firstDate: DateTime(2000),
//       lastDate: DateTime.now(),
//       builder: (context, child) => Theme(
//         data: Theme.of(context).copyWith(
//           colorScheme: const ColorScheme.light(
//             primary: AppColors.primaryColor,
//             onPrimary: AppColors.whiteColor,
//             onSurface: AppColors.textPrimaryColor,
//           ),
//         ),
//         child: child!,
//       ),
//     );
//     if (picked != null) {
//       setState(() {
//         _selectedDate = picked;
//         const months = [
//           'Jan','Feb','Mar','Apr','May','Jun',
//           'Jul','Aug','Sep','Oct','Nov','Dec'
//         ];
//         _dateCtrl.text =
//             '${months[picked.month - 1]} ${picked.day}, ${picked.year}';
//       });
//       final formatted =
//           '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
//       widget.controller.updateChild(
//         widget.index,
//         dob: formatted,
//         dobDisplay: _dateCtrl.text,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();
//     final data = widget.controller.getChildData(widget.index);
//     final gender = (data['gender'] as String?) ?? 'male';

//     return Container(
//       margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.02),
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(
//           color: AppColors.primaryColor.withOpacity(0.15),
//           width: 1.5,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: AppColors.primaryColor.withOpacity(0.07),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // ── Card header ──────────────────────────────────────────
//           Container(
//             padding: EdgeInsets.symmetric(
//               horizontal: size.customWidth(context) * 0.045,
//               vertical: size.customHeight(context) * 0.014,
//             ),
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   AppColors.primaryColor.withOpacity(0.12),
//                   AppColors.secondaryColor.withOpacity(0.06),
//                 ],
//               ),
//               borderRadius: const BorderRadius.vertical(
//                   top: Radius.circular(18)),
//             ),
//             child: Row(
//               children: [
//                 Container(
//                   width: 34,
//                   height: 34,
//                   decoration: BoxDecoration(
//                     color: AppColors.primaryColor,
//                     shape: BoxShape.circle,
//                   ),
//                   child: Center(
//                     child: Text(
//                       '${widget.index + 1}',
//                       style: GoogleFonts.poppins(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: size.customWidth(context) * 0.04,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: size.customWidth(context) * 0.025),
//                 Text(
//                   'Child ${widget.index + 1}',
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.042,
//                     fontWeight: FontWeight.w700,
//                     color: AppColors.textPrimaryColor,
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           Padding(
//             padding: EdgeInsets.all(size.customWidth(context) * 0.045),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // ── Name field ──────────────────────────────────────
//                 _label(context, size, 'Full Name'),
//                 SizedBox(height: size.customHeight(context) * 0.008),
//                 _buildTextField(
//                   context: context,
//                   size: size,
//                   ctrl: _nameCtrl,
//                   hint: 'Enter child\'s full name',
//                   icon: Icons.person_outline_rounded,
//                   onChanged: (v) =>
//                       widget.controller.updateChild(widget.index, name: v),
//                 ),

//                 SizedBox(height: size.customHeight(context) * 0.02),

//                 // ── Date of birth ───────────────────────────────────
//                 _label(context, size, 'Date of Birth'),
//                 SizedBox(height: size.customHeight(context) * 0.008),
//                 GestureDetector(
//                   onTap: _pickDate,
//                   child: AbsorbPointer(
//                     child: _buildTextField(
//                       context: context,
//                       size: size,
//                       ctrl: _dateCtrl,
//                       hint: 'Select date of birth',
//                       icon: Icons.cake_outlined,
//                       suffixIcon: Icons.calendar_today_rounded,
//                     ),
//                   ),
//                 ),

//                 SizedBox(height: size.customHeight(context) * 0.02),

//                 // ── Gender selector ─────────────────────────────────
//                 _label(context, size, 'Gender'),
//                 SizedBox(height: size.customHeight(context) * 0.012),
//                 Obx(() {
//                   final currentGender =
//                       (widget.controller.getChildData(widget.index)['gender']
//                               as String?) ??
//                           'male';
//                   return Row(
//                     children: [
//                       Expanded(
//                         child: _genderOption(
//                           context: context,
//                           size: size,
//                           label: 'Male',
//                           value: 'male',
//                           icon: Icons.boy_rounded,
//                           color: const Color(0xFF2196F3),
//                           isSelected: currentGender == 'male',
//                           onTap: () => widget.controller
//                               .updateChild(widget.index, gender: 'male'),
//                         ),
//                       ),
//                       SizedBox(width: size.customWidth(context) * 0.04),
//                       Expanded(
//                         child: _genderOption(
//                           context: context,
//                           size: size,
//                           label: 'Female',
//                           value: 'female',
//                           icon: Icons.girl_rounded,
//                           color: const Color(0xFFE91E8C),
//                           isSelected: currentGender == 'female',
//                           onTap: () => widget.controller
//                               .updateChild(widget.index, gender: 'female'),
//                         ),
//                       ),
//                     ],
//                   );
//                 }),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _label(BuildContext context, CustomSize size, String text) {
//     return Text(
//       text,
//       style: GoogleFonts.poppins(
//         fontSize: size.customWidth(context) * 0.038,
//         fontWeight: FontWeight.w600,
//         color: AppColors.textPrimaryColor,
//       ),
//     );
//   }

//   Widget _buildTextField({
//     required BuildContext context,
//     required CustomSize size,
//     required TextEditingController ctrl,
//     required String hint,
//     required IconData icon,
//     IconData? suffixIcon,
//     void Function(String)? onChanged,
//   }) {
//     return TextFormField(
//       controller: ctrl,
//       onChanged: onChanged,
//       cursorColor: AppColors.primaryColor,
//       style: GoogleFonts.poppins(
//         fontSize: size.customWidth(context) * 0.038,
//         color: AppColors.textPrimaryColor,
//       ),
//       decoration: InputDecoration(
//         prefixIcon: Icon(icon, color: AppColors.primaryColor, size: 20),
//         suffixIcon: suffixIcon != null
//             ? Icon(suffixIcon, color: AppColors.primaryColor, size: 18)
//             : null,
//         hintText: hint,
//         hintStyle: GoogleFonts.poppins(
//           fontSize: size.customWidth(context) * 0.038,
//           color: AppColors.greyColor,
//         ),
//         filled: true,
//         fillColor: AppColors.lightGreyColor,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide.none,
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(
//               color: AppColors.greyColor.withOpacity(0.2), width: 1),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide:
//               const BorderSide(color: AppColors.primaryColor, width: 1.8),
//         ),
//         contentPadding: EdgeInsets.symmetric(
//           vertical: size.customHeight(context) * 0.018,
//           horizontal: size.customWidth(context) * 0.04,
//         ),
//       ),
//     );
//   }

//   Widget _genderOption({
//     required BuildContext context,
//     required CustomSize size,
//     required String label,
//     required String value,
//     required IconData icon,
//     required Color color,
//     required bool isSelected,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         padding: EdgeInsets.symmetric(
//             vertical: size.customHeight(context) * 0.018),
//         decoration: BoxDecoration(
//           color: isSelected ? color.withOpacity(0.1) : AppColors.whiteColor,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//             color: isSelected ? color : AppColors.greyColor.withOpacity(0.3),
//             width: isSelected ? 2 : 1,
//           ),
//           boxShadow: isSelected
//               ? [
//                   BoxShadow(
//                     color: color.withOpacity(0.18),
//                     blurRadius: 8,
//                     offset: const Offset(0, 3),
//                   )
//                 ]
//               : [],
//         ),
//         child: Column(
//           children: [
//             Icon(icon,
//                 size: size.customWidth(context) * 0.1,
//                 color: isSelected ? color : AppColors.greyColor),
//             SizedBox(height: size.customHeight(context) * 0.006),
//             Text(
//               label,
//               style: GoogleFonts.poppins(
//                 fontSize: size.customWidth(context) * 0.036,
//                 fontWeight:
//                     isSelected ? FontWeight.w700 : FontWeight.w400,
//                 color: isSelected ? color : AppColors.textSecondaryColor,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// lib/view/auth/add_children_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import 'package:speechspectrum/controllers/registration_controller.dart';
import 'package:speechspectrum/controllers/pre_signup_child_controller.dart';
import 'package:speechspectrum/routes/app_routes.dart';

class AddChildrenScreen extends StatefulWidget {
  const AddChildrenScreen({super.key});

  @override
  State<AddChildrenScreen> createState() => _AddChildrenScreenState();
}

class _AddChildrenScreenState extends State<AddChildrenScreen> {
  late final PreSignupChildController _childCtrl;
  late final RegistrationController _regCtrl;
  final TextEditingController _countCtrl = TextEditingController(text: '1');

  @override
  void initState() {
    super.initState();
    _regCtrl = Get.find<RegistrationController>();
    _childCtrl = Get.isRegistered<PreSignupChildController>()
        ? Get.find<PreSignupChildController>()
        : Get.put(PreSignupChildController());
    _countCtrl.text = '${_childCtrl.childCount.value}';
  }

  @override
  void dispose() {
    _countCtrl.dispose();
    super.dispose();
  }

  void _onCountChanged(String value) {
    final n = int.tryParse(value);
    if (n != null && n >= 1) {
      _childCtrl.setChildCount(n);
    }
  }

  void _handleContinue() {
    final n = int.tryParse(_countCtrl.text.trim());
    if (n == null || n < 1) {
      Get.snackbar(
        'Invalid Number',
        'Please enter a valid number of children (at least 1)',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.errorColor,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
      return;
    }
    if (!_childCtrl.validateAll()) return;
    Get.toNamed(AppRoutes.signup);
  }

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.blackColor),
          onPressed: () => Get.back(),
        ),
        title: Column(
          children: [
            SizedBox(height: size.customHeight(context) * 0.025),
            Obx(() {
              final isExpert = _regCtrl.role.value == 'expert';
              final totalSteps = isExpert ? 6 : 5;
              final progress = 4 / totalSteps;
              return LinearProgressIndicator(
                value: progress,
                backgroundColor: AppColors.greyColor.withOpacity(0.3),
                valueColor:
                    const AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                minHeight: size.customHeight(context) * 0.008,
              );
            }),
            SizedBox(height: size.customHeight(context) * 0.008),
            Text(
              'STEP 4/5',
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
        child: Obx(() {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.customWidth(context) * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: size.customHeight(context) * 0.03),

                      // ── Title ──────────────────────────────────────────
                      Center(
                        child: Text(
                          'Add Your Children',
                          style: GoogleFonts.poppins(
                            fontSize: size.customWidth(context) * 0.06,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimaryColor,
                          ),
                        ),
                      ),
                      SizedBox(height: size.customHeight(context) * 0.008),
                      Center(
                        child: Text(
                          'Enter how many children you would like to add',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: size.customWidth(context) * 0.038,
                            color: AppColors.textSecondaryColor,
                          ),
                        ),
                      ),

                      SizedBox(height: size.customHeight(context) * 0.03),

                      // ── Count input ────────────────────────────────────
                      _buildCountInput(context, size),

                      SizedBox(height: size.customHeight(context) * 0.03),

                      // ── Child forms ────────────────────────────────────
                      ...List.generate(
                        _childCtrl.childCount.value,
                        (index) => _ChildFormCard(
                          index: index,
                          controller: _childCtrl,
                        ),
                      ),

                      SizedBox(height: size.customHeight(context) * 0.02),
                    ],
                  ),
                ),
              ),

              // ── Continue button ────────────────────────────────────────
              Padding(
                padding: EdgeInsets.fromLTRB(
                  size.customWidth(context) * 0.05,
                  0,
                  size.customWidth(context) * 0.05,
                  size.customHeight(context) * 0.03,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: size.customHeight(context) * 0.065,
                  child: ElevatedButton(
                    onPressed:
                        _childCtrl.isLoading.value ? null : _handleContinue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      disabledBackgroundColor:
                          AppColors.primaryColor.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            size.customHeight(context) * 0.2),
                      ),
                      elevation: 3,
                    ),
                    child: _childCtrl.isLoading.value
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2.5),
                          )
                        : Text(
                            'Continue',
                            style: GoogleFonts.poppins(
                              fontSize: size.customWidth(context) * 0.045,
                              fontWeight: FontWeight.w600,
                              color: AppColors.whiteColor,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  // ── Number input widget ────────────────────────────────────────────────────
  Widget _buildCountInput(BuildContext context, CustomSize size) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.customWidth(context) * 0.045,
        vertical: size.customHeight(context) * 0.022,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primaryColor.withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.child_care_rounded,
                color: AppColors.primaryColor, size: 22),
          ),
          SizedBox(width: size.customWidth(context) * 0.035),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Number of Children',
                  style: GoogleFonts.poppins(
                    fontSize: size.customWidth(context) * 0.034,
                    color: AppColors.textSecondaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: size.customHeight(context) * 0.005),
                TextField(
                  controller: _countCtrl,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  cursorColor: AppColors.primaryColor,
                  style: GoogleFonts.poppins(
                    fontSize: size.customWidth(context) * 0.048,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimaryColor,
                  ),
                  decoration: InputDecoration(
                    hintText: 'e.g. 3',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: size.customWidth(context) * 0.042,
                      color: AppColors.greyColor,
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  onChanged: _onCountChanged,
                ),
              ],
            ),
          ),
          // ── +/- stepper ────────────────────────────────────────────
          Column(
            children: [
              _stepBtn(
                icon: Icons.add,
                onTap: () {
                  final next = _childCtrl.childCount.value + 1;
                  _countCtrl.text = '$next';
                  _childCtrl.setChildCount(next);
                },
              ),
              SizedBox(height: size.customHeight(context) * 0.008),
              _stepBtn(
                icon: Icons.remove,
                onTap: () {
                  final current = _childCtrl.childCount.value;
                  if (current > 1) {
                    final next = current - 1;
                    _countCtrl.text = '$next';
                    _childCtrl.setChildCount(next);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _stepBtn({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
}

// ── Single child form card ─────────────────────────────────────────────────
class _ChildFormCard extends StatefulWidget {
  final int index;
  final PreSignupChildController controller;

  const _ChildFormCard({required this.index, required this.controller});

  @override
  State<_ChildFormCard> createState() => _ChildFormCardState();
}

class _ChildFormCardState extends State<_ChildFormCard> {
  late TextEditingController _nameCtrl;
  late TextEditingController _dateCtrl;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    final data = widget.controller.getChildData(widget.index);
    _nameCtrl = TextEditingController(text: data['name'] ?? '');
    _dateCtrl = TextEditingController(text: data['dobDisplay'] ?? '');
    final dobRaw = data['dob'] as String?;
    if (dobRaw != null && dobRaw.isNotEmpty) {
      try {
        _selectedDate = DateTime.parse(dobRaw);
      } catch (_) {}
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _dateCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ??
          DateTime.now().subtract(const Duration(days: 365 * 3)),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: AppColors.primaryColor,
            onPrimary: AppColors.whiteColor,
            onSurface: AppColors.textPrimaryColor,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        const months = [
          'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
          'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
        ];
        _dateCtrl.text =
            '${months[picked.month - 1]} ${picked.day}, ${picked.year}';
      });
      final formatted =
          '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      widget.controller.updateChild(
        widget.index,
        dob: formatted,
        dobDisplay: _dateCtrl.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();

    return Container(
      margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.02),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primaryColor.withOpacity(0.15),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.07),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Card header ──────────────────────────────────────────────
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: size.customWidth(context) * 0.045,
              vertical: size.customHeight(context) * 0.014,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryColor.withOpacity(0.12),
                  AppColors.secondaryColor.withOpacity(0.06),
                ],
              ),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(18)),
            ),
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${widget.index + 1}',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: size.customWidth(context) * 0.04,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: size.customWidth(context) * 0.025),
                Text(
                  'Child ${widget.index + 1}',
                  style: GoogleFonts.poppins(
                    fontSize: size.customWidth(context) * 0.042,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimaryColor,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.all(size.customWidth(context) * 0.045),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Name ──────────────────────────────────────────────
                _label(context, size, 'Full Name'),
                SizedBox(height: size.customHeight(context) * 0.008),
                _buildTextField(
                  context: context,
                  size: size,
                  ctrl: _nameCtrl,
                  hint: 'Enter child\'s full name',
                  icon: Icons.person_outline_rounded,
                  onChanged: (v) =>
                      widget.controller.updateChild(widget.index, name: v),
                ),

                SizedBox(height: size.customHeight(context) * 0.02),

                // ── DOB ────────────────────────────────────────────────
                _label(context, size, 'Date of Birth'),
                SizedBox(height: size.customHeight(context) * 0.008),
                GestureDetector(
                  onTap: _pickDate,
                  child: AbsorbPointer(
                    child: _buildTextField(
                      context: context,
                      size: size,
                      ctrl: _dateCtrl,
                      hint: 'Select date of birth',
                      icon: Icons.cake_outlined,
                      suffixIcon: Icons.calendar_today_rounded,
                    ),
                  ),
                ),

                SizedBox(height: size.customHeight(context) * 0.02),

                // ── Gender ─────────────────────────────────────────────
                _label(context, size, 'Gender'),
                SizedBox(height: size.customHeight(context) * 0.012),
                Obx(() {
                  final currentGender =
                      (widget.controller.getChildData(widget.index)['gender']
                              as String?) ??
                          'male';
                  return Row(
                    children: [
                      Expanded(
                        child: _genderOption(
                          context: context,
                          size: size,
                          label: 'Male',
                          icon: Icons.boy_rounded,
                          color: const Color(0xFF2196F3),
                          isSelected: currentGender == 'male',
                          onTap: () => widget.controller
                              .updateChild(widget.index, gender: 'male'),
                        ),
                      ),
                      SizedBox(width: size.customWidth(context) * 0.04),
                      Expanded(
                        child: _genderOption(
                          context: context,
                          size: size,
                          label: 'Female',
                          icon: Icons.girl_rounded,
                          color: const Color(0xFFE91E8C),
                          isSelected: currentGender == 'female',
                          onTap: () => widget.controller
                              .updateChild(widget.index, gender: 'female'),
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(BuildContext context, CustomSize size, String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: size.customWidth(context) * 0.038,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimaryColor,
      ),
    );
  }

  Widget _buildTextField({
    required BuildContext context,
    required CustomSize size,
    required TextEditingController ctrl,
    required String hint,
    required IconData icon,
    IconData? suffixIcon,
    void Function(String)? onChanged,
  }) {
    return TextFormField(
      controller: ctrl,
      onChanged: onChanged,
      cursorColor: AppColors.primaryColor,
      style: GoogleFonts.poppins(
        fontSize: size.customWidth(context) * 0.038,
        color: AppColors.textPrimaryColor,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: AppColors.primaryColor, size: 20),
        suffixIcon: suffixIcon != null
            ? Icon(suffixIcon, color: AppColors.primaryColor, size: 18)
            : null,
        hintText: hint,
        hintStyle: GoogleFonts.poppins(
          fontSize: size.customWidth(context) * 0.038,
          color: AppColors.greyColor,
        ),
        filled: true,
        fillColor: AppColors.lightGreyColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              BorderSide(color: AppColors.greyColor.withOpacity(0.2), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              const BorderSide(color: AppColors.primaryColor, width: 1.8),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: size.customHeight(context) * 0.018,
          horizontal: size.customWidth(context) * 0.04,
        ),
      ),
    );
  }

  Widget _genderOption({
    required BuildContext context,
    required CustomSize size,
    required String label,
    required IconData icon,
    required Color color,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding:
            EdgeInsets.symmetric(vertical: size.customHeight(context) * 0.018),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : AppColors.whiteColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : AppColors.greyColor.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.18),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  )
                ]
              : [],
        ),
        child: Column(
          children: [
            Icon(icon,
                size: size.customWidth(context) * 0.1,
                color: isSelected ? color : AppColors.greyColor),
            SizedBox(height: size.customHeight(context) * 0.006),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: size.customWidth(context) * 0.036,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                color: isSelected ? color : AppColors.textSecondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}