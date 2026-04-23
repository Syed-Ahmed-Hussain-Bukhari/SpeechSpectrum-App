// // lib/view/speech/speech_recording_screen.dart

// import 'dart:async';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:record/record.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/speech_controller.dart';
// import 'package:speechspectrum/routes/app_routes.dart';

// class SpeechRecordingScreen extends StatefulWidget {
//   const SpeechRecordingScreen({super.key});

//   @override
//   State<SpeechRecordingScreen> createState() => _SpeechRecordingScreenState();
// }

// class _SpeechRecordingScreenState extends State<SpeechRecordingScreen>
//     with SingleTickerProviderStateMixin {
//   final controller = Get.put(SpeechController());
//   final audioRecorder = AudioRecorder();

//   final RxBool isRecording = false.obs;
//   final RxInt recordingSeconds = 0.obs;
//   final RxDouble audioLevel = 0.0.obs;
//   final Rx<File?> recordedFile = Rx<File?>(null);

//   Timer? recordingTimer;
//   Timer? levelTimer;
//   late AnimationController animationController;

//   @override
//   void initState() {
//     super.initState();
//     animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1500),
//     )..repeat(reverse: true);

//     _initRecorder();
//   }

//   @override
//   void dispose() {
//     recordingTimer?.cancel();
//     levelTimer?.cancel();
//     animationController.dispose();
//     audioRecorder.dispose();
//     super.dispose();
//   }

//   Future<void> _initRecorder() async {
//     final hasPermission = await audioRecorder.hasPermission();
//     if (!hasPermission) {
//       Get.snackbar(
//         'Permission Required',
//         'Microphone permission is required to record audio',
//         backgroundColor: AppColors.warningColor,
//         colorText: AppColors.whiteColor,
//         snackPosition: SnackPosition.TOP,
//       );
//     }
//   }

//   Future<void> _startRecording() async {
//     try {
//       final hasPermission = await audioRecorder.hasPermission();
//       if (!hasPermission) {
//         Get.snackbar(
//           'Permission Denied',
//           'Please grant microphone permission',
//           backgroundColor: AppColors.errorColor,
//           colorText: AppColors.whiteColor,
//           snackPosition: SnackPosition.TOP,
//         );
//         return;
//       }

//       final directory = await getApplicationDocumentsDirectory();
//       final filePath =
//           '${directory.path}/speech_${DateTime.now().millisecondsSinceEpoch}.wav';

//       await audioRecorder.start(
//         const RecordConfig(
//           encoder: AudioEncoder.wav,
//           bitRate: 128000,
//           sampleRate: 44100,
//         ),
//         path: filePath,
//       );

//       isRecording.value = true;
//       recordingSeconds.value = 0;

//       // Start timer
//       recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
//         recordingSeconds.value++;
//       });

//       // Start audio level monitoring
//       levelTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
//         _updateAudioLevel();
//       });

//       debugPrint('✅ Recording started: $filePath');
//     } catch (e) {
//       debugPrint('❌ Recording error: $e');
//       Get.snackbar(
//         'Error',
//         'Failed to start recording',
//         backgroundColor: AppColors.errorColor,
//         colorText: AppColors.whiteColor,
//         snackPosition: SnackPosition.TOP,
//       );
//     }
//   }

//   Future<void> _stopRecording() async {
//     try {
//       final path = await audioRecorder.stop();

//       recordingTimer?.cancel();
//       levelTimer?.cancel();
//       isRecording.value = false;
//       audioLevel.value = 0.0;

//       if (path != null) {
//         recordedFile.value = File(path);
//         debugPrint('✅ Recording stopped: $path');
        
//         // Show confirmation dialog
//         _showUploadConfirmation();
//       }
//     } catch (e) {
//       debugPrint('❌ Stop recording error: $e');
//       Get.snackbar(
//         'Error',
//         'Failed to stop recording',
//         backgroundColor: AppColors.errorColor,
//         colorText: AppColors.whiteColor,
//         snackPosition: SnackPosition.TOP,
//       );
//     }
//   }

//   Future<void> _updateAudioLevel() async {
//     try {
//       final amplitude = await audioRecorder.getAmplitude();
//       audioLevel.value = (amplitude.current / amplitude.max).clamp(0.0, 1.0);
//     } catch (e) {
//       // Silently fail
//     }
//   }

//   void _showUploadConfirmation() {
//     final size = CustomSize();

//     Get.dialog(
//       AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         title: Text(
//           'Upload Recording?',
//           style: GoogleFonts.poppins(
//             fontWeight: FontWeight.bold,
//             fontSize: size.customWidth(context) * 0.05,
//           ),
//         ),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(
//               Icons.mic_rounded,
//               size: 60,
//               color: AppColors.successColor,
//             ),
//             SizedBox(height: size.customHeight(context) * 0.02),
//             Text(
//               'Duration: ${_formatDuration(recordingSeconds.value)}',
//               style: GoogleFonts.poppins(
//                 fontSize: size.customWidth(context) * 0.04,
//                 fontWeight: FontWeight.w600,
//                 color: AppColors.textPrimaryColor,
//               ),
//             ),
//             SizedBox(height: size.customHeight(context) * 0.01),
//             Text(
//               'Child: ${controller.selectedChild.value?.childName ?? "Unknown"}',
//               style: GoogleFonts.poppins(
//                 fontSize: size.customWidth(context) * 0.035,
//                 color: AppColors.textSecondaryColor,
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Get.back();
//               _discardRecording();
//             },
//             child: Text(
//               'Discard',
//               style: GoogleFonts.poppins(
//                 color: AppColors.errorColor,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Get.back();
//               _uploadRecording();
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: AppColors.primaryColor,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//             child: Text(
//               'Upload',
//               style: GoogleFonts.poppins(
//                 color: AppColors.whiteColor,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _uploadRecording() async {
//     if (recordedFile.value == null) return;

//     final success = await controller.submitSpeech(
//       audioFile: recordedFile.value!,
//       durationSeconds: recordingSeconds.value,
//       format: 'wav',
//     );

//     if (success) {
//       // Navigate to submissions list
//       Get.offNamed(AppRoutes.speechSubmissions);
//     }
//   }

//   void _discardRecording() {
//     recordedFile.value?.delete();
//     recordedFile.value = null;
//     recordingSeconds.value = 0;
//   }

//   String _formatDuration(int seconds) {
//     final minutes = seconds ~/ 60;
//     final secs = seconds % 60;
//     return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();

//     return Scaffold(
//       backgroundColor: AppColors.lightGreyColor,
//       body: CustomScrollView(
//         slivers: [
//           // App Bar
//           SliverAppBar(
//             expandedHeight: size.customHeight(context) * 0.25,
//             pinned: true,
//             backgroundColor: AppColors.primaryColor,
//             flexibleSpace: FlexibleSpaceBar(
//               background: _buildHeader(context),
//             ),
//             leading: IconButton(
//               icon: const Icon(Icons.arrow_back, color: AppColors.whiteColor),
//               onPressed: () => Get.back(),
//             ),
//           ),

