// // lib/view/expert/appointments/expert_speech_detail_screen.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/expert_child_data_controller.dart';
// import 'package:speechspectrum/services/expert_child_data_service.dart';

// class ExpertSpeechDetailScreen extends StatefulWidget {
//   const ExpertSpeechDetailScreen({super.key});

//   @override
//   State<ExpertSpeechDetailScreen> createState() =>
//       _ExpertSpeechDetailScreenState();
// }

// class _ExpertSpeechDetailScreenState
//     extends State<ExpertSpeechDetailScreen> {
//   late final ExpertChildDataController _ctrl;
//   late final String _submissionId;
//   late final String _childName;

//   @override
//   void initState() {
//     super.initState();
//     final args = Get.arguments as Map<String, dynamic>? ?? {};
//     _submissionId = args['submissionId'] ?? '';
//     _childName = args['childName'] ?? '';

//     _ctrl = Get.isRegistered<ExpertChildDataController>()
//         ? Get.find<ExpertChildDataController>()
//         : Get.put(ExpertChildDataController());

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (_submissionId.isNotEmpty) {
//         _ctrl.fetchSpeechDetail(_submissionId);
//       }
//     });
//   }

//   Color _riskColor(ExpertSpeechAnalysis r) {
//     if (r.isHighRisk) return AppColors.errorColor;
//     if (r.isModerateRisk) return AppColors.warningColor;
//     return AppColors.successColor;
//   }

//   IconData _riskIcon(ExpertSpeechAnalysis r) {
//     if (r.isHighRisk) return Icons.warning_rounded;
//     if (r.isModerateRisk) return Icons.info_rounded;
//     return Icons.check_circle_rounded;
//   }

//   String _interpretationText(ExpertSpeechAnalysis r) {
//     if (r.isLowRisk) {
//       return 'The speech pattern shows low-risk indicators and appears within a typical developmental range.';
//     } else if (r.isModerateRisk) {
//       return 'The speech pattern shows moderate-risk characteristics. Consider recommending further assessment by a speech therapist.';
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
//         if (_ctrl.isLoadingSpeechDetail.value &&
//             _ctrl.selectedSpeech.value == null) {
//           return _buildLoading(context, size);
//         }
//         final item = _ctrl.selectedSpeech.value;
//         if (item == null) {
//           return _buildError(context, size);
//         }
//         return _buildBody(context, size, item);
//       }),
//     );
//   }

//   Widget _buildLoading(BuildContext context, CustomSize size) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const CircularProgressIndicator(
//               color: AppColors.primaryColor, strokeWidth: 3),
//           SizedBox(height: size.customHeight(context) * 0.02),
//           Text('Loading speech details...',
//               style: GoogleFonts.poppins(
//                   color: AppColors.textSecondaryColor, fontSize: 14)),
//         ],
//       ),
//     );
//   }

//   Widget _buildError(BuildContext context, CustomSize size) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Icon(Icons.error_outline_rounded,
//               size: 64, color: AppColors.errorColor),
//           SizedBox(height: size.customHeight(context) * 0.02),
//           Text('Failed to load speech detail',
//               style: GoogleFonts.poppins(
//                   fontSize: 14, color: AppColors.textSecondaryColor)),
//           SizedBox(height: size.customHeight(context) * 0.02),
//           ElevatedButton(
//             onPressed: () => _ctrl.fetchSpeechDetail(_submissionId),
//             style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.primaryColor),
//             child: Text('Retry',
//                 style: GoogleFonts.poppins(color: Colors.white)),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildBody(
//       BuildContext context, CustomSize size, ExpertSpeechItem item) {
//     final hasResult = item.hasResults;
//     final speechResult = item.latestResult;
//     final analysisResult = speechResult?.result;

//     return CustomScrollView(
//       slivers: [
//         // ── App Bar ─────────────────────────────────────────────────────
//         SliverAppBar(
//           expandedHeight: size.customHeight(context) * 0.25,
//           pinned: true,
//           backgroundColor: AppColors.primaryColor,
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back_ios_new_rounded,
//                 color: Colors.white, size: 20),
//             onPressed: () => Get.back(),
//           ),
//           flexibleSpace: FlexibleSpaceBar(
//             background: Container(
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     AppColors.primaryColor,
//                     AppColors.secondaryColor
//                   ],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//               ),
//               child: SafeArea(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       width: 70,
//                       height: 70,
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.2),
//                         shape: BoxShape.circle,
//                       ),
//                       child: Icon(
//                         hasResult && analysisResult != null
//                             ? _riskIcon(analysisResult)
//                             : Icons.mic_rounded,
//                         size: 40,
//                         color: Colors.white,
//                       ),
//                     ),
//                     SizedBox(height: size.customHeight(context) * 0.015),
//                     Text('Speech Analysis',
//                         style: GoogleFonts.poppins(
//                             color: Colors.white,
//                             fontSize: size.customWidth(context) * 0.055,
//                             fontWeight: FontWeight.bold)),
//                     SizedBox(height: size.customHeight(context) * 0.005),
//                     Text(
//                       _childName.isNotEmpty
//                           ? _childName
//                           : item.children.childName,
//                       style: GoogleFonts.poppins(
//                           color: Colors.white.withOpacity(0.9),
//                           fontSize: size.customWidth(context) * 0.034),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),

