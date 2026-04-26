// // lib/view/children/child_health_detail_screen.dart
// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/controllers/child_health_controller.dart';
// import 'package:speechspectrum/models/child_health_model.dart';
// import 'package:speechspectrum/models/child_model.dart';
// import 'package:speechspectrum/routes/app_routes.dart';
// import 'package:speechspectrum/view/children/child_health_profile_screen.dart';

// class ChildHealthDetailScreen extends StatefulWidget {
//   const ChildHealthDetailScreen({super.key});

//   @override
//   State<ChildHealthDetailScreen> createState() => _ChildHealthDetailScreenState();
// }

// class _ChildHealthDetailScreenState extends State<ChildHealthDetailScreen> {
//   late ChildHealthController controller;
//   late ChildData child;

//   @override
//   void initState() {
//     super.initState();
//     final args = Get.arguments as Map<String, dynamic>;
//     child = args['child'] as ChildData;

//     controller = Get.isRegistered<ChildHealthController>()
//         ? Get.find<ChildHealthController>()
//         : Get.put(ChildHealthController());

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       controller.fetchHealthProfile(child.childId);
//     });
//   }

//   Future<void> _goToEditHealth() async {
//     final result = await Get.toNamed(
//       AppRoutes.childHealthProfile,
//       arguments: {
//         'child': child,
//         'healthData': controller.healthData.value,
//       },
//     );
//     if (result == true) {
//       controller.fetchHealthProfile(child.childId);
//     }
//   }

//   Future<void> _addRecord() async {
//     final result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf'],
//       allowMultiple: true,
//     );
//     if (result == null || result.files.isEmpty) return;

//     // Show type picker for each file
//     final List<Map<String, String>> records = [];
//     for (final file in result.files) {
//       final type = await _showTypePickerDialog(file.name);
//       if (type != null) {
//         records.add({'path': file.path!, 'type': type});
//       }
//     }
//     if (records.isNotEmpty) {
//       await controller.uploadMedicalRecords(childId: child.childId, records: records);
//     }
//   }

//   Future<String?> _showTypePickerDialog(String fileName) {
//     String selected = 'other';
//     return showDialog<String>(
//       context: context,
//       builder: (ctx) {
//         return StatefulBuilder(builder: (ctx, setS) {
//           final w = MediaQuery.of(ctx).size.width;
//           final h = MediaQuery.of(ctx).size.height;
//           return Dialog(
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//             child: Padding(
//               padding: EdgeInsets.all(w * 0.05),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Document Type', style: GoogleFonts.poppins(fontSize: w * 0.045, fontWeight: FontWeight.bold, color: AppColors.textPrimaryColor)),
//                   SizedBox(height: h * 0.008),
//                   Text(fileName, style: GoogleFonts.poppins(fontSize: w * 0.033, color: AppColors.textSecondaryColor), maxLines: 1, overflow: TextOverflow.ellipsis),
//                   SizedBox(height: h * 0.02),
//                   DropdownButtonFormField<String>(
//                     value: selected,
//                     dropdownColor: AppColors.whiteColor,
//                     borderRadius: BorderRadius.circular(12),
//                     decoration: InputDecoration(
//                       filled: true,
//                       fillColor: AppColors.lightGreyColor,
//                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
//                       contentPadding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: h * 0.015),
//                     ),
//                     items: kDocumentTypes.map((t) => DropdownMenuItem(value: t, child: Text(_fmt(t), style: GoogleFonts.poppins(fontSize: w * 0.037)))).toList(),
//                     onChanged: (v) => setS(() => selected = v ?? selected),
//                   ),
//                   SizedBox(height: h * 0.025),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: OutlinedButton(
//                           onPressed: () => Navigator.pop(ctx),
//                           style: OutlinedButton.styleFrom(
//                             padding: EdgeInsets.symmetric(vertical: h * 0.015),
//                             side: BorderSide(color: AppColors.greyColor.withOpacity(0.4)),
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                           ),
//                           child: Text('Cancel', style: GoogleFonts.poppins(color: AppColors.textSecondaryColor, fontWeight: FontWeight.w600)),
//                         ),
//                       ),
//                       SizedBox(width: w * 0.03),
//                       Expanded(
//                         child: ElevatedButton(
//                           onPressed: () => Navigator.pop(ctx, selected),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: AppColors.primaryColor,
//                             padding: EdgeInsets.symmetric(vertical: h * 0.015),
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                           ),
//                           child: Text('Upload', style: GoogleFonts.poppins(color: AppColors.whiteColor, fontWeight: FontWeight.w600)),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//       },
//     );
//   }

//   void _showDeleteRecordDialog(MedicalRecord record) {
//     final w = MediaQuery.of(context).size.width;
//     final h = MediaQuery.of(context).size.height;
//     Get.dialog(
//       Dialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         child: Padding(
//           padding: EdgeInsets.all(w * 0.05),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 width: 70,
//                 height: 70,
//                 decoration: BoxDecoration(color: AppColors.errorColor.withOpacity(0.1), shape: BoxShape.circle),
//                 child: const Icon(Icons.warning_amber_rounded, color: AppColors.errorColor, size: 40),
//               ),
//               SizedBox(height: h * 0.02),
//               Text('Delete Record', style: GoogleFonts.poppins(fontSize: w * 0.048, fontWeight: FontWeight.bold, color: AppColors.textPrimaryColor)),
//               SizedBox(height: h * 0.01),
//               Text('Delete "${record.fileName}"?', textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: w * 0.036, color: AppColors.textSecondaryColor, height: 1.4)),
//               SizedBox(height: h * 0.005),
//               Text('This cannot be undone.', style: GoogleFonts.poppins(fontSize: w * 0.033, color: AppColors.errorColor, fontWeight: FontWeight.w500)),
//               SizedBox(height: h * 0.025),
//               Row(
//                 children: [
//                   Expanded(
//                     child: OutlinedButton(
//                       onPressed: () => Get.back(),
//                       style: OutlinedButton.styleFrom(
//                         padding: EdgeInsets.symmetric(vertical: h * 0.015),
//                         side: BorderSide(color: AppColors.greyColor.withOpacity(0.4)),
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                       ),
//                       child: Text('Cancel', style: GoogleFonts.poppins(color: AppColors.textSecondaryColor, fontWeight: FontWeight.w600)),
//                     ),
//                   ),
//                   SizedBox(width: w * 0.03),
//                   Expanded(
//                     child: Obx(() => ElevatedButton(
//                           onPressed: controller.isDeletingRecord.value
//                               ? null
//                               : () async {
//                                   final ok = await controller.deleteMedicalRecord(
//                                     childId: child.childId,
//                                     documentId: record.documentId,
//                                   );
//                                   if (ok) Get.back();
//                                 },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: AppColors.errorColor,
//                             padding: EdgeInsets.symmetric(vertical: h * 0.015),
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                           ),
//                           child: controller.isDeletingRecord.value
//                               ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
//                               : Text('Delete', style: GoogleFonts.poppins(color: AppColors.whiteColor, fontWeight: FontWeight.w600)),
//                         )),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
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
//             flexibleSpace: FlexibleSpaceBar(background: _buildHeader(context, w, h)),
//             leading: IconButton(
//               icon: const Icon(Icons.arrow_back, color: AppColors.whiteColor),
//               onPressed: () => Get.back(),
//             ),
//             actions: [
//               IconButton(
//                 icon: const Icon(Icons.edit_rounded, color: AppColors.whiteColor),
//                 onPressed: _goToEditHealth,
//                 tooltip: 'Edit Health Profile',
//               ),
//             ],
//           ),
//           Obx(() {
//             if (controller.isLoading.value) {
//               return SliverFillRemaining(
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const CircularProgressIndicator(color: AppColors.primaryColor, strokeWidth: 3),
//                       SizedBox(height: h * 0.02),
//                       Text('Loading health profile...', style: GoogleFonts.poppins(color: AppColors.textSecondaryColor, fontSize: w * 0.035)),
//                     ],
//                   ),
//                 ),
//               );
//             }

//             if (controller.healthData.value == null) {
//               return SliverFillRemaining(child: _buildNoHealthState(context, w, h));
//             }

