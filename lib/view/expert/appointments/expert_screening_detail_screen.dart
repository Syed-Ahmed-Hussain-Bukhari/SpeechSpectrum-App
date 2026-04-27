// // lib/view/expert/appointments/expert_screening_detail_screen.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/expert_child_data_controller.dart';
// import 'package:speechspectrum/services/expert_child_data_service.dart';

// class ExpertScreeningDetailScreen extends StatefulWidget {
//   const ExpertScreeningDetailScreen({super.key});

//   @override
//   State<ExpertScreeningDetailScreen> createState() =>
//       _ExpertScreeningDetailScreenState();
// }

// class _ExpertScreeningDetailScreenState
//     extends State<ExpertScreeningDetailScreen> {
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
//         _ctrl.fetchScreeningDetail(_submissionId);
//       }
//     });
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

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();
//     return Scaffold(
//       backgroundColor: AppColors.lightGreyColor,
//       appBar: AppBar(
//         backgroundColor: AppColors.whiteColor,
//         elevation: 0,
//         surfaceTintColor: Colors.transparent,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios_new_rounded,
//               color: AppColors.textPrimaryColor, size: 20),
//           onPressed: () => Get.back(),
//         ),
//         title: Text(
//           'Screening Detail',
//           style: GoogleFonts.poppins(
//               color: AppColors.textPrimaryColor,
//               fontSize: 18,
//               fontWeight: FontWeight.w600),
//         ),
//       ),
//       body: Obx(() {
//         if (_ctrl.isLoadingScreeningDetail.value &&
//             _ctrl.selectedScreening.value == null) {
//           return const Center(
//               child: CircularProgressIndicator(
//                   color: AppColors.primaryColor, strokeWidth: 3));
//         }
//         final item = _ctrl.selectedScreening.value;
//         if (item == null) {
//           return Center(
//             child: Text('Failed to load screening detail',
//                 style: GoogleFonts.poppins(
//                     color: AppColors.textSecondaryColor)),
//           );
//         }
//         return _buildContent(context, size, item);
//       }),
//     );
//   }

//   Widget _buildContent(
//       BuildContext context, CustomSize size, ExpertScreeningItem item) {
//     final hasResult = item.questionnaireResults.isNotEmpty;
//     final result = hasResult ? item.questionnaireResults.first.result : null;

//     Color riskColor = AppColors.greyColor;
//     if (result != null) {
//       if (result.isHighRisk) riskColor = AppColors.errorColor;
//       else if (result.isMediumRisk) riskColor = AppColors.warningColor;
//       else riskColor = AppColors.successColor;
//     }

