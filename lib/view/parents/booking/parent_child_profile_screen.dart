// // lib/view/parents/booking/parent_child_profile_screen.dart
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/child_profile_controller.dart';
// import 'package:speechspectrum/controllers/expert_child_data_controller.dart';
// import 'package:speechspectrum/models/child_profile_model.dart';
// import 'package:speechspectrum/routes/app_routes.dart';
// import 'package:speechspectrum/services/expert_child_data_service.dart';

// class ParentChildProfileScreen extends StatefulWidget {
//   const ParentChildProfileScreen({super.key});

//   @override
//   State<ParentChildProfileScreen> createState() =>
//       _ParentChildProfileScreenState();
// }

// class _ParentChildProfileScreenState extends State<ParentChildProfileScreen>
//     with SingleTickerProviderStateMixin {
//   late final ChildProfileController _profileCtrl;
//   late final ExpertChildDataController _dataCtrl;
//   late final TabController _tab;
//   late final String _childId;
//   late final String _childName;

//   static const _tabs = [
//     ('Overview', Icons.person_outline_rounded),
//     ('Health', Icons.favorite_border_rounded),
//     ('Screening', Icons.assignment_outlined),
//     ('Speech', Icons.mic_outlined),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     final args = Get.arguments as Map<String, dynamic>? ?? {};
//     _childId = args['childId'] ?? '';
//     _childName = args['childName'] ?? 'Child Profile';

//     _tab = TabController(length: _tabs.length, vsync: this);

//     _profileCtrl = Get.isRegistered<ChildProfileController>()
//         ? Get.find<ChildProfileController>()
//         : Get.put(ChildProfileController());

//     _dataCtrl = Get.isRegistered<ExpertChildDataController>()
//         ? Get.find<ExpertChildDataController>()
//         : Get.put(ExpertChildDataController());

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (_childId.isNotEmpty) {
//         _profileCtrl.loadAll(_childId);
//         _dataCtrl.fetchScreening(_childId);
//         _dataCtrl.fetchSpeech(_childId);
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _tab.dispose();
//     super.dispose();
//   }

//   // ── PDF: Screening ────────────────────────────────────────────────────────

//   Future<void> _downloadScreeningPdf(
//       BuildContext context, ExpertScreeningItem item) async {
//     try {
//       final hasResult = item.questionnaireResults.isNotEmpty;
//       final result = hasResult ? item.questionnaireResults.first.result : null;

//       final pdf = pw.Document();
//       pdf.addPage(
//         pw.MultiPage(
//           pageFormat: PdfPageFormat.a4,
//           margin: const pw.EdgeInsets.all(40),
//           build: (pw.Context ctx) => [
//             pw.Container(
//               padding: const pw.EdgeInsets.all(20),
//               decoration: pw.BoxDecoration(
//                 color: PdfColor.fromHex('6C63FF'),
//                 borderRadius:
//                     const pw.BorderRadius.all(pw.Radius.circular(12)),
//               ),
//               child: pw.Column(
//                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 children: [
//                   pw.Text('ASD Screening Report',
//                       style: pw.TextStyle(
//                           fontSize: 24,
//                           fontWeight: pw.FontWeight.bold,
//                           color: PdfColors.white)),
//                   pw.SizedBox(height: 6),
//                   pw.Text('SpeechSpectrum — Parent View',
//                       style: const pw.TextStyle(
//                           fontSize: 12, color: PdfColors.white)),
//                 ],
//               ),
//             ),
//             pw.SizedBox(height: 20),

//             if (result != null) ...[
//               pw.Container(
//                 padding: const pw.EdgeInsets.all(16),
//                 decoration: pw.BoxDecoration(
//                   border:
//                       pw.Border.all(color: PdfColor.fromHex('E0E0E0')),
//                   borderRadius:
//                       const pw.BorderRadius.all(pw.Radius.circular(8)),
//                 ),
//                 child: pw.Column(
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: [
//                     pw.Text('Screening Result',
//                         style: pw.TextStyle(
//                             fontSize: 16,
//                             fontWeight: pw.FontWeight.bold)),
//                     pw.SizedBox(height: 10),
//                     _pdfRow('Child', _childName),
//                     pw.SizedBox(height: 4),
//                     _pdfRow('Prediction', result.prediction),
//                     pw.SizedBox(height: 4),
//                     _pdfRow('Probability', result.probability),
//                     pw.SizedBox(height: 4),
//                     _pdfRow('Date', item.formattedDate),
//                     pw.SizedBox(height: 4),
//                     _pdfRow('Time', item.formattedTime),
//                   ],
//                 ),
//               ),
//               pw.SizedBox(height: 20),
//             ],

//             pw.Text('Submission Information',
//                 style: pw.TextStyle(
//                     fontSize: 14, fontWeight: pw.FontWeight.bold)),
//             pw.SizedBox(height: 8),
//             pw.Container(
//               padding: const pw.EdgeInsets.all(12),
//               decoration: pw.BoxDecoration(
//                 color: PdfColor.fromHex('F8F9FA'),
//                 borderRadius:
//                     const pw.BorderRadius.all(pw.Radius.circular(8)),
//               ),
//               child: pw.Column(
//                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 children: [
//                   _pdfRow('Age (Months)',
//                       '${item.responses['Age_Mons'] ?? 'N/A'}'),
//                   _pdfRow('Gender',
//                       item.responses['Sex'] == 1 ? 'Male' : 'Female'),
//                   _pdfRow('Jaundice History',
//                       item.responses['Jaundice'] == 1 ? 'Yes' : 'No'),
//                   _pdfRow('Family ASD History',
//                       item.responses['Family_mem_with_ASD'] == 1
//                           ? 'Yes'
//                           : 'No'),
//                 ],
//               ),
//             ),
//             pw.SizedBox(height: 20),

//             pw.Text('Questionnaire Responses',
//                 style: pw.TextStyle(
//                     fontSize: 14, fontWeight: pw.FontWeight.bold)),
//             pw.SizedBox(height: 8),
//             ...[
//               'A1','A2','A3','A4','A5','A6','A7','A8','A9','A10'
//             ].map((key) {
//               final val = item.responses[key];
//               final isPositive = val == 1;
//               return pw.Container(
//                 margin: const pw.EdgeInsets.only(bottom: 6),
//                 padding: const pw.EdgeInsets.symmetric(
//                     horizontal: 12, vertical: 8),
//                 decoration: pw.BoxDecoration(
//                   color: isPositive
//                       ? PdfColor.fromHex('E8F5E9')
//                       : PdfColor.fromHex('FFEBEE'),
//                   borderRadius:
//                       const pw.BorderRadius.all(pw.Radius.circular(6)),
//                 ),
//                 child: pw.Row(
//                   mainAxisAlignment:
//                       pw.MainAxisAlignment.spaceBetween,
//                   children: [
//                     pw.Expanded(
//                         child: pw.Text(_questionLabel(key),
//                             style:
//                                 const pw.TextStyle(fontSize: 11))),
//                     pw.SizedBox(width: 10),
//                     pw.Text(
//                       isPositive ? 'Positive' : 'Negative',
//                       style: pw.TextStyle(
//                         fontSize: 11,
//                         fontWeight: pw.FontWeight.bold,
//                         color: isPositive
//                             ? PdfColor.fromHex('388E3C')
//                             : PdfColor.fromHex('D32F2F'),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             }).toList(),

//             pw.SizedBox(height: 20),
//             pw.Container(
//               padding: const pw.EdgeInsets.all(12),
//               decoration: pw.BoxDecoration(
//                 color: PdfColor.fromHex('FFF8E1'),
//                 borderRadius:
//                     const pw.BorderRadius.all(pw.Radius.circular(8)),
//               ),
//               child: pw.Text(
//                 'Disclaimer: This is a screening tool, not a diagnostic assessment. '
//                 'Professional evaluation by a qualified healthcare provider is recommended.',
//                 style: const pw.TextStyle(fontSize: 10),
//               ),
//             ),
//           ],
//         ),
//       );

//       final Uint8List bytes = await pdf.save();
//       final dir = await getApplicationDocumentsDirectory();
//       final childSafe = _childName.replaceAll(RegExp(r'[^\w]'), '_');
//       final file = File(
//           '${dir.path}/ASD_Screening_${childSafe}_${item.submissionId}.pdf');
//       await file.writeAsBytes(bytes);
//       await OpenFile.open(file.path);
//     } catch (e) {
//       Get.snackbar('Error', 'Could not generate PDF: $e',
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: AppColors.errorColor,
//           colorText: Colors.white,
//           margin: const EdgeInsets.all(16),
//           borderRadius: 12);
//     }
//   }

//   Future<void> _downloadSpeechPdf(
//       BuildContext context, ExpertSpeechItem item) async {
//     try {
//       final analysisResult = item.latestResult?.result;
//       if (analysisResult == null) return;

//       final pdf = pw.Document();
//       pdf.addPage(
//         pw.MultiPage(
//           pageFormat: PdfPageFormat.a4,
//           margin: const pw.EdgeInsets.all(40),
//           build: (pw.Context ctx) => [
//             pw.Container(
//               padding: const pw.EdgeInsets.all(20),
//               decoration: pw.BoxDecoration(
//                 color: PdfColor.fromHex('6C63FF'),
//                 borderRadius:
//                     const pw.BorderRadius.all(pw.Radius.circular(12)),
//               ),
//               child: pw.Column(
//                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 children: [
//                   pw.Text('Speech Analysis Report',
//                       style: pw.TextStyle(
//                           fontSize: 24,
//                           fontWeight: pw.FontWeight.bold,
//                           color: PdfColors.white)),
//                   pw.SizedBox(height: 6),
//                   pw.Text('SpeechSpectrum — Parent View',
//                       style: const pw.TextStyle(
//                           fontSize: 12, color: PdfColors.white)),
//                 ],
//               ),
//             ),
//             pw.SizedBox(height: 20),

//             pw.Container(
//               padding: const pw.EdgeInsets.all(16),
//               decoration: pw.BoxDecoration(
//                 border:
//                     pw.Border.all(color: PdfColor.fromHex('E0E0E0')),
//                 borderRadius:
//                     const pw.BorderRadius.all(pw.Radius.circular(8)),
//               ),
//               child: pw.Column(
//                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 children: [
//                   pw.Text('Analysis Result',
//                       style: pw.TextStyle(
//                           fontSize: 16,
//                           fontWeight: pw.FontWeight.bold)),
//                   pw.SizedBox(height: 10),
//                   _pdfRow('Child', _childName),
//                   pw.SizedBox(height: 4),
//                   _pdfRow('Risk Level', analysisResult.riskInterpretation),
//                   pw.SizedBox(height: 4),
//                   _pdfRow('Severity Score',
//                       '${analysisResult.severityScore} / ${analysisResult.maxScore}'),
//                   pw.SizedBox(height: 4),
//                   _pdfRow('Date', item.formattedDate),
//                   pw.SizedBox(height: 4),
//                   _pdfRow('Time', item.formattedTime),
//                   pw.SizedBox(height: 4),
//                   _pdfRow('Duration',
//                       '${item.recordingDurationSeconds} seconds'),
//                 ],
//               ),
//             ),
//             pw.SizedBox(height: 20),

//             if (analysisResult.bioMarkers != null) ...[
//               pw.Text('Bio-markers',
//                   style: pw.TextStyle(
//                       fontSize: 14, fontWeight: pw.FontWeight.bold)),
//               pw.SizedBox(height: 8),
//               pw.Container(
//                 padding: const pw.EdgeInsets.all(12),
//                 decoration: pw.BoxDecoration(
//                   color: PdfColor.fromHex('F8F9FA'),
//                   borderRadius:
//                       const pw.BorderRadius.all(pw.Radius.circular(8)),
//                 ),
//                 child: pw.Column(
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: [
//                     _pdfRow('Pitch Instability',
//                         '${analysisResult.bioMarkers!.pitchInstability.toStringAsFixed(1)} Hz'),
//                     pw.SizedBox(height: 4),
//                     _pdfRow('Resonance Jitter F1',
//                         '${analysisResult.bioMarkers!.resonanceJitterF1.toStringAsFixed(1)} Hz'),
//                     pw.SizedBox(height: 4),
//                     _pdfRow('Resonance Jitter F2',
//                         '${analysisResult.bioMarkers!.resonanceJitterF2.toStringAsFixed(1)} Hz'),
//                   ],
//                 ),
//               ),
//               pw.SizedBox(height: 20),
//             ],

//             pw.Text('Interpretation',
//                 style: pw.TextStyle(
//                     fontSize: 14, fontWeight: pw.FontWeight.bold)),
//             pw.SizedBox(height: 8),
//             pw.Container(
//               padding: const pw.EdgeInsets.all(12),
//               decoration: pw.BoxDecoration(
//                 color: PdfColor.fromHex('F8F9FA'),
//                 borderRadius:
//                     const pw.BorderRadius.all(pw.Radius.circular(8)),
//               ),
//               child: pw.Text(
//                 _speechInterpretation(analysisResult),
//                 style: const pw.TextStyle(fontSize: 11),
//               ),
//             ),
//             pw.SizedBox(height: 20),

//             pw.Container(
//               padding: const pw.EdgeInsets.all(12),
//               decoration: pw.BoxDecoration(
//                 color: PdfColor.fromHex('FFF8E1'),
//                 borderRadius:
//                     const pw.BorderRadius.all(pw.Radius.circular(8)),
//               ),
//               child: pw.Text(
//                 'Disclaimer: This is a screening tool, not a diagnostic assessment. '
//                 'Professional evaluation by a qualified healthcare provider is recommended.',
//                 style: const pw.TextStyle(fontSize: 10),
//               ),
//             ),
//           ],
//         ),
//       );

//       final Uint8List bytes = await pdf.save();
//       final dir = await getApplicationDocumentsDirectory();
//       final childSafe = _childName.replaceAll(RegExp(r'[^\w]'), '_');
//       final file = File(
//           '${dir.path}/Speech_Report_${childSafe}_${item.speechSubmissionId}.pdf');
//       await file.writeAsBytes(bytes);
//       await OpenFile.open(file.path);
//     } catch (e) {
//       Get.snackbar('Error', 'Could not generate PDF: $e',
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: AppColors.errorColor,
//           colorText: Colors.white,
//           margin: const EdgeInsets.all(16),
//           borderRadius: 12);
//     }
//   }

//   pw.Widget _pdfRow(String label, String value) {
//     return pw.Padding(
//       padding: const pw.EdgeInsets.only(bottom: 4),
//       child: pw.Row(children: [
//         pw.Text('$label: ',
//             style: pw.TextStyle(
//                 fontWeight: pw.FontWeight.bold, fontSize: 11)),
//         pw.Text(value, style: const pw.TextStyle(fontSize: 11)),
//       ]),
//     );
//   }

//   String _questionLabel(String key) {
//     const map = {
//       'A1': 'Does your child look at you when called?',
//       'A2': 'How easy is eye contact with your child?',
//       'A3': 'Does your child point to indicate wants?',
//       'A4': 'Does your child point to share interest?',
//       'A5': 'Does your child pretend play?',
//       'A6': 'Does your child follow where you\'re looking?',
//       'A7': 'Does your child show signs of comforting others?',
//       'A8': 'How would you describe first words?',
//       'A9': 'Does your child use simple gestures?',
//       'A10': 'Does your child stare at nothing?',
//     };
//     return map[key] ?? key;
//   }

//   String _speechInterpretation(ExpertSpeechAnalysis r) {
//     if (r.isLowRisk) {
//       return 'The speech pattern shows low-risk indicators and appears within a typical developmental range.';
//     } else if (r.isModerateRisk) {
//       return 'The speech pattern shows moderate-risk characteristics. Consider consulting a speech therapist.';
//     } else {
//       return 'The speech pattern shows high-risk indicators. Professional speech therapy intervention is strongly recommended.';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();
//     return Scaffold(
//       backgroundColor: AppColors.lightGreyColor,
//       body: Obx(() {
//         final isLoading = _profileCtrl.isLoadingProfile.value ||
//             _profileCtrl.isLoadingHealth.value;
//         final profile = _profileCtrl.childProfile.value;

//         return NestedScrollView(
//           headerSliverBuilder: (ctx, inner) => [
//             _buildSliverAppBar(context, size, profile, isLoading),
//           ],
//           body: isLoading && profile == null
//               ? _buildLoader()
//               : TabBarView(
//                   controller: _tab,
//                   children: [
//                     _buildOverviewTab(context, size),
//                     _buildHealthTab(context, size),
//                     _buildScreeningTab(context, size),
//                     _buildSpeechTab(context, size),
//                   ],
//                 ),
//         );
//       }),
//     );
//   }

//   // ── SliverAppBar ──────────────────────────────────────────────────────────

//   Widget _buildSliverAppBar(
//     BuildContext context,
//     CustomSize size,
//     ChildData? profile,
//     bool isLoading,
//   ) {
//     return SliverAppBar(
//       expandedHeight: 230,
//       pinned: true,
//       backgroundColor: AppColors.primaryColor,
//       surfaceTintColor: Colors.transparent,
//       leading: IconButton(
//         icon: const Icon(Icons.arrow_back_ios_new_rounded,
//             color: Colors.white, size: 20),
//         onPressed: () => Get.back(),
//       ),
//       actions: [
//         if (isLoading)
//           const Padding(
//             padding: EdgeInsets.all(14),
//             child: SizedBox(
//               width: 20,
//               height: 20,
//               child: CircularProgressIndicator(
//                   color: Colors.white, strokeWidth: 2),
//             ),
//           )
//         else
//           IconButton(
//             icon: const Icon(Icons.refresh_rounded, color: Colors.white),
//             onPressed: () {
//               _profileCtrl.refreshProfile(_childId);
//               _dataCtrl.fetchScreening(_childId);
//               _dataCtrl.fetchSpeech(_childId);
//             },
//           ),
//         const SizedBox(width: 4),
//       ],
//       flexibleSpace: FlexibleSpaceBar(
//         background: _buildAppBarBackground(profile),
//       ),
//       bottom: TabBar(
//         controller: _tab,
//         labelColor: Colors.white,
//         unselectedLabelColor: Colors.white60,
//         indicatorColor: Colors.white,
//         indicatorWeight: 3,
//         isScrollable: true,
//         tabAlignment: TabAlignment.start,
//         labelStyle:
//             GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12.5),
//         unselectedLabelStyle:
//             GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 12.5),
//         tabs: _tabs
//             .map((t) => Tab(
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(t.$2, size: 14),
//                       const SizedBox(width: 5),
//                       Text(t.$1),
//                     ],
//                   ),
//                 ))
//             .toList(),
//       ),
//     );
//   }

//   Widget _buildAppBarBackground(ChildData? profile) {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [AppColors.primaryColor, AppColors.secondaryColor],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       child: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const SizedBox(height: 12),
//             Container(
//               width: 80,
//               height: 80,
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.2),
//                 shape: BoxShape.circle,
//                 border: Border.all(color: Colors.white, width: 3),
//               ),
//               child: Center(
//                 child: Text(
//                   profile?.initials ?? _initials(_childName),
//                   style: GoogleFonts.poppins(
//                     color: Colors.white,
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               profile?.childName ?? _childName,
//               style: GoogleFonts.poppins(
//                 color: Colors.white,
//                 fontSize: 20,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//             if (profile != null) ...[
//               const SizedBox(height: 4),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   _pillChip(
//                     profile.gender[0].toUpperCase() +
//                         profile.gender.substring(1),
//                     profile.gender.toLowerCase() == 'male'
//                         ? Icons.male_rounded
//                         : Icons.female_rounded,
//                   ),
//                   const SizedBox(width: 8),
//                   _pillChip(profile.age, Icons.cake_outlined),
//                 ],
//               ),
//             ],
//             const SizedBox(height: 50),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _pillChip(String label, IconData icon) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.2),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: Colors.white.withOpacity(0.4)),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, color: Colors.white, size: 12),
//           const SizedBox(width: 4),
//           Text(label,
//               style: GoogleFonts.poppins(
//                   color: Colors.white,
//                   fontSize: 11,
//                   fontWeight: FontWeight.w500)),
//         ],
//       ),
//     );
//   }

//   // ── Overview Tab ──────────────────────────────────────────────────────────

//   Widget _buildOverviewTab(BuildContext context, CustomSize size) {
//     return Obx(() {
//       final profile = _profileCtrl.childProfile.value;
//       if (profile == null) return _buildEmpty('No profile data available');

//       return ListView(
//         padding: EdgeInsets.fromLTRB(
//           size.customWidth(context) * 0.045,
//           size.customHeight(context) * 0.02,
//           size.customWidth(context) * 0.045,
//           size.customHeight(context) * 0.04,
//         ),
//         children: [
//           _sectionCard(
//             title: 'Basic Information',
//             icon: Icons.person_outline_rounded,
//             children: [
//               _infoRow('Full Name', profile.childName, Icons.badge_outlined),
//               _divider(),
//               _infoRow(
//                   'Date of Birth', profile.formattedDob, Icons.cake_outlined),
//               _divider(),
//               _infoRow('Age', profile.age, Icons.hourglass_bottom_rounded),
//               _divider(),
//               _infoRow(
//                 'Gender',
//                 profile.gender[0].toUpperCase() + profile.gender.substring(1),
//                 profile.gender.toLowerCase() == 'male'
//                     ? Icons.male_rounded
//                     : Icons.female_rounded,
//               ),
//             ],
//           ),
//           SizedBox(height: size.customHeight(context) * 0.018),
//           _buildHealthSnapshotCard(context, size),
//         ],
//       );
//     });
//   }

//   Widget _buildHealthSnapshotCard(BuildContext context, CustomSize size) {
//     return Obx(() {
//       final health = _profileCtrl.childHealth.value;
//       if (health == null) return const SizedBox.shrink();

//       return _sectionCard(
//         title: 'Health Snapshot',
//         icon: Icons.monitor_heart_outlined,
//         children: [
//           Row(
//             children: [
//               Expanded(
//                   child: _metricBox(
//                       'Weight',
//                       health.weightKg != null
//                           ? '${health.weightKg!.toStringAsFixed(1)} kg'
//                           : '—',
//                       Icons.scale_outlined,
//                       AppColors.primaryColor)),
//               const SizedBox(width: 10),
//               Expanded(
//                   child: _metricBox(
//                       'Height',
//                       health.heightCm != null
//                           ? '${health.heightCm!.toStringAsFixed(1)} cm'
//                           : '—',
//                       Icons.height_rounded,
//                       AppColors.secondaryColor)),
//               const SizedBox(width: 10),
//               Expanded(
//                   child: _metricBox(
//                       'BMI',
//                       health.bmi != null
//                           ? health.bmi!.toStringAsFixed(2)
//                           : '—',
//                       Icons.analytics_outlined,
//                       AppColors.accentColor)),
//             ],
//           ),
//           if (health.bloodGroup != null) ...[
//             const SizedBox(height: 12),
//             _divider(),
//             const SizedBox(height: 4),
//             _infoRow(
//                 'Blood Group', health.bloodGroup!, Icons.bloodtype_outlined),
//           ],
//         ],
//       );
//     });
//   }

//   // ── Health Tab ────────────────────────────────────────────────────────────

//   Widget _buildHealthTab(BuildContext context, CustomSize size) {
//     return Obx(() {
//       if (_profileCtrl.isLoadingHealth.value &&
//           _profileCtrl.childHealth.value == null) {
//         return _buildLoader();
//       }
//       final health = _profileCtrl.childHealth.value;
//       if (health == null) {
//         return _buildEmpty('No health profile available for this child');
//       }

//       return ListView(
//         padding: EdgeInsets.fromLTRB(
//           size.customWidth(context) * 0.045,
//           size.customHeight(context) * 0.02,
//           size.customWidth(context) * 0.045,
//           size.customHeight(context) * 0.04,
//         ),
//         children: [
//           _sectionCard(
//             title: 'Vitals',
//             icon: Icons.monitor_heart_outlined,
//             children: [
//               Row(
//                 children: [
//                   Expanded(
//                       child: _metricBox(
//                           'Weight',
//                           health.weightKg != null
//                               ? '${health.weightKg!.toStringAsFixed(1)} kg'
//                               : '—',
//                           Icons.scale_outlined,
//                           AppColors.primaryColor)),
//                   const SizedBox(width: 10),
//                   Expanded(
//                       child: _metricBox(
//                           'Height',
//                           health.heightCm != null
//                               ? '${health.heightCm!.toStringAsFixed(1)} cm'
//                               : '—',
//                           Icons.height_rounded,
//                           AppColors.secondaryColor)),
//                   const SizedBox(width: 10),
//                   Expanded(
//                       child: _metricBox(
//                           'BMI',
//                           health.bmi != null
//                               ? health.bmi!.toStringAsFixed(2)
//                               : '—',
//                           Icons.analytics_outlined,
//                           AppColors.accentColor)),
//                 ],
//               ),
//               if (health.bloodGroup != null) ...[
//                 const SizedBox(height: 12),
//                 _divider(),
//                 const SizedBox(height: 4),
//                 _infoRow('Blood Group', health.bloodGroup!,
//                     Icons.bloodtype_outlined,
//                     valueColor: AppColors.errorColor),
//               ],
//             ],
//           ),
//           SizedBox(height: size.customHeight(context) * 0.018),
//           _sectionCard(
//             title: 'Conditions & Allergies',
//             icon: Icons.medical_services_outlined,
//             children: [
//               if (health.knownAllergies != null &&
//                   health.knownAllergies!.isNotEmpty &&
//                   health.knownAllergies!.toLowerCase() != 'none') ...[
//                 _alertRow('Known Allergies', health.knownAllergies!,
//                     Icons.warning_amber_rounded, AppColors.warningColor),
//                 _divider(),
//               ],
//               if (health.chronicConditions != null &&
//                   health.chronicConditions!.isNotEmpty &&
//                   health.chronicConditions!.toLowerCase() != 'none') ...[
//                 _alertRow('Chronic Conditions', health.chronicConditions!,
//                     Icons.local_hospital_outlined, AppColors.errorColor),
//                 _divider(),
//               ],
//               if (health.geneticDisorders != null &&
//                   health.geneticDisorders!.isNotEmpty &&
//                   health.geneticDisorders!.toLowerCase() != 'none')
//                 _alertRow('Genetic Disorders', health.geneticDisorders!,
//                     Icons.biotech_outlined, const Color(0xFF7B1FA2))
//               else
//                 _infoRow('Genetic Disorders', 'None reported',
//                     Icons.biotech_outlined),
//             ],
//           ),
//           SizedBox(height: size.customHeight(context) * 0.018),
//           _sectionCard(
//             title: 'Family History',
//             icon: Icons.family_restroom_rounded,
//             children: [
//               _familyHistoryRow(
//                   'ASD History', health.familyHistoryAsd,
//                   Icons.psychology_outlined),
//               _divider(),
//               _familyHistoryRow('Speech Disorders',
//                   health.familyHistorySpeechDisorders,
//                   Icons.record_voice_over_outlined),
//               _divider(),
//               _familyHistoryRow('Hearing Loss',
//                   health.familyHistoryHearingLoss, Icons.hearing_outlined),
//             ],
//           ),
//           SizedBox(height: size.customHeight(context) * 0.018),
//           if (health.medicalRecords.isNotEmpty)
//             _sectionCard(
//               title: 'Medical Records (${health.medicalRecords.length})',
//               icon: Icons.folder_outlined,
//               children: health.medicalRecords
//                   .map((r) => _recordRow(r))
//                   .toList(),
//             ),
//         ],
//       );
//     });
//   }

//   Widget _recordRow(MedicalRecord record) {
//     final color = _docTypeColor(record.documentType);
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Row(
//         children: [
//           Container(
//             width: 38,
//             height: 38,
//             decoration: BoxDecoration(
//               color: color.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(10),
//               border: Border.all(color: color.withOpacity(0.3)),
//             ),
//             child: Icon(_docTypeIcon(record.documentType),
//                 color: color, size: 18),
//           ),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(record.displayName,
//                     style: GoogleFonts.poppins(
//                         fontSize: 12.5,
//                         fontWeight: FontWeight.w600,
//                         color: AppColors.textPrimaryColor),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis),
//                 Text(record.formattedUploadDate,
//                     style: GoogleFonts.poppins(
//                         fontSize: 11,
//                         color: AppColors.textSecondaryColor)),
//               ],
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
//             decoration: BoxDecoration(
//               color: color.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(6),
//             ),
//             child: Text(_docTypeLabel(record.documentType),
//                 style: GoogleFonts.poppins(
//                     fontSize: 10,
//                     fontWeight: FontWeight.w600,
//                     color: color)),
//           ),
//         ],
//       ),
//     );
//   }

//   // ── Screening Tab ─────────────────────────────────────────────────────────

//   Widget _buildScreeningTab(BuildContext context, CustomSize size) {
//     return Obx(() {
//       if (_dataCtrl.isLoadingScreening.value &&
//           _dataCtrl.screeningList.isEmpty) {
//         return _buildLoader();
//       }

//       return Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.fromLTRB(
//               size.customWidth(context) * 0.045,
//               size.customHeight(context) * 0.015,
//               size.customWidth(context) * 0.045,
//               size.customHeight(context) * 0.01,
//             ),
//             child: _searchBar(
//               hint: 'Search by probability or result...',
//               onChanged: _dataCtrl.filterScreening,
//               value: _dataCtrl.screeningSearch.value,
//             ),
//           ),
//           Expanded(
//             child: _dataCtrl.filteredScreeningList.isEmpty
//                 ? _buildEmpty(_dataCtrl.screeningSearch.value.isNotEmpty
//                     ? 'No results match your search'
//                     : 'No screening submissions for this child')
//                 : RefreshIndicator(
//                     color: AppColors.primaryColor,
//                     onRefresh: () => _dataCtrl.fetchScreening(_childId),
//                     child: ListView.builder(
//                       padding: EdgeInsets.fromLTRB(
//                         size.customWidth(context) * 0.045,
//                         0,
//                         size.customWidth(context) * 0.045,
//                         size.customHeight(context) * 0.04,
//                       ),
//                       itemCount: _dataCtrl.filteredScreeningList.length,
//                       itemBuilder: (_, i) => _screeningCard(
//                           context, size, _dataCtrl.filteredScreeningList[i]),
//                     ),
//                   ),
//           ),
//         ],
//       );
//     });
//   }

//   Widget _screeningCard(BuildContext context, CustomSize size,
//       ExpertScreeningItem item) {
//     final hasResult = item.questionnaireResults.isNotEmpty;
//     final result =
//         hasResult ? item.questionnaireResults.first.result : null;

//     Color riskColor = AppColors.greyColor;
//     if (result != null) {
//       if (result.isHighRisk) riskColor = AppColors.errorColor;
//       else if (result.isMediumRisk) riskColor = AppColors.warningColor;
//       else riskColor = AppColors.successColor;
//     }

//     return Container(
//       margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.014),
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(18),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withOpacity(0.06),
//               blurRadius: 14,
//               offset: const Offset(0, 4))
//         ],
//       ),
//       child: Column(
//         children: [
//           Container(
//             height: 4,
//             decoration: BoxDecoration(
//               color: riskColor,
//               borderRadius:
//                   const BorderRadius.vertical(top: Radius.circular(18)),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       width: 52,
//                       height: 52,
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: [
//                             riskColor.withOpacity(0.7),
//                             riskColor
//                           ],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                         borderRadius: BorderRadius.circular(14),
//                       ),
//                       child: const Icon(Icons.assignment_outlined,
//                           size: 26, color: Colors.white),
//                     ),
//                     SizedBox(width: size.customWidth(context) * 0.03),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(item.formattedDate,
//                               style: GoogleFonts.poppins(
//                                   fontSize: 13.5,
//                                   fontWeight: FontWeight.w700,
//                                   color: AppColors.textPrimaryColor)),
//                           const SizedBox(height: 2),
//                           Text(item.formattedTime,
//                               style: GoogleFonts.poppins(
//                                   fontSize: 11.5,
//                                   color: AppColors.textSecondaryColor)),
//                         ],
//                       ),
//                     ),
//                     if (result != null) ...[
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 10, vertical: 4),
//                             decoration: BoxDecoration(
//                               color: riskColor.withOpacity(0.1),
//                               borderRadius: BorderRadius.circular(20),
//                               border:
//                                   Border.all(color: riskColor.withOpacity(0.3)),
//                             ),
//                             child: Text(
//                               result.probability,
//                               style: GoogleFonts.poppins(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.bold,
//                                   color: riskColor),
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             result.prediction.length > 22
//                                 ? '${result.prediction.substring(0, 22)}...'
//                                 : result.prediction,
//                             style: GoogleFonts.poppins(
//                                 fontSize: 10.5,
//                                 color: riskColor,
//                                 fontWeight: FontWeight.w500),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ],
//                 ),

//                 SizedBox(height: size.customHeight(context) * 0.012),
//                 Divider(
//                     height: 1,
//                     color: AppColors.greyColor.withOpacity(0.15)),
//                 SizedBox(height: size.customHeight(context) * 0.01),

//                 // Bottom row: PDF download
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     if (hasResult)
//                       GestureDetector(
//                         onTap: () =>
//                             _downloadScreeningPdf(context, item),
//                         behavior: HitTestBehavior.opaque,
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 10, vertical: 5),
//                           decoration: BoxDecoration(
//                             color:
//                                 AppColors.primaryColor.withOpacity(0.06),
//                             borderRadius: BorderRadius.circular(20),
//                             border: Border.all(
//                                 color: AppColors.primaryColor
//                                     .withOpacity(0.2)),
//                           ),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               const Icon(Icons.picture_as_pdf_outlined,
//                                   size: 12,
//                                   color: AppColors.primaryColor),
//                               const SizedBox(width: 4),
//                               Text(
//                                 'Download PDF',
//                                 style: GoogleFonts.poppins(
//                                     fontSize: 11,
//                                     fontWeight: FontWeight.w600,
//                                     color: AppColors.primaryColor),
//                               ),
//                               const SizedBox(width: 4),
//                               const Icon(Icons.download_outlined,
//                                   size: 11,
//                                   color: AppColors.primaryColor),
//                             ],
//                           ),
//                         ),
//                       )
//                     else
//                       Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           const Icon(Icons.pending_rounded,
//                               size: 12, color: AppColors.warningColor),
//                           const SizedBox(width: 4),
//                           Text('Analysis pending',
//                               style: GoogleFonts.poppins(
//                                   fontSize: 11,
//                                   color: AppColors.warningColor,
//                                   fontWeight: FontWeight.w500)),
//                         ],
//                       ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ── Speech Tab ────────────────────────────────────────────────────────────

//   Widget _buildSpeechTab(BuildContext context, CustomSize size) {
//     return Obx(() {
//       if (_dataCtrl.isLoadingSpeech.value && _dataCtrl.speechList.isEmpty) {
//         return _buildLoader();
//       }

//       return Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.fromLTRB(
//               size.customWidth(context) * 0.045,
//               size.customHeight(context) * 0.015,
//               size.customWidth(context) * 0.045,
//               size.customHeight(context) * 0.01,
//             ),
//             child: _searchBar(
//               hint: 'Search by risk level...',
//               onChanged: _dataCtrl.filterSpeech,
//               value: _dataCtrl.speechSearch.value,
//             ),
//           ),
//           Expanded(
//             child: _dataCtrl.filteredSpeechList.isEmpty
//                 ? _buildEmpty(_dataCtrl.speechSearch.value.isNotEmpty
//                     ? 'No results match your search'
//                     : 'No speech submissions for this child')
//                 : RefreshIndicator(
//                     color: AppColors.primaryColor,
//                     onRefresh: () => _dataCtrl.fetchSpeech(_childId),
//                     child: ListView.builder(
//                       padding: EdgeInsets.fromLTRB(
//                         size.customWidth(context) * 0.045,
//                         0,
//                         size.customWidth(context) * 0.045,
//                         size.customHeight(context) * 0.04,
//                       ),
//                       itemCount: _dataCtrl.filteredSpeechList.length,
//                       itemBuilder: (_, i) => _speechCard(
//                           context, size, _dataCtrl.filteredSpeechList[i]),
//                     ),
//                   ),
//           ),
//         ],
//       );
//     });
//   }

//   Widget _speechCard(BuildContext context, CustomSize size,
//       ExpertSpeechItem item) {
//     final hasResult = item.hasResults;
//     final analysisResult = item.latestResult?.result;

//     Color riskColor = AppColors.greyColor;
//     IconData riskIcon = Icons.pending_rounded;
//     if (analysisResult != null) {
//       if (analysisResult.isHighRisk) {
//         riskColor = AppColors.errorColor;
//         riskIcon = Icons.warning_rounded;
//       } else if (analysisResult.isModerateRisk) {
//         riskColor = AppColors.warningColor;
//         riskIcon = Icons.info_rounded;
//       } else {
//         riskColor = AppColors.successColor;
//         riskIcon = Icons.check_circle_rounded;
//       }
//     }

//     return Container(
//       margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.014),
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(18),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withOpacity(0.06),
//               blurRadius: 14,
//               offset: const Offset(0, 4))
//         ],
//       ),
//       child: Column(
//         children: [
//           Container(
//             height: 4,
//             decoration: BoxDecoration(
//               color: riskColor,
//               borderRadius:
//                   const BorderRadius.vertical(top: Radius.circular(18)),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       width: 52,
//                       height: 52,
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: [
//                             riskColor.withOpacity(0.7),
//                             riskColor
//                           ],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                         borderRadius: BorderRadius.circular(14),
//                       ),
//                       child: Icon(riskIcon,
//                           size: 26, color: Colors.white),
//                     ),
//                     SizedBox(width: size.customWidth(context) * 0.03),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(item.formattedDate,
//                               style: GoogleFonts.poppins(
//                                   fontSize: 13.5,
//                                   fontWeight: FontWeight.w700,
//                                   color: AppColors.textPrimaryColor)),
//                           const SizedBox(height: 2),
//                           Row(
//                             children: [
//                               Icon(Icons.access_time_rounded,
//                                   size: 13,
//                                   color: AppColors.textSecondaryColor),
//                               const SizedBox(width: 3),
//                               Text('${item.recordingDurationSeconds}s',
//                                   style: GoogleFonts.poppins(
//                                       fontSize: 11.5,
//                                       color: AppColors.textSecondaryColor)),
//                               const SizedBox(width: 8),
//                               Icon(Icons.schedule_rounded,
//                                   size: 13,
//                                   color: AppColors.textSecondaryColor),
//                               const SizedBox(width: 3),
//                               Text(item.formattedTime,
//                                   style: GoogleFonts.poppins(
//                                       fontSize: 11.5,
//                                       color: AppColors.textSecondaryColor)),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),

//                 if (hasResult && analysisResult != null) ...[
//                   SizedBox(height: size.customHeight(context) * 0.012),
//                   Divider(
//                       height: 1,
//                       color: AppColors.greyColor.withOpacity(0.15)),
//                   SizedBox(height: size.customHeight(context) * 0.01),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(analysisResult.riskInterpretation,
//                                 style: GoogleFonts.poppins(
//                                     fontSize: 12.5,
//                                     fontWeight: FontWeight.w700,
//                                     color: riskColor)),
//                             const SizedBox(height: 4),
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(6),
//                               child: LinearProgressIndicator(
//                                 value: analysisResult.severityScore /
//                                     analysisResult.maxScore,
//                                 backgroundColor:
//                                     riskColor.withOpacity(0.15),
//                                 valueColor: AlwaysStoppedAnimation<Color>(
//                                     riskColor),
//                                 minHeight: 7,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 10, vertical: 5),
//                         decoration: BoxDecoration(
//                           color: riskColor.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(20),
//                           border: Border.all(
//                               color: riskColor.withOpacity(0.4)),
//                         ),
//                         child: Text(
//                           '${analysisResult.severityScore}/${analysisResult.maxScore}',
//                           style: GoogleFonts.poppins(
//                               fontSize: 12,
//                               fontWeight: FontWeight.bold,
//                               color: riskColor),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],

//                 SizedBox(height: size.customHeight(context) * 0.012),
//                 Divider(
//                     height: 1,
//                     color: AppColors.greyColor.withOpacity(0.15)),
//                 SizedBox(height: size.customHeight(context) * 0.01),

//                 // Bottom row: PDF download
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     if (hasResult && analysisResult != null)
//                       GestureDetector(
//                         onTap: () => _downloadSpeechPdf(context, item),
//                         behavior: HitTestBehavior.opaque,
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 10, vertical: 5),
//                           decoration: BoxDecoration(
//                             color:
//                                 AppColors.primaryColor.withOpacity(0.06),
//                             borderRadius: BorderRadius.circular(20),
//                             border: Border.all(
//                                 color: AppColors.primaryColor
//                                     .withOpacity(0.2)),
//                           ),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               const Icon(Icons.picture_as_pdf_outlined,
//                                   size: 12,
//                                   color: AppColors.primaryColor),
//                               const SizedBox(width: 4),
//                               Text(
//                                 'Download PDF',
//                                 style: GoogleFonts.poppins(
//                                     fontSize: 11,
//                                     fontWeight: FontWeight.w600,
//                                     color: AppColors.primaryColor),
//                               ),
//                               const SizedBox(width: 4),
//                               const Icon(Icons.download_outlined,
//                                   size: 11,
//                                   color: AppColors.primaryColor),
//                             ],
//                           ),
//                         ),
//                       )
//                     else
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 10, vertical: 5),
//                         decoration: BoxDecoration(
//                           color:
//                               AppColors.warningColor.withOpacity(0.07),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             const Icon(Icons.pending_rounded,
//                                 size: 12,
//                                 color: AppColors.warningColor),
//                             const SizedBox(width: 4),
//                             Text('Analysis pending',
//                                 style: GoogleFonts.poppins(
//                                     fontSize: 11,
//                                     color: AppColors.warningColor,
//                                     fontWeight: FontWeight.w500)),
//                           ],
//                         ),
//                       ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ── Shared helpers ────────────────────────────────────────────────────────

//   Widget _searchBar({
//     required String hint,
//     required void Function(String) onChanged,
//     required String value,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(14),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withOpacity(0.06),
//               blurRadius: 12,
//               offset: const Offset(0, 3))
//         ],
//       ),
//       child: TextField(
//         onChanged: onChanged,
//         style: GoogleFonts.poppins(
//             fontSize: 13.5, color: AppColors.textPrimaryColor),
//         decoration: InputDecoration(
//           hintText: hint,
//           hintStyle: GoogleFonts.poppins(
//               color: AppColors.greyColor, fontSize: 13),
//           prefixIcon:
//               const Icon(Icons.search, color: AppColors.primaryColor),
//           suffixIcon: value.isNotEmpty
//               ? IconButton(
//                   icon: const Icon(Icons.clear,
//                       color: AppColors.greyColor, size: 18),
//                   onPressed: () => onChanged(''),
//                 )
//               : null,
//           border: InputBorder.none,
//           contentPadding: const EdgeInsets.symmetric(
//               horizontal: 16, vertical: 14),
//         ),
//       ),
//     );
//   }

//   Widget _sectionCard({
//     required String title,
//     required IconData icon,
//     required List<Widget> children,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 14,
//               offset: const Offset(0, 4))
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
//             child: Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(7),
//                   decoration: BoxDecoration(
//                     color: AppColors.primaryColor.withOpacity(0.08),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child:
//                       Icon(icon, color: AppColors.primaryColor, size: 16),
//                 ),
//                 const SizedBox(width: 10),
//                 Text(title,
//                     style: GoogleFonts.poppins(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w700,
//                         color: AppColors.textPrimaryColor)),
//               ],
//             ),
//           ),
//           Divider(height: 1, color: AppColors.greyColor.withOpacity(0.15)),
//           Padding(
//             padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: children,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _metricBox(
//       String label, String value, IconData icon, Color color) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.07),
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(color: color.withOpacity(0.2)),
//       ),
//       child: Column(
//         children: [
//           Icon(icon, color: color, size: 22),
//           const SizedBox(height: 6),
//           Text(value,
//               style: GoogleFonts.poppins(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w700,
//                   color: AppColors.textPrimaryColor)),
//           Text(label,
//               style: GoogleFonts.poppins(
//                   fontSize: 10, color: AppColors.textSecondaryColor)),
//         ],
//       ),
//     );
//   }

//   Widget _infoRow(String label, String value, IconData icon,
//       {Color? valueColor}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 7),
//       child: Row(
//         children: [
//           Icon(icon, size: 16, color: AppColors.textSecondaryColor),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Text(label,
//                 style: GoogleFonts.poppins(
//                     fontSize: 13,
//                     color: AppColors.textSecondaryColor,
//                     fontWeight: FontWeight.w500)),
//           ),
//           Text(value,
//               style: GoogleFonts.poppins(
//                   fontSize: 13,
//                   fontWeight: FontWeight.w600,
//                   color: valueColor ?? AppColors.textPrimaryColor)),
//         ],
//       ),
//     );
//   }

//   Widget _familyHistoryRow(String label, bool hasHistory, IconData icon) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Row(
//         children: [
//           Icon(icon, size: 18, color: AppColors.textSecondaryColor),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Text(label,
//                 style: GoogleFonts.poppins(
//                     fontSize: 13,
//                     color: AppColors.textSecondaryColor,
//                     fontWeight: FontWeight.w500)),
//           ),
//           Container(
//             padding:
//                 const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//             decoration: BoxDecoration(
//               color: hasHistory
//                   ? AppColors.errorColor.withOpacity(0.1)
//                   : AppColors.successColor.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(20),
//               border: Border.all(
//                   color: hasHistory
//                       ? AppColors.errorColor.withOpacity(0.3)
//                       : AppColors.successColor.withOpacity(0.3)),
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(
//                   hasHistory
//                       ? Icons.check_circle_outline
//                       : Icons.cancel_outlined,
//                   size: 11,
//                   color: hasHistory
//                       ? AppColors.errorColor
//                       : AppColors.successColor,
//                 ),
//                 const SizedBox(width: 4),
//                 Text(hasHistory ? 'Yes' : 'No',
//                     style: GoogleFonts.poppins(
//                         fontSize: 11,
//                         fontWeight: FontWeight.w600,
//                         color: hasHistory
//                             ? AppColors.errorColor
//                             : AppColors.successColor)),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _alertRow(
//       String label, String value, IconData icon, Color color) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 4),
//       padding: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.06),
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: color.withOpacity(0.25)),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, size: 16, color: color),
//           const SizedBox(width: 8),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(label,
//                     style: GoogleFonts.poppins(
//                         fontSize: 11,
//                         color: color,
//                         fontWeight: FontWeight.w600)),
//                 const SizedBox(height: 2),
//                 Text(value,
//                     style: GoogleFonts.poppins(
//                         fontSize: 13,
//                         color: AppColors.textPrimaryColor,
//                         fontWeight: FontWeight.w500)),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _divider() =>
//       Divider(height: 1, color: AppColors.greyColor.withOpacity(0.12));