//             final hd = controller.healthData.value!;
//             return SliverToBoxAdapter(
//               child: Padding(
//                 padding: EdgeInsets.all(w * 0.05),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     if (hd.weightKg != null || hd.heightCm != null || hd.bmi != null)
//                       _buildMeasurementsCard(context, hd, w, h),
//                     if (hd.weightKg != null || hd.heightCm != null || hd.bmi != null)
//                       SizedBox(height: h * 0.02),
//                     _buildInfoCard(context, hd, w, h),
//                     SizedBox(height: h * 0.02),
//                     _buildFamilyHistoryCard(context, hd, w, h),
//                     SizedBox(height: h * 0.02),
//                     _buildMedicalRecordsCard(context, hd, w, h),
//                     SizedBox(height: h * 0.04),
//                   ],
//                 ),
//               ),
//             );
//           }),
//         ],
//       ),
//       floatingActionButton: Obx(() => controller.isUploading.value
//           ? FloatingActionButton.extended(
//               onPressed: null,
//               backgroundColor: AppColors.primaryColor,
//               icon: SizedBox(
//                 width: 20,
//                 height: 20,
//                 child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
//               ),
//               label: Text(
//                 'Uploading ${controller.uploadedCount.value}/${controller.totalToUpload.value}...',
//                 style: GoogleFonts.poppins(color: AppColors.whiteColor, fontWeight: FontWeight.w600, fontSize: 13),
//               ),
//             )
//           : FloatingActionButton.extended(
//               onPressed: _addRecord,
//               backgroundColor: AppColors.primaryColor,
//               icon: const Icon(Icons.upload_file, color: AppColors.whiteColor),
//               label: Text('Add Record', style: GoogleFonts.poppins(color: AppColors.whiteColor, fontWeight: FontWeight.w600, fontSize: 14)),
//             )),
//     );
//   }

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
//                 decoration: BoxDecoration(color: AppColors.whiteColor.withOpacity(0.2), shape: BoxShape.circle),
//                 child: const Icon(Icons.medical_services_rounded, size: 40, color: AppColors.whiteColor),
//               ),
//               SizedBox(height: h * 0.015),
//               Text('Health Profile', style: GoogleFonts.poppins(color: AppColors.whiteColor, fontSize: w * 0.055, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
//               SizedBox(height: h * 0.005),
//               Text(child.childName, style: GoogleFonts.poppins(color: AppColors.whiteColor.withOpacity(0.9), fontSize: w * 0.038)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildNoHealthState(BuildContext context, double w, double h) {
//     return Center(
//       child: Padding(
//         padding: EdgeInsets.all(w * 0.08),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: 150,
//               height: 150,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(colors: [AppColors.primaryColor.withOpacity(0.1), AppColors.secondaryColor.withOpacity(0.1)]),
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(Icons.medical_services_outlined, size: 80, color: AppColors.primaryColor),
//             ),
//             SizedBox(height: h * 0.03),
//             Text('No Health Profile Yet', style: GoogleFonts.poppins(fontSize: w * 0.05, fontWeight: FontWeight.bold, color: AppColors.textPrimaryColor)),
//             SizedBox(height: h * 0.015),
//             Text("Add ${child.childName}'s health information to better track their development.", textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: w * 0.037, color: AppColors.textSecondaryColor, height: 1.5)),
//             SizedBox(height: h * 0.04),
//             ElevatedButton.icon(
//               onPressed: _goToEditHealth,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.primaryColor,
//                 padding: EdgeInsets.symmetric(horizontal: w * 0.08, vertical: h * 0.018),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
//                 elevation: 0,
//               ),
//               icon: const Icon(Icons.add, color: AppColors.whiteColor),
//               label: Text('Create Health Profile', style: GoogleFonts.poppins(color: AppColors.whiteColor, fontWeight: FontWeight.w600, fontSize: w * 0.04)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildMeasurementsCard(BuildContext context, ChildHealthData hd, double w, double h) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(colors: [AppColors.primaryColor, AppColors.secondaryColor], begin: Alignment.topLeft, end: Alignment.bottomRight),
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [BoxShadow(color: AppColors.primaryColor.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 6))],
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(w * 0.05),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             if (hd.weightKg != null) _metricTile(context, label: 'Weight', value: '${hd.weightKg} kg', icon: Icons.monitor_weight_outlined, w: w, h: h),
//             if (hd.heightCm != null) _metricTile(context, label: 'Height', value: '${hd.heightCm} cm', icon: Icons.height_outlined, w: w, h: h),
//             if (hd.bmi != null) _metricTile(context, label: 'BMI', value: hd.bmi!.toStringAsFixed(2), icon: Icons.analytics_outlined, w: w, h: h),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _metricTile(BuildContext context, {required String label, required String value, required IconData icon, required double w, required double h}) {
//     return Column(
//       children: [
//         Icon(icon, color: AppColors.whiteColor.withOpacity(0.85), size: 26),
//         SizedBox(height: h * 0.008),
//         Text(value, style: GoogleFonts.poppins(color: AppColors.whiteColor, fontSize: w * 0.042, fontWeight: FontWeight.bold)),
//         Text(label, style: GoogleFonts.poppins(color: AppColors.whiteColor.withOpacity(0.8), fontSize: w * 0.03)),
//       ],
//     );
//   }

//   Widget _buildInfoCard(BuildContext context, ChildHealthData hd, double w, double h) {
//     return _card(
//       context,
//       title: 'Medical Information',
//       icon: Icons.medical_information_outlined,
//       w: w,
//       h: h,
//       child: Column(
//         children: [
//           if (hd.bloodGroup != null) ...[
//             _infoRow(context, icon: Icons.bloodtype_outlined, label: 'Blood Group', value: hd.bloodGroup!, w: w, h: h),
//             _divider(),
//           ],
//           if (hd.knownAllergies != null && hd.knownAllergies!.isNotEmpty) ...[
//             _infoRow(context, icon: Icons.warning_amber_outlined, label: 'Known Allergies', value: hd.knownAllergies!, w: w, h: h),
//             _divider(),
//           ],
//           if (hd.geneticDisorders != null && hd.geneticDisorders!.isNotEmpty) ...[
//             _infoRow(context, icon: Icons.biotech_outlined, label: 'Genetic Disorders', value: hd.geneticDisorders!, w: w, h: h),
//             _divider(),
//           ],
//           if (hd.chronicConditions != null && hd.chronicConditions!.isNotEmpty)
//             _infoRow(context, icon: Icons.local_hospital_outlined, label: 'Chronic Conditions', value: hd.chronicConditions!, w: w, h: h),
//         ],
//       ),
//     );
//   }

//   Widget _buildFamilyHistoryCard(BuildContext context, ChildHealthData hd, double w, double h) {
//     return _card(
//       context,
//       title: 'Family History',
//       icon: Icons.family_restroom_outlined,
//       w: w,
//       h: h,
//       child: Column(
//         children: [
//           _historyRow(context, label: 'ASD History', value: hd.familyHistoryAsd, w: w, h: h),
//           _divider(),
//           _historyRow(context, label: 'Speech Disorders', value: hd.familyHistorysSpeechDisorders, w: w, h: h),
//           _divider(),
//           _historyRow(context, label: 'Hearing Loss', value: hd.familyHistoryHearingLoss, w: w, h: h),
//         ],
//       ),
//     );
//   }

//   Widget _buildMedicalRecordsCard(BuildContext context, ChildHealthData hd, double w, double h) {
//     final records = hd.medicalRecords ?? [];
//     return _card(
//       context,
//       title: 'Medical Records',
//       icon: Icons.folder_outlined,
//       w: w,
//       h: h,
//       trailing: Text('${records.length} file${records.length != 1 ? 's' : ''}', style: GoogleFonts.poppins(fontSize: w * 0.033, color: AppColors.textSecondaryColor)),
//       child: records.isEmpty
//           ? Padding(
//               padding: EdgeInsets.symmetric(vertical: h * 0.02),
//               child: Center(child: Text('No medical records uploaded', style: GoogleFonts.poppins(fontSize: w * 0.036, color: AppColors.textSecondaryColor))),
//             )
//           : Column(
//               children: records.map((r) => _buildRecordTile(context, r, w, h)).toList(),
//             ),
//     );
//   }

