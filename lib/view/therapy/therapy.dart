// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:speechspectrum/controllers/therapy_controller.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';


// class TherapyScreen extends StatelessWidget {
//   const TherapyScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Ensure controller is registered
//     final controller = Get.put(TherapyController());
//     final size = CustomSize();

//     return Scaffold(
//       backgroundColor: const Color(0xFFF4F6FA),
//       appBar: AppBar(
//         backgroundColor: AppColors.whiteColor,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios_new_rounded,
//               color: AppColors.textPrimaryColor, size: 20),
//           onPressed: () => Get.back(),
//         ),
//         title: Text(
//           'Therapy Exercises',
//           style: GoogleFonts.poppins(
//             color: AppColors.textPrimaryColor,
//             fontSize: 18,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(1),
//           child: Container(height: 1, color: Colors.grey.shade100),
//         ),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header section
//           Container(
//             width: double.infinity,
//             padding: EdgeInsets.symmetric(
//               horizontal: size.customWidth(context) * 0.05,
//               vertical: size.customHeight(context) * 0.025,
//             ),
//             decoration: BoxDecoration(
//               color: AppColors.whiteColor,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.04),
//                   blurRadius: 8,
//                   offset: const Offset(0, 2),
//                 )
//               ],
//             ),
//             child: Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         AppColors.primaryColor,
//                         AppColors.secondaryColor
//                       ],
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                     ),
//                     borderRadius: BorderRadius.circular(14),
//                   ),
//                   child: const Icon(Icons.play_lesson_rounded,
//                       color: Colors.white, size: 26),
//                 ),
//                 const SizedBox(width: 14),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Speech & ASD Therapy',
//                         style: GoogleFonts.poppins(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w700,
//                           color: AppColors.textPrimaryColor,
//                         ),
//                       ),
//                       Text(
//                         '${TherapyController.exercises.length} guided video exercises',
//                         style: GoogleFonts.poppins(
//                           fontSize: 12,
//                           color: AppColors.textSecondaryColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                   decoration: BoxDecoration(
//                     color: AppColors.primaryColor.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Text(
//                     'Free',
//                     style: GoogleFonts.poppins(
//                       fontSize: 11,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.primaryColor,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 16),

//           Padding(
//             padding: EdgeInsets.symmetric(
//                 horizontal: size.customWidth(context) * 0.05),
//             child: Text(
//               'Choose an Exercise',
//               style: GoogleFonts.poppins(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w600,
//                 color: AppColors.textSecondaryColor,
//                 letterSpacing: 0.3,
//               ),
//             ),
//           ),
//           const SizedBox(height: 12),

//           // Grid of video cards
//           Expanded(
//             child: GridView.builder(
//               padding: EdgeInsets.symmetric(
//                 horizontal: size.customWidth(context) * 0.05,
//                 vertical: 4,
//               ),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 12,
//                 mainAxisSpacing: 14,
//                 childAspectRatio: 0.82,
//               ),
//               itemCount: TherapyController.exercises.length,
//               itemBuilder: (context, index) {
//                 final ex = TherapyController.exercises[index];
//                 return _VideoCard(
//                   exercise: ex,
//                   onTap: () {
//                     controller.openVideo(ex);
//                     Get.to(
//                       () => const VideoPlayerScreen(),
//                       transition: Transition.downToUp,
//                       duration: const Duration(milliseconds: 350),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ─── Video Card ────────────────────────────────────────────────────────────────

// class _VideoCard extends StatelessWidget {
//   final TherapyExercise exercise;
//   final VoidCallback onTap;

