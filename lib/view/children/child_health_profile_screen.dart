// // lib/view/children/child_health_profile_screen.dart
// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/components/custom_button.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/controllers/child_health_controller.dart';
// import 'package:speechspectrum/models/child_health_model.dart';
// import 'package:speechspectrum/models/child_model.dart';

// const List<String> kDocumentTypes = [
//   'lab_result',
//   'prescription',
//   'hearing_test',
//   'vision_test',
//   'previous_report',
//   'referral_letter',
//   'school_report',
//   'other',
// ];

// const List<String> kBloodGroups = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];

// class ChildHealthProfileScreen extends StatefulWidget {
//   const ChildHealthProfileScreen({super.key});

//   @override
//   State<ChildHealthProfileScreen> createState() => _ChildHealthProfileScreenState();
// }

// class _ChildHealthProfileScreenState extends State<ChildHealthProfileScreen> {
//   final _formKey = GlobalKey<FormState>();
//   late ChildHealthController controller;
//   late ChildData child;
//   ChildHealthData? existingHealth;
//   bool get isEditMode => existingHealth != null;

//   // Form controllers
//   final _allergiesCtrl = TextEditingController();
//   final _geneticCtrl = TextEditingController();
//   final _chronicCtrl = TextEditingController();
//   final _weightCtrl = TextEditingController();
//   final _heightCtrl = TextEditingController();

//   String? _selectedBloodGroup;
//   bool _familyHistoryAsd = false;
//   bool _familyHistorySpeech = false;
//   bool _familyHistoryHearing = false;

//   // Pending document uploads
//   final List<_PendingDocument> _pendingDocs = [];

//   @override
//   void initState() {
//     super.initState();
//     final args = Get.arguments as Map<String, dynamic>;
//     child = args['child'] as ChildData;
//     existingHealth = args['healthData'] as ChildHealthData?;

//     controller = Get.isRegistered<ChildHealthController>()
//         ? Get.find<ChildHealthController>()
//         : Get.put(ChildHealthController());

//     if (existingHealth != null) {
//       _selectedBloodGroup = existingHealth!.bloodGroup;
//       _allergiesCtrl.text = existingHealth!.knownAllergies ?? '';
//       _geneticCtrl.text = existingHealth!.geneticDisorders ?? '';
//       _chronicCtrl.text = existingHealth!.chronicConditions ?? '';
//       _weightCtrl.text = existingHealth!.weightKg?.toString() ?? '';
//       _heightCtrl.text = existingHealth!.heightCm?.toString() ?? '';
//       _familyHistoryAsd = existingHealth!.familyHistoryAsd;
//       _familyHistorySpeech = existingHealth!.familyHistorysSpeechDisorders;
//       _familyHistoryHearing = existingHealth!.familyHistoryHearingLoss;
//     }
//   }

//   @override
//   void dispose() {
//     _allergiesCtrl.dispose();
//     _geneticCtrl.dispose();
//     _chronicCtrl.dispose();
//     _weightCtrl.dispose();
//     _heightCtrl.dispose();
//     super.dispose();
//   }

//   Future<void> _pickDocument() async {
//     final result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf'],
//       allowMultiple: false,
//     );
//     if (result != null && result.files.isNotEmpty) {
//       final file = result.files.first;
//       setState(() {
//         _pendingDocs.add(_PendingDocument(
//           path: file.path!,
//           name: file.name,
//           type: 'other',
//         ));
//       });
//     }
//   }

//   Future<void> _handleSubmit() async {
//     if (!_formKey.currentState!.validate()) return;

//     final data = <String, dynamic>{
//       if (_selectedBloodGroup != null) 'blood_group': _selectedBloodGroup,
//       'known_allergies': _allergiesCtrl.text.trim(),
//       'family_history_asd': _familyHistoryAsd,
//       'family_history_speech_disorders': _familyHistorySpeech,
//       'family_history_hearing_loss': _familyHistoryHearing,
//       'genetic_disorders': _geneticCtrl.text.trim(),
//       'chronic_conditions': _chronicCtrl.text.trim(),
//       if (_weightCtrl.text.trim().isNotEmpty) 'weight_kg': double.tryParse(_weightCtrl.text.trim()),
//       if (_heightCtrl.text.trim().isNotEmpty) 'height_cm': double.tryParse(_heightCtrl.text.trim()),
//     };

//     final saved = await controller.saveHealthProfile(
//       childId: child.childId,
//       data: data,
//       isUpdate: isEditMode,
//     );

//     if (!saved) return;

//     // Upload pending documents sequentially
//     if (_pendingDocs.isNotEmpty) {
//       final records = _pendingDocs
//           .map((d) => {'path': d.path, 'type': d.type})
//           .toList();
//       await controller.uploadMedicalRecords(childId: child.childId, records: records);
//     }

//     Get.back(result: true);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final w = MediaQuery.of(context).size.width;
//     final h = MediaQuery.of(context).size.height;

//     return Scaffold(
//       backgroundColor: AppColors.lightGreyColor,
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             expandedHeight: h * 0.25,
//             pinned: true,
//             elevation: 0,
//             backgroundColor: AppColors.primaryColor,
//             flexibleSpace: FlexibleSpaceBar(background: _buildHeader(context, w, h)),
//             leading: IconButton(
//               icon: const Icon(Icons.arrow_back, color: AppColors.whiteColor),
//               onPressed: () => Get.back(),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: EdgeInsets.all(w * 0.05),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _sectionCard(
//                       context,
//                       title: 'Basic Measurements',
//                       icon: Icons.monitor_weight_outlined,
//                       child: Column(
//                         children: [
//                           _buildDropdown(
//                             context,
//                             label: 'Blood Group',
//                             icon: Icons.bloodtype_outlined,
//                             value: _selectedBloodGroup,
//                             items: kBloodGroups,
//                             onChanged: (v) => setState(() => _selectedBloodGroup = v),
//                           ),
//                           SizedBox(height: h * 0.02),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: _buildNumberField(
//                                   context,
//                                   ctrl: _weightCtrl,
//                                   label: 'Weight (kg)',
//                                   hint: 'e.g. 18.5',
//                                   icon: Icons.monitor_weight_outlined,
//                                 ),
//                               ),
//                               SizedBox(width: w * 0.04),
//                               Expanded(
//                                 child: _buildNumberField(
//                                   context,
//                                   ctrl: _heightCtrl,
//                                   label: 'Height (cm)',
//                                   hint: 'e.g. 109.2',
//                                   icon: Icons.height_outlined,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: h * 0.02),
//                     _sectionCard(
//                       context,
//                       title: 'Medical History',
//                       icon: Icons.medical_information_outlined,
//                       child: Column(
//                         children: [
//                           _buildTextField(context, ctrl: _allergiesCtrl, label: 'Known Allergies', hint: 'e.g. Peanuts, Dust', icon: Icons.warning_amber_outlined),
//                           SizedBox(height: h * 0.02),
//                           _buildTextField(context, ctrl: _geneticCtrl, label: 'Genetic Disorders', hint: 'e.g. None', icon: Icons.biotech_outlined),
//                           SizedBox(height: h * 0.02),
//                           _buildTextField(context, ctrl: _chronicCtrl, label: 'Chronic Conditions', hint: 'e.g. Mild asthma', icon: Icons.local_hospital_outlined),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: h * 0.02),
//                     _sectionCard(
//                       context,
//                       title: 'Family History',
//                       icon: Icons.family_restroom_outlined,
//                       child: Column(
//                         children: [
//                           _buildToggle(context, label: 'Family History of ASD', subtitle: 'Autism Spectrum Disorder', value: _familyHistoryAsd, onChanged: (v) => setState(() => _familyHistoryAsd = v)),
//                           _buildDivider(),
//                           _buildToggle(context, label: 'Family History of Speech Disorders', subtitle: 'Speech or language difficulties', value: _familyHistorySpeech, onChanged: (v) => setState(() => _familyHistorySpeech = v)),
//                           _buildDivider(),
//                           _buildToggle(context, label: 'Family History of Hearing Loss', subtitle: 'Hearing impairment in family', value: _familyHistoryHearing, onChanged: (v) => setState(() => _familyHistoryHearing = v)),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: h * 0.02),
//                     _sectionCard(
//                       context,
//                       title: 'Medical Documents',
//                       icon: Icons.folder_outlined,
//                       trailing: TextButton.icon(
//                         onPressed: _pickDocument,
//                         icon: const Icon(Icons.add, color: AppColors.primaryColor, size: 18),
//                         label: Text('Add PDF', style: GoogleFonts.poppins(color: AppColors.primaryColor, fontSize: w * 0.035, fontWeight: FontWeight.w600)),
//                       ),
//                       child: _pendingDocs.isEmpty
//                           ? _buildEmptyDocsHint(context, w, h)
//                           : Column(
//                               children: List.generate(_pendingDocs.length, (i) => _buildPendingDocTile(context, i, w, h)),
//                             ),
//                     ),
//                     SizedBox(height: h * 0.04),
//                     Obx(() => CustomButton(
//                           title: isEditMode ? 'Update Health Profile' : 'Save Health Profile',
//                           height: h * 0.065,
//                           width: double.infinity,
//                           radius: 15,
//                           color: AppColors.primaryColor,
//                           loading: controller.isSaving.value || controller.isUploading.value,
//                           onTap: _handleSubmit,
//                         )),
//                     SizedBox(height: h * 0.04),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ── Widgets ────────────────────────────────────────────────────────────────