//   Widget _buildRecordTile(BuildContext context, MedicalRecord record, double w, double h) {
//     return Container(
//       margin: EdgeInsets.only(bottom: h * 0.012),
//       padding: EdgeInsets.all(w * 0.035),
//       decoration: BoxDecoration(
//         color: AppColors.lightGreyColor,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 44,
//             height: 44,
//             decoration: BoxDecoration(color: AppColors.primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
//             child: const Icon(Icons.picture_as_pdf, color: AppColors.primaryColor, size: 22),
//           ),
//           SizedBox(width: w * 0.03),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(record.fileName, style: GoogleFonts.poppins(fontSize: w * 0.036, fontWeight: FontWeight.w500, color: AppColors.textPrimaryColor), maxLines: 1, overflow: TextOverflow.ellipsis),
//                 SizedBox(height: h * 0.004),
//                 Row(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//                       decoration: BoxDecoration(color: AppColors.primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
//                       child: Text(record.getDocumentTypeDisplay(), style: GoogleFonts.poppins(fontSize: w * 0.028, color: AppColors.primaryColor, fontWeight: FontWeight.w500)),
//                     ),
//                     SizedBox(width: w * 0.02),
//                     Text(_formatDate(record.uploadedAt), style: GoogleFonts.poppins(fontSize: w * 0.028, color: AppColors.textSecondaryColor)),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.delete_outline, color: AppColors.errorColor, size: 20),
//             onPressed: () => _showDeleteRecordDialog(record),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _card(BuildContext context, {required String title, required IconData icon, required Widget child, required double w, required double h, Widget? trailing}) {
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
//                 Expanded(child: Text(title, style: GoogleFonts.poppins(fontSize: w * 0.042, fontWeight: FontWeight.bold, color: AppColors.textPrimaryColor))),
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

//   Widget _infoRow(BuildContext context, {required IconData icon, required String label, required String value, required double w, required double h}) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: h * 0.008),
//       child: Row(
//         children: [
//           Icon(icon, color: AppColors.primaryColor, size: 20),
//           SizedBox(width: w * 0.03),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(label, style: GoogleFonts.poppins(fontSize: w * 0.03, color: AppColors.textSecondaryColor)),
//                 Text(value, style: GoogleFonts.poppins(fontSize: w * 0.038, fontWeight: FontWeight.w500, color: AppColors.textPrimaryColor)),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _historyRow(BuildContext context, {required String label, required bool value, required double w, required double h}) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: h * 0.008),
//       child: Row(
//         children: [
//           Icon(value ? Icons.check_circle_outline : Icons.cancel_outlined, color: value ? AppColors.errorColor : AppColors.successColor, size: 20),
//           SizedBox(width: w * 0.03),
//           Expanded(child: Text(label, style: GoogleFonts.poppins(fontSize: w * 0.037, color: AppColors.textPrimaryColor))),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
//             decoration: BoxDecoration(
//               color: (value ? AppColors.errorColor : AppColors.successColor).withOpacity(0.1),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Text(value ? 'Yes' : 'No', style: GoogleFonts.poppins(fontSize: w * 0.033, fontWeight: FontWeight.w600, color: value ? AppColors.errorColor : AppColors.successColor)),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _divider() => Padding(
//         padding: const EdgeInsets.symmetric(vertical: 6),
//         child: Divider(color: AppColors.greyColor.withOpacity(0.2), height: 1),
//       );

//   String _formatDate(String dateStr) {
//     try {
//       final date = DateTime.parse(dateStr);
//       return DateFormat('MMM dd, yyyy').format(date);
//     } catch (_) {
//       return dateStr;
//     }
//   }

//   String _fmt(String type) => type.split('_').map((w) => w[0].toUpperCase() + w.substring(1)).join(' ');
// }


// // lib/view/children/child_health_detail_screen.dart
// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/controllers/child_controller.dart';
// import 'package:speechspectrum/controllers/child_health_controller.dart';
// import 'package:speechspectrum/models/child_health_model.dart';
// import 'package:speechspectrum/models/child_model.dart';
// import 'package:speechspectrum/routes/app_routes.dart';
// import 'package:speechspectrum/view/children/child_health_profile_screen.dart';

// class ChildHealthDetailScreen extends StatefulWidget {
//   const ChildHealthDetailScreen({super.key});

//   @override
//   State<ChildHealthDetailScreen> createState() =>
//       _ChildHealthDetailScreenState();
// }

// class _ChildHealthDetailScreenState extends State<ChildHealthDetailScreen> {
//   late ChildHealthController controller;
//   late ChildController childController;
//   late ChildData child;
//   bool isCreationFlow = false;

//   @override
//   void initState() {
//     super.initState();
//     final args = Get.arguments as Map<String, dynamic>;
//     child = args['child'] as ChildData;
//     isCreationFlow = (args['isCreationFlow'] as bool?) ?? false;

//     controller = Get.isRegistered<ChildHealthController>()
//         ? Get.find<ChildHealthController>()
//         : Get.put(ChildHealthController());

//     childController = Get.isRegistered<ChildController>()
//         ? Get.find<ChildController>()
//         : Get.put(ChildController());

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       controller.fetchHealthProfile(child.childId);
//     });
//   }

//   // ── Navigate to edit health profile ────────────────────────────────────
//   Future<void> _goToEditHealth() async {
//     final result = await Get.toNamed(
//       AppRoutes.childHealthProfile,
//       arguments: {
//         'child': child,
//         'healthData': controller.healthData.value,
//         'isCreationFlow': false,
//       },
//     );
//     if (result == true) {
//       controller.fetchHealthProfile(child.childId);
//     }
//   }

//   // ── Add new record (from detail view) ──────────────────────────────────
//   Future<void> _addRecord() async {
//     final result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf'],
//       allowMultiple: true,
//     );
//     if (result == null || result.files.isEmpty) return;

//     final List<Map<String, String>> records = [];
//     for (final file in result.files) {
//       final type = await _showTypePickerDialog(file.name);
//       if (type != null) {
//         records.add({'path': file.path!, 'type': type});
//       }
//     }
//     if (records.isNotEmpty) {
//       await controller.uploadMedicalRecords(
//           childId: child.childId, records: records);
//     }
//   }

//   // ── Type picker dialog ──────────────────────────────────────────────────
//   Future<String?> _showTypePickerDialog(String fileName) {
//     String selected = 'other';
//     return showDialog<String>(
//       context: context,
//       builder: (ctx) {
//         return StatefulBuilder(builder: (ctx, setS) {
//           final w = MediaQuery.of(ctx).size.width;
//           final h = MediaQuery.of(ctx).size.height;
//           return Dialog(
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//             child: Padding(
//               padding: EdgeInsets.all(w * 0.05),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Document Type',
//                     style: GoogleFonts.poppins(
//                       fontSize: w * 0.045,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.textPrimaryColor,
//                     ),
//                   ),
//                   SizedBox(height: h * 0.008),
//                   Text(
//                     fileName,
//                     style: GoogleFonts.poppins(
//                       fontSize: w * 0.033,
//                       color: AppColors.textSecondaryColor,
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   SizedBox(height: h * 0.02),
//                   DropdownButtonFormField<String>(
//                     value: selected,
//                     dropdownColor: AppColors.whiteColor,
//                     borderRadius: BorderRadius.circular(12),
//                     decoration: InputDecoration(
//                       filled: true,
//                       fillColor: AppColors.lightGreyColor,
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide.none),
//                       contentPadding: EdgeInsets.symmetric(
//                           horizontal: w * 0.04, vertical: h * 0.015),
//                     ),
//                     items: kDocumentTypes
//                         .map((t) => DropdownMenuItem(
//                               value: t,
//                               child: Text(_fmt(t),
//                                   style:
//                                       GoogleFonts.poppins(fontSize: w * 0.037)),
//                             ))
//                         .toList(),
//                     onChanged: (v) => setS(() => selected = v ?? selected),
//                   ),
//                   SizedBox(height: h * 0.025),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: OutlinedButton(
//                           onPressed: () => Navigator.pop(ctx),
//                           style: OutlinedButton.styleFrom(
//                             padding: EdgeInsets.symmetric(
//                                 vertical: h * 0.015),
//                             side: BorderSide(
//                                 color: AppColors.greyColor.withOpacity(0.4)),
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12)),
//                           ),
//                           child: Text(
//                             'Cancel',
//                             style: GoogleFonts.poppins(
//                               color: AppColors.textSecondaryColor,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: w * 0.03),
//                       Expanded(
//                         child: ElevatedButton(
//                           onPressed: () => Navigator.pop(ctx, selected),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: AppColors.primaryColor,
//                             padding: EdgeInsets.symmetric(
//                                 vertical: h * 0.015),
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12)),
//                           ),
//                           child: Text(
//                             'Upload',
//                             style: GoogleFonts.poppins(
//                               color: AppColors.whiteColor,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//       },
//     );
//   }

