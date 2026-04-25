// // // lib/view/parent/booking/parent_my_appointments_screen.dart
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:get/get.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:url_launcher/url_launcher.dart';
// // import 'package:speechspectrum/constants/app_colors.dart';
// // import 'package:speechspectrum/constants/custom_size.dart';
// // import 'package:speechspectrum/controllers/parent_booking_controller.dart';
// // import 'package:speechspectrum/models/my_appointment_model.dart';
// // import 'package:speechspectrum/routes/app_routes.dart';

// // class ParentMyAppointmentsScreen extends StatefulWidget {
// //   const ParentMyAppointmentsScreen({super.key});

// //   @override
// //   State<ParentMyAppointmentsScreen> createState() =>
// //       _ParentMyAppointmentsScreenState();
// // }

// // class _ParentMyAppointmentsScreenState
// //     extends State<ParentMyAppointmentsScreen>
// //     with SingleTickerProviderStateMixin {
// //   late final ParentBookingController _c;
// //   late final TabController _tab;

// //   static const _tabs = [
// //     ('All', Icons.list_alt_rounded),
// //     ('Scheduled', Icons.schedule_rounded),
// //     ('Confirmed', Icons.check_circle_outline_rounded),
// //     ('Completed', Icons.task_alt_rounded),
// //     ('Cancelled', Icons.cancel_outlined),
// //   ];

// //   @override
// //   void initState() {
// //     super.initState();
// //     _tab = TabController(length: _tabs.length, vsync: this);
// //     _c = Get.isRegistered<ParentBookingController>()
// //         ? Get.find<ParentBookingController>()
// //         : Get.put(ParentBookingController());
// //     WidgetsBinding.instance.addPostFrameCallback((_) {
// //       _c.fetchMyAppointments();
// //     });
// //   }

// //   @override
// //   void dispose() {
// //     _tab.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final size = CustomSize();

// //     return Scaffold(
// //       backgroundColor: AppColors.lightGreyColor,
// //       appBar: AppBar(
// //         backgroundColor: AppColors.whiteColor,
// //         elevation: 0,
// //         surfaceTintColor: Colors.transparent,
// //         leading: IconButton(
// //           icon: const Icon(Icons.arrow_back_ios_new_rounded,
// //               color: AppColors.textPrimaryColor, size: 20),
// //           onPressed: () => Get.back(),
// //         ),
// //         title: Text('My Appointments',
// //             style: GoogleFonts.poppins(
// //                 color: AppColors.textPrimaryColor,
// //                 fontSize: 18,
// //                 fontWeight: FontWeight.w600)),
// //         actions: [
// //           Obx(() => _c.isLoadingAppointments.value
// //               ? const Padding(
// //                   padding: EdgeInsets.all(16),
// //                   child: SizedBox(
// //                       width: 20,
// //                       height: 20,
// //                       child: CircularProgressIndicator(
// //                           color: AppColors.primaryColor, strokeWidth: 2)))
// //               : IconButton(
// //                   icon: const Icon(Icons.refresh_rounded,
// //                       color: AppColors.primaryColor),
// //                   onPressed: _c.fetchMyAppointments)),
// //           const SizedBox(width: 4),
// //         ],
// //         bottom: TabBar(
// //           controller: _tab,
// //           isScrollable: true,
// //           tabAlignment: TabAlignment.start,
// //           labelColor: AppColors.primaryColor,
// //           unselectedLabelColor: AppColors.textSecondaryColor,
// //           indicatorColor: AppColors.primaryColor,
// //           indicatorWeight: 2.5,
// //           labelPadding:
// //               const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
// //           labelStyle: GoogleFonts.poppins(
// //               fontWeight: FontWeight.w600, fontSize: 13),
// //           unselectedLabelStyle: GoogleFonts.poppins(
// //               fontWeight: FontWeight.w500, fontSize: 13),
// //           tabs: _tabs
// //               .map((t) => Tab(
// //                     child: Row(
// //                       mainAxisSize: MainAxisSize.min,
// //                       children: [
// //                         Icon(t.$2, size: 14),
// //                         const SizedBox(width: 5),
// //                         Text(t.$1),
// //                       ],
// //                     ),
// //                   ))
// //               .toList(),
// //         ),
// //       ),
// //       body: Obx(() {
// //         if (_c.isLoadingAppointments.value &&
// //             _c.myAppointments.isEmpty) {
// //           return _loader(context, size);
// //         }
// //         return TabBarView(
// //           controller: _tab,
// //           children: [
// //             _list(context, size, _c.myAppointments),
// //             _list(context, size, _c.scheduledList),
// //             _list(context, size, _c.confirmedList),
// //             _list(context, size, _c.completedList),
// //             _list(context, size, _c.cancelledList),
// //           ],
// //         );
// //       }),
// //     );
// //   }

// //   Widget _list(BuildContext context, CustomSize size,
// //       List<MyAppointmentItem> items) {
// //     if (items.isEmpty) return _empty(context, size);
// //     return RefreshIndicator(
// //       color: AppColors.primaryColor,
// //       onRefresh: _c.fetchMyAppointments,
// //       child: ListView.builder(
// //         padding: EdgeInsets.fromLTRB(
// //           size.customWidth(context) * 0.045,
// //           size.customHeight(context) * 0.02,
// //           size.customWidth(context) * 0.045,
// //           size.customHeight(context) * 0.04,
// //         ),
// //         itemCount: items.length,
// //         itemBuilder: (_, i) => _card(context, size, items[i]),
// //       ),
// //     );
// //   }

// //   Widget _card(
// //       BuildContext context, CustomSize size, MyAppointmentItem appt) {
// //     final meta = _statusMeta(appt.status);

