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

// // lib/view/auth/add_children_screen.dart
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/registration_controller.dart';
// import 'package:speechspectrum/controllers/pre_signup_child_controller.dart';
// import 'package:speechspectrum/routes/app_routes.dart';

// class AddChildrenScreen extends StatefulWidget {
//   const AddChildrenScreen({super.key});

//   @override
//   State<AddChildrenScreen> createState() => _AddChildrenScreenState();
// }

// class _AddChildrenScreenState extends State<AddChildrenScreen> {
//   late final PreSignupChildController _childCtrl;
//   late final RegistrationController _regCtrl;
//   final TextEditingController _countCtrl = TextEditingController(text: '1');

//   @override
//   void initState() {
//     super.initState();
//     _regCtrl = Get.find<RegistrationController>();
//     _childCtrl = Get.isRegistered<PreSignupChildController>()
//         ? Get.find<PreSignupChildController>()
//         : Get.put(PreSignupChildController());
//     _countCtrl.text = '${_childCtrl.childCount.value}';
//   }

//   @override
//   void dispose() {
//     _countCtrl.dispose();
//     super.dispose();
//   }

//   void _onCountChanged(String value) {
//     final n = int.tryParse(value);
//     if (n != null && n >= 1) {
//       _childCtrl.setChildCount(n);
//     }
//   }

//   void _handleContinue() {
//     final n = int.tryParse(_countCtrl.text.trim());
//     if (n == null || n < 1) {
//       Get.snackbar(
//         'Invalid Number',
//         'Please enter a valid number of children (at least 1)',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: AppColors.errorColor,
//         colorText: Colors.white,
//         margin: const EdgeInsets.all(16),
//         borderRadius: 12,
//       );
//       return;
//     }
//     if (!_childCtrl.validateAll()) return;
//     Get.toNamed(AppRoutes.signup);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();

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
//               final isExpert = _regCtrl.role.value == 'expert';
//               final totalSteps = isExpert ? 6 : 5;
//               final progress = 4 / totalSteps;
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
//                           'Enter how many children you would like to add',
//                           textAlign: TextAlign.center,
//                           style: GoogleFonts.poppins(
//                             fontSize: size.customWidth(context) * 0.038,
//                             color: AppColors.textSecondaryColor,
//                           ),
//                         ),
//                       ),

//                       SizedBox(height: size.customHeight(context) * 0.03),

//                       // ── Count input ────────────────────────────────────
//                       _buildCountInput(context, size),

//                       SizedBox(height: size.customHeight(context) * 0.03),

//                       // ── Child forms ────────────────────────────────────
//                       ...List.generate(
//                         _childCtrl.childCount.value,
//                         (index) => _ChildFormCard(
//                           index: index,
//                           controller: _childCtrl,
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
//                     onPressed:
//                         _childCtrl.isLoading.value ? null : _handleContinue,
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
//                     child: _childCtrl.isLoading.value
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