//   // ── Delete record dialog ────────────────────────────────────────────────
//   void _showDeleteRecordDialog(MedicalRecord record) {
//     final w = MediaQuery.of(context).size.width;
//     final h = MediaQuery.of(context).size.height;
//     Get.dialog(
//       Dialog(
//         shape:
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         child: Padding(
//           padding: EdgeInsets.all(w * 0.05),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 width: 70,
//                 height: 70,
//                 decoration: BoxDecoration(
//                   color: AppColors.errorColor.withOpacity(0.1),
//                   shape: BoxShape.circle,
//                 ),
//                 child: const Icon(Icons.warning_amber_rounded,
//                     color: AppColors.errorColor, size: 40),
//               ),
//               SizedBox(height: h * 0.02),
//               Text(
//                 'Delete Record',
//                 style: GoogleFonts.poppins(
//                   fontSize: w * 0.048,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.textPrimaryColor,
//                 ),
//               ),
//               SizedBox(height: h * 0.01),
//               Text(
//                 'Delete "${record.fileName}"?',
//                 textAlign: TextAlign.center,
//                 style: GoogleFonts.poppins(
//                   fontSize: w * 0.036,
//                   color: AppColors.textSecondaryColor,
//                   height: 1.4,
//                 ),
//               ),
//               SizedBox(height: h * 0.005),
//               Text(
//                 'This cannot be undone.',
//                 style: GoogleFonts.poppins(
//                   fontSize: w * 0.033,
//                   color: AppColors.errorColor,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               SizedBox(height: h * 0.025),
//               Row(
//                 children: [
//                   Expanded(
//                     child: OutlinedButton(
//                       onPressed: () => Get.back(),
//                       style: OutlinedButton.styleFrom(
//                         padding:
//                             EdgeInsets.symmetric(vertical: h * 0.015),
//                         side: BorderSide(
//                             color: AppColors.greyColor.withOpacity(0.4)),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12)),
//                       ),
//                       child: Text(
//                         'Cancel',
//                         style: GoogleFonts.poppins(
//                           color: AppColors.textSecondaryColor,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: w * 0.03),
//                   Expanded(
//                     child: Obx(() => ElevatedButton(
//                           onPressed: controller.isDeletingRecord.value
//                               ? null
//                               : () async {
//                                   final ok =
//                                       await controller.deleteMedicalRecord(
//                                     childId: child.childId,
//                                     documentId: record.documentId,
//                                   );
//                                   if (ok) Get.back();
//                                 },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: AppColors.errorColor,
//                             padding: EdgeInsets.symmetric(
//                                 vertical: h * 0.015),
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12)),
//                           ),
//                           child: controller.isDeletingRecord.value
//                               ? const SizedBox(
//                                   width: 18,
//                                   height: 18,
//                                   child: CircularProgressIndicator(
//                                       color: Colors.white, strokeWidth: 2),
//                                 )
//                               : Text(
//                                   'Delete',
//                                   style: GoogleFonts.poppins(
//                                     color: AppColors.whiteColor,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                         )),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // ── Finish creation flow — refresh list and go to children list ─────────
//   Future<void> _finishCreation() async {
//     Get.snackbar(
//       'All Done! 🎉',
//       '${child.childName}\'s profile is complete.',
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: AppColors.successColor,
//       colorText: AppColors.whiteColor,
//       margin: const EdgeInsets.all(16),
//       borderRadius: 12,
//     );
//     await childController.finishCreationFlow();
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
//             flexibleSpace: FlexibleSpaceBar(
//                 background: _buildHeader(context, w, h)),
//             leading: isCreationFlow
//                 ? const SizedBox.shrink() // no back in creation flow step 3
//                 : IconButton(
//                     icon: const Icon(Icons.arrow_back,
//                         color: AppColors.whiteColor),
//                     onPressed: () => Get.back(),
//                   ),
//             actions: [
//               if (!isCreationFlow)
//                 IconButton(
//                   icon:
//                       const Icon(Icons.edit_rounded, color: AppColors.whiteColor),
//                   onPressed: _goToEditHealth,
//                   tooltip: 'Edit Health Profile',
//                 ),
//             ],
//           ),
//           Obx(() {
//             if (controller.isLoading.value) {
//               return SliverFillRemaining(
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const CircularProgressIndicator(
//                           color: AppColors.primaryColor, strokeWidth: 3),
//                       SizedBox(height: h * 0.02),
//                       Text(
//                         'Loading health profile...',
//                         style: GoogleFonts.poppins(
//                           color: AppColors.textSecondaryColor,
//                           fontSize: w * 0.035,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             }

//             if (controller.healthData.value == null) {
//               return SliverFillRemaining(
//                   child: _buildNoHealthState(context, w, h));
//             }

//             final hd = controller.healthData.value!;
//             return SliverToBoxAdapter(
//               child: Padding(
//                 padding: EdgeInsets.all(w * 0.05),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Step 3 indicator (creation flow only)
//                     if (isCreationFlow) ...[
//                       _buildStepIndicator(context, w, h),
//                       SizedBox(height: h * 0.02),
//                       _buildCreationFlowBanner(context, w, h),
//                       SizedBox(height: h * 0.02),
//                     ],

//                     if (hd.weightKg != null ||
//                         hd.heightCm != null ||
//                         hd.bmi != null)
//                       _buildMeasurementsCard(context, hd, w, h),
//                     if (hd.weightKg != null ||
//                         hd.heightCm != null ||
//                         hd.bmi != null)
//                       SizedBox(height: h * 0.02),
//                     _buildInfoCard(context, hd, w, h),
//                     SizedBox(height: h * 0.02),
//                     _buildFamilyHistoryCard(context, hd, w, h),
//                     SizedBox(height: h * 0.02),
//                     _buildMedicalRecordsCard(context, hd, w, h),
//                     SizedBox(height: h * 0.04),

//                     // Finish button (creation flow only)
//                     if (isCreationFlow) ...[
//                       SizedBox(
//                         width: double.infinity,
//                         height: h * 0.065,
//                         child: ElevatedButton.icon(
//                           onPressed: _finishCreation,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: AppColors.successColor,
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(15)),
//                             elevation: 0,
//                           ),
//                           icon: const Icon(Icons.check_circle_outline,
//                               color: Colors.white),
//                           label: Text(
//                             'Finish & Go to My Children',
//                             style: GoogleFonts.poppins(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: w * 0.042,
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: h * 0.04),
//                     ],
//                   ],
//                 ),
//               ),
//             );
//           }),
//         ],
//       ),
//       floatingActionButton: isCreationFlow
//           ? null // no add-record FAB during creation flow review
//           : Obx(() => controller.isUploading.value
//               ? FloatingActionButton.extended(
//                   onPressed: null,
//                   backgroundColor: AppColors.primaryColor,
//                   icon: const SizedBox(
//                     width: 20,
//                     height: 20,
//                     child: CircularProgressIndicator(
//                         color: Colors.white, strokeWidth: 2),
//                   ),
//                   label: Text(
//                     'Uploading ${controller.uploadedCount.value}/${controller.totalToUpload.value}...',
//                     style: GoogleFonts.poppins(
//                       color: AppColors.whiteColor,
//                       fontWeight: FontWeight.w600,
//                       fontSize: 13,
//                     ),
//                   ),
//                 )
//               : FloatingActionButton.extended(
//                   onPressed: _addRecord,
//                   backgroundColor: AppColors.primaryColor,
//                   icon: const Icon(Icons.upload_file,
//                       color: AppColors.whiteColor),
//                   label: Text(
//                     'Add Record',
//                     style: GoogleFonts.poppins(
//                       color: AppColors.whiteColor,
//                       fontWeight: FontWeight.w600,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )),
//     );
//   }