//   const _VideoCard({required this.exercise, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(18),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.07),
//               blurRadius: 12,
//               offset: const Offset(0, 4),
//             )
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Thumbnail
//             ClipRRect(
//               borderRadius:
//                   const BorderRadius.vertical(top: Radius.circular(18)),
//               child: Stack(
//                 children: [
//                   CachedNetworkImage(
//                     imageUrl: exercise.thumbnail,
//                     height: 110,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                     placeholder: (_, __) => Container(
//                       height: 110,
//                       color: Colors.grey.shade200,
//                       child: Center(
//                         child: CircularProgressIndicator(
//                           strokeWidth: 2,
//                           color: AppColors.primaryColor,
//                         ),
//                       ),
//                     ),
//                     errorWidget: (_, __, ___) => Container(
//                       height: 110,
//                       color: Colors.grey.shade200,
//                       child:
//                           Icon(Icons.image_not_supported, color: Colors.grey),
//                     ),
//                   ),
//                   // Dark overlay + play button
//                   Positioned.fill(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           begin: Alignment.topCenter,
//                           end: Alignment.bottomCenter,
//                           colors: [
//                             Colors.transparent,
//                             Colors.black.withOpacity(0.45),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned.fill(
//                     child: Center(
//                       child: Container(
//                         width: 38,
//                         height: 38,
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.92),
//                           shape: BoxShape.circle,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.2),
//                               blurRadius: 8,
//                             )
//                           ],
//                         ),
//                         child: Icon(
//                           Icons.play_arrow_rounded,
//                           color: AppColors.primaryColor,
//                           size: 24,
//                         ),
//                       ),
//                     ),
//                   ),
//                   // Episode badge
//                   Positioned(
//                     top: 8,
//                     left: 8,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 7, vertical: 3),
//                       decoration: BoxDecoration(
//                         color: AppColors.primaryColor,
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                       child: Text(
//                         '#${exercise.id}',
//                         style: GoogleFonts.poppins(
//                           color: Colors.white,
//                           fontSize: 10,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             // Title & arrow
//             Padding(
//               padding: const EdgeInsets.fromLTRB(10, 10, 8, 10),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: Text(
//                       exercise.title,
//                       style: GoogleFonts.poppins(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w600,
//                         color: AppColors.textPrimaryColor,
//                         height: 1.35,
//                       ),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   const SizedBox(width: 4),
//                   Icon(
//                     Icons.arrow_forward_ios_rounded,
//                     size: 12,
//                     color: AppColors.primaryColor,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ─── Video Player Screen ───────────────────────────────────────────────────────

// class VideoPlayerScreen extends StatefulWidget {
//   const VideoPlayerScreen({super.key});

//   @override
//   State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
// }

// class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
//   late YoutubePlayerController _ytController;
//   final TherapyController _therapyCtrl = Get.find<TherapyController>();
//   bool _isFullScreen = false;

//   @override
//   void initState() {
//     super.initState();
//     final videoId = _therapyCtrl.currentExercise.value!.videoUrl;
//     _ytController = YoutubePlayerController(
//       initialVideoId: videoId,
//       flags: const YoutubePlayerFlags(
//         autoPlay: true,
//         mute: false,
//         enableCaption: true,
//         forceHD: false,
//       ),
//     )..addListener(_listener);
//   }

//   void _listener() {
//     if (_ytController.value.isFullScreen != _isFullScreen) {
//       setState(() => _isFullScreen = _ytController.value.isFullScreen);
//     }
//   }

//   @override
//   void deactivate() {
//     _ytController.pause();
//     super.deactivate();
//   }

//   @override
//   void dispose() {
//     _ytController.removeListener(_listener);
//     _ytController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final exercise = _therapyCtrl.currentExercise.value!;

//     return YoutubePlayerBuilder(
//       onExitFullScreen: () {
//         SystemChrome.setPreferredOrientations(DeviceOrientation.values);
//       },
//       player: YoutubePlayer(
//         controller: _ytController,
//         showVideoProgressIndicator: true,
//         progressIndicatorColor: AppColors.primaryColor,
//         progressColors: ProgressBarColors(
//           playedColor: AppColors.primaryColor,
//           handleColor: AppColors.secondaryColor,
//           bufferedColor: AppColors.primaryColor.withOpacity(0.3),
//           backgroundColor: Colors.grey.shade300,
//         ),
//         onReady: () {},
//       ),
//       builder: (context, player) {
//         return Scaffold(
//           backgroundColor: const Color(0xFF0D0D0D),
//           appBar: _isFullScreen
//               ? null
//               : AppBar(
//                   backgroundColor: const Color(0xFF0D0D0D),
//                   elevation: 0,
//                   leading: IconButton(
//                     icon: const Icon(Icons.arrow_back_ios_new_rounded,
//                         color: Colors.white, size: 20),
//                     onPressed: () => Get.back(),
//                   ),
//                   title: Text(
//                     'Now Playing',
//                     style: GoogleFonts.poppins(
//                       color: Colors.white70,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//           body: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // YouTube Player
//               player,

//               if (!_isFullScreen) ...[
//                 const SizedBox(height: 20),

//                 // Title & number
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 10, vertical: 4),
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [
//                               AppColors.primaryColor,
//                               AppColors.secondaryColor
//                             ],
//                           ),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Text(
//                           'Exercise #${exercise.id}',
//                           style: GoogleFonts.poppins(
//                             color: Colors.white,
//                             fontSize: 11,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Text(
//                     exercise.title,
//                     style: GoogleFonts.poppins(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.w700,
//                       height: 1.3,
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 6),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Text(
//                     'Speech & ASD Therapy Session',
//                     style: GoogleFonts.poppins(
//                       color: Colors.white38,
//                       fontSize: 13,
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 24),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Divider(color: Colors.white10),
//                 ),
//                 const SizedBox(height: 16),