//     return SingleChildScrollView(
//       padding: EdgeInsets.all(size.customWidth(context) * 0.045),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // ── Result card ─────────────────────────────────────────────────
//           if (result != null) ...[
//             Container(
//               padding: EdgeInsets.all(size.customWidth(context) * 0.055),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [riskColor, riskColor.withOpacity(0.7)],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.circular(24),
//                 boxShadow: [
//                   BoxShadow(
//                       color: riskColor.withOpacity(0.3),
//                       blurRadius: 20,
//                       offset: const Offset(0, 8))
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   SizedBox(
//                     width: size.customWidth(context) * 0.35,
//                     height: size.customWidth(context) * 0.35,
//                     child: CircularProgressIndicator(
//                       value: result.probabilityValue / 100,
//                       strokeWidth: 12,
//                       backgroundColor: Colors.white.withOpacity(0.3),
//                       valueColor: const AlwaysStoppedAnimation<Color>(
//                           Colors.white),
//                     ),
//                   ),
//                   SizedBox(height: size.customHeight(context) * 0.02),
//                   Text(result.probability,
//                       style: GoogleFonts.poppins(
//                           color: Colors.white,
//                           fontSize: 40,
//                           fontWeight: FontWeight.bold,
//                           height: 1)),
//                   const SizedBox(height: 4),
//                   Text('probability',
//                       style: GoogleFonts.poppins(
//                           color: Colors.white.withOpacity(0.9),
//                           fontSize: 14)),
//                   SizedBox(height: size.customHeight(context) * 0.02),
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 18, vertical: 8),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.2),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(result.prediction,
//                         style: GoogleFonts.poppins(
//                             color: Colors.white,
//                             fontSize: 15,
//                             fontWeight: FontWeight.w600),
//                         textAlign: TextAlign.center),
//                   ),
//                   SizedBox(height: size.customHeight(context) * 0.015),
//                   Text('Based on questionnaire responses and analysis',
//                       style: GoogleFonts.poppins(
//                           color: Colors.white.withOpacity(0.85),
//                           fontSize: 12),
//                       textAlign: TextAlign.center),
//                 ],
//               ),
//             ),
//             SizedBox(height: size.customHeight(context) * 0.022),
//           ],

//           // ── Submission info ─────────────────────────────────────────────
//           _sectionCard(
//             title: 'Submission Information',
//             icon: Icons.info_outline_rounded,
//             children: [
//               _infoRow('Child', _childName, Icons.person_outline),
//               _divider(),
//               _infoRow(
//                   'Date', item.formattedDate, Icons.calendar_today_outlined),
//               _divider(),
//               _infoRow('Time', item.formattedTime, Icons.access_time_outlined),
//               _divider(),
//               _infoRow('Age (Months)',
//                   '${item.responses['Age_Mons'] ?? 'N/A'}',
//                   Icons.cake_outlined),
//               _divider(),
//               _infoRow('Gender',
//                   item.responses['Sex'] == 1 ? 'Male' : 'Female',
//                   Icons.wc_outlined),
//               _divider(),
//               _infoRow('Jaundice History',
//                   item.responses['Jaundice'] == 1 ? 'Yes' : 'No',
//                   Icons.medical_information_outlined),
//               _divider(),
//               _infoRow('Family ASD History',
//                   item.responses['Family_mem_with_ASD'] == 1 ? 'Yes' : 'No',
//                   Icons.family_restroom_outlined),
//             ],
//           ),

//           SizedBox(height: size.customHeight(context) * 0.022),

//           // ── Questionnaire responses ─────────────────────────────────────
//           _sectionCard(
//             title: 'Questionnaire Responses',
//             icon: Icons.quiz_outlined,
//             children: [
//               ...['A1','A2','A3','A4','A5','A6','A7','A8','A9','A10']
//                   .map((key) {
//                 final val = item.responses[key];
//                 final isPositive = val == 1;
//                 return _responseItem(
//                   _questionLabel(key),
//                   isPositive ? 'Positive' : 'Negative',
//                   isPositive,
//                 );
//               }).toList(),
//             ],
//           ),

//           SizedBox(height: size.customHeight(context) * 0.04),
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

//   Widget _responseItem(String question, String answer, bool isPositive) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 10),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: isPositive
//             ? AppColors.successColor.withOpacity(0.05)
//             : AppColors.errorColor.withOpacity(0.05),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           color: isPositive
//               ? AppColors.successColor.withOpacity(0.2)
//               : AppColors.errorColor.withOpacity(0.2),
//         ),
//       ),
//       child: Row(
//         children: [
//           Icon(
//             isPositive
//                 ? Icons.check_circle_outline
//                 : Icons.cancel_outlined,
//             color: isPositive ? AppColors.successColor : AppColors.errorColor,
//             size: 22,
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(question,
//                     style: GoogleFonts.poppins(
//                         fontSize: 12.5, color: AppColors.textPrimaryColor)),
//                 const SizedBox(height: 3),
//                 Text(answer,
//                     style: GoogleFonts.poppins(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w600,
//                         color: isPositive
//                             ? AppColors.successColor
//                             : AppColors.errorColor)),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _divider() =>
//       Divider(height: 1, color: AppColors.greyColor.withOpacity(0.12));
// }


// lib/view/expert/appointments/expert_screening_detail_screen.dart
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

class ExpertScreeningDetailScreen extends StatefulWidget {
  const ExpertScreeningDetailScreen({super.key});

  @override
  State<ExpertScreeningDetailScreen> createState() =>
      _ExpertScreeningDetailScreenState();
}

class _ExpertScreeningDetailScreenState
    extends State<ExpertScreeningDetailScreen> {
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
        _ctrl.fetchScreeningDetail(_submissionId);
      }
    });
  }

  String _questionLabel(String key) {
    const map = {
      'A1': 'Does your child look at you when called?',
      'A2': 'How easy is eye contact with your child?',
      'A3': 'Does your child point to indicate wants?',
      'A4': 'Does your child point to share interest?',
      'A5': 'Does your child pretend play?',
      'A6': 'Does your child follow where you\'re looking?',
      'A7': 'Does your child show signs of comforting others?',
      'A8': 'How would you describe first words?',
      'A9': 'Does your child use simple gestures?',
      'A10': 'Does your child stare at nothing?',
    };
    return map[key] ?? key;
  }

  // ── PDF Generation ────────────────────────────────────────────────────────

  Future<void> _generatePdf(ExpertScreeningItem item) async {
    _isGeneratingPdf.value = true;
    try {
      final hasResult = item.questionnaireResults.isNotEmpty;
      final result = hasResult ? item.questionnaireResults.first.result : null;

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
                  pw.Text('ASD Screening Report',
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
            if (result != null) ...[
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
                    pw.Text('Screening Result',
                        style: pw.TextStyle(
                            fontSize: 16, fontWeight: pw.FontWeight.bold)),
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

            // Submission info
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
                  _pdfRow('Family ASD History',
                      item.responses['Family_mem_with_ASD'] == 1
                          ? 'Yes'
                          : 'No'),
                ],
              ),
            ),
            pw.SizedBox(height: 20),

            // Questionnaire responses
            pw.Text('Questionnaire Responses',
                style: pw.TextStyle(
                    fontSize: 14, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 8),
            ...[
              'A1','A2','A3','A4','A5','A6','A7','A8','A9','A10'
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
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
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
          '${dir.path}/ASD_Screening_${childSafe}_$_submissionId.pdf');
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
          'Screening Detail',
          style: GoogleFonts.poppins(
              color: AppColors.textPrimaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
        // Generate PDF action in app bar
        actions: [
          Obx(() {
            final item = _ctrl.selectedScreening.value;
            final hasResult = item != null &&
                item.questionnaireResults.isNotEmpty;
            if (!hasResult) return const SizedBox.shrink();
            return _isGeneratingPdf.value
                ? const Padding(
                    padding: EdgeInsets.all(14),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                          color: AppColors.primaryColor, strokeWidth: 2),
                    ),
                  )
                : IconButton(
                    icon: const Icon(Icons.picture_as_pdf_outlined,
                        color: AppColors.primaryColor),
                    tooltip: 'Generate PDF',
                    onPressed: () => _generatePdf(item),
                  );
          }),
          const SizedBox(width: 4),
        ],
      ),
      body: Obx(() {
        if (_ctrl.isLoadingScreeningDetail.value &&
            _ctrl.selectedScreening.value == null) {
          return const Center(
              child: CircularProgressIndicator(
                  color: AppColors.primaryColor, strokeWidth: 3));
        }
        final item = _ctrl.selectedScreening.value;
        if (item == null) {
          return Center(
            child: Text('Failed to load screening detail',
                style: GoogleFonts.poppins(
                    color: AppColors.textSecondaryColor)),
          );
        }
        return _buildContent(context, size, item);
      }),
    );
  }

  Widget _buildContent(
      BuildContext context, CustomSize size, ExpertScreeningItem item) {
    final hasResult = item.questionnaireResults.isNotEmpty;
    final result = hasResult ? item.questionnaireResults.first.result : null;

    Color riskColor = AppColors.greyColor;
    if (result != null) {
      if (result.isHighRisk) riskColor = AppColors.errorColor;
      else if (result.isMediumRisk) riskColor = AppColors.warningColor;
      else riskColor = AppColors.successColor;
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(size.customWidth(context) * 0.045),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Result card ─────────────────────────────────────────────────
          if (result != null) ...[
            Container(
              padding: EdgeInsets.all(size.customWidth(context) * 0.055),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [riskColor, riskColor.withOpacity(0.7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                      color: riskColor.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8))
                ],
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: size.customWidth(context) * 0.35,
                    height: size.customWidth(context) * 0.35,
                    child: CircularProgressIndicator(
                      value: result.probabilityValue / 100,
                      strokeWidth: 12,
                      backgroundColor: Colors.white.withOpacity(0.3),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.white),
                    ),
                  ),
                  SizedBox(height: size.customHeight(context) * 0.02),
                  Text(result.probability,
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          height: 1)),
                  const SizedBox(height: 4),
                  Text('probability',
                      style: GoogleFonts.poppins(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14)),
                  SizedBox(height: size.customHeight(context) * 0.02),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(result.prediction,
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center),
                  ),
                  SizedBox(height: size.customHeight(context) * 0.015),
                  Text('Based on questionnaire responses and analysis',
                      style: GoogleFonts.poppins(
                          color: Colors.white.withOpacity(0.85),
                          fontSize: 12),
                      textAlign: TextAlign.center),
                ],
              ),
            ),
            SizedBox(height: size.customHeight(context) * 0.022),
          ],

          // ── Submission info ─────────────────────────────────────────────
          _sectionCard(
            title: 'Submission Information',
            icon: Icons.info_outline_rounded,
            children: [
              _infoRow('Child', _childName, Icons.person_outline),
              _divider(),
              _infoRow(
                  'Date', item.formattedDate, Icons.calendar_today_outlined),
              _divider(),
              _infoRow('Time', item.formattedTime, Icons.access_time_outlined),
              _divider(),
              _infoRow('Age (Months)',
                  '${item.responses['Age_Mons'] ?? 'N/A'}',
                  Icons.cake_outlined),
              _divider(),
              _infoRow('Gender',
                  item.responses['Sex'] == 1 ? 'Male' : 'Female',
                  Icons.wc_outlined),
              _divider(),
              _infoRow('Jaundice History',
                  item.responses['Jaundice'] == 1 ? 'Yes' : 'No',
                  Icons.medical_information_outlined),
              _divider(),
              _infoRow('Family ASD History',
                  item.responses['Family_mem_with_ASD'] == 1 ? 'Yes' : 'No',
                  Icons.family_restroom_outlined),
            ],
          ),

          SizedBox(height: size.customHeight(context) * 0.022),

          // ── Questionnaire responses ─────────────────────────────────────
          _sectionCard(
            title: 'Questionnaire Responses',
            icon: Icons.quiz_outlined,
            children: [
              ...['A1','A2','A3','A4','A5','A6','A7','A8','A9','A10']
                  .map((key) {
                final val = item.responses[key];
                final isPositive = val == 1;
                return _responseItem(
                  _questionLabel(key),
                  isPositive ? 'Positive' : 'Negative',
                  isPositive,
                );
              }).toList(),
            ],
          ),

          SizedBox(height: size.customHeight(context) * 0.022),

          // ── Generate PDF button ─────────────────────────────────────────
          if (hasResult)
            Obx(() => GestureDetector(
                  onTap:
                      _isGeneratingPdf.value ? null : () => _generatePdf(item),
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
                                  color: AppColors.primaryColor.withOpacity(0.35),
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
                                color: AppColors.primaryColor, strokeWidth: 2),
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

  Widget _responseItem(String question, String answer, bool isPositive) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isPositive
            ? AppColors.successColor.withOpacity(0.05)
            : AppColors.errorColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isPositive
              ? AppColors.successColor.withOpacity(0.2)
              : AppColors.errorColor.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(
            isPositive
                ? Icons.check_circle_outline
                : Icons.cancel_outlined,
            color: isPositive ? AppColors.successColor : AppColors.errorColor,
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(question,
                    style: GoogleFonts.poppins(
                        fontSize: 12.5, color: AppColors.textPrimaryColor)),
                const SizedBox(height: 3),
                Text(answer,
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isPositive
                            ? AppColors.successColor
                            : AppColors.errorColor)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() =>
      Divider(height: 1, color: AppColors.greyColor.withOpacity(0.12));
}