//   // ── Step 3 indicator ─────────────────────────────────────────────────────
//   Widget _buildStepIndicator(BuildContext context, double w, double h) {
//     return Row(
//       children: [
//         _stepBadge(1, 'Child Info', done: true, active: false, w: w),
//         Expanded(child: Container(height: 2, color: AppColors.primaryColor)),
//         _stepBadge(2, 'Health Profile', done: true, active: false, w: w),
//         Expanded(child: Container(height: 2, color: AppColors.primaryColor)),
//         _stepBadge(3, 'Review', done: false, active: true, w: w),
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
//                     color: active ? AppColors.whiteColor : AppColors.greyColor,
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

//   Widget _buildCreationFlowBanner(
//       BuildContext context, double w, double h) {
//     return Container(
//       padding: EdgeInsets.all(w * 0.04),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             AppColors.successColor.withOpacity(0.1),
//             AppColors.primaryColor.withOpacity(0.05),
//           ],
//         ),
//         borderRadius: BorderRadius.circular(15),
//         border:
//             Border.all(color: AppColors.successColor.withOpacity(0.3)),
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.info_outline,
//               color: AppColors.successColor, size: 24),
//           SizedBox(width: w * 0.03),
//           Expanded(
//             child: Text(
//               'Review ${child.childName}\'s profile below. Tap "Finish" when ready.',
//               style: GoogleFonts.poppins(
//                 fontSize: w * 0.034,
//                 color: AppColors.textPrimaryColor,
//                 height: 1.4,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ── Header ────────────────────────────────────────────────────────────────
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
//                 child: const Icon(Icons.medical_services_rounded,
//                     size: 40, color: AppColors.whiteColor),
//               ),
//               SizedBox(height: h * 0.015),
//               Text(
//                 isCreationFlow ? 'Step 3 · Review' : 'Health Profile',
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

//   Widget _buildNoHealthState(BuildContext context, double w, double h) {
//     return Center(
//       child: Padding(
//         padding: EdgeInsets.all(w * 0.08),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: 150,
//               height: 150,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(colors: [
//                   AppColors.primaryColor.withOpacity(0.1),
//                   AppColors.secondaryColor.withOpacity(0.1),
//                 ]),
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(Icons.medical_services_outlined,
//                   size: 80, color: AppColors.primaryColor),
//             ),
//             SizedBox(height: h * 0.03),
//             Text(
//               'No Health Profile Yet',
//               style: GoogleFonts.poppins(
//                 fontSize: w * 0.05,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.textPrimaryColor,
//               ),
//             ),
//             SizedBox(height: h * 0.015),
//             Text(
//               "Add ${child.childName}'s health information to better track their development.",
//               textAlign: TextAlign.center,
//               style: GoogleFonts.poppins(
//                 fontSize: w * 0.037,
//                 color: AppColors.textSecondaryColor,
//                 height: 1.5,
//               ),
//             ),
//             SizedBox(height: h * 0.04),
//             ElevatedButton.icon(
//               onPressed: _goToEditHealth,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.primaryColor,
//                 padding: EdgeInsets.symmetric(
//                     horizontal: w * 0.08, vertical: h * 0.018),
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(14)),
//                 elevation: 0,
//               ),
//               icon: const Icon(Icons.add, color: AppColors.whiteColor),
//               label: Text(
//                 'Create Health Profile',
//                 style: GoogleFonts.poppins(
//                   color: AppColors.whiteColor,
//                   fontWeight: FontWeight.w600,
//                   fontSize: w * 0.04,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildMeasurementsCard(
//       BuildContext context, ChildHealthData hd, double w, double h) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [AppColors.primaryColor, AppColors.secondaryColor],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: AppColors.primaryColor.withOpacity(0.3),
//             blurRadius: 15,
//             offset: const Offset(0, 6),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(w * 0.05),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             if (hd.weightKg != null)
//               _metricTile(context,
//                   label: 'Weight',
//                   value: '${hd.weightKg} kg',
//                   icon: Icons.monitor_weight_outlined,
//                   w: w,
//                   h: h),
//             if (hd.heightCm != null)
//               _metricTile(context,
//                   label: 'Height',
//                   value: '${hd.heightCm} cm',
//                   icon: Icons.height_outlined,
//                   w: w,
//                   h: h),
//             if (hd.bmi != null)
//               _metricTile(context,
//                   label: 'BMI',
//                   value: hd.bmi!.toStringAsFixed(2),
//                   icon: Icons.analytics_outlined,
//                   w: w,
//                   h: h),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _metricTile(BuildContext context,
//       {required String label,
//       required String value,
//       required IconData icon,
//       required double w,
//       required double h}) {
//     return Column(
//       children: [
//         Icon(icon, color: AppColors.whiteColor.withOpacity(0.85), size: 26),
//         SizedBox(height: h * 0.008),
//         Text(
//           value,
//           style: GoogleFonts.poppins(
//             color: AppColors.whiteColor,
//             fontSize: w * 0.042,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         Text(
//           label,
//           style: GoogleFonts.poppins(
//             color: AppColors.whiteColor.withOpacity(0.8),
//             fontSize: w * 0.03,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildInfoCard(
//       BuildContext context, ChildHealthData hd, double w, double h) {
//     return _card(
//       context,
//       title: 'Medical Information',
//       icon: Icons.medical_information_outlined,
//       w: w,
//       h: h,
//       child: Column(
//         children: [
//           if (hd.bloodGroup != null) ...[
//             _infoRow(context,
//                 icon: Icons.bloodtype_outlined,
//                 label: 'Blood Group',
//                 value: hd.bloodGroup!,
//                 w: w,
//                 h: h),
//             _divider(),
//           ],
//           if (hd.knownAllergies != null &&
//               hd.knownAllergies!.isNotEmpty) ...[
//             _infoRow(context,
//                 icon: Icons.warning_amber_outlined,
//                 label: 'Known Allergies',
//                 value: hd.knownAllergies!,
//                 w: w,
//                 h: h),
//             _divider(),
//           ],
//           if (hd.geneticDisorders != null &&
//               hd.geneticDisorders!.isNotEmpty) ...[
//             _infoRow(context,
//                 icon: Icons.biotech_outlined,
//                 label: 'Genetic Disorders',
//                 value: hd.geneticDisorders!,
//                 w: w,
//                 h: h),
//             _divider(),
//           ],
//           if (hd.chronicConditions != null &&
//               hd.chronicConditions!.isNotEmpty)
//             _infoRow(context,
//                 icon: Icons.local_hospital_outlined,
//                 label: 'Chronic Conditions',
//                 value: hd.chronicConditions!,
//                 w: w,
//                 h: h),
//         ],
//       ),
//     );
//   }

//   Widget _buildFamilyHistoryCard(
//       BuildContext context, ChildHealthData hd, double w, double h) {
//     return _card(
//       context,
//       title: 'Family History',
//       icon: Icons.family_restroom_outlined,
//       w: w,
//       h: h,
//       child: Column(
//         children: [
//           _historyRow(context,
//               label: 'ASD History',
//               value: hd.familyHistoryAsd,
//               w: w,
//               h: h),
//           _divider(),
//           _historyRow(context,
//               label: 'Speech Disorders',
//               value: hd.familyHistorysSpeechDisorders,
//               w: w,
//               h: h),
//           _divider(),
//           _historyRow(context,
//               label: 'Hearing Loss',
//               value: hd.familyHistoryHearingLoss,
//               w: w,
//               h: h),
//         ],
//       ),
//     );
//   }