//                 // Up next
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Text(
//                     'UP NEXT',
//                     style: GoogleFonts.poppins(
//                       color: Colors.white38,
//                       fontSize: 11,
//                       fontWeight: FontWeight.w700,
//                       letterSpacing: 1.5,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 12),

//                 Expanded(
//                   child: ListView.separated(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     itemCount: TherapyController.exercises.length,
//                     separatorBuilder: (_, __) => const SizedBox(height: 10),
//                     itemBuilder: (context, index) {
//                       final ex = TherapyController.exercises[index];
//                       final isCurrent = ex.id == exercise.id;
//                       return GestureDetector(
//                         onTap: isCurrent
//                             ? null
//                             : () {
//                                 _therapyCtrl.openVideo(ex);
//                                 _ytController.load(ex.videoUrl);
//                               },
//                         child: Container(
//                           padding: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: isCurrent
//                                 ? AppColors.primaryColor.withOpacity(0.15)
//                                 : Colors.white.withOpacity(0.05),
//                             borderRadius: BorderRadius.circular(12),
//                             border: isCurrent
//                                 ? Border.all(
//                                     color:
//                                         AppColors.primaryColor.withOpacity(0.4),
//                                     width: 1.2)
//                                 : null,
//                           ),
//                           child: Row(
//                             children: [
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(8),
//                                 child: CachedNetworkImage(
//                                   imageUrl: ex.thumbnail,
//                                   width: 64,
//                                   height: 42,
//                                   fit: BoxFit.cover,
//                                   placeholder: (_, __) => Container(
//                                     width: 64,
//                                     height: 42,
//                                     color: Colors.grey.shade800,
//                                   ),
//                                   errorWidget: (_, __, ___) => Container(
//                                     width: 64,
//                                     height: 42,
//                                     color: Colors.grey.shade800,
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(width: 12),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       ex.title,
//                                       style: GoogleFonts.poppins(
//                                         color: isCurrent
//                                             ? AppColors.primaryColor
//                                             : Colors.white,
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                       maxLines: 1,
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                     const SizedBox(height: 2),
//                                     Text(
//                                       'Exercise #${ex.id}',
//                                       style: GoogleFonts.poppins(
//                                         color: Colors.white38,
//                                         fontSize: 11,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               if (isCurrent)
//                                 Container(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 8, vertical: 3),
//                                   decoration: BoxDecoration(
//                                     color: AppColors.primaryColor,
//                                     borderRadius: BorderRadius.circular(6),
//                                   ),
//                                   child: Text(
//                                     'Playing',
//                                     style: GoogleFonts.poppins(
//                                       color: Colors.white,
//                                       fontSize: 10,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                 )
//                               else
//                                 Icon(Icons.play_circle_outline_rounded,
//                                     color: Colors.white38, size: 20),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ],
//           ),
//         );
//       },
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:youtube_player_iframe/youtube_player_iframe.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/therapy_controller.dart';

// // ─── Therapy Screen (Grid) ────────────────────────────────────────────────────

// class TherapyScreen extends StatelessWidget {
//   const TherapyScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(TherapyController());
//     final size = CustomSize();

//     return Scaffold(
//       backgroundColor: const Color(0xFFF4F6FA),
//       appBar: AppBar(
//         backgroundColor: AppColors.whiteColor,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios_new_rounded,
//               color: AppColors.textPrimaryColor, size: 20),
//           onPressed: () => Get.back(),
//         ),
//         title: Text(
//           'Therapy Exercises',
//           style: GoogleFonts.poppins(
//             color: AppColors.textPrimaryColor,
//             fontSize: 18,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(1),
//           child: Container(height: 1, color: Colors.grey.shade100),
//         ),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // ── Header banner ───────────────────────────────────────────────────
//           Container(
//             width: double.infinity,
//             padding: EdgeInsets.symmetric(
//               horizontal: size.customWidth(context) * 0.05,
//               vertical: size.customHeight(context) * 0.025,
//             ),
//             decoration: BoxDecoration(
//               color: AppColors.whiteColor,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.04),
//                   blurRadius: 8,
//                   offset: const Offset(0, 2),
//                 )
//               ],
//             ),
//             child: Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         AppColors.primaryColor,
//                         AppColors.secondaryColor,
//                       ],
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                     ),
//                     borderRadius: BorderRadius.circular(14),
//                   ),
//                   child: const Icon(Icons.play_lesson_rounded,
//                       color: Colors.white, size: 26),
//                 ),
//                 const SizedBox(width: 14),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Speech & ASD Therapy',
//                         style: GoogleFonts.poppins(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w700,
//                           color: AppColors.textPrimaryColor,
//                         ),
//                       ),
//                       Text(
//                         '${TherapyController.exercises.length} guided video exercises',
//                         style: GoogleFonts.poppins(
//                           fontSize: 12,
//                           color: AppColors.textSecondaryColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                   decoration: BoxDecoration(
//                     color: AppColors.primaryColor.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Text(
//                     'Free',
//                     style: GoogleFonts.poppins(
//                       fontSize: 11,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.primaryColor,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 16),