// //     return GestureDetector(
// //       onTap: () => Get.toNamed(
// //         AppRoutes.parentAppointmentDetail,
// //         arguments: appt.appointmentId,
// //       ),
// //       child: Container(
// //         margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.016),
// //         decoration: BoxDecoration(
// //           color: AppColors.whiteColor,
// //           borderRadius: BorderRadius.circular(20),
// //           boxShadow: [
// //             BoxShadow(
// //                 color: Colors.black.withOpacity(0.06),
// //                 blurRadius: 14,
// //                 offset: const Offset(0, 4))
// //           ],
// //         ),
// //         child: Column(
// //           children: [
// //             Container(
// //               height: 4,
// //               decoration: BoxDecoration(
// //                 color: meta.color,
// //                 borderRadius: const BorderRadius.vertical(
// //                     top: Radius.circular(20)),
// //               ),
// //             ),
// //             Padding(
// //               padding: EdgeInsets.all(size.customWidth(context) * 0.042),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Row(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       // Avatar
// //                       Container(
// //                         width: 50,
// //                         height: 50,
// //                         decoration: BoxDecoration(
// //                           gradient: LinearGradient(
// //                             colors: [
// //                               AppColors.primaryColor.withOpacity(0.7),
// //                               AppColors.primaryColor
// //                             ],
// //                           ),
// //                           borderRadius: BorderRadius.circular(14),
// //                         ),
// //                         child: Center(
// //                           child: Text(appt.childInitials,
// //                               style: GoogleFonts.poppins(
// //                                   color: Colors.white,
// //                                   fontSize: 16,
// //                                   fontWeight: FontWeight.bold)),
// //                         ),
// //                       ),
// //                       SizedBox(width: size.customWidth(context) * 0.03),
// //                       Expanded(
// //                         child: Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             Text(
// //                               appt.children?.childName ?? 'Child',
// //                               style: GoogleFonts.poppins(
// //                                   fontSize:
// //                                       size.customWidth(context) * 0.04,
// //                                   fontWeight: FontWeight.w700,
// //                                   color: AppColors.textPrimaryColor),
// //                               maxLines: 1,
// //                               overflow: TextOverflow.ellipsis,
// //                             ),
// //                             Text(
// //                               appt.expertUsers?.fullName ?? '',
// //                               style: GoogleFonts.poppins(
// //                                   fontSize:
// //                                       size.customWidth(context) * 0.031,
// //                                   color: AppColors.primaryColor,
// //                                   fontWeight: FontWeight.w500),
// //                               maxLines: 1,
// //                               overflow: TextOverflow.ellipsis,
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                       Container(
// //                         padding: const EdgeInsets.symmetric(
// //                             horizontal: 10, vertical: 4),
// //                         decoration: BoxDecoration(
// //                           color: meta.color.withOpacity(0.1),
// //                           borderRadius: BorderRadius.circular(20),
// //                         ),
// //                         child: Text(meta.label,
// //                             style: GoogleFonts.poppins(
// //                                 fontSize: 10,
// //                                 fontWeight: FontWeight.w600,
// //                                 color: meta.color)),
// //                       ),
// //                     ],
// //                   ),
// //                   SizedBox(height: size.customHeight(context) * 0.012),
// //                   Divider(
// //                       height: 1,
// //                       color: AppColors.greyColor.withOpacity(0.15)),
// //                   SizedBox(height: size.customHeight(context) * 0.01),
// //                   Wrap(
// //                     spacing: 14,
// //                     runSpacing: 6,
// //                     children: [
// //                       _chip2(Icons.calendar_today_outlined,
// //                           appt.formattedDate, AppColors.primaryColor),
// //                       _chip2(Icons.access_time_rounded,
// //                           appt.formattedTime, AppColors.secondaryColor),
// //                       _chip2(_modeIcon(appt.bookedMode),
// //                           appt.bookedMode[0].toUpperCase() +
// //                               appt.bookedMode.substring(1),
// //                           AppColors.accentColor),
// //                       _chip2(
// //                           Icons.payments_outlined,
// //                           '${appt.currency} ${appt.feeCharged.toStringAsFixed(0)}',
// //                           AppColors.warningColor),
// //                     ],
// //                   ),
// //                   // Meet link
// //                   if (appt.meetLink != null &&
// //                       appt.meetLink!.isNotEmpty) ...[
// //                     SizedBox(height: size.customHeight(context) * 0.01),
// //                     _meetLinkBanner(context, size, appt.meetLink!),
// //                   ],
// //                   // Cancellation
// //                   if (appt.isCancelled &&
// //                       appt.cancellationReason != null) ...[
// //                     SizedBox(height: size.customHeight(context) * 0.01),
// //                     Container(
// //                       padding: const EdgeInsets.symmetric(
// //                           horizontal: 10, vertical: 7),
// //                       decoration: BoxDecoration(
// //                         color: AppColors.errorColor.withOpacity(0.06),
// //                         borderRadius: BorderRadius.circular(10),
// //                       ),
// //                       child: Row(children: [
// //                         const Icon(Icons.info_outline_rounded,
// //                             size: 13, color: AppColors.errorColor),
// //                         const SizedBox(width: 6),
// //                         Expanded(
// //                           child: Text(appt.cancellationReason!,
// //                               style: GoogleFonts.poppins(
// //                                   fontSize: 12,
// //                                   color: AppColors.errorColor),
// //                               maxLines: 2,
// //                               overflow: TextOverflow.ellipsis),
// //                         ),
// //                       ]),
// //                     ),
// //                   ],
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _meetLinkBanner(
// //       BuildContext context, CustomSize size, String url) {
// //     return GestureDetector(
// //       onTap: () async {
// //         final uri = Uri.tryParse(url);
// //         if (uri != null && await canLaunchUrl(uri)) {
// //           await launchUrl(uri, mode: LaunchMode.externalApplication);
// //         }
// //       },
// //       child: Container(
// //         padding:
// //             const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
// //         decoration: BoxDecoration(
// //           color: const Color(0xFF2196F3).withOpacity(0.07),
// //           borderRadius: BorderRadius.circular(12),
// //           border: Border.all(
// //               color: const Color(0xFF2196F3).withOpacity(0.3),
// //               width: 1),
// //         ),
// //         child: Row(
// //           children: [
// //             const Icon(Icons.videocam_rounded,
// //                 color: Color(0xFF2196F3), size: 18),
// //             const SizedBox(width: 8),
// //             Expanded(
// //               child: Text(
// //                 'Join Meeting',
// //                 style: GoogleFonts.poppins(
// //                     fontSize: 13,
// //                     color: const Color(0xFF2196F3),
// //                     fontWeight: FontWeight.w600),
// //               ),
// //             ),
// //             GestureDetector(
// //               onTap: () {
// //                 Clipboard.setData(ClipboardData(text: url));
// //                 Get.snackbar('Copied', 'Meeting link copied',
// //                     snackPosition: SnackPosition.BOTTOM,
// //                     backgroundColor: AppColors.textPrimaryColor,
// //                     colorText: Colors.white,
// //                     margin: const EdgeInsets.all(16),
// //                     borderRadius: 12,
// //                     duration: const Duration(seconds: 2));
// //               },
// //               child: const Icon(Icons.copy_outlined,
// //                   size: 15, color: Color(0xFF2196F3)),
// //             ),
// //             const SizedBox(width: 4),
// //             const Icon(Icons.open_in_new_rounded,
// //                 size: 15, color: Color(0xFF2196F3)),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _chip2(IconData icon, String label, Color color) {
// //     return Row(
// //       mainAxisSize: MainAxisSize.min,
// //       children: [
// //         Icon(icon, size: 13, color: color),
// //         const SizedBox(width: 4),
// //         Text(label,
// //             style: GoogleFonts.poppins(
// //                 fontSize: 12,
// //                 color: AppColors.textSecondaryColor,
// //                 fontWeight: FontWeight.w500)),
// //       ],
// //     );
// //   }

// //   Widget _loader(BuildContext context, CustomSize size) {
// //     return Center(
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           const CircularProgressIndicator(
// //               color: AppColors.primaryColor, strokeWidth: 3),
// //           SizedBox(height: size.customHeight(context) * 0.02),
// //           Text('Loading appointments...',
// //               style: GoogleFonts.poppins(
// //                   color: AppColors.textSecondaryColor,
// //                   fontSize: size.customWidth(context) * 0.036)),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _empty(BuildContext context, CustomSize size) {
// //     return Center(
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           Container(
// //             width: 110,
// //             height: 110,
// //             decoration: BoxDecoration(
// //                 color: AppColors.primaryColor.withOpacity(0.07),
// //                 shape: BoxShape.circle),
// //             child: const Icon(Icons.event_busy_outlined,
// //                 size: 52, color: AppColors.primaryColor),
// //           ),
// //           SizedBox(height: size.customHeight(context) * 0.025),
// //           Text('No appointments here',
// //               style: GoogleFonts.poppins(
// //                   fontSize: size.customWidth(context) * 0.044,
// //                   fontWeight: FontWeight.bold,
// //                   color: AppColors.textPrimaryColor)),
// //           SizedBox(height: size.customHeight(context) * 0.008),
// //           Text('Nothing in this category',
// //               style: GoogleFonts.poppins(
// //                   fontSize: size.customWidth(context) * 0.033,
// //                   color: AppColors.textSecondaryColor)),
// //         ],
// //       ),
// //     );
// //   }

// //   _StatusMeta _statusMeta(String status) {
// //     switch (status.toLowerCase()) {
// //       case 'confirmed':
// //         return _StatusMeta(AppColors.primaryColor, 'Confirmed');
// //       case 'completed':
// //         return _StatusMeta(AppColors.successColor, 'Completed');
// //       case 'cancelled':
// //         return _StatusMeta(AppColors.errorColor, 'Cancelled');
// //       case 'no_show':
// //         return _StatusMeta(AppColors.greyColor, 'No Show');
// //       default:
// //         return _StatusMeta(AppColors.warningColor, 'Scheduled');
// //     }
// //   }

// //   IconData _modeIcon(String mode) {
// //     switch (mode.toLowerCase()) {
// //       case 'online':
// //         return Icons.videocam_outlined;
// //       case 'physical':
// //         return Icons.location_on_outlined;
// //       default:
// //         return Icons.swap_horiz_rounded;
// //     }
// //   }
// // }

// // class _StatusMeta {
// //   final Color color;
// //   final String label;
// //   _StatusMeta(this.color, this.label);
// // }

// // // ═══════════════════════════════════════════════════════════════
// // //   Parent Appointment Detail Screen
// // // ═══════════════════════════════════════════════════════════════
// // class ParentAppointmentDetailScreen extends StatefulWidget {
// //   const ParentAppointmentDetailScreen({super.key});

// //   @override
// //   State<ParentAppointmentDetailScreen> createState() =>
// //       _ParentAppointmentDetailScreenState();
// // }

// // class _ParentAppointmentDetailScreenState
// //     extends State<ParentAppointmentDetailScreen> {
// //   late final ParentBookingController _c;
// //   late final String _appointmentId;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _c = Get.find<ParentBookingController>();
// //     _appointmentId = Get.arguments as String;
// //     WidgetsBinding.instance.addPostFrameCallback((_) {
// //       _c.fetchAppointmentDetail(_appointmentId);
// //       _c.fetchAppointmentRecords(_appointmentId);
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final size = CustomSize();

// //     return Scaffold(
// //       backgroundColor: AppColors.lightGreyColor,
// //       body: Obx(() {
// //         if (_c.isLoadingDetail.value) return _loader();
// //         final appt = _c.selectedAppointment.value;
// //         if (appt == null) return _error();
// //         return _content(context, size, appt);
// //       }),
// //     );
// //   }

// //   Widget _content(
// //       BuildContext context, CustomSize size, MyAppointmentItem appt) {
// //     final meta = _statusMeta(appt.status);

// //     return CustomScrollView(
// //       slivers: [
// //         SliverAppBar(
// //           expandedHeight: size.customHeight(context) * 0.24,
// //           pinned: true,
// //           backgroundColor: AppColors.primaryColor,
// //           surfaceTintColor: Colors.transparent,
// //           leading: GestureDetector(
// //             onTap: () => Get.back(),
// //             child: Container(
// //               margin: const EdgeInsets.all(8),
// //               decoration: BoxDecoration(
// //                   color: Colors.white.withOpacity(0.15),
// //                   borderRadius: BorderRadius.circular(12)),
// //               child: const Icon(Icons.arrow_back_ios_new_rounded,
// //                   color: Colors.white, size: 18),
// //             ),
// //           ),
// //           flexibleSpace: FlexibleSpaceBar(
// //             background: Container(
// //               decoration: const BoxDecoration(
// //                 gradient: LinearGradient(
// //                   colors: [AppColors.primaryColor, AppColors.secondaryColor],
// //                   begin: Alignment.topLeft,
// //                   end: Alignment.bottomRight,
// //                 ),
// //               ),
// //               child: SafeArea(
// //                 child: Padding(
// //                   padding: EdgeInsets.fromLTRB(
// //                     size.customWidth(context) * 0.05,
// //                     size.customHeight(context) * 0.06,
// //                     size.customWidth(context) * 0.05,
// //                     16,
// //                   ),
// //                   child: Row(
// //                     children: [
// //                       Container(
// //                         width: 64,
// //                         height: 64,
// //                         decoration: BoxDecoration(
// //                             color: Colors.white.withOpacity(0.2),
// //                             borderRadius: BorderRadius.circular(18)),
// //                         child: Center(
// //                           child: Text(appt.childInitials,
// //                               style: GoogleFonts.poppins(
// //                                   color: Colors.white,
// //                                   fontSize: 24,
// //                                   fontWeight: FontWeight.bold)),
// //                         ),
// //                       ),
// //                       SizedBox(width: size.customWidth(context) * 0.04),
// //                       Expanded(
// //                         child: Column(
// //                           mainAxisSize: MainAxisSize.min,
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             Text(
// //                               appt.children?.childName ?? 'Unknown',
// //                               style: GoogleFonts.poppins(
// //                                   color: Colors.white,
// //                                   fontSize:
// //                                       size.customWidth(context) * 0.044,
// //                                   fontWeight: FontWeight.bold),
// //                             ),
// //                             Text(
// //                               appt.expertUsers?.fullName ?? '',
// //                               style: GoogleFonts.poppins(
// //                                   color: Colors.white.withOpacity(0.85),
// //                                   fontSize:
// //                                       size.customWidth(context) * 0.031),
// //                             ),
// //                             const SizedBox(height: 6),
// //                             Container(
// //                               padding: const EdgeInsets.symmetric(
// //                                   horizontal: 12, vertical: 4),
// //                               decoration: BoxDecoration(
// //                                 color: meta.color.withOpacity(0.2),
// //                                 borderRadius: BorderRadius.circular(20),
// //                                 border: Border.all(
// //                                     color: Colors.white.withOpacity(0.4)),
// //                               ),
// //                               child: Text(meta.label,
// //                                   style: GoogleFonts.poppins(
// //                                       color: Colors.white,
// //                                       fontSize: 12,
// //                                       fontWeight: FontWeight.w600)),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ),

// //         SliverPadding(
// //           padding: EdgeInsets.fromLTRB(
// //             size.customWidth(context) * 0.045,
// //             size.customHeight(context) * 0.02,
// //             size.customWidth(context) * 0.045,
// //             size.customHeight(context) * 0.06,
// //           ),
// //           sliver: SliverList(
// //             delegate: SliverChildListDelegate([
// //               // Meet link prominent banner
// //               if (appt.meetLink != null && appt.meetLink!.isNotEmpty) ...[
// //                 _meetLinkCard(context, size, appt.meetLink!),
// //                 SizedBox(height: size.customHeight(context) * 0.018),
// //               ],

// //               // Appointment details card
// //               _detailCard(context, size, appt),
// //               SizedBox(height: size.customHeight(context) * 0.018),

// //               // Slot info
// //               if (appt.appointmentSlots != null) ...[
// //                 _slotCard(context, size, appt.appointmentSlots!),
// //                 SizedBox(height: size.customHeight(context) * 0.018),
// //               ],

// //               // Expert info
// //               if (appt.expertUsers != null) ...[
// //                 _expertCard(context, size, appt.expertUsers!),
// //                 SizedBox(height: size.customHeight(context) * 0.018),
// //               ],

// //               // Cancellation
// //               if (appt.isCancelled) ...[
// //                 _cancellationCard(context, size, appt),
// //                 SizedBox(height: size.customHeight(context) * 0.018),
// //               ],

// //               // Session records
// //               _recordsSection(context, size),
// //               SizedBox(height: size.customHeight(context) * 0.04),
// //             ]),
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   Widget _meetLinkCard(
// //       BuildContext context, CustomSize size, String url) {
// //     return GestureDetector(
// //       onTap: () async {
// //         final uri = Uri.tryParse(url);
// //         if (uri != null && await canLaunchUrl(uri)) {
// //           await launchUrl(uri, mode: LaunchMode.externalApplication);
// //         }
// //       },
// //       child: Container(
// //         padding: EdgeInsets.all(size.customWidth(context) * 0.04),
// //         decoration: BoxDecoration(
// //           gradient: LinearGradient(
// //             colors: [
// //               const Color(0xFF2196F3),
// //               const Color(0xFF1565C0),
// //             ],
// //             begin: Alignment.topLeft,
// //             end: Alignment.bottomRight,
// //           ),
// //           borderRadius: BorderRadius.circular(18),
// //           boxShadow: [
// //             BoxShadow(
// //                 color: const Color(0xFF2196F3).withOpacity(0.3),
// //                 blurRadius: 14,
// //                 offset: const Offset(0, 4))
// //           ],
// //         ),
// //         child: Row(
// //           children: [
// //             Container(
// //               padding: const EdgeInsets.all(10),
// //               decoration: BoxDecoration(
// //                   color: Colors.white.withOpacity(0.2),
// //                   borderRadius: BorderRadius.circular(12)),
// //               child: const Icon(Icons.videocam_rounded,
// //                   color: Colors.white, size: 24),
// //             ),
// //             SizedBox(width: size.customWidth(context) * 0.035),
// //             Expanded(
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text('Join Meeting',
// //                       style: GoogleFonts.poppins(
// //                           color: Colors.white,
// //                           fontSize: 16,
// //                           fontWeight: FontWeight.bold)),
// //                   Text('Tap to open Zoom meeting',
// //                       style: GoogleFonts.poppins(
// //                           color: Colors.white.withOpacity(0.8),
// //                           fontSize: 12)),
// //                 ],
// //               ),
// //             ),
// //             Row(
// //               children: [
// //                 GestureDetector(
// //                   onTap: () {
// //                     Clipboard.setData(ClipboardData(text: url));
// //                     Get.snackbar('Copied', 'Meeting link copied',
// //                         snackPosition: SnackPosition.BOTTOM,
// //                         backgroundColor: AppColors.textPrimaryColor,
// //                         colorText: Colors.white,
// //                         margin: const EdgeInsets.all(16),
// //                         borderRadius: 12,
// //                         duration: const Duration(seconds: 2));
// //                   },
// //                   child: Container(
// //                     padding: const EdgeInsets.all(8),
// //                     decoration: BoxDecoration(
// //                         color: Colors.white.withOpacity(0.15),
// //                         borderRadius: BorderRadius.circular(8)),
// //                     child: const Icon(Icons.copy_outlined,
// //                         color: Colors.white, size: 16),
// //                   ),
// //                 ),
// //                 const SizedBox(width: 8),
// //                 const Icon(Icons.open_in_new_rounded,
// //                     color: Colors.white, size: 20),
// //               ],
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _detailCard(
// //       BuildContext context, CustomSize size, MyAppointmentItem appt) {
// //     return _card(context, size,
// //         title: 'Appointment Details',
// //         icon: Icons.event_note_rounded,
// //         children: [
// //           _row(context, size, 'Date', appt.formattedDate,
// //               Icons.calendar_today_outlined),
// //           _row(context, size, 'Time', appt.formattedTime,
// //               Icons.access_time_rounded),
// //           _row(context, size, 'Duration', '${appt.durationMinutes} min',
// //               Icons.timer_outlined),
// //           _row(context, size, 'Mode',
// //               appt.bookedMode[0].toUpperCase() + appt.bookedMode.substring(1),
// //               _modeIcon(appt.bookedMode)),
// //           _row(context, size, 'Fee',
// //               '${appt.currency} ${appt.feeCharged.toStringAsFixed(0)}',
// //               Icons.payments_outlined),
// //         ]);
// //   }

// //   Widget _slotCard(
// //       BuildContext context, CustomSize size, AppointmentSlot slot) {
// //     return _card(context, size,
// //         title: 'Slot Information',
// //         icon: Icons.calendar_month_rounded,
// //         children: [
// //           _row(context, size, 'Slot Date', slot.slotDate,
// //               Icons.today_rounded),
// //           _row(context, size, 'Slot Time',
// //               '${slot.formattedStart} – ${slot.formattedEnd}',
// //               Icons.schedule_rounded),
// //           _row(context, size, 'Slot Mode',
// //               slot.mode[0].toUpperCase() + slot.mode.substring(1),
// //               _modeIcon(slot.mode)),
// //         ]);
// //   }

// //   Widget _expertCard(
// //       BuildContext context, CustomSize size, AppointmentExpert expert) {
// //     return _card(context, size,
// //         title: 'Expert Information',
// //         icon: Icons.person_outline_rounded,
// //         children: [
// //           _row(context, size, 'Name', expert.fullName,
// //               Icons.badge_outlined),
// //           _row(context, size, 'Specialization', expert.specialization,
// //               Icons.medical_information_outlined),
// //           if (expert.phone != null)
// //             _rowTappable(context, size, 'Phone', expert.phone!,
// //                 Icons.phone_outlined, () async {
// //               final uri = Uri(scheme: 'tel', path: expert.phone);
// //               if (await canLaunchUrl(uri)) await launchUrl(uri);
// //             }),
// //           if (expert.contactEmail != null)
// //             _rowTappable(context, size, 'Email', expert.contactEmail!,
// //                 Icons.email_outlined, () async {
// //               final uri = Uri(scheme: 'mailto', path: expert.contactEmail);
// //               if (await canLaunchUrl(uri)) await launchUrl(uri);
// //             }),
// //         ]);
// //   }

// //   Widget _cancellationCard(
// //       BuildContext context, CustomSize size, MyAppointmentItem appt) {
// //     return Container(
// //       padding: EdgeInsets.all(size.customWidth(context) * 0.045),
// //       decoration: BoxDecoration(
// //         color: AppColors.errorColor.withOpacity(0.05),
// //         borderRadius: BorderRadius.circular(18),
// //         border: Border.all(color: AppColors.errorColor.withOpacity(0.2)),
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Row(children: [
// //             const Icon(Icons.cancel_outlined,
// //                 color: AppColors.errorColor, size: 18),
// //             const SizedBox(width: 8),
// //             Text('Cancellation Info',
// //                 style: GoogleFonts.poppins(
// //                     fontSize: 14,
// //                     fontWeight: FontWeight.w600,
// //                     color: AppColors.errorColor)),
// //           ]),
// //           const SizedBox(height: 12),
// //           if (appt.cancelledBy != null)
// //             _row(context, size, 'By',
// //                 appt.cancelledBy![0].toUpperCase() +
// //                     appt.cancelledBy!.substring(1),
// //                 Icons.person_outlined),
// //           if (appt.cancellationReason != null)
// //             _row(context, size, 'Reason', appt.cancellationReason!,
// //                 Icons.info_outline_rounded),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _recordsSection(BuildContext context, CustomSize size) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Row(children: [
// //           Container(
// //               width: 4,
// //               height: 20,
// //               decoration: BoxDecoration(
// //                   color: AppColors.primaryColor,
// //                   borderRadius: BorderRadius.circular(2))),
// //           const SizedBox(width: 10),
// //           Text('Session Records',
// //               style: GoogleFonts.poppins(
// //                   fontSize: size.customWidth(context) * 0.042,
// //                   fontWeight: FontWeight.bold,
// //                   color: AppColors.textPrimaryColor)),
// //         ]),
// //         SizedBox(height: size.customHeight(context) * 0.015),
// //         Obx(() {
// //           if (_c.isLoadingRecords.value) {
// //             return const Center(
// //                 child: Padding(
// //               padding: EdgeInsets.all(24),
// //               child: CircularProgressIndicator(
// //                   color: AppColors.primaryColor, strokeWidth: 2),
// //             ));
// //           }
// //           if (_c.appointmentRecords.isEmpty) {
// //             return Container(
// //               padding: const EdgeInsets.all(24),
// //               decoration: BoxDecoration(
// //                 color: AppColors.whiteColor,
// //                 borderRadius: BorderRadius.circular(18),
// //                 boxShadow: [
// //                   BoxShadow(
// //                       color: Colors.black.withOpacity(0.04),
// //                       blurRadius: 8,
// //                       offset: const Offset(0, 2))
// //                 ],
// //               ),
// //               child: Center(
// //                 child: Column(
// //                   children: [
// //                     Icon(Icons.note_outlined,
// //                         size: 40,
// //                         color: AppColors.textSecondaryColor
// //                             .withOpacity(0.4)),
// //                     const SizedBox(height: 10),
// //                     Text('No session records yet',
// //                         style: GoogleFonts.poppins(
// //                             fontSize: 13,
// //                             color: AppColors.textSecondaryColor)),
// //                   ],
// //                 ),
// //               ),
// //             );
// //           }
// //           return Column(
// //             children: _c.appointmentRecords
// //                 .map((r) => _recordCard(context, size, r))
// //                 .toList(),
// //           );
// //         }),
// //       ],
// //     );
// //   }

// //   Widget _recordCard(BuildContext context, CustomSize size,
// //       AppointmentRecordItem record) {
// //     return Container(
// //       margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.014),
// //       padding: EdgeInsets.all(size.customWidth(context) * 0.042),
// //       decoration: BoxDecoration(
// //         color: AppColors.whiteColor,
// //         borderRadius: BorderRadius.circular(18),
// //         boxShadow: [
// //           BoxShadow(
// //               color: Colors.black.withOpacity(0.05),
// //               blurRadius: 10,
// //               offset: const Offset(0, 3))
// //         ],
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Row(
// //             children: [
// //               Container(
// //                   padding: const EdgeInsets.all(8),
// //                   decoration: BoxDecoration(
// //                       color: AppColors.primaryColor.withOpacity(0.1),
// //                       borderRadius: BorderRadius.circular(10)),
// //                   child: const Icon(Icons.description_outlined,
// //                       color: AppColors.primaryColor, size: 18)),
// //               const SizedBox(width: 10),
// //               Text('Session Note',
// //                   style: GoogleFonts.poppins(
// //                       fontSize: 14,
// //                       fontWeight: FontWeight.w600,
// //                       color: AppColors.textPrimaryColor)),
// //               const Spacer(),
// //               Text(record.formattedDate,
// //                   style: GoogleFonts.poppins(
// //                       fontSize: 11,
// //                       color: AppColors.textSecondaryColor)),
// //             ],
// //           ),
// //           SizedBox(height: size.customHeight(context) * 0.012),
// //           Divider(
// //               height: 1, color: AppColors.greyColor.withOpacity(0.15)),
// //           SizedBox(height: size.customHeight(context) * 0.012),
// //           _recordField('Notes', record.notes, Icons.notes_rounded),
// //           SizedBox(height: size.customHeight(context) * 0.008),
// //           _recordField('Therapy Plan', record.therapyPlan,
// //               Icons.health_and_safety_outlined),
// //           SizedBox(height: size.customHeight(context) * 0.008),
// //           _recordField('Progress', record.progressFeedback,
// //               Icons.trending_up_rounded),
// //           if (record.medication != null) ...[
// //             SizedBox(height: size.customHeight(context) * 0.008),
// //             _recordField(
// //                 'Medication',
// //                 record.medication!['name'] ?? 'None',
// //                 Icons.medication_outlined),
// //           ],
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _recordField(String label, String value, IconData icon) {
// //     return Row(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Icon(icon,
// //             size: 14,
// //             color: AppColors.primaryColor.withOpacity(0.7)),
// //         const SizedBox(width: 8),
// //         Expanded(
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Text(label,
// //                   style: GoogleFonts.poppins(
// //                       fontSize: 11,
// //                       color: AppColors.textSecondaryColor,
// //                       fontWeight: FontWeight.w500)),
// //               Text(value,
// //                   style: GoogleFonts.poppins(
// //                       fontSize: 13,
// //                       color: AppColors.textPrimaryColor)),
// //             ],
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   Widget _card(BuildContext context, CustomSize size,
// //       {required String title,
// //       required IconData icon,
// //       required List<Widget> children}) {
// //     return Container(
// //       padding: EdgeInsets.all(size.customWidth(context) * 0.045),
// //       decoration: BoxDecoration(
// //         color: AppColors.whiteColor,
// //         borderRadius: BorderRadius.circular(18),
// //         boxShadow: [
// //           BoxShadow(
// //               color: Colors.black.withOpacity(0.05),
// //               blurRadius: 10,
// //               offset: const Offset(0, 3))
// //         ],
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Row(children: [
// //             Container(
// //                 padding: const EdgeInsets.all(8),
// //                 decoration: BoxDecoration(
// //                     color: AppColors.primaryColor.withOpacity(0.1),
// //                     borderRadius: BorderRadius.circular(10)),
// //                 child: Icon(icon,
// //                     color: AppColors.primaryColor, size: 18)),
// //             const SizedBox(width: 10),
// //             Text(title,
// //                 style: GoogleFonts.poppins(
// //                     fontSize: 14,
// //                     fontWeight: FontWeight.w600,
// //                     color: AppColors.textPrimaryColor)),
// //           ]),
// //           SizedBox(height: size.customHeight(context) * 0.014),
// //           Divider(
// //               height: 1, color: AppColors.greyColor.withOpacity(0.15)),
// //           SizedBox(height: size.customHeight(context) * 0.012),
// //           ...children,
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _row(BuildContext context, CustomSize size, String label,
// //       String value, IconData icon) {
// //     return Padding(
// //       padding: EdgeInsets.only(bottom: size.customHeight(context) * 0.01),
// //       child: Row(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Icon(icon, size: 14, color: AppColors.textSecondaryColor),
// //           const SizedBox(width: 10),
// //           SizedBox(
// //             width: size.customWidth(context) * 0.22,
// //             child: Text(label,
// //                 style: GoogleFonts.poppins(
// //                     fontSize: 12,
// //                     color: AppColors.textSecondaryColor,
// //                     fontWeight: FontWeight.w500)),
// //           ),
// //           Expanded(
// //             child: Text(value,
// //                 style: GoogleFonts.poppins(
// //                     fontSize: 13,
// //                     color: AppColors.textPrimaryColor,
// //                     fontWeight: FontWeight.w500),
// //                 maxLines: 3,
// //                 overflow: TextOverflow.ellipsis),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _rowTappable(BuildContext context, CustomSize size, String label,
// //       String value, IconData icon, VoidCallback onTap) {
// //     return GestureDetector(
// //       onTap: onTap,
// //       child: Padding(
// //         padding:
// //             EdgeInsets.only(bottom: size.customHeight(context) * 0.01),
// //         child: Row(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Icon(icon, size: 14, color: AppColors.textSecondaryColor),
// //             const SizedBox(width: 10),
// //             SizedBox(
// //               width: size.customWidth(context) * 0.22,
// //               child: Text(label,
// //                   style: GoogleFonts.poppins(
// //                       fontSize: 12,
// //                       color: AppColors.textSecondaryColor,
// //                       fontWeight: FontWeight.w500)),
// //             ),
// //             Expanded(
// //               child: Text(value,
// //                   style: GoogleFonts.poppins(
// //                       fontSize: 13,
// //                       color: AppColors.accentColor,
// //                       fontWeight: FontWeight.w500),
// //                   maxLines: 2,
// //                   overflow: TextOverflow.ellipsis),
// //             ),
// //             const Icon(Icons.launch_rounded,
// //                 size: 14, color: AppColors.accentColor),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _loader() {
// //     return Scaffold(
// //       appBar: AppBar(
// //           backgroundColor: AppColors.whiteColor,
// //           elevation: 0,
// //           leading: IconButton(
// //               icon: const Icon(Icons.arrow_back_ios_new_rounded,
// //                   color: AppColors.textPrimaryColor),
// //               onPressed: () => Get.back())),
// //       body: const Center(
// //           child: CircularProgressIndicator(
// //               color: AppColors.primaryColor, strokeWidth: 3)),
// //     );
// //   }

// //   Widget _error() {
// //     return Scaffold(
// //       appBar: AppBar(
// //           backgroundColor: AppColors.whiteColor,
// //           elevation: 0,
// //           leading: IconButton(
// //               icon: const Icon(Icons.arrow_back_ios_new_rounded,
// //                   color: AppColors.textPrimaryColor),
// //               onPressed: () => Get.back())),
// //       body: Center(
// //           child: Text('Appointment not found',
// //               style: GoogleFonts.poppins(
// //                   color: AppColors.textSecondaryColor))),
// //     );
// //   }

// //   _StatusMeta _statusMeta(String status) {
// //     switch (status.toLowerCase()) {
// //       case 'confirmed':
// //         return _StatusMeta(AppColors.primaryColor, 'Confirmed');
// //       case 'completed':
// //         return _StatusMeta(AppColors.successColor, 'Completed');
// //       case 'cancelled':
// //         return _StatusMeta(AppColors.errorColor, 'Cancelled');
// //       case 'no_show':
// //         return _StatusMeta(AppColors.greyColor, 'No Show');
// //       default:
// //         return _StatusMeta(AppColors.warningColor, 'Scheduled');
// //     }
// //   }

// //   IconData _modeIcon(String mode) {
// //     switch (mode.toLowerCase()) {
// //       case 'online':
// //         return Icons.videocam_outlined;
// //       case 'physical':
// //         return Icons.location_on_outlined;
// //       default:
// //         return Icons.swap_horiz_rounded;
// //     }
// //   }
// // }


// // // lib/view/parent/booking/parent_my_appointments_screen.dart
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:get/get.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:url_launcher/url_launcher.dart';
// // import 'package:speechspectrum/constants/app_colors.dart';
// // import 'package:speechspectrum/constants/custom_size.dart';
// // import 'package:speechspectrum/controllers/parent_booking_controller.dart';
// // import 'package:speechspectrum/models/my_appointment_model.dart';
// // import 'package:speechspectrum/routes/app_routes.dart';

// // class ParentMyAppointmentsScreen extends StatefulWidget {
// //   const ParentMyAppointmentsScreen({super.key});

// //   @override
// //   State<ParentMyAppointmentsScreen> createState() =>
// //       _ParentMyAppointmentsScreenState();
// // }

// // class _ParentMyAppointmentsScreenState
// //     extends State<ParentMyAppointmentsScreen>
// //     with SingleTickerProviderStateMixin {
// //   late final ParentBookingController _c;
// //   late final TabController _tab;

// //   static const _tabs = [
// //     ('All', Icons.list_alt_rounded),
// //     ('Scheduled', Icons.schedule_rounded),
// //     ('Confirmed', Icons.check_circle_outline_rounded),
// //     ('Completed', Icons.task_alt_rounded),
// //     ('Cancelled', Icons.cancel_outlined),
// //     ('No Show', Icons.person_off_outlined),
// //   ];

// //   @override
// //   void initState() {
// //     super.initState();
// //     _tab = TabController(length: _tabs.length, vsync: this);
// //     _c = Get.isRegistered<ParentBookingController>()
// //         ? Get.find<ParentBookingController>()
// //         : Get.put(ParentBookingController());
// //     WidgetsBinding.instance.addPostFrameCallback((_) {
// //       _c.fetchMyAppointments();
// //     });
// //   }

// //   @override
// //   void dispose() {
// //     _tab.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final size = CustomSize();

// //     return Scaffold(
// //       backgroundColor: AppColors.lightGreyColor,
// //       appBar: AppBar(
// //         backgroundColor: AppColors.whiteColor,
// //         elevation: 0,
// //         surfaceTintColor: Colors.transparent,
// //         leading: IconButton(
// //           icon: const Icon(Icons.arrow_back_ios_new_rounded,
// //               color: AppColors.textPrimaryColor, size: 20),
// //           onPressed: () => Get.back(),
// //         ),
// //         title: Text('My Appointments',
// //             style: GoogleFonts.poppins(
// //                 color: AppColors.textPrimaryColor,
// //                 fontSize: 18,
// //                 fontWeight: FontWeight.w600)),
// //         actions: [
// //           Obx(() => _c.isLoadingAppointments.value
// //               ? const Padding(
// //                   padding: EdgeInsets.all(16),
// //                   child: SizedBox(
// //                       width: 20,
// //                       height: 20,
// //                       child: CircularProgressIndicator(
// //                           color: AppColors.primaryColor, strokeWidth: 2)))
// //               : IconButton(
// //                   icon: const Icon(Icons.refresh_rounded,
// //                       color: AppColors.primaryColor),
// //                   onPressed: _c.fetchMyAppointments)),
// //           const SizedBox(width: 4),
// //         ],
// //         bottom: TabBar(
// //           controller: _tab,
// //           isScrollable: true,
// //           tabAlignment: TabAlignment.start,
// //           labelColor: AppColors.primaryColor,
// //           unselectedLabelColor: AppColors.textSecondaryColor,
// //           indicatorColor: AppColors.primaryColor,
// //           indicatorWeight: 2.5,
// //           labelPadding:
// //               const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
// //           labelStyle:
// //               GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13),
// //           unselectedLabelStyle:
// //               GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 13),
// //           tabs: _tabs
// //               .map((t) => Tab(
// //                     child: Row(
// //                       mainAxisSize: MainAxisSize.min,
// //                       children: [
// //                         Icon(t.$2, size: 14),
// //                         const SizedBox(width: 5),
// //                         Text(t.$1),
// //                       ],
// //                     ),
// //                   ))
// //               .toList(),
// //         ),
// //       ),
// //       body: Obx(() {
// //         if (_c.isLoadingAppointments.value && _c.myAppointments.isEmpty) {
// //           return _loader(context, size);
// //         }
// //         return TabBarView(
// //           controller: _tab,
// //           children: [
// //             _list(context, size, _c.myAppointments),
// //             _list(context, size, _c.scheduledList),
// //             _list(context, size, _c.confirmedList),
// //             _list(context, size, _c.completedList),
// //             _list(context, size, _c.cancelledList),
// //             _list(context, size, _c.noShowList),
// //           ],
// //         );
// //       }),
// //     );
// //   }

// //   Widget _list(
// //       BuildContext context, CustomSize size, List<MyAppointmentItem> items) {
// //     if (items.isEmpty) return _empty(context, size);
// //     return RefreshIndicator(
// //       color: AppColors.primaryColor,
// //       onRefresh: _c.fetchMyAppointments,
// //       child: ListView.builder(
// //         padding: EdgeInsets.fromLTRB(
// //           size.customWidth(context) * 0.045,
// //           size.customHeight(context) * 0.02,
// //           size.customWidth(context) * 0.045,
// //           size.customHeight(context) * 0.04,
// //         ),
// //         itemCount: items.length,
// //         itemBuilder: (_, i) => _card(context, size, items[i]),
// //       ),
// //     );
// //   }

// //   Widget _card(
// //       BuildContext context, CustomSize size, MyAppointmentItem appt) {
// //     final meta = _statusMeta(appt.status);

// //     return GestureDetector(
// //       onTap: () => Get.toNamed(
// //         AppRoutes.parentAppointmentDetail,
// //         arguments: appt.appointmentId,
// //       ),
// //       child: Container(
// //         margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.016),
// //         decoration: BoxDecoration(
// //           color: AppColors.whiteColor,
// //           borderRadius: BorderRadius.circular(20),
// //           boxShadow: [
// //             BoxShadow(
// //                 color: Colors.black.withOpacity(0.06),
// //                 blurRadius: 14,
// //                 offset: const Offset(0, 4))
// //           ],
// //         ),
// //         child: Column(
// //           children: [
// //             Container(
// //               height: 4,
// //               decoration: BoxDecoration(
// //                 color: meta.color,
// //                 borderRadius:
// //                     const BorderRadius.vertical(top: Radius.circular(20)),
// //               ),
// //             ),
// //             Padding(
// //               padding: EdgeInsets.all(size.customWidth(context) * 0.042),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Row(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       // Avatar
// //                       Container(
// //                         width: 50,
// //                         height: 50,
// //                         decoration: BoxDecoration(
// //                           gradient: LinearGradient(
// //                             colors: [
// //                               AppColors.primaryColor.withOpacity(0.7),
// //                               AppColors.primaryColor
// //                             ],
// //                           ),
// //                           borderRadius: BorderRadius.circular(14),
// //                         ),
// //                         child: Center(
// //                           child: Text(appt.childInitials,
// //                               style: GoogleFonts.poppins(
// //                                   color: Colors.white,
// //                                   fontSize: 16,
// //                                   fontWeight: FontWeight.bold)),
// //                         ),
// //                       ),
// //                       SizedBox(width: size.customWidth(context) * 0.03),
// //                       Expanded(
// //                         child: Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             Text(
// //                               appt.children?.childName ?? 'Child',
// //                               style: GoogleFonts.poppins(
// //                                   fontSize: size.customWidth(context) * 0.04,
// //                                   fontWeight: FontWeight.w700,
// //                                   color: AppColors.textPrimaryColor),
// //                               maxLines: 1,
// //                               overflow: TextOverflow.ellipsis,
// //                             ),
// //                             Text(
// //                               appt.expertUsers?.fullName ?? '',
// //                               style: GoogleFonts.poppins(
// //                                   fontSize:
// //                                       size.customWidth(context) * 0.031,
// //                                   color: AppColors.primaryColor,
// //                                   fontWeight: FontWeight.w500),
// //                               maxLines: 1,
// //                               overflow: TextOverflow.ellipsis,
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                       Container(
// //                         padding: const EdgeInsets.symmetric(
// //                             horizontal: 10, vertical: 4),
// //                         decoration: BoxDecoration(
// //                           color: meta.color.withOpacity(0.1),
// //                           borderRadius: BorderRadius.circular(20),
// //                         ),
// //                         child: Text(meta.label,
// //                             style: GoogleFonts.poppins(
// //                                 fontSize: 10,
// //                                 fontWeight: FontWeight.w600,
// //                                 color: meta.color)),
// //                       ),
// //                     ],
// //                   ),
// //                   SizedBox(height: size.customHeight(context) * 0.012),
// //                   Divider(
// //                       height: 1,
// //                       color: AppColors.greyColor.withOpacity(0.15)),
// //                   SizedBox(height: size.customHeight(context) * 0.01),
// //                   Wrap(
// //                     spacing: 14,
// //                     runSpacing: 6,
// //                     children: [
// //                       _chip2(Icons.calendar_today_outlined,
// //                           appt.formattedDate, AppColors.primaryColor),
// //                       _chip2(Icons.access_time_rounded, appt.formattedTime,
// //                           AppColors.secondaryColor),
// //                       _chip2(
// //                           _modeIcon(appt.bookedMode),
// //                           appt.bookedMode[0].toUpperCase() +
// //                               appt.bookedMode.substring(1),
// //                           AppColors.accentColor),
// //                       _chip2(
// //                           Icons.payments_outlined,
// //                           '${appt.currency} ${appt.feeCharged.toStringAsFixed(0)}',
// //                           AppColors.warningColor),
// //                     ],
// //                   ),
// //                   // Meet link
// //                   if (appt.meetLink != null &&
// //                       appt.meetLink!.isNotEmpty) ...[
// //                     SizedBox(height: size.customHeight(context) * 0.01),
// //                     _meetLinkBanner(context, size, appt.meetLink!),
// //                   ],
// //                   // Cancellation reason
// //                   if (appt.isCancelled &&
// //                       appt.cancellationReason != null) ...[
// //                     SizedBox(height: size.customHeight(context) * 0.01),
// //                     Container(
// //                       padding: const EdgeInsets.symmetric(
// //                           horizontal: 10, vertical: 7),
// //                       decoration: BoxDecoration(
// //                         color: AppColors.errorColor.withOpacity(0.06),
// //                         borderRadius: BorderRadius.circular(10),
// //                       ),
// //                       child: Row(children: [
// //                         const Icon(Icons.info_outline_rounded,
// //                             size: 13, color: AppColors.errorColor),
// //                         const SizedBox(width: 6),
// //                         Expanded(
// //                           child: Text(appt.cancellationReason!,
// //                               style: GoogleFonts.poppins(
// //                                   fontSize: 12,
// //                                   color: AppColors.errorColor),
// //                               maxLines: 2,
// //                               overflow: TextOverflow.ellipsis),
// //                         ),
// //                       ]),
// //                     ),
// //                   ],
// //                   // No Show info banner
// //                   if (appt.isNoShow) ...[
// //                     SizedBox(height: size.customHeight(context) * 0.01),
// //                     Container(
// //                       padding: const EdgeInsets.symmetric(
// //                           horizontal: 10, vertical: 7),
// //                       decoration: BoxDecoration(
// //                         color: AppColors.greyColor.withOpacity(0.08),
// //                         borderRadius: BorderRadius.circular(10),
// //                         border: Border.all(
// //                             color: AppColors.greyColor.withOpacity(0.3)),
// //                       ),
// //                       child: Row(children: [
// //                         Icon(Icons.person_off_outlined,
// //                             size: 13, color: AppColors.greyColor),
// //                         const SizedBox(width: 6),
// //                         Expanded(
// //                           child: Text(
// //                             'Patient did not attend this session',
// //                             style: GoogleFonts.poppins(
// //                                 fontSize: 12, color: AppColors.greyColor),
// //                           ),
// //                         ),
// //                       ]),
// //                     ),
// //                   ],
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _meetLinkBanner(
// //       BuildContext context, CustomSize size, String url) {
// //     return GestureDetector(
// //       onTap: () async {
// //         final uri = Uri.tryParse(url);
// //         if (uri != null && await canLaunchUrl(uri)) {
// //           await launchUrl(uri, mode: LaunchMode.externalApplication);
// //         }
// //       },
// //       child: Container(
// //         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
// //         decoration: BoxDecoration(
// //           color: const Color(0xFF2196F3).withOpacity(0.07),
// //           borderRadius: BorderRadius.circular(12),
// //           border: Border.all(
// //               color: const Color(0xFF2196F3).withOpacity(0.3), width: 1),
// //         ),
// //         child: Row(
// //           children: [
// //             const Icon(Icons.videocam_rounded,
// //                 color: Color(0xFF2196F3), size: 18),
// //             const SizedBox(width: 8),
// //             Expanded(
// //               child: Text(
// //                 'Join Meeting',
// //                 style: GoogleFonts.poppins(
// //                     fontSize: 13,
// //                     color: const Color(0xFF2196F3),
// //                     fontWeight: FontWeight.w600),
// //               ),
// //             ),
// //             GestureDetector(
// //               onTap: () {
// //                 Clipboard.setData(ClipboardData(text: url));
// //                 Get.snackbar('Copied', 'Meeting link copied',
// //                     snackPosition: SnackPosition.BOTTOM,
// //                     backgroundColor: AppColors.textPrimaryColor,
// //                     colorText: Colors.white,
// //                     margin: const EdgeInsets.all(16),
// //                     borderRadius: 12,
// //                     duration: const Duration(seconds: 2));
// //               },
// //               child: const Icon(Icons.copy_outlined,
// //                   size: 15, color: Color(0xFF2196F3)),
// //             ),
// //             const SizedBox(width: 4),
// //             const Icon(Icons.open_in_new_rounded,
// //                 size: 15, color: Color(0xFF2196F3)),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _chip2(IconData icon, String label, Color color) {
// //     return Row(
// //       mainAxisSize: MainAxisSize.min,
// //       children: [
// //         Icon(icon, size: 13, color: color),
// //         const SizedBox(width: 4),
// //         Text(label,
// //             style: GoogleFonts.poppins(
// //                 fontSize: 12,
// //                 color: AppColors.textSecondaryColor,
// //                 fontWeight: FontWeight.w500)),
// //       ],
// //     );
// //   }

// //   Widget _loader(BuildContext context, CustomSize size) {
// //     return Center(
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           const CircularProgressIndicator(
// //               color: AppColors.primaryColor, strokeWidth: 3),
// //           SizedBox(height: size.customHeight(context) * 0.02),
// //           Text('Loading appointments...',
// //               style: GoogleFonts.poppins(
// //                   color: AppColors.textSecondaryColor,
// //                   fontSize: size.customWidth(context) * 0.036)),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _empty(BuildContext context, CustomSize size) {
// //     return Center(
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           Container(
// //             width: 110,
// //             height: 110,
// //             decoration: BoxDecoration(
// //                 color: AppColors.primaryColor.withOpacity(0.07),
// //                 shape: BoxShape.circle),
// //             child: const Icon(Icons.event_busy_outlined,
// //                 size: 52, color: AppColors.primaryColor),
// //           ),
// //           SizedBox(height: size.customHeight(context) * 0.025),
// //           Text('No appointments here',
// //               style: GoogleFonts.poppins(
// //                   fontSize: size.customWidth(context) * 0.044,
// //                   fontWeight: FontWeight.bold,
// //                   color: AppColors.textPrimaryColor)),
// //           SizedBox(height: size.customHeight(context) * 0.008),
// //           Text('Nothing in this category',
// //               style: GoogleFonts.poppins(
// //                   fontSize: size.customWidth(context) * 0.033,
// //                   color: AppColors.textSecondaryColor)),
// //         ],
// //       ),
// //     );
// //   }

// //   _StatusMeta _statusMeta(String status) {
// //     switch (status.toLowerCase()) {
// //       case 'confirmed':
// //         return _StatusMeta(AppColors.primaryColor, 'Confirmed');
// //       case 'completed':
// //         return _StatusMeta(AppColors.successColor, 'Completed');
// //       case 'cancelled':
// //         return _StatusMeta(AppColors.errorColor, 'Cancelled');
// //       case 'no_show':
// //         return _StatusMeta(AppColors.greyColor, 'No Show');
// //       default:
// //         return _StatusMeta(AppColors.warningColor, 'Scheduled');
// //     }
// //   }

// //   IconData _modeIcon(String mode) {
// //     switch (mode.toLowerCase()) {
// //       case 'online':
// //         return Icons.videocam_outlined;
// //       case 'physical':
// //         return Icons.location_on_outlined;
// //       default:
// //         return Icons.swap_horiz_rounded;
// //     }
// //   }
// // }

// // // ═══════════════════════════════════════════════════════════════
// // //   Parent Appointment Detail Screen
// // // ═══════════════════════════════════════════════════════════════
// // class ParentAppointmentDetailScreen extends StatefulWidget {
// //   const ParentAppointmentDetailScreen({super.key});

// //   @override
// //   State<ParentAppointmentDetailScreen> createState() =>
// //       _ParentAppointmentDetailScreenState();
// // }

// // class _ParentAppointmentDetailScreenState
// //     extends State<ParentAppointmentDetailScreen> {
// //   late final ParentBookingController _c;
// //   late final String _appointmentId;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _c = Get.find<ParentBookingController>();
// //     _appointmentId = Get.arguments as String;
// //     WidgetsBinding.instance.addPostFrameCallback((_) {
// //       _c.fetchAppointmentDetail(_appointmentId);
// //       _c.fetchAppointmentRecords(_appointmentId);
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final size = CustomSize();

// //     return Scaffold(
// //       backgroundColor: AppColors.lightGreyColor,
// //       body: Obx(() {
// //         if (_c.isLoadingDetail.value) return _loader();
// //         final appt = _c.selectedAppointment.value;
// //         if (appt == null) return _error();
// //         return _content(context, size, appt);
// //       }),
// //     );
// //   }

// //   Widget _content(
// //       BuildContext context, CustomSize size, MyAppointmentItem appt) {
// //     final meta = _statusMeta(appt.status);

// //     return CustomScrollView(
// //       slivers: [
// //         SliverAppBar(
// //           expandedHeight: size.customHeight(context) * 0.24,
// //           pinned: true,
// //           backgroundColor: AppColors.primaryColor,
// //           surfaceTintColor: Colors.transparent,
// //           leading: GestureDetector(
// //             onTap: () => Get.back(),
// //             child: Container(
// //               margin: const EdgeInsets.all(8),
// //               decoration: BoxDecoration(
// //                   color: Colors.white.withOpacity(0.15),
// //                   borderRadius: BorderRadius.circular(12)),
// //               child: const Icon(Icons.arrow_back_ios_new_rounded,
// //                   color: Colors.white, size: 18),
// //             ),
// //           ),
// //           flexibleSpace: FlexibleSpaceBar(
// //             background: Container(
// //               decoration: const BoxDecoration(
// //                 gradient: LinearGradient(
// //                   colors: [AppColors.primaryColor, AppColors.secondaryColor],
// //                   begin: Alignment.topLeft,
// //                   end: Alignment.bottomRight,
// //                 ),
// //               ),
// //               child: SafeArea(
// //                 child: Padding(
// //                   padding: EdgeInsets.fromLTRB(
// //                     size.customWidth(context) * 0.05,
// //                     size.customHeight(context) * 0.06,
// //                     size.customWidth(context) * 0.05,
// //                     16,
// //                   ),
// //                   child: Row(
// //                     children: [
// //                       Container(
// //                         width: 64,
// //                         height: 64,
// //                         decoration: BoxDecoration(
// //                             color: Colors.white.withOpacity(0.2),
// //                             borderRadius: BorderRadius.circular(18)),
// //                         child: Center(
// //                           child: Text(appt.childInitials,
// //                               style: GoogleFonts.poppins(
// //                                   color: Colors.white,
// //                                   fontSize: 24,
// //                                   fontWeight: FontWeight.bold)),
// //                         ),
// //                       ),
// //                       SizedBox(width: size.customWidth(context) * 0.04),
// //                       Expanded(
// //                         child: Column(
// //                           mainAxisSize: MainAxisSize.min,
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             Text(
// //                               appt.children?.childName ?? 'Unknown',
// //                               style: GoogleFonts.poppins(
// //                                   color: Colors.white,
// //                                   fontSize:
// //                                       size.customWidth(context) * 0.044,
// //                                   fontWeight: FontWeight.bold),
// //                             ),
// //                             Text(
// //                               appt.expertUsers?.fullName ?? '',
// //                               style: GoogleFonts.poppins(
// //                                   color: Colors.white.withOpacity(0.85),
// //                                   fontSize:
// //                                       size.customWidth(context) * 0.031),
// //                             ),
// //                             const SizedBox(height: 6),
// //                             Container(
// //                               padding: const EdgeInsets.symmetric(
// //                                   horizontal: 12, vertical: 4),
// //                               decoration: BoxDecoration(
// //                                 color: meta.color.withOpacity(0.2),
// //                                 borderRadius: BorderRadius.circular(20),
// //                                 border: Border.all(
// //                                     color: Colors.white.withOpacity(0.4)),
// //                               ),
// //                               child: Row(
// //                                 mainAxisSize: MainAxisSize.min,
// //                                 children: [
// //                                   Icon(meta.icon,
// //                                       color: Colors.white, size: 12),
// //                                   const SizedBox(width: 5),
// //                                   Text(meta.label,
// //                                       style: GoogleFonts.poppins(
// //                                           color: Colors.white,
// //                                           fontSize: 12,
// //                                           fontWeight: FontWeight.w600)),
// //                                 ],
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ),

// //         SliverPadding(
// //           padding: EdgeInsets.fromLTRB(
// //             size.customWidth(context) * 0.045,
// //             size.customHeight(context) * 0.02,
// //             size.customWidth(context) * 0.045,
// //             size.customHeight(context) * 0.06,
// //           ),
// //           sliver: SliverList(
// //             delegate: SliverChildListDelegate([
// //               // Meet link prominent banner
// //               if (appt.meetLink != null && appt.meetLink!.isNotEmpty) ...[
// //                 _meetLinkCard(context, size, appt.meetLink!),
// //                 SizedBox(height: size.customHeight(context) * 0.018),
// //               ],

// //               // No Show info card
// //               if (appt.isNoShow) ...[
// //                 _noShowCard(context, size),
// //                 SizedBox(height: size.customHeight(context) * 0.018),
// //               ],

// //               // Appointment details card
// //               _detailCard(context, size, appt),
// //               SizedBox(height: size.customHeight(context) * 0.018),

// //               // Slot info
// //               if (appt.appointmentSlots != null) ...[
// //                 _slotCard(context, size, appt.appointmentSlots!),
// //                 SizedBox(height: size.customHeight(context) * 0.018),
// //               ],

// //               // Expert info
// //               if (appt.expertUsers != null) ...[
// //                 _expertCard(context, size, appt.expertUsers!),
// //                 SizedBox(height: size.customHeight(context) * 0.018),
// //               ],

// //               // Cancellation
// //               if (appt.isCancelled) ...[
// //                 _cancellationCard(context, size, appt),
// //                 SizedBox(height: size.customHeight(context) * 0.018),
// //               ],

// //               // Session records (only for completed)
// //               if (appt.isCompleted) ...[
// //                 _recordsSection(context, size),
// //                 SizedBox(height: size.customHeight(context) * 0.04),
// //               ],
// //             ]),
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   Widget _noShowCard(BuildContext context, CustomSize size) {
// //     return Container(
// //       padding: EdgeInsets.all(size.customWidth(context) * 0.045),
// //       decoration: BoxDecoration(
// //         color: AppColors.greyColor.withOpacity(0.07),
// //         borderRadius: BorderRadius.circular(18),
// //         border: Border.all(color: AppColors.greyColor.withOpacity(0.3)),
// //       ),
// //       child: Row(
// //         children: [
// //           Container(
// //             padding: const EdgeInsets.all(10),
// //             decoration: BoxDecoration(
// //                 color: AppColors.greyColor.withOpacity(0.12),
// //                 borderRadius: BorderRadius.circular(12)),
// //             child: Icon(Icons.person_off_outlined,
// //                 color: AppColors.greyColor, size: 22),
// //           ),
// //           const SizedBox(width: 14),
// //           Expanded(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   'No Show',
// //                   style: GoogleFonts.poppins(
// //                       fontSize: 14,
// //                       fontWeight: FontWeight.bold,
// //                       color: AppColors.greyColor),
// //                 ),
// //                 const SizedBox(height: 2),
// //                 Text(
// //                   'The patient did not attend this scheduled session.',
// //                   style: GoogleFonts.poppins(
// //                       fontSize: 12,
// //                       color: AppColors.greyColor.withOpacity(0.8)),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _meetLinkCard(
// //       BuildContext context, CustomSize size, String url) {
// //     return GestureDetector(
// //       onTap: () async {
// //         final uri = Uri.tryParse(url);
// //         if (uri != null && await canLaunchUrl(uri)) {
// //           await launchUrl(uri, mode: LaunchMode.externalApplication);
// //         }
// //       },
// //       child: Container(
// //         padding: EdgeInsets.all(size.customWidth(context) * 0.04),
// //         decoration: BoxDecoration(
// //           gradient: const LinearGradient(
// //             colors: [Color(0xFF2196F3), Color(0xFF1565C0)],
// //             begin: Alignment.topLeft,
// //             end: Alignment.bottomRight,
// //           ),
// //           borderRadius: BorderRadius.circular(18),
// //           boxShadow: [
// //             BoxShadow(
// //                 color: const Color(0xFF2196F3).withOpacity(0.3),
// //                 blurRadius: 14,
// //                 offset: const Offset(0, 4))
// //           ],
// //         ),
// //         child: Row(
// //           children: [
// //             Container(
// //               padding: const EdgeInsets.all(10),
// //               decoration: BoxDecoration(
// //                   color: Colors.white.withOpacity(0.2),
// //                   borderRadius: BorderRadius.circular(12)),
// //               child: const Icon(Icons.videocam_rounded,
// //                   color: Colors.white, size: 24),
// //             ),
// //             SizedBox(width: size.customWidth(context) * 0.035),
// //             Expanded(
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text('Join Meeting',
// //                       style: GoogleFonts.poppins(
// //                           color: Colors.white,
// //                           fontSize: 16,
// //                           fontWeight: FontWeight.bold)),
// //                   Text('Tap to open meeting',
// //                       style: GoogleFonts.poppins(
// //                           color: Colors.white.withOpacity(0.8),
// //                           fontSize: 12)),
// //                 ],
// //               ),
// //             ),
// //             Row(
// //               children: [
// //                 GestureDetector(
// //                   onTap: () {
// //                     Clipboard.setData(ClipboardData(text: url));
// //                     Get.snackbar('Copied', 'Meeting link copied',
// //                         snackPosition: SnackPosition.BOTTOM,
// //                         backgroundColor: AppColors.textPrimaryColor,
// //                         colorText: Colors.white,
// //                         margin: const EdgeInsets.all(16),
// //                         borderRadius: 12,
// //                         duration: const Duration(seconds: 2));
// //                   },
// //                   child: Container(
// //                     padding: const EdgeInsets.all(8),
// //                     decoration: BoxDecoration(
// //                         color: Colors.white.withOpacity(0.15),
// //                         borderRadius: BorderRadius.circular(8)),
// //                     child: const Icon(Icons.copy_outlined,
// //                         color: Colors.white, size: 16),
// //                   ),
// //                 ),
// //                 const SizedBox(width: 8),
// //                 const Icon(Icons.open_in_new_rounded,
// //                     color: Colors.white, size: 20),
// //               ],
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _detailCard(
// //       BuildContext context, CustomSize size, MyAppointmentItem appt) {
// //     return _card(context, size,
// //         title: 'Appointment Details',
// //         icon: Icons.event_note_rounded,
// //         children: [
// //           _row(context, size, 'Date', appt.formattedDate,
// //               Icons.calendar_today_outlined),
// //           _row(context, size, 'Time', appt.formattedTime,
// //               Icons.access_time_rounded),
// //           _row(context, size, 'Duration', '${appt.durationMinutes} min',
// //               Icons.timer_outlined),
// //           _row(
// //               context,
// //               size,
// //               'Mode',
// //               appt.bookedMode[0].toUpperCase() + appt.bookedMode.substring(1),
// //               _modeIcon(appt.bookedMode)),
// //           _row(
// //               context,
// //               size,
// //               'Fee',
// //               '${appt.currency} ${appt.feeCharged.toStringAsFixed(0)}',
// //               Icons.payments_outlined),
// //         ]);
// //   }

// //   Widget _slotCard(
// //       BuildContext context, CustomSize size, AppointmentSlot slot) {
// //     return _card(context, size,
// //         title: 'Slot Information',
// //         icon: Icons.calendar_month_rounded,
// //         children: [
// //           _row(context, size, 'Slot Date', slot.slotDate,
// //               Icons.today_rounded),
// //           _row(context, size, 'Slot Time',
// //               '${slot.formattedStart} – ${slot.formattedEnd}',
// //               Icons.schedule_rounded),
// //           _row(
// //               context,
// //               size,
// //               'Slot Mode',
// //               slot.mode[0].toUpperCase() + slot.mode.substring(1),
// //               _modeIcon(slot.mode)),
// //         ]);
// //   }

// //   Widget _expertCard(
// //       BuildContext context, CustomSize size, AppointmentExpert expert) {
// //     return _card(context, size,
// //         title: 'Expert Information',
// //         icon: Icons.person_outline_rounded,
// //         children: [
// //           _row(context, size, 'Name', expert.fullName, Icons.badge_outlined),
// //           _row(context, size, 'Specialization', expert.specialization,
// //               Icons.medical_information_outlined),
// //           if (expert.phone != null)
// //             _rowTappable(context, size, 'Phone', expert.phone!,
// //                 Icons.phone_outlined, () async {
// //               final uri = Uri(scheme: 'tel', path: expert.phone);
// //               if (await canLaunchUrl(uri)) await launchUrl(uri);
// //             }),
// //           if (expert.contactEmail != null)
// //             _rowTappable(context, size, 'Email', expert.contactEmail!,
// //                 Icons.email_outlined, () async {
// //               final uri = Uri(scheme: 'mailto', path: expert.contactEmail);
// //               if (await canLaunchUrl(uri)) await launchUrl(uri);
// //             }),
// //         ]);
// //   }

// //   Widget _cancellationCard(
// //       BuildContext context, CustomSize size, MyAppointmentItem appt) {
// //     return Container(
// //       padding: EdgeInsets.all(size.customWidth(context) * 0.045),
// //       decoration: BoxDecoration(
// //         color: AppColors.errorColor.withOpacity(0.05),
// //         borderRadius: BorderRadius.circular(18),
// //         border: Border.all(color: AppColors.errorColor.withOpacity(0.2)),
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Row(children: [
// //             const Icon(Icons.cancel_outlined,
// //                 color: AppColors.errorColor, size: 18),
// //             const SizedBox(width: 8),
// //             Text('Cancellation Info',
// //                 style: GoogleFonts.poppins(
// //                     fontSize: 14,
// //                     fontWeight: FontWeight.w600,
// //                     color: AppColors.errorColor)),
// //           ]),
// //           const SizedBox(height: 12),
// //           if (appt.cancelledBy != null)
// //             _row(
// //                 context,
// //                 size,
// //                 'By',
// //                 appt.cancelledBy![0].toUpperCase() +
// //                     appt.cancelledBy!.substring(1),
// //                 Icons.person_outlined),
// //           if (appt.cancellationReason != null)
// //             _row(context, size, 'Reason', appt.cancellationReason!,
// //                 Icons.info_outline_rounded),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _recordsSection(BuildContext context, CustomSize size) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Row(children: [
// //           Container(
// //               width: 4,
// //               height: 20,
// //               decoration: BoxDecoration(
// //                   color: AppColors.primaryColor,
// //                   borderRadius: BorderRadius.circular(2))),
// //           const SizedBox(width: 10),
// //           Text('Session Records',
// //               style: GoogleFonts.poppins(
// //                   fontSize: size.customWidth(context) * 0.042,
// //                   fontWeight: FontWeight.bold,
// //                   color: AppColors.textPrimaryColor)),
// //         ]),
// //         SizedBox(height: size.customHeight(context) * 0.015),
// //         Obx(() {
// //           if (_c.isLoadingRecords.value) {
// //             return const Center(
// //                 child: Padding(
// //               padding: EdgeInsets.all(24),
// //               child: CircularProgressIndicator(
// //                   color: AppColors.primaryColor, strokeWidth: 2),
// //             ));
// //           }
// //           if (_c.appointmentRecords.isEmpty) {
// //             return Container(
// //               padding: const EdgeInsets.all(24),
// //               decoration: BoxDecoration(
// //                 color: AppColors.whiteColor,
// //                 borderRadius: BorderRadius.circular(18),
// //                 boxShadow: [
// //                   BoxShadow(
// //                       color: Colors.black.withOpacity(0.04),
// //                       blurRadius: 8,
// //                       offset: const Offset(0, 2))
// //                 ],
// //               ),
// //               child: Center(
// //                 child: Column(
// //                   children: [
// //                     Icon(Icons.note_outlined,
// //                         size: 40,
// //                         color:
// //                             AppColors.textSecondaryColor.withOpacity(0.4)),
// //                     const SizedBox(height: 10),
// //                     Text('No session records yet',
// //                         style: GoogleFonts.poppins(
// //                             fontSize: 13,
// //                             color: AppColors.textSecondaryColor)),
// //                   ],
// //                 ),
// //               ),
// //             );
// //           }
// //           return Column(
// //             children: _c.appointmentRecords
// //                 .map((r) => _recordCard(context, size, r))
// //                 .toList(),
// //           );
// //         }),
// //       ],
// //     );
// //   }

// //   Widget _recordCard(BuildContext context, CustomSize size,
// //       AppointmentRecordItem record) {
// //     return Container(
// //       margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.014),
// //       padding: EdgeInsets.all(size.customWidth(context) * 0.042),
// //       decoration: BoxDecoration(
// //         color: AppColors.whiteColor,
// //         borderRadius: BorderRadius.circular(18),
// //         boxShadow: [
// //           BoxShadow(
// //               color: Colors.black.withOpacity(0.05),
// //               blurRadius: 10,
// //               offset: const Offset(0, 3))
// //         ],
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Row(
// //             children: [
// //               Container(
// //                   padding: const EdgeInsets.all(8),
// //                   decoration: BoxDecoration(
// //                       color: AppColors.primaryColor.withOpacity(0.1),
// //                       borderRadius: BorderRadius.circular(10)),
// //                   child: const Icon(Icons.description_outlined,
// //                       color: AppColors.primaryColor, size: 18)),
// //               const SizedBox(width: 10),
// //               Text('Session Note',
// //                   style: GoogleFonts.poppins(
// //                       fontSize: 14,
// //                       fontWeight: FontWeight.w600,
// //                       color: AppColors.textPrimaryColor)),
// //               const Spacer(),
// //               Text(record.formattedDate,
// //                   style: GoogleFonts.poppins(
// //                       fontSize: 11, color: AppColors.textSecondaryColor)),
// //             ],
// //           ),
// //           SizedBox(height: size.customHeight(context) * 0.012),
// //           Divider(height: 1, color: AppColors.greyColor.withOpacity(0.15)),
// //           SizedBox(height: size.customHeight(context) * 0.012),
// //           _recordField('Notes', record.notes, Icons.notes_rounded),
// //           SizedBox(height: size.customHeight(context) * 0.008),
// //           _recordField('Therapy Plan', record.therapyPlan,
// //               Icons.health_and_safety_outlined),
// //           SizedBox(height: size.customHeight(context) * 0.008),
// //           _recordField('Progress', record.progressFeedback,
// //               Icons.trending_up_rounded),
// //           if (record.medication != null) ...[
// //             SizedBox(height: size.customHeight(context) * 0.008),
// //             _recordField(
// //                 'Medication',
// //                 record.medication!['name'] ?? 'None',
// //                 Icons.medication_outlined),
// //           ],
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _recordField(String label, String value, IconData icon) {
// //     return Row(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Icon(icon, size: 14, color: AppColors.primaryColor.withOpacity(0.7)),
// //         const SizedBox(width: 8),
// //         Expanded(
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Text(label,
// //                   style: GoogleFonts.poppins(
// //                       fontSize: 11,
// //                       color: AppColors.textSecondaryColor,
// //                       fontWeight: FontWeight.w500)),
// //               Text(value,
// //                   style: GoogleFonts.poppins(
// //                       fontSize: 13, color: AppColors.textPrimaryColor)),
// //             ],
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   Widget _card(BuildContext context, CustomSize size,
// //       {required String title,
// //       required IconData icon,
// //       required List<Widget> children}) {
// //     return Container(
// //       padding: EdgeInsets.all(size.customWidth(context) * 0.045),
// //       decoration: BoxDecoration(
// //         color: AppColors.whiteColor,
// //         borderRadius: BorderRadius.circular(18),
// //         boxShadow: [
// //           BoxShadow(
// //               color: Colors.black.withOpacity(0.05),
// //               blurRadius: 10,
// //               offset: const Offset(0, 3))
// //         ],
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Row(children: [
// //             Container(
// //                 padding: const EdgeInsets.all(8),
// //                 decoration: BoxDecoration(
// //                     color: AppColors.primaryColor.withOpacity(0.1),
// //                     borderRadius: BorderRadius.circular(10)),
// //                 child:
// //                     Icon(icon, color: AppColors.primaryColor, size: 18)),
// //             const SizedBox(width: 10),
// //             Text(title,
// //                 style: GoogleFonts.poppins(
// //                     fontSize: 14,
// //                     fontWeight: FontWeight.w600,
// //                     color: AppColors.textPrimaryColor)),
// //           ]),
// //           SizedBox(height: size.customHeight(context) * 0.014),
// //           Divider(height: 1, color: AppColors.greyColor.withOpacity(0.15)),
// //           SizedBox(height: size.customHeight(context) * 0.012),
// //           ...children,
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _row(BuildContext context, CustomSize size, String label,
// //       String value, IconData icon) {
// //     return Padding(
// //       padding: EdgeInsets.only(bottom: size.customHeight(context) * 0.01),
// //       child: Row(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Icon(icon, size: 14, color: AppColors.textSecondaryColor),
// //           const SizedBox(width: 10),
// //           SizedBox(
// //             width: size.customWidth(context) * 0.22,
// //             child: Text(label,
// //                 style: GoogleFonts.poppins(
// //                     fontSize: 12,
// //                     color: AppColors.textSecondaryColor,
// //                     fontWeight: FontWeight.w500)),
// //           ),
// //           Expanded(
// //             child: Text(value,
// //                 style: GoogleFonts.poppins(
// //                     fontSize: 13,
// //                     color: AppColors.textPrimaryColor,
// //                     fontWeight: FontWeight.w500),
// //                 maxLines: 3,
// //                 overflow: TextOverflow.ellipsis),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _rowTappable(BuildContext context, CustomSize size, String label,
// //       String value, IconData icon, VoidCallback onTap) {
// //     return GestureDetector(
// //       onTap: onTap,
// //       child: Padding(
// //         padding: EdgeInsets.only(bottom: size.customHeight(context) * 0.01),
// //         child: Row(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Icon(icon, size: 14, color: AppColors.textSecondaryColor),
// //             const SizedBox(width: 10),
// //             SizedBox(
// //               width: size.customWidth(context) * 0.22,
// //               child: Text(label,
// //                   style: GoogleFonts.poppins(
// //                       fontSize: 12,
// //                       color: AppColors.textSecondaryColor,
// //                       fontWeight: FontWeight.w500)),
// //             ),
// //             Expanded(
// //               child: Text(value,
// //                   style: GoogleFonts.poppins(
// //                       fontSize: 13,
// //                       color: AppColors.accentColor,
// //                       fontWeight: FontWeight.w500),
// //                   maxLines: 2,
// //                   overflow: TextOverflow.ellipsis),
// //             ),
// //             const Icon(Icons.launch_rounded,
// //                 size: 14, color: AppColors.accentColor),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _loader() {
// //     return Scaffold(
// //       appBar: AppBar(
// //           backgroundColor: AppColors.whiteColor,
// //           elevation: 0,
// //           leading: IconButton(
// //               icon: const Icon(Icons.arrow_back_ios_new_rounded,
// //                   color: AppColors.textPrimaryColor),
// //               onPressed: () => Get.back())),
// //       body: const Center(
// //           child: CircularProgressIndicator(
// //               color: AppColors.primaryColor, strokeWidth: 3)),
// //     );
// //   }

// //   Widget _error() {
// //     return Scaffold(
// //       appBar: AppBar(
// //           backgroundColor: AppColors.whiteColor,
// //           elevation: 0,
// //           leading: IconButton(
// //               icon: const Icon(Icons.arrow_back_ios_new_rounded,
// //                   color: AppColors.textPrimaryColor),
// //               onPressed: () => Get.back())),
// //       body: Center(
// //           child: Text('Appointment not found',
// //               style: GoogleFonts.poppins(
// //                   color: AppColors.textSecondaryColor))),
// //     );
// //   }

// //   _StatusMeta _statusMeta(String status) {
// //     switch (status.toLowerCase()) {
// //       case 'confirmed':
// //         return _StatusMeta(
// //             AppColors.primaryColor, 'Confirmed', Icons.check_circle_outlined);
// //       case 'completed':
// //         return _StatusMeta(
// //             AppColors.successColor, 'Completed', Icons.task_alt_rounded);
// //       case 'cancelled':
// //         return _StatusMeta(
// //             AppColors.errorColor, 'Cancelled', Icons.cancel_outlined);
// //       case 'no_show':
// //         return _StatusMeta(
// //             AppColors.greyColor, 'No Show', Icons.person_off_outlined);
// //       default:
// //         return _StatusMeta(
// //             AppColors.warningColor, 'Scheduled', Icons.schedule_rounded);
// //     }
// //   }

// //   IconData _modeIcon(String mode) {
// //     switch (mode.toLowerCase()) {
// //       case 'online':
// //         return Icons.videocam_outlined;
// //       case 'physical':
// //         return Icons.location_on_outlined;
// //       default:
// //         return Icons.swap_horiz_rounded;
// //     }
// //   }
// // }

// // // ═══════════════════════════════════════════════════════════════
// // //   Single shared _StatusMeta class — icon is optional
// // // ═══════════════════════════════════════════════════════════════
// // class _StatusMeta {
// //   final Color color;
// //   final String label;
// //   final IconData icon;
// //   _StatusMeta(this.color, this.label, [this.icon = Icons.info_outline]);
// // }



// // lib/view/parent/booking/parent_my_appointments_screen.dart
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/parent_booking_controller.dart';
// import 'package:speechspectrum/controllers/payment_controller.dart';
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
//     ('No Show', Icons.person_off_outlined),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _tab = TabController(length: _tabs.length, vsync: this);
//     _c = Get.isRegistered<ParentBookingController>()
//         ? Get.find<ParentBookingController>()
//         : Get.put(ParentBookingController());
//     // Ensure PaymentController is registered
//     if (!Get.isRegistered<PaymentController>()) {
//       Get.put(PaymentController());
//     }
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
//           labelStyle:
//               GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13),
//           unselectedLabelStyle:
//               GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 13),
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
//         if (_c.isLoadingAppointments.value && _c.myAppointments.isEmpty) {
//           return _loader(context, size);
//         }
//         return TabBarView(
//           controller: _tab,
//           children: [
//             _list(context, size, _c.myAppointments, showAll: true),
//             _list(context, size, _c.scheduledList),
//             _list(context, size, _c.confirmedList, isConfirmedTab: true),
//             _list(context, size, _c.completedList),
//             _list(context, size, _c.cancelledList),
//             _list(context, size, _c.noShowList),
//           ],
//         );
//       }),
//     );
//   }

//   Widget _list(
//     BuildContext context,
//     CustomSize size,
//     List<MyAppointmentItem> items, {
//     bool showAll = false,
//     bool isConfirmedTab = false,
//   }) {
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
//         itemBuilder: (_, i) => _card(
//           context,
//           size,
//           items[i],
//           // Show meeting link + payment only on Confirmed tab
//           showConfirmedFeatures: isConfirmedTab || items[i].isConfirmed,
//         ),
//       ),
//     );
//   }

//   Widget _card(
//     BuildContext context,
//     CustomSize size,
//     MyAppointmentItem appt, {
//     bool showConfirmedFeatures = false,
//   }) {
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
//                 borderRadius:
//                     const BorderRadius.vertical(top: Radius.circular(20)),
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
//                                   fontSize: size.customWidth(context) * 0.04,
//                                   fontWeight: FontWeight.w700,
//                                   color: AppColors.textPrimaryColor),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                             Text(
//                               appt.expertUsers?.fullName ?? '',
//                               style: GoogleFonts.poppins(
//                                   fontSize: size.customWidth(context) * 0.031,
//                                   color: AppColors.primaryColor,
//                                   fontWeight: FontWeight.w500),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ],
//                         ),
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           // Appointment status badge
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 10, vertical: 4),
//                             decoration: BoxDecoration(
//                               color: meta.color.withOpacity(0.1),
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             child: Text(meta.label,
//                                 style: GoogleFonts.poppins(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w600,
//                                     color: meta.color)),
//                           ),
//                           // Payment badge — only on confirmed appointments
//                           if (showConfirmedFeatures) ...[
//                             const SizedBox(height: 4),
//                             _paymentBadgeSmall(appt),
//                           ],
//                         ],
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
//                       _chip2(Icons.access_time_rounded, appt.formattedTime,
//                           AppColors.secondaryColor),
//                       _chip2(
//                           _modeIcon(appt.bookedMode),
//                           appt.bookedMode[0].toUpperCase() +
//                               appt.bookedMode.substring(1),
//                           AppColors.accentColor),
//                       _chip2(
//                           Icons.payments_outlined,
//                           '${appt.currency} ${appt.feeCharged.toStringAsFixed(0)}',
//                           AppColors.warningColor),
//                     ],
//                   ),

//                   // ── CONFIRMED-ONLY FEATURES ──────────────────
//                   if (showConfirmedFeatures) ...[
//                     // Meet link banner (only confirmed + has link)
//                     if (appt.meetLink != null && appt.meetLink!.isNotEmpty) ...[
//                       SizedBox(height: size.customHeight(context) * 0.01),
//                       _meetLinkBanner(context, size, appt.meetLink!),
//                     ],
//                     // Payment section
//                     SizedBox(height: size.customHeight(context) * 0.01),
//                     _paymentSection(context, size, appt),
//                   ],

//                   // Cancellation reason (all tabs)
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
//                   // No Show info banner (all tabs)
//                   if (appt.isNoShow) ...[
//                     SizedBox(height: size.customHeight(context) * 0.01),
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 10, vertical: 7),
//                       decoration: BoxDecoration(
//                         color: AppColors.greyColor.withOpacity(0.08),
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(
//                             color: AppColors.greyColor.withOpacity(0.3)),
//                       ),
//                       child: Row(children: [
//                         Icon(Icons.person_off_outlined,
//                             size: 13, color: AppColors.greyColor),
//                         const SizedBox(width: 6),
//                         Expanded(
//                           child: Text(
//                             'Patient did not attend this session',
//                             style: GoogleFonts.poppins(
//                                 fontSize: 12, color: AppColors.greyColor),
//                           ),
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

//   /// Small payment status badge shown next to status pill in card header
//   Widget _paymentBadgeSmall(MyAppointmentItem appt) {
//     final isPaid = appt.paymentStatus?.toLowerCase() == 'paid';
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//       decoration: BoxDecoration(
//         color: isPaid
//             ? AppColors.successColor.withOpacity(0.1)
//             : AppColors.warningColor.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(
//             isPaid ? Icons.check_circle_outline : Icons.pending_outlined,
//             size: 9,
//             color: isPaid ? AppColors.successColor : AppColors.warningColor,
//           ),
//           const SizedBox(width: 3),
//           Text(
//             isPaid ? 'Paid' : 'Unpaid',
//             style: GoogleFonts.poppins(
//               fontSize: 9,
//               fontWeight: FontWeight.w600,
//               color: isPaid ? AppColors.successColor : AppColors.warningColor,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   /// Full payment section — shows "Needs Payment" banner + Pay button or Paid status
//   Widget _paymentSection(
//       BuildContext context, CustomSize size, MyAppointmentItem appt) {
//     final isPaid = appt.paymentStatus?.toLowerCase() == 'paid';

//     if (isPaid) {
//       // Paid — green status strip, no pay button
//       return Container(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         decoration: BoxDecoration(
//           color: AppColors.successColor.withOpacity(0.07),
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//               color: AppColors.successColor.withOpacity(0.25), width: 1),
//         ),
//         child: Row(
//           children: [
//             const Icon(Icons.check_circle_rounded,
//                 color: AppColors.successColor, size: 16),
//             const SizedBox(width: 8),
//             Text(
//               'Payment Complete',
//               style: GoogleFonts.poppins(
//                 fontSize: 12,
//                 color: AppColors.successColor,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         ),
//       );
//     }

//     // Pending — orange warning strip + Pay Now button
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: AppColors.warningColor.withOpacity(0.07),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//             color: AppColors.warningColor.withOpacity(0.3), width: 1),
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.warning_amber_rounded,
//               color: AppColors.warningColor, size: 16),
//           const SizedBox(width: 8),
//           Expanded(
//             child: Text(
//               'Payment pending — tap to complete',
//               style: GoogleFonts.poppins(
//                 fontSize: 11,
//                 color: AppColors.warningColor,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//           const SizedBox(width: 8),
//           GetBuilder<PaymentController>(
//             init: Get.isRegistered<PaymentController>()
//                 ? Get.find<PaymentController>()
//                 : Get.put(PaymentController()),
//             builder: (pc) => GestureDetector(
//               onTap: pc.isInitiating.value
//                   ? null
//                   : () => pc.initiatePayment(appt.appointmentId),
//               child: Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                 decoration: BoxDecoration(
//                   color: AppColors.warningColor,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: pc.isInitiating.value
//                     ? const SizedBox(
//                         width: 14,
//                         height: 14,
//                         child: CircularProgressIndicator(
//                             color: Colors.white, strokeWidth: 2))
//                     : Text(
//                         'Pay Now',
//                         style: GoogleFonts.poppins(
//                           fontSize: 11,
//                           color: Colors.white,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//               ),
//             ),
//           ),
//         ],
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
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         decoration: BoxDecoration(
//           color: const Color(0xFF2196F3).withOpacity(0.07),
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//               color: const Color(0xFF2196F3).withOpacity(0.3), width: 1),
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
//   late final PaymentController _pc;
//   late final String _appointmentId;

//   @override
//   void initState() {
//     super.initState();
//     _c = Get.find<ParentBookingController>();
//     _pc = Get.isRegistered<PaymentController>()
//         ? Get.find<PaymentController>()
//         : Get.put(PaymentController());
//     _appointmentId = Get.arguments as String;
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _c.fetchAppointmentDetail(_appointmentId);
//       _c.fetchAppointmentRecords(_appointmentId);
//       _pc.fetchPaymentStatus(_appointmentId);
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
//     final isConfirmed = appt.isConfirmed;

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
//                                   fontSize: size.customWidth(context) * 0.044,
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
//                             Row(
//                               children: [
//                                 Container(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 12, vertical: 4),
//                                   decoration: BoxDecoration(
//                                     color: meta.color.withOpacity(0.2),
//                                     borderRadius: BorderRadius.circular(20),
//                                     border: Border.all(
//                                         color: Colors.white.withOpacity(0.4)),
//                                   ),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Icon(meta.icon,
//                                           color: Colors.white, size: 12),
//                                       const SizedBox(width: 5),
//                                       Text(meta.label,
//                                           style: GoogleFonts.poppins(
//                                               color: Colors.white,
//                                               fontSize: 12,
//                                               fontWeight: FontWeight.w600)),
//                                     ],
//                                   ),
//                                 ),
//                                 // Payment badge in header — only for confirmed
//                                 if (isConfirmed) ...[
//                                   const SizedBox(width: 6),
//                                   Obx(() {
//                                     final ps = _pc.paymentStatus.value;
//                                     final isPaid =
//                                         ps?.isPaid ?? appt.paymentStatus?.toLowerCase() == 'paid';
//                                     return Container(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 10, vertical: 4),
//                                       decoration: BoxDecoration(
//                                         color: isPaid
//                                             ? AppColors.successColor
//                                                 .withOpacity(0.2)
//                                             : AppColors.warningColor
//                                                 .withOpacity(0.2),
//                                         borderRadius: BorderRadius.circular(20),
//                                         border: Border.all(
//                                             color:
//                                                 Colors.white.withOpacity(0.4)),
//                                       ),
//                                       child: Text(
//                                         isPaid ? 'Paid' : 'Unpaid',
//                                         style: GoogleFonts.poppins(
//                                             color: Colors.white,
//                                             fontSize: 11,
//                                             fontWeight: FontWeight.w600),
//                                       ),
//                                     );
//                                   }),
//                                 ],
//                               ],
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

//               // ── CONFIRMED-ONLY: Meet link + Payment ──────────
//               if (isConfirmed) ...[
//                 // Meet link prominent banner
//                 if (appt.meetLink != null && appt.meetLink!.isNotEmpty) ...[
//                   _meetLinkCard(context, size, appt.meetLink!),
//                   SizedBox(height: size.customHeight(context) * 0.018),
//                 ],

//                 // Payment card
//                 _paymentCard(context, size, appt),
//                 SizedBox(height: size.customHeight(context) * 0.018),
//               ],

//               // No Show info card
//               if (appt.isNoShow) ...[
//                 _noShowCard(context, size),
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

//               // Session records (only for completed)
//               if (appt.isCompleted) ...[
//                 _recordsSection(context, size),
//                 SizedBox(height: size.customHeight(context) * 0.04),
//               ],
//             ]),
//           ),
//         ),
//       ],
//     );
//   }

//   // ── Payment Card (Detail Screen) ───────────────────────────
//   Widget _paymentCard(
//       BuildContext context, CustomSize size, MyAppointmentItem appt) {
//     return Obx(() {
//       final ps = _pc.paymentStatus.value;
//       // Prefer live fetched status, fall back to appointment field
//       final rawStatus = ps?.status ?? appt.paymentStatus ?? 'pending';
//       final isPaid = rawStatus.toLowerCase() == 'paid';

//       return Container(
//         padding: EdgeInsets.all(size.customWidth(context) * 0.045),
//         decoration: BoxDecoration(
//           color: AppColors.whiteColor,
//           borderRadius: BorderRadius.circular(18),
//           boxShadow: [
//             BoxShadow(
//                 color: Colors.black.withOpacity(0.05),
//                 blurRadius: 10,
//                 offset: const Offset(0, 3))
//           ],
//           border: Border.all(
//             color: isPaid
//                 ? AppColors.successColor.withOpacity(0.3)
//                 : AppColors.warningColor.withOpacity(0.4),
//             width: 1.5,
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(children: [
//               Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                       color: isPaid
//                           ? AppColors.successColor.withOpacity(0.1)
//                           : AppColors.warningColor.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(10)),
//                   child: Icon(
//                     isPaid
//                         ? Icons.check_circle_rounded
//                         : Icons.payment_rounded,
//                     color: isPaid
//                         ? AppColors.successColor
//                         : AppColors.warningColor,
//                     size: 18,
//                   )),
//               const SizedBox(width: 10),
//               Text(
//                 'Payment',
//                 style: GoogleFonts.poppins(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.textPrimaryColor),
//               ),
//               const Spacer(),
//               // Refresh icon
//               Obx(() => _pc.isLoadingStatus.value
//                   ? const SizedBox(
//                       width: 16,
//                       height: 16,
//                       child: CircularProgressIndicator(
//                           color: AppColors.primaryColor, strokeWidth: 2))
//                   : GestureDetector(
//                       onTap: () =>
//                           _pc.fetchPaymentStatus(appt.appointmentId),
//                       child: const Icon(Icons.refresh_rounded,
//                           size: 18, color: AppColors.textSecondaryColor),
//                     )),
//             ]),
//             SizedBox(height: size.customHeight(context) * 0.014),
//             Divider(height: 1, color: AppColors.greyColor.withOpacity(0.15)),
//             SizedBox(height: size.customHeight(context) * 0.012),

//             // Amount row
//             _row(
//               context,
//               size,
//               'Amount',
//               '${appt.currency} ${appt.feeCharged.toStringAsFixed(0)}',
//               Icons.payments_outlined,
//             ),

//             // Status row with colored text
//             Padding(
//               padding: EdgeInsets.only(
//                   bottom: size.customHeight(context) * 0.01),
//               child: Row(
//                 children: [
//                   Icon(Icons.circle,
//                       size: 8,
//                       color: isPaid
//                           ? AppColors.successColor
//                           : AppColors.warningColor),
//                   const SizedBox(width: 10),
//                   SizedBox(
//                     width: size.customWidth(context) * 0.22,
//                     child: Text('Status',
//                         style: GoogleFonts.poppins(
//                             fontSize: 12,
//                             color: AppColors.textSecondaryColor,
//                             fontWeight: FontWeight.w500)),
//                   ),
//                   Text(
//                     isPaid ? 'Paid' : 'Pending — needs payment',
//                     style: GoogleFonts.poppins(
//                       fontSize: 13,
//                       fontWeight: FontWeight.w600,
//                       color: isPaid
//                           ? AppColors.successColor
//                           : AppColors.warningColor,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             // Pay button — only if not paid
//             if (!isPaid) ...[
//               SizedBox(height: size.customHeight(context) * 0.014),
//               Obx(() => SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton.icon(
//                       onPressed: _pc.isInitiating.value
//                           ? null
//                           : () => _pc.initiatePayment(appt.appointmentId),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.warningColor,
//                         disabledBackgroundColor:
//                             AppColors.warningColor.withOpacity(0.5),
//                         padding: const EdgeInsets.symmetric(vertical: 13),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       icon: _pc.isInitiating.value
//                           ? const SizedBox(
//                               width: 16,
//                               height: 16,
//                               child: CircularProgressIndicator(
//                                   color: Colors.white, strokeWidth: 2))
//                           : const Icon(Icons.payment_rounded,
//                               color: Colors.white, size: 18),
//                       label: Text(
//                         _pc.isInitiating.value
//                             ? 'Opening Payment...'
//                             : 'Pay Now — ${appt.currency} ${appt.feeCharged.toStringAsFixed(0)}',
//                         style: GoogleFonts.poppins(
//                           color: Colors.white,
//                           fontWeight: FontWeight.w700,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ),
//                   )),
//             ],
//           ],
//         ),
//       );
//     });
//   }

//   Widget _noShowCard(BuildContext context, CustomSize size) {
//     return Container(
//       padding: EdgeInsets.all(size.customWidth(context) * 0.045),
//       decoration: BoxDecoration(
//         color: AppColors.greyColor.withOpacity(0.07),
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(color: AppColors.greyColor.withOpacity(0.3)),
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//                 color: AppColors.greyColor.withOpacity(0.12),
//                 borderRadius: BorderRadius.circular(12)),
//             child: Icon(Icons.person_off_outlined,
//                 color: AppColors.greyColor, size: 22),
//           ),
//           const SizedBox(width: 14),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'No Show',
//                   style: GoogleFonts.poppins(
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.greyColor),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   'The patient did not attend this scheduled session.',
//                   style: GoogleFonts.poppins(
//                       fontSize: 12,
//                       color: AppColors.greyColor.withOpacity(0.8)),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
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
//           gradient: const LinearGradient(
//             colors: [Color(0xFF2196F3), Color(0xFF1565C0)],
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
//                   Text('Tap to open in browser',
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
//           _row(
//               context,
//               size,
//               'Mode',
//               appt.bookedMode[0].toUpperCase() + appt.bookedMode.substring(1),
//               _modeIcon(appt.bookedMode)),
//           _row(
//               context,
//               size,
//               'Fee',
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
//           _row(
//               context,
//               size,
//               'Slot Mode',
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
//           _row(context, size, 'Name', expert.fullName, Icons.badge_outlined),
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
//             _row(
//                 context,
//                 size,
//                 'By',
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
//                         color: AppColors.textSecondaryColor.withOpacity(0.4)),
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
//                       fontSize: 11, color: AppColors.textSecondaryColor)),
//             ],
//           ),
//           SizedBox(height: size.customHeight(context) * 0.012),
//           Divider(height: 1, color: AppColors.greyColor.withOpacity(0.15)),
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
//         Icon(icon, size: 14, color: AppColors.primaryColor.withOpacity(0.7)),
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
//                       fontSize: 13, color: AppColors.textPrimaryColor)),
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
//                 child: Icon(icon, color: AppColors.primaryColor, size: 18)),
//             const SizedBox(width: 10),
//             Text(title,
//                 style: GoogleFonts.poppins(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.textPrimaryColor)),
//           ]),
//           SizedBox(height: size.customHeight(context) * 0.014),
//           Divider(height: 1, color: AppColors.greyColor.withOpacity(0.15)),
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
//         padding: EdgeInsets.only(bottom: size.customHeight(context) * 0.01),
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
//         return _StatusMeta(
//             AppColors.primaryColor, 'Confirmed', Icons.check_circle_outlined);
//       case 'completed':
//         return _StatusMeta(
//             AppColors.successColor, 'Completed', Icons.task_alt_rounded);
//       case 'cancelled':
//         return _StatusMeta(
//             AppColors.errorColor, 'Cancelled', Icons.cancel_outlined);
//       case 'no_show':
//         return _StatusMeta(
//             AppColors.greyColor, 'No Show', Icons.person_off_outlined);
//       default:
//         return _StatusMeta(
//             AppColors.warningColor, 'Scheduled', Icons.schedule_rounded);
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

// // ═══════════════════════════════════════════════════════════════
// //   Shared _StatusMeta
// // ═══════════════════════════════════════════════════════════════
// class _StatusMeta {
//   final Color color;
//   final String label;
//   final IconData icon;
//   _StatusMeta(this.color, this.label, [this.icon = Icons.info_outline]);
// }



// // lib/view/parent/booking/parent_my_appointments_screen.dart
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// // Use android_intent_plus for opening URLs on Android — avoids canLaunchUrl
// // returning null for Zoom/external apps when no component is found.
// import 'package:android_intent_plus/android_intent.dart';
// import 'package:android_intent_plus/flag.dart';
// import 'dart:io' show Platform;
// import 'package:url_launcher/url_launcher.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/parent_booking_controller.dart';
// import 'package:speechspectrum/controllers/payment_controller.dart';
// import 'package:speechspectrum/models/my_appointment_model.dart';
// import 'package:speechspectrum/routes/app_routes.dart';


// Future<void> _openUrl(String url) async {
//   final uri = Uri.parse(url);
//   if (Platform.isAndroid) {
//     try {
//       final intent = AndroidIntent(
//         action: 'action_view',
//         data: url,
//         flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
//       );
//       await intent.launch();
//       return;
//     } catch (_) {
//       // fall through to url_launcher
//     }
//   }
//   // iOS / fallback
//   if (await canLaunchUrl(uri)) {
//     await launchUrl(uri, mode: LaunchMode.externalApplication);
//   } else {
//     await launchUrl(uri, mode: LaunchMode.platformDefault);
//   }
// }

// // ═══════════════════════════════════════════════════════════════
// //   Parent My Appointments Screen
// // ═══════════════════════════════════════════════════════════════
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
//     ('No Show', Icons.person_off_outlined),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _tab = TabController(length: _tabs.length, vsync: this);
//     _c = Get.isRegistered<ParentBookingController>()
//         ? Get.find<ParentBookingController>()
//         : Get.put(ParentBookingController());
//     if (!Get.isRegistered<PaymentController>()) {
//       Get.put(PaymentController());
//     }
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
//           labelStyle:
//               GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13),
//           unselectedLabelStyle:
//               GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 13),
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
//         if (_c.isLoadingAppointments.value && _c.myAppointments.isEmpty) {
//           return _loader(context, size);
//         }
//         return TabBarView(
//           controller: _tab,
//           children: [
//             // All — no special features
//             _list(context, size, _c.myAppointments,showPayment: true,showMeetLink: true),
//             // Scheduled — show payment section only
//             _list(context, size, _c.scheduledList, showPayment: true),
//             // Confirmed — show meeting link only
//             _list(context, size, _c.confirmedList, showMeetLink: true),
//             // Completed, Cancelled, No Show — plain
//             _list(context, size, _c.completedList),
//             _list(context, size, _c.cancelledList),
//             _list(context, size, _c.noShowList),
//           ],
//         );
//       }),
//     );
//   }

//   Widget _list(
//     BuildContext context,
//     CustomSize size,
//     List<MyAppointmentItem> items, {
//     bool showPayment = false,
//     bool showMeetLink = false,
//   }) {
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
//         itemBuilder: (_, i) => _card(
//           context,
//           size,
//           items[i],
//           showPayment: showPayment,
//           showMeetLink: showMeetLink,
//         ),
//       ),
//     );
//   }

//   Widget _card(
//     BuildContext context,
//     CustomSize size,
//     MyAppointmentItem appt, {
//     bool showPayment = false,
//     bool showMeetLink = false,
//   }) {
//     final meta = _statusMeta(appt.status);
//     final isPaid =
//         appt.paymentStatus?.toLowerCase() == 'paid';

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
//             // Status color bar at top
//             Container(
//               height: 4,
//               decoration: BoxDecoration(
//                 color: meta.color,
//                 borderRadius:
//                     const BorderRadius.vertical(top: Radius.circular(20)),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(size.customWidth(context) * 0.042),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // ── Header row ─────────────────────────────
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Avatar
//                       Container(
//                         width: 50,
//                         height: 50,
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(colors: [
//                             AppColors.primaryColor.withOpacity(0.7),
//                             AppColors.primaryColor,
//                           ]),
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
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           // Status badge
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 10, vertical: 4),
//                             decoration: BoxDecoration(
//                               color: meta.color.withOpacity(0.1),
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             child: Text(meta.label,
//                                 style: GoogleFonts.poppins(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w600,
//                                     color: meta.color)),
//                           ),
//                           // Payment badge — only on Scheduled tab
//                           if (showPayment) ...[
//                             const SizedBox(height: 4),
//                             _paymentBadgeSmall(isPaid),
//                           ],
//                         ],
//                       ),
//                     ],
//                   ),

//                   SizedBox(height: size.customHeight(context) * 0.012),
//                   Divider(
//                       height: 1,
//                       color: AppColors.greyColor.withOpacity(0.15)),
//                   SizedBox(height: size.customHeight(context) * 0.01),

//                   // Info chips
//                   Wrap(
//                     spacing: 14,
//                     runSpacing: 6,
//                     children: [
//                       _chip2(Icons.calendar_today_outlined,
//                           appt.formattedDate, AppColors.primaryColor),
//                       _chip2(Icons.access_time_rounded, appt.formattedTime,
//                           AppColors.secondaryColor),
//                       _chip2(
//                           _modeIcon(appt.bookedMode),
//                           appt.bookedMode[0].toUpperCase() +
//                               appt.bookedMode.substring(1),
//                           AppColors.accentColor),
//                       _chip2(
//                           Icons.payments_outlined,
//                           '${appt.currency} ${appt.feeCharged.toStringAsFixed(0)}',
//                           AppColors.warningColor),
//                     ],
//                   ),

//                   // ── SCHEDULED TAB: Payment section ──────────
//                   if (showPayment) ...[
//                     SizedBox(height: size.customHeight(context) * 0.01),
//                     _paymentSection(context, size, appt, isPaid),
//                   ],

//                   // ── CONFIRMED TAB: Meeting link ──────────────
//                   if (showMeetLink &&
//                       appt.meetLink != null &&
//                       appt.meetLink!.isNotEmpty) ...[
//                     SizedBox(height: size.customHeight(context) * 0.01),
//                     _meetLinkBanner(context, size, appt.meetLink!),
//                   ],

//                   // Cancellation reason
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

//                   // No Show banner
//                   if (appt.isNoShow) ...[
//                     SizedBox(height: size.customHeight(context) * 0.01),
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 10, vertical: 7),
//                       decoration: BoxDecoration(
//                         color: AppColors.greyColor.withOpacity(0.08),
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(
//                             color: AppColors.greyColor.withOpacity(0.3)),
//                       ),
//                       child: Row(children: [
//                         Icon(Icons.person_off_outlined,
//                             size: 13, color: AppColors.greyColor),
//                         const SizedBox(width: 6),
//                         Expanded(
//                           child: Text(
//                             'Patient did not attend this session',
//                             style: GoogleFonts.poppins(
//                                 fontSize: 12,
//                                 color: AppColors.greyColor),
//                           ),
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

//   // Small payment badge in card header (Scheduled tab only)
//   Widget _paymentBadgeSmall(bool isPaid) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//       decoration: BoxDecoration(
//         color: isPaid
//             ? AppColors.successColor.withOpacity(0.1)
//             : AppColors.warningColor.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(
//             isPaid ? Icons.check_circle_outline : Icons.pending_outlined,
//             size: 9,
//             color: isPaid ? AppColors.successColor : AppColors.warningColor,
//           ),
//           const SizedBox(width: 3),
//           Text(
//             isPaid ? 'Paid' : 'Unpaid',
//             style: GoogleFonts.poppins(
//               fontSize: 9,
//               fontWeight: FontWeight.w600,
//               color:
//                   isPaid ? AppColors.successColor : AppColors.warningColor,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Payment section row with Pay Now button (Scheduled tab only)
//   Widget _paymentSection(BuildContext context, CustomSize size,
//       MyAppointmentItem appt, bool isPaid) {
//     if (isPaid) {
//       return Container(
//         padding:
//             const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         decoration: BoxDecoration(
//           color: AppColors.successColor.withOpacity(0.07),
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//               color: AppColors.successColor.withOpacity(0.25), width: 1),
//         ),
//         child: Row(children: [
//           const Icon(Icons.check_circle_rounded,
//               color: AppColors.successColor, size: 16),
//           const SizedBox(width: 8),
//           Text(
//             'Payment Complete',
//             style: GoogleFonts.poppins(
//               fontSize: 12,
//               color: AppColors.successColor,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ]),
//       );
//     }

//     // Pending — show Pay Now
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: AppColors.warningColor.withOpacity(0.07),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//             color: AppColors.warningColor.withOpacity(0.3), width: 1),
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.warning_amber_rounded,
//               color: AppColors.warningColor, size: 16),
//           const SizedBox(width: 8),
//           Expanded(
//             child: Text(
//               'Payment pending — tap to complete',
//               style: GoogleFonts.poppins(
//                 fontSize: 11,
//                 color: AppColors.warningColor,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//           const SizedBox(width: 8),
//           GetBuilder<PaymentController>(
//             init: Get.isRegistered<PaymentController>()
//                 ? Get.find<PaymentController>()
//                 : Get.put(PaymentController()),
//             builder: (pc) => GestureDetector(
//               onTap: pc.isInitiating.value
//                   ? null
//                   : () => pc.initiatePayment(appt.appointmentId),
//               child: Container(
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: 12, vertical: 6),
//                 decoration: BoxDecoration(
//                   color: AppColors.warningColor,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: pc.isInitiating.value
//                     ? const SizedBox(
//                         width: 14,
//                         height: 14,
//                         child: CircularProgressIndicator(
//                             color: Colors.white, strokeWidth: 2))
//                     : Text(
//                         'Pay Now',
//                         style: GoogleFonts.poppins(
//                           fontSize: 11,
//                           color: Colors.white,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Meeting link banner (Confirmed tab only)
//   Widget _meetLinkBanner(
//       BuildContext context, CustomSize size, String url) {
//     return GestureDetector(
//       onTap: () => _openUrl(url),
//       child: Container(
//         padding:
//             const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         decoration: BoxDecoration(
//           color: const Color(0xFF2196F3).withOpacity(0.07),
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//               color: const Color(0xFF2196F3).withOpacity(0.3), width: 1),
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
//             // Copy button
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
//   late final PaymentController _pc;
//   late final String _appointmentId;

//   @override
//   void initState() {
//     super.initState();
//     _c = Get.find<ParentBookingController>();
//     _pc = Get.isRegistered<PaymentController>()
//         ? Get.find<PaymentController>()
//         : Get.put(PaymentController());
//     _appointmentId = Get.arguments as String;
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _c.fetchAppointmentDetail(_appointmentId);
//       _c.fetchAppointmentRecords(_appointmentId);
//       // Only fetch payment status for scheduled appointments
//       // (we check after detail loads in _content)
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

//         // Fetch payment status only for scheduled appointments
//         if (appt.isScheduled) {
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             _pc.fetchPaymentStatus(_appointmentId);
//           });
//         }

//         return _content(context, size, appt);
//       }),
//     );
//   }

//   Widget _content(
//       BuildContext context, CustomSize size, MyAppointmentItem appt) {
//     final meta = _statusMeta(appt.status);
//     // Meeting link: only confirmed
//     final isConfirmed = appt.isConfirmed;
//     // Payment: only scheduled
//     final isScheduled = appt.isScheduled;

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
//                             Row(
//                               children: [
//                                 // Status badge
//                                 Container(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 12, vertical: 4),
//                                   decoration: BoxDecoration(
//                                     color: meta.color.withOpacity(0.2),
//                                     borderRadius: BorderRadius.circular(20),
//                                     border: Border.all(
//                                         color:
//                                             Colors.white.withOpacity(0.4)),
//                                   ),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Icon(meta.icon,
//                                           color: Colors.white, size: 12),
//                                       const SizedBox(width: 5),
//                                       Text(meta.label,
//                                           style: GoogleFonts.poppins(
//                                               color: Colors.white,
//                                               fontSize: 12,
//                                               fontWeight: FontWeight.w600)),
//                                     ],
//                                   ),
//                                 ),
//                                 // Payment badge in header — only for scheduled
//                                 if (isScheduled) ...[
//                                   const SizedBox(width: 6),
//                                   Obx(() {
//                                     final ps = _pc.paymentStatus.value;
//                                     final isPaid = ps?.isPaid ??
//                                         appt.paymentStatus?.toLowerCase() ==
//                                             'paid';
//                                     return Container(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 10, vertical: 4),
//                                       decoration: BoxDecoration(
//                                         color: isPaid
//                                             ? AppColors.successColor
//                                                 .withOpacity(0.2)
//                                             : AppColors.warningColor
//                                                 .withOpacity(0.2),
//                                         borderRadius:
//                                             BorderRadius.circular(20),
//                                         border: Border.all(
//                                             color: Colors.white
//                                                 .withOpacity(0.4)),
//                                       ),
//                                       child: Text(
//                                         isPaid ? 'Paid' : 'Unpaid',
//                                         style: GoogleFonts.poppins(
//                                             color: Colors.white,
//                                             fontSize: 11,
//                                             fontWeight: FontWeight.w600),
//                                       ),
//                                     );
//                                   }),
//                                 ],
//                               ],
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

//               // ── CONFIRMED ONLY: Meet link ────────────────────
//               if (isConfirmed &&
//                   appt.meetLink != null &&
//                   appt.meetLink!.isNotEmpty) ...[
//                 _meetLinkCard(context, size, appt.meetLink!),
//                 SizedBox(height: size.customHeight(context) * 0.018),
//               ],

//               // ── SCHEDULED ONLY: Payment card ─────────────────
//               if (isScheduled) ...[
//                 _paymentCard(context, size, appt),
//                 SizedBox(height: size.customHeight(context) * 0.018),
//               ],

//               // No Show info card
//               if (appt.isNoShow) ...[
//                 _noShowCard(context, size),
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

//               // Session records (only for completed)
//               if (appt.isCompleted) ...[
//                 _recordsSection(context, size),
//                 SizedBox(height: size.customHeight(context) * 0.04),
//               ],
//             ]),
//           ),
//         ),
//       ],
//     );
//   }

//   // ── Payment Card — Scheduled only ─────────────────────────
//   Widget _paymentCard(
//       BuildContext context, CustomSize size, MyAppointmentItem appt) {
//     return Obx(() {
//       final ps = _pc.paymentStatus.value;
//       final rawStatus = ps?.status ?? appt.paymentStatus ?? 'pending';
//       final isPaid = rawStatus.toLowerCase() == 'paid';

//       return Container(
//         padding: EdgeInsets.all(size.customWidth(context) * 0.045),
//         decoration: BoxDecoration(
//           color: AppColors.whiteColor,
//           borderRadius: BorderRadius.circular(18),
//           boxShadow: [
//             BoxShadow(
//                 color: Colors.black.withOpacity(0.05),
//                 blurRadius: 10,
//                 offset: const Offset(0, 3))
//           ],
//           border: Border.all(
//             color: isPaid
//                 ? AppColors.successColor.withOpacity(0.3)
//                 : AppColors.warningColor.withOpacity(0.4),
//             width: 1.5,
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(children: [
//               Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                       color: isPaid
//                           ? AppColors.successColor.withOpacity(0.1)
//                           : AppColors.warningColor.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(10)),
//                   child: Icon(
//                     isPaid
//                         ? Icons.check_circle_rounded
//                         : Icons.payment_rounded,
//                     color: isPaid
//                         ? AppColors.successColor
//                         : AppColors.warningColor,
//                     size: 18,
//                   )),
//               const SizedBox(width: 10),
//               Text('Payment',
//                   style: GoogleFonts.poppins(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.textPrimaryColor)),
//               const Spacer(),
//               Obx(() => _pc.isLoadingStatus.value
//                   ? const SizedBox(
//                       width: 16,
//                       height: 16,
//                       child: CircularProgressIndicator(
//                           color: AppColors.primaryColor, strokeWidth: 2))
//                   : GestureDetector(
//                       onTap: () =>
//                           _pc.fetchPaymentStatus(appt.appointmentId),
//                       child: const Icon(Icons.refresh_rounded,
//                           size: 18,
//                           color: AppColors.textSecondaryColor),
//                     )),
//             ]),
//             SizedBox(height: size.customHeight(context) * 0.014),
//             Divider(height: 1, color: AppColors.greyColor.withOpacity(0.15)),
//             SizedBox(height: size.customHeight(context) * 0.012),

//             _row(context, size, 'Amount',
//                 '${appt.currency} ${appt.feeCharged.toStringAsFixed(0)}',
//                 Icons.payments_outlined),

//             Padding(
//               padding: EdgeInsets.only(
//                   bottom: size.customHeight(context) * 0.01),
//               child: Row(
//                 children: [
//                   Icon(Icons.circle,
//                       size: 8,
//                       color: isPaid
//                           ? AppColors.successColor
//                           : AppColors.warningColor),
//                   const SizedBox(width: 10),
//                   SizedBox(
//                     width: size.customWidth(context) * 0.22,
//                     child: Text('Status',
//                         style: GoogleFonts.poppins(
//                             fontSize: 12,
//                             color: AppColors.textSecondaryColor,
//                             fontWeight: FontWeight.w500)),
//                   ),
//                   Text(
//                     isPaid ? 'Paid' : 'Pending — needs payment',
//                     style: GoogleFonts.poppins(
//                       fontSize: 13,
//                       fontWeight: FontWeight.w600,
//                       color: isPaid
//                           ? AppColors.successColor
//                           : AppColors.warningColor,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             // Pay button — only if not paid
//             if (!isPaid) ...[
//               SizedBox(height: size.customHeight(context) * 0.014),
//               Obx(() => SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton.icon(
//                       onPressed: _pc.isInitiating.value
//                           ? null
//                           : () => _pc.initiatePayment(appt.appointmentId),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.warningColor,
//                         disabledBackgroundColor:
//                             AppColors.warningColor.withOpacity(0.5),
//                         padding: const EdgeInsets.symmetric(vertical: 13),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12)),
//                       ),
//                       icon: _pc.isInitiating.value
//                           ? const SizedBox(
//                               width: 16,
//                               height: 16,
//                               child: CircularProgressIndicator(
//                                   color: Colors.white, strokeWidth: 2))
//                           : const Icon(Icons.payment_rounded,
//                               color: Colors.white, size: 18),
//                       label: Text(
//                         _pc.isInitiating.value
//                             ? 'Opening Payment...'
//                             : 'Pay Now — ${appt.currency} ${appt.feeCharged.toStringAsFixed(0)}',
//                         style: GoogleFonts.poppins(
//                           color: Colors.white,
//                           fontWeight: FontWeight.w700,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ),
//                   )),
//             ],
//           ],
//         ),
//       );
//     });
//   }

//   // ── Meet link card — Confirmed only ───────────────────────
//   Widget _meetLinkCard(
//       BuildContext context, CustomSize size, String url) {
//     return GestureDetector(
//       onTap: () => _openUrl(url),
//       child: Container(
//         padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [Color(0xFF2196F3), Color(0xFF1565C0)],
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
//                   Text('Tap to open in browser',
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

//   Widget _noShowCard(BuildContext context, CustomSize size) {
//     return Container(
//       padding: EdgeInsets.all(size.customWidth(context) * 0.045),
//       decoration: BoxDecoration(
//         color: AppColors.greyColor.withOpacity(0.07),
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(color: AppColors.greyColor.withOpacity(0.3)),
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//                 color: AppColors.greyColor.withOpacity(0.12),
//                 borderRadius: BorderRadius.circular(12)),
//             child: Icon(Icons.person_off_outlined,
//                 color: AppColors.greyColor, size: 22),
//           ),
//           const SizedBox(width: 14),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('No Show',
//                     style: GoogleFonts.poppins(
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                         color: AppColors.greyColor)),
//                 const SizedBox(height: 2),
//                 Text(
//                   'The patient did not attend this scheduled session.',
//                   style: GoogleFonts.poppins(
//                       fontSize: 12,
//                       color: AppColors.greyColor.withOpacity(0.8)),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _detailCard(
//       BuildContext context, CustomSize size, MyAppointmentItem appt) {
//     return _cardWidget(context, size,
//         title: 'Appointment Details',
//         icon: Icons.event_note_rounded,
//         children: [
//           _row(context, size, 'Date', appt.formattedDate,
//               Icons.calendar_today_outlined),
//           _row(context, size, 'Time', appt.formattedTime,
//               Icons.access_time_rounded),
//           _row(context, size, 'Duration', '${appt.durationMinutes} min',
//               Icons.timer_outlined),
//           _row(
//               context,
//               size,
//               'Mode',
//               appt.bookedMode[0].toUpperCase() +
//                   appt.bookedMode.substring(1),
//               _modeIcon(appt.bookedMode)),
//           _row(
//               context,
//               size,
//               'Fee',
//               '${appt.currency} ${appt.feeCharged.toStringAsFixed(0)}',
//               Icons.payments_outlined),
//         ]);
//   }

//   Widget _slotCard(
//       BuildContext context, CustomSize size, AppointmentSlot slot) {
//     return _cardWidget(context, size,
//         title: 'Slot Information',
//         icon: Icons.calendar_month_rounded,
//         children: [
//           _row(context, size, 'Slot Date', slot.slotDate,
//               Icons.today_rounded),
//           _row(context, size, 'Slot Time',
//               '${slot.formattedStart} – ${slot.formattedEnd}',
//               Icons.schedule_rounded),
//           _row(
//               context,
//               size,
//               'Slot Mode',
//               slot.mode[0].toUpperCase() + slot.mode.substring(1),
//               _modeIcon(slot.mode)),
//         ]);
//   }

//   Widget _expertCard(
//       BuildContext context, CustomSize size, AppointmentExpert expert) {
//     return _cardWidget(context, size,
//         title: 'Expert Information',
//         icon: Icons.person_outline_rounded,
//         children: [
//           _row(context, size, 'Name', expert.fullName, Icons.badge_outlined),
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
//               final uri =
//                   Uri(scheme: 'mailto', path: expert.contactEmail);
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
//             _row(
//                 context,
//                 size,
//                 'By',
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
//                         color:
//                             AppColors.textSecondaryColor.withOpacity(0.4)),
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
//       margin:
//           EdgeInsets.only(bottom: size.customHeight(context) * 0.014),
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
//           Divider(height: 1, color: AppColors.greyColor.withOpacity(0.15)),
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
//             size: 14, color: AppColors.primaryColor.withOpacity(0.7)),
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
//                       fontSize: 13, color: AppColors.textPrimaryColor)),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _cardWidget(BuildContext context, CustomSize size,
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
//           Divider(height: 1, color: AppColors.greyColor.withOpacity(0.15)),
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
//         padding: EdgeInsets.only(bottom: size.customHeight(context) * 0.01),
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
//         return _StatusMeta(
//             AppColors.primaryColor, 'Confirmed', Icons.check_circle_outlined);
//       case 'completed':
//         return _StatusMeta(
//             AppColors.successColor, 'Completed', Icons.task_alt_rounded);
//       case 'cancelled':
//         return _StatusMeta(
//             AppColors.errorColor, 'Cancelled', Icons.cancel_outlined);
//       case 'no_show':
//         return _StatusMeta(
//             AppColors.greyColor, 'No Show', Icons.person_off_outlined);
//       default:
//         return _StatusMeta(AppColors.warningColor, 'Scheduled', Icons.schedule_rounded);
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
 
// // ═══════════════════════════════════════════════════════════════
// //   Shared _StatusMeta
// // ═══════════════════════════════════════════════════════════════
// class _StatusMeta {
//   final Color color;
//   final String label;
//   final IconData icon;
//   _StatusMeta(this.color, this.label, [this.icon = Icons.info_outline]);
// }


// // lib/view/parent/booking/parent_my_appointments_screen.dart
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// // Use android_intent_plus for opening URLs on Android — avoids canLaunchUrl
// // returning null for Zoom/external apps when no component is found.
// import 'package:android_intent_plus/android_intent.dart';
// import 'package:android_intent_plus/flag.dart';
// import 'dart:io' show Platform;
// import 'package:url_launcher/url_launcher.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/parent_booking_controller.dart';
// import 'package:speechspectrum/controllers/payment_controller.dart';
// import 'package:speechspectrum/models/my_appointment_model.dart';
// import 'package:speechspectrum/routes/app_routes.dart';

// // ─────────────────────────────────────────────────────────────
// //  Helper: open any URL — works for Zoom and browser links
// //  Fixes: "component name is null" on Android
// // ─────────────────────────────────────────────────────────────
// Future<void> _openUrl(String url) async {
//   final uri = Uri.parse(url);
//   if (Platform.isAndroid) {
//     try {
//       final intent = AndroidIntent(
//         action: 'action_view',
//         data: url,
//         flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
//       );
//       await intent.launch();
//       return;
//     } catch (_) {
//       // fall through to url_launcher
//     }
//   }
//   // iOS / fallback
//   if (await canLaunchUrl(uri)) {
//     await launchUrl(uri, mode: LaunchMode.externalApplication);
//   } else {
//     await launchUrl(uri, mode: LaunchMode.platformDefault);
//   }
// }

// // ═══════════════════════════════════════════════════════════════
// //   Parent My Appointments Screen
// // ═══════════════════════════════════════════════════════════════
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
//     ('No Show', Icons.person_off_outlined),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _tab = TabController(length: _tabs.length, vsync: this);
//     _c = Get.isRegistered<ParentBookingController>()
//         ? Get.find<ParentBookingController>()
//         : Get.put(ParentBookingController());
//     if (!Get.isRegistered<PaymentController>()) {
//       Get.put(PaymentController());
//     }
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
//           labelStyle:
//               GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13),
//           unselectedLabelStyle:
//               GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 13),
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
//         if (_c.isLoadingAppointments.value && _c.myAppointments.isEmpty) {
//           return _loader(context, size);
//         }
//         return TabBarView(
//           controller: _tab,
//           children: [
//             // ── ALL: smartMode=true lets each card decide by its own status
//             _list(context, size, _c.myAppointments, smartMode: true),
//             // Scheduled — show payment section only
//             _list(context, size, _c.scheduledList, showPayment: true),
//             // Confirmed — show meeting link only
//             _list(context, size, _c.confirmedList, showMeetLink: true),
//             // Completed, Cancelled, No Show — plain
//             _list(context, size, _c.completedList),
//             _list(context, size, _c.cancelledList),
//             _list(context, size, _c.noShowList),
//           ],
//         );
//       }),
//     );
//   }

//   Widget _list(
//     BuildContext context,
//     CustomSize size,
//     List<MyAppointmentItem> items, {
//     bool showPayment = false,
//     bool showMeetLink = false,
//     // When true each card derives showPayment / showMeetLink from its own status
//     bool smartMode = false,
//   }) {
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
//         itemBuilder: (_, i) {
//           final appt = items[i];
//           // In smart mode derive flags from each appointment's own status
//           final effectiveShowPayment =
//               smartMode ? appt.isScheduled : showPayment;
//           final effectiveShowMeetLink =
//               smartMode ? appt.isConfirmed : showMeetLink;
//           return _card(
//             context,
//             size,
//             appt,
//             showPayment: effectiveShowPayment,
//             showMeetLink: effectiveShowMeetLink,
//           );
//         },
//       ),
//     );
//   }

//   Widget _card(
//     BuildContext context,
//     CustomSize size,
//     MyAppointmentItem appt, {
//     bool showPayment = false,
//     bool showMeetLink = false,
//   }) {
//     final meta = _statusMeta(appt.status);
//     final isPaid =
//         appt.paymentStatus?.toLowerCase() == 'paid';

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
//             // Status color bar at top
//             Container(
//               height: 4,
//               decoration: BoxDecoration(
//                 color: meta.color,
//                 borderRadius:
//                     const BorderRadius.vertical(top: Radius.circular(20)),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(size.customWidth(context) * 0.042),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // ── Header row ─────────────────────────────
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Avatar
//                       Container(
//                         width: 50,
//                         height: 50,
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(colors: [
//                             AppColors.primaryColor.withOpacity(0.7),
//                             AppColors.primaryColor,
//                           ]),
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
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           // Status badge
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 10, vertical: 4),
//                             decoration: BoxDecoration(
//                               color: meta.color.withOpacity(0.1),
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             child: Text(meta.label,
//                                 style: GoogleFonts.poppins(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w600,
//                                     color: meta.color)),
//                           ),
//                           // Payment badge — only on Scheduled cards
//                           if (showPayment) ...[
//                             const SizedBox(height: 4),
//                             _paymentBadgeSmall(isPaid),
//                           ],
//                         ],
//                       ),
//                     ],
//                   ),

//                   SizedBox(height: size.customHeight(context) * 0.012),
//                   Divider(
//                       height: 1,
//                       color: AppColors.greyColor.withOpacity(0.15)),
//                   SizedBox(height: size.customHeight(context) * 0.01),

//                   // Info chips
//                   Wrap(
//                     spacing: 14,
//                     runSpacing: 6,
//                     children: [
//                       _chip2(Icons.calendar_today_outlined,
//                           appt.formattedDate, AppColors.primaryColor),
//                       _chip2(Icons.access_time_rounded, appt.formattedTime,
//                           AppColors.secondaryColor),
//                       _chip2(
//                           _modeIcon(appt.bookedMode),
//                           appt.bookedMode[0].toUpperCase() +
//                               appt.bookedMode.substring(1),
//                           AppColors.accentColor),
//                       _chip2(
//                           Icons.payments_outlined,
//                           '${appt.currency} ${appt.feeCharged.toStringAsFixed(0)}',
//                           AppColors.warningColor),
//                     ],
//                   ),

//                   // ── SCHEDULED CARD: Payment section ──────────
//                   if (showPayment) ...[
//                     SizedBox(height: size.customHeight(context) * 0.01),
//                     _paymentSection(context, size, appt, isPaid),
//                   ],

//                   // ── CONFIRMED CARD: Meeting link ──────────────
//                   if (showMeetLink &&
//                       appt.meetLink != null &&
//                       appt.meetLink!.isNotEmpty) ...[
//                     SizedBox(height: size.customHeight(context) * 0.01),
//                     _meetLinkBanner(context, size, appt.meetLink!),
//                   ],

//                   // Cancellation reason
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

//                   // No Show banner
//                   if (appt.isNoShow) ...[
//                     SizedBox(height: size.customHeight(context) * 0.01),
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 10, vertical: 7),
//                       decoration: BoxDecoration(
//                         color: AppColors.greyColor.withOpacity(0.08),
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(
//                             color: AppColors.greyColor.withOpacity(0.3)),
//                       ),
//                       child: Row(children: [
//                         Icon(Icons.person_off_outlined,
//                             size: 13, color: AppColors.greyColor),
//                         const SizedBox(width: 6),
//                         Expanded(
//                           child: Text(
//                             'Patient did not attend this session',
//                             style: GoogleFonts.poppins(
//                                 fontSize: 12,
//                                 color: AppColors.greyColor),
//                           ),
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

//   // Small payment badge in card header (Scheduled cards only)
//   Widget _paymentBadgeSmall(bool isPaid) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//       decoration: BoxDecoration(
//         color: isPaid
//             ? AppColors.successColor.withOpacity(0.1)
//             : AppColors.warningColor.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(
//             isPaid ? Icons.check_circle_outline : Icons.pending_outlined,
//             size: 9,
//             color: isPaid ? AppColors.successColor : AppColors.warningColor,
//           ),
//           const SizedBox(width: 3),
//           Text(
//             isPaid ? 'Paid' : 'Unpaid',
//             style: GoogleFonts.poppins(
//               fontSize: 9,
//               fontWeight: FontWeight.w600,
//               color:
//                   isPaid ? AppColors.successColor : AppColors.warningColor,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Payment section row with Pay Now button (Scheduled cards only)
//   Widget _paymentSection(BuildContext context, CustomSize size,
//       MyAppointmentItem appt, bool isPaid) {
//     if (isPaid) {
//       return Container(
//         padding:
//             const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         decoration: BoxDecoration(
//           color: AppColors.successColor.withOpacity(0.07),
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//               color: AppColors.successColor.withOpacity(0.25), width: 1),
//         ),
//         child: Row(children: [
//           const Icon(Icons.check_circle_rounded,
//               color: AppColors.successColor, size: 16),
//           const SizedBox(width: 8),
//           Text(
//             'Payment Complete',
//             style: GoogleFonts.poppins(
//               fontSize: 12,
//               color: AppColors.successColor,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ]),
//       );
//     }

//     // Pending — show Pay Now
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: AppColors.warningColor.withOpacity(0.07),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//             color: AppColors.warningColor.withOpacity(0.3), width: 1),
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.warning_amber_rounded,
//               color: AppColors.warningColor, size: 16),
//           const SizedBox(width: 8),
//           Expanded(
//             child: Text(
//               'Payment pending — tap to complete',
//               style: GoogleFonts.poppins(
//                 fontSize: 11,
//                 color: AppColors.warningColor,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//           const SizedBox(width: 8),
//           GetBuilder<PaymentController>(
//             init: Get.isRegistered<PaymentController>()
//                 ? Get.find<PaymentController>()
//                 : Get.put(PaymentController()),
//             builder: (pc) => GestureDetector(
//               onTap: pc.isInitiating.value
//                   ? null
//                   : () => pc.initiatePayment(appt.appointmentId),
//               child: Container(
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: 12, vertical: 6),
//                 decoration: BoxDecoration(
//                   color: AppColors.warningColor,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: pc.isInitiating.value
//                     ? const SizedBox(
//                         width: 14,
//                         height: 14,
//                         child: CircularProgressIndicator(
//                             color: Colors.white, strokeWidth: 2))
//                     : Text(
//                         'Pay Now',
//                         style: GoogleFonts.poppins(
//                           fontSize: 11,
//                           color: Colors.white,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Meeting link banner (Confirmed cards only)
//   Widget _meetLinkBanner(
//       BuildContext context, CustomSize size, String url) {
//     return GestureDetector(
//       onTap: () => _openUrl(url),
//       child: Container(
//         padding:
//             const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         decoration: BoxDecoration(
//           color: const Color(0xFF2196F3).withOpacity(0.07),
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//               color: const Color(0xFF2196F3).withOpacity(0.3), width: 1),
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
//             // Copy button
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
//   late final PaymentController _pc;
//   late final String _appointmentId;

//   @override
//   void initState() {
//     super.initState();
//     _c = Get.find<ParentBookingController>();
//     _pc = Get.isRegistered<PaymentController>()
//         ? Get.find<PaymentController>()
//         : Get.put(PaymentController());
//     _appointmentId = Get.arguments as String;
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _c.fetchAppointmentDetail(_appointmentId);
//       _c.fetchAppointmentRecords(_appointmentId);
//       // Only fetch payment status for scheduled appointments
//       // (we check after detail loads in _content)
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

//         // Fetch payment status only for scheduled appointments
//         if (appt.isScheduled) {
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             _pc.fetchPaymentStatus(_appointmentId);
//           });
//         }

//         return _content(context, size, appt);
//       }),
//     );
//   }

//   Widget _content(
//       BuildContext context, CustomSize size, MyAppointmentItem appt) {
//     final meta = _statusMeta(appt.status);
//     // Meeting link: only confirmed
//     final isConfirmed = appt.isConfirmed;
//     // Payment: only scheduled
//     final isScheduled = appt.isScheduled;

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
//                             Row(
//                               children: [
//                                 // Status badge
//                                 Container(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 12, vertical: 4),
//                                   decoration: BoxDecoration(
//                                     color: meta.color.withOpacity(0.2),
//                                     borderRadius: BorderRadius.circular(20),
//                                     border: Border.all(
//                                         color:
//                                             Colors.white.withOpacity(0.4)),
//                                   ),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Icon(meta.icon,
//                                           color: Colors.white, size: 12),
//                                       const SizedBox(width: 5),
//                                       Text(meta.label,
//                                           style: GoogleFonts.poppins(
//                                               color: Colors.white,
//                                               fontSize: 12,
//                                               fontWeight: FontWeight.w600)),
//                                     ],
//                                   ),
//                                 ),
//                                 // Payment badge in header — only for scheduled
//                                 if (isScheduled) ...[
//                                   const SizedBox(width: 6),
//                                   Obx(() {
//                                     final ps = _pc.paymentStatus.value;
//                                     final isPaid = ps?.isPaid ??
//                                         appt.paymentStatus?.toLowerCase() ==
//                                             'paid';
//                                     return Container(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 10, vertical: 4),
//                                       decoration: BoxDecoration(
//                                         color: isPaid
//                                             ? AppColors.successColor
//                                                 .withOpacity(0.2)
//                                             : AppColors.warningColor
//                                                 .withOpacity(0.2),
//                                         borderRadius:
//                                             BorderRadius.circular(20),
//                                         border: Border.all(
//                                             color: Colors.white
//                                                 .withOpacity(0.4)),
//                                       ),
//                                       child: Text(
//                                         isPaid ? 'Paid' : 'Unpaid',
//                                         style: GoogleFonts.poppins(
//                                             color: Colors.white,
//                                             fontSize: 11,
//                                             fontWeight: FontWeight.w600),
//                                       ),
//                                     );
//                                   }),
//                                 ],
//                               ],
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

//               // ── CONFIRMED ONLY: Meet link ────────────────────
//               if (isConfirmed &&
//                   appt.meetLink != null &&
//                   appt.meetLink!.isNotEmpty) ...[
//                 _meetLinkCard(context, size, appt.meetLink!),
//                 SizedBox(height: size.customHeight(context) * 0.018),
//               ],

//               // ── SCHEDULED ONLY: Payment card ─────────────────
//               if (isScheduled) ...[
//                 _paymentCard(context, size, appt),
//                 SizedBox(height: size.customHeight(context) * 0.018),
//               ],

//               // No Show info card
//               if (appt.isNoShow) ...[
//                 _noShowCard(context, size),
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

//               // Session records (only for completed)
//               if (appt.isCompleted) ...[
//                 _recordsSection(context, size),
//                 SizedBox(height: size.customHeight(context) * 0.04),
//               ],
//             ]),
//           ),
//         ),
//       ],
//     );
//   }

//   // ── Payment Card — Scheduled only ─────────────────────────
//   Widget _paymentCard(
//       BuildContext context, CustomSize size, MyAppointmentItem appt) {
//     return Obx(() {
//       final ps = _pc.paymentStatus.value;
//       final rawStatus = ps?.status ?? appt.paymentStatus ?? 'pending';
//       final isPaid = rawStatus.toLowerCase() == 'paid';

//       return Container(
//         padding: EdgeInsets.all(size.customWidth(context) * 0.045),
//         decoration: BoxDecoration(
//           color: AppColors.whiteColor,
//           borderRadius: BorderRadius.circular(18),
//           boxShadow: [
//             BoxShadow(
//                 color: Colors.black.withOpacity(0.05),
//                 blurRadius: 10,
//                 offset: const Offset(0, 3))
//           ],
//           border: Border.all(
//             color: isPaid
//                 ? AppColors.successColor.withOpacity(0.3)
//                 : AppColors.warningColor.withOpacity(0.4),
//             width: 1.5,
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(children: [
//               Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                       color: isPaid
//                           ? AppColors.successColor.withOpacity(0.1)
//                           : AppColors.warningColor.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(10)),
//                   child: Icon(
//                     isPaid
//                         ? Icons.check_circle_rounded
//                         : Icons.payment_rounded,
//                     color: isPaid
//                         ? AppColors.successColor
//                         : AppColors.warningColor,
//                     size: 18,
//                   )),
//               const SizedBox(width: 10),
//               Text('Payment',
//                   style: GoogleFonts.poppins(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.textPrimaryColor)),
//               const Spacer(),
//               Obx(() => _pc.isLoadingStatus.value
//                   ? const SizedBox(
//                       width: 16,
//                       height: 16,
//                       child: CircularProgressIndicator(
//                           color: AppColors.primaryColor, strokeWidth: 2))
//                   : GestureDetector(
//                       onTap: () =>
//                           _pc.fetchPaymentStatus(appt.appointmentId),
//                       child: const Icon(Icons.refresh_rounded,
//                           size: 18,
//                           color: AppColors.textSecondaryColor),
//                     )),
//             ]),
//             SizedBox(height: size.customHeight(context) * 0.014),
//             Divider(height: 1, color: AppColors.greyColor.withOpacity(0.15)),
//             SizedBox(height: size.customHeight(context) * 0.012),

//             _row(context, size, 'Amount',
//                 '${appt.currency} ${appt.feeCharged.toStringAsFixed(0)}',
//                 Icons.payments_outlined),

//             Padding(
//               padding: EdgeInsets.only(
//                   bottom: size.customHeight(context) * 0.01),
//               child: Row(
//                 children: [
//                   Icon(Icons.circle,
//                       size: 8,
//                       color: isPaid
//                           ? AppColors.successColor
//                           : AppColors.warningColor),
//                   const SizedBox(width: 10),
//                   SizedBox(
//                     width: size.customWidth(context) * 0.22,
//                     child: Text('Status',
//                         style: GoogleFonts.poppins(
//                             fontSize: 12,
//                             color: AppColors.textSecondaryColor,
//                             fontWeight: FontWeight.w500)),
//                   ),
//                   Text(
//                     isPaid ? 'Paid' : 'Pending — needs payment',
//                     style: GoogleFonts.poppins(
//                       fontSize: 13,
//                       fontWeight: FontWeight.w600,
//                       color: isPaid
//                           ? AppColors.successColor
//                           : AppColors.warningColor,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             // Pay button — only if not paid
//             if (!isPaid) ...[
//               SizedBox(height: size.customHeight(context) * 0.014),
//               Obx(() => SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton.icon(
//                       onPressed: _pc.isInitiating.value
//                           ? null
//                           : () => _pc.initiatePayment(appt.appointmentId),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.warningColor,
//                         disabledBackgroundColor:
//                             AppColors.warningColor.withOpacity(0.5),
//                         padding: const EdgeInsets.symmetric(vertical: 13),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12)),
//                       ),
//                       icon: _pc.isInitiating.value
//                           ? const SizedBox(
//                               width: 16,
//                               height: 16,
//                               child: CircularProgressIndicator(
//                                   color: Colors.white, strokeWidth: 2))
//                           : const Icon(Icons.payment_rounded,
//                               color: Colors.white, size: 18),
//                       label: Text(
//                         _pc.isInitiating.value
//                             ? 'Opening Payment...'
//                             : 'Pay Now — ${appt.currency} ${appt.feeCharged.toStringAsFixed(0)}',
//                         style: GoogleFonts.poppins(
//                           color: Colors.white,
//                           fontWeight: FontWeight.w700,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ),
//                   )),
//             ],
//           ],
//         ),
//       );
//     });
//   }

//   // ── Meet link card — Confirmed only ───────────────────────
//   Widget _meetLinkCard(
//       BuildContext context, CustomSize size, String url) {
//     return GestureDetector(
//       onTap: () => _openUrl(url),
//       child: Container(
//         padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [Color(0xFF2196F3), Color(0xFF1565C0)],
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
//                   Text('Tap to open in browser',
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

//   Widget _noShowCard(BuildContext context, CustomSize size) {
//     return Container(
//       padding: EdgeInsets.all(size.customWidth(context) * 0.045),
//       decoration: BoxDecoration(
//         color: AppColors.greyColor.withOpacity(0.07),
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(color: AppColors.greyColor.withOpacity(0.3)),
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//                 color: AppColors.greyColor.withOpacity(0.12),
//                 borderRadius: BorderRadius.circular(12)),
//             child: Icon(Icons.person_off_outlined,
//                 color: AppColors.greyColor, size: 22),
//           ),
//           const SizedBox(width: 14),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('No Show',
//                     style: GoogleFonts.poppins(
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                         color: AppColors.greyColor)),
//                 const SizedBox(height: 2),
//                 Text(
//                   'The patient did not attend this scheduled session.',
//                   style: GoogleFonts.poppins(
//                       fontSize: 12,
//                       color: AppColors.greyColor.withOpacity(0.8)),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _detailCard(
//       BuildContext context, CustomSize size, MyAppointmentItem appt) {
//     return _cardWidget(context, size,
//         title: 'Appointment Details',
//         icon: Icons.event_note_rounded,
//         children: [
//           _row(context, size, 'Date', appt.formattedDate,
//               Icons.calendar_today_outlined),
//           _row(context, size, 'Time', appt.formattedTime,
//               Icons.access_time_rounded),
//           _row(context, size, 'Duration', '${appt.durationMinutes} min',
//               Icons.timer_outlined),
//           _row(
//               context,
//               size,
//               'Mode',
//               appt.bookedMode[0].toUpperCase() +
//                   appt.bookedMode.substring(1),
//               _modeIcon(appt.bookedMode)),
//           _row(
//               context,
//               size,
//               'Fee',
//               '${appt.currency} ${appt.feeCharged.toStringAsFixed(0)}',
//               Icons.payments_outlined),
//         ]);
//   }

//   Widget _slotCard(
//       BuildContext context, CustomSize size, AppointmentSlot slot) {
//     return _cardWidget(context, size,
//         title: 'Slot Information',
//         icon: Icons.calendar_month_rounded,
//         children: [
//           _row(context, size, 'Slot Date', slot.slotDate,
//               Icons.today_rounded),
//           _row(context, size, 'Slot Time',
//               '${slot.formattedStart} – ${slot.formattedEnd}',
//               Icons.schedule_rounded),
//           _row(
//               context,
//               size,
//               'Slot Mode',
//               slot.mode[0].toUpperCase() + slot.mode.substring(1),
//               _modeIcon(slot.mode)),
//         ]);
//   }

//   Widget _expertCard(
//       BuildContext context, CustomSize size, AppointmentExpert expert) {
//     return _cardWidget(context, size,
//         title: 'Expert Information',
//         icon: Icons.person_outline_rounded,
//         children: [
//           _row(context, size, 'Name', expert.fullName, Icons.badge_outlined),
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
//               final uri =
//                   Uri(scheme: 'mailto', path: expert.contactEmail);
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
//             _row(
//                 context,
//                 size,
//                 'By',
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
//                         color:
//                             AppColors.textSecondaryColor.withOpacity(0.4)),
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
//       margin:
//           EdgeInsets.only(bottom: size.customHeight(context) * 0.014),
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
//           Divider(height: 1, color: AppColors.greyColor.withOpacity(0.15)),
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
//             size: 14, color: AppColors.primaryColor.withOpacity(0.7)),
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
//                       fontSize: 13, color: AppColors.textPrimaryColor)),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _cardWidget(BuildContext context, CustomSize size,
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
//           Divider(height: 1, color: AppColors.greyColor.withOpacity(0.15)),
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
//         padding: EdgeInsets.only(bottom: size.customHeight(context) * 0.01),
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
//         return _StatusMeta(
//             AppColors.primaryColor, 'Confirmed', Icons.check_circle_outlined);
//       case 'completed':
//         return _StatusMeta(
//             AppColors.successColor, 'Completed', Icons.task_alt_rounded);case 'cancelled':
//         return _StatusMeta(
//             AppColors.errorColor, 'Cancelled', Icons.cancel_outlined);
//       case 'no_show':
//         return _StatusMeta(
//             AppColors.greyColor, 'No Show', Icons.person_off_outlined);
//       default:
//         return _StatusMeta(
//             AppColors.warningColor, 'Scheduled', Icons.schedule_rounded);
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
//   }}
 
// // ═══════════════════════════════════════════════════════════════
// //   Shared _StatusMeta
// // ═══════════════════════════════════════════════════════════════
// class _StatusMeta {
//   final Color color;
//   final String label;
//   final IconData icon;
//   _StatusMeta(this.color, this.label, [this.icon = Icons.info_outline]);
// }



// // lib/view/parent/booking/parent_my_appointments_screen.dart
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:android_intent_plus/android_intent.dart';
// import 'package:android_intent_plus/flag.dart';
// import 'dart:io' show Platform;
// import 'package:url_launcher/url_launcher.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/parent_booking_controller.dart';
// import 'package:speechspectrum/controllers/payment_controller.dart';
// import 'package:speechspectrum/models/my_appointment_model.dart';
// import 'package:speechspectrum/routes/app_routes.dart';

// // ─────────────────────────────────────────────────────────────
// //  Helper: open any URL — works for Zoom and browser links
// // ─────────────────────────────────────────────────────────────
// Future<void> _openUrl(String url) async {
//   final uri = Uri.parse(url);
//   if (Platform.isAndroid) {
//     try {
//       final intent = AndroidIntent(
//         action: 'action_view',
//         data: url,
//         flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
//       );
//       await intent.launch();
//       return;
//     } catch (_) {}
//   }
//   if (await canLaunchUrl(uri)) {
//     await launchUrl(uri, mode: LaunchMode.externalApplication);
//   } else {
//     await launchUrl(uri, mode: LaunchMode.platformDefault);
//   }
// }

// // ═══════════════════════════════════════════════════════════════
// //   Parent My Appointments Screen
// // ═══════════════════════════════════════════════════════════════
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
//     ('No Show', Icons.person_off_outlined),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _tab = TabController(length: _tabs.length, vsync: this);
//     _c = Get.isRegistered<ParentBookingController>()
//         ? Get.find<ParentBookingController>()
//         : Get.put(ParentBookingController());
//     if (!Get.isRegistered<PaymentController>()) {
//       Get.put(PaymentController());
//     }
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
//           labelStyle:
//               GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13),
//           unselectedLabelStyle:
//               GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 13),
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
//         if (_c.isLoadingAppointments.value && _c.myAppointments.isEmpty) {
//           return _loader(context, size);
//         }
//         return TabBarView(
//           controller: _tab,
//           children: [
//             // ALL: smartMode derives flags per card
//             _list(context, size, _c.myAppointments, smartMode: true),
//             // Scheduled — no payment, no meet link (plain list)
//             _list(context, size, _c.scheduledList),
//             // Confirmed — show payment section + meet link
//             _list(context, size, _c.confirmedList,
//                 showPayment: true, showMeetLink: true),
//             // Completed, Cancelled, No Show — plain
//             _list(context, size, _c.completedList),
//             _list(context, size, _c.cancelledList),
//             _list(context, size, _c.noShowList),
//           ],
//         );
//       }),
//     );
//   }

//   Widget _list(
//     BuildContext context,
//     CustomSize size,
//     List<MyAppointmentItem> items, {
//     bool showPayment = false,
//     bool showMeetLink = false,
//     bool smartMode = false,
//   }) {
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
//         itemBuilder: (_, i) {
//           final appt = items[i];
//           // In smart mode derive flags from each appointment's own status
//           final effectiveShowPayment =
//               smartMode ? appt.isConfirmed : showPayment;
//           final effectiveShowMeetLink =
//               smartMode ? appt.isConfirmed : showMeetLink;
//           return _card(
//             context,
//             size,
//             appt,
//             showPayment: effectiveShowPayment,
//             showMeetLink: effectiveShowMeetLink,
//           );
//         },
//       ),
//     );
//   }

//   Widget _card(
//     BuildContext context,
//     CustomSize size,
//     MyAppointmentItem appt, {
//     bool showPayment = false,
//     bool showMeetLink = false,
//   }) {
//     final meta = _statusMeta(appt.status);
//     final isPaid = appt.paymentStatus?.toLowerCase() == 'paid';

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
//             // Status color bar at top
//             Container(
//               height: 4,
//               decoration: BoxDecoration(
//                 color: meta.color,
//                 borderRadius:
//                     const BorderRadius.vertical(top: Radius.circular(20)),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(size.customWidth(context) * 0.042),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // ── Header row ─────────────────────────────
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Avatar
//                       Container(
//                         width: 50,
//                         height: 50,
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(colors: [
//                             AppColors.primaryColor.withOpacity(0.7),
//                             AppColors.primaryColor,
//                           ]),
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
//                                   fontSize: size.customWidth(context) * 0.04,
//                                   fontWeight: FontWeight.w700,
//                                   color: AppColors.textPrimaryColor),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                             Text(
//                               appt.expertUsers?.fullName ?? '',
//                               style: GoogleFonts.poppins(
//                                   fontSize: size.customWidth(context) * 0.031,
//                                   color: AppColors.primaryColor,
//                                   fontWeight: FontWeight.w500),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ],
//                         ),
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           // Status badge
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 10, vertical: 4),
//                             decoration: BoxDecoration(
//                               color: meta.color.withOpacity(0.1),
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             child: Text(meta.label,
//                                 style: GoogleFonts.poppins(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w600,
//                                     color: meta.color)),
//                           ),
//                           // Payment badge — only on Confirmed cards
//                           if (showPayment) ...[
//                             const SizedBox(height: 4),
//                             _paymentBadgeSmall(isPaid),
//                           ],
//                         ],
//                       ),
//                     ],
//                   ),

//                   SizedBox(height: size.customHeight(context) * 0.012),
//                   Divider(
//                       height: 1,
//                       color: AppColors.greyColor.withOpacity(0.15)),
//                   SizedBox(height: size.customHeight(context) * 0.01),

//                   // Info chips
//                   Wrap(
//                     spacing: 14,
//                     runSpacing: 6,
//                     children: [
//                       _chip2(Icons.calendar_today_outlined,
//                           appt.formattedDate, AppColors.primaryColor),
//                       _chip2(Icons.access_time_rounded, appt.formattedTime,
//                           AppColors.secondaryColor),
//                       _chip2(
//                           _modeIcon(appt.bookedMode),
//                           appt.bookedMode[0].toUpperCase() +
//                               appt.bookedMode.substring(1),
//                           AppColors.accentColor),
//                       _chip2(
//                           Icons.payments_outlined,
//                           '${appt.currency} ${appt.feeCharged.toStringAsFixed(0)}',
//                           AppColors.warningColor),
//                     ],
//                   ),

//                   // ── CONFIRMED CARD: Payment section ──────────
//                   if (showPayment) ...[
//                     SizedBox(height: size.customHeight(context) * 0.01),
//                     _paymentSection(context, size, appt, isPaid),
//                   ],

//                   // ── CONFIRMED CARD: Meeting link ──────────────
//                   if (showMeetLink &&
//                       appt.meetLink != null &&
//                       appt.meetLink!.isNotEmpty) ...[
//                     SizedBox(height: size.customHeight(context) * 0.01),
//                     _meetLinkBanner(context, size, appt.meetLink!),
//                   ],

//                   // Cancellation reason
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

//                   // No Show banner
//                   if (appt.isNoShow) ...[
//                     SizedBox(height: size.customHeight(context) * 0.01),
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 10, vertical: 7),
//                       decoration: BoxDecoration(
//                         color: AppColors.greyColor.withOpacity(0.08),
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(
//                             color: AppColors.greyColor.withOpacity(0.3)),
//                       ),
//                       child: Row(children: [
//                         Icon(Icons.person_off_outlined,
//                             size: 13, color: AppColors.greyColor),
//                         const SizedBox(width: 6),
//                         Expanded(
//                           child: Text(
//                             'Patient did not attend this session',
//                             style: GoogleFonts.poppins(
//                                 fontSize: 12,
//                                 color: AppColors.greyColor),
//                           ),
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

//   // Small payment badge in card header (Confirmed cards only)
//   Widget _paymentBadgeSmall(bool isPaid) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//       decoration: BoxDecoration(
//         color: isPaid
//             ? AppColors.successColor.withOpacity(0.1)
//             : AppColors.warningColor.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(
//             isPaid ? Icons.check_circle_outline : Icons.pending_outlined,
//             size: 9,
//             color: isPaid ? AppColors.successColor : AppColors.warningColor,
//           ),
//           const SizedBox(width: 3),
//           Text(
//             isPaid ? 'Paid' : 'Unpaid',
//             style: GoogleFonts.poppins(
//               fontSize: 9,
//               fontWeight: FontWeight.w600,
//               color: isPaid ? AppColors.successColor : AppColors.warningColor,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Payment section row with Pay Now button (Confirmed cards only)
//   Widget _paymentSection(BuildContext context, CustomSize size,
//       MyAppointmentItem appt, bool isPaid) {
//     if (isPaid) {
//       return Container(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         decoration: BoxDecoration(
//           color: AppColors.successColor.withOpacity(0.07),
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//               color: AppColors.successColor.withOpacity(0.25), width: 1),
//         ),
//         child: Row(children: [
//           const Icon(Icons.check_circle_rounded,
//               color: AppColors.successColor, size: 16),
//           const SizedBox(width: 8),
//           Text(
//             'Payment Complete',
//             style: GoogleFonts.poppins(
//               fontSize: 12,
//               color: AppColors.successColor,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ]),
//       );
//     }

//     // Pending — show Pay Now
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: AppColors.warningColor.withOpacity(0.07),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//             color: AppColors.warningColor.withOpacity(0.3), width: 1),
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.warning_amber_rounded,
//               color: AppColors.warningColor, size: 16),
//           const SizedBox(width: 8),
//           Expanded(
//             child: Text(
//               'Payment pending — tap to complete',
//               style: GoogleFonts.poppins(
//                 fontSize: 11,
//                 color: AppColors.warningColor,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//           const SizedBox(width: 8),
//           GetBuilder<PaymentController>(
//             init: Get.isRegistered<PaymentController>()
//                 ? Get.find<PaymentController>()
//                 : Get.put(PaymentController()),
//             builder: (pc) => GestureDetector(
//               onTap: pc.isInitiating.value
//                   ? null
//                   : () => pc.initiatePayment(appt.appointmentId),
//               child: Container(
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: 12, vertical: 6),
//                 decoration: BoxDecoration(
//                   color: AppColors.warningColor,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: pc.isInitiating.value
//                     ? const SizedBox(
//                         width: 14,
//                         height: 14,
//                         child: CircularProgressIndicator(
//                             color: Colors.white, strokeWidth: 2))
//                     : Text(
//                         'Pay Now',
//                         style: GoogleFonts.poppins(
//                           fontSize: 11,
//                           color: Colors.white,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Meeting link banner (Confirmed cards only)
//   Widget _meetLinkBanner(
//       BuildContext context, CustomSize size, String url) {
//     return GestureDetector(
//       onTap: () => _openUrl(url),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         decoration: BoxDecoration(
//           color: const Color(0xFF2196F3).withOpacity(0.07),
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//               color: const Color(0xFF2196F3).withOpacity(0.3), width: 1),
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
//   late final PaymentController _pc;
//   late final String _appointmentId;

//   @override
//   void initState() {
//     super.initState();
//     _c = Get.find<ParentBookingController>();
//     _pc = Get.isRegistered<PaymentController>()
//         ? Get.find<PaymentController>()
//         : Get.put(PaymentController());
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

//         // Fetch payment status only for confirmed appointments
//         if (appt.isConfirmed) {
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             _pc.fetchPaymentStatus(_appointmentId);
//           });
//         }

//         return _content(context, size, appt);
//       }),
//     );
//   }

//   Widget _content(
//       BuildContext context, CustomSize size, MyAppointmentItem appt) {
//     final meta = _statusMeta(appt.status);
//     // Both payment and meet link: only for confirmed
//     final isConfirmed = appt.isConfirmed;

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
//                                   fontSize: size.customWidth(context) * 0.044,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             Text(
//                               appt.expertUsers?.fullName ?? '',
//                               style: GoogleFonts.poppins(
//                                   color: Colors.white.withOpacity(0.85),
//                                   fontSize: size.customWidth(context) * 0.031),
//                             ),
//                             const SizedBox(height: 6),
//                             Row(
//                               children: [
//                                 // Status badge
//                                 Container(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 12, vertical: 4),
//                                   decoration: BoxDecoration(
//                                     color: meta.color.withOpacity(0.2),
//                                     borderRadius: BorderRadius.circular(20),
//                                     border: Border.all(
//                                         color: Colors.white.withOpacity(0.4)),
//                                   ),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Icon(meta.icon,
//                                           color: Colors.white, size: 12),
//                                       const SizedBox(width: 5),
//                                       Text(meta.label,
//                                           style: GoogleFonts.poppins(
//                                               color: Colors.white,
//                                               fontSize: 12,
//                                               fontWeight: FontWeight.w600)),
//                                     ],
//                                   ),
//                                 ),
//                                 // Payment badge in header — only for confirmed
//                                 if (isConfirmed) ...[
//                                   const SizedBox(width: 6),
//                                   Obx(() {
//                                     final ps = _pc.paymentStatus.value;
//                                     final isPaid = ps?.isPaid ??
//                                         appt.paymentStatus?.toLowerCase() ==
//                                             'paid';
//                                     return Container(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 10, vertical: 4),
//                                       decoration: BoxDecoration(
//                                         color: isPaid
//                                             ? AppColors.successColor
//                                                 .withOpacity(0.2)
//                                             : AppColors.warningColor
//                                                 .withOpacity(0.2),
//                                         borderRadius:
//                                             BorderRadius.circular(20),
//                                         border: Border.all(
//                                             color: Colors.white
//                                                 .withOpacity(0.4)),
//                                       ),
//                                       child: Text(
//                                         isPaid ? 'Paid' : 'Unpaid',
//                                         style: GoogleFonts.poppins(
//                                             color: Colors.white,
//                                             fontSize: 11,
//                                             fontWeight: FontWeight.w600),
//                                       ),
//                                     );
//                                   }),
//                                 ],
//                               ],
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

//               // ── CONFIRMED ONLY: Meet link ────────────────────
//               if (isConfirmed &&
//                   appt.meetLink != null &&
//                   appt.meetLink!.isNotEmpty) ...[
//                 _meetLinkCard(context, size, appt.meetLink!),
//                 SizedBox(height: size.customHeight(context) * 0.018),
//               ],

//               // ── CONFIRMED ONLY: Payment card ─────────────────
//               if (isConfirmed) ...[
//                 _paymentCard(context, size, appt),
//                 SizedBox(height: size.customHeight(context) * 0.018),
//               ],

//               // No Show info card
//               if (appt.isNoShow) ...[
//                 _noShowCard(context, size),
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

//               // Session records (only for completed)
//               if (appt.isCompleted) ...[
//                 _recordsSection(context, size),
//                 SizedBox(height: size.customHeight(context) * 0.04),
//               ],
//             ]),
//           ),
//         ),
//       ],
//     );
//   }

//   // ── Payment Card — Confirmed only ─────────────────────────
//   Widget _paymentCard(
//       BuildContext context, CustomSize size, MyAppointmentItem appt) {
//     return Obx(() {
//       final ps = _pc.paymentStatus.value;
//       final rawStatus = ps?.status ?? appt.paymentStatus ?? 'pending';
//       final isPaid = rawStatus.toLowerCase() == 'paid';

//       return Container(
//         padding: EdgeInsets.all(size.customWidth(context) * 0.045),
//         decoration: BoxDecoration(
//           color: AppColors.whiteColor,
//           borderRadius: BorderRadius.circular(18),
//           boxShadow: [
//             BoxShadow(
//                 color: Colors.black.withOpacity(0.05),
//                 blurRadius: 10,
//                 offset: const Offset(0, 3))
//           ],
//           border: Border.all(
//             color: isPaid
//                 ? AppColors.successColor.withOpacity(0.3)
//                 : AppColors.warningColor.withOpacity(0.4),
//             width: 1.5,
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(children: [
//               Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                       color: isPaid
//                           ? AppColors.successColor.withOpacity(0.1)
//                           : AppColors.warningColor.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(10)),
//                   child: Icon(
//                     isPaid
//                         ? Icons.check_circle_rounded
//                         : Icons.payment_rounded,
//                     color: isPaid
//                         ? AppColors.successColor
//                         : AppColors.warningColor,
//                     size: 18,
//                   )),
//               const SizedBox(width: 10),
//               Text('Payment',
//                   style: GoogleFonts.poppins(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.textPrimaryColor)),
//               const Spacer(),
//               Obx(() => _pc.isLoadingStatus.value
//                   ? const SizedBox(
//                       width: 16,
//                       height: 16,
//                       child: CircularProgressIndicator(
//                           color: AppColors.primaryColor, strokeWidth: 2))
//                   : GestureDetector(
//                       onTap: () =>
//                           _pc.fetchPaymentStatus(appt.appointmentId),
//                       child: const Icon(Icons.refresh_rounded,
//                           size: 18,
//                           color: AppColors.textSecondaryColor),
//                     )),
//             ]),
//             SizedBox(height: size.customHeight(context) * 0.014),
//             Divider(height: 1, color: AppColors.greyColor.withOpacity(0.15)),
//             SizedBox(height: size.customHeight(context) * 0.012),

//             _row(context, size, 'Amount',
//                 '${appt.currency} ${appt.feeCharged.toStringAsFixed(0)}',
//                 Icons.payments_outlined),

//             Padding(
//               padding: EdgeInsets.only(
//                   bottom: size.customHeight(context) * 0.01),
//               child: Row(
//                 children: [
//                   Icon(Icons.circle,
//                       size: 8,
//                       color: isPaid
//                           ? AppColors.successColor
//                           : AppColors.warningColor),
//                   const SizedBox(width: 10),
//                   SizedBox(
//                     width: size.customWidth(context) * 0.22,
//                     child: Text('Status',
//                         style: GoogleFonts.poppins(
//                             fontSize: 12,
//                             color: AppColors.textSecondaryColor,
//                             fontWeight: FontWeight.w500)),
//                   ),
//                   Text(
//                     isPaid ? 'Paid' : 'Pending — needs payment',
//                     style: GoogleFonts.poppins(
//                       fontSize: 13,
//                       fontWeight: FontWeight.w600,
//                       color: isPaid
//                           ? AppColors.successColor
//                           : AppColors.warningColor,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             // Pay button — only if not paid
//             if (!isPaid) ...[
//               SizedBox(height: size.customHeight(context) * 0.014),
//               Obx(() => SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton.icon(
//                       onPressed: _pc.isInitiating.value
//                           ? null
//                           : () => _pc.initiatePayment(appt.appointmentId),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.warningColor,
//                         disabledBackgroundColor:
//                             AppColors.warningColor.withOpacity(0.5),
//                         padding: const EdgeInsets.symmetric(vertical: 13),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12)),
//                       ),
//                       icon: _pc.isInitiating.value
//                           ? const SizedBox(
//                               width: 16,
//                               height: 16,
//                               child: CircularProgressIndicator(
//                                   color: Colors.white, strokeWidth: 2))
//                           : const Icon(Icons.payment_rounded,
//                               color: Colors.white, size: 18),
//                       label: Text(
//                         _pc.isInitiating.value
//                             ? 'Opening Payment...'
//                             : 'Pay Now — ${appt.currency} ${appt.feeCharged.toStringAsFixed(0)}',
//                         style: GoogleFonts.poppins(
//                           color: Colors.white,
//                           fontWeight: FontWeight.w700,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ),
//                   )),
//             ],
//           ],
//         ),
//       );
//     });
//   }

//   // ── Meet link card — Confirmed only ───────────────────────
//   Widget _meetLinkCard(
//       BuildContext context, CustomSize size, String url) {
//     return GestureDetector(
//       onTap: () => _openUrl(url),
//       child: Container(
//         padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [Color(0xFF2196F3), Color(0xFF1565C0)],
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
//                   Text('Tap to open in browser',
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

//   Widget _noShowCard(BuildContext context, CustomSize size) {
//     return Container(
//       padding: EdgeInsets.all(size.customWidth(context) * 0.045),
//       decoration: BoxDecoration(
//         color: AppColors.greyColor.withOpacity(0.07),
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(color: AppColors.greyColor.withOpacity(0.3)),
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//                 color: AppColors.greyColor.withOpacity(0.12),
//                 borderRadius: BorderRadius.circular(12)),
//             child: Icon(Icons.person_off_outlined,
//                 color: AppColors.greyColor, size: 22),
//           ),
//           const SizedBox(width: 14),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('No Show',
//                     style: GoogleFonts.poppins(
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                         color: AppColors.greyColor)),
//                 const SizedBox(height: 2),
//                 Text(
//                   'The patient did not attend this scheduled session.',
//                   style: GoogleFonts.poppins(
//                       fontSize: 12,
//                       color: AppColors.greyColor.withOpacity(0.8)),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _detailCard(
//       BuildContext context, CustomSize size, MyAppointmentItem appt) {
//     return _cardWidget(context, size,
//         title: 'Appointment Details',
//         icon: Icons.event_note_rounded,
//         children: [
//           _row(context, size, 'Date', appt.formattedDate,
//               Icons.calendar_today_outlined),
//           _row(context, size, 'Time', appt.formattedTime,
//               Icons.access_time_rounded),
//           _row(context, size, 'Duration', '${appt.durationMinutes} min',
//               Icons.timer_outlined),
//           _row(
//               context,
//               size,
//               'Mode',
//               appt.bookedMode[0].toUpperCase() +
//                   appt.bookedMode.substring(1),
//               _modeIcon(appt.bookedMode)),
//           _row(
//               context,
//               size,
//               'Fee',
//               '${appt.currency} ${appt.feeCharged.toStringAsFixed(0)}',
//               Icons.payments_outlined),
//         ]);
//   }

//   Widget _slotCard(
//       BuildContext context, CustomSize size, AppointmentSlot slot) {
//     return _cardWidget(context, size,
//         title: 'Slot Information',
//         icon: Icons.calendar_month_rounded,
//         children: [
//           _row(context, size, 'Slot Date', slot.slotDate,
//               Icons.today_rounded),
//           _row(context, size, 'Slot Time',
//               '${slot.formattedStart} – ${slot.formattedEnd}',
//               Icons.schedule_rounded),
//           _row(
//               context,
//               size,
//               'Slot Mode',
//               slot.mode[0].toUpperCase() + slot.mode.substring(1),
//               _modeIcon(slot.mode)),
//         ]);
//   }

//   Widget _expertCard(
//       BuildContext context, CustomSize size, AppointmentExpert expert) {
//     return _cardWidget(context, size,
//         title: 'Expert Information',
//         icon: Icons.person_outline_rounded,
//         children: [
//           _row(context, size, 'Name', expert.fullName, Icons.badge_outlined),
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
//               final uri =
//                   Uri(scheme: 'mailto', path: expert.contactEmail);
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
//             _row(
//                 context,
//                 size,
//                 'By',
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
//                         color:
//                             AppColors.textSecondaryColor.withOpacity(0.4)),
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
//           Divider(height: 1, color: AppColors.greyColor.withOpacity(0.15)),
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
//             size: 14, color: AppColors.primaryColor.withOpacity(0.7)),
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
//                       fontSize: 13, color: AppColors.textPrimaryColor)),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _cardWidget(BuildContext context, CustomSize size,
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
//           Divider(height: 1, color: AppColors.greyColor.withOpacity(0.15)),
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
//         padding: EdgeInsets.only(bottom: size.customHeight(context) * 0.01),
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
//         return _StatusMeta(
//             AppColors.primaryColor, 'Confirmed', Icons.check_circle_outlined);
//       case 'completed':
//         return _StatusMeta(
//             AppColors.successColor, 'Completed', Icons.task_alt_rounded);
//       case 'cancelled':
//         return _StatusMeta(
//             AppColors.errorColor, 'Cancelled', Icons.cancel_outlined);
//       case 'no_show':
//         return _StatusMeta(
//             AppColors.greyColor, 'No Show', Icons.person_off_outlined);
//       default:
//         return _StatusMeta(
//             AppColors.warningColor, 'Scheduled', Icons.schedule_rounded);
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

// // ═══════════════════════════════════════════════════════════════
// //   Shared _StatusMeta
// // ═══════════════════════════════════════════════════════════════
// class _StatusMeta {
//   final Color color;
//   final String label;
//   final IconData icon;
//   _StatusMeta(this.color, this.label, [this.icon = Icons.info_outline]);
// }


// lib/view/parents/booking/parent_my_appointments_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'dart:io' show Platform;
import 'package:url_launcher/url_launcher.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import 'package:speechspectrum/controllers/parent_booking_controller.dart';
import 'package:speechspectrum/controllers/payment_controller.dart';
import 'package:speechspectrum/models/my_appointment_model.dart';
import 'package:speechspectrum/routes/app_routes.dart';

// ─────────────────────────────────────────────────────────────
//  URL launcher helper
// ─────────────────────────────────────────────────────────────
Future<void> _openUrl(String url) async {
  final uri = Uri.parse(url);
  if (Platform.isAndroid) {
    try {
      final intent = AndroidIntent(
        action: 'action_view',
        data: url,
        flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
      );
      await intent.launch();
      return;
    } catch (_) {}
  }
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    await launchUrl(uri, mode: LaunchMode.platformDefault);
  }
}

// ─────────────────────────────────────────────────────────────
//  Date helpers
// ─────────────────────────────────────────────────────────────
bool _isExpired(MyAppointmentItem appt) {
  try {
    final scheduled = DateTime.parse(appt.scheduledAt);
    final now = DateTime.now();
    return scheduled.isBefore(now);
  } catch (_) {
    return false;
  }
}

bool _isMeetLinkExpired(MyAppointmentItem appt) => _isExpired(appt);

// ═══════════════════════════════════════════════════════════════
//   Parent My Appointments Screen
// ═══════════════════════════════════════════════════════════════
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

  // ── Tabs: Requested replaces Scheduled, Expired added ──────
  static const _tabs = [
    ('All', Icons.list_alt_rounded),
    ('Requested', Icons.pending_actions_rounded),   // was Scheduled
    ('Confirmed', Icons.check_circle_outline_rounded),
    ('Expired', Icons.timer_off_outlined),           // NEW
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
    if (!Get.isRegistered<PaymentController>()) {
      Get.put(PaymentController());
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _c.fetchMyAppointments();
    });
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  // ── Filtered lists ─────────────────────────────────────────

  /// Requested = scheduled status AND not yet expired (future date)
  List<MyAppointmentItem> get _requestedList => _c.myAppointments
      .where((a) => a.isScheduled && !_isExpired(a))
      .toList()
    ..sort((a, b) => _parseDate(a.scheduledAt)
        .compareTo(_parseDate(b.scheduledAt))); // soonest first

  /// Confirmed = confirmed status AND not yet expired
  List<MyAppointmentItem> get _confirmedList => _c.myAppointments
      .where((a) => a.isConfirmed && !_isExpired(a))
      .toList()
    ..sort((a, b) => _parseDate(a.scheduledAt)
        .compareTo(_parseDate(b.scheduledAt)));

  /// Expired = scheduled or confirmed but date is in the past
  List<MyAppointmentItem> get _expiredList => _c.myAppointments
      .where((a) => (a.isScheduled || a.isConfirmed) && _isExpired(a))
      .toList()
    ..sort((a, b) => _parseDate(b.scheduledAt)
        .compareTo(_parseDate(a.scheduledAt))); // most recent first

  /// All tab: show everything, smart flags per card
  List<MyAppointmentItem> get _allList => List.of(_c.myAppointments)
    ..sort((a, b) =>
        _parseDate(b.scheduledAt).compareTo(_parseDate(a.scheduledAt)));

  DateTime _parseDate(String s) {
    try {
      return DateTime.parse(s);
    } catch (_) {
      return DateTime(2000);
    }
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

        // All lists computed fresh inside Obx so they react to data changes
        final allList = _allList;
        final requestedList = _requestedList;
        final confirmedList = _confirmedList;
        final expiredList = _expiredList;
        final completedList = _c.completedList;
        final cancelledList = _c.cancelledList;
        final noShowList = _c.noShowList;

        return TabBarView(
          controller: _tab,
          children: [
            // ALL — smart flags per card
            _list(context, size, allList, smartMode: true),
            // Requested (scheduled, future only) — sorted soonest first
            _list(context, size, requestedList,
                emptyMessage: 'No pending requests',
                emptySubMessage: 'Requested appointments will appear here'),
            // Confirmed (future only)
            _list(context, size, confirmedList,
                showPayment: true,
                showMeetLink: true,
                emptyMessage: 'No confirmed appointments',
                emptySubMessage: 'Confirmed sessions will appear here'),
            // Expired tab
            _list(context, size, expiredList,
                isExpiredTab: true,
                emptyMessage: 'No expired appointments',
                emptySubMessage: 'Past scheduled/confirmed sessions appear here'),
            // Completed, Cancelled, No Show — no date filter
            _list(context, size, completedList),
            _list(context, size, cancelledList),
            _list(context, size, noShowList),
          ],
        );
      }),
    );
  }

  // ── List builder ───────────────────────────────────────────
  Widget _list(
    BuildContext context,
    CustomSize size,
    List<MyAppointmentItem> items, {
    bool showPayment = false,
    bool showMeetLink = false,
    bool smartMode = false,
    bool isExpiredTab = false,
    String emptyMessage = 'No appointments here',
    String emptySubMessage = 'Nothing in this category',
  }) {
    if (items.isEmpty) {
      return _empty(context, size,
          message: emptyMessage, subMessage: emptySubMessage);
    }
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
        itemBuilder: (_, i) {
          final appt = items[i];
          final expired = _isExpired(appt);

          bool effectiveShowPayment;
          bool effectiveShowMeetLink;

          if (isExpiredTab) {
            // In expired tab: show payment if confirmed+expired; no meet link
            effectiveShowPayment = appt.isConfirmed;
            effectiveShowMeetLink = false;
          } else if (smartMode) {
            effectiveShowPayment = appt.isConfirmed && !expired;
            effectiveShowMeetLink = appt.isConfirmed && !expired;
          } else {
            effectiveShowPayment = showPayment;
            effectiveShowMeetLink = showMeetLink && !expired;
          }

          return _AppointmentCard(
            key: ValueKey(appt.appointmentId),
            appt: appt,
            showPayment: effectiveShowPayment,
            showMeetLink: effectiveShowMeetLink,
            isExpired: expired,
            isExpiredTab: isExpiredTab,
            size: size,
          );
        },
      ),
    );
  }

  // ── Helpers ────────────────────────────────────────────────
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

  Widget _empty(BuildContext context, CustomSize size,
      {required String message, required String subMessage}) {
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
          Text(message,
              style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.044,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryColor)),
          SizedBox(height: size.customHeight(context) * 0.008),
          Text(subMessage,
              style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.033,
                  color: AppColors.textSecondaryColor)),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  _AppointmentCard — own widget so Obx scope is clean
// ══════════════════════════════════════════════════════════════
class _AppointmentCard extends StatelessWidget {
  final MyAppointmentItem appt;
  final bool showPayment;
  final bool showMeetLink;
  final bool isExpired;
  final bool isExpiredTab;
  final CustomSize size;

  const _AppointmentCard({
    super.key,
    required this.appt,
    required this.showPayment,
    required this.showMeetLink,
    required this.isExpired,
    required this.isExpiredTab,
    required this.size,
  });

  _StatusMeta get _meta {
    // In expired tab always show grey "Expired" badge
    if (isExpiredTab || (isExpired && (appt.isScheduled || appt.isConfirmed))) {
      return _StatusMeta(AppColors.greyColor, 'Expired', Icons.timer_off_outlined);
    }
    switch (appt.status.toLowerCase()) {
      case 'confirmed':
        return _StatusMeta(AppColors.primaryColor, 'Confirmed',
            Icons.check_circle_outlined);
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
        // "scheduled" → show as "Requested"
        return _StatusMeta(
            AppColors.warningColor, 'Requested', Icons.pending_actions_rounded);
    }
  }

  @override
  Widget build(BuildContext context) {
    final meta = _meta;
    final isPaid = appt.paymentStatus?.toLowerCase() == 'paid';

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
            // Status color bar
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
                  // Header row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Avatar
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            AppColors.primaryColor.withOpacity(0.7),
                            AppColors.primaryColor,
                          ]),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Status badge
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
                          // Payment badge (confirmed & not expired)
                          if (showPayment) ...[
                            const SizedBox(height: 4),
                            _paymentBadgeSmall(isPaid),
                          ],
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: size.customHeight(context) * 0.012),
                  Divider(
                      height: 1,
                      color: AppColors.greyColor.withOpacity(0.15)),
                  SizedBox(height: size.customHeight(context) * 0.01),

                  // Info chips
                  Wrap(
                    spacing: 14,
                    runSpacing: 6,
                    children: [
                      _chip2(Icons.calendar_today_outlined,
                          appt.formattedDate, AppColors.primaryColor),
                      _chip2(Icons.access_time_rounded,
                          appt.formattedTime, AppColors.secondaryColor),
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

                  // Payment section (confirmed, future only)
                  if (showPayment) ...[
                    SizedBox(height: size.customHeight(context) * 0.01),
                    _paymentSection(context, appt, isPaid),
                  ],

                  // Meeting link (confirmed, future) OR expired notice
                  if (appt.isConfirmed &&
                      appt.meetLink != null &&
                      appt.meetLink!.isNotEmpty) ...[
                    SizedBox(height: size.customHeight(context) * 0.01),
                    if (showMeetLink)
                      _meetLinkBanner(context, appt.meetLink!)
                    else
                      _meetLinkExpiredBanner(context),
                  ],

                  // Expired notice banner (in expired tab)
                  if (isExpiredTab) ...[
                    SizedBox(height: size.customHeight(context) * 0.01),
                    _expiredNoticeBanner(context),
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

                  // No Show banner
                  if (appt.isNoShow) ...[
                    SizedBox(height: size.customHeight(context) * 0.01),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 7),
                      decoration: BoxDecoration(
                        color: AppColors.greyColor.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color:
                                AppColors.greyColor.withOpacity(0.3)),
                      ),
                      child: Row(children: [
                        Icon(Icons.person_off_outlined,
                            size: 13, color: AppColors.greyColor),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            'Patient did not attend this session',
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: AppColors.greyColor),
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

  Widget _paymentBadgeSmall(bool isPaid) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: isPaid
            ? AppColors.successColor.withOpacity(0.1)
            : AppColors.warningColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isPaid
                ? Icons.check_circle_outline
                : Icons.pending_outlined,
            size: 9,
            color:
                isPaid ? AppColors.successColor : AppColors.warningColor,
          ),
          const SizedBox(width: 3),
          Text(
            isPaid ? 'Paid' : 'Unpaid',
            style: GoogleFonts.poppins(
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: isPaid
                  ? AppColors.successColor
                  : AppColors.warningColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _paymentSection(
      BuildContext context, MyAppointmentItem appt, bool isPaid) {
    if (isPaid) {
      return Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.successColor.withOpacity(0.07),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: AppColors.successColor.withOpacity(0.25), width: 1),
        ),
        child: Row(children: [
          const Icon(Icons.check_circle_rounded,
              color: AppColors.successColor, size: 16),
          const SizedBox(width: 8),
          Text('Payment Complete',
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: AppColors.successColor,
                  fontWeight: FontWeight.w600)),
        ]),
      );
    }
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.warningColor.withOpacity(0.07),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: AppColors.warningColor.withOpacity(0.3), width: 1),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning_amber_rounded,
              color: AppColors.warningColor, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text('Payment pending — tap to complete',
                style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: AppColors.warningColor,
                    fontWeight: FontWeight.w500)),
          ),
          const SizedBox(width: 8),
          GetBuilder<PaymentController>(
            init: Get.isRegistered<PaymentController>()
                ? Get.find<PaymentController>()
                : Get.put(PaymentController()),
            builder: (pc) => GestureDetector(
              onTap: pc.isInitiating.value
                  ? null
                  : () => pc.initiatePayment(appt.appointmentId),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                    color: AppColors.warningColor,
                    borderRadius: BorderRadius.circular(8)),
                child: pc.isInitiating.value
                    ? const SizedBox(
                        width: 14,
                        height: 14,
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2))
                    : Text('Pay Now',
                        style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: Colors.white,
                            fontWeight: FontWeight.w700)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _meetLinkBanner(BuildContext context, String url) {
    return GestureDetector(
      onTap: () => _openUrl(url),
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
              child: Text('Join Meeting',
                  style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: const Color(0xFF2196F3),
                      fontWeight: FontWeight.w600)),
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

  /// Shown when appointment is confirmed+expired but has a meet link
  Widget _meetLinkExpiredBanner(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.greyColor.withOpacity(0.07),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: AppColors.greyColor.withOpacity(0.25), width: 1),
      ),
      child: Row(
        children: [
          Icon(Icons.videocam_off_rounded,
              color: AppColors.greyColor, size: 18),
          const SizedBox(width: 8),
          Text('Meeting Link Expired',
              style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: AppColors.greyColor,
                  fontWeight: FontWeight.w600)),
          const Spacer(),
          Icon(Icons.lock_clock_outlined,
              size: 14, color: AppColors.greyColor),
        ],
      ),
    );
  }

  /// Generic expired banner shown in expired tab cards
  Widget _expiredNoticeBanner(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.greyColor.withOpacity(0.07),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: AppColors.greyColor.withOpacity(0.25), width: 1),
      ),
      child: Row(
        children: [
          Icon(Icons.timer_off_outlined,
              color: AppColors.greyColor, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'This appointment has passed without completion',
              style: GoogleFonts.poppins(
                  fontSize: 12, color: AppColors.greyColor),
            ),
          ),
        ],
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
  late final PaymentController _pc;
  late final String _appointmentId;

  @override
  void initState() {
    super.initState();
    _c = Get.find<ParentBookingController>();
    _pc = Get.isRegistered<PaymentController>()
        ? Get.find<PaymentController>()
        : Get.put(PaymentController());
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

        if (appt.isConfirmed) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _pc.fetchPaymentStatus(_appointmentId);
          });
        }

        return _content(context, size, appt);
      }),
    );
  }

  Widget _content(
      BuildContext context, CustomSize size, MyAppointmentItem appt) {
    final expired = _isExpired(appt);
    final isConfirmed = appt.isConfirmed;
    final meta = _statusMeta(appt.status, expired: expired);

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
                            Row(
                              children: [
                                // Status badge
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: meta.color.withOpacity(0.2),
                                    borderRadius:
                                        BorderRadius.circular(20),
                                    border: Border.all(
                                        color: Colors.white
                                            .withOpacity(0.4)),
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
                                              fontWeight:
                                                  FontWeight.w600)),
                                    ],
                                  ),
                                ),
                                // Payment badge — confirmed+future only
                                if (isConfirmed && !expired) ...[
                                  const SizedBox(width: 6),
                                  Obx(() {
                                    final ps = _pc.paymentStatus.value;
                                    final isPaid = ps?.isPaid ??
                                        appt.paymentStatus
                                                ?.toLowerCase() ==
                                            'paid';
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: isPaid
                                            ? AppColors.successColor
                                                .withOpacity(0.2)
                                            : AppColors.warningColor
                                                .withOpacity(0.2),
                                        borderRadius:
                                            BorderRadius.circular(20),
                                        border: Border.all(
                                            color: Colors.white
                                                .withOpacity(0.4)),
                                      ),
                                      child: Text(
                                        isPaid ? 'Paid' : 'Unpaid',
                                        style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    );
                                  }),
                                ],
                              ],
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

              // ── Expired notice (confirmed or requested, past date) ──
              if (expired &&
                  (appt.isConfirmed || appt.isScheduled)) ...[
                _expiredDetailBanner(context, size),
                SizedBox(height: size.customHeight(context) * 0.018),
              ],

              // ── CONFIRMED + FUTURE: Meet link ──────────────────────
              if (isConfirmed && !expired &&
                  appt.meetLink != null &&
                  appt.meetLink!.isNotEmpty) ...[
                _meetLinkCard(context, size, appt.meetLink!),
                SizedBox(height: size.customHeight(context) * 0.018),
              ],

              // ── CONFIRMED + EXPIRED: Meet link expired notice ──────
              if (isConfirmed && expired &&
                  appt.meetLink != null &&
                  appt.meetLink!.isNotEmpty) ...[
                _meetLinkExpiredCard(context, size),
                SizedBox(height: size.customHeight(context) * 0.018),
              ],

              // ── CONFIRMED + FUTURE: Payment card ───────────────────
              if (isConfirmed && !expired) ...[
                _paymentCard(context, size, appt),
                SizedBox(height: size.customHeight(context) * 0.018),
              ],

              // No Show
              if (appt.isNoShow) ...[
                _noShowCard(context, size),
                SizedBox(height: size.customHeight(context) * 0.018),
              ],

              // Appointment details
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

              // Session records (completed only)
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

  // ── Expired detail banner ───────────────────────────────────
  Widget _expiredDetailBanner(BuildContext context, CustomSize size) {
    return Container(
      padding: EdgeInsets.all(size.customWidth(context) * 0.042),
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
            child: Icon(Icons.timer_off_outlined,
                color: AppColors.greyColor, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Appointment Expired',
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.greyColor)),
                const SizedBox(height: 2),
                Text(
                  'This appointment date has passed without completion.',
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

  // ── Meet link expired card (detail screen) ─────────────────
  Widget _meetLinkExpiredCard(BuildContext context, CustomSize size) {
    return Container(
      padding: EdgeInsets.all(size.customWidth(context) * 0.04),
      decoration: BoxDecoration(
        color: AppColors.greyColor.withOpacity(0.07),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
            color: AppColors.greyColor.withOpacity(0.25), width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: AppColors.greyColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12)),
            child: Icon(Icons.videocam_off_rounded,
                color: AppColors.greyColor, size: 24),
          ),
          SizedBox(width: size.customWidth(context) * 0.035),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Meeting Link Expired',
                    style: GoogleFonts.poppins(
                        color: AppColors.greyColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                Text('This session has already passed',
                    style: GoogleFonts.poppins(
                        color: AppColors.greyColor.withOpacity(0.75),
                        fontSize: 12)),
              ],
            ),
          ),
          Icon(Icons.lock_clock_outlined,
              size: 20, color: AppColors.greyColor),
        ],
      ),
    );
  }

  // ── Payment Card ────────────────────────────────────────────
  Widget _paymentCard(
      BuildContext context, CustomSize size, MyAppointmentItem appt) {
    return Obx(() {
      final ps = _pc.paymentStatus.value;
      final rawStatus = ps?.status ?? appt.paymentStatus ?? 'pending';
      final isPaid = rawStatus.toLowerCase() == 'paid';

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
          border: Border.all(
            color: isPaid
                ? AppColors.successColor.withOpacity(0.3)
                : AppColors.warningColor.withOpacity(0.4),
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: isPaid
                          ? AppColors.successColor.withOpacity(0.1)
                          : AppColors.warningColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    isPaid
                        ? Icons.check_circle_rounded
                        : Icons.payment_rounded,
                    color: isPaid
                        ? AppColors.successColor
                        : AppColors.warningColor,
                    size: 18,
                  )),
              const SizedBox(width: 10),
              Text('Payment',
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimaryColor)),
              const Spacer(),
              Obx(() => _pc.isLoadingStatus.value
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                          color: AppColors.primaryColor, strokeWidth: 2))
                  : GestureDetector(
                      onTap: () =>
                          _pc.fetchPaymentStatus(appt.appointmentId),
                      child: const Icon(Icons.refresh_rounded,
                          size: 18,
                          color: AppColors.textSecondaryColor),
                    )),
            ]),
            SizedBox(height: size.customHeight(context) * 0.014),
            Divider(
                height: 1,
                color: AppColors.greyColor.withOpacity(0.15)),
            SizedBox(height: size.customHeight(context) * 0.012),
            _row(context, size, 'Amount',
                '${appt.currency} ${appt.feeCharged.toStringAsFixed(0)}',
                Icons.payments_outlined),
            Padding(
              padding: EdgeInsets.only(
                  bottom: size.customHeight(context) * 0.01),
              child: Row(
                children: [
                  Icon(Icons.circle,
                      size: 8,
                      color: isPaid
                          ? AppColors.successColor
                          : AppColors.warningColor),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: size.customWidth(context) * 0.22,
                    child: Text('Status',
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: AppColors.textSecondaryColor,
                            fontWeight: FontWeight.w500)),
                  ),
                  Text(
                    isPaid ? 'Paid' : 'Pending — needs payment',
                    style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isPaid
                            ? AppColors.successColor
                            : AppColors.warningColor),
                  ),
                ],
              ),
            ),
            if (!isPaid) ...[
              SizedBox(height: size.customHeight(context) * 0.014),
              Obx(() => SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _pc.isInitiating.value
                          ? null
                          : () =>
                              _pc.initiatePayment(appt.appointmentId),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.warningColor,
                        disabledBackgroundColor:
                            AppColors.warningColor.withOpacity(0.5),
                        padding:
                            const EdgeInsets.symmetric(vertical: 13),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      icon: _pc.isInitiating.value
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                  color: Colors.white, strokeWidth: 2))
                          : const Icon(Icons.payment_rounded,
                              color: Colors.white, size: 18),
                      label: Text(
                        _pc.isInitiating.value
                            ? 'Opening Payment...'
                            : 'Pay Now — ${appt.currency} ${appt.feeCharged.toStringAsFixed(0)}',
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 14),
                      ),
                    ),
                  )),
            ],
          ],
        ),
      );
    });
  }

  // ── Meet link card (active) ─────────────────────────────────
  Widget _meetLinkCard(BuildContext context, CustomSize size, String url) {
    return GestureDetector(
      onTap: () => _openUrl(url),
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
                  Text('Tap to open in browser',
                      style: GoogleFonts.poppins(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 12)),
                ],
              ),
            ),
            Row(children: [
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
            ]),
          ],
        ),
      ),
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
                Text('No Show',
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.greyColor)),
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

  Widget _detailCard(
      BuildContext context, CustomSize size, MyAppointmentItem appt) {
    return _cardWidget(context, size,
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
              appt.bookedMode[0].toUpperCase() +
                  appt.bookedMode.substring(1),
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
    return _cardWidget(context, size,
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

  Widget _expertCard(BuildContext context, CustomSize size,
      AppointmentExpert expert) {
    return _cardWidget(context, size,
        title: 'Expert Information',
        icon: Icons.person_outline_rounded,
        children: [
          _row(context, size, 'Name', expert.fullName,
              Icons.badge_outlined),
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
              final uri =
                  Uri(scheme: 'mailto', path: expert.contactEmail);
              if (await canLaunchUrl(uri)) await launchUrl(uri);
            }),
        ]);
  }

  Widget _cancellationCard(BuildContext context, CustomSize size,
      MyAppointmentItem appt) {
    return Container(
      padding: EdgeInsets.all(size.customWidth(context) * 0.045),
      decoration: BoxDecoration(
        color: AppColors.errorColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(18),
        border:
            Border.all(color: AppColors.errorColor.withOpacity(0.2)),
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
                        color: AppColors.textSecondaryColor
                            .withOpacity(0.4)),
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
      margin:
          EdgeInsets.only(bottom: size.customHeight(context) * 0.014),
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
                      fontSize: 11,
                      color: AppColors.textSecondaryColor)),
            ],
          ),
          SizedBox(height: size.customHeight(context) * 0.012),
          Divider(
              height: 1,
              color: AppColors.greyColor.withOpacity(0.15)),
          SizedBox(height: size.customHeight(context) * 0.012),
          _recordField(
              'Notes', record.notes, Icons.notes_rounded),
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
        Icon(icon,
            size: 14, color: AppColors.primaryColor.withOpacity(0.7)),
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
                      fontSize: 13,
                      color: AppColors.textPrimaryColor)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _cardWidget(BuildContext context, CustomSize size,
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
                child: Icon(icon,
                    color: AppColors.primaryColor, size: 18)),
            const SizedBox(width: 10),
            Text(title,
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimaryColor)),
          ]),
          SizedBox(height: size.customHeight(context) * 0.014),
          Divider(
              height: 1,
              color: AppColors.greyColor.withOpacity(0.15)),
          SizedBox(height: size.customHeight(context) * 0.012),
          ...children,
        ],
      ),
    );
  }

  Widget _row(BuildContext context, CustomSize size, String label,
      String value, IconData icon) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: size.customHeight(context) * 0.01),
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
        padding: EdgeInsets.only(
            bottom: size.customHeight(context) * 0.01),
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

  _StatusMeta _statusMeta(String status, {bool expired = false}) {
    // Override with Expired if date has passed for scheduled/confirmed
    if (expired &&
        (status.toLowerCase() == 'scheduled' ||
            status.toLowerCase() == 'confirmed')) {
      return _StatusMeta(
          AppColors.greyColor, 'Expired', Icons.timer_off_outlined);
    }
    switch (status.toLowerCase()) {
      case 'confirmed':
        return _StatusMeta(AppColors.primaryColor, 'Confirmed',
            Icons.check_circle_outlined);
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
        // scheduled → Requested
        return _StatusMeta(AppColors.warningColor, 'Requested',
            Icons.pending_actions_rounded);
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
//   Shared _StatusMeta
// ═══════════════════════════════════════════════════════════════
class _StatusMeta {
  final Color color;
  final String label;
  final IconData icon;
  _StatusMeta(this.color, this.label,
      [this.icon = Icons.info_outline]);
}