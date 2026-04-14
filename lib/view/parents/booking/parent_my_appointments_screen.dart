// // lib/view/parent/booking/parent_my_appointments_screen.dart
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/parent_booking_controller.dart';
// import 'package:speechspectrum/models/my_appointment_model.dart';
// import 'package:speechspectrum/routes/app_routes.dart';

// class ParentMyAppointmentsScreen extends StatefulWidget {
//   const ParentMyAppointmentsScreen({super.key});

//   @override
//   State<ParentMyAppointmentsScreen> createState() =>
//       _ParentMyAppointmentsScreenState();
// }

// class _ParentMyAppointmentsScreenState
//     extends State<ParentMyAppointmentsScreen>
//     with SingleTickerProviderStateMixin {
//   late final ParentBookingController _c;
//   late final TabController _tab;

//   static const _tabs = [
//     ('All', Icons.list_alt_rounded),
//     ('Scheduled', Icons.schedule_rounded),
//     ('Confirmed', Icons.check_circle_outline_rounded),
//     ('Completed', Icons.task_alt_rounded),
//     ('Cancelled', Icons.cancel_outlined),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _tab = TabController(length: _tabs.length, vsync: this);
//     _c = Get.isRegistered<ParentBookingController>()
//         ? Get.find<ParentBookingController>()
//         : Get.put(ParentBookingController());
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _c.fetchMyAppointments();
//     });
//   }

//   @override
//   void dispose() {
//     _tab.dispose();
//     super.dispose();
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
//         title: Text('My Appointments',
//             style: GoogleFonts.poppins(
//                 color: AppColors.textPrimaryColor,
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600)),
//         actions: [
//           Obx(() => _c.isLoadingAppointments.value
//               ? const Padding(
//                   padding: EdgeInsets.all(16),
//                   child: SizedBox(
//                       width: 20,
//                       height: 20,
//                       child: CircularProgressIndicator(
//                           color: AppColors.primaryColor, strokeWidth: 2)))
//               : IconButton(
//                   icon: const Icon(Icons.refresh_rounded,
//                       color: AppColors.primaryColor),
//                   onPressed: _c.fetchMyAppointments)),
//           const SizedBox(width: 4),
//         ],
//         bottom: TabBar(
//           controller: _tab,
//           isScrollable: true,
//           tabAlignment: TabAlignment.start,
//           labelColor: AppColors.primaryColor,
//           unselectedLabelColor: AppColors.textSecondaryColor,
//           indicatorColor: AppColors.primaryColor,
//           indicatorWeight: 2.5,
//           labelPadding:
//               const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
//           labelStyle: GoogleFonts.poppins(
//               fontWeight: FontWeight.w600, fontSize: 13),
//           unselectedLabelStyle: GoogleFonts.poppins(
//               fontWeight: FontWeight.w500, fontSize: 13),
//           tabs: _tabs
//               .map((t) => Tab(
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Icon(t.$2, size: 14),
//                         const SizedBox(width: 5),
//                         Text(t.$1),
//                       ],
//                     ),
//                   ))
//               .toList(),
//         ),
//       ),
//       body: Obx(() {
//         if (_c.isLoadingAppointments.value &&
//             _c.myAppointments.isEmpty) {
//           return _loader(context, size);
//         }
//         return TabBarView(
//           controller: _tab,
//           children: [
//             _list(context, size, _c.myAppointments),
//             _list(context, size, _c.scheduledList),
//             _list(context, size, _c.confirmedList),
//             _list(context, size, _c.completedList),
//             _list(context, size, _c.cancelledList),
//           ],
//         );
//       }),
//     );
//   }

//   Widget _list(BuildContext context, CustomSize size,
//       List<MyAppointmentItem> items) {
//     if (items.isEmpty) return _empty(context, size);
//     return RefreshIndicator(
//       color: AppColors.primaryColor,
//       onRefresh: _c.fetchMyAppointments,
//       child: ListView.builder(
//         padding: EdgeInsets.fromLTRB(
//           size.customWidth(context) * 0.045,
//           size.customHeight(context) * 0.02,
//           size.customWidth(context) * 0.045,
//           size.customHeight(context) * 0.04,
//         ),
//         itemCount: items.length,
//         itemBuilder: (_, i) => _card(context, size, items[i]),
//       ),
//     );
//   }

//   Widget _card(
//       BuildContext context, CustomSize size, MyAppointmentItem appt) {
//     final meta = _statusMeta(appt.status);