//   // ── Number input widget ────────────────────────────────────────────────────
//   Widget _buildCountInput(BuildContext context, CustomSize size) {
//     return Container(
//       padding: EdgeInsets.symmetric(
//         horizontal: size.customWidth(context) * 0.045,
//         vertical: size.customHeight(context) * 0.022,
//       ),
//       decoration: BoxDecoration(
//         color: AppColors.primaryColor.withOpacity(0.05),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(
//           color: AppColors.primaryColor.withOpacity(0.2),
//           width: 1.5,
//         ),
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: AppColors.primaryColor.withOpacity(0.12),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: const Icon(Icons.child_care_rounded,
//                 color: AppColors.primaryColor, size: 22),
//           ),
//           SizedBox(width: size.customWidth(context) * 0.035),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Number of Children',
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.034,
//                     color: AppColors.textSecondaryColor,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 SizedBox(height: size.customHeight(context) * 0.005),
//                 TextField(
//                   controller: _countCtrl,
//                   keyboardType: TextInputType.number,
//                   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                   cursorColor: AppColors.primaryColor,
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.048,
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.textPrimaryColor,
//                   ),
//                   decoration: InputDecoration(
//                     hintText: 'e.g. 3',
//                     hintStyle: GoogleFonts.poppins(
//                       fontSize: size.customWidth(context) * 0.042,
//                       color: AppColors.greyColor,
//                     ),
//                     isDense: true,
//                     contentPadding: EdgeInsets.zero,
//                     border: InputBorder.none,
//                     enabledBorder: InputBorder.none,
//                     focusedBorder: InputBorder.none,
//                   ),
//                   onChanged: _onCountChanged,
//                 ),
//               ],
//             ),
//           ),
//           // ── +/- stepper ────────────────────────────────────────────
//           Column(
//             children: [
//               _stepBtn(
//                 icon: Icons.add,
//                 onTap: () {
//                   final next = _childCtrl.childCount.value + 1;
//                   _countCtrl.text = '$next';
//                   _childCtrl.setChildCount(next);
//                 },
//               ),
//               SizedBox(height: size.customHeight(context) * 0.008),
//               _stepBtn(
//                 icon: Icons.remove,
//                 onTap: () {
//                   final current = _childCtrl.childCount.value;
//                   if (current > 1) {
//                     final next = current - 1;
//                     _countCtrl.text = '$next';
//                     _childCtrl.setChildCount(next);
//                   }
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _stepBtn({required IconData icon, required VoidCallback onTap}) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 32,
//         height: 32,
//         decoration: BoxDecoration(
//           color: AppColors.primaryColor,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Icon(icon, color: Colors.white, size: 18),
//       ),
//     );
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
//       initialDate: _selectedDate ??
//           DateTime.now().subtract(const Duration(days: 365 * 3)),
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
//           'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
//           'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
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
//           // ── Card header ──────────────────────────────────────────────
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
//               borderRadius:
//                   const BorderRadius.vertical(top: Radius.circular(18)),
//             ),
//             child: Row(
//               children: [
//                 Container(
//                   width: 34,
//                   height: 34,
//                   decoration: const BoxDecoration(
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
//                 // ── Name ──────────────────────────────────────────────
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

//                 // ── DOB ────────────────────────────────────────────────
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

//                 // ── Gender ─────────────────────────────────────────────
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
//           borderSide:
//               BorderSide(color: AppColors.greyColor.withOpacity(0.2), width: 1),
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
//     required IconData icon,
//     required Color color,
//     required bool isSelected,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         padding:
//             EdgeInsets.symmetric(vertical: size.customHeight(context) * 0.018),
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
//                 fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
//                 color: isSelected ? color : AppColors.textSecondaryColor,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// // lib/view/auth/add_children_screen.dart
// //
// // UPDATED — each child card now has:
// //   • Basic info (name, dob, gender)  ← unchanged
// //   • Health info section (blood group, weight, height, allergies, etc.)
// //   • Medical documents section (multiple PDFs, one API call each)
// //
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/registration_controller.dart';
// import 'package:speechspectrum/controllers/pre_signup_child_controller.dart';
// import 'package:speechspectrum/routes/app_routes.dart';

// const List<String> kRegDocumentTypes = [
//   'lab_result',
//   'prescription',
//   'hearing_test',
//   'vision_test',
//   'previous_report',
//   'referral_letter',
//   'school_report',
//   'other',
// ];

// const List<String> kRegBloodGroups = [
//   'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-',
// ];

// class AddChildrenScreen extends StatefulWidget {
//   const AddChildrenScreen({super.key});

//   @override
//   State<AddChildrenScreen> createState() => _AddChildrenScreenState();
// }

// class _AddChildrenScreenState extends State<AddChildrenScreen> {
//   late final PreSignupChildController _childCtrl;
//   late final RegistrationController _regCtrl;
//   final TextEditingController _countCtrl = TextEditingController(text: '1');

//   @override
//   void initState() {
//     super.initState();
//     _regCtrl = Get.find<RegistrationController>();
//     _childCtrl = Get.isRegistered<PreSignupChildController>()
//         ? Get.find<PreSignupChildController>()
//         : Get.put(PreSignupChildController());
//     _countCtrl.text = '${_childCtrl.childCount.value}';
//   }

//   @override
//   void dispose() {
//     _countCtrl.dispose();
//     super.dispose();
//   }

//   void _onCountChanged(String value) {
//     final n = int.tryParse(value);
//     if (n != null && n >= 1) _childCtrl.setChildCount(n);
//   }

//   void _handleContinue() {
//     final n = int.tryParse(_countCtrl.text.trim());
//     if (n == null || n < 1) {
//       Get.snackbar(
//         'Invalid Number',
//         'Please enter a valid number of children (at least 1)',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: AppColors.errorColor,
//         colorText: Colors.white,
//         margin: const EdgeInsets.all(16),
//         borderRadius: 12,
//       );
//       return;
//     }
//     if (!_childCtrl.validateAll()) return;
//     Get.toNamed(AppRoutes.signup);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();

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
//               final isExpert = _regCtrl.role.value == 'expert';
//               final totalSteps = isExpert ? 6 : 5;
//               return LinearProgressIndicator(
//                 value: 4 / totalSteps,
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

//                       // Title
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
//                           'Enter basic info, optional health details & medical documents',
//                           textAlign: TextAlign.center,
//                           style: GoogleFonts.poppins(
//                             fontSize: size.customWidth(context) * 0.035,
//                             color: AppColors.textSecondaryColor,
//                           ),
//                         ),
//                       ),

//                       SizedBox(height: size.customHeight(context) * 0.03),

//                       _buildCountInput(context, size),

//                       SizedBox(height: size.customHeight(context) * 0.03),

//                       ...List.generate(
//                         _childCtrl.childCount.value,
//                         (i) => _ChildFullFormCard(
//                           index: i,
//                           controller: _childCtrl,
//                         ),
//                       ),

//                       SizedBox(height: size.customHeight(context) * 0.02),
//                     ],
//                   ),
//                 ),
//               ),

//               // Continue button
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
//                     onPressed:
//                         _childCtrl.isLoading.value ? null : _handleContinue,
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
//                     child: _childCtrl.isLoading.value
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

//   Widget _buildCountInput(BuildContext context, CustomSize size) {
//     return Container(
//       padding: EdgeInsets.symmetric(
//         horizontal: size.customWidth(context) * 0.045,
//         vertical: size.customHeight(context) * 0.022,
//       ),
//       decoration: BoxDecoration(
//         color: AppColors.primaryColor.withOpacity(0.05),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(
//           color: AppColors.primaryColor.withOpacity(0.2),
//           width: 1.5,
//         ),
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: AppColors.primaryColor.withOpacity(0.12),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: const Icon(Icons.child_care_rounded,
//                 color: AppColors.primaryColor, size: 22),
//           ),
//           SizedBox(width: size.customWidth(context) * 0.035),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Number of Children',
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.034,
//                     color: AppColors.textSecondaryColor,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 SizedBox(height: size.customHeight(context) * 0.005),
//                 TextField(
//                   controller: _countCtrl,
//                   keyboardType: TextInputType.number,
//                   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                   cursorColor: AppColors.primaryColor,
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.048,
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.textPrimaryColor,
//                   ),
//                   decoration: InputDecoration(
//                     hintText: 'e.g. 3',
//                     hintStyle: GoogleFonts.poppins(
//                       fontSize: size.customWidth(context) * 0.042,
//                       color: AppColors.greyColor,
//                     ),
//                     isDense: true,
//                     contentPadding: EdgeInsets.zero,
//                     border: InputBorder.none,
//                   ),
//                   onChanged: _onCountChanged,
//                 ),
//               ],
//             ),
//           ),
//           Column(
//             children: [
//               _stepBtn(
//                 icon: Icons.add,
//                 onTap: () {
//                   final next = _childCtrl.childCount.value + 1;
//                   _countCtrl.text = '$next';
//                   _childCtrl.setChildCount(next);
//                 },
//               ),
//               SizedBox(height: size.customHeight(context) * 0.008),
//               _stepBtn(
//                 icon: Icons.remove,
//                 onTap: () {
//                   final current = _childCtrl.childCount.value;
//                   if (current > 1) {
//                     final next = current - 1;
//                     _countCtrl.text = '$next';
//                     _childCtrl.setChildCount(next);
//                   }
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _stepBtn({required IconData icon, required VoidCallback onTap}) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 32,
//         height: 32,
//         decoration: BoxDecoration(
//           color: AppColors.primaryColor,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Icon(icon, color: Colors.white, size: 18),
//       ),
//     );
//   }
// }

// // ─────────────────────────────────────────────────────────────────────────────
// // Full child form card: basic info + health info + documents
// // ─────────────────────────────────────────────────────────────────────────────
// class _ChildFullFormCard extends StatefulWidget {
//   final int index;
//   final PreSignupChildController controller;

//   const _ChildFullFormCard({required this.index, required this.controller});

//   @override
//   State<_ChildFullFormCard> createState() => _ChildFullFormCardState();
// }

// class _ChildFullFormCardState extends State<_ChildFullFormCard> {
//   // basic
//   late TextEditingController _nameCtrl;
//   late TextEditingController _dateCtrl;
//   DateTime? _selectedDate;

//   // health
//   late TextEditingController _allergiesCtrl;
//   late TextEditingController _geneticCtrl;
//   late TextEditingController _chronicCtrl;
//   late TextEditingController _weightCtrl;
//   late TextEditingController _heightCtrl;
//   String? _selectedBloodGroup;
//   bool _familyHistoryAsd = false;
//   bool _familyHistorySpeech = false;
//   bool _familyHistoryHearing = false;

//   // section expansion
//   bool _healthExpanded = false;
//   bool _docsExpanded = false;

//   @override
//   void initState() {
//     super.initState();
//     final data = widget.controller.getChildData(widget.index);

//     _nameCtrl = TextEditingController(text: data['name'] ?? '');
//     _dateCtrl = TextEditingController(text: data['dobDisplay'] ?? '');
//     final dobRaw = data['dob'] as String?;
//     if (dobRaw != null && dobRaw.isNotEmpty) {
//       try { _selectedDate = DateTime.parse(dobRaw); } catch (_) {}
//     }

//     _allergiesCtrl = TextEditingController(text: data['knownAllergies'] ?? '');
//     _geneticCtrl = TextEditingController(text: data['geneticDisorders'] ?? '');
//     _chronicCtrl = TextEditingController(text: data['chronicConditions'] ?? '');
//     _weightCtrl = TextEditingController(text: data['weightKg'] ?? '');
//     _heightCtrl = TextEditingController(text: data['heightCm'] ?? '');
//     _selectedBloodGroup = data['bloodGroup'] as String?;
//     _familyHistoryAsd = data['familyHistoryAsd'] ?? false;
//     _familyHistorySpeech = data['familyHistorySpeech'] ?? false;
//     _familyHistoryHearing = data['familyHistoryHearing'] ?? false;
//   }

//   @override
//   void dispose() {
//     _nameCtrl.dispose();
//     _dateCtrl.dispose();
//     _allergiesCtrl.dispose();
//     _geneticCtrl.dispose();
//     _chronicCtrl.dispose();
//     _weightCtrl.dispose();
//     _heightCtrl.dispose();
//     super.dispose();
//   }

//   Future<void> _pickDate() async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: _selectedDate ??
//           DateTime.now().subtract(const Duration(days: 365 * 3)),
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
//       widget.controller.updateChild(widget.index,
//           dob: formatted, dobDisplay: _dateCtrl.text);
//     }
//   }

//   Future<void> _pickDocuments() async {
//     final result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf'],
//       allowMultiple: true,
//     );
//     if (result == null || result.files.isEmpty) return;
//     for (final file in result.files) {
//       widget.controller.addDocument(
//         widget.index,
//         path: file.path!,
//         type: 'other',
//         name: file.name,
//       );
//     }
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();

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
//           // ── Card header ─────────────────────────────────────────────
//           _buildCardHeader(context, size),

//           Padding(
//             padding: EdgeInsets.all(size.customWidth(context) * 0.045),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // ── Basic info ────────────────────────────────────────
//                 _buildBasicInfo(context, size),

//                 SizedBox(height: size.customHeight(context) * 0.02),

//                 // ── Health info (expandable) ───────────────────────────
//                 _buildExpandableSection(
//                   context: context,
//                   size: size,
//                   title: 'Health Information',
//                   subtitle: 'Optional · Blood group, weight, allergies…',
//                   icon: Icons.medical_services_outlined,
//                   color: const Color(0xFF00b894),
//                   expanded: _healthExpanded,
//                   onToggle: () =>
//                       setState(() => _healthExpanded = !_healthExpanded),
//                   child: _buildHealthSection(context, size),
//                 ),

//                 SizedBox(height: size.customHeight(context) * 0.015),

//                 // ── Documents (expandable) ────────────────────────────
//                 _buildExpandableSection(
//                   context: context,
//                   size: size,
//                   title: 'Medical Documents',
//                   subtitle: 'Optional · PDF files only',
//                   icon: Icons.folder_outlined,
//                   color: AppColors.accentColor,
//                   expanded: _docsExpanded,
//                   onToggle: () =>
//                       setState(() => _docsExpanded = !_docsExpanded),
//                   child: _buildDocumentsSection(context, size),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCardHeader(BuildContext context, CustomSize size) {
//     return Container(
//       padding: EdgeInsets.symmetric(
//         horizontal: size.customWidth(context) * 0.045,
//         vertical: size.customHeight(context) * 0.014,
//       ),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(colors: [
//           AppColors.primaryColor.withOpacity(0.12),
//           AppColors.secondaryColor.withOpacity(0.06),
//         ]),
//         borderRadius:
//             const BorderRadius.vertical(top: Radius.circular(18)),
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 34,
//             height: 34,
//             decoration: const BoxDecoration(
//               color: AppColors.primaryColor,
//               shape: BoxShape.circle,
//             ),
//             child: Center(
//               child: Text(
//                 '${widget.index + 1}',
//                 style: GoogleFonts.poppins(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: size.customWidth(context) * 0.04,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(width: size.customWidth(context) * 0.025),
//           Text(
//             'Child ${widget.index + 1}',
//             style: GoogleFonts.poppins(
//               fontSize: size.customWidth(context) * 0.042,
//               fontWeight: FontWeight.w700,
//               color: AppColors.textPrimaryColor,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildBasicInfo(BuildContext context, CustomSize size) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _label(context, size, 'Full Name *'),
//         SizedBox(height: size.customHeight(context) * 0.008),
//         _buildTextField(
//           context: context,
//           size: size,
//           ctrl: _nameCtrl,
//           hint: "Enter child's full name",
//           icon: Icons.person_outline_rounded,
//           onChanged: (v) =>
//               widget.controller.updateChild(widget.index, name: v),
//         ),

//         SizedBox(height: size.customHeight(context) * 0.02),

//         _label(context, size, 'Date of Birth *'),
//         SizedBox(height: size.customHeight(context) * 0.008),
//         GestureDetector(
//           onTap: _pickDate,
//           child: AbsorbPointer(
//             child: _buildTextField(
//               context: context,
//               size: size,
//               ctrl: _dateCtrl,
//               hint: 'Select date of birth',
//               icon: Icons.cake_outlined,
//               suffixIcon: Icons.calendar_today_rounded,
//             ),
//           ),
//         ),

//         SizedBox(height: size.customHeight(context) * 0.02),

//         _label(context, size, 'Gender'),
//         SizedBox(height: size.customHeight(context) * 0.012),
//         Obx(() {
//           final currentGender =
//               (widget.controller.getChildData(widget.index)['gender']
//                       as String?) ??
//                   'male';
//           return Row(
//             children: [
//               Expanded(
//                 child: _genderOption(
//                   context: context,
//                   size: size,
//                   label: 'Male',
//                   icon: Icons.boy_rounded,
//                   color: const Color(0xFF2196F3),
//                   isSelected: currentGender == 'male',
//                   onTap: () => widget.controller
//                       .updateChild(widget.index, gender: 'male'),
//                 ),
//               ),
//               SizedBox(width: size.customWidth(context) * 0.04),
//               Expanded(
//                 child: _genderOption(
//                   context: context,
//                   size: size,
//                   label: 'Female',
//                   icon: Icons.girl_rounded,
//                   color: const Color(0xFFE91E8C),
//                   isSelected: currentGender == 'female',
//                   onTap: () => widget.controller
//                       .updateChild(widget.index, gender: 'female'),
//                 ),
//               ),
//             ],
//           );
//         }),
//       ],
//     );
//   }

//   Widget _buildExpandableSection({
//     required BuildContext context,
//     required CustomSize size,
//     required String title,
//     required String subtitle,
//     required IconData icon,
//     required Color color,
//     required bool expanded,
//     required VoidCallback onToggle,
//     required Widget child,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.04),
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(color: color.withOpacity(0.2)),
//       ),
//       child: Column(
//         children: [
//           InkWell(
//             onTap: onToggle,
//             borderRadius: BorderRadius.circular(14),
//             child: Padding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: size.customWidth(context) * 0.04,
//                 vertical: size.customHeight(context) * 0.015,
//               ),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 36,
//                     height: 36,
//                     decoration: BoxDecoration(
//                       color: color.withOpacity(0.15),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Icon(icon, color: color, size: 20),
//                   ),
//                   SizedBox(width: size.customWidth(context) * 0.03),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           title,
//                           style: GoogleFonts.poppins(
//                             fontSize: size.customWidth(context) * 0.038,
//                             fontWeight: FontWeight.w600,
//                             color: AppColors.textPrimaryColor,
//                           ),
//                         ),
//                         Text(
//                           subtitle,
//                           style: GoogleFonts.poppins(
//                             fontSize: size.customWidth(context) * 0.03,
//                             color: AppColors.textSecondaryColor,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Icon(
//                     expanded
//                         ? Icons.keyboard_arrow_up_rounded
//                         : Icons.keyboard_arrow_down_rounded,
//                     color: color,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           if (expanded)
//             Padding(
//               padding: EdgeInsets.fromLTRB(
//                 size.customWidth(context) * 0.04,
//                 0,
//                 size.customWidth(context) * 0.04,
//                 size.customHeight(context) * 0.015,
//               ),
//               child: child,
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _buildHealthSection(BuildContext context, CustomSize size) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Divider(color: AppColors.greyColor.withOpacity(0.2)),
//         SizedBox(height: size.customHeight(context) * 0.01),

//         // Blood group dropdown
//         _label(context, size, 'Blood Group'),
//         SizedBox(height: size.customHeight(context) * 0.008),
//         DropdownButtonFormField<String>(
//           value: _selectedBloodGroup,
//           style: GoogleFonts.poppins(
//               fontSize: size.customWidth(context) * 0.037,
//               color: AppColors.textPrimaryColor),
//           dropdownColor: AppColors.whiteColor,
//           borderRadius: BorderRadius.circular(12),
//           decoration: _inputDecoration(context, size,
//               hint: 'Select blood group',
//               icon: Icons.bloodtype_outlined),
//           items: kRegBloodGroups
//               .map((g) => DropdownMenuItem(
//                     value: g,
//                     child: Text(g,
//                         style: GoogleFonts.poppins(
//                             fontSize: size.customWidth(context) * 0.037)),
//                   ))
//               .toList(),
//           onChanged: (v) {
//             setState(() => _selectedBloodGroup = v);
//             widget.controller.updateChild(widget.index, bloodGroup: v ?? '');
//           },
//         ),

//         SizedBox(height: size.customHeight(context) * 0.018),

//         // Weight + Height
//         Row(
//           children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _label(context, size, 'Weight (kg)'),
//                   SizedBox(height: size.customHeight(context) * 0.008),
//                   TextFormField(
//                     controller: _weightCtrl,
//                     keyboardType: const TextInputType.numberWithOptions(decimal: true),
//                     inputFormatters: [
//                       FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))
//                     ],
//                     cursorColor: AppColors.primaryColor,
//                     style: GoogleFonts.poppins(
//                         fontSize: size.customWidth(context) * 0.037,
//                         color: AppColors.textPrimaryColor),
//                     decoration: _inputDecoration(context, size,
//                         hint: 'e.g. 18.5',
//                         icon: Icons.monitor_weight_outlined),
//                     onChanged: (v) => widget.controller
//                         .updateChild(widget.index, weightKg: v),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(width: size.customWidth(context) * 0.03),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _label(context, size, 'Height (cm)'),
//                   SizedBox(height: size.customHeight(context) * 0.008),
//                   TextFormField(
//                     controller: _heightCtrl,
//                     keyboardType: const TextInputType.numberWithOptions(decimal: true),
//                     inputFormatters: [
//                       FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))
//                     ],
//                     cursorColor: AppColors.primaryColor,
//                     style: GoogleFonts.poppins(
//                         fontSize: size.customWidth(context) * 0.037,
//                         color: AppColors.textPrimaryColor),
//                     decoration: _inputDecoration(context, size,
//                         hint: 'e.g. 109.2',
//                         icon: Icons.height_outlined),
//                     onChanged: (v) => widget.controller
//                         .updateChild(widget.index, heightCm: v),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),

//         SizedBox(height: size.customHeight(context) * 0.018),

//         _label(context, size, 'Known Allergies'),
//         SizedBox(height: size.customHeight(context) * 0.008),
//         TextFormField(
//           controller: _allergiesCtrl,
//           cursorColor: AppColors.primaryColor,
//           style: GoogleFonts.poppins(
//               fontSize: size.customWidth(context) * 0.037,
//               color: AppColors.textPrimaryColor),
//           decoration: _inputDecoration(context, size,
//               hint: 'e.g. Peanuts, Dust',
//               icon: Icons.warning_amber_outlined),
//           onChanged: (v) =>
//               widget.controller.updateChild(widget.index, knownAllergies: v),
//         ),

//         SizedBox(height: size.customHeight(context) * 0.018),

//         _label(context, size, 'Genetic Disorders'),
//         SizedBox(height: size.customHeight(context) * 0.008),
//         TextFormField(
//           controller: _geneticCtrl,
//           cursorColor: AppColors.primaryColor,
//           style: GoogleFonts.poppins(
//               fontSize: size.customWidth(context) * 0.037,
//               color: AppColors.textPrimaryColor),
//           decoration: _inputDecoration(context, size,
//               hint: 'e.g. None',
//               icon: Icons.biotech_outlined),
//           onChanged: (v) =>
//               widget.controller.updateChild(widget.index, geneticDisorders: v),
//         ),

//         SizedBox(height: size.customHeight(context) * 0.018),

//         _label(context, size, 'Chronic Conditions'),
//         SizedBox(height: size.customHeight(context) * 0.008),
//         TextFormField(
//           controller: _chronicCtrl,
//           cursorColor: AppColors.primaryColor,
//           style: GoogleFonts.poppins(
//               fontSize: size.customWidth(context) * 0.037,
//               color: AppColors.textPrimaryColor),
//           decoration: _inputDecoration(context, size,
//               hint: 'e.g. Mild asthma',
//               icon: Icons.local_hospital_outlined),
//           onChanged: (v) =>
//               widget.controller.updateChild(widget.index, chronicConditions: v),
//         ),

//         SizedBox(height: size.customHeight(context) * 0.018),

//         _label(context, size, 'Family History'),
//         SizedBox(height: size.customHeight(context) * 0.01),
//         _buildToggleRow(
//           context: context,
//           size: size,
//           label: 'ASD History',
//           value: _familyHistoryAsd,
//           onChanged: (v) {
//             setState(() => _familyHistoryAsd = v);
//             widget.controller.updateChild(widget.index, familyHistoryAsd: v);
//           },
//         ),
//         _buildToggleRow(
//           context: context,
//           size: size,
//           label: 'Speech Disorders',
//           value: _familyHistorySpeech,
//           onChanged: (v) {
//             setState(() => _familyHistorySpeech = v);
//             widget.controller.updateChild(widget.index, familyHistorySpeech: v);
//           },
//         ),
//         _buildToggleRow(
//           context: context,
//           size: size,
//           label: 'Hearing Loss',
//           value: _familyHistoryHearing,
//           onChanged: (v) {
//             setState(() => _familyHistoryHearing = v);
//             widget.controller.updateChild(widget.index, familyHistoryHearing: v);
//           },
//         ),
//       ],
//     );
//   }

//   Widget _buildToggleRow({
//     required BuildContext context,
//     required CustomSize size,
//     required String label,
//     required bool value,
//     required ValueChanged<bool> onChanged,
//   }) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: size.customHeight(context) * 0.006),
//       child: Row(
//         children: [
//           Expanded(
//             child: Text(
//               label,
//               style: GoogleFonts.poppins(
//                 fontSize: size.customWidth(context) * 0.036,
//                 color: AppColors.textPrimaryColor,
//               ),
//             ),
//           ),
//           Switch(
//             value: value,
//             onChanged: onChanged,
//             activeColor: AppColors.primaryColor,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDocumentsSection(BuildContext context, CustomSize size) {
//     final docs = widget.controller.getDocuments(widget.index);

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Divider(color: AppColors.greyColor.withOpacity(0.2)),
//         SizedBox(height: size.customHeight(context) * 0.01),

//         // Upload button
//         SizedBox(
//           width: double.infinity,
//           child: OutlinedButton.icon(
//             onPressed: _pickDocuments,
//             icon: const Icon(Icons.upload_file,
//                 color: AppColors.primaryColor, size: 20),
//             label: Text(
//               'Add PDF Documents',
//               style: GoogleFonts.poppins(
//                 color: AppColors.primaryColor,
//                 fontSize: size.customWidth(context) * 0.037,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             style: OutlinedButton.styleFrom(
//               padding: EdgeInsets.symmetric(
//                   vertical: size.customHeight(context) * 0.015),
//               side: const BorderSide(color: AppColors.primaryColor),
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12)),
//             ),
//           ),
//         ),