//         // ── Body ─────────────────────────────────────────────────────────
//         SliverToBoxAdapter(
//           child: Padding(
//             padding: EdgeInsets.all(size.customWidth(context) * 0.045),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Recording info
//                 _sectionCard(
//                   title: 'Recording Information',
//                   icon: Icons.mic_outlined,
//                   children: [
//                     _infoRow('Child',
//                         _childName.isNotEmpty
//                             ? _childName
//                             : item.children.childName,
//                         Icons.person_outline),
//                     _divider(),
//                     _infoRow(
//                         'Duration',
//                         '${item.recordingDurationSeconds} seconds',
//                         Icons.access_time_rounded),
//                     _divider(),
//                     _infoRow(
//                         'Date', item.formattedDate, Icons.calendar_today_outlined),
//                     _divider(),
//                     _infoRow(
//                         'Time', item.formattedTime, Icons.schedule_rounded),
//                     if (item.recordingFormat != null) ...[
//                       _divider(),
//                       _infoRow('Format',
//                           item.recordingFormat!.toUpperCase(),
//                           Icons.audio_file_rounded),
//                     ],
//                   ],
//                 ),

//                 SizedBox(height: size.customHeight(context) * 0.022),

//                 // Analysis results
//                 if (!hasResult)
//                   _buildPendingCard(context, size)
//                 else if (analysisResult != null) ...[
//                   _buildResultCard(context, size, analysisResult),
//                   SizedBox(height: size.customHeight(context) * 0.022),
//                   if (analysisResult.bioMarkers != null)
//                     _buildBioMarkersCard(
//                         context, size, analysisResult.bioMarkers!),
//                 ],

//                 SizedBox(height: size.customHeight(context) * 0.04),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildPendingCard(BuildContext context, CustomSize size) {
//     return Container(
//       padding: EdgeInsets.all(size.customWidth(context) * 0.05),
//       decoration: BoxDecoration(
//         color: AppColors.warningColor.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(20),
//         border:
//             Border.all(color: AppColors.warningColor.withOpacity(0.3)),
//       ),
//       child: Column(
//         children: [
//           const Icon(Icons.pending_rounded,
//               size: 50, color: AppColors.warningColor),
//           SizedBox(height: size.customHeight(context) * 0.015),
//           Text('Analysis Pending',
//               style: GoogleFonts.poppins(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.warningColor)),
//           SizedBox(height: size.customHeight(context) * 0.008),
//           Text('The speech analysis is being processed.',
//               style: GoogleFonts.poppins(
//                   fontSize: 13, color: AppColors.textSecondaryColor),
//               textAlign: TextAlign.center),
//         ],
//       ),
//     );
//   }

//   Widget _buildResultCard(
//       BuildContext context, CustomSize size, ExpertSpeechAnalysis r) {
//     final riskColor = _riskColor(r);

//     return Container(
//       padding: EdgeInsets.all(size.customWidth(context) * 0.05),
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
//         children: [
//           Text('Analysis Results',
//               style: GoogleFonts.poppins(
//                   fontSize: 15,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.textPrimaryColor)),
//           SizedBox(height: size.customHeight(context) * 0.022),