//     return GestureDetector(
//       onTap: () => Get.toNamed(
//         AppRoutes.parentAppointmentDetail,
//         arguments: appt.appointmentId,
//       ),
//       child: Container(
//         margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.016),
//         decoration: BoxDecoration(
//           color: AppColors.whiteColor,
//           borderRadius: BorderRadius.circular(20),
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
//                 color: meta.color,
//                 borderRadius: const BorderRadius.vertical(
//                     top: Radius.circular(20)),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(size.customWidth(context) * 0.042),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Avatar
//                       Container(
//                         width: 50,
//                         height: 50,
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [
//                               AppColors.primaryColor.withOpacity(0.7),
//                               AppColors.primaryColor
//                             ],
//                           ),
//                           borderRadius: BorderRadius.circular(14),
//                         ),
//                         child: Center(
//                           child: Text(appt.childInitials,
//                               style: GoogleFonts.poppins(
//                                   color: Colors.white,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold)),
//                         ),
//                       ),
//                       SizedBox(width: size.customWidth(context) * 0.03),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               appt.children?.childName ?? 'Child',
//                               style: GoogleFonts.poppins(
//                                   fontSize:
//                                       size.customWidth(context) * 0.04,
//                                   fontWeight: FontWeight.w700,
//                                   color: AppColors.textPrimaryColor),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                             Text(
//                               appt.expertUsers?.fullName ?? '',
//                               style: GoogleFonts.poppins(
//                                   fontSize:
//                                       size.customWidth(context) * 0.031,
//                                   color: AppColors.primaryColor,
//                                   fontWeight: FontWeight.w500),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 10, vertical: 4),
//                         decoration: BoxDecoration(
//                           color: meta.color.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Text(meta.label,
//                             style: GoogleFonts.poppins(
//                                 fontSize: 10,
//                                 fontWeight: FontWeight.w600,
//                                 color: meta.color)),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: size.customHeight(context) * 0.012),
//                   Divider(
//                       height: 1,
//                       color: AppColors.greyColor.withOpacity(0.15)),
//                   SizedBox(height: size.customHeight(context) * 0.01),
//                   Wrap(
//                     spacing: 14,
//                     runSpacing: 6,
//                     children: [
//                       _chip2(Icons.calendar_today_outlined,
//                           appt.formattedDate, AppColors.primaryColor),
//                       _chip2(Icons.access_time_rounded,
//                           appt.formattedTime, AppColors.secondaryColor),
//                       _chip2(_modeIcon(appt.bookedMode),
//                           appt.bookedMode[0].toUpperCase() +
//                               appt.bookedMode.substring(1),
//                           AppColors.accentColor),
//                       _chip2(
//                           Icons.payments_outlined,
//                           '${appt.currency} ${appt.feeCharged.toStringAsFixed(0)}',
//                           AppColors.warningColor),
//                     ],
//                   ),
//                   // Meet link
//                   if (appt.meetLink != null &&
//                       appt.meetLink!.isNotEmpty) ...[
//                     SizedBox(height: size.customHeight(context) * 0.01),
//                     _meetLinkBanner(context, size, appt.meetLink!),
//                   ],
//                   // Cancellation
//                   if (appt.isCancelled &&
//                       appt.cancellationReason != null) ...[
//                     SizedBox(height: size.customHeight(context) * 0.01),
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 10, vertical: 7),
//                       decoration: BoxDecoration(
//                         color: AppColors.errorColor.withOpacity(0.06),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Row(children: [
//                         const Icon(Icons.info_outline_rounded,
//                             size: 13, color: AppColors.errorColor),
//                         const SizedBox(width: 6),
//                         Expanded(
//                           child: Text(appt.cancellationReason!,
//                               style: GoogleFonts.poppins(
//                                   fontSize: 12,
//                                   color: AppColors.errorColor),
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis),
//                         ),
//                       ]),
//                     ),
//                   ],
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _meetLinkBanner(
//       BuildContext context, CustomSize size, String url) {
//     return GestureDetector(
//       onTap: () async {
//         final uri = Uri.tryParse(url);
//         if (uri != null && await canLaunchUrl(uri)) {
//           await launchUrl(uri, mode: LaunchMode.externalApplication);
//         }
//       },
//       child: Container(
//         padding:
//             const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         decoration: BoxDecoration(
//           color: const Color(0xFF2196F3).withOpacity(0.07),
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//               color: const Color(0xFF2196F3).withOpacity(0.3),
//               width: 1),
//         ),
//         child: Row(
//           children: [
//             const Icon(Icons.videocam_rounded,
//                 color: Color(0xFF2196F3), size: 18),
//             const SizedBox(width: 8),
//             Expanded(
//               child: Text(
//                 'Join Meeting',
//                 style: GoogleFonts.poppins(
//                     fontSize: 13,
//                     color: const Color(0xFF2196F3),
//                     fontWeight: FontWeight.w600),
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 Clipboard.setData(ClipboardData(text: url));
//                 Get.snackbar('Copied', 'Meeting link copied',
//                     snackPosition: SnackPosition.BOTTOM,
//                     backgroundColor: AppColors.textPrimaryColor,
//                     colorText: Colors.white,
//                     margin: const EdgeInsets.all(16),
//                     borderRadius: 12,
//                     duration: const Duration(seconds: 2));
//               },
//               child: const Icon(Icons.copy_outlined,
//                   size: 15, color: Color(0xFF2196F3)),
//             ),
//             const SizedBox(width: 4),
//             const Icon(Icons.open_in_new_rounded,
//                 size: 15, color: Color(0xFF2196F3)),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _chip2(IconData icon, String label, Color color) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Icon(icon, size: 13, color: color),
//         const SizedBox(width: 4),
//         Text(label,
//             style: GoogleFonts.poppins(
//                 fontSize: 12,
//                 color: AppColors.textSecondaryColor,
//                 fontWeight: FontWeight.w500)),
//       ],
//     );
//   }

//   Widget _loader(BuildContext context, CustomSize size) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const CircularProgressIndicator(
//               color: AppColors.primaryColor, strokeWidth: 3),
//           SizedBox(height: size.customHeight(context) * 0.02),
//           Text('Loading appointments...',
//               style: GoogleFonts.poppins(
//                   color: AppColors.textSecondaryColor,
//                   fontSize: size.customWidth(context) * 0.036)),
//         ],
//       ),
//     );
//   }

//   Widget _empty(BuildContext context, CustomSize size) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             width: 110,
//             height: 110,
//             decoration: BoxDecoration(
//                 color: AppColors.primaryColor.withOpacity(0.07),
//                 shape: BoxShape.circle),
//             child: const Icon(Icons.event_busy_outlined,
//                 size: 52, color: AppColors.primaryColor),
//           ),
//           SizedBox(height: size.customHeight(context) * 0.025),
//           Text('No appointments here',
//               style: GoogleFonts.poppins(
//                   fontSize: size.customWidth(context) * 0.044,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.textPrimaryColor)),
//           SizedBox(height: size.customHeight(context) * 0.008),
//           Text('Nothing in this category',
//               style: GoogleFonts.poppins(
//                   fontSize: size.customWidth(context) * 0.033,
//                   color: AppColors.textSecondaryColor)),
//         ],
//       ),
//     );
//   }

//   _StatusMeta _statusMeta(String status) {
//     switch (status.toLowerCase()) {
//       case 'confirmed':
//         return _StatusMeta(AppColors.primaryColor, 'Confirmed');
//       case 'completed':
//         return _StatusMeta(AppColors.successColor, 'Completed');
//       case 'cancelled':
//         return _StatusMeta(AppColors.errorColor, 'Cancelled');
//       case 'no_show':
//         return _StatusMeta(AppColors.greyColor, 'No Show');
//       default:
//         return _StatusMeta(AppColors.warningColor, 'Scheduled');
//     }
//   }

//   IconData _modeIcon(String mode) {
//     switch (mode.toLowerCase()) {
//       case 'online':
//         return Icons.videocam_outlined;
//       case 'physical':
//         return Icons.location_on_outlined;
//       default:
//         return Icons.swap_horiz_rounded;
//     }
//   }
// }

// class _StatusMeta {
//   final Color color;
//   final String label;
//   _StatusMeta(this.color, this.label);
// }

// // ═══════════════════════════════════════════════════════════════
// //   Parent Appointment Detail Screen
// // ═══════════════════════════════════════════════════════════════
// class ParentAppointmentDetailScreen extends StatefulWidget {
//   const ParentAppointmentDetailScreen({super.key});

//   @override
//   State<ParentAppointmentDetailScreen> createState() =>
//       _ParentAppointmentDetailScreenState();
// }

// class _ParentAppointmentDetailScreenState
//     extends State<ParentAppointmentDetailScreen> {
//   late final ParentBookingController _c;
//   late final String _appointmentId;

//   @override
//   void initState() {
//     super.initState();
//     _c = Get.find<ParentBookingController>();
//     _appointmentId = Get.arguments as String;
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _c.fetchAppointmentDetail(_appointmentId);
//       _c.fetchAppointmentRecords(_appointmentId);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();

//     return Scaffold(
//       backgroundColor: AppColors.lightGreyColor,
//       body: Obx(() {
//         if (_c.isLoadingDetail.value) return _loader();
//         final appt = _c.selectedAppointment.value;
//         if (appt == null) return _error();
//         return _content(context, size, appt);
//       }),
//     );
//   }

//   Widget _content(
//       BuildContext context, CustomSize size, MyAppointmentItem appt) {
//     final meta = _statusMeta(appt.status);

//     return CustomScrollView(
//       slivers: [
//         SliverAppBar(
//           expandedHeight: size.customHeight(context) * 0.24,
//           pinned: true,
//           backgroundColor: AppColors.primaryColor,
//           surfaceTintColor: Colors.transparent,
//           leading: GestureDetector(
//             onTap: () => Get.back(),
//             child: Container(
//               margin: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.15),
//                   borderRadius: BorderRadius.circular(12)),
//               child: const Icon(Icons.arrow_back_ios_new_rounded,
//                   color: Colors.white, size: 18),
//             ),
//           ),
//           flexibleSpace: FlexibleSpaceBar(
//             background: Container(
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [AppColors.primaryColor, AppColors.secondaryColor],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//               ),
//               child: SafeArea(
//                 child: Padding(
//                   padding: EdgeInsets.fromLTRB(
//                     size.customWidth(context) * 0.05,
//                     size.customHeight(context) * 0.06,
//                     size.customWidth(context) * 0.05,
//                     16,
//                   ),
//                   child: Row(
//                     children: [
//                       Container(
//                         width: 64,
//                         height: 64,
//                         decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.2),
//                             borderRadius: BorderRadius.circular(18)),
//                         child: Center(
//                           child: Text(appt.childInitials,
//                               style: GoogleFonts.poppins(
//                                   color: Colors.white,
//                                   fontSize: 24,
//                                   fontWeight: FontWeight.bold)),
//                         ),
//                       ),
//                       SizedBox(width: size.customWidth(context) * 0.04),
//                       Expanded(
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               appt.children?.childName ?? 'Unknown',
//                               style: GoogleFonts.poppins(
//                                   color: Colors.white,
//                                   fontSize:
//                                       size.customWidth(context) * 0.044,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             Text(
//                               appt.expertUsers?.fullName ?? '',
//                               style: GoogleFonts.poppins(
//                                   color: Colors.white.withOpacity(0.85),
//                                   fontSize:
//                                       size.customWidth(context) * 0.031),
//                             ),
//                             const SizedBox(height: 6),
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 12, vertical: 4),
//                               decoration: BoxDecoration(
//                                 color: meta.color.withOpacity(0.2),
//                                 borderRadius: BorderRadius.circular(20),
//                                 border: Border.all(
//                                     color: Colors.white.withOpacity(0.4)),
//                               ),
//                               child: Text(meta.label,
//                                   style: GoogleFonts.poppins(
//                                       color: Colors.white,
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w600)),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),