//         if (docs.isEmpty)
//           Padding(
//             padding: EdgeInsets.symmetric(
//                 vertical: size.customHeight(context) * 0.02),
//             child: Center(
//               child: Text(
//                 'No documents added yet',
//                 style: GoogleFonts.poppins(
//                   fontSize: size.customWidth(context) * 0.034,
//                   color: AppColors.textSecondaryColor,
//                 ),
//               ),
//             ),
//           )
//         else
//           ...List.generate(docs.length, (i) => _buildDocTile(context, size, i, docs[i])),
//       ],
//     );
//   }

//   Widget _buildDocTile(
//       BuildContext context, CustomSize size, int docIndex, Map<String, String> doc) {
//     return Container(
//       margin: EdgeInsets.only(top: size.customHeight(context) * 0.012),
//       padding: EdgeInsets.all(size.customWidth(context) * 0.035),
//       decoration: BoxDecoration(
//         color: AppColors.lightGreyColor,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: AppColors.primaryColor.withOpacity(0.15)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 width: 38,
//                 height: 38,
//                 decoration: BoxDecoration(
//                   color: AppColors.primaryColor.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: const Icon(Icons.picture_as_pdf,
//                     color: AppColors.primaryColor, size: 20),
//               ),
//               SizedBox(width: size.customWidth(context) * 0.025),
//               Expanded(
//                 child: Text(
//                   doc['name'] ?? '',
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.034,
//                     fontWeight: FontWeight.w500,
//                     color: AppColors.textPrimaryColor,
//                   ),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//               IconButton(
//                 icon: const Icon(Icons.close,
//                     color: AppColors.errorColor, size: 18),
//                 onPressed: () {
//                   widget.controller.removeDocument(widget.index, docIndex);
//                   setState(() {});
//                 },
//                 padding: EdgeInsets.zero,
//                 constraints: const BoxConstraints(),
//               ),
//             ],
//           ),
//           SizedBox(height: size.customHeight(context) * 0.01),
//           DropdownButtonFormField<String>(
//             value: doc['type'] ?? 'other',
//             style: GoogleFonts.poppins(
//                 fontSize: size.customWidth(context) * 0.034,
//                 color: AppColors.textPrimaryColor),
//             dropdownColor: AppColors.whiteColor,
//             borderRadius: BorderRadius.circular(12),
//             decoration: InputDecoration(
//               prefixIcon: const Icon(Icons.category_outlined,
//                   color: AppColors.primaryColor, size: 17),
//               isDense: true,
//               filled: true,
//               fillColor: AppColors.whiteColor,
//               border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide: BorderSide.none),
//               contentPadding: EdgeInsets.symmetric(
//                   vertical: size.customHeight(context) * 0.012,
//                   horizontal: size.customWidth(context) * 0.03),
//             ),
//             items: kRegDocumentTypes
//                 .map((t) => DropdownMenuItem(
//                       value: t,
//                       child: Text(_formatDocType(t),
//                           style: GoogleFonts.poppins(
//                               fontSize: size.customWidth(context) * 0.034)),
//                     ))
//                 .toList(),
//             onChanged: (v) {
//               widget.controller.updateDocumentType(
//                   widget.index, docIndex, v ?? 'other');
//               setState(() {});
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   // ── Shared field builders ─────────────────────────────────────────────────