//           // Score circle
//           Stack(
//             alignment: Alignment.center,
//             children: [
//               SizedBox(
//                 width: size.customWidth(context) * 0.42,
//                 height: size.customWidth(context) * 0.42,
//                 child: CircularProgressIndicator(
//                   value: r.severityScore / r.maxScore,
//                   strokeWidth: 10,
//                   backgroundColor: riskColor.withOpacity(0.15),
//                   valueColor: AlwaysStoppedAnimation<Color>(riskColor),
//                 ),
//               ),
//               Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     '${r.severityScore}',
//                     style: GoogleFonts.poppins(
//                         fontSize: size.customWidth(context) * 0.12,
//                         fontWeight: FontWeight.bold,
//                         color: riskColor),
//                   ),
//                   Text('out of ${r.maxScore}',
//                       style: GoogleFonts.poppins(
//                           fontSize: size.customWidth(context) * 0.03,
//                           color: AppColors.textSecondaryColor)),
//                 ],
//               ),
//             ],
//           ),

//           SizedBox(height: size.customHeight(context) * 0.022),

//           // Risk badge
//           Container(
//             padding: EdgeInsets.symmetric(
//               horizontal: size.customWidth(context) * 0.05,
//               vertical: size.customHeight(context) * 0.01,
//             ),
//             decoration: BoxDecoration(
//               color: riskColor.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(25),
//               border: Border.all(color: riskColor.withOpacity(0.4), width: 2),
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(_riskIcon(r), color: riskColor, size: 20),
//                 SizedBox(width: size.customWidth(context) * 0.02),
//                 Text(
//                   r.riskInterpretation,
//                   style: GoogleFonts.poppins(
//                       fontSize: size.customWidth(context) * 0.04,
//                       fontWeight: FontWeight.bold,
//                       color: riskColor),
//                 ),
//               ],
//             ),
//           ),

//           SizedBox(height: size.customHeight(context) * 0.018),

//           // Interpretation
//           Container(
//             padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//             decoration: BoxDecoration(
//               color: AppColors.primaryColor.withOpacity(0.05),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Row(
//               children: [
//                 const Icon(Icons.info_outline_rounded,
//                     color: AppColors.primaryColor, size: 18),
//                 SizedBox(width: size.customWidth(context) * 0.02),
//                 Expanded(
//                   child: Text(
//                     _interpretationText(r),
//                     style: GoogleFonts.poppins(
//                         fontSize: size.customWidth(context) * 0.032,
//                         color: AppColors.textPrimaryColor,
//                         height: 1.4),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildBioMarkersCard(
//       BuildContext context, CustomSize size, ExpertBioMarkers bm) {
//     return _sectionCard(
//       title: 'Bio-markers',
//       icon: Icons.analytics_rounded,
//       children: [
//         _bioMarkerRow(context, size,
//             label: 'Pitch Instability',
//             value: bm.pitchInstability,
//             icon: Icons.graphic_eq_rounded),
//         SizedBox(height: size.customHeight(context) * 0.012),
//         _bioMarkerRow(context, size,
//             label: 'Resonance Jitter F1',
//             value: bm.resonanceJitterF1,
//             icon: Icons.waves_rounded),
//         SizedBox(height: size.customHeight(context) * 0.012),
//         _bioMarkerRow(context, size,
//             label: 'Resonance Jitter F2',
//             value: bm.resonanceJitterF2,
//             icon: Icons.waves_rounded),
//       ],
//     );
//   }

//   Widget _bioMarkerRow(BuildContext context, CustomSize size,
//       {required String label,
//       required double value,
//       required IconData icon}) {
//     return Container(
//       padding: EdgeInsets.all(size.customWidth(context) * 0.035),
//       decoration: BoxDecoration(
//         color: AppColors.lightGreyColor,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           Icon(icon, color: AppColors.primaryColor, size: 20),
//           SizedBox(width: size.customWidth(context) * 0.03),
//           Expanded(
//             child: Text(label,
//                 style: GoogleFonts.poppins(
//                     fontSize: 13, color: AppColors.textSecondaryColor)),
//           ),
//           Text(
//             '${value.toStringAsFixed(1)} Hz',
//             style: GoogleFonts.poppins(
//                 fontSize: 13,
//                 fontWeight: FontWeight.w600,
//                 color: AppColors.textPrimaryColor),
//           ),
//         ],
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
//               height: 1, color: AppColors.greyColor.withOpacity(0.15)),
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