//         SliverPadding(
//           padding: EdgeInsets.fromLTRB(
//             size.customWidth(context) * 0.045,
//             size.customHeight(context) * 0.02,
//             size.customWidth(context) * 0.045,
//             size.customHeight(context) * 0.06,
//           ),
//           sliver: SliverList(
//             delegate: SliverChildListDelegate([
//               // Meet link prominent banner
//               if (appt.meetLink != null && appt.meetLink!.isNotEmpty) ...[
//                 _meetLinkCard(context, size, appt.meetLink!),
//                 SizedBox(height: size.customHeight(context) * 0.018),
//               ],

//               // Appointment details card
//               _detailCard(context, size, appt),
//               SizedBox(height: size.customHeight(context) * 0.018),

//               // Slot info
//               if (appt.appointmentSlots != null) ...[
//                 _slotCard(context, size, appt.appointmentSlots!),
//                 SizedBox(height: size.customHeight(context) * 0.018),
//               ],

//               // Expert info
//               if (appt.expertUsers != null) ...[
//                 _expertCard(context, size, appt.expertUsers!),
//                 SizedBox(height: size.customHeight(context) * 0.018),
//               ],

//               // Cancellation
//               if (appt.isCancelled) ...[
//                 _cancellationCard(context, size, appt),
//                 SizedBox(height: size.customHeight(context) * 0.018),
//               ],

//               // Session records
//               _recordsSection(context, size),
//               SizedBox(height: size.customHeight(context) * 0.04),
//             ]),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _meetLinkCard(
//       BuildContext context, CustomSize size, String url) {
//     return GestureDetector(
//       onTap: () async {
//         final uri = Uri.tryParse(url);
//         if (uri != null && await canLaunchUrl(uri)) {
//           await launchUrl(uri, mode: LaunchMode.externalApplication);
//         }
//       },
//       child: Container(
//         padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               const Color(0xFF2196F3),
//               const Color(0xFF1565C0),
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(18),
//           boxShadow: [
//             BoxShadow(
//                 color: const Color(0xFF2196F3).withOpacity(0.3),
//                 blurRadius: 14,
//                 offset: const Offset(0, 4))
//           ],
//         ),
//         child: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.2),
//                   borderRadius: BorderRadius.circular(12)),
//               child: const Icon(Icons.videocam_rounded,
//                   color: Colors.white, size: 24),
//             ),
//             SizedBox(width: size.customWidth(context) * 0.035),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Join Meeting',
//                       style: GoogleFonts.poppins(
//                           color: Colors.white,
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold)),
//                   Text('Tap to open Zoom meeting',
//                       style: GoogleFonts.poppins(
//                           color: Colors.white.withOpacity(0.8),
//                           fontSize: 12)),
//                 ],
//               ),
//             ),
//             Row(
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     Clipboard.setData(ClipboardData(text: url));
//                     Get.snackbar('Copied', 'Meeting link copied',
//                         snackPosition: SnackPosition.BOTTOM,
//                         backgroundColor: AppColors.textPrimaryColor,
//                         colorText: Colors.white,
//                         margin: const EdgeInsets.all(16),
//                         borderRadius: 12,
//                         duration: const Duration(seconds: 2));
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.15),
//                         borderRadius: BorderRadius.circular(8)),
//                     child: const Icon(Icons.copy_outlined,
//                         color: Colors.white, size: 16),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 const Icon(Icons.open_in_new_rounded,
//                     color: Colors.white, size: 20),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _detailCard(
//       BuildContext context, CustomSize size, MyAppointmentItem appt) {
//     return _card(context, size,
//         title: 'Appointment Details',
//         icon: Icons.event_note_rounded,
//         children: [
//           _row(context, size, 'Date', appt.formattedDate,
//               Icons.calendar_today_outlined),
//           _row(context, size, 'Time', appt.formattedTime,
//               Icons.access_time_rounded),
//           _row(context, size, 'Duration', '${appt.durationMinutes} min',
//               Icons.timer_outlined),
//           _row(context, size, 'Mode',
//               appt.bookedMode[0].toUpperCase() + appt.bookedMode.substring(1),
//               _modeIcon(appt.bookedMode)),
//           _row(context, size, 'Fee',
//               '${appt.currency} ${appt.feeCharged.toStringAsFixed(0)}',
//               Icons.payments_outlined),
//         ]);
//   }

//   Widget _slotCard(
//       BuildContext context, CustomSize size, AppointmentSlot slot) {
//     return _card(context, size,
//         title: 'Slot Information',
//         icon: Icons.calendar_month_rounded,
//         children: [
//           _row(context, size, 'Slot Date', slot.slotDate,
//               Icons.today_rounded),
//           _row(context, size, 'Slot Time',
//               '${slot.formattedStart} – ${slot.formattedEnd}',
//               Icons.schedule_rounded),
//           _row(context, size, 'Slot Mode',
//               slot.mode[0].toUpperCase() + slot.mode.substring(1),
//               _modeIcon(slot.mode)),
//         ]);
//   }