//   Widget _buildLoader() {
//     return const Center(
//       child: CircularProgressIndicator(
//           color: AppColors.primaryColor, strokeWidth: 3),
//     );
//   }

//   Widget _buildEmpty(String msg) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(32),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: 90,
//               height: 90,
//               decoration: BoxDecoration(
//                   color: AppColors.primaryColor.withOpacity(0.07),
//                   shape: BoxShape.circle),
//               child: const Icon(Icons.info_outline_rounded,
//                   size: 40, color: AppColors.primaryColor),
//             ),
//             const SizedBox(height: 16),
//             Text(msg,
//                 style: GoogleFonts.poppins(
//                     fontSize: 14, color: AppColors.textSecondaryColor),
//                 textAlign: TextAlign.center),
//           ],
//         ),
//       ),
//     );
//   }

//   String _initials(String name) {
//     final parts = name.trim().split(' ');
//     if (parts.length >= 2 && parts[0].isNotEmpty && parts[1].isNotEmpty) {
//       return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
//     }
//     return name.isNotEmpty ? name[0].toUpperCase() : 'C';
//   }

//   Color _docTypeColor(String type) {
//     switch (type.toLowerCase()) {
//       case 'lab_result':
//         return const Color(0xFF1565C0);
//       case 'prescription':
//         return AppColors.successColor;
//       case 'hearing_test':
//         return const Color(0xFF6A1B9A);
//       case 'vision_test':
//         return const Color(0xFF00838F);
//       case 'previous_report':
//         return AppColors.secondaryColor;
//       case 'referral_letter':
//         return const Color(0xFFE65100);
//       case 'school_report':
//         return const Color(0xFF2E7D32);
//       case 'other':
//       default:
//         return AppColors.accentColor;
//     }
//   }

//   IconData _docTypeIcon(String type) {
//     switch (type.toLowerCase()) {
//       case 'lab_result':
//         return Icons.science_outlined;
//       case 'prescription':
//         return Icons.medication_outlined;
//       case 'hearing_test':
//         return Icons.hearing_outlined;
//       case 'vision_test':
//         return Icons.visibility_outlined;
//       case 'previous_report':
//         return Icons.assignment_outlined;
//       case 'referral_letter':
//         return Icons.forward_to_inbox_outlined;
//       case 'school_report':
//         return Icons.school_outlined;
//       case 'other':
//       default:
//         return Icons.description_outlined;
//     }
//   }

//   String _docTypeLabel(String type) {
//     switch (type.toLowerCase()) {
//       case 'lab_result':
//         return 'Lab Result';
//       case 'prescription':
//         return 'Prescription';
//       case 'hearing_test':
//         return 'Hearing Test';
//       case 'vision_test':
//         return 'Vision Test';
//       case 'previous_report':
//         return 'Previous Report';
//       case 'referral_letter':
//         return 'Referral Letter';
//       case 'school_report':
//         return 'School Report';
//       case 'other':
//       default:
//         return 'Other';
//     }
//   }
// }