//           Padding(
//             padding: EdgeInsets.symmetric(
//                 horizontal: size.customWidth(context) * 0.05),
//             child: Text(
//               'Choose an Exercise',
//               style: GoogleFonts.poppins(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w600,
//                 color: AppColors.textSecondaryColor,
//                 letterSpacing: 0.3,
//               ),
//             ),
//           ),
//           const SizedBox(height: 12),

//           // ── Video card grid ─────────────────────────────────────────────────
//           Expanded(
//             child: GridView.builder(
//               padding: EdgeInsets.symmetric(
//                 horizontal: size.customWidth(context) * 0.05,
//                 vertical: 4,
//               ),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 12,
//                 mainAxisSpacing: 14,
//                 childAspectRatio: 0.82,
//               ),
//               itemCount: TherapyController.exercises.length,
//               itemBuilder: (context, index) {
//                 final ex = TherapyController.exercises[index];
//                 return _VideoCard(
//                   exercise: ex,
//                   onTap: () {
//                     controller.openVideo(ex);
//                     Get.to(
//                       () => const VideoPlayerScreen(),
//                       transition: Transition.downToUp,
//                       duration: const Duration(milliseconds: 350),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ─── Video Card ───────────────────────────────────────────────────────────────

// class _VideoCard extends StatelessWidget {
//   final TherapyExercise exercise;
//   final VoidCallback onTap;