//   Widget _expertCard(
//       BuildContext context, CustomSize size, AppointmentExpert expert) {
//     return _card(context, size,
//         title: 'Expert Information',
//         icon: Icons.person_outline_rounded,
//         children: [
//           _row(context, size, 'Name', expert.fullName,
//               Icons.badge_outlined),
//           _row(context, size, 'Specialization', expert.specialization,
//               Icons.medical_information_outlined),
//           if (expert.phone != null)
//             _rowTappable(context, size, 'Phone', expert.phone!,
//                 Icons.phone_outlined, () async {
//               final uri = Uri(scheme: 'tel', path: expert.phone);
//               if (await canLaunchUrl(uri)) await launchUrl(uri);
//             }),
//           if (expert.contactEmail != null)
//             _rowTappable(context, size, 'Email', expert.contactEmail!,
//                 Icons.email_outlined, () async {
//               final uri = Uri(scheme: 'mailto', path: expert.contactEmail);
//               if (await canLaunchUrl(uri)) await launchUrl(uri);
//             }),
//         ]);
//   }

//   Widget _cancellationCard(
//       BuildContext context, CustomSize size, MyAppointmentItem appt) {
//     return Container(
//       padding: EdgeInsets.all(size.customWidth(context) * 0.045),
//       decoration: BoxDecoration(
//         color: AppColors.errorColor.withOpacity(0.05),
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(color: AppColors.errorColor.withOpacity(0.2)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(children: [
//             const Icon(Icons.cancel_outlined,
//                 color: AppColors.errorColor, size: 18),
//             const SizedBox(width: 8),
//             Text('Cancellation Info',
//                 style: GoogleFonts.poppins(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.errorColor)),
//           ]),
//           const SizedBox(height: 12),
//           if (appt.cancelledBy != null)
//             _row(context, size, 'By',
//                 appt.cancelledBy![0].toUpperCase() +
//                     appt.cancelledBy!.substring(1),
//                 Icons.person_outlined),
//           if (appt.cancellationReason != null)
//             _row(context, size, 'Reason', appt.cancellationReason!,
//                 Icons.info_outline_rounded),
//         ],
//       ),
//     );
//   }

//   Widget _recordsSection(BuildContext context, CustomSize size) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(children: [
//           Container(
//               width: 4,
//               height: 20,
//               decoration: BoxDecoration(
//                   color: AppColors.primaryColor,
//                   borderRadius: BorderRadius.circular(2))),
//           const SizedBox(width: 10),
//           Text('Session Records',
//               style: GoogleFonts.poppins(
//                   fontSize: size.customWidth(context) * 0.042,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.textPrimaryColor)),
//         ]),
//         SizedBox(height: size.customHeight(context) * 0.015),
//         Obx(() {
//           if (_c.isLoadingRecords.value) {
//             return const Center(
//                 child: Padding(
//               padding: EdgeInsets.all(24),
//               child: CircularProgressIndicator(
//                   color: AppColors.primaryColor, strokeWidth: 2),
//             ));
//           }
//           if (_c.appointmentRecords.isEmpty) {
//             return Container(
//               padding: const EdgeInsets.all(24),
//               decoration: BoxDecoration(
//                 color: AppColors.whiteColor,
//                 borderRadius: BorderRadius.circular(18),
//                 boxShadow: [
//                   BoxShadow(
//                       color: Colors.black.withOpacity(0.04),
//                       blurRadius: 8,
//                       offset: const Offset(0, 2))
//                 ],
//               ),
//               child: Center(
//                 child: Column(
//                   children: [
//                     Icon(Icons.note_outlined,
//                         size: 40,
//                         color: AppColors.textSecondaryColor
//                             .withOpacity(0.4)),
//                     const SizedBox(height: 10),
//                     Text('No session records yet',
//                         style: GoogleFonts.poppins(
//                             fontSize: 13,
//                             color: AppColors.textSecondaryColor)),
//                   ],
//                 ),
//               ),
//             );
//           }
//           return Column(
//             children: _c.appointmentRecords
//                 .map((r) => _recordCard(context, size, r))
//                 .toList(),
//           );
//         }),
//       ],
//     );
//   }

//   Widget _recordCard(BuildContext context, CustomSize size,
//       AppointmentRecordItem record) {
//     return Container(
//       margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.014),
//       padding: EdgeInsets.all(size.customWidth(context) * 0.042),
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(18),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 10,
//               offset: const Offset(0, 3))
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                       color: AppColors.primaryColor.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(10)),
//                   child: const Icon(Icons.description_outlined,
//                       color: AppColors.primaryColor, size: 18)),
//               const SizedBox(width: 10),
//               Text('Session Note',
//                   style: GoogleFonts.poppins(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.textPrimaryColor)),
//               const Spacer(),
//               Text(record.formattedDate,
//                   style: GoogleFonts.poppins(
//                       fontSize: 11,
//                       color: AppColors.textSecondaryColor)),
//             ],
//           ),
//           SizedBox(height: size.customHeight(context) * 0.012),
//           Divider(
//               height: 1, color: AppColors.greyColor.withOpacity(0.15)),
//           SizedBox(height: size.customHeight(context) * 0.012),
//           _recordField('Notes', record.notes, Icons.notes_rounded),
//           SizedBox(height: size.customHeight(context) * 0.008),
//           _recordField('Therapy Plan', record.therapyPlan,
//               Icons.health_and_safety_outlined),
//           SizedBox(height: size.customHeight(context) * 0.008),
//           _recordField('Progress', record.progressFeedback,
//               Icons.trending_up_rounded),
//           if (record.medication != null) ...[
//             SizedBox(height: size.customHeight(context) * 0.008),
//             _recordField(
//                 'Medication',
//                 record.medication!['name'] ?? 'None',
//                 Icons.medication_outlined),
//           ],
//         ],
//       ),
//     );
//   }

//   Widget _recordField(String label, String value, IconData icon) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Icon(icon,
//             size: 14,
//             color: AppColors.primaryColor.withOpacity(0.7)),
//         const SizedBox(width: 8),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(label,
//                   style: GoogleFonts.poppins(
//                       fontSize: 11,
//                       color: AppColors.textSecondaryColor,
//                       fontWeight: FontWeight.w500)),
//               Text(value,
//                   style: GoogleFonts.poppins(
//                       fontSize: 13,
//                       color: AppColors.textPrimaryColor)),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _card(BuildContext context, CustomSize size,
//       {required String title,
//       required IconData icon,
//       required List<Widget> children}) {
//     return Container(
//       padding: EdgeInsets.all(size.customWidth(context) * 0.045),
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(18),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 10,
//               offset: const Offset(0, 3))
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(children: [
//             Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                     color: AppColors.primaryColor.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(10)),
//                 child: Icon(icon,
//                     color: AppColors.primaryColor, size: 18)),
//             const SizedBox(width: 10),
//             Text(title,
//                 style: GoogleFonts.poppins(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.textPrimaryColor)),
//           ]),
//           SizedBox(height: size.customHeight(context) * 0.014),
//           Divider(
//               height: 1, color: AppColors.greyColor.withOpacity(0.15)),
//           SizedBox(height: size.customHeight(context) * 0.012),
//           ...children,
//         ],
//       ),
//     );
//   }

//   Widget _row(BuildContext context, CustomSize size, String label,
//       String value, IconData icon) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: size.customHeight(context) * 0.01),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, size: 14, color: AppColors.textSecondaryColor),
//           const SizedBox(width: 10),
//           SizedBox(
//             width: size.customWidth(context) * 0.22,
//             child: Text(label,
//                 style: GoogleFonts.poppins(
//                     fontSize: 12,
//                     color: AppColors.textSecondaryColor,
//                     fontWeight: FontWeight.w500)),
//           ),
//           Expanded(
//             child: Text(value,
//                 style: GoogleFonts.poppins(
//                     fontSize: 13,
//                     color: AppColors.textPrimaryColor,
//                     fontWeight: FontWeight.w500),
//                 maxLines: 3,
//                 overflow: TextOverflow.ellipsis),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _rowTappable(BuildContext context, CustomSize size, String label,
//       String value, IconData icon, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Padding(
//         padding:
//             EdgeInsets.only(bottom: size.customHeight(context) * 0.01),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Icon(icon, size: 14, color: AppColors.textSecondaryColor),
//             const SizedBox(width: 10),
//             SizedBox(
//               width: size.customWidth(context) * 0.22,
//               child: Text(label,
//                   style: GoogleFonts.poppins(
//                       fontSize: 12,
//                       color: AppColors.textSecondaryColor,
//                       fontWeight: FontWeight.w500)),
//             ),
//             Expanded(
//               child: Text(value,
//                   style: GoogleFonts.poppins(
//                       fontSize: 13,
//                       color: AppColors.accentColor,
//                       fontWeight: FontWeight.w500),
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis),
//             ),
//             const Icon(Icons.launch_rounded,
//                 size: 14, color: AppColors.accentColor),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _loader() {
//     return Scaffold(
//       appBar: AppBar(
//           backgroundColor: AppColors.whiteColor,
//           elevation: 0,
//           leading: IconButton(
//               icon: const Icon(Icons.arrow_back_ios_new_rounded,
//                   color: AppColors.textPrimaryColor),
//               onPressed: () => Get.back())),
//       body: const Center(
//           child: CircularProgressIndicator(
//               color: AppColors.primaryColor, strokeWidth: 3)),
//     );
//   }

//   Widget _error() {
//     return Scaffold(
//       appBar: AppBar(
//           backgroundColor: AppColors.whiteColor,
//           elevation: 0,
//           leading: IconButton(
//               icon: const Icon(Icons.arrow_back_ios_new_rounded,
//                   color: AppColors.textPrimaryColor),
//               onPressed: () => Get.back())),
//       body: Center(
//           child: Text('Appointment not found',
//               style: GoogleFonts.poppins(
//                   color: AppColors.textSecondaryColor))),
//     );
//   }

//   _StatusMeta _statusMeta(String status) {
//     switch (status.toLowerCase()) {
//       case 'confirmed':
//         return _StatusMeta(AppColors.primaryColor, 'Confirmed');
//       case 'completed':
//         return _StatusMeta(AppColors.successColor, 'Completed');
//       case 'cancelled':
//         return _StatusMeta(AppColors.errorColor, 'Cancelled');
//       case 'no_show':
//         return _StatusMeta(AppColors.greyColor, 'No Show');
//       default:
//         return _StatusMeta(AppColors.warningColor, 'Scheduled');
//     }
//   }

//   IconData _modeIcon(String mode) {
//     switch (mode.toLowerCase()) {
//       case 'online':
//         return Icons.videocam_outlined;
//       case 'physical':
//         return Icons.location_on_outlined;
//       default:
//         return Icons.swap_horiz_rounded;
//     }
//   }
// }


// lib/view/parent/booking/parent_my_appointments_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import 'package:speechspectrum/controllers/parent_booking_controller.dart';
import 'package:speechspectrum/models/my_appointment_model.dart';
import 'package:speechspectrum/routes/app_routes.dart';

class ParentMyAppointmentsScreen extends StatefulWidget {
  const ParentMyAppointmentsScreen({super.key});

  @override
  State<ParentMyAppointmentsScreen> createState() =>
      _ParentMyAppointmentsScreenState();
}

class _ParentMyAppointmentsScreenState
    extends State<ParentMyAppointmentsScreen>
    with SingleTickerProviderStateMixin {
  late final ParentBookingController _c;
  late final TabController _tab;

  static const _tabs = [
    ('All', Icons.list_alt_rounded),
    ('Scheduled', Icons.schedule_rounded),
    ('Confirmed', Icons.check_circle_outline_rounded),
    ('Completed', Icons.task_alt_rounded),
    ('Cancelled', Icons.cancel_outlined),
    ('No Show', Icons.person_off_outlined),
  ];

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: _tabs.length, vsync: this);
    _c = Get.isRegistered<ParentBookingController>()
        ? Get.find<ParentBookingController>()
        : Get.put(ParentBookingController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _c.fetchMyAppointments();
    });
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
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
        title: Text('My Appointments',
            style: GoogleFonts.poppins(
                color: AppColors.textPrimaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w600)),
        actions: [
          Obx(() => _c.isLoadingAppointments.value
              ? const Padding(
                  padding: EdgeInsets.all(16),
                  child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                          color: AppColors.primaryColor, strokeWidth: 2)))
              : IconButton(
                  icon: const Icon(Icons.refresh_rounded,
                      color: AppColors.primaryColor),
                  onPressed: _c.fetchMyAppointments)),
          const SizedBox(width: 4),
        ],
        bottom: TabBar(
          controller: _tab,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          labelColor: AppColors.primaryColor,
          unselectedLabelColor: AppColors.textSecondaryColor,
          indicatorColor: AppColors.primaryColor,
          indicatorWeight: 2.5,
          labelPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
          labelStyle:
              GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13),
          unselectedLabelStyle:
              GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 13),
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
      ),
      body: Obx(() {
        if (_c.isLoadingAppointments.value && _c.myAppointments.isEmpty) {
          return _loader(context, size);
        }
        return TabBarView(
          controller: _tab,
          children: [
            _list(context, size, _c.myAppointments),
            _list(context, size, _c.scheduledList),
            _list(context, size, _c.confirmedList),
            _list(context, size, _c.completedList),
            _list(context, size, _c.cancelledList),
            _list(context, size, _c.noShowList),
          ],
        );
      }),
    );
  }

  Widget _list(
      BuildContext context, CustomSize size, List<MyAppointmentItem> items) {
    if (items.isEmpty) return _empty(context, size);
    return RefreshIndicator(
      color: AppColors.primaryColor,
      onRefresh: _c.fetchMyAppointments,
      child: ListView.builder(
        padding: EdgeInsets.fromLTRB(
          size.customWidth(context) * 0.045,
          size.customHeight(context) * 0.02,
          size.customWidth(context) * 0.045,
          size.customHeight(context) * 0.04,
        ),
        itemCount: items.length,
        itemBuilder: (_, i) => _card(context, size, items[i]),
      ),
    );
  }

  Widget _card(
      BuildContext context, CustomSize size, MyAppointmentItem appt) {
    final meta = _statusMeta(appt.status);

    return GestureDetector(
      onTap: () => Get.toNamed(
        AppRoutes.parentAppointmentDetail,
        arguments: appt.appointmentId,
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.016),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(20),
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
                color: meta.color,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(size.customWidth(context) * 0.042),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Avatar
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.primaryColor.withOpacity(0.7),
                              AppColors.primaryColor
                            ],
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Center(
                          child: Text(appt.childInitials,
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SizedBox(width: size.customWidth(context) * 0.03),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              appt.children?.childName ?? 'Child',
                              style: GoogleFonts.poppins(
                                  fontSize: size.customWidth(context) * 0.04,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimaryColor),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              appt.expertUsers?.fullName ?? '',
                              style: GoogleFonts.poppins(
                                  fontSize:
                                      size.customWidth(context) * 0.031,
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w500),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: meta.color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(meta.label,
                            style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: meta.color)),
                      ),
                    ],
                  ),
                  SizedBox(height: size.customHeight(context) * 0.012),
                  Divider(
                      height: 1,
                      color: AppColors.greyColor.withOpacity(0.15)),
                  SizedBox(height: size.customHeight(context) * 0.01),
                  Wrap(
                    spacing: 14,
                    runSpacing: 6,
                    children: [
                      _chip2(Icons.calendar_today_outlined,
                          appt.formattedDate, AppColors.primaryColor),
                      _chip2(Icons.access_time_rounded, appt.formattedTime,
                          AppColors.secondaryColor),
                      _chip2(
                          _modeIcon(appt.bookedMode),
                          appt.bookedMode[0].toUpperCase() +
                              appt.bookedMode.substring(1),
                          AppColors.accentColor),
                      _chip2(
                          Icons.payments_outlined,
                          '${appt.currency} ${appt.feeCharged.toStringAsFixed(0)}',
                          AppColors.warningColor),
                    ],
                  ),
                  // Meet link
                  if (appt.meetLink != null &&
                      appt.meetLink!.isNotEmpty) ...[
                    SizedBox(height: size.customHeight(context) * 0.01),
                    _meetLinkBanner(context, size, appt.meetLink!),
                  ],
                  // Cancellation reason
                  if (appt.isCancelled &&
                      appt.cancellationReason != null) ...[
                    SizedBox(height: size.customHeight(context) * 0.01),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 7),
                      decoration: BoxDecoration(
                        color: AppColors.errorColor.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(children: [
                        const Icon(Icons.info_outline_rounded,
                            size: 13, color: AppColors.errorColor),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(appt.cancellationReason!,
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: AppColors.errorColor),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ]),
                    ),
                  ],
                  // No Show info banner
                  if (appt.isNoShow) ...[
                    SizedBox(height: size.customHeight(context) * 0.01),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 7),
                      decoration: BoxDecoration(
                        color: AppColors.greyColor.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: AppColors.greyColor.withOpacity(0.3)),
                      ),
                      child: Row(children: [
                        Icon(Icons.person_off_outlined,
                            size: 13, color: AppColors.greyColor),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            'Patient did not attend this session',
                            style: GoogleFonts.poppins(
                                fontSize: 12, color: AppColors.greyColor),
                          ),
                        ),
                      ]),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _meetLinkBanner(
      BuildContext context, CustomSize size, String url) {
    return GestureDetector(
      onTap: () async {
        final uri = Uri.tryParse(url);
        if (uri != null && await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF2196F3).withOpacity(0.07),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: const Color(0xFF2196F3).withOpacity(0.3), width: 1),
        ),
        child: Row(
          children: [
            const Icon(Icons.videocam_rounded,
                color: Color(0xFF2196F3), size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Join Meeting',
                style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: const Color(0xFF2196F3),
                    fontWeight: FontWeight.w600),
              ),
            ),
            GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(text: url));
                Get.snackbar('Copied', 'Meeting link copied',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: AppColors.textPrimaryColor,
                    colorText: Colors.white,
                    margin: const EdgeInsets.all(16),
                    borderRadius: 12,
                    duration: const Duration(seconds: 2));
              },
              child: const Icon(Icons.copy_outlined,
                  size: 15, color: Color(0xFF2196F3)),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.open_in_new_rounded,
                size: 15, color: Color(0xFF2196F3)),
          ],
        ),
      ),
    );
  }

  Widget _chip2(IconData icon, String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: color),
        const SizedBox(width: 4),
        Text(label,
            style: GoogleFonts.poppins(
                fontSize: 12,
                color: AppColors.textSecondaryColor,
                fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _loader(BuildContext context, CustomSize size) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
              color: AppColors.primaryColor, strokeWidth: 3),
          SizedBox(height: size.customHeight(context) * 0.02),
          Text('Loading appointments...',
              style: GoogleFonts.poppins(
                  color: AppColors.textSecondaryColor,
                  fontSize: size.customWidth(context) * 0.036)),
        ],
      ),
    );
  }

  Widget _empty(BuildContext context, CustomSize size) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.07),
                shape: BoxShape.circle),
            child: const Icon(Icons.event_busy_outlined,
                size: 52, color: AppColors.primaryColor),
          ),
          SizedBox(height: size.customHeight(context) * 0.025),
          Text('No appointments here',
              style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.044,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryColor)),
          SizedBox(height: size.customHeight(context) * 0.008),
          Text('Nothing in this category',
              style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.033,
                  color: AppColors.textSecondaryColor)),
        ],
      ),
    );
  }

  _StatusMeta _statusMeta(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return _StatusMeta(AppColors.primaryColor, 'Confirmed');
      case 'completed':
        return _StatusMeta(AppColors.successColor, 'Completed');
      case 'cancelled':
        return _StatusMeta(AppColors.errorColor, 'Cancelled');
      case 'no_show':
        return _StatusMeta(AppColors.greyColor, 'No Show');
      default:
        return _StatusMeta(AppColors.warningColor, 'Scheduled');
    }
  }

  IconData _modeIcon(String mode) {
    switch (mode.toLowerCase()) {
      case 'online':
        return Icons.videocam_outlined;
      case 'physical':
        return Icons.location_on_outlined;
      default:
        return Icons.swap_horiz_rounded;
    }
  }
}

