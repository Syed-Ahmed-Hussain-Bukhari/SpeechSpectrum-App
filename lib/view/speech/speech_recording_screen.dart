// lib/view/speech/speech_recording_screen.dart

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import 'package:speechspectrum/controllers/speech_controller.dart';
import 'package:speechspectrum/routes/app_routes.dart';

class SpeechRecordingScreen extends StatefulWidget {
  const SpeechRecordingScreen({super.key});

  @override
  State<SpeechRecordingScreen> createState() => _SpeechRecordingScreenState();
}

class _SpeechRecordingScreenState extends State<SpeechRecordingScreen>
    with SingleTickerProviderStateMixin {
  final controller = Get.put(SpeechController());
  final audioRecorder = AudioRecorder();

  final RxBool isRecording = false.obs;
  final RxInt recordingSeconds = 0.obs;
  final RxDouble audioLevel = 0.0.obs;
  final Rx<File?> recordedFile = Rx<File?>(null);

  Timer? recordingTimer;
  Timer? levelTimer;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _initRecorder();
  }

  @override
  void dispose() {
    recordingTimer?.cancel();
    levelTimer?.cancel();
    animationController.dispose();
    audioRecorder.dispose();
    super.dispose();
  }

  Future<void> _initRecorder() async {
    final hasPermission = await audioRecorder.hasPermission();
    if (!hasPermission) {
      Get.snackbar(
        'Permission Required',
        'Microphone permission is required to record audio',
        backgroundColor: AppColors.warningColor,
        colorText: AppColors.whiteColor,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future<void> _startRecording() async {
    try {
      final hasPermission = await audioRecorder.hasPermission();
      if (!hasPermission) {
        Get.snackbar(
          'Permission Denied',
          'Please grant microphone permission',
          backgroundColor: AppColors.errorColor,
          colorText: AppColors.whiteColor,
          snackPosition: SnackPosition.TOP,
        );
        return;
      }

      final directory = await getApplicationDocumentsDirectory();
      final filePath =
          '${directory.path}/speech_${DateTime.now().millisecondsSinceEpoch}.wav';

      await audioRecorder.start(
        const RecordConfig(
          encoder: AudioEncoder.wav,
          bitRate: 128000,
          sampleRate: 44100,
        ),
        path: filePath,
      );

      isRecording.value = true;
      recordingSeconds.value = 0;

      // Start timer
      recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        recordingSeconds.value++;
      });

      // Start audio level monitoring
      levelTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        _updateAudioLevel();
      });

      debugPrint('✅ Recording started: $filePath');
    } catch (e) {
      debugPrint('❌ Recording error: $e');
      Get.snackbar(
        'Error',
        'Failed to start recording',
        backgroundColor: AppColors.errorColor,
        colorText: AppColors.whiteColor,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future<void> _stopRecording() async {
    try {
      final path = await audioRecorder.stop();

      recordingTimer?.cancel();
      levelTimer?.cancel();
      isRecording.value = false;
      audioLevel.value = 0.0;

      if (path != null) {
        recordedFile.value = File(path);
        debugPrint('✅ Recording stopped: $path');
        
        // Show confirmation dialog
        _showUploadConfirmation();
      }
    } catch (e) {
      debugPrint('❌ Stop recording error: $e');
      Get.snackbar(
        'Error',
        'Failed to stop recording',
        backgroundColor: AppColors.errorColor,
        colorText: AppColors.whiteColor,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future<void> _updateAudioLevel() async {
    try {
      final amplitude = await audioRecorder.getAmplitude();
      audioLevel.value = (amplitude.current / amplitude.max).clamp(0.0, 1.0);
    } catch (e) {
      // Silently fail
    }
  }

  void _showUploadConfirmation() {
    final size = CustomSize();

    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          'Upload Recording?',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: size.customWidth(context) * 0.05,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.mic_rounded,
              size: 60,
              color: AppColors.successColor,
            ),
            SizedBox(height: size.customHeight(context) * 0.02),
            Text(
              'Duration: ${_formatDuration(recordingSeconds.value)}',
              style: GoogleFonts.poppins(
                fontSize: size.customWidth(context) * 0.04,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimaryColor,
              ),
            ),
            SizedBox(height: size.customHeight(context) * 0.01),
            Text(
              'Child: ${controller.selectedChild.value?.childName ?? "Unknown"}',
              style: GoogleFonts.poppins(
                fontSize: size.customWidth(context) * 0.035,
                color: AppColors.textSecondaryColor,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              _discardRecording();
            },
            child: Text(
              'Discard',
              style: GoogleFonts.poppins(
                color: AppColors.errorColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              _uploadRecording();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'Upload',
              style: GoogleFonts.poppins(
                color: AppColors.whiteColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _uploadRecording() async {
    if (recordedFile.value == null) return;

    final success = await controller.submitSpeech(
      audioFile: recordedFile.value!,
      durationSeconds: recordingSeconds.value,
      format: 'wav',
    );

    if (success) {
      // Navigate to submissions list
      Get.offNamed(AppRoutes.speechSubmissions);
    }
  }

  void _discardRecording() {
    recordedFile.value?.delete();
    recordedFile.value = null;
    recordingSeconds.value = 0;
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();

    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: size.customHeight(context) * 0.25,
            pinned: true,
            backgroundColor: AppColors.primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              background: _buildHeader(context),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.whiteColor),
              onPressed: () => Get.back(),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(size.customWidth(context) * 0.05),
              child: Column(
                children: [
                  // Child Selection
                  _buildChildSelection(context),

                  SizedBox(height: size.customHeight(context) * 0.03),

                  // Recording Area
                  _buildRecordingArea(context),

                  SizedBox(height: size.customHeight(context) * 0.03),

                  // Instructions
                  _buildInstructions(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final size = CustomSize();

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
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: AppColors.whiteColor.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.mic_rounded,
                size: 40,
                color: AppColors.whiteColor,
              ),
            ),
            SizedBox(height: size.customHeight(context) * 0.015),
            Text(
              'Speech Recording',
              style: GoogleFonts.poppins(
                color: AppColors.whiteColor,
                fontSize: size.customWidth(context) * 0.06,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: size.customHeight(context) * 0.005),
            Text(
              'Record your child\'s speech',
              style: GoogleFonts.poppins(
                color: AppColors.whiteColor.withOpacity(0.9),
                fontSize: size.customWidth(context) * 0.035,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChildSelection(BuildContext context) {
    final size = CustomSize();

    return Obx(() {
      if (controller.isLoadingChildren.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.children.isEmpty) {
        return Container(
          padding: EdgeInsets.all(size.customWidth(context) * 0.04),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            'No children found. Please add a child first.',
            style: GoogleFonts.poppins(
              color: AppColors.textSecondaryColor,
              fontSize: size.customWidth(context) * 0.035,
            ),
            textAlign: TextAlign.center,
          ),
        );
      }

      return Container(
        padding: EdgeInsets.all(size.customWidth(context) * 0.04),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Child',
              style: GoogleFonts.poppins(
                fontSize: size.customWidth(context) * 0.04,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimaryColor,
              ),
            ),
            SizedBox(height: size.customHeight(context) * 0.015),
            DropdownButtonFormField<String>(
              value: controller.selectedChild.value?.childId,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: size.customWidth(context) * 0.04,
                  vertical: size.customHeight(context) * 0.015,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColors.greyColor.withOpacity(0.3)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColors.greyColor.withOpacity(0.3)),
                ),
              ),
              items: controller.children.map((child) {
                return DropdownMenuItem<String>(
                  value: child.childId,
                  child: Row(
                    children: [
                      Icon(
                        Icons.child_care,
                        color: AppColors.primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: size.customWidth(context) * 0.02),
                      Text(
                        child.childName,
                        style: GoogleFonts.poppins(
                          fontSize: size.customWidth(context) * 0.038,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                final selected = controller.children.firstWhere(
                  (child) => child.childId == value,
                );
                controller.selectChild(selected);
              },
            ),
          ],
        ),
      );
    });
  }

  Widget _buildRecordingArea(BuildContext context) {
    final size = CustomSize();

    return Obx(() => Container(
          padding: EdgeInsets.all(size.customWidth(context) * 0.06),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Waveform Animation
              SizedBox(
                height: size.customHeight(context) * 0.15,
                child: isRecording.value
                    ? _buildWaveform(context)
                    : Center(
                        child: Icon(
                          Icons.graphic_eq_rounded,
                          size: 80,
                          color: AppColors.greyColor.withOpacity(0.3),
                        ),
                      ),
              ),

              SizedBox(height: size.customHeight(context) * 0.03),

              // Timer
              Text(
                _formatDuration(recordingSeconds.value),
                style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.12,
                  fontWeight: FontWeight.bold,
                  color: isRecording.value
                      ? AppColors.errorColor
                      : AppColors.textPrimaryColor,
                ),
              ),

              SizedBox(height: size.customHeight(context) * 0.03),

              // Record Button
              GestureDetector(
                onTap: controller.selectedChild.value == null
                    ? null
                    : () {
                        if (isRecording.value) {
                          _stopRecording();
                        } else {
                          _startRecording();
                        }
                      },
                child: Container(
                  width: size.customWidth(context) * 0.25,
                  height: size.customWidth(context) * 0.25,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: controller.selectedChild.value == null
                          ? [AppColors.greyColor, AppColors.greyColor]
                          : isRecording.value
                              ? [AppColors.errorColor, AppColors.warningColor]
                              : [AppColors.primaryColor, AppColors.secondaryColor],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: (isRecording.value
                                ? AppColors.errorColor
                                : AppColors.primaryColor)
                            .withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Icon(
                    isRecording.value ? Icons.stop_rounded : Icons.mic_rounded,
                    size: size.customWidth(context) * 0.12,
                    color: AppColors.whiteColor,
                  ),
                ),
              ),

              SizedBox(height: size.customHeight(context) * 0.02),

              Text(
                isRecording.value ? 'Tap to Stop' : 'Tap to Record',
                style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.04,
                  color: AppColors.textSecondaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildWaveform(BuildContext context) {
    final size = CustomSize();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(20, (index) {
        return Obx(() {
          final height = (audioLevel.value * 100 * (0.5 + (index % 3) * 0.3))
              .clamp(10.0, 100.0);
          
          return AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            width: size.customWidth(context) * 0.015,
            height: height,
            margin: EdgeInsets.symmetric(
              horizontal: size.customWidth(context) * 0.005,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: [AppColors.primaryColor, AppColors.secondaryColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          );
        });
      }),
    );
  }

  Widget _buildInstructions(BuildContext context) {
    final size = CustomSize();

    return Container(
      padding: EdgeInsets.all(size.customWidth(context) * 0.04),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: AppColors.primaryColor.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                color: AppColors.primaryColor,
                size: 20,
              ),
              SizedBox(width: size.customWidth(context) * 0.02),
              Text(
                'Instructions',
                style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.04,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: size.customHeight(context) * 0.015),
          _buildInstructionItem(
            context,
            '1. Select your child from the dropdown',
          ),
          _buildInstructionItem(
            context,
            '2. Find a quiet environment',
          ),
          _buildInstructionItem(
            context,
            '3. Tap the microphone button to start recording',
          ),
          _buildInstructionItem(
            context,
            '4. Let your child speak clearly',
          ),
          _buildInstructionItem(
            context,
            '5. Tap stop when finished',
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionItem(BuildContext context, String text) {
    final size = CustomSize();

    return Padding(
      padding: EdgeInsets.only(bottom: size.customHeight(context) * 0.008),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 16,
            color: AppColors.primaryColor,
          ),
          SizedBox(width: size.customWidth(context) * 0.02),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: size.customWidth(context) * 0.035,
                color: AppColors.textPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}