//   Widget _infoRow(String label, String value, IconData icon) {
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
//                   color: AppColors.textPrimaryColor)),
//         ],
//       ),
//     );
//   }

//   Widget _divider() =>
//       Divider(height: 1, color: AppColors.greyColor.withOpacity(0.12));
// }


// lib/view/expert/appointments/expert_speech_detail_screen.dart
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
import 'package:speechspectrum/controllers/expert_child_data_controller.dart';
import 'package:speechspectrum/services/expert_child_data_service.dart';

class ExpertSpeechDetailScreen extends StatefulWidget {
  const ExpertSpeechDetailScreen({super.key});

  @override
  State<ExpertSpeechDetailScreen> createState() =>
      _ExpertSpeechDetailScreenState();
}

class _ExpertSpeechDetailScreenState
    extends State<ExpertSpeechDetailScreen> {
  late final ExpertChildDataController _ctrl;
  late final String _submissionId;
  late final String _childName;

  // Track loading state for PDF generation
  final RxBool _isGeneratingPdf = false.obs;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    _submissionId = args['submissionId'] ?? '';
    _childName = args['childName'] ?? '';

    _ctrl = Get.isRegistered<ExpertChildDataController>()
        ? Get.find<ExpertChildDataController>()
        : Get.put(ExpertChildDataController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_submissionId.isNotEmpty) {
        _ctrl.fetchSpeechDetail(_submissionId);
      }
    });
  }

  Color _riskColor(ExpertSpeechAnalysis r) {
    if (r.isHighRisk) return AppColors.errorColor;
    if (r.isModerateRisk) return AppColors.warningColor;
    return AppColors.successColor;
  }

  IconData _riskIcon(ExpertSpeechAnalysis r) {
    if (r.isHighRisk) return Icons.warning_rounded;
    if (r.isModerateRisk) return Icons.info_rounded;
    return Icons.check_circle_rounded;
  }

  String _interpretationText(ExpertSpeechAnalysis r) {
    if (r.isLowRisk) {
      return 'The speech pattern shows low-risk indicators and appears within a typical developmental range.';
    } else if (r.isModerateRisk) {
      return 'The speech pattern shows moderate-risk characteristics. Consider recommending further assessment by a speech therapist.';
    } else {
      return 'The speech pattern shows high-risk indicators. Professional speech therapy intervention is strongly recommended.';
    }
  }

  // ── PDF Generation ────────────────────────────────────────────────────────

  Future<void> _generatePdf(ExpertSpeechItem item) async {
    final analysisResult = item.latestResult?.result;
    if (analysisResult == null) return;

    _isGeneratingPdf.value = true;
    try {
      final pdf = pw.Document();
      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(40),
          build: (pw.Context ctx) => [
            // Header
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
                  pw.Text('SpeechSpectrum — Expert Review',
                      style: const pw.TextStyle(
                          fontSize: 12, color: PdfColors.white)),
                ],
              ),
            ),
            pw.SizedBox(height: 20),

            // Result summary
            pw.Container(
              padding: const pw.EdgeInsets.all(16),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColor.fromHex('E0E0E0')),
                borderRadius:
                    const pw.BorderRadius.all(pw.Radius.circular(8)),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('Analysis Result',
                      style: pw.TextStyle(
                          fontSize: 16, fontWeight: pw.FontWeight.bold)),
                  pw.SizedBox(height: 10),
                  _pdfRow('Child', _childName),
                  pw.SizedBox(height: 4),
                  _pdfRow('Risk Level', analysisResult.riskInterpretation),
                  pw.SizedBox(height: 4),
                  _pdfRow('Severity Score',
                      '${analysisResult.severityScore} / ${analysisResult.maxScore}'),
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

            // Bio-markers
            if (analysisResult.bioMarkers != null) ...[
              pw.Text('Bio-markers',
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
                    _pdfRow('Pitch Instability',
                        '${analysisResult.bioMarkers!.pitchInstability.toStringAsFixed(1)} Hz'),
                    pw.SizedBox(height: 4),
                    _pdfRow('Resonance Jitter F1',
                        '${analysisResult.bioMarkers!.resonanceJitterF1.toStringAsFixed(1)} Hz'),
                    pw.SizedBox(height: 4),
                    _pdfRow('Resonance Jitter F2',
                        '${analysisResult.bioMarkers!.resonanceJitterF2.toStringAsFixed(1)} Hz'),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),
            ],

            // Interpretation
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
                _interpretationText(analysisResult),
                style: const pw.TextStyle(fontSize: 11),
              ),
            ),
            pw.SizedBox(height: 20),

            pw.Container(
              padding: const pw.EdgeInsets.all(12),
              decoration: pw.BoxDecoration(
                color: PdfColor.fromHex('FFF8E1'),
                borderRadius:
                    const pw.BorderRadius.all(pw.Radius.circular(8)),
              ),
              child: pw.Text(
                'Disclaimer: This is a screening tool, not a diagnostic assessment. '
                'Professional evaluation by a qualified healthcare provider is recommended.',
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
          '${dir.path}/Speech_Report_${childSafe}_$_submissionId.pdf');
      await file.writeAsBytes(bytes);
      await OpenFile.open(file.path);
    } catch (e) {
      Get.snackbar('Error', 'Could not generate PDF: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.errorColor,
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 12);
    } finally {
      _isGeneratingPdf.value = false;
    }
  }

  pw.Widget _pdfRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 4),
      child: pw.Row(children: [
        pw.Text('$label: ',
            style:
                pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11)),
        pw.Text(value, style: const pw.TextStyle(fontSize: 11)),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();
    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      body: Obx(() {
        if (_ctrl.isLoadingSpeechDetail.value &&
            _ctrl.selectedSpeech.value == null) {
          return _buildLoading(context, size);
        }
        final item = _ctrl.selectedSpeech.value;
        if (item == null) {
          return _buildError(context, size);
        }
        return _buildBody(context, size, item);
      }),
    );
  }

  Widget _buildLoading(BuildContext context, CustomSize size) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
              color: AppColors.primaryColor, strokeWidth: 3),
          SizedBox(height: size.customHeight(context) * 0.02),
          Text('Loading speech details...',
              style: GoogleFonts.poppins(
                  color: AppColors.textSecondaryColor, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildError(BuildContext context, CustomSize size) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline_rounded,
              size: 64, color: AppColors.errorColor),
          SizedBox(height: size.customHeight(context) * 0.02),
          Text('Failed to load speech detail',
              style: GoogleFonts.poppins(
                  fontSize: 14, color: AppColors.textSecondaryColor)),
          SizedBox(height: size.customHeight(context) * 0.02),
          ElevatedButton(
            onPressed: () => _ctrl.fetchSpeechDetail(_submissionId),
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor),
            child: Text('Retry',
                style: GoogleFonts.poppins(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(
      BuildContext context, CustomSize size, ExpertSpeechItem item) {
    final hasResult = item.hasResults;
    final speechResult = item.latestResult;
    final analysisResult = speechResult?.result;

    return CustomScrollView(
      slivers: [
        // ── App Bar ─────────────────────────────────────────────────────
        SliverAppBar(
          expandedHeight: size.customHeight(context) * 0.25,
          pinned: true,
          backgroundColor: AppColors.primaryColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.white, size: 20),
            onPressed: () => Get.back(),
          ),
          // Generate PDF in app bar when result exists
          actions: [
            if (hasResult && analysisResult != null)
              Obx(() => _isGeneratingPdf.value
                  ? const Padding(
                      padding: EdgeInsets.all(14),
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2),
                      ),
                    )
                  : IconButton(
                      icon: const Icon(Icons.picture_as_pdf_outlined,
                          color: Colors.white),
                      tooltip: 'Generate PDF',
                      onPressed: () => _generatePdf(item),
                    )),
            const SizedBox(width: 4),
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryColor,
                    AppColors.secondaryColor
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        hasResult && analysisResult != null
                            ? _riskIcon(analysisResult)
                            : Icons.mic_rounded,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: size.customHeight(context) * 0.015),
                    Text('Speech Analysis',
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: size.customWidth(context) * 0.055,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: size.customHeight(context) * 0.005),
                    Text(
                      _childName.isNotEmpty
                          ? _childName
                          : item.children.childName,
                      style: GoogleFonts.poppins(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: size.customWidth(context) * 0.034),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // ── Body ─────────────────────────────────────────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(size.customWidth(context) * 0.045),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Recording info
                _sectionCard(
                  title: 'Recording Information',
                  icon: Icons.mic_outlined,
                  children: [
                    _infoRow('Child',
                        _childName.isNotEmpty
                            ? _childName
                            : item.children.childName,
                        Icons.person_outline),
                    _divider(),
                    _infoRow(
                        'Duration',
                        '${item.recordingDurationSeconds} seconds',
                        Icons.access_time_rounded),
                    _divider(),
                    _infoRow(
                        'Date', item.formattedDate, Icons.calendar_today_outlined),
                    _divider(),
                    _infoRow(
                        'Time', item.formattedTime, Icons.schedule_rounded),
                    if (item.recordingFormat != null) ...[
                      _divider(),
                      _infoRow('Format',
                          item.recordingFormat!.toUpperCase(),
                          Icons.audio_file_rounded),
                    ],
                  ],
                ),

                SizedBox(height: size.customHeight(context) * 0.022),

                // Analysis results
                if (!hasResult)
                  _buildPendingCard(context, size)
                else if (analysisResult != null) ...[
                  _buildResultCard(context, size, analysisResult),
                  SizedBox(height: size.customHeight(context) * 0.022),
                  if (analysisResult.bioMarkers != null)
                    _buildBioMarkersCard(
                        context, size, analysisResult.bioMarkers!),
                ],

                SizedBox(height: size.customHeight(context) * 0.022),

                // ── Generate PDF button ─────────────────────────────────
                if (hasResult && analysisResult != null)
                  Obx(() => GestureDetector(
                        onTap: _isGeneratingPdf.value
                            ? null
                            : () => _generatePdf(item),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            gradient: _isGeneratingPdf.value
                                ? null
                                : const LinearGradient(
                                    colors: [
                                      AppColors.primaryColor,
                                      AppColors.secondaryColor
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                            color: _isGeneratingPdf.value
                                ? AppColors.greyColor.withOpacity(0.3)
                                : null,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: _isGeneratingPdf.value
                                ? null
                                : [
                                    BoxShadow(
                                        color: AppColors.primaryColor
                                            .withOpacity(0.35),
                                        blurRadius: 16,
                                        offset: const Offset(0, 6))
                                  ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (_isGeneratingPdf.value)
                                const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                      color: AppColors.primaryColor,
                                      strokeWidth: 2),
                                )
                              else
                                const Icon(Icons.picture_as_pdf_rounded,
                                    color: Colors.white, size: 22),
                              const SizedBox(width: 10),
                              Text(
                                _isGeneratingPdf.value
                                    ? 'Generating PDF...'
                                    : 'Generate & Download PDF Report',
                                style: GoogleFonts.poppins(
                                    color: _isGeneratingPdf.value
                                        ? AppColors.textSecondaryColor
                                        : Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                              if (!_isGeneratingPdf.value) ...[
                                const SizedBox(width: 8),
                                const Icon(Icons.download_rounded,
                                    color: Colors.white, size: 18),
                              ],
                            ],
                          ),
                        ),
                      )),

                SizedBox(height: size.customHeight(context) * 0.04),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPendingCard(BuildContext context, CustomSize size) {
    return Container(
      padding: EdgeInsets.all(size.customWidth(context) * 0.05),
      decoration: BoxDecoration(
        color: AppColors.warningColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border:
            Border.all(color: AppColors.warningColor.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          const Icon(Icons.pending_rounded,
              size: 50, color: AppColors.warningColor),
          SizedBox(height: size.customHeight(context) * 0.015),
          Text('Analysis Pending',
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.warningColor)),
          SizedBox(height: size.customHeight(context) * 0.008),
          Text('The speech analysis is being processed.',
              style: GoogleFonts.poppins(
                  fontSize: 13, color: AppColors.textSecondaryColor),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildResultCard(
      BuildContext context, CustomSize size, ExpertSpeechAnalysis r) {
    final riskColor = _riskColor(r);

    return Container(
      padding: EdgeInsets.all(size.customWidth(context) * 0.05),
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
        children: [
          Text('Analysis Results',
              style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryColor)),
          SizedBox(height: size.customHeight(context) * 0.022),

          // Score circle
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: size.customWidth(context) * 0.42,
                height: size.customWidth(context) * 0.42,
                child: CircularProgressIndicator(
                  value: r.severityScore / r.maxScore,
                  strokeWidth: 10,
                  backgroundColor: riskColor.withOpacity(0.15),
                  valueColor: AlwaysStoppedAnimation<Color>(riskColor),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${r.severityScore}',
                    style: GoogleFonts.poppins(
                        fontSize: size.customWidth(context) * 0.12,
                        fontWeight: FontWeight.bold,
                        color: riskColor),
                  ),
                  Text('out of ${r.maxScore}',
                      style: GoogleFonts.poppins(
                          fontSize: size.customWidth(context) * 0.03,
                          color: AppColors.textSecondaryColor)),
                ],
              ),
            ],
          ),

          SizedBox(height: size.customHeight(context) * 0.022),

          // Risk badge
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: size.customWidth(context) * 0.05,
              vertical: size.customHeight(context) * 0.01,
            ),
            decoration: BoxDecoration(
              color: riskColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: riskColor.withOpacity(0.4), width: 2),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(_riskIcon(r), color: riskColor, size: 20),
                SizedBox(width: size.customWidth(context) * 0.02),
                Text(
                  r.riskInterpretation,
                  style: GoogleFonts.poppins(
                      fontSize: size.customWidth(context) * 0.04,
                      fontWeight: FontWeight.bold,
                      color: riskColor),
                ),
              ],
            ),
          ),

          SizedBox(height: size.customHeight(context) * 0.018),

          // Interpretation
          Container(
            padding: EdgeInsets.all(size.customWidth(context) * 0.04),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline_rounded,
                    color: AppColors.primaryColor, size: 18),
                SizedBox(width: size.customWidth(context) * 0.02),
                Expanded(
                  child: Text(
                    _interpretationText(r),
                    style: GoogleFonts.poppins(
                        fontSize: size.customWidth(context) * 0.032,
                        color: AppColors.textPrimaryColor,
                        height: 1.4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBioMarkersCard(
      BuildContext context, CustomSize size, ExpertBioMarkers bm) {
    return _sectionCard(
      title: 'Bio-markers',
      icon: Icons.analytics_rounded,
      children: [
        _bioMarkerRow(context, size,
            label: 'Pitch Instability',
            value: bm.pitchInstability,
            icon: Icons.graphic_eq_rounded),
        SizedBox(height: size.customHeight(context) * 0.012),
        _bioMarkerRow(context, size,
            label: 'Resonance Jitter F1',
            value: bm.resonanceJitterF1,
            icon: Icons.waves_rounded),
        SizedBox(height: size.customHeight(context) * 0.012),
        _bioMarkerRow(context, size,
            label: 'Resonance Jitter F2',
            value: bm.resonanceJitterF2,
            icon: Icons.waves_rounded),
      ],
    );
  }

  Widget _bioMarkerRow(BuildContext context, CustomSize size,
      {required String label,
      required double value,
      required IconData icon}) {
    return Container(
      padding: EdgeInsets.all(size.customWidth(context) * 0.035),
      decoration: BoxDecoration(
        color: AppColors.lightGreyColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryColor, size: 20),
          SizedBox(width: size.customWidth(context) * 0.03),
          Expanded(
            child: Text(label,
                style: GoogleFonts.poppins(
                    fontSize: 13, color: AppColors.textSecondaryColor)),
          ),
          Text(
            '${value.toStringAsFixed(1)} Hz',
            style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimaryColor),
          ),
        ],
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
              height: 1, color: AppColors.greyColor.withOpacity(0.15)),
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

  Widget _infoRow(String label, String value, IconData icon) {
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
                  color: AppColors.textPrimaryColor)),
        ],
      ),
    );
  }

  Widget _divider() =>
      Divider(height: 1, color: AppColors.greyColor.withOpacity(0.12));
}