//   Widget _buildHeader(BuildContext context, double w, double h) {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [AppColors.primaryColor, AppColors.secondaryColor],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       child: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.all(w * 0.05),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 width: 75,
//                 height: 75,
//                 decoration: BoxDecoration(
//                   color: AppColors.whiteColor.withOpacity(0.2),
//                   shape: BoxShape.circle,
//                 ),
//                 child: const Icon(Icons.medical_services_rounded, size: 40, color: AppColors.whiteColor),
//               ),
//               SizedBox(height: h * 0.015),
//               Text(
//                 isEditMode ? 'Edit Health Profile' : 'Health Profile',
//                 style: GoogleFonts.poppins(
//                   color: AppColors.whiteColor,
//                   fontSize: w * 0.055,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 0.5,
//                 ),
//               ),
//               SizedBox(height: h * 0.005),
//               Text(
//                 child.childName,
//                 style: GoogleFonts.poppins(
//                   color: AppColors.whiteColor.withOpacity(0.9),
//                   fontSize: w * 0.038,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _sectionCard(BuildContext context, {required String title, required IconData icon, required Widget child, Widget? trailing}) {
//     final w = MediaQuery.of(context).size.width;
//     final h = MediaQuery.of(context).size.height;
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 12, offset: const Offset(0, 4))],
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(w * 0.045),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Container(
//                   width: 38,
//                   height: 38,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(colors: [AppColors.primaryColor.withOpacity(0.15), AppColors.secondaryColor.withOpacity(0.08)]),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Icon(icon, color: AppColors.primaryColor, size: 20),
//                 ),
//                 SizedBox(width: w * 0.03),
//                 Expanded(
//                   child: Text(
//                     title,
//                     style: GoogleFonts.poppins(fontSize: w * 0.042, fontWeight: FontWeight.bold, color: AppColors.textPrimaryColor),
//                   ),
//                 ),
//                 if (trailing != null) trailing,
//               ],
//             ),
//             SizedBox(height: h * 0.02),
//             child,
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(BuildContext context, {required TextEditingController ctrl, required String label, required String hint, required IconData icon}) {
//     final w = MediaQuery.of(context).size.width;
//     final h = MediaQuery.of(context).size.height;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label, style: GoogleFonts.poppins(fontSize: w * 0.037, fontWeight: FontWeight.w500, color: AppColors.textSecondaryColor)),
//         SizedBox(height: h * 0.008),
//         TextFormField(
//           controller: ctrl,
//           style: GoogleFonts.poppins(fontSize: w * 0.038, color: AppColors.textPrimaryColor),
//           cursorColor: AppColors.primaryColor,
//           decoration: _inputDecoration(context, hint: hint, icon: icon),
//         ),
//       ],
//     );
//   }

//   Widget _buildNumberField(BuildContext context, {required TextEditingController ctrl, required String label, required String hint, required IconData icon}) {
//     final w = MediaQuery.of(context).size.width;
//     final h = MediaQuery.of(context).size.height;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label, style: GoogleFonts.poppins(fontSize: w * 0.033, fontWeight: FontWeight.w500, color: AppColors.textSecondaryColor)),
//         SizedBox(height: h * 0.008),
//         TextFormField(
//           controller: ctrl,
//           keyboardType: const TextInputType.numberWithOptions(decimal: true),
//           inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
//           style: GoogleFonts.poppins(fontSize: w * 0.038, color: AppColors.textPrimaryColor),
//           cursorColor: AppColors.primaryColor,
//           decoration: _inputDecoration(context, hint: hint, icon: icon),
//         ),
//       ],
//     );
//   }

//   Widget _buildDropdown(BuildContext context, {required String label, required IconData icon, required String? value, required List<String> items, required ValueChanged<String?> onChanged}) {
//     final w = MediaQuery.of(context).size.width;
//     final h = MediaQuery.of(context).size.height;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label, style: GoogleFonts.poppins(fontSize: w * 0.037, fontWeight: FontWeight.w500, color: AppColors.textSecondaryColor)),
//         SizedBox(height: h * 0.008),
//         DropdownButtonFormField<String>(
//           value: value,
//           style: GoogleFonts.poppins(fontSize: w * 0.038, color: AppColors.textPrimaryColor),
//           decoration: _inputDecoration(context, hint: 'Select blood group', icon: icon),
//           dropdownColor: AppColors.whiteColor,
//           borderRadius: BorderRadius.circular(15),
//           items: items.map((g) => DropdownMenuItem(value: g, child: Text(g, style: GoogleFonts.poppins(fontSize: w * 0.038)))).toList(),
//           onChanged: onChanged,
//         ),
//       ],
//     );
//   }

//   InputDecoration _inputDecoration(BuildContext context, {required String hint, required IconData icon}) {
//     final w = MediaQuery.of(context).size.width;
//     final h = MediaQuery.of(context).size.height;
//     return InputDecoration(
//       prefixIcon: Icon(icon, color: AppColors.primaryColor),
//       hintText: hint,
//       hintStyle: GoogleFonts.poppins(color: AppColors.greyColor, fontSize: w * 0.037),
//       filled: true,
//       fillColor: AppColors.lightGreyColor,
//       border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
//       enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
//       focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.primaryColor, width: 2)),
//       contentPadding: EdgeInsets.symmetric(vertical: h * 0.018, horizontal: w * 0.04),
//     );
//   }

//   Widget _buildToggle(BuildContext context, {required String label, required String subtitle, required bool value, required ValueChanged<bool> onChanged}) {
//     final w = MediaQuery.of(context).size.width;
//     return Row(
//       children: [
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(label, style: GoogleFonts.poppins(fontSize: w * 0.038, fontWeight: FontWeight.w500, color: AppColors.textPrimaryColor)),
//               Text(subtitle, style: GoogleFonts.poppins(fontSize: w * 0.032, color: AppColors.textSecondaryColor)),
//             ],
//           ),
//         ),
//         Switch(
//           value: value,
//           onChanged: onChanged,
//           activeColor: AppColors.primaryColor,
//         ),
//       ],
//     );
//   }

//   Widget _buildDivider() => Padding(
//         padding: const EdgeInsets.symmetric(vertical: 10),
//         child: Divider(color: AppColors.greyColor.withOpacity(0.2), height: 1),
//       );

//   Widget _buildEmptyDocsHint(BuildContext context, double w, double h) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: h * 0.03),
//       alignment: Alignment.center,
//       child: Column(
//         children: [
//           Icon(Icons.upload_file_outlined, color: AppColors.greyColor, size: 44),
//           SizedBox(height: h * 0.01),
//           Text('No documents added', style: GoogleFonts.poppins(color: AppColors.textSecondaryColor, fontSize: w * 0.036)),
//           SizedBox(height: h * 0.005),
//           Text('Tap "Add PDF" to upload medical records', style: GoogleFonts.poppins(color: AppColors.greyColor, fontSize: w * 0.032)),
//         ],
//       ),
//     );
//   }

//   Widget _buildPendingDocTile(BuildContext context, int index, double w, double h) {
//     final doc = _pendingDocs[index];
//     return Container(
//       margin: EdgeInsets.only(bottom: h * 0.012),
//       padding: EdgeInsets.all(w * 0.035),
//       decoration: BoxDecoration(
//         color: AppColors.lightGreyColor,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: AppColors.primaryColor.withOpacity(0.2)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 width: 40,
//                 height: 40,
//                 decoration: BoxDecoration(
//                   color: AppColors.primaryColor.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: const Icon(Icons.picture_as_pdf, color: AppColors.primaryColor, size: 22),
//               ),
//               SizedBox(width: w * 0.03),
//               Expanded(
//                 child: Text(doc.name, style: GoogleFonts.poppins(fontSize: w * 0.035, fontWeight: FontWeight.w500, color: AppColors.textPrimaryColor), maxLines: 1, overflow: TextOverflow.ellipsis),
//               ),
//               IconButton(
//                 icon: const Icon(Icons.close, color: AppColors.errorColor, size: 20),
//                 onPressed: () => setState(() => _pendingDocs.removeAt(index)),
//                 padding: EdgeInsets.zero,
//                 constraints: const BoxConstraints(),
//               ),
//             ],
//           ),
//           SizedBox(height: h * 0.012),
//           DropdownButtonFormField<String>(
//             value: doc.type,
//             style: GoogleFonts.poppins(fontSize: w * 0.035, color: AppColors.textPrimaryColor),
//             dropdownColor: AppColors.whiteColor,
//             borderRadius: BorderRadius.circular(12),
//             decoration: InputDecoration(
//               prefixIcon: const Icon(Icons.category_outlined, color: AppColors.primaryColor, size: 18),
//               isDense: true,
//               filled: true,
//               fillColor: AppColors.whiteColor,
//               border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
//               contentPadding: EdgeInsets.symmetric(vertical: h * 0.012, horizontal: w * 0.03),
//             ),
//             items: kDocumentTypes
//                 .map((t) => DropdownMenuItem(
//                       value: t,
//                       child: Text(_formatDocType(t), style: GoogleFonts.poppins(fontSize: w * 0.035)),
//                     ))
//                 .toList(),
//             onChanged: (v) => setState(() => _pendingDocs[index] = _PendingDocument(path: doc.path, name: doc.name, type: v ?? doc.type)),
//           ),
//         ],
//       ),
//     );
//   }

//   String _formatDocType(String type) {
//     return type.split('_').map((w) => w[0].toUpperCase() + w.substring(1)).join(' ');
//   }
// }

// class _PendingDocument {
//   final String path;
//   final String name;
//   final String type;
//   _PendingDocument({required this.path, required this.name, required this.type});
// }


// // lib/view/children/child_health_profile_screen.dart
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/components/custom_button.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/controllers/child_controller.dart';
// import 'package:speechspectrum/controllers/child_health_controller.dart';
// import 'package:speechspectrum/models/child_health_model.dart';
// import 'package:speechspectrum/models/child_model.dart';
// import 'package:speechspectrum/routes/app_routes.dart';

// const List<String> kDocumentTypes = [
//   'lab_result',
//   'prescription',
//   'hearing_test',
//   'vision_test',
//   'previous_report',
//   'referral_letter',
//   'school_report',
//   'other',
// ];

// const List<String> kBloodGroups = [
//   'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'
// ];

// class ChildHealthProfileScreen extends StatefulWidget {
//   const ChildHealthProfileScreen({super.key});

//   @override
//   State<ChildHealthProfileScreen> createState() =>
//       _ChildHealthProfileScreenState();
// }

// class _ChildHealthProfileScreenState extends State<ChildHealthProfileScreen> {
//   final _formKey = GlobalKey<FormState>();
//   late ChildHealthController controller;
//   late ChildData child;
//   ChildHealthData? existingHealth;

//   /// true  → came from Step 1 (create child flow) — Step 2 of 3
//   /// false → standalone edit from child detail screen
//   bool isCreationFlow = false;

//   bool get isEditMode => existingHealth != null;

//   // ── Form controllers ────────────────────────────────────────────────────
//   final _allergiesCtrl = TextEditingController();
//   final _geneticCtrl = TextEditingController();
//   final _chronicCtrl = TextEditingController();
//   final _weightCtrl = TextEditingController();
//   final _heightCtrl = TextEditingController();

//   String? _selectedBloodGroup;
//   bool _familyHistoryAsd = false;
//   bool _familyHistorySpeech = false;
//   bool _familyHistoryHearing = false;

//   // ── Documents: pending new uploads ─────────────────────────────────────
//   final List<_PendingDocument> _pendingDocs = [];

//   // ── Existing records (edit mode): track which ones user wants to replace
//   // key = documentId, value = new file path (null = keep original)
//   final Map<String, _ReplacementDoc?> _recordReplacements = {};

//   @override
//   void initState() {
//     super.initState();
//     final args = Get.arguments as Map<String, dynamic>;
//     child = args['child'] as ChildData;
//     existingHealth = args['healthData'] as ChildHealthData?;
//     isCreationFlow = (args['isCreationFlow'] as bool?) ?? false;

//     controller = Get.isRegistered<ChildHealthController>()
//         ? Get.find<ChildHealthController>()
//         : Get.put(ChildHealthController());

//     // ── Pre-fill fields from existing data ──────────────────────────────
//     if (existingHealth != null) {
//       _selectedBloodGroup = existingHealth!.bloodGroup;
//       _allergiesCtrl.text = existingHealth!.knownAllergies ?? '';
//       _geneticCtrl.text = existingHealth!.geneticDisorders ?? '';
//       _chronicCtrl.text = existingHealth!.chronicConditions ?? '';
//       _weightCtrl.text =
//           existingHealth!.weightKg != null
//               ? existingHealth!.weightKg.toString()
//               : '';
//       _heightCtrl.text =
//           existingHealth!.heightCm != null
//               ? existingHealth!.heightCm.toString()
//               : '';
//       _familyHistoryAsd = existingHealth!.familyHistoryAsd;
//       _familyHistorySpeech = existingHealth!.familyHistorysSpeechDisorders;
//       _familyHistoryHearing = existingHealth!.familyHistoryHearingLoss;

//       // Initialise replacement map with nulls (= keep original)
//       for (final r in existingHealth!.medicalRecords ?? <MedicalRecord>[]) {
//         _recordReplacements[r.documentId] = null;
//       }
//     }
//   }

//   @override
//   void dispose() {
//     _allergiesCtrl.dispose();
//     _geneticCtrl.dispose();
//     _chronicCtrl.dispose();
//     _weightCtrl.dispose();
//     _heightCtrl.dispose();
//     super.dispose();
//   }

//   // ── Pick a brand-new document to add ────────────────────────────────────
//   Future<void> _pickNewDocument() async {
//     final result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf'],
//       allowMultiple: false,
//     );
//     if (result != null && result.files.isNotEmpty) {
//       final file = result.files.first;
//       setState(() {
//         _pendingDocs.add(
//           _PendingDocument(path: file.path!, name: file.name, type: 'other'),
//         );
//       });
//     }
//   }

//   // ── Pick a replacement for an existing record ────────────────────────────
//   Future<void> _pickReplacementForRecord(String documentId) async {
//     final result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf'],
//       allowMultiple: false,
//     );
//     if (result != null && result.files.isNotEmpty) {
//       final file = result.files.first;
//       setState(() {
//         _recordReplacements[documentId] =
//             _ReplacementDoc(path: file.path!, name: file.name, type: 'other');
//       });
//     }
//   }

//   // ── Submit handler ───────────────────────────────────────────────────────
//   Future<void> _handleSubmit() async {
//     if (!_formKey.currentState!.validate()) return;

//     final data = <String, dynamic>{
//       if (_selectedBloodGroup != null) 'blood_group': _selectedBloodGroup,
//       'known_allergies': _allergiesCtrl.text.trim(),
//       'family_history_asd': _familyHistoryAsd,
//       'family_history_speech_disorders': _familyHistorySpeech,
//       'family_history_hearing_loss': _familyHistoryHearing,
//       'genetic_disorders': _geneticCtrl.text.trim(),
//       'chronic_conditions': _chronicCtrl.text.trim(),
//       if (_weightCtrl.text.trim().isNotEmpty)
//         'weight_kg': double.tryParse(_weightCtrl.text.trim()),
//       if (_heightCtrl.text.trim().isNotEmpty)
//         'height_cm': double.tryParse(_heightCtrl.text.trim()),
//     };

//     // Step 1: save / update core health profile
//     final saved = await controller.saveHealthProfile(
//       childId: child.childId,
//       data: data,
//       isUpdate: isEditMode,
//     );
//     if (!saved) return;

//     // Step 2: upload new documents
//     if (_pendingDocs.isNotEmpty) {
//       final records =
//           _pendingDocs.map((d) => {'path': d.path, 'type': d.type}).toList();
//       final uploaded = await controller.uploadMedicalRecords(
//         childId: child.childId,
//         records: records,
//       );
//       if (!uploaded) return;
//     }

//     // Step 3: update replaced existing records
//     for (final entry in _recordReplacements.entries) {
//       final replacement = entry.value;
//       if (replacement == null) continue; // user didn't replace this one
//       await controller.updateMedicalRecord(
//         childId: child.childId,
//         documentId: entry.key,
//         filePath: replacement.path,
//         documentType: replacement.type,
//       );
//     }

//     if (isCreationFlow) {
//       // Creation flow: navigate to Step 3 — documents only screen
//       // (we reuse the health detail screen as the "review + done" page)
//       _snackLocal(
//         'Step 2 Complete ✓',
//         'Health profile saved! Review and finish.',
//         false,
//       );
//       // Navigate to Step 3: the health detail / review screen
//       Get.toNamed(
//         AppRoutes.childHealthDetail,
//         arguments: {
//           'child': child,
//           'isCreationFlow': true,
//         },
//       );
//     } else {
//       // Normal edit flow
//       Get.back(result: true);
//     }
//   }

//   void _snackLocal(String title, String message, bool isError) {
//     Get.snackbar(
//       title,
//       message,
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: isError ? AppColors.errorColor : AppColors.successColor,
//       colorText: AppColors.whiteColor,
//       margin: const EdgeInsets.all(16),
//       borderRadius: 12,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final w = MediaQuery.of(context).size.width;
//     final h = MediaQuery.of(context).size.height;

//     return Scaffold(
//       backgroundColor: AppColors.lightGreyColor,
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             expandedHeight: h * 0.25,
//             pinned: true,
//             elevation: 0,
//             backgroundColor: AppColors.primaryColor,
//             flexibleSpace:
//                 FlexibleSpaceBar(background: _buildHeader(context, w, h)),
//             leading: IconButton(
//               icon: const Icon(Icons.arrow_back, color: AppColors.whiteColor),
//               onPressed: () => Get.back(),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: EdgeInsets.all(w * 0.05),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Step indicator (only in creation flow)
//                     if (isCreationFlow) _buildStepIndicator(context, w, h),
//                     if (isCreationFlow) SizedBox(height: h * 0.025),

//                     // Basic Measurements
//                     _sectionCard(
//                       context,
//                       title: 'Basic Measurements',
//                       icon: Icons.monitor_weight_outlined,
//                       child: Column(
//                         children: [
//                           _buildDropdown(
//                             context,
//                             label: 'Blood Group',
//                             icon: Icons.bloodtype_outlined,
//                             value: _selectedBloodGroup,
//                             items: kBloodGroups,
//                             onChanged: (v) =>
//                                 setState(() => _selectedBloodGroup = v),
//                           ),
//                           SizedBox(height: h * 0.02),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: _buildNumberField(
//                                   context,
//                                   ctrl: _weightCtrl,
//                                   label: 'Weight (kg)',
//                                   hint: 'e.g. 18.5',
//                                   icon: Icons.monitor_weight_outlined,
//                                 ),
//                               ),
//                               SizedBox(width: w * 0.04),
//                               Expanded(
//                                 child: _buildNumberField(
//                                   context,
//                                   ctrl: _heightCtrl,
//                                   label: 'Height (cm)',
//                                   hint: 'e.g. 109.2',
//                                   icon: Icons.height_outlined,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: h * 0.02),

//                     // Medical History
//                     _sectionCard(
//                       context,
//                       title: 'Medical History',
//                       icon: Icons.medical_information_outlined,
//                       child: Column(
//                         children: [
//                           _buildTextField(
//                             context,
//                             ctrl: _allergiesCtrl,
//                             label: 'Known Allergies',
//                             hint: 'e.g. Peanuts, Dust',
//                             icon: Icons.warning_amber_outlined,
//                           ),
//                           SizedBox(height: h * 0.02),
//                           _buildTextField(
//                             context,
//                             ctrl: _geneticCtrl,
//                             label: 'Genetic Disorders',
//                             hint: 'e.g. None',
//                             icon: Icons.biotech_outlined,
//                           ),
//                           SizedBox(height: h * 0.02),
//                           _buildTextField(
//                             context,
//                             ctrl: _chronicCtrl,
//                             label: 'Chronic Conditions',
//                             hint: 'e.g. Mild asthma',
//                             icon: Icons.local_hospital_outlined,
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: h * 0.02),

//                     // Family History
//                     _sectionCard(
//                       context,
//                       title: 'Family History',
//                       icon: Icons.family_restroom_outlined,
//                       child: Column(
//                         children: [
//                           _buildToggle(
//                             context,
//                             label: 'Family History of ASD',
//                             subtitle: 'Autism Spectrum Disorder',
//                             value: _familyHistoryAsd,
//                             onChanged: (v) =>
//                                 setState(() => _familyHistoryAsd = v),
//                           ),
//                           _buildDivider(),
//                           _buildToggle(
//                             context,
//                             label: 'Family History of Speech Disorders',
//                             subtitle: 'Speech or language difficulties',
//                             value: _familyHistorySpeech,
//                             onChanged: (v) =>
//                                 setState(() => _familyHistorySpeech = v),
//                           ),
//                           _buildDivider(),
//                           _buildToggle(
//                             context,
//                             label: 'Family History of Hearing Loss',
//                             subtitle: 'Hearing impairment in family',
//                             value: _familyHistoryHearing,
//                             onChanged: (v) =>
//                                 setState(() => _familyHistoryHearing = v),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: h * 0.02),

//                     // Medical Documents
//                     _sectionCard(
//                       context,
//                       title: 'Medical Documents',
//                       icon: Icons.folder_outlined,
//                       trailing: TextButton.icon(
//                         onPressed: _pickNewDocument,
//                         icon: const Icon(Icons.add,
//                             color: AppColors.primaryColor, size: 18),
//                         label: Text(
//                           'Add PDF',
//                           style: GoogleFonts.poppins(
//                             color: AppColors.primaryColor,
//                             fontSize: w * 0.035,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // ── Existing records (edit mode) ──────────────
//                           if (isEditMode &&
//                               (existingHealth!.medicalRecords ?? [])
//                                   .isNotEmpty) ...[
//                             _existingRecordsLabel(context, w, h),
//                             ...(existingHealth!.medicalRecords ?? []).map(
//                               (r) => _buildExistingRecordTile(
//                                   context, r, w, h),
//                             ),
//                             if (_pendingDocs.isNotEmpty)
//                               Padding(
//                                 padding:
//                                     EdgeInsets.only(top: h * 0.015, bottom: h * 0.008),
//                                 child: Text(
//                                   'New documents to upload',
//                                   style: GoogleFonts.poppins(
//                                     fontSize: w * 0.034,
//                                     fontWeight: FontWeight.w600,
//                                     color: AppColors.textSecondaryColor,
//                                   ),
//                                 ),
//                               ),
//                           ],

//                           // ── Pending new docs ──────────────────────────
//                           if (_pendingDocs.isEmpty &&
//                               (existingHealth?.medicalRecords ?? []).isEmpty)
//                             _buildEmptyDocsHint(context, w, h)
//                           else
//                             ...List.generate(
//                               _pendingDocs.length,
//                               (i) => _buildPendingDocTile(context, i, w, h),
//                             ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: h * 0.04),

//                     // Submit button
//                     Obx(() => CustomButton(
//                           title: isCreationFlow
//                               ? 'Save & Continue →'
//                               : isEditMode
//                                   ? 'Update Health Profile'
//                                   : 'Save Health Profile',
//                           height: h * 0.065,
//                           width: double.infinity,
//                           radius: 15,
//                           color: AppColors.primaryColor,
//                           loading: controller.isSaving.value ||
//                               controller.isUploading.value,
//                           onTap: _handleSubmit,
//                         )),
//                     SizedBox(height: h * 0.04),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ── Step indicator ───────────────────────────────────────────────────────
//   Widget _buildStepIndicator(BuildContext context, double w, double h) {
//     return Row(
//       children: [
//         _stepBadge(1, 'Child Info', done: true, active: false, w: w),
//         Expanded(
//           child: Container(height: 2, color: AppColors.primaryColor),
//         ),
//         _stepBadge(2, 'Health Profile', done: false, active: true, w: w),
//         Expanded(
//           child: Container(
//               height: 2, color: AppColors.greyColor.withOpacity(0.3)),
//         ),
//         _stepBadge(3, 'Review', done: false, active: false, w: w),
//       ],
//     );
//   }

//   Widget _stepBadge(int step, String label,
//       {required bool done, required bool active, required double w}) {
//     final color = done || active
//         ? AppColors.primaryColor
//         : AppColors.greyColor.withOpacity(0.4);
//     return Column(
//       children: [
//         Container(
//           width: 30,
//           height: 30,
//           decoration: BoxDecoration(color: color, shape: BoxShape.circle),
//           alignment: Alignment.center,
//           child: done
//               ? const Icon(Icons.check, color: Colors.white, size: 16)
//               : Text(
//                   '$step',
//                   style: GoogleFonts.poppins(
//                     color: active
//                         ? AppColors.whiteColor
//                         : AppColors.greyColor,
//                     fontSize: w * 0.032,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           label,
//           style: GoogleFonts.poppins(
//             fontSize: w * 0.026,
//             color: active ? AppColors.primaryColor : AppColors.greyColor,
//             fontWeight: active ? FontWeight.w600 : FontWeight.normal,
//           ),
//         ),
//       ],
//     );
//   }

//   // ── Existing records label ────────────────────────────────────────────────
//   Widget _existingRecordsLabel(BuildContext context, double w, double h) {
//     final count = (existingHealth?.medicalRecords ?? []).length;
//     return Padding(
//       padding: EdgeInsets.only(bottom: h * 0.01),
//       child: Row(
//         children: [
//           Text(
//             'Existing Documents ($count)',
//             style: GoogleFonts.poppins(
//               fontSize: w * 0.034,
//               fontWeight: FontWeight.w600,
//               color: AppColors.textSecondaryColor,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ── Existing record tile with optional replacement ────────────────────────
//   Widget _buildExistingRecordTile(
//       BuildContext context, MedicalRecord record, double w, double h) {
//     final replacement = _recordReplacements[record.documentId];
//     return Container(
//       margin: EdgeInsets.only(bottom: h * 0.012),
//       padding: EdgeInsets.all(w * 0.035),
//       decoration: BoxDecoration(
//         color: replacement != null
//             ? AppColors.primaryColor.withOpacity(0.05)
//             : AppColors.lightGreyColor,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           color: replacement != null
//               ? AppColors.primaryColor.withOpacity(0.4)
//               : AppColors.greyColor.withOpacity(0.2),
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 width: 40,
//                 height: 40,
//                 decoration: BoxDecoration(
//                   color: AppColors.primaryColor.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: const Icon(Icons.picture_as_pdf,
//                     color: AppColors.primaryColor, size: 20),
//               ),
//               SizedBox(width: w * 0.03),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       replacement != null ? replacement.name : record.fileName,
//                       style: GoogleFonts.poppins(
//                         fontSize: w * 0.034,
//                         fontWeight: FontWeight.w500,
//                         color: AppColors.textPrimaryColor,
//                       ),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     SizedBox(height: 2),
//                     Row(
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 6, vertical: 2),
//                           decoration: BoxDecoration(
//                             color: AppColors.primaryColor.withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                           child: Text(
//                             record.getDocumentTypeDisplay(),
//                             style: GoogleFonts.poppins(
//                               fontSize: w * 0.026,
//                               color: AppColors.primaryColor,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                         if (replacement != null) ...[
//                           SizedBox(width: w * 0.02),
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 6, vertical: 2),
//                             decoration: BoxDecoration(
//                               color: AppColors.successColor.withOpacity(0.1),
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                             child: Text(
//                               'Will be replaced',
//                               style: GoogleFonts.poppins(
//                                 fontSize: w * 0.026,
//                                 color: AppColors.successColor,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               // Replace button
//               GestureDetector(
//                 onTap: () => _pickReplacementForRecord(record.documentId),
//                 child: Container(
//                   padding:
//                       EdgeInsets.symmetric(horizontal: w * 0.025, vertical: 6),
//                   decoration: BoxDecoration(
//                     color: AppColors.primaryColor.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(8),
//                     border: Border.all(
//                         color: AppColors.primaryColor.withOpacity(0.3)),
//                   ),
//                   child: Text(
//                     replacement != null ? 'Change' : 'Replace',
//                     style: GoogleFonts.poppins(
//                       fontSize: w * 0.028,
//                       color: AppColors.primaryColor,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           // Replacement doc type selector
//           if (replacement != null) ...[
//             SizedBox(height: h * 0.012),
//             DropdownButtonFormField<String>(
//               value: replacement.type,
//               style: GoogleFonts.poppins(
//                   fontSize: w * 0.035, color: AppColors.textPrimaryColor),
//               dropdownColor: AppColors.whiteColor,
//               borderRadius: BorderRadius.circular(12),
//               decoration: InputDecoration(
//                 prefixIcon: const Icon(Icons.category_outlined,
//                     color: AppColors.primaryColor, size: 18),
//                 isDense: true,
//                 filled: true,
//                 fillColor: AppColors.whiteColor,
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: BorderSide.none),
//                 contentPadding: EdgeInsets.symmetric(
//                     vertical: h * 0.012, horizontal: w * 0.03),
//               ),
//               items: kDocumentTypes
//                   .map((t) => DropdownMenuItem(
//                         value: t,
//                         child: Text(_formatDocType(t),
//                             style: GoogleFonts.poppins(fontSize: w * 0.035)),
//                       ))
//                   .toList(),
//               onChanged: (v) => setState(() {
//                 _recordReplacements[record.documentId] = _ReplacementDoc(
//                   path: replacement.path,
//                   name: replacement.name,
//                   type: v ?? replacement.type,
//                 );
//               }),
//             ),
//             Align(
//               alignment: Alignment.centerRight,
//               child: TextButton(
//                 onPressed: () =>
//                     setState(() => _recordReplacements[record.documentId] = null),
//                 child: Text(
//                   'Keep original',
//                   style: GoogleFonts.poppins(
//                     fontSize: w * 0.03,
//                     color: AppColors.textSecondaryColor,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }

//   // ── Pending new doc tile ─────────────────────────────────────────────────
//   Widget _buildPendingDocTile(
//       BuildContext context, int index, double w, double h) {
//     final doc = _pendingDocs[index];
//     return Container(
//       margin: EdgeInsets.only(bottom: h * 0.012),
//       padding: EdgeInsets.all(w * 0.035),
//       decoration: BoxDecoration(
//         color: AppColors.lightGreyColor,
//         borderRadius: BorderRadius.circular(12),
//         border:
//             Border.all(color: AppColors.primaryColor.withOpacity(0.2)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 width: 40,
//                 height: 40,
//                 decoration: BoxDecoration(
//                   color: AppColors.primaryColor.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: const Icon(Icons.picture_as_pdf,
//                     color: AppColors.primaryColor, size: 22),
//               ),
//               SizedBox(width: w * 0.03),
//               Expanded(
//                 child: Text(
//                   doc.name,
//                   style: GoogleFonts.poppins(
//                     fontSize: w * 0.035,
//                     fontWeight: FontWeight.w500,
//                     color: AppColors.textPrimaryColor,
//                   ),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//               IconButton(
//                 icon:
//                     const Icon(Icons.close, color: AppColors.errorColor, size: 20),
//                 onPressed: () =>
//                     setState(() => _pendingDocs.removeAt(index)),
//                 padding: EdgeInsets.zero,
//                 constraints: const BoxConstraints(),
//               ),
//             ],
//           ),
//           SizedBox(height: h * 0.012),
//           DropdownButtonFormField<String>(
//             value: doc.type,
//             style: GoogleFonts.poppins(
//                 fontSize: w * 0.035, color: AppColors.textPrimaryColor),
//             dropdownColor: AppColors.whiteColor,
//             borderRadius: BorderRadius.circular(12),
//             decoration: InputDecoration(
//               prefixIcon: const Icon(Icons.category_outlined,
//                   color: AppColors.primaryColor, size: 18),
//               isDense: true,
//               filled: true,
//               fillColor: AppColors.whiteColor,
//               border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide: BorderSide.none),
//               contentPadding: EdgeInsets.symmetric(
//                   vertical: h * 0.012, horizontal: w * 0.03),
//             ),
//             items: kDocumentTypes
//                 .map((t) => DropdownMenuItem(
//                       value: t,
//                       child: Text(_formatDocType(t),
//                           style: GoogleFonts.poppins(fontSize: w * 0.035)),
//                     ))
//                 .toList(),
//             onChanged: (v) => setState(() => _pendingDocs[index] =
//                 _PendingDocument(
//                     path: doc.path,
//                     name: doc.name,
//                     type: v ?? doc.type)),
//           ),
//         ],
//       ),
//     );
//   }

