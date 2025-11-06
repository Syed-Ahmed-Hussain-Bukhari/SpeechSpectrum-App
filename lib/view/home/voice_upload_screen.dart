import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../routes/app_routes.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';

class VoiceUploadScreen extends StatefulWidget {
  const VoiceUploadScreen({super.key});

  @override
  State<VoiceUploadScreen> createState() => _VoiceUploadScreenState();
}

class _VoiceUploadScreenState extends State<VoiceUploadScreen> {
  bool isRecording = false;
  String? uploadedFileName;

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
        title: Row(
          children: [
            Icon(Icons.mic, color: AppColors.primaryColor, size: 28),
            SizedBox(width: 8),
            Text(
              'Voice Upload',
              style: GoogleFonts.poppins(
                color: AppColors.textPrimaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(size.customWidth(context) * 0.05),
          child: Column(
            children: [
              // Info Card
              Container(
                padding: EdgeInsets.all(size.customWidth(context) * 0.04),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: AppColors.primaryColor.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: AppColors.primaryColor),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Please upload your child\'s short voice sample for analysis.',
                        style: GoogleFonts.poppins(
                          fontSize: size.customWidth(context) * 0.035,
                          color: AppColors.textPrimaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: size.customHeight(context) * 0.04),
              
              // Main Upload Card
              Container(
                padding: EdgeInsets.all(size.customWidth(context) * 0.06),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Upload or Record Voice Sample',
                      style: GoogleFonts.poppins(
                        fontSize: size.customWidth(context) * 0.05,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimaryColor,
                      ),
                    ),
                    SizedBox(height: size.customHeight(context) * 0.01),
                    Text(
                      'Provide a short voice sample (10-30 seconds). Our AI will analyze speech patterns for early indicators.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: size.customWidth(context) * 0.035,
                        color: AppColors.textSecondaryColor,
                      ),
                    ),
                    
                    SizedBox(height: size.customHeight(context) * 0.04),
                    
                    // Upload Area
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          uploadedFileName = 'child_voice_sample.wav';
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(size.customWidth(context) * 0.08),
                        decoration: BoxDecoration(
                          color: AppColors.lightGreyColor,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: AppColors.primaryColor.withOpacity(0.3),
                            width: 2,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              uploadedFileName != null ? Icons.check_circle : Icons.cloud_upload_outlined,
                              size: 60,
                              color: uploadedFileName != null ? AppColors.successColor : AppColors.primaryColor,
                            ),
                            SizedBox(height: 16),
                            Text(
                              uploadedFileName ?? 'Click or drag an audio file here',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: size.customWidth(context) * 0.04,
                                color: uploadedFileName != null ? AppColors.successColor : AppColors.textSecondaryColor,
                                fontWeight: uploadedFileName != null ? FontWeight.w600 : FontWeight.normal,
                              ),
                            ),
                            if (uploadedFileName == null)
                              Text(
                                'Supported formats: WAV, MP3, M4A',
                                style: GoogleFonts.poppins(
                                  fontSize: size.customWidth(context) * 0.03,
                                  color: AppColors.greyColor,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    
                    SizedBox(height: size.customHeight(context) * 0.03),
                    
                    // OR Divider
                    Row(
                      children: [
                        Expanded(child: Divider(color: AppColors.greyColor)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'OR',
                            style: GoogleFonts.poppins(
                              color: AppColors.textSecondaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(child: Divider(color: AppColors.greyColor)),
                      ],
                    ),
                    
                    SizedBox(height: size.customHeight(context) * 0.03),
                    
                    // Record Button
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          isRecording = !isRecording;
                        });
                      },
                      icon: Icon(
                        isRecording ? Icons.stop : Icons.mic,
                        color: AppColors.whiteColor,
                      ),
                      label: Text(
                        isRecording ? 'Stop Recording' : 'Start Recording',
                        style: GoogleFonts.poppins(
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w600,
                          fontSize: size.customWidth(context) * 0.04,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isRecording ? AppColors.errorColor : AppColors.primaryColor,
                        padding: EdgeInsets.symmetric(
                          horizontal: size.customWidth(context) * 0.08,
                          vertical: size.customHeight(context) * 0.02,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    
                    if (isRecording) ...[
                      SizedBox(height: size.customHeight(context) * 0.02),
                      Text(
                        'Recording... 00:15',
                        style: GoogleFonts.poppins(
                          color: AppColors.errorColor,
                          fontWeight: FontWeight.w600,
                          fontSize: size.customWidth(context) * 0.04,
                        ),
                      ),
                    ],
                    
                    SizedBox(height: size.customHeight(context) * 0.03),
                    
                    // Submit Button
                    if (uploadedFileName != null || isRecording)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.snackbar(
                              'Success',
                              'Voice sample uploaded successfully!',
                              backgroundColor: AppColors.successColor,
                              colorText: AppColors.whiteColor,
                            );
                            Get.offAllNamed(AppRoutes.results);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Submit Voice Sample',
                            style: GoogleFonts.poppins(
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w600,
                              fontSize: size.customWidth(context) * 0.04,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