//   Widget _label(BuildContext context, CustomSize size, String text) {
//     return Text(
//       text,
//       style: GoogleFonts.poppins(
//         fontSize: size.customWidth(context) * 0.036,
//         fontWeight: FontWeight.w600,
//         color: AppColors.textPrimaryColor,
//       ),
//     );
//   }

//   InputDecoration _inputDecoration(BuildContext context, CustomSize size,
//       {required String hint, required IconData icon}) {
//     return InputDecoration(
//       prefixIcon: Icon(icon, color: AppColors.primaryColor, size: 20),
//       hintText: hint,
//       hintStyle: GoogleFonts.poppins(
//         fontSize: size.customWidth(context) * 0.036,
//         color: AppColors.greyColor,
//       ),
//       filled: true,
//       fillColor: AppColors.lightGreyColor,
//       border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
//       enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: AppColors.greyColor.withOpacity(0.2))),
//       focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide:
//               const BorderSide(color: AppColors.primaryColor, width: 1.8)),
//       contentPadding: EdgeInsets.symmetric(
//         vertical: size.customHeight(context) * 0.018,
//         horizontal: size.customWidth(context) * 0.04,
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
//         fontSize: size.customWidth(context) * 0.037,
//         color: AppColors.textPrimaryColor,
//       ),
//       decoration: InputDecoration(
//         prefixIcon: Icon(icon, color: AppColors.primaryColor, size: 20),
//         suffixIcon: suffixIcon != null
//             ? Icon(suffixIcon, color: AppColors.primaryColor, size: 18)
//             : null,
//         hintText: hint,
//         hintStyle: GoogleFonts.poppins(
//           fontSize: size.customWidth(context) * 0.037,
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
//           borderSide:
//               BorderSide(color: AppColors.greyColor.withOpacity(0.2), width: 1),
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
//     required IconData icon,
//     required Color color,
//     required bool isSelected,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         padding:
//             EdgeInsets.symmetric(vertical: size.customHeight(context) * 0.018),
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
//                 fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
//                 color:
//                     isSelected ? color : AppColors.textSecondaryColor,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   String _formatDocType(String type) => type
//       .split('_')
//       .map((w) => w[0].toUpperCase() + w.substring(1))
//       .join(' ');
// }