// // lib/view/parents/booking/parent_child_profile_screen.dart
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/child_profile_controller.dart';
// import 'package:speechspectrum/controllers/expert_child_data_controller.dart';
// import 'package:speechspectrum/models/child_profile_model.dart';
// import 'package:speechspectrum/routes/app_routes.dart';
// import 'package:speechspectrum/services/expert_child_data_service.dart';

// class ParentChildProfileScreen extends StatefulWidget {
//   const ParentChildProfileScreen({super.key});

//   @override
//   State<ParentChildProfileScreen> createState() =>
//       _ParentChildProfileScreenState();
// }

// class _ParentChildProfileScreenState extends State<ParentChildProfileScreen>
//     with SingleTickerProviderStateMixin {
//   late final ChildProfileController _profileCtrl;
//   late final ExpertChildDataController _dataCtrl;
//   late final TabController _tab;
//   late final String _childId;
//   late final String _childName;

//   static const _tabs = [
//     ('Overview', Icons.person_outline_rounded),
//     ('Health', Icons.favorite_border_rounded),
//     ('Screening', Icons.assignment_outlined),
//     ('Speech', Icons.mic_outlined),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     final args = Get.arguments as Map<String, dynamic>? ?? {};
//     _childId = args['childId'] ?? '';
//     _childName = args['childName'] ?? 'Child Profile';

//     _tab = TabController(length: _tabs.length, vsync: this);

//     _profileCtrl = Get.isRegistered<ChildProfileController>()
//         ? Get.find<ChildProfileController>()
//         : Get.put(ChildProfileController());

//     _dataCtrl = Get.isRegistered<ExpertChildDataController>()
//         ? Get.find<ExpertChildDataController>()
//         : Get.put(ExpertChildDataController());

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (_childId.isNotEmpty) {
//         _profileCtrl.loadAll(_childId);
//         _dataCtrl.fetchScreening(_childId);
//         _dataCtrl.fetchSpeech(_childId);
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _tab.dispose();
//     super.dispose();
//   }

//   // ── PDF helpers (same as before) ─────────────────────────────────────────

//   Future<void> _downloadScreeningPdf(
//       BuildContext context, ExpertScreeningItem item) async {
//     try {
//       final hasResult = item.questionnaireResults.isNotEmpty;
//       final result = hasResult ? item.questionnaireResults.first.result : null;

//       final pdf = pw.Document();
//       pdf.addPage(
//         pw.MultiPage(
//           pageFormat: PdfPageFormat.a4,
//           margin: const pw.EdgeInsets.all(40),
//           build: (pw.Context ctx) => [
//             pw.Container(
//               padding: const pw.EdgeInsets.all(20),
//               decoration: pw.BoxDecoration(
//                 color: PdfColor.fromHex('6C63FF'),
//                 borderRadius:
//                     const pw.BorderRadius.all(pw.Radius.circular(12)),
//               ),
//               child: pw.Column(
//                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 children: [
//                   pw.Text('ASD Screening Report',
//                       style: pw.TextStyle(
//                           fontSize: 24,
//                           fontWeight: pw.FontWeight.bold,
//                           color: PdfColors.white)),
//                   pw.SizedBox(height: 6),
//                   pw.Text('SpeechSpectrum — Parent View',
//                       style: const pw.TextStyle(
//                           fontSize: 12, color: PdfColors.white)),
//                 ],
//               ),
//             ),
//             pw.SizedBox(height: 20),

//             if (result != null) ...[
//               pw.Container(
//                 padding: const pw.EdgeInsets.all(16),
//                 decoration: pw.BoxDecoration(
//                   border:
//                       pw.Border.all(color: PdfColor.fromHex('E0E0E0')),
//                   borderRadius:
//                       const pw.BorderRadius.all(pw.Radius.circular(8)),
//                 ),
//                 child: pw.Column(
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: [
//                     pw.Text('Screening Result',
//                         style: pw.TextStyle(
//                             fontSize: 16, fontWeight: pw.FontWeight.bold)),
//                     pw.SizedBox(height: 10),
//                     _pdfRow('Child', _childName),
//                     pw.SizedBox(height: 4),
//                     _pdfRow('Prediction', result.prediction),
//                     pw.SizedBox(height: 4),
//                     _pdfRow('Probability', result.probability),
//                     pw.SizedBox(height: 4),
//                     _pdfRow('Date', item.formattedDate),
//                     pw.SizedBox(height: 4),
//                     _pdfRow('Time', item.formattedTime),
//                   ],
//                 ),
//               ),
//               pw.SizedBox(height: 20),
//             ],

//             pw.Text('Submission Information',
//                 style: pw.TextStyle(
//                     fontSize: 14, fontWeight: pw.FontWeight.bold)),
//             pw.SizedBox(height: 8),
//             pw.Container(
//               padding: const pw.EdgeInsets.all(12),
//               decoration: pw.BoxDecoration(
//                 color: PdfColor.fromHex('F8F9FA'),
//                 borderRadius:
//                     const pw.BorderRadius.all(pw.Radius.circular(8)),
//               ),
//               child: pw.Column(
//                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 children: [
//                   _pdfRow('Age (Months)',
//                       '${item.responses['Age_Mons'] ?? 'N/A'}'),
//                   _pdfRow('Gender',
//                       item.responses['Sex'] == 1 ? 'Male' : 'Female'),
//                   _pdfRow('Jaundice History',
//                       item.responses['Jaundice'] == 1 ? 'Yes' : 'No'),
//                   _pdfRow('Family ASD History',
//                       item.responses['Family_mem_with_ASD'] == 1
//                           ? 'Yes'
//                           : 'No'),
//                 ],
//               ),
//             ),
//             pw.SizedBox(height: 20),

//             pw.Text('Questionnaire Responses',
//                 style: pw.TextStyle(
//                     fontSize: 14, fontWeight: pw.FontWeight.bold)),
//             pw.SizedBox(height: 8),
//             ...['A1', 'A2', 'A3', 'A4', 'A5', 'A6', 'A7', 'A8', 'A9', 'A10']
//                 .map((key) {
//               final val = item.responses[key];
//               final isPositive = val == 1;
//               return pw.Container(
//                 margin: const pw.EdgeInsets.only(bottom: 6),
//                 padding: const pw.EdgeInsets.symmetric(
//                     horizontal: 12, vertical: 8),
//                 decoration: pw.BoxDecoration(
//                   color: isPositive
//                       ? PdfColor.fromHex('E8F5E9')
//                       : PdfColor.fromHex('FFEBEE'),
//                   borderRadius:
//                       const pw.BorderRadius.all(pw.Radius.circular(6)),
//                 ),
//                 child: pw.Row(
//                   mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                   children: [
//                     pw.Expanded(
//                         child: pw.Text(_questionLabel(key),
//                             style:
//                                 const pw.TextStyle(fontSize: 11))),
//                     pw.SizedBox(width: 10),
//                     pw.Text(
//                       isPositive ? 'Positive' : 'Negative',
//                       style: pw.TextStyle(
//                         fontSize: 11,
//                         fontWeight: pw.FontWeight.bold,
//                         color: isPositive
//                             ? PdfColor.fromHex('388E3C')
//                             : PdfColor.fromHex('D32F2F'),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             }).toList(),

//             pw.SizedBox(height: 20),
//             pw.Container(
//               padding: const pw.EdgeInsets.all(12),
//               decoration: pw.BoxDecoration(
//                 color: PdfColor.fromHex('FFF8E1'),
//                 borderRadius:
//                     const pw.BorderRadius.all(pw.Radius.circular(8)),
//               ),
//               child: pw.Text(
//                 'Disclaimer: This is a screening tool, not a diagnostic assessment. '
//                 'Professional evaluation by a qualified healthcare provider is recommended.',
//                 style: const pw.TextStyle(fontSize: 10),
//               ),
//             ),
//           ],
//         ),
//       );

//       final Uint8List bytes = await pdf.save();
//       final dir = await getApplicationDocumentsDirectory();
//       final childSafe = _childName.replaceAll(RegExp(r'[^\w]'), '_');
//       final file = File(
//           '${dir.path}/ASD_Screening_${childSafe}_${item.submissionId}.pdf');
//       await file.writeAsBytes(bytes);
//       await OpenFile.open(file.path);
//     } catch (e) {
//       Get.snackbar('Error', 'Could not generate PDF: $e',
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: AppColors.errorColor,
//           colorText: Colors.white,
//           margin: const EdgeInsets.all(16),
//           borderRadius: 12);
//     }
//   }

//   Future<void> _downloadSpeechPdf(
//       BuildContext context, ExpertSpeechItem item) async {
//     try {
//       final analysisResult = item.latestResult?.result;
//       if (analysisResult == null) return;

//       final pdf = pw.Document();
//       pdf.addPage(
//         pw.MultiPage(
//           pageFormat: PdfPageFormat.a4,
//           margin: const pw.EdgeInsets.all(40),
//           build: (pw.Context ctx) => [
//             pw.Container(
//               padding: const pw.EdgeInsets.all(20),
//               decoration: pw.BoxDecoration(
//                 color: PdfColor.fromHex('6C63FF'),
//                 borderRadius:
//                     const pw.BorderRadius.all(pw.Radius.circular(12)),
//               ),
//               child: pw.Column(
//                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 children: [
//                   pw.Text('Speech Analysis Report',
//                       style: pw.TextStyle(
//                           fontSize: 24,
//                           fontWeight: pw.FontWeight.bold,
//                           color: PdfColors.white)),
//                   pw.SizedBox(height: 6),
//                   pw.Text('SpeechSpectrum — Parent View',
//                       style: const pw.TextStyle(
//                           fontSize: 12, color: PdfColors.white)),
//                 ],
//               ),
//             ),
//             pw.SizedBox(height: 20),

//             pw.Container(
//               padding: const pw.EdgeInsets.all(16),
//               decoration: pw.BoxDecoration(
//                 border:
//                     pw.Border.all(color: PdfColor.fromHex('E0E0E0')),
//                 borderRadius:
//                     const pw.BorderRadius.all(pw.Radius.circular(8)),
//               ),
//               child: pw.Column(
//                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 children: [
//                   pw.Text('Analysis Result',
//                       style: pw.TextStyle(
//                           fontSize: 16, fontWeight: pw.FontWeight.bold)),
//                   pw.SizedBox(height: 10),
//                   _pdfRow('Child', _childName),
//                   pw.SizedBox(height: 4),
//                   _pdfRow('Risk Level', analysisResult.riskInterpretation),
//                   pw.SizedBox(height: 4),
//                   _pdfRow('Severity Score',
//                       '${analysisResult.severityScore} / ${analysisResult.maxScore}'),
//                   pw.SizedBox(height: 4),
//                   _pdfRow('Date', item.formattedDate),
//                   pw.SizedBox(height: 4),
//                   _pdfRow('Time', item.formattedTime),
//                   pw.SizedBox(height: 4),
//                   _pdfRow('Duration',
//                       '${item.recordingDurationSeconds} seconds'),
//                 ],
//               ),
//             ),
//             pw.SizedBox(height: 20),

//             if (analysisResult.bioMarkers != null) ...[
//               pw.Text('Bio-markers',
//                   style: pw.TextStyle(
//                       fontSize: 14, fontWeight: pw.FontWeight.bold)),
//               pw.SizedBox(height: 8),
//               pw.Container(
//                 padding: const pw.EdgeInsets.all(12),
//                 decoration: pw.BoxDecoration(
//                   color: PdfColor.fromHex('F8F9FA'),
//                   borderRadius:
//                       const pw.BorderRadius.all(pw.Radius.circular(8)),
//                 ),
//                 child: pw.Column(
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: [
//                     _pdfRow('Pitch Instability',
//                         '${analysisResult.bioMarkers!.pitchInstability.toStringAsFixed(1)} Hz'),
//                     pw.SizedBox(height: 4),
//                     _pdfRow('Resonance Jitter F1',
//                         '${analysisResult.bioMarkers!.resonanceJitterF1.toStringAsFixed(1)} Hz'),
//                     pw.SizedBox(height: 4),
//                     _pdfRow('Resonance Jitter F2',
//                         '${analysisResult.bioMarkers!.resonanceJitterF2.toStringAsFixed(1)} Hz'),
//                   ],
//                 ),
//               ),
//               pw.SizedBox(height: 20),
//             ],

//             pw.Text('Interpretation',
//                 style: pw.TextStyle(
//                     fontSize: 14, fontWeight: pw.FontWeight.bold)),
//             pw.SizedBox(height: 8),
//             pw.Container(
//               padding: const pw.EdgeInsets.all(12),
//               decoration: pw.BoxDecoration(
//                 color: PdfColor.fromHex('F8F9FA'),
//                 borderRadius:
//                     const pw.BorderRadius.all(pw.Radius.circular(8)),
//               ),
//               child: pw.Text(
//                 _speechInterpretation(analysisResult),
//                 style: const pw.TextStyle(fontSize: 11),
//               ),
//             ),
//             pw.SizedBox(height: 20),

//             pw.Container(
//               padding: const pw.EdgeInsets.all(12),
//               decoration: pw.BoxDecoration(
//                 color: PdfColor.fromHex('FFF8E1'),
//                 borderRadius:
//                     const pw.BorderRadius.all(pw.Radius.circular(8)),
//               ),
//               child: pw.Text(
//                 'Disclaimer: This is a screening tool, not a diagnostic assessment. '
//                 'Professional evaluation by a qualified healthcare provider is recommended.',
//                 style: const pw.TextStyle(fontSize: 10),
//               ),
//             ),
//           ],
//         ),
//       );

//       final Uint8List bytes = await pdf.save();
//       final dir = await getApplicationDocumentsDirectory();
//       final childSafe = _childName.replaceAll(RegExp(r'[^\w]'), '_');
//       final file = File(
//           '${dir.path}/Speech_Report_${childSafe}_${item.speechSubmissionId}.pdf');
//       await file.writeAsBytes(bytes);
//       await OpenFile.open(file.path);
//     } catch (e) {
//       Get.snackbar('Error', 'Could not generate PDF: $e',
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: AppColors.errorColor,
//           colorText: Colors.white,
//           margin: const EdgeInsets.all(16),
//           borderRadius: 12);
//     }
//   }

//   pw.Widget _pdfRow(String label, String value) {
//     return pw.Padding(
//       padding: const pw.EdgeInsets.only(bottom: 4),
//       child: pw.Row(children: [
//         pw.Text('$label: ',
//             style: pw.TextStyle(
//                 fontWeight: pw.FontWeight.bold, fontSize: 11)),
//         pw.Text(value, style: const pw.TextStyle(fontSize: 11)),
//       ]),
//     );
//   }

//   String _questionLabel(String key) {
//     const map = {
//       'A1': 'Does your child look at you when called?',
//       'A2': 'How easy is eye contact with your child?',
//       'A3': 'Does your child point to indicate wants?',
//       'A4': 'Does your child point to share interest?',
//       'A5': 'Does your child pretend play?',
//       'A6': 'Does your child follow where you\'re looking?',
//       'A7': 'Does your child show signs of comforting others?',
//       'A8': 'How would you describe first words?',
//       'A9': 'Does your child use simple gestures?',
//       'A10': 'Does your child stare at nothing?',
//     };
//     return map[key] ?? key;
//   }

//   String _speechInterpretation(ExpertSpeechAnalysis r) {
//     if (r.isLowRisk) {
//       return 'The speech pattern shows low-risk indicators and appears within a typical developmental range.';
//     } else if (r.isModerateRisk) {
//       return 'The speech pattern shows moderate-risk characteristics. Consider consulting a speech therapist.';
//     } else {
//       return 'The speech pattern shows high-risk indicators. Professional speech therapy intervention is strongly recommended.';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();
//     return Scaffold(
//       backgroundColor: AppColors.lightGreyColor,
//       body: Obx(() {
//         final isLoading = _profileCtrl.isLoadingProfile.value ||
//             _profileCtrl.isLoadingHealth.value;
//         final profile = _profileCtrl.childProfile.value;

//         return NestedScrollView(
//           headerSliverBuilder: (ctx, inner) => [
//             _buildSliverAppBar(context, size, profile, isLoading),
//           ],
//           body: isLoading && profile == null
//               ? _buildLoader()
//               : TabBarView(
//                   controller: _tab,
//                   children: [
//                     _buildOverviewTab(context, size),
//                     _buildHealthTab(context, size),
//                     _buildScreeningTab(context, size),
//                     _buildSpeechTab(context, size),
//                   ],
//                 ),
//         );
//       }),
//     );
//   }

//   Widget _buildSliverAppBar(
//     BuildContext context,
//     CustomSize size,
//     ChildData? profile,
//     bool isLoading,
//   ) {
//     return SliverAppBar(
//       expandedHeight: 230,
//       pinned: true,
//       backgroundColor: AppColors.primaryColor,
//       surfaceTintColor: Colors.transparent,
//       leading: IconButton(
//         icon: const Icon(Icons.arrow_back_ios_new_rounded,
//             color: Colors.white, size: 20),
//         onPressed: () => Get.back(),
//       ),
//       actions: [
//         if (isLoading)
//           const Padding(
//             padding: EdgeInsets.all(14),
//             child: SizedBox(
//               width: 20,
//               height: 20,
//               child: CircularProgressIndicator(
//                   color: Colors.white, strokeWidth: 2),
//             ),
//           )
//         else
//           IconButton(
//             icon: const Icon(Icons.refresh_rounded, color: Colors.white),
//             onPressed: () {
//               _profileCtrl.refreshProfile(_childId);
//               _dataCtrl.fetchScreening(_childId);
//               _dataCtrl.fetchSpeech(_childId);
//             },
//           ),
//         const SizedBox(width: 4),
//       ],
//       flexibleSpace: FlexibleSpaceBar(
//         background: _buildAppBarBackground(profile),
//       ),
//       bottom: TabBar(
//         controller: _tab,
//         labelColor: Colors.white,
//         unselectedLabelColor: Colors.white60,
//         indicatorColor: Colors.white,
//         indicatorWeight: 3,
//         isScrollable: true,
//         tabAlignment: TabAlignment.start,
//         labelStyle:
//             GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12.5),
//         unselectedLabelStyle:
//             GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 12.5),
//         tabs: _tabs
//             .map((t) => Tab(
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(t.$2, size: 14),
//                       const SizedBox(width: 5),
//                       Text(t.$1),
//                     ],
//                   ),
//                 ))
//             .toList(),
//       ),
//     );
//   }

//   Widget _buildAppBarBackground(ChildData? profile) {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [AppColors.primaryColor, AppColors.secondaryColor],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       child: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const SizedBox(height: 12),
//             Container(
//               width: 80,
//               height: 80,
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.2),
//                 shape: BoxShape.circle,
//                 border: Border.all(color: Colors.white, width: 3),
//               ),
//               child: Center(
//                 child: Text(
//                   profile?.initials ?? _initials(_childName),
//                   style: GoogleFonts.poppins(
//                     color: Colors.white,
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               profile?.childName ?? _childName,
//               style: GoogleFonts.poppins(
//                 color: Colors.white,
//                 fontSize: 20,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//             if (profile != null) ...[
//               const SizedBox(height: 4),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   _pillChip(
//                     profile.gender[0].toUpperCase() +
//                         profile.gender.substring(1),
//                     profile.gender.toLowerCase() == 'male'
//                         ? Icons.male_rounded
//                         : Icons.female_rounded,
//                   ),
//                   const SizedBox(width: 8),
//                   _pillChip(profile.age, Icons.cake_outlined),
//                 ],
//               ),
//             ],
//             const SizedBox(height: 50),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _pillChip(String label, IconData icon) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.2),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: Colors.white.withOpacity(0.4)),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, color: Colors.white, size: 12),
//           const SizedBox(width: 4),
//           Text(label,
//               style: GoogleFonts.poppins(
//                   color: Colors.white,
//                   fontSize: 11,
//                   fontWeight: FontWeight.w500)),
//         ],
//       ),
//     );
//   }

//   // ── Overview Tab ──────────────────────────────────────────────────────────

//   Widget _buildOverviewTab(BuildContext context, CustomSize size) {
//     return Obx(() {
//       final profile = _profileCtrl.childProfile.value;
//       if (profile == null) return _buildEmpty('No profile data available');

//       return ListView(
//         padding: EdgeInsets.fromLTRB(
//           size.customWidth(context) * 0.045,
//           size.customHeight(context) * 0.02,
//           size.customWidth(context) * 0.045,
//           size.customHeight(context) * 0.04,
//         ),
//         children: [
//           _sectionCard(
//             title: 'Basic Information',
//             icon: Icons.person_outline_rounded,
//             children: [
//               _infoRow('Full Name', profile.childName, Icons.badge_outlined),
//               _divider(),
//               _infoRow(
//                   'Date of Birth', profile.formattedDob, Icons.cake_outlined),
//               _divider(),
//               _infoRow('Age', profile.age, Icons.hourglass_bottom_rounded),
//               _divider(),
//               _infoRow(
//                 'Gender',
//                 profile.gender[0].toUpperCase() + profile.gender.substring(1),
//                 profile.gender.toLowerCase() == 'male'
//                     ? Icons.male_rounded
//                     : Icons.female_rounded,
//               ),
//             ],
//           ),
//           SizedBox(height: size.customHeight(context) * 0.018),
//           _buildHealthSnapshotCard(context, size),
//         ],
//       );
//     });
//   }

//   Widget _buildHealthSnapshotCard(BuildContext context, CustomSize size) {
//     return Obx(() {
//       final health = _profileCtrl.childHealth.value;
//       if (health == null) return const SizedBox.shrink();

//       return _sectionCard(
//         title: 'Health Snapshot',
//         icon: Icons.monitor_heart_outlined,
//         children: [
//           Row(
//             children: [
//               Expanded(
//                   child: _metricBox(
//                       'Weight',
//                       health.weightKg != null
//                           ? '${health.weightKg!.toStringAsFixed(1)} kg'
//                           : '—',
//                       Icons.scale_outlined,
//                       AppColors.primaryColor)),
//               const SizedBox(width: 10),
//               Expanded(
//                   child: _metricBox(
//                       'Height',
//                       health.heightCm != null
//                           ? '${health.heightCm!.toStringAsFixed(1)} cm'
//                           : '—',
//                       Icons.height_rounded,
//                       AppColors.secondaryColor)),
//               const SizedBox(width: 10),
//               Expanded(
//                   child: _metricBox(
//                       'BMI',
//                       health.bmi != null
//                           ? health.bmi!.toStringAsFixed(2)
//                           : '—',
//                       Icons.analytics_outlined,
//                       AppColors.accentColor)),
//             ],
//           ),
//           if (health.bloodGroup != null) ...[
//             const SizedBox(height: 12),
//             _divider(),
//             const SizedBox(height: 4),
//             _infoRow(
//                 'Blood Group', health.bloodGroup!, Icons.bloodtype_outlined),
//           ],
//         ],
//       );
//     });
//   }

//   // ── Health Tab ────────────────────────────────────────────────────────────

//   Widget _buildHealthTab(BuildContext context, CustomSize size) {
//     return Obx(() {
//       if (_profileCtrl.isLoadingHealth.value &&
//           _profileCtrl.childHealth.value == null) {
//         return _buildLoader();
//       }
//       final health = _profileCtrl.childHealth.value;
//       if (health == null) {
//         return _buildEmpty('No health profile available for this child');
//       }

//       return ListView(
//         padding: EdgeInsets.fromLTRB(
//           size.customWidth(context) * 0.045,
//           size.customHeight(context) * 0.02,
//           size.customWidth(context) * 0.045,
//           size.customHeight(context) * 0.04,
//         ),
//         children: [
//           _sectionCard(
//             title: 'Vitals',
//             icon: Icons.monitor_heart_outlined,
//             children: [
//               Row(
//                 children: [
//                   Expanded(
//                       child: _metricBox(
//                           'Weight',
//                           health.weightKg != null
//                               ? '${health.weightKg!.toStringAsFixed(1)} kg'
//                               : '—',
//                           Icons.scale_outlined,
//                           AppColors.primaryColor)),
//                   const SizedBox(width: 10),
//                   Expanded(
//                       child: _metricBox(
//                           'Height',
//                           health.heightCm != null
//                               ? '${health.heightCm!.toStringAsFixed(1)} cm'
//                               : '—',
//                           Icons.height_rounded,
//                           AppColors.secondaryColor)),
//                   const SizedBox(width: 10),
//                   Expanded(
//                       child: _metricBox(
//                           'BMI',
//                           health.bmi != null
//                               ? health.bmi!.toStringAsFixed(2)
//                               : '—',
//                           Icons.analytics_outlined,
//                           AppColors.accentColor)),
//                 ],
//               ),
//               if (health.bloodGroup != null) ...[
//                 const SizedBox(height: 12),
//                 _divider(),
//                 const SizedBox(height: 4),
//                 _infoRow('Blood Group', health.bloodGroup!,
//                     Icons.bloodtype_outlined,
//                     valueColor: AppColors.errorColor),
//               ],
//             ],
//           ),
//           SizedBox(height: size.customHeight(context) * 0.018),
//           _sectionCard(
//             title: 'Conditions & Allergies',
//             icon: Icons.medical_services_outlined,
//             children: [
//               if (health.knownAllergies != null &&
//                   health.knownAllergies!.isNotEmpty &&
//                   health.knownAllergies!.toLowerCase() != 'none') ...[
//                 _alertRow('Known Allergies', health.knownAllergies!,
//                     Icons.warning_amber_rounded, AppColors.warningColor),
//                 _divider(),
//               ],
//               if (health.chronicConditions != null &&
//                   health.chronicConditions!.isNotEmpty &&
//                   health.chronicConditions!.toLowerCase() != 'none') ...[
//                 _alertRow('Chronic Conditions', health.chronicConditions!,
//                     Icons.local_hospital_outlined, AppColors.errorColor),
//                 _divider(),
//               ],
//               if (health.geneticDisorders != null &&
//                   health.geneticDisorders!.isNotEmpty &&
//                   health.geneticDisorders!.toLowerCase() != 'none')
//                 _alertRow('Genetic Disorders', health.geneticDisorders!,
//                     Icons.biotech_outlined, const Color(0xFF7B1FA2))
//               else
//                 _infoRow('Genetic Disorders', 'None reported',
//                     Icons.biotech_outlined),
//             ],
//           ),
//           SizedBox(height: size.customHeight(context) * 0.018),
//           _sectionCard(
//             title: 'Family History',
//             icon: Icons.family_restroom_rounded,
//             children: [
//               _familyHistoryRow(
//                   'ASD History', health.familyHistoryAsd,
//                   Icons.psychology_outlined),
//               _divider(),
//               _familyHistoryRow('Speech Disorders',
//                   health.familyHistorySpeechDisorders,
//                   Icons.record_voice_over_outlined),
//               _divider(),
//               _familyHistoryRow('Hearing Loss',
//                   health.familyHistoryHearingLoss, Icons.hearing_outlined),
//             ],
//           ),
//           SizedBox(height: size.customHeight(context) * 0.018),
//           if (health.medicalRecords.isNotEmpty)
//             _sectionCard(
//               title: 'Medical Records (${health.medicalRecords.length})',
//               icon: Icons.folder_outlined,
//               children: health.medicalRecords
//                   .map((r) => _recordRow(r))
//                   .toList(),
//             ),
//         ],
//       );
//     });
//   }

//   Widget _recordRow(MedicalRecord record) {
//     final color = _docTypeColor(record.documentType);
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Row(
//         children: [
//           Container(
//             width: 38,
//             height: 38,
//             decoration: BoxDecoration(
//               color: color.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(10),
//               border: Border.all(color: color.withOpacity(0.3)),
//             ),
//             child: Icon(_docTypeIcon(record.documentType),
//                 color: color, size: 18),
//           ),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(record.displayName,
//                     style: GoogleFonts.poppins(
//                         fontSize: 12.5,
//                         fontWeight: FontWeight.w600,
//                         color: AppColors.textPrimaryColor),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis),
//                 Text(record.formattedUploadDate,
//                     style: GoogleFonts.poppins(
//                         fontSize: 11,
//                         color: AppColors.textSecondaryColor)),
//               ],
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
//             decoration: BoxDecoration(
//               color: color.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(6),
//             ),
//             child: Text(_docTypeLabel(record.documentType),
//                 style: GoogleFonts.poppins(
//                     fontSize: 10,
//                     fontWeight: FontWeight.w600,
//                     color: color)),
//           ),
//         ],
//       ),
//     );
//   }

//   // ── Screening Tab — NOW WITH "View Details" navigation ───────────────────

//   Widget _buildScreeningTab(BuildContext context, CustomSize size) {
//     return Obx(() {
//       if (_dataCtrl.isLoadingScreening.value &&
//           _dataCtrl.screeningList.isEmpty) {
//         return _buildLoader();
//       }

//       return Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.fromLTRB(
//               size.customWidth(context) * 0.045,
//               size.customHeight(context) * 0.015,
//               size.customWidth(context) * 0.045,
//               size.customHeight(context) * 0.01,
//             ),
//             child: _searchBar(
//               hint: 'Search by probability or result...',
//               onChanged: _dataCtrl.filterScreening,
//               value: _dataCtrl.screeningSearch.value,
//             ),
//           ),
//           Expanded(
//             child: _dataCtrl.filteredScreeningList.isEmpty
//                 ? _buildEmpty(_dataCtrl.screeningSearch.value.isNotEmpty
//                     ? 'No results match your search'
//                     : 'No screening submissions for this child')
//                 : RefreshIndicator(
//                     color: AppColors.primaryColor,
//                     onRefresh: () => _dataCtrl.fetchScreening(_childId),
//                     child: ListView.builder(
//                       padding: EdgeInsets.fromLTRB(
//                         size.customWidth(context) * 0.045,
//                         0,
//                         size.customWidth(context) * 0.045,
//                         size.customHeight(context) * 0.04,
//                       ),
//                       itemCount: _dataCtrl.filteredScreeningList.length,
//                       itemBuilder: (_, i) => _screeningCard(
//                           context, size, _dataCtrl.filteredScreeningList[i]),
//                     ),
//                   ),
//           ),
//         ],
//       );
//     });
//   }

//   Widget _screeningCard(BuildContext context, CustomSize size,
//       ExpertScreeningItem item) {
//     final hasResult = item.questionnaireResults.isNotEmpty;
//     final result =
//         hasResult ? item.questionnaireResults.first.result : null;

//     Color riskColor = AppColors.greyColor;
//     if (result != null) {
//       if (result.isHighRisk) riskColor = AppColors.errorColor;
//       else if (result.isMediumRisk) riskColor = AppColors.warningColor;
//       else riskColor = AppColors.successColor;
//     }

//     return GestureDetector(
//       onTap: () {
//         Get.toNamed(
//           AppRoutes.parentScreeningDetail,
//           arguments: {
//             'submissionId': item.submissionId,
//             'childName': _childName,
//           },
//         );
//       },
//       child: Container(
//         margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.014),
//         decoration: BoxDecoration(
//           color: AppColors.whiteColor,
//           borderRadius: BorderRadius.circular(18),
//           boxShadow: [
//             BoxShadow(
//                 color: Colors.black.withOpacity(0.06),
//                 blurRadius: 14,
//                 offset: const Offset(0, 4))
//           ],
//         ),
//         child: Column(
//           children: [
//             Container(
//               height: 4,
//               decoration: BoxDecoration(
//                 color: riskColor,
//                 borderRadius:
//                     const BorderRadius.vertical(top: Radius.circular(18)),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Container(
//                         width: 52,
//                         height: 52,
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [riskColor.withOpacity(0.7), riskColor],
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                           ),
//                           borderRadius: BorderRadius.circular(14),
//                         ),
//                         child: const Icon(Icons.assignment_outlined,
//                             size: 26, color: Colors.white),
//                       ),
//                       SizedBox(width: size.customWidth(context) * 0.03),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(item.formattedDate,
//                                 style: GoogleFonts.poppins(
//                                     fontSize: 13.5,
//                                     fontWeight: FontWeight.w700,
//                                     color: AppColors.textPrimaryColor)),
//                             const SizedBox(height: 2),
//                             Text(item.formattedTime,
//                                 style: GoogleFonts.poppins(
//                                     fontSize: 11.5,
//                                     color: AppColors.textSecondaryColor)),
//                           ],
//                         ),
//                       ),
//                       if (result != null) ...[
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 10, vertical: 4),
//                               decoration: BoxDecoration(
//                                 color: riskColor.withOpacity(0.1),
//                                 borderRadius: BorderRadius.circular(20),
//                                 border: Border.all(
//                                     color: riskColor.withOpacity(0.3)),
//                               ),
//                               child: Text(
//                                 result.probability,
//                                 style: GoogleFonts.poppins(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.bold,
//                                     color: riskColor),
//                               ),
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               result.prediction.length > 22
//                                   ? '${result.prediction.substring(0, 22)}...'
//                                   : result.prediction,
//                               style: GoogleFonts.poppins(
//                                   fontSize: 10.5,
//                                   color: riskColor,
//                                   fontWeight: FontWeight.w500),
//                             ),
//                           ],
//                         ),
//                       ],
//                       const SizedBox(width: 6),
//                       const Icon(Icons.arrow_forward_ios_rounded,
//                           size: 13, color: AppColors.primaryColor),
//                     ],
//                   ),

//                   SizedBox(height: size.customHeight(context) * 0.012),
//                   Divider(
//                       height: 1,
//                       color: AppColors.greyColor.withOpacity(0.15)),
//                   SizedBox(height: size.customHeight(context) * 0.01),

//                   // Bottom row: View Details + PDF
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       // View Details button
//                       Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text('View Details',
//                               style: GoogleFonts.poppins(
//                                   fontSize: 11,
//                                   color: AppColors.primaryColor,
//                                   fontWeight: FontWeight.w500)),
//                           const SizedBox(width: 3),
//                           const Icon(Icons.arrow_forward_ios_rounded,
//                               size: 11, color: AppColors.primaryColor),
//                         ],
//                       ),

//                       // PDF download or pending
//                       if (hasResult)
//                         GestureDetector(
//                           onTap: () =>
//                               _downloadScreeningPdf(context, item),
//                           behavior: HitTestBehavior.opaque,
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 10, vertical: 5),
//                             decoration: BoxDecoration(
//                               color: AppColors.primaryColor.withOpacity(0.06),
//                               borderRadius: BorderRadius.circular(20),
//                               border: Border.all(
//                                   color:
//                                       AppColors.primaryColor.withOpacity(0.2)),
//                             ),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 const Icon(Icons.picture_as_pdf_outlined,
//                                     size: 12, color: AppColors.primaryColor),
//                                 const SizedBox(width: 4),
//                                 Text(
//                                   'Download PDF',
//                                   style: GoogleFonts.poppins(
//                                       fontSize: 11,
//                                       fontWeight: FontWeight.w600,
//                                       color: AppColors.primaryColor),
//                                 ),
//                                 const SizedBox(width: 4),
//                                 const Icon(Icons.download_outlined,
//                                     size: 11, color: AppColors.primaryColor),
//                               ],
//                             ),
//                           ),
//                         )
//                       else
//                         Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             const Icon(Icons.pending_rounded,
//                                 size: 12, color: AppColors.warningColor),
//                             const SizedBox(width: 4),
//                             Text('Analysis pending',
//                                 style: GoogleFonts.poppins(
//                                     fontSize: 11,
//                                     color: AppColors.warningColor,
//                                     fontWeight: FontWeight.w500)),
//                           ],
//                         ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ── Speech Tab — NOW WITH "View Details" navigation ──────────────────────