//   const _VideoCard({required this.exercise, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(18),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.07),
//               blurRadius: 12,
//               offset: const Offset(0, 4),
//             )
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // ── Thumbnail ─────────────────────────────────
//             ClipRRect(
//               borderRadius:
//                   const BorderRadius.vertical(top: Radius.circular(18)),
//               child: Stack(
//                 children: [
//                   // Plain Image.network — no cache package needed
//                   Image.network(
//                     exercise.thumbnail,
//                     height: 110,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                     loadingBuilder: (_, child, progress) {
//                       if (progress == null) return child;
//                       return Container(
//                         height: 110,
//                         color: Colors.grey.shade200,
//                         child: Center(
//                           child: CircularProgressIndicator(
//                             strokeWidth: 2,
//                             color: AppColors.primaryColor,
//                             value: progress.expectedTotalBytes != null
//                                 ? progress.cumulativeBytesLoaded /
//                                     progress.expectedTotalBytes!
//                                 : null,
//                           ),
//                         ),
//                       );
//                     },
//                     errorBuilder: (_, __, ___) => Container(
//                       height: 110,
//                       color: Colors.grey.shade200,
//                       child: const Icon(Icons.image_not_supported,
//                           color: Colors.grey),
//                     ),
//                   ),
//                   // Gradient overlay
//                   Positioned.fill(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           begin: Alignment.topCenter,
//                           end: Alignment.bottomCenter,
//                           colors: [
//                             Colors.transparent,
//                             Colors.black.withOpacity(0.45),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   // Play button
//                   Positioned.fill(
//                     child: Center(
//                       child: Container(
//                         width: 38,
//                         height: 38,
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.92),
//                           shape: BoxShape.circle,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.2),
//                               blurRadius: 8,
//                             )
//                           ],
//                         ),
//                         child: Icon(
//                           Icons.play_arrow_rounded,
//                           color: AppColors.primaryColor,
//                           size: 24,
//                         ),
//                       ),
//                     ),
//                   ),
//                   // Episode badge
//                   Positioned(
//                     top: 8,
//                     left: 8,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 7, vertical: 3),
//                       decoration: BoxDecoration(
//                         color: AppColors.primaryColor,
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                       child: Text(
//                         '#${exercise.id}',
//                         style: GoogleFonts.poppins(
//                           color: Colors.white,
//                           fontSize: 10,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             // ── Title row ─────────────────────────────────
//             Padding(
//               padding: const EdgeInsets.fromLTRB(10, 10, 8, 10),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: Text(
//                       exercise.title,
//                       style: GoogleFonts.poppins(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w600,
//                         color: AppColors.textPrimaryColor,
//                         height: 1.35,
//                       ),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   const SizedBox(width: 4),
//                   Icon(
//                     Icons.arrow_forward_ios_rounded,
//                     size: 12,
//                     color: AppColors.primaryColor,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ─── Video Player Screen ──────────────────────────────────────────────────────

// class VideoPlayerScreen extends StatefulWidget {
//   const VideoPlayerScreen({super.key});

//   @override
//   State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
// }

// class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
//   final TherapyController _therapyCtrl = Get.find<TherapyController>();

//   @override
//   void dispose() {
//     _therapyCtrl.ytController?.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       final exercise = _therapyCtrl.currentExercise.value;
//       if (exercise == null) return const SizedBox.shrink();

//       return Scaffold(
//         backgroundColor: const Color(0xFF0D0D0D),
//         appBar: AppBar(
//           backgroundColor: const Color(0xFF0D0D0D),
//           elevation: 0,
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back_ios_new_rounded,
//                 color: Colors.white, size: 20),
//             onPressed: () => Get.back(),
//           ),
//           title: Text(
//             'Now Playing',
//             style: GoogleFonts.poppins(
//               color: Colors.white70,
//               fontSize: 14,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // ── YouTube iframe player ───────────────────────────────────────
//             if (_therapyCtrl.ytController != null)
//               YoutubePlayer(
//                 controller: _therapyCtrl.ytController!,
//                 aspectRatio: 16 / 9,
//               ),

//             const SizedBox(height: 20),

//             // ── Exercise badge ──────────────────────────────────────────────
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       AppColors.primaryColor,
//                       AppColors.secondaryColor,
//                     ],
//                   ),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Text(
//                   'Exercise #${exercise.id}',
//                   style: GoogleFonts.poppins(
//                     color: Colors.white,
//                     fontSize: 11,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 10),

//             // ── Title ───────────────────────────────────────────────────────
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Text(
//                 exercise.title,
//                 style: GoogleFonts.poppins(
//                   color: Colors.white,
//                   fontSize: 20,
//                   fontWeight: FontWeight.w700,
//                   height: 1.3,
//                 ),
//               ),
//             ),

//             const SizedBox(height: 6),

//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Text(
//                 'Speech & ASD Therapy Session',
//                 style: GoogleFonts.poppins(
//                     color: Colors.white38, fontSize: 13),
//               ),
//             ),

//             const SizedBox(height: 20),
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               child: Divider(color: Colors.white10),
//             ),
//             const SizedBox(height: 12),

//             // ── Up Next label ───────────────────────────────────────────────
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Text(
//                 'UP NEXT',
//                 style: GoogleFonts.poppins(
//                   color: Colors.white38,
//                   fontSize: 11,
//                   fontWeight: FontWeight.w700,
//                   letterSpacing: 1.5,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 12),

//             // ── Up Next list ────────────────────────────────────────────────
//             Expanded(
//               child: ListView.separated(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 itemCount: TherapyController.exercises.length,
//                 separatorBuilder: (_, __) => const SizedBox(height: 10),
//                 itemBuilder: (context, index) {
//                   final ex = TherapyController.exercises[index];
//                   final isCurrent = ex.id == exercise.id;

//                   return GestureDetector(
//                     onTap: isCurrent
//                         ? null
//                         : () => _therapyCtrl.switchVideo(ex),
//                     child: Container(
//                       padding: const EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         color: isCurrent
//                             ? AppColors.primaryColor.withOpacity(0.15)
//                             : Colors.white.withOpacity(0.05),
//                         borderRadius: BorderRadius.circular(12),
//                         border: isCurrent
//                             ? Border.all(
//                                 color: AppColors.primaryColor.withOpacity(0.4),
//                                 width: 1.2,
//                               )
//                             : null,
//                       ),
//                       child: Row(
//                         children: [
//                           // Thumbnail — plain Image.network
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(8),
//                             child: Image.network(
//                               ex.thumbnail,
//                               width: 64,
//                               height: 42,
//                               fit: BoxFit.cover,
//                               loadingBuilder: (_, child, progress) {
//                                 if (progress == null) return child;
//                                 return Container(
//                                   width: 64,
//                                   height: 42,
//                                   color: Colors.grey.shade800,
//                                 );
//                               },
//                               errorBuilder: (_, __, ___) => Container(
//                                 width: 64,
//                                 height: 42,
//                                 color: Colors.grey.shade800,
//                                 child: const Icon(Icons.broken_image,
//                                     color: Colors.grey, size: 18),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 12),

//                           // Title & number
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   ex.title,
//                                   style: GoogleFonts.poppins(
//                                     color: isCurrent
//                                         ? AppColors.primaryColor
//                                         : Colors.white,
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                                 const SizedBox(height: 2),
//                                 Text(
//                                   'Exercise #${ex.id}',
//                                   style: GoogleFonts.poppins(
//                                     color: Colors.white38,
//                                     fontSize: 11,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),

//                           // Playing badge or play icon
//                           if (isCurrent)
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 8, vertical: 3),
//                               decoration: BoxDecoration(
//                                 color: AppColors.primaryColor,
//                                 borderRadius: BorderRadius.circular(6),
//                               ),
//                               child: Text(
//                                 'Playing',
//                                 style: GoogleFonts.poppins(
//                                   color: Colors.white,
//                                   fontSize: 10,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             )
//                           else
//                             const Icon(Icons.play_circle_outline_rounded,
//                                 color: Colors.white38, size: 20),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       );
//     });
//   }
// }


// ============================================================
// therapy_screen.dart  —  Speech Spectrum
// Fix: Videos that block iframe embedding are now opened
//      directly in YouTube (browser / YouTube app) using
//      url_launcher.  Tap a card → YouTube opens the video.
//
// pubspec.yaml dependency to add:
//   url_launcher: ^6.3.0
// ============================================================

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

// ─── Model ────────────────────────────────────────────────────────────────────

class TherapyExercise {
  final String id;
  final String title;
  final String videoId; // YouTube video ID only
  final String thumbnail;

  const TherapyExercise({
    required this.id,
    required this.title,
    required this.videoId,
    required this.thumbnail,
  });

  /// Full YouTube watch URL
  String get youtubeUrl => 'https://www.youtube.com/watch?v=$videoId';
}

// ─── Controller ───────────────────────────────────────────────────────────────

class TherapyController extends GetxController {
  static const List<TherapyExercise> exercises = [
    TherapyExercise(
      id: '1',
      title: 'First Words & Songs',
      videoId: 'nXzvYnkXQNI',
      thumbnail: 'https://img.youtube.com/vi/nXzvYnkXQNI/mqdefault.jpg',
    ),
    TherapyExercise(
      id: '2',
      title: 'Brain & Finger Warmup',
      videoId: '4o1iRDFm8Ww',
      thumbnail: 'https://img.youtube.com/vi/4o1iRDFm8Ww/mqdefault.jpg',
    ),
    TherapyExercise(
      id: '3',
      title: 'Gesture Development',
      videoId: 'pTLtcno5_cY',
      thumbnail: 'https://img.youtube.com/vi/pTLtcno5_cY/mqdefault.jpg',
    ),
    TherapyExercise(
      id: '4',
      title: 'Simple Greeting Routine',
      videoId: 'fN1Cyr0ZK9M',
      thumbnail: 'https://img.youtube.com/vi/fN1Cyr0ZK9M/mqdefault.jpg',
    ),
    TherapyExercise(
      id: '5',
      title: 'Articulate Clearer Sounds',
      videoId: 'R_fxJMHZ8ic',
      thumbnail: 'https://img.youtube.com/vi/R_fxJMHZ8ic/mqdefault.jpg',
    ),
    TherapyExercise(
      id: '6',
      title: 'Eye Contact Game',
      videoId: '0hAF2FGdNwQ',
      thumbnail: 'https://img.youtube.com/vi/0hAF2FGdNwQ/mqdefault.jpg',
    ),
    TherapyExercise(
      id: '7',
      title: 'Object Naming: Toy Box',
      videoId: '37qPEWQMQa4',
      thumbnail: 'https://img.youtube.com/vi/37qPEWQMQa4/mqdefault.jpg',
    ),
    TherapyExercise(
      id: '8',
      title: 'Focus & Attention Drill',
      videoId: '5he1sCixSLM',
      thumbnail: 'https://img.youtube.com/vi/5he1sCixSLM/mqdefault.jpg',
    ),
    TherapyExercise(
      id: '9',
      title: 'Simple Body Parts',
      videoId: 'SUt8q0EKbms',
      thumbnail: 'https://img.youtube.com/vi/SUt8q0EKbms/mqdefault.jpg',
    ),
    TherapyExercise(
      id: '10',
      title: 'Alphabet Puzzle Solve',
      videoId: 'D7Bg0KS1mz8',
      thumbnail: 'https://img.youtube.com/vi/D7Bg0KS1mz8/mqdefault.jpg',
    ),
    TherapyExercise(
      id: '11',
      title: 'Action Verbs & Songs',
      videoId: 'pSGVb60-BSw',
      thumbnail: 'https://img.youtube.com/vi/pSGVb60-BSw/mqdefault.jpg',
    ),
    TherapyExercise(
      id: '12',
      title: 'Interactive Animal Play',
      videoId: '4Talws29mys',
      thumbnail: 'https://img.youtube.com/vi/4Talws29mys/mqdefault.jpg',
    ),
  ];

  /// Opens the YouTube video in the YouTube app or browser.
  Future<void> openVideo(TherapyExercise exercise) async {
    final Uri uri = Uri.parse(exercise.youtubeUrl);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      Get.snackbar(
        'Error',
        'Could not open video. Please check your internet connection.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade700,
        colorText: Colors.white,
      );
    }
  }
}

// ─── Therapy Screen ────────────────────────────────────────────────────────────

class TherapyScreen extends StatelessWidget {
  const TherapyScreen({super.key});

  // Soft brand colours (replace with your AppColors if preferred)
  static const Color _primary = Color(0xFF4F6AF5);
  static const Color _secondary = Color(0xFF7B92FF);
  static const Color _bg = Color(0xFFF4F6FA);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TherapyController());

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.black12,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Color(0xFF1E2340), size: 20),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Therapy Exercises',
          style: GoogleFonts.poppins(
            color: const Color(0xFF1E2340),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: Colors.grey.shade100),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header banner ─────────────────────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            color: Colors.white,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [_primary, _secondary],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.play_lesson_rounded,
                      color: Colors.white, size: 26),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Speech & ASD Therapy',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1E2340),
                        ),
                      ),
                      Text(
                        '${TherapyController.exercises.length} guided video exercises',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: _primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Free',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: _primary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Choose an Exercise',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF6B7280),
                letterSpacing: 0.3,
              ),
            ),
          ),
          const SizedBox(height: 12),

          // ── Tip banner ────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFA5D6A7)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.open_in_new_rounded,
                      size: 16, color: Color(0xFF2E7D32)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Videos open in YouTube app for the best experience.',
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF2E7D32),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // ── Video card grid ───────────────────────────────────────────────
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 14,
                childAspectRatio: 0.82,
              ),
              itemCount: TherapyController.exercises.length,
              itemBuilder: (context, index) {
                final ex = TherapyController.exercises[index];
                return _VideoCard(
                  exercise: ex,
                  onTap: () => controller.openVideo(ex),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Video Card ───────────────────────────────────────────────────────────────

class _VideoCard extends StatelessWidget {
  final TherapyExercise exercise;
  final VoidCallback onTap;

  static const Color _primary = Color(0xFF4F6AF5);

  const _VideoCard({required this.exercise, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 12,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Thumbnail ──────────────────────────────────
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(18)),
              child: Stack(
                children: [
                  Image.network(
                    exercise.thumbnail,
                    height: 110,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (_, child, progress) {
                      if (progress == null) return child;
                      return Container(
                        height: 110,
                        color: Colors.grey.shade200,
                        child: Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: _primary,
                            value: progress.expectedTotalBytes != null
                                ? progress.cumulativeBytesLoaded /
                                    progress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (_, __, ___) => Container(
                      height: 110,
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.image_not_supported,
                          color: Colors.grey),
                    ),
                  ),
                  // Gradient overlay
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.45),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // YouTube-style play button
                  Positioned.fill(
                    child: Center(
                      child: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: Colors.red.shade600,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 8,
                            )
                          ],
                        ),
                        child: const Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                    ),
                  ),
                  // Episode badge
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 3),
                      decoration: BoxDecoration(
                        color: _primary,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '#${exercise.id}',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  // "Opens in YouTube" pill at bottom-right
                  Positioned(
                    bottom: 6,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.open_in_new,
                              color: Colors.white, size: 9),
                          const SizedBox(width: 3),
                          Text(
                            'YouTube',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Title row ──────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 8, 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      exercise.title,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1E2340),
                        height: 1.35,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 12,
                    color: _primary,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}