// ═══════════════════════════════════════════════════════════════
//   Parent Appointment Detail Screen
// ═══════════════════════════════════════════════════════════════
class ParentAppointmentDetailScreen extends StatefulWidget {
  const ParentAppointmentDetailScreen({super.key});

  @override
  State<ParentAppointmentDetailScreen> createState() =>
      _ParentAppointmentDetailScreenState();
}

class _ParentAppointmentDetailScreenState
    extends State<ParentAppointmentDetailScreen> {
  late final ParentBookingController _c;
  late final String _appointmentId;

  @override
  void initState() {
    super.initState();
    _c = Get.find<ParentBookingController>();
    _appointmentId = Get.arguments as String;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _c.fetchAppointmentDetail(_appointmentId);
      _c.fetchAppointmentRecords(_appointmentId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();

    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      body: Obx(() {
        if (_c.isLoadingDetail.value) return _loader();
        final appt = _c.selectedAppointment.value;
        if (appt == null) return _error();
        return _content(context, size, appt);
      }),
    );
  }

  Widget _content(
      BuildContext context, CustomSize size, MyAppointmentItem appt) {
    final meta = _statusMeta(appt.status);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: size.customHeight(context) * 0.24,
          pinned: true,
          backgroundColor: AppColors.primaryColor,
          surfaceTintColor: Colors.transparent,
          leading: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.white, size: 18),
            ),
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primaryColor, AppColors.secondaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    size.customWidth(context) * 0.05,
                    size.customHeight(context) * 0.06,
                    size.customWidth(context) * 0.05,
                    16,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(18)),
                        child: Center(
                          child: Text(appt.childInitials,
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SizedBox(width: size.customWidth(context) * 0.04),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              appt.children?.childName ?? 'Unknown',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize:
                                      size.customWidth(context) * 0.044,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              appt.expertUsers?.fullName ?? '',
                              style: GoogleFonts.poppins(
                                  color: Colors.white.withOpacity(0.85),
                                  fontSize:
                                      size.customWidth(context) * 0.031),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: meta.color.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: Colors.white.withOpacity(0.4)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(meta.icon,
                                      color: Colors.white, size: 12),
                                  const SizedBox(width: 5),
                                  Text(meta.label,
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

        SliverPadding(
          padding: EdgeInsets.fromLTRB(
            size.customWidth(context) * 0.045,
            size.customHeight(context) * 0.02,
            size.customWidth(context) * 0.045,
            size.customHeight(context) * 0.06,
          ),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // Meet link prominent banner
              if (appt.meetLink != null && appt.meetLink!.isNotEmpty) ...[
                _meetLinkCard(context, size, appt.meetLink!),
                SizedBox(height: size.customHeight(context) * 0.018),
              ],

              // No Show info card
              if (appt.isNoShow) ...[
                _noShowCard(context, size),
                SizedBox(height: size.customHeight(context) * 0.018),
              ],

              // Appointment details card
              _detailCard(context, size, appt),
              SizedBox(height: size.customHeight(context) * 0.018),

              // Slot info
              if (appt.appointmentSlots != null) ...[
                _slotCard(context, size, appt.appointmentSlots!),
                SizedBox(height: size.customHeight(context) * 0.018),
              ],

              // Expert info
              if (appt.expertUsers != null) ...[
                _expertCard(context, size, appt.expertUsers!),
                SizedBox(height: size.customHeight(context) * 0.018),
              ],

              // Cancellation
              if (appt.isCancelled) ...[
                _cancellationCard(context, size, appt),
                SizedBox(height: size.customHeight(context) * 0.018),
              ],

              // Session records (only for completed)
              if (appt.isCompleted) ...[
                _recordsSection(context, size),
                SizedBox(height: size.customHeight(context) * 0.04),
              ],
            ]),
          ),
        ),
      ],
    );
  }

  Widget _noShowCard(BuildContext context, CustomSize size) {
    return Container(
      padding: EdgeInsets.all(size.customWidth(context) * 0.045),
      decoration: BoxDecoration(
        color: AppColors.greyColor.withOpacity(0.07),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.greyColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: AppColors.greyColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12)),
            child: Icon(Icons.person_off_outlined,
                color: AppColors.greyColor, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'No Show',
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.greyColor),
                ),
                const SizedBox(height: 2),
                Text(
                  'The patient did not attend this scheduled session.',
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: AppColors.greyColor.withOpacity(0.8)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _meetLinkCard(
      BuildContext context, CustomSize size, String url) {
    return GestureDetector(
      onTap: () async {
        final uri = Uri.tryParse(url);
        if (uri != null && await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      child: Container(
        padding: EdgeInsets.all(size.customWidth(context) * 0.04),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF2196F3), Color(0xFF1565C0)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
                color: const Color(0xFF2196F3).withOpacity(0.3),
                blurRadius: 14,
                offset: const Offset(0, 4))
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.videocam_rounded,
                  color: Colors.white, size: 24),
            ),
            SizedBox(width: size.customWidth(context) * 0.035),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Join Meeting',
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  Text('Tap to open meeting',
                      style: GoogleFonts.poppins(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 12)),
                ],
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: url));
                    Get.snackbar('Copied', 'Meeting link copied',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: AppColors.textPrimaryColor,
                        colorText: Colors.white,
                        margin: const EdgeInsets.all(16),
                        borderRadius: 12,
                        duration: const Duration(seconds: 2));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8)),
                    child: const Icon(Icons.copy_outlined,
                        color: Colors.white, size: 16),
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.open_in_new_rounded,
                    color: Colors.white, size: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailCard(
      BuildContext context, CustomSize size, MyAppointmentItem appt) {
    return _card(context, size,
        title: 'Appointment Details',
        icon: Icons.event_note_rounded,
        children: [
          _row(context, size, 'Date', appt.formattedDate,
              Icons.calendar_today_outlined),
          _row(context, size, 'Time', appt.formattedTime,
              Icons.access_time_rounded),
          _row(context, size, 'Duration', '${appt.durationMinutes} min',
              Icons.timer_outlined),
          _row(
              context,
              size,
              'Mode',
              appt.bookedMode[0].toUpperCase() + appt.bookedMode.substring(1),
              _modeIcon(appt.bookedMode)),
          _row(
              context,
              size,
              'Fee',
              '${appt.currency} ${appt.feeCharged.toStringAsFixed(0)}',
              Icons.payments_outlined),
        ]);
  }

  Widget _slotCard(
      BuildContext context, CustomSize size, AppointmentSlot slot) {
    return _card(context, size,
        title: 'Slot Information',
        icon: Icons.calendar_month_rounded,
        children: [
          _row(context, size, 'Slot Date', slot.slotDate,
              Icons.today_rounded),
          _row(context, size, 'Slot Time',
              '${slot.formattedStart} – ${slot.formattedEnd}',
              Icons.schedule_rounded),
          _row(
              context,
              size,
              'Slot Mode',
              slot.mode[0].toUpperCase() + slot.mode.substring(1),
              _modeIcon(slot.mode)),
        ]);
  }

  Widget _expertCard(
      BuildContext context, CustomSize size, AppointmentExpert expert) {
    return _card(context, size,
        title: 'Expert Information',
        icon: Icons.person_outline_rounded,
        children: [
          _row(context, size, 'Name', expert.fullName, Icons.badge_outlined),
          _row(context, size, 'Specialization', expert.specialization,
              Icons.medical_information_outlined),
          if (expert.phone != null)
            _rowTappable(context, size, 'Phone', expert.phone!,
                Icons.phone_outlined, () async {
              final uri = Uri(scheme: 'tel', path: expert.phone);
              if (await canLaunchUrl(uri)) await launchUrl(uri);
            }),
          if (expert.contactEmail != null)
            _rowTappable(context, size, 'Email', expert.contactEmail!,
                Icons.email_outlined, () async {
              final uri = Uri(scheme: 'mailto', path: expert.contactEmail);
              if (await canLaunchUrl(uri)) await launchUrl(uri);
            }),
        ]);
  }

  Widget _cancellationCard(
      BuildContext context, CustomSize size, MyAppointmentItem appt) {
    return Container(
      padding: EdgeInsets.all(size.customWidth(context) * 0.045),
      decoration: BoxDecoration(
        color: AppColors.errorColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.errorColor.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            const Icon(Icons.cancel_outlined,
                color: AppColors.errorColor, size: 18),
            const SizedBox(width: 8),
            Text('Cancellation Info',
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.errorColor)),
          ]),
          const SizedBox(height: 12),
          if (appt.cancelledBy != null)
            _row(
                context,
                size,
                'By',
                appt.cancelledBy![0].toUpperCase() +
                    appt.cancelledBy!.substring(1),
                Icons.person_outlined),
          if (appt.cancellationReason != null)
            _row(context, size, 'Reason', appt.cancellationReason!,
                Icons.info_outline_rounded),
        ],
      ),
    );
  }

  Widget _recordsSection(BuildContext context, CustomSize size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Container(
              width: 4,
              height: 20,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(2))),
          const SizedBox(width: 10),
          Text('Session Records',
              style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.042,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryColor)),
        ]),
        SizedBox(height: size.customHeight(context) * 0.015),
        Obx(() {
          if (_c.isLoadingRecords.value) {
            return const Center(
                child: Padding(
              padding: EdgeInsets.all(24),
              child: CircularProgressIndicator(
                  color: AppColors.primaryColor, strokeWidth: 2),
            ));
          }
          if (_c.appointmentRecords.isEmpty) {
            return Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2))
                ],
              ),
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.note_outlined,
                        size: 40,
                        color:
                            AppColors.textSecondaryColor.withOpacity(0.4)),
                    const SizedBox(height: 10),
                    Text('No session records yet',
                        style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: AppColors.textSecondaryColor)),
                  ],
                ),
              ),
            );
          }
          return Column(
            children: _c.appointmentRecords
                .map((r) => _recordCard(context, size, r))
                .toList(),
          );
        }),
      ],
    );
  }

  Widget _recordCard(BuildContext context, CustomSize size,
      AppointmentRecordItem record) {
    return Container(
      margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.014),
      padding: EdgeInsets.all(size.customWidth(context) * 0.042),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 3))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.description_outlined,
                      color: AppColors.primaryColor, size: 18)),
              const SizedBox(width: 10),
              Text('Session Note',
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimaryColor)),
              const Spacer(),
              Text(record.formattedDate,
                  style: GoogleFonts.poppins(
                      fontSize: 11, color: AppColors.textSecondaryColor)),
            ],
          ),
          SizedBox(height: size.customHeight(context) * 0.012),
          Divider(height: 1, color: AppColors.greyColor.withOpacity(0.15)),
          SizedBox(height: size.customHeight(context) * 0.012),
          _recordField('Notes', record.notes, Icons.notes_rounded),
          SizedBox(height: size.customHeight(context) * 0.008),
          _recordField('Therapy Plan', record.therapyPlan,
              Icons.health_and_safety_outlined),
          SizedBox(height: size.customHeight(context) * 0.008),
          _recordField('Progress', record.progressFeedback,
              Icons.trending_up_rounded),
          if (record.medication != null) ...[
            SizedBox(height: size.customHeight(context) * 0.008),
            _recordField(
                'Medication',
                record.medication!['name'] ?? 'None',
                Icons.medication_outlined),
          ],
        ],
      ),
    );
  }

  Widget _recordField(String label, String value, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 14, color: AppColors.primaryColor.withOpacity(0.7)),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: AppColors.textSecondaryColor,
                      fontWeight: FontWeight.w500)),
              Text(value,
                  style: GoogleFonts.poppins(
                      fontSize: 13, color: AppColors.textPrimaryColor)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _card(BuildContext context, CustomSize size,
      {required String title,
      required IconData icon,
      required List<Widget> children}) {
    return Container(
      padding: EdgeInsets.all(size.customWidth(context) * 0.045),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 3))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10)),
                child:
                    Icon(icon, color: AppColors.primaryColor, size: 18)),
            const SizedBox(width: 10),
            Text(title,
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimaryColor)),
          ]),
          SizedBox(height: size.customHeight(context) * 0.014),
          Divider(height: 1, color: AppColors.greyColor.withOpacity(0.15)),
          SizedBox(height: size.customHeight(context) * 0.012),
          ...children,
        ],
      ),
    );
  }

  Widget _row(BuildContext context, CustomSize size, String label,
      String value, IconData icon) {
    return Padding(
      padding: EdgeInsets.only(bottom: size.customHeight(context) * 0.01),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 14, color: AppColors.textSecondaryColor),
          const SizedBox(width: 10),
          SizedBox(
            width: size.customWidth(context) * 0.22,
            child: Text(label,
                style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColors.textSecondaryColor,
                    fontWeight: FontWeight.w500)),
          ),
          Expanded(
            child: Text(value,
                style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: AppColors.textPrimaryColor,
                    fontWeight: FontWeight.w500),
                maxLines: 3,
                overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }

  Widget _rowTappable(BuildContext context, CustomSize size, String label,
      String value, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(bottom: size.customHeight(context) * 0.01),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 14, color: AppColors.textSecondaryColor),
            const SizedBox(width: 10),
            SizedBox(
              width: size.customWidth(context) * 0.22,
              child: Text(label,
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: AppColors.textSecondaryColor,
                      fontWeight: FontWeight.w500)),
            ),
            Expanded(
              child: Text(value,
                  style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: AppColors.accentColor,
                      fontWeight: FontWeight.w500),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis),
            ),
            const Icon(Icons.launch_rounded,
                size: 14, color: AppColors.accentColor),
          ],
        ),
      ),
    );
  }

  Widget _loader() {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          elevation: 0,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: AppColors.textPrimaryColor),
              onPressed: () => Get.back())),
      body: const Center(
          child: CircularProgressIndicator(
              color: AppColors.primaryColor, strokeWidth: 3)),
    );
  }

  Widget _error() {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          elevation: 0,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: AppColors.textPrimaryColor),
              onPressed: () => Get.back())),
      body: Center(
          child: Text('Appointment not found',
              style: GoogleFonts.poppins(
                  color: AppColors.textSecondaryColor))),
    );
  }

  _StatusMeta _statusMeta(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return _StatusMeta(
            AppColors.primaryColor, 'Confirmed', Icons.check_circle_outlined);
      case 'completed':
        return _StatusMeta(
            AppColors.successColor, 'Completed', Icons.task_alt_rounded);
      case 'cancelled':
        return _StatusMeta(
            AppColors.errorColor, 'Cancelled', Icons.cancel_outlined);
      case 'no_show':
        return _StatusMeta(
            AppColors.greyColor, 'No Show', Icons.person_off_outlined);
      default:
        return _StatusMeta(
            AppColors.warningColor, 'Scheduled', Icons.schedule_rounded);
    }
  }

  IconData _modeIcon(String mode) {
    switch (mode.toLowerCase()) {
      case 'online':
        return Icons.videocam_outlined;
      case 'physical':
        return Icons.location_on_outlined;
      default:
        return Icons.swap_horiz_rounded;
    }
  }
}

// ═══════════════════════════════════════════════════════════════
//   Single shared _StatusMeta class — icon is optional
// ═══════════════════════════════════════════════════════════════
class _StatusMeta {
  final Color color;
  final String label;
  final IconData icon;
  _StatusMeta(this.color, this.label, [this.icon = Icons.info_outline]);
}