//   Widget _buildSpeechTab(BuildContext context, CustomSize size) {
//     return Obx(() {
//       if (_dataCtrl.isLoadingSpeech.value && _dataCtrl.speechList.isEmpty) {
//         return _buildLoader();
//       }

//       return Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.fromLTRB(
//               size.customWidth(context) * 0.045,
//               size.customHeight(context) * 0.015,
//               size.customWidth(context) * 0.045,
//               size.customHeight(context) * 0.01,
//             ),
//             child: _searchBar(
//               hint: 'Search by risk level...',
//               onChanged: _dataCtrl.filterSpeech,
//               value: _dataCtrl.speechSearch.value,
//             ),
//           ),
//           Expanded(
//             child: _dataCtrl.filteredSpeechList.isEmpty
//                 ? _buildEmpty(_dataCtrl.speechSearch.value.isNotEmpty
//                     ? 'No results match your search'
//                     : 'No speech submissions for this child')
//                 : RefreshIndicator(
//                     color: AppColors.primaryColor,
//                     onRefresh: () => _dataCtrl.fetchSpeech(_childId),
//                     child: ListView.builder(
//                       padding: EdgeInsets.fromLTRB(
//                         size.customWidth(context) * 0.045,
//                         0,
//                         size.customWidth(context) * 0.045,
//                         size.customHeight(context) * 0.04,
//                       ),
//                       itemCount: _dataCtrl.filteredSpeechList.length,
//                       itemBuilder: (_, i) => _speechCard(
//                           context, size, _dataCtrl.filteredSpeechList[i]),
//                     ),
//                   ),
//           ),
//         ],
//       );
//     });
//   }

//   Widget _speechCard(BuildContext context, CustomSize size,
//       ExpertSpeechItem item) {
//     final hasResult = item.hasResults;
//     final analysisResult = item.latestResult?.result;

//     Color riskColor = AppColors.greyColor;
//     IconData riskIcon = Icons.pending_rounded;
//     if (analysisResult != null) {
//       if (analysisResult.isHighRisk) {
//         riskColor = AppColors.errorColor;
//         riskIcon = Icons.warning_rounded;
//       } else if (analysisResult.isModerateRisk) {
//         riskColor = AppColors.warningColor;
//         riskIcon = Icons.info_rounded;
//       } else {
//         riskColor = AppColors.successColor;
//         riskIcon = Icons.check_circle_rounded;
//       }
//     }

//     return GestureDetector(
//       onTap: () {
//         Get.toNamed(
//           AppRoutes.parentSpeechDetail,
//           arguments: {
//             'submissionId': item.speechSubmissionId,
//             'childName': _childName,
//           },
//         );
//       },
//       child: Container(
//         margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.014),
//         decoration: BoxDecoration(
//           color: AppColors.whiteColor,
//           borderRadius: BorderRadius.circular(18),
//           boxShadow: [
//             BoxShadow(
//                 color: Colors.black.withOpacity(0.06),
//                 blurRadius: 14,
//                 offset: const Offset(0, 4))
//           ],
//         ),
//         child: Column(
//           children: [
//             Container(
//               height: 4,
//               decoration: BoxDecoration(
//                 color: riskColor,
//                 borderRadius:
//                     const BorderRadius.vertical(top: Radius.circular(18)),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Container(
//                         width: 52,
//                         height: 52,
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [riskColor.withOpacity(0.7), riskColor],
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                           ),
//                           borderRadius: BorderRadius.circular(14),
//                         ),
//                         child:
//                             Icon(riskIcon, size: 26, color: Colors.white),
//                       ),
//                       SizedBox(width: size.customWidth(context) * 0.03),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(item.formattedDate,
//                                 style: GoogleFonts.poppins(
//                                     fontSize: 13.5,
//                                     fontWeight: FontWeight.w700,
//                                     color: AppColors.textPrimaryColor)),
//                             const SizedBox(height: 2),
//                             Row(
//                               children: [
//                                 Icon(Icons.access_time_rounded,
//                                     size: 13,
//                                     color: AppColors.textSecondaryColor),
//                                 const SizedBox(width: 3),
//                                 Text('${item.recordingDurationSeconds}s',
//                                     style: GoogleFonts.poppins(
//                                         fontSize: 11.5,
//                                         color: AppColors.textSecondaryColor)),
//                                 const SizedBox(width: 8),
//                                 Icon(Icons.schedule_rounded,
//                                     size: 13,
//                                     color: AppColors.textSecondaryColor),
//                                 const SizedBox(width: 3),
//                                 Text(item.formattedTime,
//                                     style: GoogleFonts.poppins(
//                                         fontSize: 11.5,
//                                         color: AppColors.textSecondaryColor)),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       const Icon(Icons.arrow_forward_ios_rounded,
//                           size: 13, color: AppColors.primaryColor),
//                     ],
//                   ),

//                   if (hasResult && analysisResult != null) ...[
//                     SizedBox(height: size.customHeight(context) * 0.012),
//                     Divider(
//                         height: 1,
//                         color: AppColors.greyColor.withOpacity(0.15)),
//                     SizedBox(height: size.customHeight(context) * 0.01),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(analysisResult.riskInterpretation,
//                                   style: GoogleFonts.poppins(
//                                       fontSize: 12.5,
//                                       fontWeight: FontWeight.w700,
//                                       color: riskColor)),
//                               const SizedBox(height: 4),
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(6),
//                                 child: LinearProgressIndicator(
//                                   value: analysisResult.severityScore /
//                                       analysisResult.maxScore,
//                                   backgroundColor:
//                                       riskColor.withOpacity(0.15),
//                                   valueColor:
//                                       AlwaysStoppedAnimation<Color>(riskColor),
//                                   minHeight: 7,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 10, vertical: 5),
//                           decoration: BoxDecoration(
//                             color: riskColor.withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(20),
//                             border:
//                                 Border.all(color: riskColor.withOpacity(0.4)),
//                           ),
//                           child: Text(
//                             '${analysisResult.severityScore}/${analysisResult.maxScore}',
//                             style: GoogleFonts.poppins(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.bold,
//                                 color: riskColor),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],

//                   SizedBox(height: size.customHeight(context) * 0.012),
//                   Divider(
//                       height: 1,
//                       color: AppColors.greyColor.withOpacity(0.15)),
//                   SizedBox(height: size.customHeight(context) * 0.01),

//                   // Bottom row: View Details + PDF / pending
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text('View Details',
//                               style: GoogleFonts.poppins(
//                                   fontSize: 11,
//                                   color: AppColors.primaryColor,
//                                   fontWeight: FontWeight.w500)),
//                           const SizedBox(width: 3),
//                           const Icon(Icons.arrow_forward_ios_rounded,
//                               size: 11, color: AppColors.primaryColor),
//                         ],
//                       ),

//                       if (hasResult && analysisResult != null)
//                         GestureDetector(
//                           onTap: () => _downloadSpeechPdf(context, item),
//                           behavior: HitTestBehavior.opaque,
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 10, vertical: 5),
//                             decoration: BoxDecoration(
//                               color: AppColors.primaryColor.withOpacity(0.06),
//                               borderRadius: BorderRadius.circular(20),
//                               border: Border.all(
//                                   color:
//                                       AppColors.primaryColor.withOpacity(0.2)),
//                             ),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 const Icon(Icons.picture_as_pdf_outlined,
//                                     size: 12, color: AppColors.primaryColor),
//                                 const SizedBox(width: 4),
//                                 Text(
//                                   'Download PDF',
//                                   style: GoogleFonts.poppins(
//                                       fontSize: 11,
//                                       fontWeight: FontWeight.w600,
//                                       color: AppColors.primaryColor),
//                                 ),
//                                 const SizedBox(width: 4),
//                                 const Icon(Icons.download_outlined,
//                                     size: 11, color: AppColors.primaryColor),
//                               ],
//                             ),
//                           ),
//                         )
//                       else
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 10, vertical: 5),
//                           decoration: BoxDecoration(
//                             color: AppColors.warningColor.withOpacity(0.07),
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               const Icon(Icons.pending_rounded,
//                                   size: 12, color: AppColors.warningColor),
//                               const SizedBox(width: 4),
//                               Text('Analysis pending',
//                                   style: GoogleFonts.poppins(
//                                       fontSize: 11,
//                                       color: AppColors.warningColor,
//                                       fontWeight: FontWeight.w500)),
//                             ],
//                           ),
//                         ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ── Shared helpers ────────────────────────────────────────────────────────

//   Widget _searchBar({
//     required String hint,
//     required void Function(String) onChanged,
//     required String value,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(14),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withOpacity(0.06),
//               blurRadius: 12,
//               offset: const Offset(0, 3))
//         ],
//       ),
//       child: TextField(
//         onChanged: onChanged,
//         style: GoogleFonts.poppins(
//             fontSize: 13.5, color: AppColors.textPrimaryColor),
//         decoration: InputDecoration(
//           hintText: hint,
//           hintStyle:
//               GoogleFonts.poppins(color: AppColors.greyColor, fontSize: 13),
//           prefixIcon:
//               const Icon(Icons.search, color: AppColors.primaryColor),
//           suffixIcon: value.isNotEmpty
//               ? IconButton(
//                   icon: const Icon(Icons.clear,
//                       color: AppColors.greyColor, size: 18),
//                   onPressed: () => onChanged(''),
//                 )
//               : null,
//           border: InputBorder.none,
//           contentPadding:
//               const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//         ),
//       ),
//     );
//   }

//   Widget _sectionCard({
//     required String title,
//     required IconData icon,
//     required List<Widget> children,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 14,
//               offset: const Offset(0, 4))
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
//             child: Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(7),
//                   decoration: BoxDecoration(
//                     color: AppColors.primaryColor.withOpacity(0.08),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child:
//                       Icon(icon, color: AppColors.primaryColor, size: 16),
//                 ),
//                 const SizedBox(width: 10),
//                 Text(title,
//                     style: GoogleFonts.poppins(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w700,
//                         color: AppColors.textPrimaryColor)),
//               ],
//             ),
//           ),
//           Divider(height: 1, color: AppColors.greyColor.withOpacity(0.15)),
//           Padding(
//             padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: children,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _metricBox(
//       String label, String value, IconData icon, Color color) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.07),
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(color: color.withOpacity(0.2)),
//       ),
//       child: Column(
//         children: [
//           Icon(icon, color: color, size: 22),
//           const SizedBox(height: 6),
//           Text(value,
//               style: GoogleFonts.poppins(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w700,
//                   color: AppColors.textPrimaryColor)),
//           Text(label,
//               style: GoogleFonts.poppins(
//                   fontSize: 10, color: AppColors.textSecondaryColor)),
//         ],
//       ),
//     );
//   }

//   Widget _infoRow(String label, String value, IconData icon,
//       {Color? valueColor}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 7),
//       child: Row(
//         children: [
//           Icon(icon, size: 16, color: AppColors.textSecondaryColor),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Text(label,
//                 style: GoogleFonts.poppins(
//                     fontSize: 13,
//                     color: AppColors.textSecondaryColor,
//                     fontWeight: FontWeight.w500)),
//           ),
//           Text(value,
//               style: GoogleFonts.poppins(
//                   fontSize: 13,
//                   fontWeight: FontWeight.w600,
//                   color: valueColor ?? AppColors.textPrimaryColor)),
//         ],
//       ),
//     );
//   }

//   Widget _familyHistoryRow(String label, bool hasHistory, IconData icon) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Row(
//         children: [
//           Icon(icon, size: 18, color: AppColors.textSecondaryColor),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Text(label,
//                 style: GoogleFonts.poppins(
//                     fontSize: 13,
//                     color: AppColors.textSecondaryColor,
//                     fontWeight: FontWeight.w500)),
//           ),
//           Container(
//             padding:
//                 const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//             decoration: BoxDecoration(
//               color: hasHistory
//                   ? AppColors.errorColor.withOpacity(0.1)
//                   : AppColors.successColor.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(20),
//               border: Border.all(
//                   color: hasHistory
//                       ? AppColors.errorColor.withOpacity(0.3)
//                       : AppColors.successColor.withOpacity(0.3)),
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(
//                   hasHistory
//                       ? Icons.check_circle_outline
//                       : Icons.cancel_outlined,
//                   size: 11,
//                   color: hasHistory
//                       ? AppColors.errorColor
//                       : AppColors.successColor,
//                 ),
//                 const SizedBox(width: 4),
//                 Text(hasHistory ? 'Yes' : 'No',
//                     style: GoogleFonts.poppins(
//                         fontSize: 11,
//                         fontWeight: FontWeight.w600,
//                         color: hasHistory
//                             ? AppColors.errorColor
//                             : AppColors.successColor)),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _alertRow(
//       String label, String value, IconData icon, Color color) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 4),
//       padding: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.06),
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: color.withOpacity(0.25)),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, size: 16, color: color),
//           const SizedBox(width: 8),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(label,
//                     style: GoogleFonts.poppins(
//                         fontSize: 11,
//                         color: color,
//                         fontWeight: FontWeight.w600)),
//                 const SizedBox(height: 2),
//                 Text(value,
//                     style: GoogleFonts.poppins(
//                         fontSize: 13,
//                         color: AppColors.textPrimaryColor,
//                         fontWeight: FontWeight.w500)),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _divider() =>
//       Divider(height: 1, color: AppColors.greyColor.withOpacity(0.12));

//   Widget _buildLoader() {
//     return const Center(
//       child: CircularProgressIndicator(
//           color: AppColors.primaryColor, strokeWidth: 3),
//     );
//   }

//   Widget _buildEmpty(String msg) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(32),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: 90,
//               height: 90,
//               decoration: BoxDecoration(
//                   color: AppColors.primaryColor.withOpacity(0.07),
//                   shape: BoxShape.circle),
//               child: const Icon(Icons.info_outline_rounded,
//                   size: 40, color: AppColors.primaryColor),
//             ),
//             const SizedBox(height: 16),
//             Text(msg,
//                 style: GoogleFonts.poppins(
//                     fontSize: 14, color: AppColors.textSecondaryColor),
//                 textAlign: TextAlign.center),
//           ],
//         ),
//       ),
//     );
//   }