//           // Content
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: EdgeInsets.all(size.customWidth(context) * 0.05),
//               child: Column(
//                 children: [
//                   // Child Selection
//                   _buildChildSelection(context),

//                   SizedBox(height: size.customHeight(context) * 0.03),

//                   // Recording Area
//                   _buildRecordingArea(context),

//                   SizedBox(height: size.customHeight(context) * 0.03),

//                   // Instructions
//                   _buildInstructions(context),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildHeader(BuildContext context) {
//     final size = CustomSize();

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
//             Container(
//               width: 70,
//               height: 70,
//               decoration: BoxDecoration(
//                 color: AppColors.whiteColor.withOpacity(0.2),
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(
//                 Icons.mic_rounded,
//                 size: 40,
//                 color: AppColors.whiteColor,
//               ),
//             ),
//             SizedBox(height: size.customHeight(context) * 0.015),
//             Text(
//               'Speech Recording',
//               style: GoogleFonts.poppins(
//                 color: AppColors.whiteColor,
//                 fontSize: size.customWidth(context) * 0.06,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: size.customHeight(context) * 0.005),
//             Text(
//               'Record your child\'s speech',
//               style: GoogleFonts.poppins(
//                 color: AppColors.whiteColor.withOpacity(0.9),
//                 fontSize: size.customWidth(context) * 0.035,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildChildSelection(BuildContext context) {
//     final size = CustomSize();

//     return Obx(() {
//       if (controller.isLoadingChildren.value) {
//         return const Center(child: CircularProgressIndicator());
//       }

//       if (controller.children.isEmpty) {
//         return Container(
//           padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//           decoration: BoxDecoration(
//             color: AppColors.whiteColor,
//             borderRadius: BorderRadius.circular(15),
//           ),
//           child: Text(
//             'No children found. Please add a child first.',
//             style: GoogleFonts.poppins(
//               color: AppColors.textSecondaryColor,
//               fontSize: size.customWidth(context) * 0.035,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         );
//       }

//       return Container(
//         padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//         decoration: BoxDecoration(
//           color: AppColors.whiteColor,
//           borderRadius: BorderRadius.circular(15),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 10,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Select Child',
//               style: GoogleFonts.poppins(
//                 fontSize: size.customWidth(context) * 0.04,
//                 fontWeight: FontWeight.w600,
//                 color: AppColors.textPrimaryColor,
//               ),
//             ),
//             SizedBox(height: size.customHeight(context) * 0.015),
//             DropdownButtonFormField<String>(
//               value: controller.selectedChild.value?.childId,
//               decoration: InputDecoration(
//                 contentPadding: EdgeInsets.symmetric(
//                   horizontal: size.customWidth(context) * 0.04,
//                   vertical: size.customHeight(context) * 0.015,
//                 ),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide: BorderSide(color: AppColors.greyColor.withOpacity(0.3)),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide: BorderSide(color: AppColors.greyColor.withOpacity(0.3)),
//                 ),
//               ),
//               items: controller.children.map((child) {
//                 return DropdownMenuItem<String>(
//                   value: child.childId,
//                   child: Row(
//                     children: [
//                       Icon(
//                         Icons.child_care,
//                         color: AppColors.primaryColor,
//                         size: 20,
//                       ),
//                       SizedBox(width: size.customWidth(context) * 0.02),
//                       Text(
//                         child.childName,
//                         style: GoogleFonts.poppins(
//                           fontSize: size.customWidth(context) * 0.038,
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 final selected = controller.children.firstWhere(
//                   (child) => child.childId == value,
//                 );
//                 controller.selectChild(selected);
//               },
//             ),
//           ],
//         ),
//       );
//     });
//   }

//   Widget _buildRecordingArea(BuildContext context) {
//     final size = CustomSize();

//     return Obx(() => Container(
//           padding: EdgeInsets.all(size.customWidth(context) * 0.06),
//           decoration: BoxDecoration(
//             color: AppColors.whiteColor,
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.08),
//                 blurRadius: 20,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: Column(
//             children: [
//               // Waveform Animation
//               SizedBox(
//                 height: size.customHeight(context) * 0.15,
//                 child: isRecording.value
//                     ? _buildWaveform(context)
//                     : Center(
//                         child: Icon(
//                           Icons.graphic_eq_rounded,
//                           size: 80,
//                           color: AppColors.greyColor.withOpacity(0.3),
//                         ),
//                       ),
//               ),

//               SizedBox(height: size.customHeight(context) * 0.03),

//               // Timer
//               Text(
//                 _formatDuration(recordingSeconds.value),
//                 style: GoogleFonts.poppins(
//                   fontSize: size.customWidth(context) * 0.12,
//                   fontWeight: FontWeight.bold,
//                   color: isRecording.value
//                       ? AppColors.errorColor
//                       : AppColors.textPrimaryColor,
//                 ),
//               ),

//               SizedBox(height: size.customHeight(context) * 0.03),

//               // Record Button
//               GestureDetector(
//                 onTap: controller.selectedChild.value == null
//                     ? null
//                     : () {
//                         if (isRecording.value) {
//                           _stopRecording();
//                         } else {
//                           _startRecording();
//                         }
//                       },
//                 child: Container(
//                   width: size.customWidth(context) * 0.25,
//                   height: size.customWidth(context) * 0.25,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     gradient: LinearGradient(
//                       colors: controller.selectedChild.value == null
//                           ? [AppColors.greyColor, AppColors.greyColor]
//                           : isRecording.value
//                               ? [AppColors.errorColor, AppColors.warningColor]
//                               : [AppColors.primaryColor, AppColors.secondaryColor],
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         color: (isRecording.value
//                                 ? AppColors.errorColor
//                                 : AppColors.primaryColor)
//                             .withOpacity(0.3),
//                         blurRadius: 20,
//                         offset: const Offset(0, 10),
//                       ),
//                     ],
//                   ),
//                   child: Icon(
//                     isRecording.value ? Icons.stop_rounded : Icons.mic_rounded,
//                     size: size.customWidth(context) * 0.12,
//                     color: AppColors.whiteColor,
//                   ),
//                 ),
//               ),

//               SizedBox(height: size.customHeight(context) * 0.02),

//               Text(
//                 isRecording.value ? 'Tap to Stop' : 'Tap to Record',
//                 style: GoogleFonts.poppins(
//                   fontSize: size.customWidth(context) * 0.04,
//                   color: AppColors.textSecondaryColor,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }

//   Widget _buildWaveform(BuildContext context) {
//     final size = CustomSize();

//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: List.generate(20, (index) {
//         return Obx(() {
//           final height = (audioLevel.value * 100 * (0.5 + (index % 3) * 0.3))
//               .clamp(10.0, 100.0);
          
//           return AnimatedContainer(
//             duration: const Duration(milliseconds: 100),
//             width: size.customWidth(context) * 0.015,
//             height: height,
//             margin: EdgeInsets.symmetric(
//               horizontal: size.customWidth(context) * 0.005,
//             ),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               gradient: LinearGradient(
//                 colors: [AppColors.primaryColor, AppColors.secondaryColor],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//           );
//         });
//       }),
//     );
//   }

//   Widget _buildInstructions(BuildContext context) {
//     final size = CustomSize();

//     return Container(
//       padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//       decoration: BoxDecoration(
//         color: AppColors.primaryColor.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(15),
//         border: Border.all(
//           color: AppColors.primaryColor.withOpacity(0.2),
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(
//                 Icons.info_outline_rounded,
//                 color: AppColors.primaryColor,
//                 size: 20,
//               ),
//               SizedBox(width: size.customWidth(context) * 0.02),
//               Text(
//                 'Instructions',
//                 style: GoogleFonts.poppins(
//                   fontSize: size.customWidth(context) * 0.04,
//                   fontWeight: FontWeight.w600,
//                   color: AppColors.primaryColor,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: size.customHeight(context) * 0.015),
//           _buildInstructionItem(
//             context,
//             '1. Select your child from the dropdown',
//           ),
//           _buildInstructionItem(
//             context,
//             '2. Find a quiet environment',
//           ),
//           _buildInstructionItem(
//             context,
//             '3. Tap the microphone button to start recording',
//           ),
//           _buildInstructionItem(
//             context,
//             '4. Let your child speak clearly',
//           ),
//           _buildInstructionItem(
//             context,
//             '5. Tap stop when finished',
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildInstructionItem(BuildContext context, String text) {
//     final size = CustomSize();

//     return Padding(
//       padding: EdgeInsets.only(bottom: size.customHeight(context) * 0.008),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(
//             Icons.check_circle_outline,
//             size: 16,
//             color: AppColors.primaryColor,
//           ),
//           SizedBox(width: size.customWidth(context) * 0.02),
//           Expanded(
//             child: Text(
//               text,
//               style: GoogleFonts.poppins(
//                 fontSize: size.customWidth(context) * 0.035,
//                 color: AppColors.textPrimaryColor,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// // lib/view/speech/speech_recording_screen.dart

// import 'dart:async';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:record/record.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/speech_controller.dart';
// import 'package:speechspectrum/routes/app_routes.dart';

// class SpeechRecordingScreen extends StatefulWidget {
//   const SpeechRecordingScreen({super.key});

//   @override
//   State<SpeechRecordingScreen> createState() => _SpeechRecordingScreenState();
// }

// class _SpeechRecordingScreenState extends State<SpeechRecordingScreen>
//     with SingleTickerProviderStateMixin {
//   // ✅ Reuse the permanent singleton
//   final controller = SpeechController.instance;
//   final audioRecorder = AudioRecorder();

//   final RxBool isRecording = false.obs;
//   final RxInt recordingSeconds = 0.obs;
//   final RxDouble audioLevel = 0.0.obs;
//   final Rx<File?> recordedFile = Rx<File?>(null);

//   Timer? recordingTimer;
//   Timer? levelTimer;
//   late AnimationController animationController;

//   @override
//   void initState() {
//     super.initState();
//     animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1500),
//     )..repeat(reverse: true);
//     _initRecorder();
//   }

//   @override
//   void dispose() {
//     recordingTimer?.cancel();
//     levelTimer?.cancel();
//     animationController.dispose();
//     audioRecorder.dispose();
//     super.dispose();
//   }

//   Future<void> _initRecorder() async {
//     final hasPermission = await audioRecorder.hasPermission();
//     if (!hasPermission) {
//       Get.snackbar('Permission Required',
//           'Microphone permission is required to record audio',
//           backgroundColor: AppColors.warningColor,
//           colorText: AppColors.whiteColor,
//           snackPosition: SnackPosition.TOP);
//     }
//   }

//   Future<void> _startRecording() async {
//     try {
//       final hasPermission = await audioRecorder.hasPermission();
//       if (!hasPermission) {
//         Get.snackbar('Permission Denied',
//             'Please grant microphone permission',
//             backgroundColor: AppColors.errorColor,
//             colorText: AppColors.whiteColor,
//             snackPosition: SnackPosition.TOP);
//         return;
//       }

//       final directory = await getApplicationDocumentsDirectory();
//       final filePath =
//           '${directory.path}/speech_${DateTime.now().millisecondsSinceEpoch}.wav';

//       await audioRecorder.start(
//         const RecordConfig(
//           encoder: AudioEncoder.wav,
//           bitRate: 128000,
//           sampleRate: 44100,
//         ),
//         path: filePath,
//       );

//       isRecording.value = true;
//       recordingSeconds.value = 0;

//       recordingTimer =
//           Timer.periodic(const Duration(seconds: 1), (_) => recordingSeconds.value++);
//       levelTimer = Timer.periodic(
//           const Duration(milliseconds: 100), (_) => _updateAudioLevel());

//       debugPrint('✅ Recording started: $filePath');
//     } catch (e) {
//       debugPrint('❌ Recording error: $e');
//       Get.snackbar('Error', 'Failed to start recording',
//           backgroundColor: AppColors.errorColor,
//           colorText: AppColors.whiteColor,
//           snackPosition: SnackPosition.TOP);
//     }
//   }

//   Future<void> _stopRecording() async {
//     try {
//       final path = await audioRecorder.stop();
//       recordingTimer?.cancel();
//       levelTimer?.cancel();
//       isRecording.value = false;
//       audioLevel.value = 0.0;

//       if (path != null) {
//         recordedFile.value = File(path);
//         debugPrint('✅ Recording stopped: $path');
//         _showUploadConfirmation();
//       }
//     } catch (e) {
//       debugPrint('❌ Stop recording error: $e');
//       Get.snackbar('Error', 'Failed to stop recording',
//           backgroundColor: AppColors.errorColor,
//           colorText: AppColors.whiteColor,
//           snackPosition: SnackPosition.TOP);
//     }
//   }

//   Future<void> _updateAudioLevel() async {
//     try {
//       final amplitude = await audioRecorder.getAmplitude();
//       audioLevel.value = (amplitude.current / amplitude.max).clamp(0.0, 1.0);
//     } catch (_) {}
//   }

//   void _showUploadConfirmation() {
//     final size = CustomSize();
//     Get.dialog(
//       AlertDialog(
//         shape:
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         title: Text('Upload Recording?',
//             style: GoogleFonts.poppins(
//                 fontWeight: FontWeight.bold,
//                 fontSize: size.customWidth(context) * 0.05)),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Icon(Icons.mic_rounded, size: 60, color: AppColors.successColor),
//             SizedBox(height: size.customHeight(context) * 0.02),
//             Text('Duration: ${_formatDuration(recordingSeconds.value)}',
//                 style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.04,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.textPrimaryColor)),
//             SizedBox(height: size.customHeight(context) * 0.01),
//             Text(
//                 'Child: ${controller.selectedChild.value?.childName ?? "Unknown"}',
//                 style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.035,
//                     color: AppColors.textSecondaryColor)),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Get.back();
//               _discardRecording();
//             },
//             child: Text('Discard',
//                 style: GoogleFonts.poppins(
//                     color: AppColors.errorColor,
//                     fontWeight: FontWeight.w600)),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Get.back();
//               _uploadRecording();
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: AppColors.primaryColor,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10)),
//             ),
//             child: Text('Upload',
//                 style: GoogleFonts.poppins(
//                     color: AppColors.whiteColor,
//                     fontWeight: FontWeight.w600)),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _uploadRecording() async {
//     if (recordedFile.value == null) return;

//     final success = await controller.submitSpeech(
//       audioFile: recordedFile.value!,
//       durationSeconds: recordingSeconds.value,
//       format: 'wav',
//     );

//     if (success) {
//       Get.offNamed(AppRoutes.speechSubmissions);
//     }
//   }

//   void _discardRecording() {
//     recordedFile.value?.delete();
//     recordedFile.value = null;
//     recordingSeconds.value = 0;
//   }

//   String _formatDuration(int seconds) {
//     final m = seconds ~/ 60;
//     final s = seconds % 60;
//     return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();

//     return Obx(() {
//       return Stack(
//         children: [
//           // ── Main Scaffold ───────────────────────────────────────────────
//           Scaffold(
//             backgroundColor: AppColors.lightGreyColor,
//             body: CustomScrollView(
//               slivers: [
//                 SliverAppBar(
//                   expandedHeight: size.customHeight(context) * 0.25,
//                   pinned: true,
//                   backgroundColor: AppColors.primaryColor,
//                   flexibleSpace:
//                       FlexibleSpaceBar(background: _buildHeader(context)),
//                   leading: IconButton(
//                     icon: const Icon(Icons.arrow_back,
//                         color: AppColors.whiteColor),
//                     onPressed: () => Get.back(),
//                   ),
//                 ),
//                 SliverToBoxAdapter(
//                   child: Padding(
//                     padding: EdgeInsets.all(size.customWidth(context) * 0.05),
//                     child: Column(
//                       children: [
//                         _buildChildSelection(context),
//                         SizedBox(height: size.customHeight(context) * 0.03),
//                         _buildRecordingArea(context),
//                         SizedBox(height: size.customHeight(context) * 0.03),
//                         _buildInstructions(context),
//                         SizedBox(height: size.customHeight(context) * 0.05),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // ── Full-screen loading overlay while API is running ─────────────
//           // if (controller.isSubmitting.value)
//           //   Container(
//           //     color: Colors.black.withOpacity(0.55),
//           //     child: Center(
//           //       child: Container(
//           //         padding: EdgeInsets.symmetric(
//           //           horizontal: size.customWidth(context) * 0.1,
//           //           vertical: size.customHeight(context) * 0.045,
//           //         ),
//           //         decoration: BoxDecoration(
//           //           color: AppColors.whiteColor,
//           //           borderRadius: BorderRadius.circular(20),
//           //           boxShadow: [
//           //             BoxShadow(
//           //                 color: Colors.black.withOpacity(0.15),
//           //                 blurRadius: 20,
//           //                 offset: const Offset(0, 8))
//           //           ],
//           //         ),
//           //         child: Column(
//           //           mainAxisSize: MainAxisSize.min,
//           //           children: [
//           //             const CircularProgressIndicator(
//           //               color: AppColors.primaryColor,
//           //               strokeWidth: 3.5,
//           //             ),
//           //             SizedBox(height: size.customHeight(context) * 0.025),
//           //             Text(
//           //               'Uploading & Analysing...',
//           //               style: GoogleFonts.poppins(
//           //                 fontSize: size.customWidth(context) * 0.042,
//           //                 fontWeight: FontWeight.w600,
//           //                 color: AppColors.textPrimaryColor,
//           //               ),
//           //             ),
//           //             SizedBox(height: size.customHeight(context) * 0.008),
//           //             Text(
//           //               'Please wait while we analyse\nyour child\'s speech',
//           //               textAlign: TextAlign.center,
//           //               style: GoogleFonts.poppins(
//           //                 fontSize: size.customWidth(context) * 0.033,
//           //                 color: AppColors.textSecondaryColor,
//           //                 height: 1.4,
//           //               ),
//           //             ),
//           //           ],
//           //         ),
//           //       ),
//           //     ),
//           //   ),

//           if (controller.isSubmitting.value)
//   Container(
//     color: Colors.black.withOpacity(0.35),
//     child: const Center(
//       child: CircularProgressIndicator(
//         color: AppColors.primaryColor,
//         strokeWidth: 3.5,
//       ),
//     ),
//   ),
//         ],
//       );
//     });
//   }

//   Widget _buildHeader(BuildContext context) {
//     final size = CustomSize();
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
//             Container(
//               width: 70,
//               height: 70,
//               decoration: BoxDecoration(
//                   color: AppColors.whiteColor.withOpacity(0.2),
//                   shape: BoxShape.circle),
//               child: const Icon(Icons.mic_rounded,
//                   size: 40, color: AppColors.whiteColor),
//             ),
//             SizedBox(height: size.customHeight(context) * 0.015),
//             Text('Speech Recording',
//                 style: GoogleFonts.poppins(
//                     color: AppColors.whiteColor,
//                     fontSize: size.customWidth(context) * 0.06,
//                     fontWeight: FontWeight.bold)),
//             SizedBox(height: size.customHeight(context) * 0.005),
//             Text('Record your child\'s speech',
//                 style: GoogleFonts.poppins(
//                     color: AppColors.whiteColor.withOpacity(0.9),
//                     fontSize: size.customWidth(context) * 0.035)),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildChildSelection(BuildContext context) {
//     final size = CustomSize();
//     return Obx(() {
//       if (controller.isLoadingChildren.value) {
//         return const Center(
//             child: CircularProgressIndicator(color: AppColors.primaryColor));
//       }
//       if (controller.children.isEmpty) {
//         return Container(
//           padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//           decoration: BoxDecoration(
//               color: AppColors.whiteColor,
//               borderRadius: BorderRadius.circular(15)),
//           child: Text('No children found. Please add a child first.',
//               style: GoogleFonts.poppins(
//                   color: AppColors.textSecondaryColor,
//                   fontSize: size.customWidth(context) * 0.035),
//               textAlign: TextAlign.center),
//         );
//       }
//       return Container(
//         padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//         decoration: BoxDecoration(
//           color: AppColors.whiteColor,
//           borderRadius: BorderRadius.circular(15),
//           boxShadow: [
//             BoxShadow(
//                 color: Colors.black.withOpacity(0.05),
//                 blurRadius: 10,
//                 offset: const Offset(0, 2))
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Select Child',
//                 style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.04,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.textPrimaryColor)),
//             SizedBox(height: size.customHeight(context) * 0.015),
//             DropdownButtonFormField<String>(
//               value: controller.selectedChild.value?.childId,
//               decoration: InputDecoration(
//                 contentPadding: EdgeInsets.symmetric(
//                     horizontal: size.customWidth(context) * 0.04,
//                     vertical: size.customHeight(context) * 0.015),
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: BorderSide(
//                         color: AppColors.greyColor.withOpacity(0.3))),
//                 enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: BorderSide(
//                         color: AppColors.greyColor.withOpacity(0.3))),
//               ),
//               items: controller.children.map((child) {
//                 return DropdownMenuItem<String>(
//                   value: child.childId,
//                   child: Row(children: [
//                     Icon(Icons.child_care,
//                         color: AppColors.primaryColor, size: 20),
//                     SizedBox(width: size.customWidth(context) * 0.02),
//                     Text(child.childName,
//                         style: GoogleFonts.poppins(
//                             fontSize: size.customWidth(context) * 0.038)),
//                   ]),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 final selected = controller.children
//                     .firstWhere((c) => c.childId == value);
//                 controller.selectChild(selected);
//               },
//             ),
//           ],
//         ),
//       );
//     });
//   }

//   Widget _buildRecordingArea(BuildContext context) {
//     final size = CustomSize();
//     return Obx(() => Container(
//           padding: EdgeInsets.all(size.customWidth(context) * 0.06),
//           decoration: BoxDecoration(
//             color: AppColors.whiteColor,
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(
//                   color: Colors.black.withOpacity(0.08),
//                   blurRadius: 20,
//                   offset: const Offset(0, 4))
//             ],
//           ),
//           child: Column(
//             children: [
//               SizedBox(
//                 height: size.customHeight(context) * 0.15,
//                 child: isRecording.value
//                     ? _buildWaveform(context)
//                     : Center(
//                         child: Icon(Icons.graphic_eq_rounded,
//                             size: 80,
//                             color: AppColors.greyColor.withOpacity(0.3))),
//               ),
//               SizedBox(height: size.customHeight(context) * 0.03),
//               Text(
//                 _formatDuration(recordingSeconds.value),
//                 style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.12,
//                     fontWeight: FontWeight.bold,
//                     color: isRecording.value
//                         ? AppColors.errorColor
//                         : AppColors.textPrimaryColor),
//               ),
//               SizedBox(height: size.customHeight(context) * 0.03),
//               GestureDetector(
//                 onTap: controller.selectedChild.value == null
//                     ? null
//                     : () {
//                         if (isRecording.value) {
//                           _stopRecording();
//                         } else {
//                           _startRecording();
//                         }
//                       },
//                 child: Container(
//                   width: size.customWidth(context) * 0.25,
//                   height: size.customWidth(context) * 0.25,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     gradient: LinearGradient(
//                       colors: controller.selectedChild.value == null
//                           ? [AppColors.greyColor, AppColors.greyColor]
//                           : isRecording.value
//                               ? [AppColors.errorColor, AppColors.warningColor]
//                               : [
//                                   AppColors.primaryColor,
//                                   AppColors.secondaryColor
//                                 ],
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                           color: (isRecording.value
//                                   ? AppColors.errorColor
//                                   : AppColors.primaryColor)
//                               .withOpacity(0.3),
//                           blurRadius: 20,
//                           offset: const Offset(0, 10))
//                     ],
//                   ),
//                   child: Icon(
//                     isRecording.value
//                         ? Icons.stop_rounded
//                         : Icons.mic_rounded,
//                     size: size.customWidth(context) * 0.12,
//                     color: AppColors.whiteColor,
//                   ),
//                 ),
//               ),
//               SizedBox(height: size.customHeight(context) * 0.02),
//               Text(
//                 isRecording.value ? 'Tap to Stop' : 'Tap to Record',
//                 style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.04,
//                     color: AppColors.textSecondaryColor,
//                     fontWeight: FontWeight.w500),
//               ),
//             ],
//           ),
//         ));
//   }

//   Widget _buildWaveform(BuildContext context) {
//     final size = CustomSize();
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: List.generate(20, (index) {
//         return Obx(() {
//           final height =
//               (audioLevel.value * 100 * (0.5 + (index % 3) * 0.3))
//                   .clamp(10.0, 100.0);
//           return AnimatedContainer(
//             duration: const Duration(milliseconds: 100),
//             width: size.customWidth(context) * 0.015,
//             height: height,
//             margin: EdgeInsets.symmetric(
//                 horizontal: size.customWidth(context) * 0.005),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               gradient: const LinearGradient(
//                 colors: [AppColors.primaryColor, AppColors.secondaryColor],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//           );
//         });
//       }),
//     );
//   }

//   Widget _buildInstructions(BuildContext context) {
//     final size = CustomSize();
//     return Container(
//       padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//       decoration: BoxDecoration(
//         color: AppColors.primaryColor.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(15),
//         border:
//             Border.all(color: AppColors.primaryColor.withOpacity(0.2)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(children: [
//             const Icon(Icons.info_outline_rounded,
//                 color: AppColors.primaryColor, size: 20),
//             SizedBox(width: size.customWidth(context) * 0.02),
//             Text('Instructions',
//                 style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.04,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.primaryColor)),
//           ]),
//           SizedBox(height: size.customHeight(context) * 0.015),
//           _instruction(context, '1. Select your child from the dropdown'),
//           _instruction(context, '2. Find a quiet environment'),
//           _instruction(context, '3. Tap the microphone button to start'),
//           _instruction(context, '4. Let your child speak clearly'),
//           _instruction(context, '5. Tap stop when finished'),
//         ],
//       ),
//     );
//   }

//   Widget _instruction(BuildContext context, String text) {
//     final size = CustomSize();
//     return Padding(
//       padding: EdgeInsets.only(bottom: size.customHeight(context) * 0.008),
//       child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         const Icon(Icons.check_circle_outline,
//             size: 16, color: AppColors.primaryColor),
//         SizedBox(width: size.customWidth(context) * 0.02),
//         Expanded(
//           child: Text(text,
//               style: GoogleFonts.poppins(
//                   fontSize: size.customWidth(context) * 0.035,
//                   color: AppColors.textPrimaryColor)),
//         ),
//       ]),
//     );
//   }
// }

// lib/view/speech/speech_recording_screen.dart

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
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
  final controller = SpeechController.instance;
  final audioRecorder = AudioRecorder();

  // Recording state
  final RxBool isRecording = false.obs;
  final RxInt recordingSeconds = 0.obs;
  final RxDouble audioLevel = 0.0.obs;
  final Rx<File?> recordedFile = Rx<File?>(null);

  // Upload state
  final Rx<File?> uploadedFile = Rx<File?>(null);
  final RxInt uploadedFileDurationSeconds = 0.obs;
  final RxString uploadedFileName = ''.obs;

  // Which mode is selected: 'record' or 'upload'
  final RxString selectedMode = 'record'.obs;

  Timer? recordingTimer;
  Timer? levelTimer;
  late AnimationController animationController;

  static const int _minDurationSeconds = 5;

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

  // ─────────────────────────────────────────────────────────────────────────
  // RECORDING LOGIC
  // ─────────────────────────────────────────────────────────────────────────

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
      recordedFile.value = null;

      recordingTimer = Timer.periodic(
          const Duration(seconds: 1), (_) => recordingSeconds.value++);
      levelTimer = Timer.periodic(
          const Duration(milliseconds: 100), (_) => _updateAudioLevel());

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
        // ── Validate minimum duration ──────────────────────────────────────
        if (recordingSeconds.value < _minDurationSeconds) {
          // Delete the short recording
          File(path).deleteSync();
          recordingSeconds.value = 0;
          Get.snackbar(
            'Recording Too Short',
            'Voice must be at least $_minDurationSeconds seconds. '
                'Please record again.',
            backgroundColor: AppColors.errorColor,
            colorText: AppColors.whiteColor,
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 4),
            icon: const Icon(Icons.timer_off_rounded,
                color: Colors.white, size: 28),
          );
          return;
        }

        recordedFile.value = File(path);
        debugPrint('✅ Recording stopped: $path');
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
      audioLevel.value =
          (amplitude.current / amplitude.max).clamp(0.0, 1.0);
    } catch (_) {}
  }

  // ─────────────────────────────────────────────────────────────────────────
  // UPLOAD LOGIC
  // ─────────────────────────────────────────────────────────────────────────

  Future<void> _pickAudioFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['wav', 'mp3', 'm4a', 'aac', 'ogg', 'flac'],
        allowMultiple: false,
      );

      if (result == null || result.files.isEmpty) return;

      final pickedFile = result.files.first;
      if (pickedFile.path == null) return;

      final file = File(pickedFile.path!);
      final fileName = pickedFile.name;

      // ── Estimate duration from file size (rough heuristic for WAV)
      // For a real app, use a proper audio player/info package.
      // We estimate: WAV ~88 KB/s at 44.1kHz 16bit mono, ~176 KB/s stereo
      // Other formats vary. We do a best-effort fallback.
      final fileSizeBytes = await file.length();
      int estimatedDuration = _estimateDuration(fileSizeBytes, fileName);

      // ── Validate minimum duration ──────────────────────────────────────
      if (estimatedDuration < _minDurationSeconds) {
        Get.snackbar(
          'File Too Short',
          'Audio file must be at least $_minDurationSeconds seconds long. '
              'Please select a longer file.',
          backgroundColor: AppColors.errorColor,
          colorText: AppColors.whiteColor,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 4),
          icon: const Icon(Icons.timer_off_rounded,
              color: Colors.white, size: 28),
        );
        return;
      }

      uploadedFile.value = file;
      uploadedFileName.value = fileName;
      uploadedFileDurationSeconds.value = estimatedDuration;

      debugPrint(
          '✅ File picked: $fileName (est. ${estimatedDuration}s)');

      _showUploadFileConfirmation();
    } catch (e) {
      debugPrint('❌ File picker error: $e');
      Get.snackbar(
        'Error',
        'Failed to pick audio file. Make sure the file is a valid audio format.',
        backgroundColor: AppColors.errorColor,
        colorText: AppColors.whiteColor,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  /// Rough duration estimate based on file size and extension.
  /// For production use flutter_ffmpeg or just_audio to get exact duration.
  int _estimateDuration(int fileSizeBytes, String fileName) {
    final ext = fileName.split('.').last.toLowerCase();
    double bytesPerSecond;
    switch (ext) {
      case 'wav':
        bytesPerSecond = 88200; // 44.1kHz, 16bit, mono ≈ 88 KB/s
        break;
      case 'mp3':
        bytesPerSecond = 16000; // 128kbps ≈ 16 KB/s
        break;
      case 'm4a':
      case 'aac':
        bytesPerSecond = 12000; // ~96kbps ≈ 12 KB/s
        break;
      default:
        bytesPerSecond = 20000; // conservative fallback
    }
    return (fileSizeBytes / bytesPerSecond).floor();
  }

  // ─────────────────────────────────────────────────────────────────────────
  // CONFIRMATION DIALOGS
  // ─────────────────────────────────────────────────────────────────────────

  void _showUploadConfirmation() {
    final size = CustomSize();
    Get.dialog(
      AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Upload Recording?',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: size.customWidth(context) * 0.05),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.mic_rounded,
                size: 60, color: AppColors.successColor),
            SizedBox(height: size.customHeight(context) * 0.02),
            Text(
              'Duration: ${_formatDuration(recordingSeconds.value)}',
              style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.04,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimaryColor),
            ),
            SizedBox(height: size.customHeight(context) * 0.01),
            Text(
              'Child: ${controller.selectedChild.value?.childName ?? "Unknown"}',
              style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.035,
                  color: AppColors.textSecondaryColor),
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
                  fontWeight: FontWeight.w600),
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
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: Text(
              'Upload & Analyse',
              style: GoogleFonts.poppins(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  void _showUploadFileConfirmation() {
    final size = CustomSize();
    Get.dialog(
      AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Upload Audio File?',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: size.customWidth(context) * 0.05),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.audio_file_rounded,
                size: 60, color: AppColors.successColor),
            SizedBox(height: size.customHeight(context) * 0.02),
            Text(
              uploadedFileName.value,
              style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.036,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimaryColor),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: size.customHeight(context) * 0.008),
            Text(
              'Est. Duration: ${_formatDuration(uploadedFileDurationSeconds.value)}',
              style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.035,
                  color: AppColors.textSecondaryColor),
            ),
            SizedBox(height: size.customHeight(context) * 0.005),
            Text(
              'Child: ${controller.selectedChild.value?.childName ?? "Unknown"}',
              style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.035,
                  color: AppColors.textSecondaryColor),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              uploadedFile.value = null;
              uploadedFileName.value = '';
              uploadedFileDurationSeconds.value = 0;
            },
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(
                  color: AppColors.errorColor,
                  fontWeight: FontWeight.w600),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              _uploadFileRecording();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: Text(
              'Upload & Analyse',
              style: GoogleFonts.poppins(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // SUBMIT TO API
  // ─────────────────────────────────────────────────────────────────────────

  Future<void> _uploadRecording() async {
    if (recordedFile.value == null) return;

    final submissionId = await controller.submitSpeechAndGetId(
      audioFile: recordedFile.value!,
      durationSeconds: recordingSeconds.value,
      format: 'wav',
    );

    if (submissionId != null) {
      // Navigate directly to detail screen with the new submission id
      Get.offNamed(AppRoutes.speechDetail, arguments: submissionId);
    }
  }

  Future<void> _uploadFileRecording() async {
    if (uploadedFile.value == null) return;

    final ext =
        uploadedFileName.value.split('.').last.toLowerCase();

    final submissionId = await controller.submitSpeechAndGetId(
      audioFile: uploadedFile.value!,
      durationSeconds: uploadedFileDurationSeconds.value,
      format: ext,
    );

    if (submissionId != null) {
      Get.offNamed(AppRoutes.speechDetail, arguments: submissionId);
    }
  }

  void _discardRecording() {
    recordedFile.value?.delete();
    recordedFile.value = null;
    recordingSeconds.value = 0;
  }

  String _formatDuration(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  // ─────────────────────────────────────────────────────────────────────────
  // BUILD
  // ─────────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();

    return Obx(() {
      return Stack(
        children: [
          Scaffold(
            backgroundColor: AppColors.lightGreyColor,
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: size.customHeight(context) * 0.25,
                  pinned: true,
                  backgroundColor: AppColors.primaryColor,
                  flexibleSpace: FlexibleSpaceBar(
                      background: _buildHeader(context)),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back,
                        color: AppColors.whiteColor),
                    onPressed: () => Get.back(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        EdgeInsets.all(size.customWidth(context) * 0.05),
                    child: Column(
                      children: [
                        _buildChildSelection(context),
                        SizedBox(
                            height: size.customHeight(context) * 0.025),
                        // ── Mode Selector Tabs ─────────────────────────────
                        _buildModeSelector(context),
                        SizedBox(
                            height: size.customHeight(context) * 0.025),
                        // ── Content based on mode ──────────────────────────
                        selectedMode.value == 'record'
                            ? _buildRecordingArea(context)
                            : _buildUploadArea(context),
                        SizedBox(
                            height: size.customHeight(context) * 0.025),
                        _buildInstructions(context),
                        SizedBox(
                            height: size.customHeight(context) * 0.05),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Full-screen loading overlay
          if (controller.isSubmitting.value)
            Container(
              color: Colors.black.withOpacity(0.35),
              child: const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                  strokeWidth: 3.5,
                ),
              ),
            ),
        ],
      );
    });
  }

  // ─────────────────────────────────────────────────────────────────────────
  // HEADER
  // ─────────────────────────────────────────────────────────────────────────

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
                  shape: BoxShape.circle),
              child: const Icon(Icons.mic_rounded,
                  size: 40, color: AppColors.whiteColor),
            ),
            SizedBox(height: size.customHeight(context) * 0.015),
            Text(
              'Speech Recording',
              style: GoogleFonts.poppins(
                  color: AppColors.whiteColor,
                  fontSize: size.customWidth(context) * 0.06,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.customHeight(context) * 0.005),
            Text(
              'Record or upload your child\'s speech',
              style: GoogleFonts.poppins(
                  color: AppColors.whiteColor.withOpacity(0.9),
                  fontSize: size.customWidth(context) * 0.035),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // MODE SELECTOR
  // ─────────────────────────────────────────────────────────────────────────

  Widget _buildModeSelector(BuildContext context) {
    final size = CustomSize();
    return Obx(() => Container(
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2))
            ],
          ),
          padding: const EdgeInsets.all(4),
          child: Row(
            children: [
              _modeTab(
                context,
                label: 'Record Voice',
                icon: Icons.mic_rounded,
                mode: 'record',
                isSelected: selectedMode.value == 'record',
              ),
              _modeTab(
                context,
                label: 'Upload File',
                icon: Icons.upload_file_rounded,
                mode: 'upload',
                isSelected: selectedMode.value == 'upload',
              ),
            ],
          ),
        ));
  }

  Widget _modeTab(
    BuildContext context, {
    required String label,
    required IconData icon,
    required String mode,
    required bool isSelected,
  }) {
    final size = CustomSize();
    return Expanded(
      child: GestureDetector(
        onTap: () {
          // Stop recording if switching away
          if (isRecording.value && mode == 'upload') {
            _stopRecording();
          }
          selectedMode.value = mode;
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: EdgeInsets.symmetric(
              vertical: size.customHeight(context) * 0.016),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primaryColor
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20,
                color: isSelected
                    ? AppColors.whiteColor
                    : AppColors.greyColor,
              ),
              SizedBox(width: size.customWidth(context) * 0.02),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.037,
                  fontWeight: isSelected
                      ? FontWeight.w600
                      : FontWeight.w400,
                  color: isSelected
                      ? AppColors.whiteColor
                      : AppColors.greyColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // CHILD SELECTION
  // ─────────────────────────────────────────────────────────────────────────

  Widget _buildChildSelection(BuildContext context) {
    final size = CustomSize();
    return Obx(() {
      if (controller.isLoadingChildren.value) {
        return const Center(
            child:
                CircularProgressIndicator(color: AppColors.primaryColor));
      }
      if (controller.children.isEmpty) {
        return Container(
          padding: EdgeInsets.all(size.customWidth(context) * 0.04),
          decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(15)),
          child: Text(
            'No children found. Please add a child first.',
            style: GoogleFonts.poppins(
                color: AppColors.textSecondaryColor,
                fontSize: size.customWidth(context) * 0.035),
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
                offset: const Offset(0, 2))
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
                  color: AppColors.textPrimaryColor),
            ),
            SizedBox(height: size.customHeight(context) * 0.015),
            DropdownButtonFormField<String>(
              value: controller.selectedChild.value?.childId,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: size.customWidth(context) * 0.04,
                    vertical: size.customHeight(context) * 0.015),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: AppColors.greyColor.withOpacity(0.3))),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: AppColors.greyColor.withOpacity(0.3))),
              ),
              items: controller.children.map((child) {
                return DropdownMenuItem<String>(
                  value: child.childId,
                  child: Row(children: [
                    Icon(Icons.child_care,
                        color: AppColors.primaryColor, size: 20),
                    SizedBox(width: size.customWidth(context) * 0.02),
                    Text(child.childName,
                        style: GoogleFonts.poppins(
                            fontSize:
                                size.customWidth(context) * 0.038)),
                  ]),
                );
              }).toList(),
              onChanged: (value) {
                final selected = controller.children
                    .firstWhere((c) => c.childId == value);
                controller.selectChild(selected);
              },
            ),
          ],
        ),
      );
    });
  }

  // ─────────────────────────────────────────────────────────────────────────
  // RECORDING AREA
  // ─────────────────────────────────────────────────────────────────────────

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
                  offset: const Offset(0, 4))
            ],
          ),
          child: Column(
            children: [
              SizedBox(
                height: size.customHeight(context) * 0.15,
                child: isRecording.value
                    ? _buildWaveform(context)
                    : Center(
                        child: Icon(Icons.graphic_eq_rounded,
                            size: 80,
                            color: AppColors.greyColor.withOpacity(0.3))),
              ),
              SizedBox(height: size.customHeight(context) * 0.01),

              // Minimum duration hint
              if (!isRecording.value)
                Text(
                  'Minimum $_minDurationSeconds seconds required',
                  style: GoogleFonts.poppins(
                      fontSize: size.customWidth(context) * 0.032,
                      color: AppColors.textSecondaryColor),
                ),

              // Live timer with colour indicator
              if (isRecording.value) ...[
                Obx(() {
                  final secs = recordingSeconds.value;
                  final isValid = secs >= _minDurationSeconds;
                  return Column(
                    children: [
                      Text(
                        _formatDuration(secs),
                        style: GoogleFonts.poppins(
                            fontSize:
                                size.customWidth(context) * 0.12,
                            fontWeight: FontWeight.bold,
                            color: isValid
                                ? AppColors.successColor
                                : AppColors.errorColor),
                      ),
                      if (!isValid)
                        Text(
                          '${_minDurationSeconds - secs}s more to meet minimum',
                          style: GoogleFonts.poppins(
                              fontSize:
                                  size.customWidth(context) * 0.03,
                              color: AppColors.warningColor,
                              fontWeight: FontWeight.w500),
                        ),
                    ],
                  );
                }),
              ] else ...[
                Text(
                  _formatDuration(recordingSeconds.value),
                  style: GoogleFonts.poppins(
                      fontSize: size.customWidth(context) * 0.12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimaryColor),
                ),
              ],

              SizedBox(height: size.customHeight(context) * 0.03),

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
                              ? [
                                  AppColors.errorColor,
                                  AppColors.warningColor
                                ]
                              : [
                                  AppColors.primaryColor,
                                  AppColors.secondaryColor
                                ],
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
                          offset: const Offset(0, 10))
                    ],
                  ),
                  child: Icon(
                    isRecording.value
                        ? Icons.stop_rounded
                        : Icons.mic_rounded,
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
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ));
  }

  // ─────────────────────────────────────────────────────────────────────────
  // UPLOAD AREA
  // ─────────────────────────────────────────────────────────────────────────

  Widget _buildUploadArea(BuildContext context) {
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
                  offset: const Offset(0, 4))
            ],
          ),
          child: Column(
            children: [
              // Drop zone / file preview
              if (uploadedFile.value == null) ...[
                // Empty state — tap to pick
                GestureDetector(
                  onTap: controller.selectedChild.value == null
                      ? null
                      : _pickAudioFile,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        vertical: size.customHeight(context) * 0.045),
                    decoration: BoxDecoration(
                      color:
                          AppColors.primaryColor.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.primaryColor.withOpacity(0.3),
                        width: 2,
                        strokeAlign: BorderSide.strokeAlignInside,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.upload_file_rounded,
                          size: 64,
                          color: AppColors.primaryColor
                              .withOpacity(controller.selectedChild.value ==
                                      null
                                  ? 0.3
                                  : 0.8),
                        ),
                        SizedBox(
                            height: size.customHeight(context) * 0.015),
                        Text(
                          controller.selectedChild.value == null
                              ? 'Select a child first'
                              : 'Tap to pick audio file',
                          style: GoogleFonts.poppins(
                              fontSize:
                                  size.customWidth(context) * 0.04,
                              color: controller.selectedChild.value ==
                                      null
                                  ? AppColors.greyColor
                                  : AppColors.primaryColor,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                            height: size.customHeight(context) * 0.008),
                        Text(
                          'WAV, MP3, M4A, AAC, OGG, FLAC\nMinimum $_minDurationSeconds seconds',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontSize:
                                  size.customWidth(context) * 0.03,
                              color: AppColors.textSecondaryColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ] else ...[
                // File selected preview
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(size.customWidth(context) * 0.04),
                  decoration: BoxDecoration(
                    color: AppColors.successColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        color: AppColors.successColor.withOpacity(0.4)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color:
                              AppColors.successColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.audio_file_rounded,
                            color: AppColors.successColor, size: 28),
                      ),
                      SizedBox(width: size.customWidth(context) * 0.03),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              uploadedFileName.value,
                              style: GoogleFonts.poppins(
                                  fontSize:
                                      size.customWidth(context) * 0.036,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimaryColor),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'Est. ${_formatDuration(uploadedFileDurationSeconds.value)}',
                              style: GoogleFonts.poppins(
                                  fontSize:
                                      size.customWidth(context) * 0.032,
                                  color: AppColors.successColor),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close_rounded,
                            color: AppColors.errorColor),
                        onPressed: () {
                          uploadedFile.value = null;
                          uploadedFileName.value = '';
                          uploadedFileDurationSeconds.value = 0;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.customHeight(context) * 0.025),
                // Submit button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _showUploadFileConfirmation(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding: EdgeInsets.symmetric(
                          vertical:
                              size.customHeight(context) * 0.018),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                    icon: const Icon(Icons.send_rounded,
                        color: AppColors.whiteColor),
                    label: Text(
                      'Upload & Analyse',
                      style: GoogleFonts.poppins(
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w600,
                          fontSize:
                              size.customWidth(context) * 0.042),
                    ),
                  ),
                ),
                SizedBox(height: size.customHeight(context) * 0.015),
                // Change file
                TextButton.icon(
                  onPressed: _pickAudioFile,
                  icon: const Icon(Icons.swap_horiz_rounded,
                      color: AppColors.primaryColor, size: 18),
                  label: Text(
                    'Choose Different File',
                    style: GoogleFonts.poppins(
                        color: AppColors.primaryColor,
                        fontSize: size.customWidth(context) * 0.035,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ],
          ),
        ));
  }

  // ─────────────────────────────────────────────────────────────────────────
  // WAVEFORM
  // ─────────────────────────────────────────────────────────────────────────

  Widget _buildWaveform(BuildContext context) {
    final size = CustomSize();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(20, (index) {
        return Obx(() {
          final height =
              (audioLevel.value * 100 * (0.5 + (index % 3) * 0.3))
                  .clamp(10.0, 100.0);
          return AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            width: size.customWidth(context) * 0.015,
            height: height,
            margin: EdgeInsets.symmetric(
                horizontal: size.customWidth(context) * 0.005),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                colors: [
                  AppColors.primaryColor,
                  AppColors.secondaryColor
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          );
        });
      }),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // INSTRUCTIONS
  // ─────────────────────────────────────────────────────────────────────────

  Widget _buildInstructions(BuildContext context) {
    final size = CustomSize();
    final isUpload = selectedMode.value == 'upload';
    return Container(
      padding: EdgeInsets.all(size.customWidth(context) * 0.04),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border:
            Border.all(color: AppColors.primaryColor.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            const Icon(Icons.info_outline_rounded,
                color: AppColors.primaryColor, size: 20),
            SizedBox(width: size.customWidth(context) * 0.02),
            Text(
              'Instructions',
              style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.04,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor),
            ),
          ]),
          SizedBox(height: size.customHeight(context) * 0.015),
          _instruction(
              context, '1. Select your child from the dropdown'),
          if (isUpload) ...[
            _instruction(context,
                '2. Tap the upload area to pick an audio file'),
            _instruction(context,
                '3. File must be at least $_minDurationSeconds seconds long'),
            _instruction(context,
                '4. Supported: WAV, MP3, M4A, AAC, OGG, FLAC'),
            _instruction(context,
                '5. Tap "Upload & Analyse" to submit'),
          ] else ...[
            _instruction(context, '2. Find a quiet environment'),
            _instruction(context,
                '3. Tap the microphone button to start'),
            _instruction(context,
                '4. Speak clearly for at least $_minDurationSeconds seconds'),
            _instruction(
                context, '5. Tap stop when finished'),
          ],
        ],
      ),
    );
  }

  Widget _instruction(BuildContext context, String text) {
    final size = CustomSize();
    return Padding(
      padding:
          EdgeInsets.only(bottom: size.customHeight(context) * 0.008),
      child:
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Icon(Icons.check_circle_outline,
            size: 16, color: AppColors.primaryColor),
        SizedBox(width: size.customWidth(context) * 0.02),
        Expanded(
          child: Text(text,
              style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.035,
                  color: AppColors.textPrimaryColor)),
        ),
      ]),
    );
  }
}