// lib/view/auth/add_children_screen.dart
//
// UPDATED — each child card now has:
//   • Basic info (name, dob, gender)  ← unchanged
//   • Health info section (blood group, weight, height, allergies, etc.)
//   • Medical documents section (multiple PDFs, one API call each)
//
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import 'package:speechspectrum/controllers/registration_controller.dart';
import 'package:speechspectrum/controllers/pre_signup_child_controller.dart';
import 'package:speechspectrum/routes/app_routes.dart';

const List<String> kRegDocumentTypes = [
  'lab_result',
  'prescription',
  'hearing_test',
  'vision_test',
  'previous_report',
  'referral_letter',
  'school_report',
  'other',
];

const List<String> kRegBloodGroups = [
  'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-',
];

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
    if (n != null && n >= 1) _childCtrl.setChildCount(n);
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
              return LinearProgressIndicator(
                value: 4 / totalSteps,
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

                      // Title
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
                          'Enter basic info, optional health details & medical documents',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: size.customWidth(context) * 0.035,
                            color: AppColors.textSecondaryColor,
                          ),
                        ),
                      ),

                      SizedBox(height: size.customHeight(context) * 0.03),

                      _buildCountInput(context, size),

                      SizedBox(height: size.customHeight(context) * 0.03),

                      ...List.generate(
                        _childCtrl.childCount.value,
                        (i) => _ChildFullFormCard(
                          index: i,
                          controller: _childCtrl,
                        ),
                      ),

                      SizedBox(height: size.customHeight(context) * 0.02),
                    ],
                  ),
                ),
              ),

              // Continue button
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
                  ),
                  onChanged: _onCountChanged,
                ),
              ],
            ),
          ),
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