//   Widget _buildMedicalRecordsCard(
//       BuildContext context, ChildHealthData hd, double w, double h) {
//     final records = hd.medicalRecords ?? [];
//     return _card(
//       context,
//       title: 'Medical Records',
//       icon: Icons.folder_outlined,
//       w: w,
//       h: h,
//       trailing: Text(
//         '${records.length} file${records.length != 1 ? 's' : ''}',
//         style: GoogleFonts.poppins(
//           fontSize: w * 0.033,
//           color: AppColors.textSecondaryColor,
//         ),
//       ),
//       child: records.isEmpty
//           ? Padding(
//               padding: EdgeInsets.symmetric(vertical: h * 0.02),
//               child: Center(
//                 child: Text(
//                   'No medical records uploaded',
//                   style: GoogleFonts.poppins(
//                     fontSize: w * 0.036,
//                     color: AppColors.textSecondaryColor,
//                   ),
//                 ),
//               ),
//             )
//           : Column(
//               children: records
//                   .map((r) => _buildRecordTile(context, r, w, h))
//                   .toList(),
//             ),
//     );
//   }

//   Widget _buildRecordTile(
//       BuildContext context, MedicalRecord record, double w, double h) {
//     return Container(
//       margin: EdgeInsets.only(bottom: h * 0.012),
//       padding: EdgeInsets.all(w * 0.035),
//       decoration: BoxDecoration(
//         color: AppColors.lightGreyColor,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 44,
//             height: 44,
//             decoration: BoxDecoration(
//               color: AppColors.primaryColor.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: const Icon(Icons.picture_as_pdf,
//                 color: AppColors.primaryColor, size: 22),
//           ),
//           SizedBox(width: w * 0.03),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   record.fileName,
//                   style: GoogleFonts.poppins(
//                     fontSize: w * 0.036,
//                     fontWeight: FontWeight.w500,
//                     color: AppColors.textPrimaryColor,
//                   ),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 SizedBox(height: h * 0.004),
//                 Row(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 8, vertical: 2),
//                       decoration: BoxDecoration(
//                         color: AppColors.primaryColor.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                       child: Text(
//                         record.getDocumentTypeDisplay(),
//                         style: GoogleFonts.poppins(
//                           fontSize: w * 0.028,
//                           color: AppColors.primaryColor,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: w * 0.02),
//                     Text(
//                       _formatDate(record.uploadedAt),
//                       style: GoogleFonts.poppins(
//                         fontSize: w * 0.028,
//                         color: AppColors.textSecondaryColor,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           if (!isCreationFlow) // no delete during creation review
//             IconButton(
//               icon: const Icon(Icons.delete_outline,
//                   color: AppColors.errorColor, size: 20),
//               onPressed: () => _showDeleteRecordDialog(record),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _card(
//     BuildContext context, {
//     required String title,
//     required IconData icon,
//     required Widget child,
//     required double w,
//     required double h,
//     Widget? trailing,
//   }) {
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
//                   child:
//                       Icon(icon, color: AppColors.primaryColor, size: 20),
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

//   Widget _infoRow(BuildContext context,
//       {required IconData icon,
//       required String label,
//       required String value,
//       required double w,
//       required double h}) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: h * 0.008),
//       child: Row(
//         children: [
//           Icon(icon, color: AppColors.primaryColor, size: 20),
//           SizedBox(width: w * 0.03),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   label,
//                   style: GoogleFonts.poppins(
//                     fontSize: w * 0.03,
//                     color: AppColors.textSecondaryColor,
//                   ),
//                 ),
//                 Text(
//                   value,
//                   style: GoogleFonts.poppins(
//                     fontSize: w * 0.038,
//                     fontWeight: FontWeight.w500,
//                     color: AppColors.textPrimaryColor,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _historyRow(BuildContext context,
//       {required String label,
//       required bool value,
//       required double w,
//       required double h}) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: h * 0.008),
//       child: Row(
//         children: [
//           Icon(
//             value ? Icons.check_circle_outline : Icons.cancel_outlined,
//             color:
//                 value ? AppColors.errorColor : AppColors.successColor,
//             size: 20,
//           ),
//           SizedBox(width: w * 0.03),
//           Expanded(
//             child: Text(
//               label,
//               style: GoogleFonts.poppins(
//                 fontSize: w * 0.037,
//                 color: AppColors.textPrimaryColor,
//               ),
//             ),
//           ),
//           Container(
//             padding:
//                 const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
//             decoration: BoxDecoration(
//               color: (value ? AppColors.errorColor : AppColors.successColor)
//                   .withOpacity(0.1),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Text(
//               value ? 'Yes' : 'No',
//               style: GoogleFonts.poppins(
//                 fontSize: w * 0.033,
//                 fontWeight: FontWeight.w600,
//                 color: value
//                     ? AppColors.errorColor
//                     : AppColors.successColor,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _divider() => Padding(
//         padding: const EdgeInsets.symmetric(vertical: 6),
//         child: Divider(
//             color: AppColors.greyColor.withOpacity(0.2), height: 1),
//       );

//   String _formatDate(String dateStr) {
//     try {
//       final date = DateTime.parse(dateStr);
//       return DateFormat('MMM dd, yyyy').format(date);
//     } catch (_) {
//       return dateStr;
//     }
//   }

//   String _fmt(String type) => type
//       .split('_')
//       .map((w) => w[0].toUpperCase() + w.substring(1))
//       .join(' ');
// }

// lib/view/children/child_health_detail_screen.dart
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/controllers/child_controller.dart';
import 'package:speechspectrum/controllers/child_health_controller.dart';
import 'package:speechspectrum/models/child_health_model.dart';
import 'package:speechspectrum/models/child_model.dart';
import 'package:speechspectrum/routes/app_routes.dart';
import 'package:speechspectrum/view/children/child_health_profile_screen.dart';

class ChildHealthDetailScreen extends StatefulWidget {
  const ChildHealthDetailScreen({super.key});

  @override
  State<ChildHealthDetailScreen> createState() =>
      _ChildHealthDetailScreenState();
}