//   String _initials(String name) {
//     final parts = name.trim().split(' ');
//     if (parts.length >= 2 && parts[0].isNotEmpty && parts[1].isNotEmpty) {
//       return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
//     }
//     return name.isNotEmpty ? name[0].toUpperCase() : 'C';
//   }

//   Color _docTypeColor(String type) {
//     switch (type.toLowerCase()) {
//       case 'lab_result': return const Color(0xFF1565C0);
//       case 'prescription': return AppColors.successColor;
//       case 'hearing_test': return const Color(0xFF6A1B9A);
//       case 'vision_test': return const Color(0xFF00838F);
//       case 'previous_report': return AppColors.secondaryColor;
//       case 'referral_letter': return const Color(0xFFE65100);
//       case 'school_report': return const Color(0xFF2E7D32);
//       default: return AppColors.accentColor;
//     }
//   }

//   IconData _docTypeIcon(String type) {
//     switch (type.toLowerCase()) {
//       case 'lab_result': return Icons.science_outlined;
//       case 'prescription': return Icons.medication_outlined;
//       case 'hearing_test': return Icons.hearing_outlined;
//       case 'vision_test': return Icons.visibility_outlined;
//       case 'previous_report': return Icons.assignment_outlined;
//       case 'referral_letter': return Icons.forward_to_inbox_outlined;
//       case 'school_report': return Icons.school_outlined;
//       default: return Icons.description_outlined;
//     }
//   }

//   String _docTypeLabel(String type) {
//     switch (type.toLowerCase()) {
//       case 'lab_result': return 'Lab Result';
//       case 'prescription': return 'Prescription';
//       case 'hearing_test': return 'Hearing Test';
//       case 'vision_test': return 'Vision Test';
//       case 'previous_report': return 'Previous Report';
//       case 'referral_letter': return 'Referral Letter';
//       case 'school_report': return 'School Report';
//       default: return 'Other';
//     }
//   }
// }


// // lib/view/parents/booking/parent_child_profile_screen.dart
// //
// // CHANGES vs original:
// //   • Speech tab now uses ParentSpeechController + ParentSpeechItem
// //     (the new isolated controller/service).
// //   • Screening tab is UNCHANGED — still uses ExpertChildDataController.
// //   • All other tabs (Overview, Health) are UNCHANGED.
// //   • Navigation to parentSpeechDetail now passes
// //     item.speechSubmissionId  ← this was the root bug.
// //
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/child_profile_controller.dart';
// import 'package:speechspectrum/controllers/expert_child_data_controller.dart';
// import 'package:speechspectrum/controllers/parent_speech_controller.dart'; // NEW
// import 'package:speechspectrum/models/child_profile_model.dart';
// import 'package:speechspectrum/routes/app_routes.dart';
// import 'package:speechspectrum/services/expert_child_data_service.dart';
// import 'package:speechspectrum/services/parent_speech_service.dart'; // NEW

// class ParentChildProfileScreen extends StatefulWidget {
//   const ParentChildProfileScreen({super.key});

//   @override
//   State<ParentChildProfileScreen> createState() =>
//       _ParentChildProfileScreenState();
// }

// class _ParentChildProfileScreenState extends State<ParentChildProfileScreen>
//     with SingleTickerProviderStateMixin {
//   late final ChildProfileController _profileCtrl;
//   late final ExpertChildDataController _dataCtrl; // screening only
//   late final ParentSpeechController _speechCtrl; // NEW — speech only
//   late final TabController _tab;
//   late final String _childId;
//   late final String _childName;

//   static const _tabs = [
//     ('Overview', Icons.person_outline_rounded),
//     ('Health', Icons.favorite_border_rounded),
//     ('Screening', Icons.assignment_outlined),
//     ('Speech', Icons.mic_outlined),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     final args = Get.arguments as Map<String, dynamic>? ?? {};
//     _childId = args['childId'] ?? '';
//     _childName = args['childName'] ?? 'Child Profile';

//     _tab = TabController(length: _tabs.length, vsync: this);

//     _profileCtrl = Get.isRegistered<ChildProfileController>()
//         ? Get.find<ChildProfileController>()
//         : Get.put(ChildProfileController());

//     _dataCtrl = Get.isRegistered<ExpertChildDataController>()
//         ? Get.find<ExpertChildDataController>()
//         : Get.put(ExpertChildDataController());