//   // ── Header ────────────────────────────────────────────────────────────────
//   Widget _buildHeader(BuildContext context, double w, double h) {
//     String subtitle;
//     if (isCreationFlow) {
//       subtitle = 'Step 2 of 3 · Health Information';
//     } else if (isEditMode) {
//       subtitle = child.childName;
//     } else {
//       subtitle = child.childName;
//     }

//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [AppColors.primaryColor, AppColors.secondaryColor],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       child: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.all(w * 0.05),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 width: 75,
//                 height: 75,
//                 decoration: BoxDecoration(
//                   color: AppColors.whiteColor.withOpacity(0.2),
//                   shape: BoxShape.circle,
//                 ),
//                 child: const Icon(Icons.medical_services_rounded,
//                     size: 40, color: AppColors.whiteColor),
//               ),
//               SizedBox(height: h * 0.015),
//               Text(
//                 isEditMode ? 'Edit Health Profile' : 'Health Profile',
//                 style: GoogleFonts.poppins(
//                   color: AppColors.whiteColor,
//                   fontSize: w * 0.055,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 0.5,
//                 ),
//               ),
//               SizedBox(height: h * 0.005),
//               Text(
//                 subtitle,
//                 style: GoogleFonts.poppins(
//                   color: AppColors.whiteColor.withOpacity(0.9),
//                   fontSize: w * 0.038,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // ── Section card wrapper ──────────────────────────────────────────────────
//   Widget _sectionCard(
//     BuildContext context, {
//     required String title,
//     required IconData icon,
//     required Widget child,
//     Widget? trailing,
//   }) {
//     final w = MediaQuery.of(context).size.width;
//     final h = MediaQuery.of(context).size.height;
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(w * 0.045),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Container(
//                   width: 38,
//                   height: 38,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(colors: [
//                       AppColors.primaryColor.withOpacity(0.15),
//                       AppColors.secondaryColor.withOpacity(0.08),
//                     ]),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Icon(icon, color: AppColors.primaryColor, size: 20),
//                 ),
//                 SizedBox(width: w * 0.03),
//                 Expanded(
//                   child: Text(
//                     title,
//                     style: GoogleFonts.poppins(
//                       fontSize: w * 0.042,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.textPrimaryColor,
//                     ),
//                   ),
//                 ),
//                 if (trailing != null) trailing,
//               ],
//             ),
//             SizedBox(height: h * 0.02),
//             child,
//           ],
//         ),
//       ),
//     );
//   }

//   // ── Text field ────────────────────────────────────────────────────────────
//   Widget _buildTextField(
//     BuildContext context, {
//     required TextEditingController ctrl,
//     required String label,
//     required String hint,
//     required IconData icon,
//   }) {
//     final w = MediaQuery.of(context).size.width;
//     final h = MediaQuery.of(context).size.height;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: GoogleFonts.poppins(
//             fontSize: w * 0.037,
//             fontWeight: FontWeight.w500,
//             color: AppColors.textSecondaryColor,
//           ),
//         ),
//         SizedBox(height: h * 0.008),
//         TextFormField(
//           controller: ctrl,
//           style: GoogleFonts.poppins(
//               fontSize: w * 0.038, color: AppColors.textPrimaryColor),
//           cursorColor: AppColors.primaryColor,
//           decoration: _inputDecoration(context, hint: hint, icon: icon),
//         ),
//       ],
//     );
//   }

//   // ── Number field ──────────────────────────────────────────────────────────
//   Widget _buildNumberField(
//     BuildContext context, {
//     required TextEditingController ctrl,
//     required String label,
//     required String hint,
//     required IconData icon,
//   }) {
//     final w = MediaQuery.of(context).size.width;
//     final h = MediaQuery.of(context).size.height;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: GoogleFonts.poppins(
//             fontSize: w * 0.033,
//             fontWeight: FontWeight.w500,
//             color: AppColors.textSecondaryColor,
//           ),
//         ),
//         SizedBox(height: h * 0.008),
//         TextFormField(
//           controller: ctrl,
//           keyboardType:
//               const TextInputType.numberWithOptions(decimal: true),
//           inputFormatters: [
//             FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
//           ],
//           style: GoogleFonts.poppins(
//               fontSize: w * 0.038, color: AppColors.textPrimaryColor),
//           cursorColor: AppColors.primaryColor,
//           decoration: _inputDecoration(context, hint: hint, icon: icon),
//         ),
//       ],
//     );
//   }

//   // ── Dropdown ──────────────────────────────────────────────────────────────
//   Widget _buildDropdown(
//     BuildContext context, {
//     required String label,
//     required IconData icon,
//     required String? value,
//     required List<String> items,
//     required ValueChanged<String?> onChanged,
//   }) {
//     final w = MediaQuery.of(context).size.width;
//     final h = MediaQuery.of(context).size.height;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: GoogleFonts.poppins(
//             fontSize: w * 0.037,
//             fontWeight: FontWeight.w500,
//             color: AppColors.textSecondaryColor,
//           ),
//         ),
//         SizedBox(height: h * 0.008),
//         DropdownButtonFormField<String>(
//           value: value,
//           style: GoogleFonts.poppins(
//               fontSize: w * 0.038, color: AppColors.textPrimaryColor),
//           decoration:
//               _inputDecoration(context, hint: 'Select blood group', icon: icon),
//           dropdownColor: AppColors.whiteColor,
//           borderRadius: BorderRadius.circular(15),
//           items: items
//               .map((g) => DropdownMenuItem(
//                     value: g,
//                     child: Text(g,
//                         style: GoogleFonts.poppins(fontSize: w * 0.038)),
//                   ))
//               .toList(),
//           onChanged: onChanged,
//         ),
//       ],
//     );
//   }

//   // ── Toggle ────────────────────────────────────────────────────────────────
//   Widget _buildToggle(
//     BuildContext context, {
//     required String label,
//     required String subtitle,
//     required bool value,
//     required ValueChanged<bool> onChanged,
//   }) {
//     final w = MediaQuery.of(context).size.width;
//     return Row(
//       children: [
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 label,
//                 style: GoogleFonts.poppins(
//                   fontSize: w * 0.038,
//                   fontWeight: FontWeight.w500,
//                   color: AppColors.textPrimaryColor,
//                 ),
//               ),
//               Text(
//                 subtitle,
//                 style: GoogleFonts.poppins(
//                   fontSize: w * 0.032,
//                   color: AppColors.textSecondaryColor,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Switch(
//           value: value,
//           onChanged: onChanged,
//           activeColor: AppColors.primaryColor,
//         ),
//       ],
//     );
//   }

//   Widget _buildDivider() => Padding(
//         padding: const EdgeInsets.symmetric(vertical: 10),
//         child: Divider(
//             color: AppColors.greyColor.withOpacity(0.2), height: 1),
//       );

//   Widget _buildEmptyDocsHint(BuildContext context, double w, double h) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: h * 0.03),
//       alignment: Alignment.center,
//       child: Column(
//         children: [
//           Icon(Icons.upload_file_outlined,
//               color: AppColors.greyColor, size: 44),
//           SizedBox(height: h * 0.01),
//           Text(
//             'No documents added',
//             style: GoogleFonts.poppins(
//               color: AppColors.textSecondaryColor,
//               fontSize: w * 0.036,
//             ),
//           ),
//           SizedBox(height: h * 0.005),
//           Text(
//             'Tap "Add PDF" to upload medical records',
//             style: GoogleFonts.poppins(
//               color: AppColors.greyColor,
//               fontSize: w * 0.032,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   InputDecoration _inputDecoration(BuildContext context,
//       {required String hint, required IconData icon}) {
//     final w = MediaQuery.of(context).size.width;
//     final h = MediaQuery.of(context).size.height;
//     return InputDecoration(
//       prefixIcon: Icon(icon, color: AppColors.primaryColor),
//       hintText: hint,
//       hintStyle:
//           GoogleFonts.poppins(color: AppColors.greyColor, fontSize: w * 0.037),
//       filled: true,
//       fillColor: AppColors.lightGreyColor,
//       border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
//       enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
//       focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(14),
//           borderSide:
//               const BorderSide(color: AppColors.primaryColor, width: 2)),
//       contentPadding:
//           EdgeInsets.symmetric(vertical: h * 0.018, horizontal: w * 0.04),
//     );
//   }

//   String _formatDocType(String type) {
//     return type
//         .split('_')
//         .map((w) => w[0].toUpperCase() + w.substring(1))
//         .join(' ');
//   }
// }

// // ── Data classes ─────────────────────────────────────────────────────────────
// class _PendingDocument {
//   final String path;
//   final String name;
//   final String type;
//   _PendingDocument(
//       {required this.path, required this.name, required this.type});
// }

// class _ReplacementDoc {
//   final String path;
//   final String name;
//   final String type;
//   _ReplacementDoc(
//       {required this.path, required this.name, required this.type});
// }


// lib/view/children/child_health_profile_screen.dart
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/components/custom_button.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/controllers/child_controller.dart';
import 'package:speechspectrum/controllers/child_health_controller.dart';
import 'package:speechspectrum/models/child_health_model.dart';
import 'package:speechspectrum/models/child_model.dart';
import 'package:speechspectrum/routes/app_routes.dart';

const List<String> kDocumentTypes = [
  'lab_result',
  'prescription',
  'hearing_test',
  'vision_test',
  'previous_report',
  'referral_letter',
  'school_report',
  'other',
];

const List<String> kBloodGroups = [
  'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-',
];

class ChildHealthProfileScreen extends StatefulWidget {
  const ChildHealthProfileScreen({super.key});

  @override
  State<ChildHealthProfileScreen> createState() =>
      _ChildHealthProfileScreenState();
}

class _ChildHealthProfileScreenState
    extends State<ChildHealthProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late ChildHealthController controller;
  late ChildData child;
  ChildHealthData? existingHealth;

  /// true  → came from Step 1 (create child flow) — Step 2 of 3
  /// false → standalone edit from child detail screen
  bool isCreationFlow = false;

  bool get isEditMode => existingHealth != null;

  // ── Form controllers ────────────────────────────────────────────────────
  final _allergiesCtrl = TextEditingController();
  final _geneticCtrl = TextEditingController();
  final _chronicCtrl = TextEditingController();
  final _weightCtrl = TextEditingController();
  final _heightCtrl = TextEditingController();

  String? _selectedBloodGroup;
  bool _familyHistoryAsd = false;
  bool _familyHistorySpeech = false;
  bool _familyHistoryHearing = false;

  // ── Documents: pending new uploads ─────────────────────────────────────
  final List<_PendingDocument> _pendingDocs = [];

  // ── Existing records (edit mode): track which ones user wants to replace
  // key = documentId, value = new file path (null = keep original)
  final Map<String, _ReplacementDoc?> _recordReplacements = {};

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>;
    child = args['child'] as ChildData;
    existingHealth = args['healthData'] as ChildHealthData?;
    isCreationFlow = (args['isCreationFlow'] as bool?) ?? false;

    controller = Get.isRegistered<ChildHealthController>()
        ? Get.find<ChildHealthController>()
        : Get.put(ChildHealthController());

    // ── Pre-fill fields from existing data ──────────────────────────────
    if (existingHealth != null) {
      _selectedBloodGroup = existingHealth!.bloodGroup;
      _allergiesCtrl.text = existingHealth!.knownAllergies ?? '';
      _geneticCtrl.text = existingHealth!.geneticDisorders ?? '';
      _chronicCtrl.text = existingHealth!.chronicConditions ?? '';
      _weightCtrl.text = existingHealth!.weightKg != null
          ? existingHealth!.weightKg.toString()
          : '';
      _heightCtrl.text = existingHealth!.heightCm != null
          ? existingHealth!.heightCm.toString()
          : '';
      _familyHistoryAsd = existingHealth!.familyHistoryAsd;
      _familyHistorySpeech = existingHealth!.familyHistorysSpeechDisorders;
      _familyHistoryHearing = existingHealth!.familyHistoryHearingLoss;

      // Initialise replacement map with nulls (= keep original)
      for (final r
          in existingHealth!.medicalRecords ?? <MedicalRecord>[]) {
        _recordReplacements[r.documentId] = null;
      }
    }
  }

  @override
  void dispose() {
    _allergiesCtrl.dispose();
    _geneticCtrl.dispose();
    _chronicCtrl.dispose();
    _weightCtrl.dispose();
    _heightCtrl.dispose();
    super.dispose();
  }

  // ── Pick a brand-new document to add ────────────────────────────────────
  Future<void> _pickNewDocument() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: false,
    );
    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;
      setState(() {
        _pendingDocs.add(
          _PendingDocument(
              path: file.path!, name: file.name, type: 'other'),
        );
      });
    }
  }

  // ── Pick a replacement for an existing record ────────────────────────────
  Future<void> _pickReplacementForRecord(String documentId) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: false,
    );
    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;
      setState(() {
        _recordReplacements[documentId] =
            _ReplacementDoc(path: file.path!, name: file.name, type: 'other');
      });
    }
  }

  // ── Submit handler ───────────────────────────────────────────────────────
  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final data = <String, dynamic>{
      if (_selectedBloodGroup != null) 'blood_group': _selectedBloodGroup,
      'known_allergies': _allergiesCtrl.text.trim(),
      'family_history_asd': _familyHistoryAsd,
      'family_history_speech_disorders': _familyHistorySpeech,
      'family_history_hearing_loss': _familyHistoryHearing,
      'genetic_disorders': _geneticCtrl.text.trim(),
      'chronic_conditions': _chronicCtrl.text.trim(),
      if (_weightCtrl.text.trim().isNotEmpty)
        'weight_kg': double.tryParse(_weightCtrl.text.trim()),
      if (_heightCtrl.text.trim().isNotEmpty)
        'height_cm': double.tryParse(_heightCtrl.text.trim()),
    };

    // Step 1: save / update core health profile
    final saved = await controller.saveHealthProfile(
      childId: child.childId,
      data: data,
      isUpdate: isEditMode,
    );
    if (!saved) return;

    // Step 2: upload new documents
    if (_pendingDocs.isNotEmpty) {
      final records =
          _pendingDocs.map((d) => {'path': d.path, 'type': d.type}).toList();
      final uploaded = await controller.uploadMedicalRecords(
        childId: child.childId,
        records: records,
      );
      if (!uploaded) return;
    }

    // Step 3: update replaced existing records
    for (final entry in _recordReplacements.entries) {
      final replacement = entry.value;
      if (replacement == null) continue; // user didn't replace this one
      await controller.updateMedicalRecord(
        childId: child.childId,
        documentId: entry.key,
        filePath: replacement.path,
        documentType: replacement.type,
      );
    }

    if (isCreationFlow) {
      // Creation flow Step 2 → Step 3 (review screen)
      _snackLocal(
        'Step 2 Complete ✓',
        'Health profile saved! Review and finish.',
        false,
      );
      Get.toNamed(
        AppRoutes.childHealthDetail,
        arguments: {
          'child': child,
          'isCreationFlow': true,
        },
      );
    } else {
      // ── Normal edit flow ────────────────────────────────────────────────
      // Pop this edit screen and return true so the health detail screen
      // (which awaited this navigation) knows to re-fetch.
      Get.back(result: true);
    }
  }

  void _snackLocal(String title, String message, bool isError) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isError ? AppColors.errorColor : AppColors.successColor,
      colorText: AppColors.whiteColor,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: h * 0.25,
            pinned: true,
            elevation: 0,
            backgroundColor: AppColors.primaryColor,
            flexibleSpace: FlexibleSpaceBar(
                background: _buildHeader(context, w, h)),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back,
                  color: AppColors.whiteColor),
              onPressed: () => Get.back(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(w * 0.05),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Step indicator (only in creation flow)
                    if (isCreationFlow) _buildStepIndicator(context, w, h),
                    if (isCreationFlow) SizedBox(height: h * 0.025),

                    // Basic Measurements
                    _sectionCard(
                      context,
                      title: 'Basic Measurements',
                      icon: Icons.monitor_weight_outlined,
                      child: Column(
                        children: [
                          _buildDropdown(
                            context,
                            label: 'Blood Group',
                            icon: Icons.bloodtype_outlined,
                            value: _selectedBloodGroup,
                            items: kBloodGroups,
                            onChanged: (v) =>
                                setState(() => _selectedBloodGroup = v),
                          ),
                          SizedBox(height: h * 0.02),
                          Row(
                            children: [
                              Expanded(
                                child: _buildNumberField(
                                  context,
                                  ctrl: _weightCtrl,
                                  label: 'Weight (kg)',
                                  hint: 'e.g. 18.5',
                                  icon: Icons.monitor_weight_outlined,
                                ),
                              ),
                              SizedBox(width: w * 0.04),
                              Expanded(
                                child: _buildNumberField(
                                  context,
                                  ctrl: _heightCtrl,
                                  label: 'Height (cm)',
                                  hint: 'e.g. 109.2',
                                  icon: Icons.height_outlined,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: h * 0.02),

                    // Medical History
                    _sectionCard(
                      context,
                      title: 'Medical History',
                      icon: Icons.medical_information_outlined,
                      child: Column(
                        children: [
                          _buildTextField(
                            context,
                            ctrl: _allergiesCtrl,
                            label: 'Known Allergies',
                            hint: 'e.g. Peanuts, Dust',
                            icon: Icons.warning_amber_outlined,
                          ),
                          SizedBox(height: h * 0.02),
                          _buildTextField(
                            context,
                            ctrl: _geneticCtrl,
                            label: 'Genetic Disorders',
                            hint: 'e.g. None',
                            icon: Icons.biotech_outlined,
                          ),
                          SizedBox(height: h * 0.02),
                          _buildTextField(
                            context,
                            ctrl: _chronicCtrl,
                            label: 'Chronic Conditions',
                            hint: 'e.g. Mild asthma',
                            icon: Icons.local_hospital_outlined,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: h * 0.02),

                    // Family History
                    _sectionCard(
                      context,
                      title: 'Family History',
                      icon: Icons.family_restroom_outlined,
                      child: Column(
                        children: [
                          _buildToggle(
                            context,
                            label: 'Family History of ASD',
                            subtitle: 'Autism Spectrum Disorder',
                            value: _familyHistoryAsd,
                            onChanged: (v) =>
                                setState(() => _familyHistoryAsd = v),
                          ),
                          _buildDivider(),
                          _buildToggle(
                            context,
                            label:
                                'Family History of Speech Disorders',
                            subtitle: 'Speech or language difficulties',
                            value: _familyHistorySpeech,
                            onChanged: (v) =>
                                setState(() => _familyHistorySpeech = v),
                          ),
                          _buildDivider(),
                          _buildToggle(
                            context,
                            label: 'Family History of Hearing Loss',
                            subtitle: 'Hearing impairment in family',
                            value: _familyHistoryHearing,
                            onChanged: (v) =>
                                setState(() => _familyHistoryHearing = v),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: h * 0.02),

                    // Medical Documents
                    _sectionCard(
                      context,
                      title: 'Medical Documents',
                      icon: Icons.folder_outlined,
                      trailing: TextButton.icon(
                        onPressed: _pickNewDocument,
                        icon: const Icon(Icons.add,
                            color: AppColors.primaryColor, size: 18),
                        label: Text(
                          'Add PDF',
                          style: GoogleFonts.poppins(
                            color: AppColors.primaryColor,
                            fontSize: w * 0.035,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ── Existing records (edit mode) ──────────────
                          if (isEditMode &&
                              (existingHealth!.medicalRecords ?? [])
                                  .isNotEmpty) ...[
                            _existingRecordsLabel(context, w, h),
                            ...(existingHealth!.medicalRecords ?? [])
                                .map(
                              (r) => _buildExistingRecordTile(
                                  context, r, w, h),
                            ),
                            if (_pendingDocs.isNotEmpty)
                              Padding(
                                padding: EdgeInsets.only(
                                    top: h * 0.015,
                                    bottom: h * 0.008),
                                child: Text(
                                  'New documents to upload',
                                  style: GoogleFonts.poppins(
                                    fontSize: w * 0.034,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textSecondaryColor,
                                  ),
                                ),
                              ),
                          ],

                          // ── Pending new docs ──────────────────────────
                          if (_pendingDocs.isEmpty &&
                              (existingHealth?.medicalRecords ?? [])
                                  .isEmpty)
                            _buildEmptyDocsHint(context, w, h)
                          else
                            ...List.generate(
                              _pendingDocs.length,
                              (i) =>
                                  _buildPendingDocTile(context, i, w, h),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: h * 0.04),

                    // Submit button
                    Obx(() => CustomButton(
                          title: isCreationFlow
                              ? 'Save & Continue →'
                              : isEditMode
                                  ? 'Update Health Profile'
                                  : 'Save Health Profile',
                          height: h * 0.065,
                          width: double.infinity,
                          radius: 15,
                          color: AppColors.primaryColor,
                          loading: controller.isSaving.value ||
                              controller.isUploading.value,
                          onTap: _handleSubmit,
                        )),
                    SizedBox(height: h * 0.04),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Step indicator ───────────────────────────────────────────────────────
  Widget _buildStepIndicator(BuildContext context, double w, double h) {
    return Row(
      children: [
        _stepBadge(1, 'Child Info', done: true, active: false, w: w),
        Expanded(
          child: Container(height: 2, color: AppColors.primaryColor),
        ),
        _stepBadge(2, 'Health Profile',
            done: false, active: true, w: w),
        Expanded(
          child: Container(
              height: 2,
              color: AppColors.greyColor.withOpacity(0.3)),
        ),
        _stepBadge(3, 'Review', done: false, active: false, w: w),
      ],
    );
  }

  Widget _stepBadge(int step, String label,
      {required bool done, required bool active, required double w}) {
    final color = done || active
        ? AppColors.primaryColor
        : AppColors.greyColor.withOpacity(0.4);
    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration:
              BoxDecoration(color: color, shape: BoxShape.circle),
          alignment: Alignment.center,
          child: done
              ? const Icon(Icons.check, color: Colors.white, size: 16)
              : Text(
                  '$step',
                  style: GoogleFonts.poppins(
                    color: active
                        ? AppColors.whiteColor
                        : AppColors.greyColor,
                    fontSize: w * 0.032,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: w * 0.026,
            color:
                active ? AppColors.primaryColor : AppColors.greyColor,
            fontWeight:
                active ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  // ── Existing records label ────────────────────────────────────────────────
  Widget _existingRecordsLabel(
      BuildContext context, double w, double h) {
    final count = (existingHealth?.medicalRecords ?? []).length;
    return Padding(
      padding: EdgeInsets.only(bottom: h * 0.01),
      child: Row(
        children: [
          Text(
            'Existing Documents ($count)',
            style: GoogleFonts.poppins(
              fontSize: w * 0.034,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }

  // ── Existing record tile with optional replacement ────────────────────────
  Widget _buildExistingRecordTile(
      BuildContext context, MedicalRecord record, double w, double h) {
    final replacement = _recordReplacements[record.documentId];
    return Container(
      margin: EdgeInsets.only(bottom: h * 0.012),
      padding: EdgeInsets.all(w * 0.035),
      decoration: BoxDecoration(
        color: replacement != null
            ? AppColors.primaryColor.withOpacity(0.05)
            : AppColors.lightGreyColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: replacement != null
              ? AppColors.primaryColor.withOpacity(0.4)
              : AppColors.greyColor.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.picture_as_pdf,
                    color: AppColors.primaryColor, size: 20),
              ),
              SizedBox(width: w * 0.03),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      replacement != null
                          ? replacement.name
                          : record.fileName,
                      style: GoogleFonts.poppins(
                        fontSize: w * 0.034,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimaryColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color:
                                AppColors.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            record.getDocumentTypeDisplay(),
                            style: GoogleFonts.poppins(
                              fontSize: w * 0.026,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        if (replacement != null) ...[
                          SizedBox(width: w * 0.02),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.successColor
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              'Will be replaced',
                              style: GoogleFonts.poppins(
                                fontSize: w * 0.026,
                                color: AppColors.successColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              // Replace button
              GestureDetector(
                onTap: () =>
                    _pickReplacementForRecord(record.documentId),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: w * 0.025, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color:
                            AppColors.primaryColor.withOpacity(0.3)),
                  ),
                  child: Text(
                    replacement != null ? 'Change' : 'Replace',
                    style: GoogleFonts.poppins(
                      fontSize: w * 0.028,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Replacement doc type selector
          if (replacement != null) ...[
            SizedBox(height: h * 0.012),
            DropdownButtonFormField<String>(
              value: replacement.type,
              style: GoogleFonts.poppins(
                  fontSize: w * 0.035,
                  color: AppColors.textPrimaryColor),
              dropdownColor: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(12),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.category_outlined,
                    color: AppColors.primaryColor, size: 18),
                isDense: true,
                filled: true,
                fillColor: AppColors.whiteColor,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
                contentPadding: EdgeInsets.symmetric(
                    vertical: h * 0.012, horizontal: w * 0.03),
              ),
              items: kDocumentTypes
                  .map((t) => DropdownMenuItem(
                        value: t,
                        child: Text(_formatDocType(t),
                            style: GoogleFonts.poppins(
                                fontSize: w * 0.035)),
                      ))
                  .toList(),
              onChanged: (v) => setState(() {
                _recordReplacements[record.documentId] =
                    _ReplacementDoc(
                  path: replacement.path,
                  name: replacement.name,
                  type: v ?? replacement.type,
                );
              }),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => setState(
                    () => _recordReplacements[record.documentId] = null),
                child: Text(
                  'Keep original',
                  style: GoogleFonts.poppins(
                    fontSize: w * 0.03,
                    color: AppColors.textSecondaryColor,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ── Pending new doc tile ─────────────────────────────────────────────────
  Widget _buildPendingDocTile(
      BuildContext context, int index, double w, double h) {
    final doc = _pendingDocs[index];
    return Container(
      margin: EdgeInsets.only(bottom: h * 0.012),
      padding: EdgeInsets.all(w * 0.035),
      decoration: BoxDecoration(
        color: AppColors.lightGreyColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: AppColors.primaryColor.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.picture_as_pdf,
                    color: AppColors.primaryColor, size: 22),
              ),
              SizedBox(width: w * 0.03),
              Expanded(
                child: Text(
                  doc.name,
                  style: GoogleFonts.poppins(
                    fontSize: w * 0.035,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimaryColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close,
                    color: AppColors.errorColor, size: 20),
                onPressed: () =>
                    setState(() => _pendingDocs.removeAt(index)),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          SizedBox(height: h * 0.012),
          DropdownButtonFormField<String>(
            value: doc.type,
            style: GoogleFonts.poppins(
                fontSize: w * 0.035,
                color: AppColors.textPrimaryColor),
            dropdownColor: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(12),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.category_outlined,
                  color: AppColors.primaryColor, size: 18),
              isDense: true,
              filled: true,
              fillColor: AppColors.whiteColor,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              contentPadding: EdgeInsets.symmetric(
                  vertical: h * 0.012, horizontal: w * 0.03),
            ),
            items: kDocumentTypes
                .map((t) => DropdownMenuItem(
                      value: t,
                      child: Text(_formatDocType(t),
                          style:
                              GoogleFonts.poppins(fontSize: w * 0.035)),
                    ))
                .toList(),
            onChanged: (v) => setState(() => _pendingDocs[index] =
                _PendingDocument(
                    path: doc.path,
                    name: doc.name,
                    type: v ?? doc.type)),
          ),
        ],
      ),
    );
  }

  // ── Header ────────────────────────────────────────────────────────────────
  Widget _buildHeader(BuildContext context, double w, double h) {
    String subtitle;
    if (isCreationFlow) {
      subtitle = 'Step 2 of 3 · Health Information';
    } else {
      subtitle = child.childName;
    }

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryColor, AppColors.secondaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(w * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.medical_services_rounded,
                    size: 40, color: AppColors.whiteColor),
              ),
              SizedBox(height: h * 0.015),
              Text(
                isEditMode ? 'Edit Health Profile' : 'Health Profile',
                style: GoogleFonts.poppins(
                  color: AppColors.whiteColor,
                  fontSize: w * 0.055,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: h * 0.005),
              Text(
                subtitle,
                style: GoogleFonts.poppins(
                  color: AppColors.whiteColor.withOpacity(0.9),
                  fontSize: w * 0.038,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Section card wrapper ──────────────────────────────────────────────────
  Widget _sectionCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Widget child,
    Widget? trailing,
  }) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(w * 0.045),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      AppColors.primaryColor.withOpacity(0.15),
                      AppColors.secondaryColor.withOpacity(0.08),
                    ]),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:
                      Icon(icon, color: AppColors.primaryColor, size: 20),
                ),
                SizedBox(width: w * 0.03),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: w * 0.042,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimaryColor,
                    ),
                  ),
                ),
                if (trailing != null) trailing,
              ],
            ),
            SizedBox(height: h * 0.02),
            child,
          ],
        ),
      ),
    );
  }

  // ── Text field ────────────────────────────────────────────────────────────
  Widget _buildTextField(
    BuildContext context, {
    required TextEditingController ctrl,
    required String label,
    required String hint,
    required IconData icon,
  }) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: w * 0.037,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondaryColor,
          ),
        ),
        SizedBox(height: h * 0.008),
        TextFormField(
          controller: ctrl,
          style: GoogleFonts.poppins(
              fontSize: w * 0.038,
              color: AppColors.textPrimaryColor),
          cursorColor: AppColors.primaryColor,
          decoration:
              _inputDecoration(context, hint: hint, icon: icon),
        ),
      ],
    );
  }

  // ── Number field ──────────────────────────────────────────────────────────
  Widget _buildNumberField(
    BuildContext context, {
    required TextEditingController ctrl,
    required String label,
    required String hint,
    required IconData icon,
  }) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: w * 0.033,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondaryColor,
          ),
        ),
        SizedBox(height: h * 0.008),
        TextFormField(
          controller: ctrl,
          keyboardType:
              const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
          ],
          style: GoogleFonts.poppins(
              fontSize: w * 0.038,
              color: AppColors.textPrimaryColor),
          cursorColor: AppColors.primaryColor,
          decoration:
              _inputDecoration(context, hint: hint, icon: icon),
        ),
      ],
    );
  }

  // ── Dropdown ──────────────────────────────────────────────────────────────
  Widget _buildDropdown(
    BuildContext context, {
    required String label,
    required IconData icon,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: w * 0.037,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondaryColor,
          ),
        ),
        SizedBox(height: h * 0.008),
        DropdownButtonFormField<String>(
          value: value,
          style: GoogleFonts.poppins(
              fontSize: w * 0.038,
              color: AppColors.textPrimaryColor),
          decoration: _inputDecoration(context,
              hint: 'Select blood group', icon: icon),
          dropdownColor: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(15),
          items: items
              .map((g) => DropdownMenuItem(
                    value: g,
                    child: Text(g,
                        style:
                            GoogleFonts.poppins(fontSize: w * 0.038)),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  // ── Toggle ────────────────────────────────────────────────────────────────
  Widget _buildToggle(
    BuildContext context, {
    required String label,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    final w = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: w * 0.038,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimaryColor,
                ),
              ),
              Text(
                subtitle,
                style: GoogleFonts.poppins(
                  fontSize: w * 0.032,
                  color: AppColors.textSecondaryColor,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.primaryColor,
        ),
      ],
    );
  }

  Widget _buildDivider() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Divider(
            color: AppColors.greyColor.withOpacity(0.2), height: 1),
      );

  Widget _buildEmptyDocsHint(
      BuildContext context, double w, double h) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: h * 0.03),
      alignment: Alignment.center,
      child: Column(
        children: [
          Icon(Icons.upload_file_outlined,
              color: AppColors.greyColor, size: 44),
          SizedBox(height: h * 0.01),
          Text(
            'No documents added',
            style: GoogleFonts.poppins(
              color: AppColors.textSecondaryColor,
              fontSize: w * 0.036,
            ),
          ),
          SizedBox(height: h * 0.005),
          Text(
            'Tap "Add PDF" to upload medical records',
            style: GoogleFonts.poppins(
              color: AppColors.greyColor,
              fontSize: w * 0.032,
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(BuildContext context,
      {required String hint, required IconData icon}) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return InputDecoration(
      prefixIcon: Icon(icon, color: AppColors.primaryColor),
      hintText: hint,
      hintStyle: GoogleFonts.poppins(
          color: AppColors.greyColor, fontSize: w * 0.037),
      filled: true,
      fillColor: AppColors.lightGreyColor,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide:
              const BorderSide(color: AppColors.primaryColor, width: 2)),
      contentPadding: EdgeInsets.symmetric(
          vertical: h * 0.018, horizontal: w * 0.04),
    );
  }

  String _formatDocType(String type) {
    return type
        .split('_')
        .map((w) => w[0].toUpperCase() + w.substring(1))
        .join(' ');
  }
}

// ── Data classes ─────────────────────────────────────────────────────────────
class _PendingDocument {
  final String path;
  final String name;
  final String type;
  _PendingDocument(
      {required this.path, required this.name, required this.type});
}

class _ReplacementDoc {
  final String path;
  final String name;
  final String type;
  _ReplacementDoc(
      {required this.path, required this.name, required this.type});
}