class _ChildHealthDetailScreenState
    extends State<ChildHealthDetailScreen> {
  late ChildHealthController controller;
  late ChildController childController;
  late ChildData child;
  bool isCreationFlow = false;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>;
    child = args['child'] as ChildData;
    isCreationFlow = (args['isCreationFlow'] as bool?) ?? false;

    controller = Get.isRegistered<ChildHealthController>()
        ? Get.find<ChildHealthController>()
        : Get.put(ChildHealthController());

    childController = Get.isRegistered<ChildController>()
        ? Get.find<ChildController>()
        : Get.put(ChildController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchHealthProfile(child.childId);
    });
  }

  // ── Navigate to edit health profile ────────────────────────────────────
  /// Pushes the edit screen and waits.  When it pops with result == true
  /// (set by health_profile_screen after a successful save) we re-fetch so
  /// this detail screen shows the fresh data.
  Future<void> _goToEditHealth() async {
    final result = await Get.toNamed(
      AppRoutes.childHealthProfile,
      arguments: {
        'child': child,
        'healthData': controller.healthData.value,
        'isCreationFlow': false,
      },
    );
    // result is true when the edit screen saved successfully and called
    // Get.back(result: true).  Re-fetch to refresh this screen.
    if (result == true) {
      controller.fetchHealthProfile(child.childId);
    }
  }

  // ── Add new record (from detail view) ──────────────────────────────────
  Future<void> _addRecord() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: true,
    );
    if (result == null || result.files.isEmpty) return;

    final List<Map<String, String>> records = [];
    for (final file in result.files) {
      final type = await _showTypePickerDialog(file.name);
      if (type != null) {
        records.add({'path': file.path!, 'type': type});
      }
    }
    if (records.isNotEmpty) {
      await controller.uploadMedicalRecords(
          childId: child.childId, records: records);
    }
  }

  // ── Type picker dialog ──────────────────────────────────────────────────
  Future<String?> _showTypePickerDialog(String fileName) {
    String selected = 'other';
    return showDialog<String>(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(builder: (ctx, setS) {
          final w = MediaQuery.of(ctx).size.width;
          final h = MediaQuery.of(ctx).size.height;
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: EdgeInsets.all(w * 0.05),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Document Type',
                    style: GoogleFonts.poppins(
                      fontSize: w * 0.045,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimaryColor,
                    ),
                  ),
                  SizedBox(height: h * 0.008),
                  Text(
                    fileName,
                    style: GoogleFonts.poppins(
                      fontSize: w * 0.033,
                      color: AppColors.textSecondaryColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: h * 0.02),
                  DropdownButtonFormField<String>(
                    value: selected,
                    dropdownColor: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(12),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.lightGreyColor,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: w * 0.04,
                          vertical: h * 0.015),
                    ),
                    items: kDocumentTypes
                        .map((t) => DropdownMenuItem(
                              value: t,
                              child: Text(_fmt(t),
                                  style: GoogleFonts.poppins(
                                      fontSize: w * 0.037)),
                            ))
                        .toList(),
                    onChanged: (v) =>
                        setS(() => selected = v ?? selected),
                  ),
                  SizedBox(height: h * 0.025),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(ctx),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: h * 0.015),
                            side: BorderSide(
                                color: AppColors.greyColor
                                    .withOpacity(0.4)),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12)),
                          ),
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.poppins(
                              color: AppColors.textSecondaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: w * 0.03),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () =>
                              Navigator.pop(ctx, selected),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            padding: EdgeInsets.symmetric(
                                vertical: h * 0.015),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12)),
                          ),
                          child: Text(
                            'Upload',
                            style: GoogleFonts.poppins(
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  // ── Delete record dialog ────────────────────────────────────────────────
  void _showDeleteRecordDialog(MedicalRecord record) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: EdgeInsets.all(w * 0.05),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: AppColors.errorColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.warning_amber_rounded,
                    color: AppColors.errorColor, size: 40),
              ),
              SizedBox(height: h * 0.02),
              Text(
                'Delete Record',
                style: GoogleFonts.poppins(
                  fontSize: w * 0.048,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryColor,
                ),
              ),
              SizedBox(height: h * 0.01),
              Text(
                'Delete "${record.fileName}"?',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: w * 0.036,
                  color: AppColors.textSecondaryColor,
                  height: 1.4,
                ),
              ),
              SizedBox(height: h * 0.005),
              Text(
                'This cannot be undone.',
                style: GoogleFonts.poppins(
                  fontSize: w * 0.033,
                  color: AppColors.errorColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: h * 0.025),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: h * 0.015),
                        side: BorderSide(
                            color:
                                AppColors.greyColor.withOpacity(0.4)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.poppins(
                          color: AppColors.textSecondaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: w * 0.03),
                  Expanded(
                    child: Obx(() => ElevatedButton(
                          onPressed: controller.isDeletingRecord.value
                              ? null
                              : () async {
                                  final ok =
                                      await controller.deleteMedicalRecord(
                                    childId: child.childId,
                                    documentId: record.documentId,
                                  );
                                  if (ok) Get.back();
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.errorColor,
                            padding: EdgeInsets.symmetric(
                                vertical: h * 0.015),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12)),
                          ),
                          child: controller.isDeletingRecord.value
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2),
                                )
                              : Text(
                                  'Delete',
                                  style: GoogleFonts.poppins(
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.w600,
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

  // ── Finish creation flow ────────────────────────────────────────────────
  Future<void> _finishCreation() async {
    Get.snackbar(
      'All Done! 🎉',
      '${child.childName}\'s profile is complete.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.successColor,
      colorText: AppColors.whiteColor,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
    await childController.finishCreationFlow();
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
            leading: isCreationFlow
                ? const SizedBox.shrink()
                : IconButton(
                    icon: const Icon(Icons.arrow_back,
                        color: AppColors.whiteColor),
                    onPressed: () => Get.back(),
                  ),
            actions: [
              if (!isCreationFlow)
                IconButton(
                  icon: const Icon(Icons.edit_rounded,
                      color: AppColors.whiteColor),
                  onPressed: _goToEditHealth,
                  tooltip: 'Edit Health Profile',
                ),
            ],
          ),
          Obx(() {
            if (controller.isLoading.value) {
              return SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(
                          color: AppColors.primaryColor, strokeWidth: 3),
                      SizedBox(height: h * 0.02),
                      Text(
                        'Loading health profile...',
                        style: GoogleFonts.poppins(
                          color: AppColors.textSecondaryColor,
                          fontSize: w * 0.035,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (controller.healthData.value == null) {
              return SliverFillRemaining(
                  child: _buildNoHealthState(context, w, h));
            }

            final hd = controller.healthData.value!;
            return SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(w * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Step 3 indicator (creation flow only)
                    if (isCreationFlow) ...[
                      _buildStepIndicator(context, w, h),
                      SizedBox(height: h * 0.02),
                      _buildCreationFlowBanner(context, w, h),
                      SizedBox(height: h * 0.02),
                    ],

                    if (hd.weightKg != null ||
                        hd.heightCm != null ||
                        hd.bmi != null)
                      _buildMeasurementsCard(context, hd, w, h),
                    if (hd.weightKg != null ||
                        hd.heightCm != null ||
                        hd.bmi != null)
                      SizedBox(height: h * 0.02),
                    _buildInfoCard(context, hd, w, h),
                    SizedBox(height: h * 0.02),
                    _buildFamilyHistoryCard(context, hd, w, h),
                    SizedBox(height: h * 0.02),
                    _buildMedicalRecordsCard(context, hd, w, h),
                    SizedBox(height: h * 0.04),

                    // Finish button (creation flow only)
                    if (isCreationFlow) ...[
                      SizedBox(
                        width: double.infinity,
                        height: h * 0.065,
                        child: ElevatedButton.icon(
                          onPressed: _finishCreation,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.successColor,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(15)),
                            elevation: 0,
                          ),
                          icon: const Icon(Icons.check_circle_outline,
                              color: Colors.white),
                          label: Text(
                            'Finish & Go to My Children',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: w * 0.042,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: h * 0.04),
                    ],
                  ],
                ),
              ),
            );
          }),
        ],
      ),
      floatingActionButton: isCreationFlow
          ? null
          : Obx(() => controller.isUploading.value
              ? FloatingActionButton.extended(
                  onPressed: null,
                  backgroundColor: AppColors.primaryColor,
                  icon: const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 2),
                  ),
                  label: Text(
                    'Uploading ${controller.uploadedCount.value}/${controller.totalToUpload.value}...',
                    style: GoogleFonts.poppins(
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                )
              : FloatingActionButton.extended(
                  onPressed: _addRecord,
                  backgroundColor: AppColors.primaryColor,
                  icon: const Icon(Icons.upload_file,
                      color: AppColors.whiteColor),
                  label: Text(
                    'Add Record',
                    style: GoogleFonts.poppins(
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                )),
    );
  }

  // ── Step 3 indicator ─────────────────────────────────────────────────────
  Widget _buildStepIndicator(
      BuildContext context, double w, double h) {
    return Row(
      children: [
        _stepBadge(1, 'Child Info', done: true, active: false, w: w),
        Expanded(
            child: Container(height: 2, color: AppColors.primaryColor)),
        _stepBadge(2, 'Health Profile',
            done: true, active: false, w: w),
        Expanded(
            child: Container(height: 2, color: AppColors.primaryColor)),
        _stepBadge(3, 'Review', done: false, active: true, w: w),
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

  Widget _buildCreationFlowBanner(
      BuildContext context, double w, double h) {
    return Container(
      padding: EdgeInsets.all(w * 0.04),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.successColor.withOpacity(0.1),
            AppColors.primaryColor.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
            color: AppColors.successColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline,
              color: AppColors.successColor, size: 24),
          SizedBox(width: w * 0.03),
          Expanded(
            child: Text(
              'Review ${child.childName}\'s profile below. Tap "Finish" when ready.',
              style: GoogleFonts.poppins(
                fontSize: w * 0.034,
                color: AppColors.textPrimaryColor,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Header ────────────────────────────────────────────────────────────────
  Widget _buildHeader(BuildContext context, double w, double h) {
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
                isCreationFlow ? 'Step 3 · Review' : 'Health Profile',
                style: GoogleFonts.poppins(
                  color: AppColors.whiteColor,
                  fontSize: w * 0.055,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: h * 0.005),
              Text(
                child.childName,
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

  Widget _buildNoHealthState(
      BuildContext context, double w, double h) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(w * 0.08),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  AppColors.primaryColor.withOpacity(0.1),
                  AppColors.secondaryColor.withOpacity(0.1),
                ]),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.medical_services_outlined,
                  size: 80, color: AppColors.primaryColor),
            ),
            SizedBox(height: h * 0.03),
            Text(
              'No Health Profile Yet',
              style: GoogleFonts.poppins(
                fontSize: w * 0.05,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimaryColor,
              ),
            ),
            SizedBox(height: h * 0.015),
            Text(
              "Add ${child.childName}'s health information to better track their development.",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: w * 0.037,
                color: AppColors.textSecondaryColor,
                height: 1.5,
              ),
            ),
            SizedBox(height: h * 0.04),
            ElevatedButton.icon(
              onPressed: _goToEditHealth,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                padding: EdgeInsets.symmetric(
                    horizontal: w * 0.08, vertical: h * 0.018),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                elevation: 0,
              ),
              icon: const Icon(Icons.add, color: AppColors.whiteColor),
              label: Text(
                'Create Health Profile',
                style: GoogleFonts.poppins(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.w600,
                  fontSize: w * 0.04,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMeasurementsCard(
      BuildContext context, ChildHealthData hd, double w, double h) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primaryColor, AppColors.secondaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(w * 0.05),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (hd.weightKg != null)
              _metricTile(context,
                  label: 'Weight',
                  value: '${hd.weightKg} kg',
                  icon: Icons.monitor_weight_outlined,
                  w: w,
                  h: h),
            if (hd.heightCm != null)
              _metricTile(context,
                  label: 'Height',
                  value: '${hd.heightCm} cm',
                  icon: Icons.height_outlined,
                  w: w,
                  h: h),
            if (hd.bmi != null)
              _metricTile(context,
                  label: 'BMI',
                  value: hd.bmi!.toStringAsFixed(2),
                  icon: Icons.analytics_outlined,
                  w: w,
                  h: h),
          ],
        ),
      ),
    );
  }

  Widget _metricTile(BuildContext context,
      {required String label,
      required String value,
      required IconData icon,
      required double w,
      required double h}) {
    return Column(
      children: [
        Icon(icon,
            color: AppColors.whiteColor.withOpacity(0.85), size: 26),
        SizedBox(height: h * 0.008),
        Text(
          value,
          style: GoogleFonts.poppins(
            color: AppColors.whiteColor,
            fontSize: w * 0.042,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            color: AppColors.whiteColor.withOpacity(0.8),
            fontSize: w * 0.03,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(
      BuildContext context, ChildHealthData hd, double w, double h) {
    return _card(
      context,
      title: 'Medical Information',
      icon: Icons.medical_information_outlined,
      w: w,
      h: h,
      child: Column(
        children: [
          if (hd.bloodGroup != null) ...[
            _infoRow(context,
                icon: Icons.bloodtype_outlined,
                label: 'Blood Group',
                value: hd.bloodGroup!,
                w: w,
                h: h),
            _divider(),
          ],
          if (hd.knownAllergies != null &&
              hd.knownAllergies!.isNotEmpty) ...[
            _infoRow(context,
                icon: Icons.warning_amber_outlined,
                label: 'Known Allergies',
                value: hd.knownAllergies!,
                w: w,
                h: h),
            _divider(),
          ],
          if (hd.geneticDisorders != null &&
              hd.geneticDisorders!.isNotEmpty) ...[
            _infoRow(context,
                icon: Icons.biotech_outlined,
                label: 'Genetic Disorders',
                value: hd.geneticDisorders!,
                w: w,
                h: h),
            _divider(),
          ],
          if (hd.chronicConditions != null &&
              hd.chronicConditions!.isNotEmpty)
            _infoRow(context,
                icon: Icons.local_hospital_outlined,
                label: 'Chronic Conditions',
                value: hd.chronicConditions!,
                w: w,
                h: h),
        ],
      ),
    );
  }

  Widget _buildFamilyHistoryCard(
      BuildContext context, ChildHealthData hd, double w, double h) {
    return _card(
      context,
      title: 'Family History',
      icon: Icons.family_restroom_outlined,
      w: w,
      h: h,
      child: Column(
        children: [
          _historyRow(context,
              label: 'ASD History',
              value: hd.familyHistoryAsd,
              w: w,
              h: h),
          _divider(),
          _historyRow(context,
              label: 'Speech Disorders',
              value: hd.familyHistorysSpeechDisorders,
              w: w,
              h: h),
          _divider(),
          _historyRow(context,
              label: 'Hearing Loss',
              value: hd.familyHistoryHearingLoss,
              w: w,
              h: h),
        ],
      ),
    );
  }

  Widget _buildMedicalRecordsCard(
      BuildContext context, ChildHealthData hd, double w, double h) {
    final records = hd.medicalRecords ?? [];
    return _card(
      context,
      title: 'Medical Records',
      icon: Icons.folder_outlined,
      w: w,
      h: h,
      trailing: Text(
        '${records.length} file${records.length != 1 ? 's' : ''}',
        style: GoogleFonts.poppins(
          fontSize: w * 0.033,
          color: AppColors.textSecondaryColor,
        ),
      ),
      child: records.isEmpty
          ? Padding(
              padding: EdgeInsets.symmetric(vertical: h * 0.02),
              child: Center(
                child: Text(
                  'No medical records uploaded',
                  style: GoogleFonts.poppins(
                    fontSize: w * 0.036,
                    color: AppColors.textSecondaryColor,
                  ),
                ),
              ),
            )
          : Column(
              children: records
                  .map((r) => _buildRecordTile(context, r, w, h))
                  .toList(),
            ),
    );
  }

  Widget _buildRecordTile(
      BuildContext context, MedicalRecord record, double w, double h) {
    return Container(
      margin: EdgeInsets.only(bottom: h * 0.012),
      padding: EdgeInsets.all(w * 0.035),
      decoration: BoxDecoration(
        color: AppColors.lightGreyColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.picture_as_pdf,
                color: AppColors.primaryColor, size: 22),
          ),
          SizedBox(width: w * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  record.fileName,
                  style: GoogleFonts.poppins(
                    fontSize: w * 0.036,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimaryColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: h * 0.004),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        record.getDocumentTypeDisplay(),
                        style: GoogleFonts.poppins(
                          fontSize: w * 0.028,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(width: w * 0.02),
                    Text(
                      _formatDate(record.uploadedAt),
                      style: GoogleFonts.poppins(
                        fontSize: w * 0.028,
                        color: AppColors.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (!isCreationFlow)
            IconButton(
              icon: const Icon(Icons.delete_outline,
                  color: AppColors.errorColor, size: 20),
              onPressed: () => _showDeleteRecordDialog(record),
            ),
        ],
      ),
    );
  }

  Widget _card(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Widget child,
    required double w,
    required double h,
    Widget? trailing,
  }) {
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
                  child: Icon(icon,
                      color: AppColors.primaryColor, size: 20),
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

  Widget _infoRow(BuildContext context,
      {required IconData icon,
      required String label,
      required String value,
      required double w,
      required double h}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: h * 0.008),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryColor, size: 20),
          SizedBox(width: w * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: w * 0.03,
                    color: AppColors.textSecondaryColor,
                  ),
                ),
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: w * 0.038,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _historyRow(BuildContext context,
      {required String label,
      required bool value,
      required double w,
      required double h}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: h * 0.008),
      child: Row(
        children: [
          Icon(
            value
                ? Icons.check_circle_outline
                : Icons.cancel_outlined,
            color: value
                ? AppColors.errorColor
                : AppColors.successColor,
            size: 20,
          ),
          SizedBox(width: w * 0.03),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: w * 0.037,
                color: AppColors.textPrimaryColor,
              ),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              color: (value
                      ? AppColors.errorColor
                      : AppColors.successColor)
                  .withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              value ? 'Yes' : 'No',
              style: GoogleFonts.poppins(
                fontSize: w * 0.033,
                fontWeight: FontWeight.w600,
                color: value
                    ? AppColors.errorColor
                    : AppColors.successColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Divider(
            color: AppColors.greyColor.withOpacity(0.2), height: 1),
      );

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('MMM dd, yyyy').format(date);
    } catch (_) {
      return dateStr;
    }
  }

  String _fmt(String type) => type
      .split('_')
      .map((w) => w[0].toUpperCase() + w.substring(1))
      .join(' ');
}