//     // ── NEW: register the dedicated speech controller ──────────────────────
//     _speechCtrl = Get.isRegistered<ParentSpeechController>()
//         ? Get.find<ParentSpeechController>()
//         : Get.put(ParentSpeechController());

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (_childId.isNotEmpty) {
//         _profileCtrl.loadAll(_childId);
//         _dataCtrl.fetchScreening(_childId); // screening unchanged
//         _speechCtrl.fetchSpeech(_childId); // NEW — uses correct service
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _tab.dispose();
//     super.dispose();
//   }

//   // ── PDF helpers ────────────────────────────────────────────────────────────

//   Future<void> _downloadScreeningPdf(
//       BuildContext context, ExpertScreeningItem item) async {
//     try {
//       final hasResult = item.questionnaireResults.isNotEmpty;
//       final result = hasResult ? item.questionnaireResults.first.result : null;

//       final pdf = pw.Document();
//       pdf.addPage(
//         pw.MultiPage(
//           pageFormat: PdfPageFormat.a4,
//           margin: const pw.EdgeInsets.all(40),
//           build: (pw.Context ctx) => [
//             pw.Container(
//               padding: const pw.EdgeInsets.all(20),
//               decoration: pw.BoxDecoration(
//                 color: PdfColor.fromHex('6C63FF'),
//                 borderRadius:
//                     const pw.BorderRadius.all(pw.Radius.circular(12)),
//               ),
//               child: pw.Column(
//                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 children: [
//                   pw.Text('ASD Screening Report',
//                       style: pw.TextStyle(
//                           fontSize: 24,
//                           fontWeight: pw.FontWeight.bold,
//                           color: PdfColors.white)),
//                   pw.SizedBox(height: 6),
//                   pw.Text('SpeechSpectrum — Parent View',
//                       style: const pw.TextStyle(
//                           fontSize: 12, color: PdfColors.white)),
//                 ],
//               ),
//             ),
//             pw.SizedBox(height: 20),
//             if (result != null) ...[
//               pw.Container(
//                 padding: const pw.EdgeInsets.all(16),
//                 decoration: pw.BoxDecoration(
//                   border:
//                       pw.Border.all(color: PdfColor.fromHex('E0E0E0')),
//                   borderRadius:
//                       const pw.BorderRadius.all(pw.Radius.circular(8)),
//                 ),
//                 child: pw.Column(
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: [
//                     pw.Text('Screening Result',
//                         style: pw.TextStyle(
//                             fontSize: 16,
//                             fontWeight: pw.FontWeight.bold)),
//                     pw.SizedBox(height: 10),
//                     _pdfRow('Child', _childName),
//                     pw.SizedBox(height: 4),
//                     _pdfRow('Prediction', result.prediction),
//                     pw.SizedBox(height: 4),
//                     _pdfRow('Probability', result.probability),
//                     pw.SizedBox(height: 4),
//                     _pdfRow('Date', item.formattedDate),
//                     pw.SizedBox(height: 4),
//                     _pdfRow('Time', item.formattedTime),
//                   ],
//                 ),
//               ),
//               pw.SizedBox(height: 20),
//             ],
//             pw.Text('Submission Information',
//                 style: pw.TextStyle(
//                     fontSize: 14, fontWeight: pw.FontWeight.bold)),
//             pw.SizedBox(height: 8),
//             pw.Container(
//               padding: const pw.EdgeInsets.all(12),
//               decoration: pw.BoxDecoration(
//                 color: PdfColor.fromHex('F8F9FA'),
//                 borderRadius:
//                     const pw.BorderRadius.all(pw.Radius.circular(8)),
//               ),
//               child: pw.Column(
//                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 children: [
//                   _pdfRow('Age (Months)',
//                       '${item.responses['Age_Mons'] ?? 'N/A'}'),
//                   _pdfRow('Gender',
//                       item.responses['Sex'] == 1 ? 'Male' : 'Female'),
//                   _pdfRow('Jaundice History',
//                       item.responses['Jaundice'] == 1 ? 'Yes' : 'No'),
//                   _pdfRow(
//                       'Family ASD History',
//                       item.responses['Family_mem_with_ASD'] == 1
//                           ? 'Yes'
//                           : 'No'),
//                 ],
//               ),
//             ),
//             pw.SizedBox(height: 20),
//             pw.Text('Questionnaire Responses',
//                 style: pw.TextStyle(
//                     fontSize: 14, fontWeight: pw.FontWeight.bold)),
//             pw.SizedBox(height: 8),
//             ...[
//               'A1',
//               'A2',
//               'A3',
//               'A4',
//               'A5',
//               'A6',
//               'A7',
//               'A8',
//               'A9',
//               'A10'
//             ].map((key) {
//               final val = item.responses[key];
//               final isPositive = val == 1;
//               return pw.Container(
//                 margin: const pw.EdgeInsets.only(bottom: 6),
//                 padding: const pw.EdgeInsets.symmetric(
//                     horizontal: 12, vertical: 8),
//                 decoration: pw.BoxDecoration(
//                   color: isPositive
//                       ? PdfColor.fromHex('E8F5E9')
//                       : PdfColor.fromHex('FFEBEE'),
//                   borderRadius:
//                       const pw.BorderRadius.all(pw.Radius.circular(6)),
//                 ),
//                 child: pw.Row(
//                   mainAxisAlignment:
//                       pw.MainAxisAlignment.spaceBetween,
//                   children: [
//                     pw.Expanded(
//                         child: pw.Text(_questionLabel(key),
//                             style: const pw.TextStyle(fontSize: 11))),
//                     pw.SizedBox(width: 10),
//                     pw.Text(
//                       isPositive ? 'Positive' : 'Negative',
//                       style: pw.TextStyle(
//                         fontSize: 11,
//                         fontWeight: pw.FontWeight.bold,
//                         color: isPositive
//                             ? PdfColor.fromHex('388E3C')
//                             : PdfColor.fromHex('D32F2F'),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             }).toList(),
//             pw.SizedBox(height: 20),
//             pw.Container(
//               padding: const pw.EdgeInsets.all(12),
//               decoration: pw.BoxDecoration(
//                 color: PdfColor.fromHex('FFF8E1'),
//                 borderRadius:
//                     const pw.BorderRadius.all(pw.Radius.circular(8)),
//               ),
//               child: pw.Text(
//                 'Disclaimer: This is a screening tool, not a diagnostic '
//                 'assessment. Professional evaluation by a qualified '
//                 'healthcare provider is recommended.',
//                 style: const pw.TextStyle(fontSize: 10),
//               ),
//             ),
//           ],
//         ),
//       );

//       final Uint8List bytes = await pdf.save();
//       final dir = await getApplicationDocumentsDirectory();
//       final childSafe = _childName.replaceAll(RegExp(r'[^\w]'), '_');
//       final file = File(
//           '${dir.path}/ASD_Screening_${childSafe}_${item.submissionId}.pdf');
//       await file.writeAsBytes(bytes);
//       await OpenFile.open(file.path);
//     } catch (e) {
//       Get.snackbar('Error', 'Could not generate PDF: $e',
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: AppColors.errorColor,
//           colorText: Colors.white,
//           margin: const EdgeInsets.all(16),
//           borderRadius: 12);
//     }
//   }

//   // ── Speech PDF now uses ParentSpeechItem ───────────────────────────────────
//   Future<void> _downloadSpeechPdf(
//       BuildContext context, ParentSpeechItem item) async {
//     try {
//       final analysisResult = item.latestResult?.result;
//       if (analysisResult == null) return;

//       final pdf = pw.Document();
//       pdf.addPage(
//         pw.MultiPage(
//           pageFormat: PdfPageFormat.a4,
//           margin: const pw.EdgeInsets.all(40),
//           build: (pw.Context ctx) => [
//             pw.Container(
//               padding: const pw.EdgeInsets.all(20),
//               decoration: pw.BoxDecoration(
//                 color: PdfColor.fromHex('6C63FF'),
//                 borderRadius:
//                     const pw.BorderRadius.all(pw.Radius.circular(12)),
//               ),
//               child: pw.Column(
//                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 children: [
//                   pw.Text('Speech Analysis Report',
//                       style: pw.TextStyle(
//                           fontSize: 24,
//                           fontWeight: pw.FontWeight.bold,
//                           color: PdfColors.white)),
//                   pw.SizedBox(height: 6),
//                   pw.Text('SpeechSpectrum — Parent View',
//                       style: const pw.TextStyle(
//                           fontSize: 12, color: PdfColors.white)),
//                 ],
//               ),
//             ),
//             pw.SizedBox(height: 20),
//             pw.Container(
//               padding: const pw.EdgeInsets.all(16),
//               decoration: pw.BoxDecoration(
//                 border:
//                     pw.Border.all(color: PdfColor.fromHex('E0E0E0')),
//                 borderRadius:
//                     const pw.BorderRadius.all(pw.Radius.circular(8)),
//               ),
//               child: pw.Column(
//                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 children: [
//                   pw.Text('Analysis Result',
//                       style: pw.TextStyle(
//                           fontSize: 16,
//                           fontWeight: pw.FontWeight.bold)),
//                   pw.SizedBox(height: 10),
//                   _pdfRow('Child', _childName),
//                   pw.SizedBox(height: 4),
//                   _pdfRow('Risk Level',
//                       analysisResult.riskInterpretation),
//                   pw.SizedBox(height: 4),
//                   _pdfRow('Severity Score',
//                       '${analysisResult.severityScore} / ${analysisResult.maxScore}'),
//                   pw.SizedBox(height: 4),
//                   _pdfRow('Date', item.formattedDate),
//                   pw.SizedBox(height: 4),
//                   _pdfRow('Time', item.formattedTime),
//                   pw.SizedBox(height: 4),
//                   _pdfRow('Duration',
//                       '${item.recordingDurationSeconds} seconds'),
//                 ],
//               ),
//             ),
//             pw.SizedBox(height: 20),
//             if (analysisResult.bioMarkers != null) ...[
//               pw.Text('Bio-markers',
//                   style: pw.TextStyle(
//                       fontSize: 14, fontWeight: pw.FontWeight.bold)),
//               pw.SizedBox(height: 8),
//               pw.Container(
//                 padding: const pw.EdgeInsets.all(12),
//                 decoration: pw.BoxDecoration(
//                   color: PdfColor.fromHex('F8F9FA'),
//                   borderRadius:
//                       const pw.BorderRadius.all(pw.Radius.circular(8)),
//                 ),
//                 child: pw.Column(
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: [
//                     _pdfRow(
//                         'Pitch Instability',
//                         '${analysisResult.bioMarkers!.pitchInstability.toStringAsFixed(1)} Hz'),
//                     pw.SizedBox(height: 4),
//                     _pdfRow(
//                         'Resonance Jitter F1',
//                         '${analysisResult.bioMarkers!.resonanceJitterF1.toStringAsFixed(1)} Hz'),
//                     pw.SizedBox(height: 4),
//                     _pdfRow(
//                         'Resonance Jitter F2',
//                         '${analysisResult.bioMarkers!.resonanceJitterF2.toStringAsFixed(1)} Hz'),
//                   ],
//                 ),
//               ),
//               pw.SizedBox(height: 20),
//             ],
//             pw.Text('Interpretation',
//                 style: pw.TextStyle(
//                     fontSize: 14, fontWeight: pw.FontWeight.bold)),
//             pw.SizedBox(height: 8),
//             pw.Container(
//               padding: const pw.EdgeInsets.all(12),
//               decoration: pw.BoxDecoration(
//                 color: PdfColor.fromHex('F8F9FA'),
//                 borderRadius:
//                     const pw.BorderRadius.all(pw.Radius.circular(8)),
//               ),
//               child: pw.Text(
//                 _speechInterpretation(analysisResult),
//                 style: const pw.TextStyle(fontSize: 11),
//               ),
//             ),
//             pw.SizedBox(height: 20),
//             pw.Container(
//               padding: const pw.EdgeInsets.all(12),
//               decoration: pw.BoxDecoration(
//                 color: PdfColor.fromHex('FFF8E1'),
//                 borderRadius:
//                     const pw.BorderRadius.all(pw.Radius.circular(8)),
//               ),
//               child: pw.Text(
//                 'Disclaimer: This is a screening tool, not a diagnostic '
//                 'assessment. Professional evaluation by a qualified '
//                 'healthcare provider is recommended.',
//                 style: const pw.TextStyle(fontSize: 10),
//               ),
//             ),
//           ],
//         ),
//       );

//       final Uint8List bytes = await pdf.save();
//       final dir = await getApplicationDocumentsDirectory();
//       final childSafe = _childName.replaceAll(RegExp(r'[^\w]'), '_');
//       final file = File(
//           '${dir.path}/Speech_Report_${childSafe}_${item.speechSubmissionId}.pdf');
//       await file.writeAsBytes(bytes);
//       await OpenFile.open(file.path);
//     } catch (e) {
//       Get.snackbar('Error', 'Could not generate PDF: $e',
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: AppColors.errorColor,
//           colorText: Colors.white,
//           margin: const EdgeInsets.all(16),
//           borderRadius: 12);
//     }
//   }

//   pw.Widget _pdfRow(String label, String value) {
//     return pw.Padding(
//       padding: const pw.EdgeInsets.only(bottom: 4),
//       child: pw.Row(children: [
//         pw.Text('$label: ',
//             style: pw.TextStyle(
//                 fontWeight: pw.FontWeight.bold, fontSize: 11)),
//         pw.Text(value, style: const pw.TextStyle(fontSize: 11)),
//       ]),
//     );
//   }

//   String _questionLabel(String key) {
//     const map = {
//       'A1': 'Does your child look at you when called?',
//       'A2': 'How easy is eye contact with your child?',
//       'A3': 'Does your child point to indicate wants?',
//       'A4': 'Does your child point to share interest?',
//       'A5': 'Does your child pretend play?',
//       'A6': "Does your child follow where you're looking?",
//       'A7': 'Does your child show signs of comforting others?',
//       'A8': 'How would you describe first words?',
//       'A9': 'Does your child use simple gestures?',
//       'A10': 'Does your child stare at nothing?',
//     };
//     return map[key] ?? key;
//   }

//   String _speechInterpretation(ParentSpeechAnalysis r) {
//     if (r.isLowRisk) {
//       return 'The speech pattern shows low-risk indicators and appears '
//           'within a typical developmental range.';
//     } else if (r.isModerateRisk) {
//       return 'The speech pattern shows moderate-risk characteristics. '
//           'Consider consulting a speech therapist.';
//     } else {
//       return 'The speech pattern shows high-risk indicators. Professional '
//           'speech therapy intervention is strongly recommended.';
//     }
//   }

//   // ── Build ──────────────────────────────────────────────────────────────────

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();
//     return Scaffold(
//       backgroundColor: AppColors.lightGreyColor,
//       body: Obx(() {
//         final isLoading = _profileCtrl.isLoadingProfile.value ||
//             _profileCtrl.isLoadingHealth.value;
//         final profile = _profileCtrl.childProfile.value;

//         return NestedScrollView(
//           headerSliverBuilder: (ctx, inner) => [
//             _buildSliverAppBar(context, size, profile, isLoading),
//           ],
//           body: isLoading && profile == null
//               ? _buildLoader()
//               : TabBarView(
//                   controller: _tab,
//                   children: [
//                     _buildOverviewTab(context, size),
//                     _buildHealthTab(context, size),
//                     _buildScreeningTab(context, size),
//                     _buildSpeechTab(context, size), // uses _speechCtrl
//                   ],
//                 ),
//         );
//       }),
//     );
//   }

//   Widget _buildSliverAppBar(
//     BuildContext context,
//     CustomSize size,
//     ChildData? profile,
//     bool isLoading,
//   ) {
//     return SliverAppBar(
//       expandedHeight: 230,
//       pinned: true,
//       backgroundColor: AppColors.primaryColor,
//       surfaceTintColor: Colors.transparent,
//       leading: IconButton(
//         icon: const Icon(Icons.arrow_back_ios_new_rounded,
//             color: Colors.white, size: 20),
//         onPressed: () => Get.back(),
//       ),
//       actions: [
//         if (isLoading)
//           const Padding(
//             padding: EdgeInsets.all(14),
//             child: SizedBox(
//                 width: 20,
//                 height: 20,
//                 child: CircularProgressIndicator(
//                     color: Colors.white, strokeWidth: 2)),
//           )
//         else
//           IconButton(
//             icon: const Icon(Icons.refresh_rounded, color: Colors.white),
//             onPressed: () {
//               _profileCtrl.refreshProfile(_childId);
//               _dataCtrl.fetchScreening(_childId);
//               _speechCtrl.fetchSpeech(_childId, forceRefresh: true);
//             },
//           ),
//         const SizedBox(width: 4),
//       ],
//       flexibleSpace: FlexibleSpaceBar(
//         background: _buildAppBarBackground(profile),
//       ),
//       bottom: TabBar(
//         controller: _tab,
//         labelColor: Colors.white,
//         unselectedLabelColor: Colors.white60,
//         indicatorColor: Colors.white,
//         indicatorWeight: 3,
//         isScrollable: true,
//         tabAlignment: TabAlignment.start,
//         labelStyle: GoogleFonts.poppins(
//             fontWeight: FontWeight.w600, fontSize: 12.5),
//         unselectedLabelStyle: GoogleFonts.poppins(
//             fontWeight: FontWeight.w500, fontSize: 12.5),
//         tabs: _tabs
//             .map((t) => Tab(
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(t.$2, size: 14),
//                       const SizedBox(width: 5),
//                       Text(t.$1),
//                     ],
//                   ),
//                 ))
//             .toList(),
//       ),
//     );
//   }

//   Widget _buildAppBarBackground(ChildData? profile) {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [AppColors.primaryColor, AppColors.secondaryColor],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       child: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const SizedBox(height: 12),
//             Container(
//               width: 80,
//               height: 80,
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.2),
//                 shape: BoxShape.circle,
//                 border: Border.all(color: Colors.white, width: 3),
//               ),
//               child: Center(
//                 child: Text(
//                   profile?.initials ?? _initials(_childName),
//                   style: GoogleFonts.poppins(
//                       color: Colors.white,
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               profile?.childName ?? _childName,
//               style: GoogleFonts.poppins(
//                   color: Colors.white,
//                   fontSize: 20,
//                   fontWeight: FontWeight.w700),
//             ),
//             if (profile != null) ...[
//               const SizedBox(height: 4),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   _pillChip(
//                     profile.gender[0].toUpperCase() +
//                         profile.gender.substring(1),
//                     profile.gender.toLowerCase() == 'male'
//                         ? Icons.male_rounded
//                         : Icons.female_rounded,
//                   ),
//                   const SizedBox(width: 8),
//                   _pillChip(profile.age, Icons.cake_outlined),
//                 ],
//               ),
//             ],
//             const SizedBox(height: 50),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _pillChip(String label, IconData icon) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.2),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: Colors.white.withOpacity(0.4)),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, color: Colors.white, size: 12),
//           const SizedBox(width: 4),
//           Text(label,
//               style: GoogleFonts.poppins(
//                   color: Colors.white,
//                   fontSize: 11,
//                   fontWeight: FontWeight.w500)),
//         ],
//       ),
//     );
//   }

//   // ── Overview Tab (UNCHANGED) ───────────────────────────────────────────────

//   Widget _buildOverviewTab(BuildContext context, CustomSize size) {
//     return Obx(() {
//       final profile = _profileCtrl.childProfile.value;
//       if (profile == null) return _buildEmpty('No profile data available');

//       return ListView(
//         padding: EdgeInsets.fromLTRB(
//           size.customWidth(context) * 0.045,
//           size.customHeight(context) * 0.02,
//           size.customWidth(context) * 0.045,
//           size.customHeight(context) * 0.04,
//         ),
//         children: [
//           _sectionCard(
//             title: 'Basic Information',
//             icon: Icons.person_outline_rounded,
//             children: [
//               _infoRow(
//                   'Full Name', profile.childName, Icons.badge_outlined),
//               _divider(),
//               _infoRow('Date of Birth', profile.formattedDob,
//                   Icons.cake_outlined),
//               _divider(),
//               _infoRow('Age', profile.age,
//                   Icons.hourglass_bottom_rounded),
//               _divider(),
//               _infoRow(
//                 'Gender',
//                 profile.gender[0].toUpperCase() +
//                     profile.gender.substring(1),
//                 profile.gender.toLowerCase() == 'male'
//                     ? Icons.male_rounded
//                     : Icons.female_rounded,
//               ),
//             ],
//           ),
//           SizedBox(height: size.customHeight(context) * 0.018),
//           _buildHealthSnapshotCard(context, size),
//         ],
//       );
//     });
//   }

//   Widget _buildHealthSnapshotCard(BuildContext context, CustomSize size) {
//     return Obx(() {
//       final health = _profileCtrl.childHealth.value;
//       if (health == null) return const SizedBox.shrink();

//       return _sectionCard(
//         title: 'Health Snapshot',
//         icon: Icons.monitor_heart_outlined,
//         children: [
//           Row(
//             children: [
//               Expanded(
//                   child: _metricBox(
//                       'Weight',
//                       health.weightKg != null
//                           ? '${health.weightKg!.toStringAsFixed(1)} kg'
//                           : '—',
//                       Icons.scale_outlined,
//                       AppColors.primaryColor)),
//               const SizedBox(width: 10),
//               Expanded(
//                   child: _metricBox(
//                       'Height',
//                       health.heightCm != null
//                           ? '${health.heightCm!.toStringAsFixed(1)} cm'
//                           : '—',
//                       Icons.height_rounded,
//                       AppColors.secondaryColor)),
//               const SizedBox(width: 10),
//               Expanded(
//                   child: _metricBox(
//                       'BMI',
//                       health.bmi != null
//                           ? health.bmi!.toStringAsFixed(2)
//                           : '—',
//                       Icons.analytics_outlined,
//                       AppColors.accentColor)),
//             ],
//           ),
//           if (health.bloodGroup != null) ...[
//             const SizedBox(height: 12),
//             _divider(),
//             const SizedBox(height: 4),
//             _infoRow('Blood Group', health.bloodGroup!,
//                 Icons.bloodtype_outlined),
//           ],
//         ],
//       );
//     });
//   }

//   // ── Health Tab (UNCHANGED) ─────────────────────────────────────────────────

//   Widget _buildHealthTab(BuildContext context, CustomSize size) {
//     return Obx(() {
//       if (_profileCtrl.isLoadingHealth.value &&
//           _profileCtrl.childHealth.value == null) {
//         return _buildLoader();
//       }
//       final health = _profileCtrl.childHealth.value;
//       if (health == null) {
//         return _buildEmpty(
//             'No health profile available for this child');
//       }

//       return ListView(
//         padding: EdgeInsets.fromLTRB(
//           size.customWidth(context) * 0.045,
//           size.customHeight(context) * 0.02,
//           size.customWidth(context) * 0.045,
//           size.customHeight(context) * 0.04,
//         ),
//         children: [
//           _sectionCard(
//             title: 'Vitals',
//             icon: Icons.monitor_heart_outlined,
//             children: [
//               Row(
//                 children: [
//                   Expanded(
//                       child: _metricBox(
//                           'Weight',
//                           health.weightKg != null
//                               ? '${health.weightKg!.toStringAsFixed(1)} kg'
//                               : '—',
//                           Icons.scale_outlined,
//                           AppColors.primaryColor)),
//                   const SizedBox(width: 10),
//                   Expanded(
//                       child: _metricBox(
//                           'Height',
//                           health.heightCm != null
//                               ? '${health.heightCm!.toStringAsFixed(1)} cm'
//                               : '—',
//                           Icons.height_rounded,
//                           AppColors.secondaryColor)),
//                   const SizedBox(width: 10),
//                   Expanded(
//                       child: _metricBox(
//                           'BMI',
//                           health.bmi != null
//                               ? health.bmi!.toStringAsFixed(2)
//                               : '—',
//                           Icons.analytics_outlined,
//                           AppColors.accentColor)),
//                 ],
//               ),
//               if (health.bloodGroup != null) ...[
//                 const SizedBox(height: 12),
//                 _divider(),
//                 const SizedBox(height: 4),
//                 _infoRow('Blood Group', health.bloodGroup!,
//                     Icons.bloodtype_outlined,
//                     valueColor: AppColors.errorColor),
//               ],
//             ],
//           ),
//           SizedBox(height: size.customHeight(context) * 0.018),
//           _sectionCard(
//             title: 'Conditions & Allergies',
//             icon: Icons.medical_services_outlined,
//             children: [
//               if (health.knownAllergies != null &&
//                   health.knownAllergies!.isNotEmpty &&
//                   health.knownAllergies!.toLowerCase() != 'none') ...[
//                 _alertRow('Known Allergies', health.knownAllergies!,
//                     Icons.warning_amber_rounded, AppColors.warningColor),
//                 _divider(),
//               ],
//               if (health.chronicConditions != null &&
//                   health.chronicConditions!.isNotEmpty &&
//                   health.chronicConditions!.toLowerCase() != 'none') ...[
//                 _alertRow(
//                     'Chronic Conditions',
//                     health.chronicConditions!,
//                     Icons.local_hospital_outlined,
//                     AppColors.errorColor),
//                 _divider(),
//               ],
//               if (health.geneticDisorders != null &&
//                   health.geneticDisorders!.isNotEmpty &&
//                   health.geneticDisorders!.toLowerCase() != 'none')
//                 _alertRow(
//                     'Genetic Disorders',
//                     health.geneticDisorders!,
//                     Icons.biotech_outlined,
//                     const Color(0xFF7B1FA2))
//               else
//                 _infoRow('Genetic Disorders', 'None reported',
//                     Icons.biotech_outlined),
//             ],
//           ),
//           SizedBox(height: size.customHeight(context) * 0.018),
//           _sectionCard(
//             title: 'Family History',
//             icon: Icons.family_restroom_rounded,
//             children: [
//               _familyHistoryRow('ASD History', health.familyHistoryAsd,
//                   Icons.psychology_outlined),
//               _divider(),
//               _familyHistoryRow(
//                   'Speech Disorders',
//                   health.familyHistorySpeechDisorders,
//                   Icons.record_voice_over_outlined),
//               _divider(),
//               _familyHistoryRow('Hearing Loss',
//                   health.familyHistoryHearingLoss, Icons.hearing_outlined),
//             ],
//           ),
//           SizedBox(height: size.customHeight(context) * 0.018),
//           if (health.medicalRecords.isNotEmpty)
//             _sectionCard(
//               title:
//                   'Medical Records (${health.medicalRecords.length})',
//               icon: Icons.folder_outlined,
//               children: health.medicalRecords
//                   .map((r) => _recordRow(r))
//                   .toList(),
//             ),
//         ],
//       );
//     });
//   }

//   Widget _recordRow(MedicalRecord record) {
//     final color = _docTypeColor(record.documentType);
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Row(
//         children: [
//           Container(
//             width: 38,
//             height: 38,
//             decoration: BoxDecoration(
//               color: color.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(10),
//               border: Border.all(color: color.withOpacity(0.3)),
//             ),
//             child: Icon(_docTypeIcon(record.documentType),
//                 color: color, size: 18),
//           ),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(record.displayName,
//                     style: GoogleFonts.poppins(
//                         fontSize: 12.5,
//                         fontWeight: FontWeight.w600,
//                         color: AppColors.textPrimaryColor),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis),
//                 Text(record.formattedUploadDate,
//                     style: GoogleFonts.poppins(
//                         fontSize: 11,
//                         color: AppColors.textSecondaryColor)),
//               ],
//             ),
//           ),
//           Container(
//             padding:
//                 const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
//             decoration: BoxDecoration(
//               color: color.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(6),
//             ),
//             child: Text(_docTypeLabel(record.documentType),
//                 style: GoogleFonts.poppins(
//                     fontSize: 10,
//                     fontWeight: FontWeight.w600,
//                     color: color)),
//           ),
//         ],
//       ),
//     );
//   }

//   // ── Screening Tab (UNCHANGED) ──────────────────────────────────────────────

//   Widget _buildScreeningTab(BuildContext context, CustomSize size) {
//     return Obx(() {
//       if (_dataCtrl.isLoadingScreening.value &&
//           _dataCtrl.screeningList.isEmpty) {
//         return _buildLoader();
//       }

//       return Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.fromLTRB(
//               size.customWidth(context) * 0.045,
//               size.customHeight(context) * 0.015,
//               size.customWidth(context) * 0.045,
//               size.customHeight(context) * 0.01,
//             ),
//             child: _searchBar(
//               hint: 'Search by probability or result...',
//               onChanged: _dataCtrl.filterScreening,
//               value: _dataCtrl.screeningSearch.value,
//             ),
//           ),
//           Expanded(
//             child: _dataCtrl.filteredScreeningList.isEmpty
//                 ? _buildEmpty(
//                     _dataCtrl.screeningSearch.value.isNotEmpty
//                         ? 'No results match your search'
//                         : 'No screening submissions for this child')
//                 : RefreshIndicator(
//                     color: AppColors.primaryColor,
//                     onRefresh: () =>
//                         _dataCtrl.fetchScreening(_childId),
//                     child: ListView.builder(
//                       padding: EdgeInsets.fromLTRB(
//                         size.customWidth(context) * 0.045,
//                         0,
//                         size.customWidth(context) * 0.045,
//                         size.customHeight(context) * 0.04,
//                       ),
//                       itemCount:
//                           _dataCtrl.filteredScreeningList.length,
//                       itemBuilder: (_, i) => _screeningCard(context,
//                           size, _dataCtrl.filteredScreeningList[i]),
//                     ),
//                   ),
//           ),
//         ],
//       );
//     });
//   }

//   Widget _screeningCard(BuildContext context, CustomSize size,
//       ExpertScreeningItem item) {
//     final hasResult = item.questionnaireResults.isNotEmpty;
//     final result =
//         hasResult ? item.questionnaireResults.first.result : null;

//     Color riskColor = AppColors.greyColor;
//     if (result != null) {
//       if (result.isHighRisk) {
//         riskColor = AppColors.errorColor;
//       } else if (result.isMediumRisk) {
//         riskColor = AppColors.warningColor;
//       } else {
//         riskColor = AppColors.successColor;
//       }
//     }

//     return GestureDetector(
//       onTap: () {
//         Get.toNamed(
//           AppRoutes.parentScreeningDetail,
//           arguments: {
//             'submissionId': item.submissionId,
//             'childName': _childName,
//           },
//         );
//       },
//       child: Container(
//         margin:
//             EdgeInsets.only(bottom: size.customHeight(context) * 0.014),
//         decoration: BoxDecoration(
//           color: AppColors.whiteColor,
//           borderRadius: BorderRadius.circular(18),
//           boxShadow: [
//             BoxShadow(
//                 color: Colors.black.withOpacity(0.06),
//                 blurRadius: 14,
//                 offset: const Offset(0, 4))
//           ],
//         ),
//         child: Column(
//           children: [
//             Container(
//               height: 4,
//               decoration: BoxDecoration(
//                 color: riskColor,
//                 borderRadius: const BorderRadius.vertical(
//                     top: Radius.circular(18)),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Container(
//                         width: 52,
//                         height: 52,
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [
//                               riskColor.withOpacity(0.7),
//                               riskColor
//                             ],
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                           ),
//                           borderRadius: BorderRadius.circular(14),
//                         ),
//                         child: const Icon(Icons.assignment_outlined,
//                             size: 26, color: Colors.white),
//                       ),
//                       SizedBox(
//                           width: size.customWidth(context) * 0.03),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(item.formattedDate,
//                                 style: GoogleFonts.poppins(
//                                     fontSize: 13.5,
//                                     fontWeight: FontWeight.w700,
//                                     color: AppColors.textPrimaryColor)),
//                             const SizedBox(height: 2),
//                             Text(item.formattedTime,
//                                 style: GoogleFonts.poppins(
//                                     fontSize: 11.5,
//                                     color:
//                                         AppColors.textSecondaryColor)),
//                           ],
//                         ),
//                       ),
//                       if (result != null) ...[
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 10, vertical: 4),
//                               decoration: BoxDecoration(
//                                 color: riskColor.withOpacity(0.1),
//                                 borderRadius:
//                                     BorderRadius.circular(20),
//                                 border: Border.all(
//                                     color: riskColor.withOpacity(0.3)),
//                               ),
//                               child: Text(result.probability,
//                                   style: GoogleFonts.poppins(
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.bold,
//                                       color: riskColor)),
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               result.prediction.length > 22
//                                   ? '${result.prediction.substring(0, 22)}...'
//                                   : result.prediction,
//                               style: GoogleFonts.poppins(
//                                   fontSize: 10.5,
//                                   color: riskColor,
//                                   fontWeight: FontWeight.w500),
//                             ),
//                           ],
//                         ),
//                       ],
//                       const SizedBox(width: 6),
//                       const Icon(Icons.arrow_forward_ios_rounded,
//                           size: 13, color: AppColors.primaryColor),
//                     ],
//                   ),
//                   SizedBox(
//                       height: size.customHeight(context) * 0.012),
//                   Divider(
//                       height: 1,
//                       color: AppColors.greyColor.withOpacity(0.15)),
//                   SizedBox(
//                       height: size.customHeight(context) * 0.01),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text('View Details',
//                               style: GoogleFonts.poppins(
//                                   fontSize: 11,
//                                   color: AppColors.primaryColor,
//                                   fontWeight: FontWeight.w500)),
//                           const SizedBox(width: 3),
//                           const Icon(Icons.arrow_forward_ios_rounded,
//                               size: 11,
//                               color: AppColors.primaryColor),
//                         ],
//                       ),
//                       if (hasResult)
//                         GestureDetector(
//                           onTap: () =>
//                               _downloadScreeningPdf(context, item),
//                           behavior: HitTestBehavior.opaque,
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 10, vertical: 5),
//                             decoration: BoxDecoration(
//                               color: AppColors.primaryColor
//                                   .withOpacity(0.06),
//                               borderRadius:
//                                   BorderRadius.circular(20),
//                               border: Border.all(
//                                   color: AppColors.primaryColor
//                                       .withOpacity(0.2)),
//                             ),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 const Icon(
//                                     Icons.picture_as_pdf_outlined,
//                                     size: 12,
//                                     color: AppColors.primaryColor),
//                                 const SizedBox(width: 4),
//                                 Text('Download PDF',
//                                     style: GoogleFonts.poppins(
//                                         fontSize: 11,
//                                         fontWeight: FontWeight.w600,
//                                         color:
//                                             AppColors.primaryColor)),
//                                 const SizedBox(width: 4),
//                                 const Icon(Icons.download_outlined,
//                                     size: 11,
//                                     color: AppColors.primaryColor),
//                               ],
//                             ),
//                           ),
//                         )
//                       else
//                         Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             const Icon(Icons.pending_rounded,
//                                 size: 12,
//                                 color: AppColors.warningColor),
//                             const SizedBox(width: 4),
//                             Text('Analysis pending',
//                                 style: GoogleFonts.poppins(
//                                     fontSize: 11,
//                                     color: AppColors.warningColor,
//                                     fontWeight: FontWeight.w500)),
//                           ],
//                         ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ── Speech Tab — uses ParentSpeechController ───────────────────────────────

//   Widget _buildSpeechTab(BuildContext context, CustomSize size) {
//     return Obx(() {
//       if (_speechCtrl.isLoadingSpeech.value &&
//           _speechCtrl.speechList.isEmpty) {
//         return _buildLoader();
//       }

//       return Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.fromLTRB(
//               size.customWidth(context) * 0.045,
//               size.customHeight(context) * 0.015,
//               size.customWidth(context) * 0.045,
//               size.customHeight(context) * 0.01,
//             ),
//             child: _searchBar(
//               hint: 'Search by risk level...',
//               onChanged: _speechCtrl.filterSpeech,
//               value: _speechCtrl.speechSearch.value,
//             ),
//           ),
//           Expanded(
//             child: _speechCtrl.filteredSpeechList.isEmpty
//                 ? _buildEmpty(
//                     _speechCtrl.speechSearch.value.isNotEmpty
//                         ? 'No results match your search'
//                         : 'No speech submissions for this child')
//                 : RefreshIndicator(
//                     color: AppColors.primaryColor,
//                     onRefresh: () =>
//                         _speechCtrl.fetchSpeech(_childId,
//                             forceRefresh: true),
//                     child: ListView.builder(
//                       padding: EdgeInsets.fromLTRB(
//                         size.customWidth(context) * 0.045,
//                         0,
//                         size.customWidth(context) * 0.045,
//                         size.customHeight(context) * 0.04,
//                       ),
//                       itemCount:
//                           _speechCtrl.filteredSpeechList.length,
//                       itemBuilder: (_, i) => _speechCard(context, size,
//                           _speechCtrl.filteredSpeechList[i]),
//                     ),
//                   ),
//           ),
//         ],
//       );
//     });
//   }

//   // ── Speech card — uses ParentSpeechItem ────────────────────────────────────
//   Widget _speechCard(BuildContext context, CustomSize size,
//       ParentSpeechItem item) {
//     final hasResult = item.hasResults;
//     final analysisResult = item.latestResult?.result;

//     Color riskColor = AppColors.greyColor;
//     IconData riskIcon = Icons.pending_rounded;
//     if (analysisResult != null) {
//       if (analysisResult.isHighRisk) {
//         riskColor = AppColors.errorColor;
//         riskIcon = Icons.warning_rounded;
//       } else if (analysisResult.isModerateRisk) {
//         riskColor = AppColors.warningColor;
//         riskIcon = Icons.info_rounded;
//       } else {
//         riskColor = AppColors.successColor;
//         riskIcon = Icons.check_circle_rounded;
//       }
//     }

//     return GestureDetector(
//       onTap: () {
//         // ── FIX: pass speechSubmissionId (not submissionId) ──────────────────
//         debugPrint(
//             '🖱️ Speech card tapped — speechSubmissionId="${item.speechSubmissionId}"');

//         Get.toNamed(
//           AppRoutes.parentSpeechDetail,
//           arguments: {
//             'submissionId': item.speechSubmissionId, // ← CORRECT field
//             'childName': _childName,
//           },
//         );
//       },
//       child: Container(
//         margin:
//             EdgeInsets.only(bottom: size.customHeight(context) * 0.014),
//         decoration: BoxDecoration(
//           color: AppColors.whiteColor,
//           borderRadius: BorderRadius.circular(18),
//           boxShadow: [
//             BoxShadow(
//                 color: Colors.black.withOpacity(0.06),
//                 blurRadius: 14,
//                 offset: const Offset(0, 4))
//           ],
//         ),
//         child: Column(
//           children: [
//             Container(
//               height: 4,
//               decoration: BoxDecoration(
//                 color: riskColor,
//                 borderRadius: const BorderRadius.vertical(
//                     top: Radius.circular(18)),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Container(
//                         width: 52,
//                         height: 52,
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [
//                               riskColor.withOpacity(0.7),
//                               riskColor
//                             ],
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                           ),
//                           borderRadius: BorderRadius.circular(14),
//                         ),
//                         child: Icon(riskIcon,
//                             size: 26, color: Colors.white),
//                       ),
//                       SizedBox(
//                           width: size.customWidth(context) * 0.03),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(item.formattedDate,
//                                 style: GoogleFonts.poppins(
//                                     fontSize: 13.5,
//                                     fontWeight: FontWeight.w700,
//                                     color: AppColors.textPrimaryColor)),
//                             const SizedBox(height: 2),
//                             Row(
//                               children: [
//                                 Icon(Icons.access_time_rounded,
//                                     size: 13,
//                                     color:
//                                         AppColors.textSecondaryColor),
//                                 const SizedBox(width: 3),
//                                 Text(
//                                     '${item.recordingDurationSeconds}s',
//                                     style: GoogleFonts.poppins(
//                                         fontSize: 11.5,
//                                         color: AppColors
//                                             .textSecondaryColor)),
//                                 const SizedBox(width: 8),
//                                 Icon(Icons.schedule_rounded,
//                                     size: 13,
//                                     color:
//                                         AppColors.textSecondaryColor),
//                                 const SizedBox(width: 3),
//                                 Text(item.formattedTime,
//                                     style: GoogleFonts.poppins(
//                                         fontSize: 11.5,
//                                         color: AppColors
//                                             .textSecondaryColor)),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       const Icon(Icons.arrow_forward_ios_rounded,
//                           size: 13, color: AppColors.primaryColor),
//                     ],
//                   ),

//                   if (hasResult && analysisResult != null) ...[
//                     SizedBox(
//                         height: size.customHeight(context) * 0.012),
//                     Divider(
//                         height: 1,
//                         color: AppColors.greyColor.withOpacity(0.15)),
//                     SizedBox(
//                         height: size.customHeight(context) * 0.01),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment:
//                                 CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                   analysisResult.riskInterpretation,
//                                   style: GoogleFonts.poppins(
//                                       fontSize: 12.5,
//                                       fontWeight: FontWeight.w700,
//                                       color: riskColor)),
//                               const SizedBox(height: 4),
//                               ClipRRect(
//                                 borderRadius:
//                                     BorderRadius.circular(6),
//                                 child: LinearProgressIndicator(
//                                   value: analysisResult.severityScore /
//                                       analysisResult.maxScore,
//                                   backgroundColor:
//                                       riskColor.withOpacity(0.15),
//                                   valueColor:
//                                       AlwaysStoppedAnimation<Color>(
//                                           riskColor),
//                                   minHeight: 7,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 10, vertical: 5),
//                           decoration: BoxDecoration(
//                             color: riskColor.withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(20),
//                             border: Border.all(
//                                 color: riskColor.withOpacity(0.4)),
//                           ),
//                           child: Text(
//                             '${analysisResult.severityScore}/${analysisResult.maxScore}',
//                             style: GoogleFonts.poppins(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.bold,
//                                 color: riskColor),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],

//                   SizedBox(
//                       height: size.customHeight(context) * 0.012),
//                   Divider(
//                       height: 1,
//                       color: AppColors.greyColor.withOpacity(0.15)),
//                   SizedBox(
//                       height: size.customHeight(context) * 0.01),

//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text('View Details',
//                               style: GoogleFonts.poppins(
//                                   fontSize: 11,
//                                   color: AppColors.primaryColor,
//                                   fontWeight: FontWeight.w500)),
//                           const SizedBox(width: 3),
//                           const Icon(Icons.arrow_forward_ios_rounded,
//                               size: 11,
//                               color: AppColors.primaryColor),
//                         ],
//                       ),
//                       if (hasResult && analysisResult != null)
//                         GestureDetector(
//                           onTap: () =>
//                               _downloadSpeechPdf(context, item),
//                           behavior: HitTestBehavior.opaque,
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 10, vertical: 5),
//                             decoration: BoxDecoration(
//                               color: AppColors.primaryColor
//                                   .withOpacity(0.06),
//                               borderRadius:
//                                   BorderRadius.circular(20),
//                               border: Border.all(
//                                   color: AppColors.primaryColor
//                                       .withOpacity(0.2)),
//                             ),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 const Icon(
//                                     Icons.picture_as_pdf_outlined,
//                                     size: 12,
//                                     color: AppColors.primaryColor),
//                                 const SizedBox(width: 4),
//                                 Text('Download PDF',
//                                     style: GoogleFonts.poppins(
//                                         fontSize: 11,
//                                         fontWeight: FontWeight.w600,
//                                         color:
//                                             AppColors.primaryColor)),
//                                 const SizedBox(width: 4),
//                                 const Icon(Icons.download_outlined,
//                                     size: 11,
//                                     color: AppColors.primaryColor),
//                               ],
//                             ),
//                           ),
//                         )
//                       else
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 10, vertical: 5),
//                           decoration: BoxDecoration(
//                             color: AppColors.warningColor
//                                 .withOpacity(0.07),
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               const Icon(Icons.pending_rounded,
//                                   size: 12,
//                                   color: AppColors.warningColor),
//                               const SizedBox(width: 4),
//                               Text('Analysis pending',
//                                   style: GoogleFonts.poppins(
//                                       fontSize: 11,
//                                       color: AppColors.warningColor,
//                                       fontWeight: FontWeight.w500)),
//                             ],
//                           ),
//                         ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ── Shared UI helpers (all UNCHANGED) ─────────────────────────────────────

//   Widget _searchBar({
//     required String hint,
//     required void Function(String) onChanged,
//     required String value,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(14),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withOpacity(0.06),
//               blurRadius: 12,
//               offset: const Offset(0, 3))
//         ],
//       ),
//       child: TextField(
//         onChanged: onChanged,
//         style: GoogleFonts.poppins(
//             fontSize: 13.5, color: AppColors.textPrimaryColor),
//         decoration: InputDecoration(
//           hintText: hint,
//           hintStyle: GoogleFonts.poppins(
//               color: AppColors.greyColor, fontSize: 13),
//           prefixIcon: const Icon(Icons.search,
//               color: AppColors.primaryColor),
//           suffixIcon: value.isNotEmpty
//               ? IconButton(
//                   icon: const Icon(Icons.clear,
//                       color: AppColors.greyColor, size: 18),
//                   onPressed: () => onChanged(''),
//                 )
//               : null,
//           border: InputBorder.none,
//           contentPadding: const EdgeInsets.symmetric(
//               horizontal: 16, vertical: 14),
//         ),
//       ),
//     );
//   }

//   Widget _sectionCard({
//     required String title,
//     required IconData icon,
//     required List<Widget> children,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 14,
//               offset: const Offset(0, 4))
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
//             child: Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(7),
//                   decoration: BoxDecoration(
//                     color:
//                         AppColors.primaryColor.withOpacity(0.08),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Icon(icon,
//                       color: AppColors.primaryColor, size: 16),
//                 ),
//                 const SizedBox(width: 10),
//                 Text(title,
//                     style: GoogleFonts.poppins(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w700,
//                         color: AppColors.textPrimaryColor)),
//               ],
//             ),
//           ),
//           Divider(
//               height: 1,
//               color: AppColors.greyColor.withOpacity(0.15)),
//           Padding(
//             padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: children,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _metricBox(
//       String label, String value, IconData icon, Color color) {
//     return Container(
//       padding:
//           const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.07),
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(color: color.withOpacity(0.2)),
//       ),
//       child: Column(
//         children: [
//           Icon(icon, color: color, size: 22),
//           const SizedBox(height: 6),
//           Text(value,
//               style: GoogleFonts.poppins(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w700,
//                   color: AppColors.textPrimaryColor)),
//           Text(label,
//               style: GoogleFonts.poppins(
//                   fontSize: 10,
//                   color: AppColors.textSecondaryColor)),
//         ],
//       ),
//     );
//   }

//   Widget _infoRow(String label, String value, IconData icon,
//       {Color? valueColor}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 7),
//       child: Row(
//         children: [
//           Icon(icon, size: 16, color: AppColors.textSecondaryColor),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Text(label,
//                 style: GoogleFonts.poppins(
//                     fontSize: 13,
//                     color: AppColors.textSecondaryColor,
//                     fontWeight: FontWeight.w500)),
//           ),
//           Text(value,
//               style: GoogleFonts.poppins(
//                   fontSize: 13,
//                   fontWeight: FontWeight.w600,
//                   color:
//                       valueColor ?? AppColors.textPrimaryColor)),
//         ],
//       ),
//     );
//   }

//   Widget _familyHistoryRow(
//       String label, bool hasHistory, IconData icon) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Row(
//         children: [
//           Icon(icon, size: 18, color: AppColors.textSecondaryColor),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Text(label,
//                 style: GoogleFonts.poppins(
//                     fontSize: 13,
//                     color: AppColors.textSecondaryColor,
//                     fontWeight: FontWeight.w500)),
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(
//                 horizontal: 10, vertical: 4),
//             decoration: BoxDecoration(
//               color: hasHistory
//                   ? AppColors.errorColor.withOpacity(0.1)
//                   : AppColors.successColor.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(20),
//               border: Border.all(
//                   color: hasHistory
//                       ? AppColors.errorColor.withOpacity(0.3)
//                       : AppColors.successColor.withOpacity(0.3)),
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(
//                   hasHistory
//                       ? Icons.check_circle_outline
//                       : Icons.cancel_outlined,
//                   size: 11,
//                   color: hasHistory
//                       ? AppColors.errorColor
//                       : AppColors.successColor,
//                 ),
//                 const SizedBox(width: 4),
//                 Text(hasHistory ? 'Yes' : 'No',
//                     style: GoogleFonts.poppins(
//                         fontSize: 11,
//                         fontWeight: FontWeight.w600,
//                         color: hasHistory
//                             ? AppColors.errorColor
//                             : AppColors.successColor)),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _alertRow(
//       String label, String value, IconData icon, Color color) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 4),
//       padding: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.06),
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: color.withOpacity(0.25)),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, size: 16, color: color),
//           const SizedBox(width: 8),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(label,
//                     style: GoogleFonts.poppins(
//                         fontSize: 11,
//                         color: color,
//                         fontWeight: FontWeight.w600)),
//                 const SizedBox(height: 2),
//                 Text(value,
//                     style: GoogleFonts.poppins(
//                         fontSize: 13,
//                         color: AppColors.textPrimaryColor,
//                         fontWeight: FontWeight.w500)),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _divider() =>
//       Divider(height: 1, color: AppColors.greyColor.withOpacity(0.12));

//   Widget _buildLoader() {
//     return const Center(
//       child: CircularProgressIndicator(
//           color: AppColors.primaryColor, strokeWidth: 3),
//     );
//   }

//   Widget _buildEmpty(String msg) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(32),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: 90,
//               height: 90,
//               decoration: BoxDecoration(
//                   color: AppColors.primaryColor.withOpacity(0.07),
//                   shape: BoxShape.circle),
//               child: const Icon(Icons.info_outline_rounded,
//                   size: 40, color: AppColors.primaryColor),
//             ),
//             const SizedBox(height: 16),
//             Text(msg,
//                 style: GoogleFonts.poppins(
//                     fontSize: 14,
//                     color: AppColors.textSecondaryColor),
//                 textAlign: TextAlign.center),
//           ],
//         ),
//       ),
//     );
//   }

//   String _initials(String name) {
//     final parts = name.trim().split(' ');
//     if (parts.length >= 2 &&
//         parts[0].isNotEmpty &&
//         parts[1].isNotEmpty) {
//       return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
//     }
//     return name.isNotEmpty ? name[0].toUpperCase() : 'C';
//   }

//   Color _docTypeColor(String type) {
//     switch (type.toLowerCase()) {
//       case 'lab_result':
//         return const Color(0xFF1565C0);
//       case 'prescription':
//         return AppColors.successColor;
//       case 'hearing_test':
//         return const Color(0xFF6A1B9A);
//       case 'vision_test':
//         return const Color(0xFF00838F);
//       case 'previous_report':
//         return AppColors.secondaryColor;
//       case 'referral_letter':
//         return const Color(0xFFE65100);
//       case 'school_report':
//         return const Color(0xFF2E7D32);
//       default:
//         return AppColors.accentColor;
//     }
//   }

//   IconData _docTypeIcon(String type) {
//     switch (type.toLowerCase()) {
//       case 'lab_result':
//         return Icons.science_outlined;
//       case 'prescription':
//         return Icons.medication_outlined;
//       case 'hearing_test':
//         return Icons.hearing_outlined;
//       case 'vision_test':
//         return Icons.visibility_outlined;
//       case 'previous_report':
//         return Icons.assignment_outlined;
//       case 'referral_letter':
//         return Icons.forward_to_inbox_outlined;
//       case 'school_report':
//         return Icons.school_outlined;
//       default:
//         return Icons.description_outlined;
//     }
//   }

//   String _docTypeLabel(String type) {
//     switch (type.toLowerCase()) {
//       case 'lab_result':
//         return 'Lab Result';
//       case 'prescription':
//         return 'Prescription';
//       case 'hearing_test':
//         return 'Hearing Test';
//       case 'vision_test':
//         return 'Vision Test';
//       case 'previous_report':
//         return 'Previous Report';
//       case 'referral_letter':
//         return 'Referral Letter';
//       case 'school_report':
//         return 'School Report';
//       default:
//         return 'Other';
//     }
//   }
// }


// lib/view/parents/booking/parent_child_profile_screen.dart
//
// Speech tab and PDF generation updated for new API response format:
//   { sa_score, severity_percentage, risk_level, model_type }
// All other tabs (Overview, Health, Screening) are UNCHANGED.
//
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import 'package:speechspectrum/controllers/child_profile_controller.dart';
import 'package:speechspectrum/controllers/expert_child_data_controller.dart';
import 'package:speechspectrum/controllers/parent_speech_controller.dart';
import 'package:speechspectrum/models/child_profile_model.dart';
import 'package:speechspectrum/routes/app_routes.dart';
import 'package:speechspectrum/services/expert_child_data_service.dart';
import 'package:speechspectrum/services/parent_speech_service.dart';

class ParentChildProfileScreen extends StatefulWidget {
  const ParentChildProfileScreen({super.key});

  @override
  State<ParentChildProfileScreen> createState() =>
      _ParentChildProfileScreenState();
}

class _ParentChildProfileScreenState extends State<ParentChildProfileScreen>
    with SingleTickerProviderStateMixin {
  late final ChildProfileController _profileCtrl;
  late final ExpertChildDataController _dataCtrl;
  late final ParentSpeechController _speechCtrl;
  late final TabController _tab;
  late final String _childId;
  late final String _childName;

  static const _tabs = [
    ('Overview', Icons.person_outline_rounded),
    ('Health', Icons.favorite_border_rounded),
    ('Screening', Icons.assignment_outlined),
    ('Speech', Icons.mic_outlined),
  ];

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    _childId = args['childId'] ?? '';
    _childName = args['childName'] ?? 'Child Profile';

    _tab = TabController(length: _tabs.length, vsync: this);

    _profileCtrl = Get.isRegistered<ChildProfileController>()
        ? Get.find<ChildProfileController>()
        : Get.put(ChildProfileController());

    _dataCtrl = Get.isRegistered<ExpertChildDataController>()
        ? Get.find<ExpertChildDataController>()
        : Get.put(ExpertChildDataController());

    _speechCtrl = Get.isRegistered<ParentSpeechController>()
        ? Get.find<ParentSpeechController>()
        : Get.put(ParentSpeechController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_childId.isNotEmpty) {
        _profileCtrl.loadAll(_childId);
        _dataCtrl.fetchScreening(_childId);
        _speechCtrl.fetchSpeech(_childId);
      }
    });
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  // ── Speech PDF — new format ────────────────────────────────────────────────
  Future<void> _downloadSpeechPdf(
      BuildContext context, ParentSpeechItem item) async {
    try {
      final analysisResult = item.latestResult?.result;
      if (analysisResult == null) return;

      final riskColor = _pdfRiskColor(analysisResult);

      final pdf = pw.Document();
      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(40),
          build: (pw.Context ctx) => [
            // ── Header ──────────────────────────────────────────────────────
            pw.Container(
              padding: const pw.EdgeInsets.all(20),
              decoration: pw.BoxDecoration(
                color: PdfColor.fromHex('6C63FF'),
                borderRadius:
                    const pw.BorderRadius.all(pw.Radius.circular(12)),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('Speech Analysis Report',
                      style: pw.TextStyle(
                          fontSize: 24,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.white)),
                  pw.SizedBox(height: 6),
                  pw.Text('SpeechSpectrum — Parent View',
                      style: const pw.TextStyle(
                          fontSize: 12, color: PdfColors.white)),
                ],
              ),
            ),
            pw.SizedBox(height: 20),

            // ── Summary card ─────────────────────────────────────────────────
            pw.Container(
              padding: const pw.EdgeInsets.all(16),
              decoration: pw.BoxDecoration(
                border:
                    pw.Border.all(color: PdfColor.fromHex('E0E0E0')),
                borderRadius:
                    const pw.BorderRadius.all(pw.Radius.circular(8)),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('Analysis Result',
                      style: pw.TextStyle(
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold)),
                  pw.SizedBox(height: 10),
                  _pdfRow('Child', _childName),
                  pw.SizedBox(height: 4),
                  _pdfRow('Risk Level', analysisResult.riskInterpretation),
                  pw.SizedBox(height: 4),
                  _pdfRow('Score',
                      '${analysisResult.saScore.toStringAsFixed(2)} / 22'),
                  // pw.SizedBox(height: 4),
                  // _pdfRow('Severity', analysisResult.severityPercentage),
                  // pw.SizedBox(height: 4),
                  // _pdfRow('Model', analysisResult.modelType),
                  pw.SizedBox(height: 4),
                  _pdfRow('Date', item.formattedDate),
                  pw.SizedBox(height: 4),
                  _pdfRow('Time', item.formattedTime),
                  pw.SizedBox(height: 4),
                  _pdfRow('Duration',
                      '${item.recordingDurationSeconds} seconds'),
                ],
              ),
            ),
            pw.SizedBox(height: 20),

            // ── Risk badge ───────────────────────────────────────────────────
            // pw.Container(
            //   padding: const pw.EdgeInsets.symmetric(
            //       horizontal: 16, vertical: 10),
            //   decoration: pw.BoxDecoration(
            //     // color: riskColor.withOpacity(0.1),
            //     color: PdfColor(riskColor.red, riskColor.green, riskColor.blue, 0.1),
            //     borderRadius:
            //         const pw.BorderRadius.all(pw.Radius.circular(8)),
            //     border:
            //         pw.Border.all(
            //           // color: riskColor.withOpacity(0.4)
            //          color: PdfColor(riskColor.red, riskColor.green, riskColor.blue, 0.4),
            //         ),
            //   ),
            //   child: pw.Row(
            //     mainAxisAlignment: pw.MainAxisAlignment.center,
            //     children: [
            //       pw.Text(
            //         analysisResult.riskInterpretation.toUpperCase(),
            //         style: pw.TextStyle(
            //             fontSize: 14,
            //             fontWeight: pw.FontWeight.bold,
            //             color: riskColor),
            //       ),
            //       pw.SizedBox(width: 10),
            //       pw.Text(
            //         '${analysisResult.saScore.toStringAsFixed(1)} / 22  •  ${analysisResult.severityPercentage}',
            //         style: pw.TextStyle(
            //             fontSize: 12,
            //             fontWeight: pw.FontWeight.bold,
            //             color: riskColor),
            //       ),
            //     ],
            //   ),
            // ),
            pw.SizedBox(height: 20),

            // ── Interpretation ───────────────────────────────────────────────
            pw.Text('Interpretation',
                style: pw.TextStyle(
                    fontSize: 14, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 8),
            pw.Container(
              padding: const pw.EdgeInsets.all(12),
              decoration: pw.BoxDecoration(
                color: PdfColor.fromHex('F8F9FA'),
                borderRadius:
                    const pw.BorderRadius.all(pw.Radius.circular(8)),
              ),
              child: pw.Text(
                _speechInterpretation(analysisResult),
                style: const pw.TextStyle(fontSize: 11),
              ),
            ),
            pw.SizedBox(height: 20),

            // ── Disclaimer ───────────────────────────────────────────────────
            pw.Container(
              padding: const pw.EdgeInsets.all(12),
              decoration: pw.BoxDecoration(
                color: PdfColor.fromHex('FFF8E1'),
                borderRadius:
                    const pw.BorderRadius.all(pw.Radius.circular(8)),
              ),
              child: pw.Text(
                'Disclaimer: This is a screening tool, not a diagnostic '
                'assessment. Professional evaluation by a qualified '
                'healthcare provider is recommended.',
                style: const pw.TextStyle(fontSize: 10),
              ),
            ),
          ],
        ),
      );

      final Uint8List bytes = await pdf.save();
      final dir = await getApplicationDocumentsDirectory();
      final childSafe = _childName.replaceAll(RegExp(r'[^\w]'), '_');
      final file = File(
          '${dir.path}/Speech_Report_${childSafe}_${item.speechSubmissionId}.pdf');
      await file.writeAsBytes(bytes);
      await OpenFile.open(file.path);
    } catch (e) {
      Get.snackbar('Error', 'Could not generate PDF: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.errorColor,
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 12);
    }
  }

  // ── Screening PDF (UNCHANGED) ──────────────────────────────────────────────
  Future<void> _downloadScreeningPdf(
      BuildContext context, ExpertScreeningItem item) async {
    try {
      final hasResult = item.questionnaireResults.isNotEmpty;
      final result = hasResult ? item.questionnaireResults.first.result : null;

      final pdf = pw.Document();
      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(40),
          build: (pw.Context ctx) => [
            pw.Container(
              padding: const pw.EdgeInsets.all(20),
              decoration: pw.BoxDecoration(
                color: PdfColor.fromHex('6C63FF'),
                borderRadius:
                    const pw.BorderRadius.all(pw.Radius.circular(12)),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('ASD Screening Report',
                      style: pw.TextStyle(
                          fontSize: 24,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.white)),
                  pw.SizedBox(height: 6),
                  pw.Text('SpeechSpectrum — Parent View',
                      style: const pw.TextStyle(
                          fontSize: 12, color: PdfColors.white)),
                ],
              ),
            ),
            pw.SizedBox(height: 20),
            if (result != null) ...[
              pw.Container(
                padding: const pw.EdgeInsets.all(16),
                decoration: pw.BoxDecoration(
                  border:
                      pw.Border.all(color: PdfColor.fromHex('E0E0E0')),
                  borderRadius:
                      const pw.BorderRadius.all(pw.Radius.circular(8)),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('Screening Result',
                        style: pw.TextStyle(
                            fontSize: 16,
                            fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(height: 10),
                    _pdfRow('Child', _childName),
                    pw.SizedBox(height: 4),
                    _pdfRow('Prediction', result.prediction),
                    pw.SizedBox(height: 4),
                    _pdfRow('Probability', result.probability),
                    pw.SizedBox(height: 4),
                    _pdfRow('Date', item.formattedDate),
                    pw.SizedBox(height: 4),
                    _pdfRow('Time', item.formattedTime),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),
            ],
            pw.Text('Submission Information',
                style: pw.TextStyle(
                    fontSize: 14, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 8),
            pw.Container(
              padding: const pw.EdgeInsets.all(12),
              decoration: pw.BoxDecoration(
                color: PdfColor.fromHex('F8F9FA'),
                borderRadius:
                    const pw.BorderRadius.all(pw.Radius.circular(8)),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  _pdfRow('Age (Months)',
                      '${item.responses['Age_Mons'] ?? 'N/A'}'),
                  _pdfRow('Gender',
                      item.responses['Sex'] == 1 ? 'Male' : 'Female'),
                  _pdfRow('Jaundice History',
                      item.responses['Jaundice'] == 1 ? 'Yes' : 'No'),
                  _pdfRow(
                      'Family ASD History',
                      item.responses['Family_mem_with_ASD'] == 1
                          ? 'Yes'
                          : 'No'),
                ],
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Text('Questionnaire Responses',
                style: pw.TextStyle(
                    fontSize: 14, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 8),
            ...[
              'A1',
              'A2',
              'A3',
              'A4',
              'A5',
              'A6',
              'A7',
              'A8',
              'A9',
              'A10'
            ].map((key) {
              final val = item.responses[key];
              final isPositive = val == 1;
              return pw.Container(
                margin: const pw.EdgeInsets.only(bottom: 6),
                padding: const pw.EdgeInsets.symmetric(
                    horizontal: 12, vertical: 8),
                decoration: pw.BoxDecoration(
                  color: isPositive
                      ? PdfColor.fromHex('E8F5E9')
                      : PdfColor.fromHex('FFEBEE'),
                  borderRadius:
                      const pw.BorderRadius.all(pw.Radius.circular(6)),
                ),
                child: pw.Row(
                  mainAxisAlignment:
                      pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Expanded(
                        child: pw.Text(_questionLabel(key),
                            style: const pw.TextStyle(fontSize: 11))),
                    pw.SizedBox(width: 10),
                    pw.Text(
                      isPositive ? 'Positive' : 'Negative',
                      style: pw.TextStyle(
                        fontSize: 11,
                        fontWeight: pw.FontWeight.bold,
                        color: isPositive
                            ? PdfColor.fromHex('388E3C')
                            : PdfColor.fromHex('D32F2F'),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            pw.SizedBox(height: 20),
            pw.Container(
              padding: const pw.EdgeInsets.all(12),
              decoration: pw.BoxDecoration(
                color: PdfColor.fromHex('FFF8E1'),
                borderRadius:
                    const pw.BorderRadius.all(pw.Radius.circular(8)),
              ),
              child: pw.Text(
                'Disclaimer: This is a screening tool, not a diagnostic '
                'assessment. Professional evaluation by a qualified '
                'healthcare provider is recommended.',
                style: const pw.TextStyle(fontSize: 10),
              ),
            ),
          ],
        ),
      );

      final Uint8List bytes = await pdf.save();
      final dir = await getApplicationDocumentsDirectory();
      final childSafe = _childName.replaceAll(RegExp(r'[^\w]'), '_');
      final file = File(
          '${dir.path}/ASD_Screening_${childSafe}_${item.submissionId}.pdf');
      await file.writeAsBytes(bytes);
      await OpenFile.open(file.path);
    } catch (e) {
      Get.snackbar('Error', 'Could not generate PDF: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.errorColor,
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 12);
    }
  }

  // ── PDF helpers ────────────────────────────────────────────────────────────

  pw.Widget _pdfRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 4),
      child: pw.Row(children: [
        pw.Text('$label: ',
            style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold, fontSize: 11)),
        pw.Text(value, style: const pw.TextStyle(fontSize: 11)),
      ]),
    );
  }

  PdfColor _pdfRiskColor(ParentSpeechAnalysis r) {
    if (r.isHighRisk) return PdfColor.fromHex('D32F2F');
    if (r.isModerateRisk) return PdfColor.fromHex('F57C00');
    return PdfColor.fromHex('388E3C');
  }

  String _speechInterpretation(ParentSpeechAnalysis r) {
    if (r.isLowRisk) {
      return 'The speech pattern shows low-risk indicators and appears '
          'within a typical developmental range.';
    } else if (r.isModerateRisk) {
      return 'The speech pattern shows moderate-risk characteristics. '
          'Consider consulting a speech therapist.';
    } else {
      return 'The speech pattern shows high-risk indicators. Professional '
          'speech therapy intervention is strongly recommended.';
    }
  }

  String _questionLabel(String key) {
    const map = {
      'A1': 'Does your child look at you when called?',
      'A2': 'How easy is eye contact with your child?',
      'A3': 'Does your child point to indicate wants?',
      'A4': 'Does your child point to share interest?',
      'A5': 'Does your child pretend play?',
      'A6': "Does your child follow where you're looking?",
      'A7': 'Does your child show signs of comforting others?',
      'A8': 'How would you describe first words?',
      'A9': 'Does your child use simple gestures?',
      'A10': 'Does your child stare at nothing?',
    };
    return map[key] ?? key;
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();
    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      body: Obx(() {
        final isLoading = _profileCtrl.isLoadingProfile.value ||
            _profileCtrl.isLoadingHealth.value;
        final profile = _profileCtrl.childProfile.value;

        return NestedScrollView(
          headerSliverBuilder: (ctx, inner) => [
            _buildSliverAppBar(context, size, profile, isLoading),
          ],
          body: isLoading && profile == null
              ? _buildLoader()
              : TabBarView(
                  controller: _tab,
                  children: [
                    _buildOverviewTab(context, size),
                    _buildHealthTab(context, size),
                    _buildScreeningTab(context, size),
                    _buildSpeechTab(context, size),
                  ],
                ),
        );
      }),
    );
  }

  Widget _buildSliverAppBar(
    BuildContext context,
    CustomSize size,
    ChildData? profile,
    bool isLoading,
  ) {
    return SliverAppBar(
      expandedHeight: 230,
      pinned: true,
      backgroundColor: AppColors.primaryColor,
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded,
            color: Colors.white, size: 20),
        onPressed: () => Get.back(),
      ),
      actions: [
        if (isLoading)
          const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 2)),
          )
        else
          IconButton(
            icon: const Icon(Icons.refresh_rounded, color: Colors.white),
            onPressed: () {
              _profileCtrl.refreshProfile(_childId);
              _dataCtrl.fetchScreening(_childId);
              _speechCtrl.fetchSpeech(_childId, forceRefresh: true);
            },
          ),
        const SizedBox(width: 4),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: _buildAppBarBackground(profile),
      ),
      bottom: TabBar(
        controller: _tab,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white60,
        indicatorColor: Colors.white,
        indicatorWeight: 3,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        labelStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w600, fontSize: 12.5),
        unselectedLabelStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w500, fontSize: 12.5),
        tabs: _tabs
            .map((t) => Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(t.$2, size: 14),
                      const SizedBox(width: 5),
                      Text(t.$1),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildAppBarBackground(ChildData? profile) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryColor, AppColors.secondaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
              ),
              child: Center(
                child: Text(
                  profile?.initials ?? _initials(_childName),
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              profile?.childName ?? _childName,
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
            if (profile != null) ...[
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _pillChip(
                    profile.gender[0].toUpperCase() +
                        profile.gender.substring(1),
                    profile.gender.toLowerCase() == 'male'
                        ? Icons.male_rounded
                        : Icons.female_rounded,
                  ),
                  const SizedBox(width: 8),
                  _pillChip(profile.age, Icons.cake_outlined),
                ],
              ),
            ],
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _pillChip(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 12),
          const SizedBox(width: 4),
          Text(label,
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  // ── Overview Tab (UNCHANGED) ───────────────────────────────────────────────

  Widget _buildOverviewTab(BuildContext context, CustomSize size) {
    return Obx(() {
      final profile = _profileCtrl.childProfile.value;
      if (profile == null) return _buildEmpty('No profile data available');

      return ListView(
        padding: EdgeInsets.fromLTRB(
          size.customWidth(context) * 0.045,
          size.customHeight(context) * 0.02,
          size.customWidth(context) * 0.045,
          size.customHeight(context) * 0.04,
        ),
        children: [
          _sectionCard(
            title: 'Basic Information',
            icon: Icons.person_outline_rounded,
            children: [
              _infoRow(
                  'Full Name', profile.childName, Icons.badge_outlined),
              _divider(),
              _infoRow('Date of Birth', profile.formattedDob,
                  Icons.cake_outlined),
              _divider(),
              _infoRow('Age', profile.age,
                  Icons.hourglass_bottom_rounded),
              _divider(),
              _infoRow(
                'Gender',
                profile.gender[0].toUpperCase() +
                    profile.gender.substring(1),
                profile.gender.toLowerCase() == 'male'
                    ? Icons.male_rounded
                    : Icons.female_rounded,
              ),
            ],
          ),
          SizedBox(height: size.customHeight(context) * 0.018),
          _buildHealthSnapshotCard(context, size),
        ],
      );
    });
  }

  Widget _buildHealthSnapshotCard(BuildContext context, CustomSize size) {
    return Obx(() {
      final health = _profileCtrl.childHealth.value;
      if (health == null) return const SizedBox.shrink();

      return _sectionCard(
        title: 'Health Snapshot',
        icon: Icons.monitor_heart_outlined,
        children: [
          Row(
            children: [
              Expanded(
                  child: _metricBox(
                      'Weight',
                      health.weightKg != null
                          ? '${health.weightKg!.toStringAsFixed(1)} kg'
                          : '—',
                      Icons.scale_outlined,
                      AppColors.primaryColor)),
              const SizedBox(width: 10),
              Expanded(
                  child: _metricBox(
                      'Height',
                      health.heightCm != null
                          ? '${health.heightCm!.toStringAsFixed(1)} cm'
                          : '—',
                      Icons.height_rounded,
                      AppColors.secondaryColor)),
              const SizedBox(width: 10),
              Expanded(
                  child: _metricBox(
                      'BMI',
                      health.bmi != null
                          ? health.bmi!.toStringAsFixed(2)
                          : '—',
                      Icons.analytics_outlined,
                      AppColors.accentColor)),
            ],
          ),
          if (health.bloodGroup != null) ...[
            const SizedBox(height: 12),
            _divider(),
            const SizedBox(height: 4),
            _infoRow('Blood Group', health.bloodGroup!,
                Icons.bloodtype_outlined),
          ],
        ],
      );
    });
  }

  // ── Health Tab (UNCHANGED) ─────────────────────────────────────────────────

  Widget _buildHealthTab(BuildContext context, CustomSize size) {
    return Obx(() {
      if (_profileCtrl.isLoadingHealth.value &&
          _profileCtrl.childHealth.value == null) {
        return _buildLoader();
      }
      final health = _profileCtrl.childHealth.value;
      if (health == null) {
        return _buildEmpty(
            'No health profile available for this child');
      }

      return ListView(
        padding: EdgeInsets.fromLTRB(
          size.customWidth(context) * 0.045,
          size.customHeight(context) * 0.02,
          size.customWidth(context) * 0.045,
          size.customHeight(context) * 0.04,
        ),
        children: [
          _sectionCard(
            title: 'Vitals',
            icon: Icons.monitor_heart_outlined,
            children: [
              Row(
                children: [
                  Expanded(
                      child: _metricBox(
                          'Weight',
                          health.weightKg != null
                              ? '${health.weightKg!.toStringAsFixed(1)} kg'
                              : '—',
                          Icons.scale_outlined,
                          AppColors.primaryColor)),
                  const SizedBox(width: 10),
                  Expanded(
                      child: _metricBox(
                          'Height',
                          health.heightCm != null
                              ? '${health.heightCm!.toStringAsFixed(1)} cm'
                              : '—',
                          Icons.height_rounded,
                          AppColors.secondaryColor)),
                  const SizedBox(width: 10),
                  Expanded(
                      child: _metricBox(
                          'BMI',
                          health.bmi != null
                              ? health.bmi!.toStringAsFixed(2)
                              : '—',
                          Icons.analytics_outlined,
                          AppColors.accentColor)),
                ],
              ),
              if (health.bloodGroup != null) ...[
                const SizedBox(height: 12),
                _divider(),
                const SizedBox(height: 4),
                _infoRow('Blood Group', health.bloodGroup!,
                    Icons.bloodtype_outlined,
                    valueColor: AppColors.errorColor),
              ],
            ],
          ),
          SizedBox(height: size.customHeight(context) * 0.018),
          _sectionCard(
            title: 'Conditions & Allergies',
            icon: Icons.medical_services_outlined,
            children: [
              if (health.knownAllergies != null &&
                  health.knownAllergies!.isNotEmpty &&
                  health.knownAllergies!.toLowerCase() != 'none') ...[
                _alertRow('Known Allergies', health.knownAllergies!,
                    Icons.warning_amber_rounded, AppColors.warningColor),
                _divider(),
              ],
              if (health.chronicConditions != null &&
                  health.chronicConditions!.isNotEmpty &&
                  health.chronicConditions!.toLowerCase() != 'none') ...[
                _alertRow(
                    'Chronic Conditions',
                    health.chronicConditions!,
                    Icons.local_hospital_outlined,
                    AppColors.errorColor),
                _divider(),
              ],
              if (health.geneticDisorders != null &&
                  health.geneticDisorders!.isNotEmpty &&
                  health.geneticDisorders!.toLowerCase() != 'none')
                _alertRow(
                    'Genetic Disorders',
                    health.geneticDisorders!,
                    Icons.biotech_outlined,
                    const Color(0xFF7B1FA2))
              else
                _infoRow('Genetic Disorders', 'None reported',
                    Icons.biotech_outlined),
            ],
          ),
          SizedBox(height: size.customHeight(context) * 0.018),
          _sectionCard(
            title: 'Family History',
            icon: Icons.family_restroom_rounded,
            children: [
              _familyHistoryRow('ASD History', health.familyHistoryAsd,
                  Icons.psychology_outlined),
              _divider(),
              _familyHistoryRow(
                  'Speech Disorders',
                  health.familyHistorySpeechDisorders,
                  Icons.record_voice_over_outlined),
              _divider(),
              _familyHistoryRow('Hearing Loss',
                  health.familyHistoryHearingLoss, Icons.hearing_outlined),
            ],
          ),
          SizedBox(height: size.customHeight(context) * 0.018),
          if (health.medicalRecords.isNotEmpty)
            _sectionCard(
              title:
                  'Medical Records (${health.medicalRecords.length})',
              icon: Icons.folder_outlined,
              children: health.medicalRecords
                  .map((r) => _recordRow(r))
                  .toList(),
            ),
        ],
      );
    });
  }

  Widget _recordRow(MedicalRecord record) {
    final color = _docTypeColor(record.documentType);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: color.withOpacity(0.3)),
            ),
            child: Icon(_docTypeIcon(record.documentType),
                color: color, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(record.displayName,
                    style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimaryColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                Text(record.formattedUploadDate,
                    style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: AppColors.textSecondaryColor)),
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(_docTypeLabel(record.documentType),
                style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: color)),
          ),
        ],
      ),
    );
  }

  // ── Screening Tab (UNCHANGED) ──────────────────────────────────────────────

  Widget _buildScreeningTab(BuildContext context, CustomSize size) {
    return Obx(() {
      if (_dataCtrl.isLoadingScreening.value &&
          _dataCtrl.screeningList.isEmpty) {
        return _buildLoader();
      }

      return Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              size.customWidth(context) * 0.045,
              size.customHeight(context) * 0.015,
              size.customWidth(context) * 0.045,
              size.customHeight(context) * 0.01,
            ),
            child: _searchBar(
              hint: 'Search by probability or result...',
              onChanged: _dataCtrl.filterScreening,
              value: _dataCtrl.screeningSearch.value,
            ),
          ),
          Expanded(
            child: _dataCtrl.filteredScreeningList.isEmpty
                ? _buildEmpty(
                    _dataCtrl.screeningSearch.value.isNotEmpty
                        ? 'No results match your search'
                        : 'No screening submissions for this child')
                : RefreshIndicator(
                    color: AppColors.primaryColor,
                    onRefresh: () =>
                        _dataCtrl.fetchScreening(_childId),
                    child: ListView.builder(
                      padding: EdgeInsets.fromLTRB(
                        size.customWidth(context) * 0.045,
                        0,
                        size.customWidth(context) * 0.045,
                        size.customHeight(context) * 0.04,
                      ),
                      itemCount:
                          _dataCtrl.filteredScreeningList.length,
                      itemBuilder: (_, i) => _screeningCard(context,
                          size, _dataCtrl.filteredScreeningList[i]),
                    ),
                  ),
          ),
        ],
      );
    });
  }

  Widget _screeningCard(BuildContext context, CustomSize size,
      ExpertScreeningItem item) {
    final hasResult = item.questionnaireResults.isNotEmpty;
    final result =
        hasResult ? item.questionnaireResults.first.result : null;

    Color riskColor = AppColors.greyColor;
    if (result != null) {
      if (result.isHighRisk) {
        riskColor = AppColors.errorColor;
      } else if (result.isMediumRisk) {
        riskColor = AppColors.warningColor;
      } else {
        riskColor = AppColors.successColor;
      }
    }

    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppRoutes.parentScreeningDetail,
          arguments: {
            'submissionId': item.submissionId,
            'childName': _childName,
          },
        );
      },
      child: Container(
        margin:
            EdgeInsets.only(bottom: size.customHeight(context) * 0.014),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 14,
                offset: const Offset(0, 4))
          ],
        ),
        child: Column(
          children: [
            Container(
              height: 4,
              decoration: BoxDecoration(
                color: riskColor,
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(18)),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(size.customWidth(context) * 0.04),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              riskColor.withOpacity(0.7),
                              riskColor
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(Icons.assignment_outlined,
                            size: 26, color: Colors.white),
                      ),
                      SizedBox(
                          width: size.customWidth(context) * 0.03),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.formattedDate,
                                style: GoogleFonts.poppins(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimaryColor)),
                            const SizedBox(height: 2),
                            Text(item.formattedTime,
                                style: GoogleFonts.poppins(
                                    fontSize: 11.5,
                                    color:
                                        AppColors.textSecondaryColor)),
                          ],
                        ),
                      ),
                      if (result != null) ...[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: riskColor.withOpacity(0.1),
                                borderRadius:
                                    BorderRadius.circular(20),
                                border: Border.all(
                                    color: riskColor.withOpacity(0.3)),
                              ),
                              child: Text(result.probability,
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: riskColor)),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              result.prediction.length > 22
                                  ? '${result.prediction.substring(0, 22)}...'
                                  : result.prediction,
                              style: GoogleFonts.poppins(
                                  fontSize: 10.5,
                                  color: riskColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                      const SizedBox(width: 6),
                      const Icon(Icons.arrow_forward_ios_rounded,
                          size: 13, color: AppColors.primaryColor),
                    ],
                  ),
                  SizedBox(
                      height: size.customHeight(context) * 0.012),
                  Divider(
                      height: 1,
                      color: AppColors.greyColor.withOpacity(0.15)),
                  SizedBox(
                      height: size.customHeight(context) * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('View Details',
                              style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w500)),
                          const SizedBox(width: 3),
                          const Icon(Icons.arrow_forward_ios_rounded,
                              size: 11,
                              color: AppColors.primaryColor),
                        ],
                      ),
                      if (hasResult)
                        GestureDetector(
                          onTap: () =>
                              _downloadScreeningPdf(context, item),
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor
                                  .withOpacity(0.06),
                              borderRadius:
                                  BorderRadius.circular(20),
                              border: Border.all(
                                  color: AppColors.primaryColor
                                      .withOpacity(0.2)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                    Icons.picture_as_pdf_outlined,
                                    size: 12,
                                    color: AppColors.primaryColor),
                                const SizedBox(width: 4),
                                Text('Download PDF',
                                    style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color:
                                            AppColors.primaryColor)),
                                const SizedBox(width: 4),
                                const Icon(Icons.download_outlined,
                                    size: 11,
                                    color: AppColors.primaryColor),
                              ],
                            ),
                          ),
                        )
                      else
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.pending_rounded,
                                size: 12,
                                color: AppColors.warningColor),
                            const SizedBox(width: 4),
                            Text('Analysis pending',
                                style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    color: AppColors.warningColor,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Speech Tab ─────────────────────────────────────────────────────────────

  Widget _buildSpeechTab(BuildContext context, CustomSize size) {
    return Obx(() {
      if (_speechCtrl.isLoadingSpeech.value &&
          _speechCtrl.speechList.isEmpty) {
        return _buildLoader();
      }

      return Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              size.customWidth(context) * 0.045,
              size.customHeight(context) * 0.015,
              size.customWidth(context) * 0.045,
              size.customHeight(context) * 0.01,
            ),
            child: _searchBar(
              hint: 'Search by risk level...',
              onChanged: _speechCtrl.filterSpeech,
              value: _speechCtrl.speechSearch.value,
            ),
          ),
          Expanded(
            child: _speechCtrl.filteredSpeechList.isEmpty
                ? _buildEmpty(
                    _speechCtrl.speechSearch.value.isNotEmpty
                        ? 'No results match your search'
                        : 'No speech submissions for this child')
                : RefreshIndicator(
                    color: AppColors.primaryColor,
                    onRefresh: () =>
                        _speechCtrl.fetchSpeech(_childId,
                            forceRefresh: true),
                    child: ListView.builder(
                      padding: EdgeInsets.fromLTRB(
                        size.customWidth(context) * 0.045,
                        0,
                        size.customWidth(context) * 0.045,
                        size.customHeight(context) * 0.04,
                      ),
                      itemCount:
                          _speechCtrl.filteredSpeechList.length,
                      itemBuilder: (_, i) => _speechCard(context, size,
                          _speechCtrl.filteredSpeechList[i]),
                    ),
                  ),
          ),
        ],
      );
    });
  }

  // ── Speech Card — new format ───────────────────────────────────────────────
  Widget _speechCard(BuildContext context, CustomSize size,
      ParentSpeechItem item) {
    final hasResult = item.hasResults;
    final analysisResult = item.latestResult?.result;

    Color riskColor = AppColors.greyColor;
    IconData riskIcon = Icons.pending_rounded;
    if (analysisResult != null) {
      if (analysisResult.isHighRisk) {
        riskColor = AppColors.errorColor;
        riskIcon = Icons.warning_rounded;
      } else if (analysisResult.isModerateRisk) {
        riskColor = AppColors.warningColor;
        riskIcon = Icons.info_rounded;
      } else {
        riskColor = AppColors.successColor;
        riskIcon = Icons.check_circle_rounded;
      }
    }

    return GestureDetector(
      onTap: () {
        debugPrint(
            '🖱️ Speech card tapped — speechSubmissionId="${item.speechSubmissionId}"');
        Get.toNamed(
          AppRoutes.parentSpeechDetail,
          arguments: {
            'submissionId': item.speechSubmissionId,
            'childName': _childName,
          },
        );
      },
      child: Container(
        margin:
            EdgeInsets.only(bottom: size.customHeight(context) * 0.014),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 14,
                offset: const Offset(0, 4))
          ],
        ),
        child: Column(
          children: [
            // Colored top bar
            Container(
              height: 4,
              decoration: BoxDecoration(
                color: riskColor,
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(18)),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(size.customWidth(context) * 0.04),
              child: Column(
                children: [
                  // ── Row 1: icon + date/time + arrow ─────────────────────
                  Row(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              riskColor.withOpacity(0.7),
                              riskColor
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(riskIcon,
                            size: 26, color: Colors.white),
                      ),
                      SizedBox(
                          width: size.customWidth(context) * 0.03),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.formattedDate,
                                style: GoogleFonts.poppins(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimaryColor)),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                Icon(Icons.access_time_rounded,
                                    size: 13,
                                    color: AppColors.textSecondaryColor),
                                const SizedBox(width: 3),
                                Text(
                                    '${item.recordingDurationSeconds}s',
                                    style: GoogleFonts.poppins(
                                        fontSize: 11.5,
                                        color: AppColors
                                            .textSecondaryColor)),
                                const SizedBox(width: 8),
                                Icon(Icons.schedule_rounded,
                                    size: 13,
                                    color: AppColors.textSecondaryColor),
                                const SizedBox(width: 3),
                                Text(item.formattedTime,
                                    style: GoogleFonts.poppins(
                                        fontSize: 11.5,
                                        color: AppColors
                                            .textSecondaryColor)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios_rounded,
                          size: 13, color: AppColors.primaryColor),
                    ],
                  ),

                  // // ── Row 2: risk + score bar (new format) ──────────────────
                  // if (hasResult && analysisResult != null) ...[
                  //   SizedBox(
                  //       height: size.customHeight(context) * 0.012),
                  //   Divider(
                  //       height: 1,
                  //       color: AppColors.greyColor.withOpacity(0.15)),
                  //   SizedBox(
                  //       height: size.customHeight(context) * 0.01),
                  //   Row(
                  //     children: [
                  //       Expanded(
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             // Risk label
                  //             Text(
                  //                 analysisResult.riskInterpretation,
                  //                 style: GoogleFonts.poppins(
                  //                     fontSize: 12.5,
                  //                     fontWeight: FontWeight.w700,
                  //                     color: riskColor)),
                  //             const SizedBox(height: 2),
                  //             // Severity percentage sub-label
                  //             Text(
                  //               '${analysisResult.severityPercentage} severity  •  ${analysisResult.modelType}',
                  //               style: GoogleFonts.poppins(
                  //                   fontSize: 10,
                  //                   color: AppColors.textSecondaryColor),
                  //               maxLines: 1,
                  //               overflow: TextOverflow.ellipsis,
                  //             ),
                  //             const SizedBox(height: 6),
                  //             // Progress bar
                  //             ClipRRect(
                  //               borderRadius: BorderRadius.circular(6),
                  //               child: LinearProgressIndicator(
                  //                 value: analysisResult.progressValue,
                  //                 backgroundColor:
                  //                     riskColor.withOpacity(0.15),
                  //                 valueColor:
                  //                     AlwaysStoppedAnimation<Color>(
                  //                         riskColor),
                  //                 minHeight: 7,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       const SizedBox(width: 12),
                  //       // Score badge: e.g. "14.9 / 22"
                  //       Container(
                  //         padding: const EdgeInsets.symmetric(
                  //             horizontal: 10, vertical: 5),
                  //         decoration: BoxDecoration(
                  //           color: riskColor.withOpacity(0.1),
                  //           borderRadius: BorderRadius.circular(20),
                  //           border: Border.all(
                  //               color: riskColor.withOpacity(0.4)),
                  //         ),
                  //         child: Text(
                  //           analysisResult.scoreBadgeLabel,
                  //           style: GoogleFonts.poppins(
                  //               fontSize: 12,
                  //               fontWeight: FontWeight.bold,
                  //               color: riskColor),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ],

                  SizedBox(
                      height: size.customHeight(context) * 0.012),
                  Divider(
                      height: 1,
                      color: AppColors.greyColor.withOpacity(0.15)),
                  SizedBox(
                      height: size.customHeight(context) * 0.01),

                  // ── Row 3: View Details + Download PDF ───────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('View Details',
                              style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w500)),
                          const SizedBox(width: 3),
                          const Icon(Icons.arrow_forward_ios_rounded,
                              size: 11,
                              color: AppColors.primaryColor),
                        ],
                      ),
                      if (hasResult && analysisResult != null)
                        GestureDetector(
                          onTap: () =>
                              _downloadSpeechPdf(context, item),
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor
                                  .withOpacity(0.06),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: AppColors.primaryColor
                                      .withOpacity(0.2)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                    Icons.picture_as_pdf_outlined,
                                    size: 12,
                                    color: AppColors.primaryColor),
                                const SizedBox(width: 4),
                                Text('Download PDF',
                                    style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryColor)),
                                const SizedBox(width: 4),
                                const Icon(Icons.download_outlined,
                                    size: 11,
                                    color: AppColors.primaryColor),
                              ],
                            ),
                          ),
                        )
                      else
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color:
                                AppColors.warningColor.withOpacity(0.07),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.pending_rounded,
                                  size: 12,
                                  color: AppColors.warningColor),
                              const SizedBox(width: 4),
                              Text('Analysis pending',
                                  style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      color: AppColors.warningColor,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Shared UI helpers (UNCHANGED) ──────────────────────────────────────────

  Widget _searchBar({
    required String hint,
    required void Function(String) onChanged,
    required String value,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 3))
        ],
      ),
      child: TextField(
        onChanged: onChanged,
        style: GoogleFonts.poppins(
            fontSize: 13.5, color: AppColors.textPrimaryColor),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.poppins(
              color: AppColors.greyColor, fontSize: 13),
          prefixIcon: const Icon(Icons.search,
              color: AppColors.primaryColor),
          suffixIcon: value.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear,
                      color: AppColors.greyColor, size: 18),
                  onPressed: () => onChanged(''),
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  Widget _sectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 14,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon,
                      color: AppColors.primaryColor, size: 16),
                ),
                const SizedBox(width: 10),
                Text(title,
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimaryColor)),
              ],
            ),
          ),
          Divider(
              height: 1,
              color: AppColors.greyColor.withOpacity(0.15)),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _metricBox(
      String label, String value, IconData icon, Color color) {
    return Container(
      padding:
          const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.07),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 6),
          Text(value,
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimaryColor)),
          Text(label,
              style: GoogleFonts.poppins(
                  fontSize: 10,
                  color: AppColors.textSecondaryColor)),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value, IconData icon,
      {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.textSecondaryColor),
          const SizedBox(width: 10),
          Expanded(
            child: Text(label,
                style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: AppColors.textSecondaryColor,
                    fontWeight: FontWeight.w500)),
          ),
          Text(value,
              style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: valueColor ?? AppColors.textPrimaryColor)),
        ],
      ),
    );
  }

  Widget _familyHistoryRow(
      String label, bool hasHistory, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.textSecondaryColor),
          const SizedBox(width: 10),
          Expanded(
            child: Text(label,
                style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: AppColors.textSecondaryColor,
                    fontWeight: FontWeight.w500)),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: hasHistory
                  ? AppColors.errorColor.withOpacity(0.1)
                  : AppColors.successColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: hasHistory
                      ? AppColors.errorColor.withOpacity(0.3)
                      : AppColors.successColor.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  hasHistory
                      ? Icons.check_circle_outline
                      : Icons.cancel_outlined,
                  size: 11,
                  color: hasHistory
                      ? AppColors.errorColor
                      : AppColors.successColor,
                ),
                const SizedBox(width: 4),
                Text(hasHistory ? 'Yes' : 'No',
                    style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: hasHistory
                            ? AppColors.errorColor
                            : AppColors.successColor)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _alertRow(
      String label, String value, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: color,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(value,
                    style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: AppColors.textPrimaryColor,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() =>
      Divider(height: 1, color: AppColors.greyColor.withOpacity(0.12));

  Widget _buildLoader() {
    return const Center(
      child: CircularProgressIndicator(
          color: AppColors.primaryColor, strokeWidth: 3),
    );
  }

  Widget _buildEmpty(String msg) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.07),
                  shape: BoxShape.circle),
              child: const Icon(Icons.info_outline_rounded,
                  size: 40, color: AppColors.primaryColor),
            ),
            const SizedBox(height: 16),
            Text(msg,
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: AppColors.textSecondaryColor),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2 &&
        parts[0].isNotEmpty &&
        parts[1].isNotEmpty) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : 'C';
  }

  Color _docTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'lab_result':
        return const Color(0xFF1565C0);
      case 'prescription':
        return AppColors.successColor;
      case 'hearing_test':
        return const Color(0xFF6A1B9A);
      case 'vision_test':
        return const Color(0xFF00838F);
      case 'previous_report':
        return AppColors.secondaryColor;
      case 'referral_letter':
        return const Color(0xFFE65100);
      case 'school_report':
        return const Color(0xFF2E7D32);
      default:
        return AppColors.accentColor;
    }
  }

  IconData _docTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'lab_result':
        return Icons.science_outlined;
      case 'prescription':
        return Icons.medication_outlined;
      case 'hearing_test':
        return Icons.hearing_outlined;
      case 'vision_test':
        return Icons.visibility_outlined;
      case 'previous_report':
        return Icons.assignment_outlined;
      case 'referral_letter':
        return Icons.forward_to_inbox_outlined;
      case 'school_report':
        return Icons.school_outlined;
      default:
        return Icons.description_outlined;
    }
  }

  String _docTypeLabel(String type) {
    switch (type.toLowerCase()) {
      case 'lab_result':
        return 'Lab Result';
      case 'prescription':
        return 'Prescription';
      case 'hearing_test':
        return 'Hearing Test';
      case 'vision_test':
        return 'Vision Test';
      case 'previous_report':
        return 'Previous Report';
      case 'referral_letter':
        return 'Referral Letter';
      case 'school_report':
        return 'School Report';
      default:
        return 'Other';
    }
  }
}