// ─────────────────────────────────────────────────────────────────────────────
// Full child form card: basic info + health info + documents
// ─────────────────────────────────────────────────────────────────────────────
class _ChildFullFormCard extends StatefulWidget {
  final int index;
  final PreSignupChildController controller;

  const _ChildFullFormCard({required this.index, required this.controller});

  @override
  State<_ChildFullFormCard> createState() => _ChildFullFormCardState();
}

class _ChildFullFormCardState extends State<_ChildFullFormCard> {
  // basic
  late TextEditingController _nameCtrl;
  late TextEditingController _dateCtrl;
  DateTime? _selectedDate;

  // health
  late TextEditingController _allergiesCtrl;
  late TextEditingController _geneticCtrl;
  late TextEditingController _chronicCtrl;
  late TextEditingController _weightCtrl;
  late TextEditingController _heightCtrl;
  String? _selectedBloodGroup;
  bool _familyHistoryAsd = false;
  bool _familyHistorySpeech = false;
  bool _familyHistoryHearing = false;

  // section expansion
  bool _healthExpanded = false;
  bool _docsExpanded = false;

  @override
  void initState() {
    super.initState();
    final data = widget.controller.getChildData(widget.index);

    _nameCtrl = TextEditingController(text: data['name'] ?? '');
    _dateCtrl = TextEditingController(text: data['dobDisplay'] ?? '');
    final dobRaw = data['dob'] as String?;
    if (dobRaw != null && dobRaw.isNotEmpty) {
      try { _selectedDate = DateTime.parse(dobRaw); } catch (_) {}
    }

    _allergiesCtrl = TextEditingController(text: data['knownAllergies'] ?? '');
    _geneticCtrl = TextEditingController(text: data['geneticDisorders'] ?? '');
    _chronicCtrl = TextEditingController(text: data['chronicConditions'] ?? '');
    _weightCtrl = TextEditingController(text: data['weightKg'] ?? '');
    _heightCtrl = TextEditingController(text: data['heightCm'] ?? '');
    // Convert empty string → null so the dropdown has no pre-selected value
    final rawBloodGroup = data['bloodGroup'] as String?;
    _selectedBloodGroup = (rawBloodGroup != null && rawBloodGroup.isNotEmpty)
        ? (kRegBloodGroups.contains(rawBloodGroup) ? rawBloodGroup : null)
        : null;
    _familyHistoryAsd = data['familyHistoryAsd'] ?? false;
    _familyHistorySpeech = data['familyHistorySpeech'] ?? false;
    _familyHistoryHearing = data['familyHistoryHearing'] ?? false;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _dateCtrl.dispose();
    _allergiesCtrl.dispose();
    _geneticCtrl.dispose();
    _chronicCtrl.dispose();
    _weightCtrl.dispose();
    _heightCtrl.dispose();
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
          'Jan','Feb','Mar','Apr','May','Jun',
          'Jul','Aug','Sep','Oct','Nov','Dec'
        ];
        _dateCtrl.text =
            '${months[picked.month - 1]} ${picked.day}, ${picked.year}';
      });
      final formatted =
          '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      widget.controller.updateChild(widget.index,
          dob: formatted, dobDisplay: _dateCtrl.text);
    }
  }

  Future<void> _pickDocuments() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: true,
    );
    if (result == null || result.files.isEmpty) return;
    for (final file in result.files) {
      widget.controller.addDocument(
        widget.index,
        path: file.path!,
        type: 'other',
        name: file.name,
      );
    }
    setState(() {});
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
          // ── Card header ─────────────────────────────────────────────
          _buildCardHeader(context, size),

          Padding(
            padding: EdgeInsets.all(size.customWidth(context) * 0.045),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Basic info ────────────────────────────────────────
                _buildBasicInfo(context, size),

                SizedBox(height: size.customHeight(context) * 0.02),

                // ── Health info (expandable) ───────────────────────────
                _buildExpandableSection(
                  context: context,
                  size: size,
                  title: 'Health Information',
                  subtitle: 'Optional · Blood group, weight, allergies…',
                  icon: Icons.medical_services_outlined,
                  color: const Color(0xFF00b894),
                  expanded: _healthExpanded,
                  onToggle: () =>
                      setState(() => _healthExpanded = !_healthExpanded),
                  child: _buildHealthSection(context, size),
                ),

                SizedBox(height: size.customHeight(context) * 0.015),

                // ── Documents (expandable) ────────────────────────────
                _buildExpandableSection(
                  context: context,
                  size: size,
                  title: 'Medical Documents',
                  subtitle: 'Optional · PDF files only',
                  icon: Icons.folder_outlined,
                  color: AppColors.accentColor,
                  expanded: _docsExpanded,
                  onToggle: () =>
                      setState(() => _docsExpanded = !_docsExpanded),
                  child: _buildDocumentsSection(context, size),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardHeader(BuildContext context, CustomSize size) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.customWidth(context) * 0.045,
        vertical: size.customHeight(context) * 0.014,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          AppColors.primaryColor.withOpacity(0.12),
          AppColors.secondaryColor.withOpacity(0.06),
        ]),
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
    );
  }

  Widget _buildBasicInfo(BuildContext context, CustomSize size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(context, size, 'Full Name *'),
        SizedBox(height: size.customHeight(context) * 0.008),
        _buildTextField(
          context: context,
          size: size,
          ctrl: _nameCtrl,
          hint: "Enter child's full name",
          icon: Icons.person_outline_rounded,
          onChanged: (v) =>
              widget.controller.updateChild(widget.index, name: v),
        ),

        SizedBox(height: size.customHeight(context) * 0.02),

        _label(context, size, 'Date of Birth *'),
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
    );
  }

  Widget _buildExpandableSection({
    required BuildContext context,
    required CustomSize size,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required bool expanded,
    required VoidCallback onToggle,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.04),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onToggle,
            borderRadius: BorderRadius.circular(14),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.customWidth(context) * 0.04,
                vertical: size.customHeight(context) * 0.015,
              ),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(icon, color: color, size: 20),
                  ),
                  SizedBox(width: size.customWidth(context) * 0.03),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.poppins(
                            fontSize: size.customWidth(context) * 0.038,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimaryColor,
                          ),
                        ),
                        Text(
                          subtitle,
                          style: GoogleFonts.poppins(
                            fontSize: size.customWidth(context) * 0.03,
                            color: AppColors.textSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    expanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: color,
                  ),
                ],
              ),
            ),
          ),
          if (expanded)
            Padding(
              padding: EdgeInsets.fromLTRB(
                size.customWidth(context) * 0.04,
                0,
                size.customWidth(context) * 0.04,
                size.customHeight(context) * 0.015,
              ),
              child: child,
            ),
        ],
      ),
    );
  }

  Widget _buildHealthSection(BuildContext context, CustomSize size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(color: AppColors.greyColor.withOpacity(0.2)),
        SizedBox(height: size.customHeight(context) * 0.01),

        // Blood group dropdown
        _label(context, size, 'Blood Group'),
        SizedBox(height: size.customHeight(context) * 0.008),
        DropdownButtonFormField<String>(
          // Ensure value is EITHER null OR exactly one of the list items.
          // Never pass an empty string — that would crash the assertion.
          value: (_selectedBloodGroup != null &&
                  kRegBloodGroups.contains(_selectedBloodGroup))
              ? _selectedBloodGroup
              : null,
          style: GoogleFonts.poppins(
              fontSize: size.customWidth(context) * 0.037,
              color: AppColors.textPrimaryColor),
          dropdownColor: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(12),
          hint: Text(
            'Select blood group',
            style: GoogleFonts.poppins(
                fontSize: size.customWidth(context) * 0.037,
                color: AppColors.greyColor),
          ),
          decoration: _inputDecorationNoHint(context, size,
              icon: Icons.bloodtype_outlined),
          items: kRegBloodGroups
              .map((g) => DropdownMenuItem(
                    value: g,
                    child: Text(g,
                        style: GoogleFonts.poppins(
                            fontSize: size.customWidth(context) * 0.037)),
                  ))
              .toList(),
          onChanged: (v) {
            setState(() => _selectedBloodGroup = v);
            widget.controller.updateChild(widget.index, bloodGroup: v ?? '');
          },
        ),

        SizedBox(height: size.customHeight(context) * 0.018),

        // Weight + Height
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label(context, size, 'Weight (kg)'),
                  SizedBox(height: size.customHeight(context) * 0.008),
                  TextFormField(
                    controller: _weightCtrl,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))
                    ],
                    cursorColor: AppColors.primaryColor,
                    style: GoogleFonts.poppins(
                        fontSize: size.customWidth(context) * 0.037,
                        color: AppColors.textPrimaryColor),
                    decoration: _inputDecoration(context, size,
                        hint: 'e.g. 18.5',
                        icon: Icons.monitor_weight_outlined),
                    onChanged: (v) => widget.controller
                        .updateChild(widget.index, weightKg: v),
                  ),
                ],
              ),
            ),
            SizedBox(width: size.customWidth(context) * 0.03),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label(context, size, 'Height (cm)'),
                  SizedBox(height: size.customHeight(context) * 0.008),
                  TextFormField(
                    controller: _heightCtrl,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))
                    ],
                    cursorColor: AppColors.primaryColor,
                    style: GoogleFonts.poppins(
                        fontSize: size.customWidth(context) * 0.037,
                        color: AppColors.textPrimaryColor),
                    decoration: _inputDecoration(context, size,
                        hint: 'e.g. 109.2',
                        icon: Icons.height_outlined),
                    onChanged: (v) => widget.controller
                        .updateChild(widget.index, heightCm: v),
                  ),
                ],
              ),
            ),
          ],
        ),

        SizedBox(height: size.customHeight(context) * 0.018),

        _label(context, size, 'Known Allergies'),
        SizedBox(height: size.customHeight(context) * 0.008),
        TextFormField(
          controller: _allergiesCtrl,
          cursorColor: AppColors.primaryColor,
          style: GoogleFonts.poppins(
              fontSize: size.customWidth(context) * 0.037,
              color: AppColors.textPrimaryColor),
          decoration: _inputDecoration(context, size,
              hint: 'e.g. Peanuts, Dust',
              icon: Icons.warning_amber_outlined),
          onChanged: (v) =>
              widget.controller.updateChild(widget.index, knownAllergies: v),
        ),

        SizedBox(height: size.customHeight(context) * 0.018),

        _label(context, size, 'Genetic Disorders'),
        SizedBox(height: size.customHeight(context) * 0.008),
        TextFormField(
          controller: _geneticCtrl,
          cursorColor: AppColors.primaryColor,
          style: GoogleFonts.poppins(
              fontSize: size.customWidth(context) * 0.037,
              color: AppColors.textPrimaryColor),
          decoration: _inputDecoration(context, size,
              hint: 'e.g. None',
              icon: Icons.biotech_outlined),
          onChanged: (v) =>
              widget.controller.updateChild(widget.index, geneticDisorders: v),
        ),

        SizedBox(height: size.customHeight(context) * 0.018),

        _label(context, size, 'Chronic Conditions'),
        SizedBox(height: size.customHeight(context) * 0.008),
        TextFormField(
          controller: _chronicCtrl,
          cursorColor: AppColors.primaryColor,
          style: GoogleFonts.poppins(
              fontSize: size.customWidth(context) * 0.037,
              color: AppColors.textPrimaryColor),
          decoration: _inputDecoration(context, size,
              hint: 'e.g. Mild asthma',
              icon: Icons.local_hospital_outlined),
          onChanged: (v) =>
              widget.controller.updateChild(widget.index, chronicConditions: v),
        ),

        SizedBox(height: size.customHeight(context) * 0.018),

        _label(context, size, 'Family History'),
        SizedBox(height: size.customHeight(context) * 0.01),
        _buildToggleRow(
          context: context,
          size: size,
          label: 'ASD History',
          value: _familyHistoryAsd,
          onChanged: (v) {
            setState(() => _familyHistoryAsd = v);
            widget.controller.updateChild(widget.index, familyHistoryAsd: v);
          },
        ),
        _buildToggleRow(
          context: context,
          size: size,
          label: 'Speech Disorders',
          value: _familyHistorySpeech,
          onChanged: (v) {
            setState(() => _familyHistorySpeech = v);
            widget.controller.updateChild(widget.index, familyHistorySpeech: v);
          },
        ),
        _buildToggleRow(
          context: context,
          size: size,
          label: 'Hearing Loss',
          value: _familyHistoryHearing,
          onChanged: (v) {
            setState(() => _familyHistoryHearing = v);
            widget.controller.updateChild(widget.index, familyHistoryHearing: v);
          },
        ),
      ],
    );
  }

  Widget _buildToggleRow({
    required BuildContext context,
    required CustomSize size,
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.customHeight(context) * 0.006),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: size.customWidth(context) * 0.036,
                color: AppColors.textPrimaryColor,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentsSection(BuildContext context, CustomSize size) {
    final docs = widget.controller.getDocuments(widget.index);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(color: AppColors.greyColor.withOpacity(0.2)),
        SizedBox(height: size.customHeight(context) * 0.01),

        // Upload button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: _pickDocuments,
            icon: const Icon(Icons.upload_file,
                color: AppColors.primaryColor, size: 20),
            label: Text(
              'Add PDF Documents',
              style: GoogleFonts.poppins(
                color: AppColors.primaryColor,
                fontSize: size.customWidth(context) * 0.037,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                  vertical: size.customHeight(context) * 0.015),
              side: const BorderSide(color: AppColors.primaryColor),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),

        if (docs.isEmpty)
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: size.customHeight(context) * 0.02),
            child: Center(
              child: Text(
                'No documents added yet',
                style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.034,
                  color: AppColors.textSecondaryColor,
                ),
              ),
            ),
          )
        else
          ...List.generate(docs.length, (i) => _buildDocTile(context, size, i, docs[i])),
      ],
    );
  }

  Widget _buildDocTile(
      BuildContext context, CustomSize size, int docIndex, Map<String, String> doc) {
    return Container(
      margin: EdgeInsets.only(top: size.customHeight(context) * 0.012),
      padding: EdgeInsets.all(size.customWidth(context) * 0.035),
      decoration: BoxDecoration(
        color: AppColors.lightGreyColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primaryColor.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.picture_as_pdf,
                    color: AppColors.primaryColor, size: 20),
              ),
              SizedBox(width: size.customWidth(context) * 0.025),
              Expanded(
                child: Text(
                  doc['name'] ?? '',
                  style: GoogleFonts.poppins(
                    fontSize: size.customWidth(context) * 0.034,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimaryColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close,
                    color: AppColors.errorColor, size: 18),
                onPressed: () {
                  widget.controller.removeDocument(widget.index, docIndex);
                  setState(() {});
                },
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          SizedBox(height: size.customHeight(context) * 0.01),
          DropdownButtonFormField<String>(
            // Guard: only use the stored type if it exists in the list
            value: kRegDocumentTypes.contains(doc['type']) ? doc['type'] : 'other',
            style: GoogleFonts.poppins(
                fontSize: size.customWidth(context) * 0.034,
                color: AppColors.textPrimaryColor),
            dropdownColor: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(12),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.category_outlined,
                  color: AppColors.primaryColor, size: 17),
              isDense: true,
              filled: true,
              fillColor: AppColors.whiteColor,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              contentPadding: EdgeInsets.symmetric(
                  vertical: size.customHeight(context) * 0.012,
                  horizontal: size.customWidth(context) * 0.03),
            ),
            items: kRegDocumentTypes
                .map((t) => DropdownMenuItem(
                      value: t,
                      child: Text(_formatDocType(t),
                          style: GoogleFonts.poppins(
                              fontSize: size.customWidth(context) * 0.034)),
                    ))
                .toList(),
            onChanged: (v) {
              widget.controller.updateDocumentType(
                  widget.index, docIndex, v ?? 'other');
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  // ── Shared field builders ─────────────────────────────────────────────────

  Widget _label(BuildContext context, CustomSize size, String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: size.customWidth(context) * 0.036,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimaryColor,
      ),
    );
  }

  InputDecoration _inputDecoration(BuildContext context, CustomSize size,
      {required String hint, required IconData icon}) {
    return InputDecoration(
      prefixIcon: Icon(icon, color: AppColors.primaryColor, size: 20),
      hintText: hint,
      hintStyle: GoogleFonts.poppins(
        fontSize: size.customWidth(context) * 0.036,
        color: AppColors.greyColor,
      ),
      filled: true,
      fillColor: AppColors.lightGreyColor,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.greyColor.withOpacity(0.2))),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              const BorderSide(color: AppColors.primaryColor, width: 1.8)),
      contentPadding: EdgeInsets.symmetric(
        vertical: size.customHeight(context) * 0.018,
        horizontal: size.customWidth(context) * 0.04,
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
        fontSize: size.customWidth(context) * 0.037,
        color: AppColors.textPrimaryColor,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: AppColors.primaryColor, size: 20),
        suffixIcon: suffixIcon != null
            ? Icon(suffixIcon, color: AppColors.primaryColor, size: 18)
            : null,
        hintText: hint,
        hintStyle: GoogleFonts.poppins(
          fontSize: size.customWidth(context) * 0.037,
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

  // Same as _inputDecoration but without hintText — used when the dropdown
  // widget itself supplies the hint via its own `hint:` property.
  InputDecoration _inputDecorationNoHint(BuildContext context, CustomSize size,
      {required IconData icon}) {
    return InputDecoration(
      prefixIcon: Icon(icon, color: AppColors.primaryColor, size: 20),
      filled: true,
      fillColor: AppColors.lightGreyColor,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.greyColor.withOpacity(0.2))),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              const BorderSide(color: AppColors.primaryColor, width: 1.8)),
      contentPadding: EdgeInsets.symmetric(
        vertical: size.customHeight(context) * 0.018,
        horizontal: size.customWidth(context) * 0.04,
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
                color:
                    isSelected ? color : AppColors.textSecondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDocType(String type) => type
      .split('_')
      .map((w) => w[0].toUpperCase() + w.substring(1))
      .join(' ');
}