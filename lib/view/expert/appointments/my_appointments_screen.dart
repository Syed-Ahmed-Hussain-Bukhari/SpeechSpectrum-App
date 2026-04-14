// // // // // // lib/view/expert/appointments/my_appointments_screen.dart
// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:get/get.dart';
// // // // // import 'package:google_fonts/google_fonts.dart';
// // // // // import 'package:speechspectrum/constants/app_colors.dart';
// // // // // import 'package:speechspectrum/constants/custom_size.dart';
// // // // // import 'package:speechspectrum/controllers/my_appointment_controller.dart';
// // // // // import 'package:speechspectrum/models/my_appointment_model.dart';
// // // // // import 'package:speechspectrum/routes/app_routes.dart';

// // // // // class MyAppointmentsScreen extends StatefulWidget {
// // // // //   const MyAppointmentsScreen({super.key});

// // // // //   @override
// // // // //   State<MyAppointmentsScreen> createState() => _MyAppointmentsScreenState();
// // // // // }

// // // // // class _MyAppointmentsScreenState extends State<MyAppointmentsScreen>
// // // // //     with SingleTickerProviderStateMixin {
// // // // //   late final MyAppointmentController _c;
// // // // //   late final TabController _tab;

// // // // //   static const _tabs = [
// // // // //     ('All', Icons.list_alt_rounded),
// // // // //     ('Scheduled', Icons.schedule_rounded),
// // // // //     ('Confirmed', Icons.check_circle_outline_rounded),
// // // // //     ('Completed', Icons.task_alt_rounded),
// // // // //     ('Cancelled', Icons.cancel_outlined),
// // // // //     ('No Show', Icons.person_off_outlined),
// // // // //   ];

// // // // //   @override
// // // // //   void initState() {
// // // // //     super.initState();
// // // // //     _tab = TabController(length: _tabs.length, vsync: this);
// // // // //     _c = Get.isRegistered<MyAppointmentController>()
// // // // //         ? Get.find<MyAppointmentController>()
// // // // //         : Get.put(MyAppointmentController());
// // // // //     WidgetsBinding.instance.addPostFrameCallback((_) {
// // // // //       _c.fetchMyAppointments();
// // // // //     });
// // // // //   }

// // // // //   @override
// // // // //   void dispose() {
// // // // //     _tab.dispose();
// // // // //     super.dispose();
// // // // //   }

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     final size = CustomSize();

// // // // //     return Scaffold(
// // // // //       backgroundColor: AppColors.lightGreyColor,
// // // // //       appBar: AppBar(
// // // // //         backgroundColor: AppColors.whiteColor,
// // // // //         elevation: 0,
// // // // //         surfaceTintColor: Colors.transparent,
// // // // //         leading: IconButton(
// // // // //           icon: const Icon(Icons.arrow_back_ios_new_rounded,
// // // // //               color: AppColors.textPrimaryColor, size: 20),
// // // // //           onPressed: () => Get.back(),
// // // // //         ),
// // // // //         title: Text('My Appointments',
// // // // //             style: GoogleFonts.poppins(
// // // // //                 color: AppColors.textPrimaryColor,
// // // // //                 fontSize: 18,
// // // // //                 fontWeight: FontWeight.w600)),
// // // // //         actions: [
// // // // //           Obx(() => _c.isLoading.value
// // // // //               ? const Padding(
// // // // //                   padding: EdgeInsets.all(16),
// // // // //                   child: SizedBox(
// // // // //                       width: 20,
// // // // //                       height: 20,
// // // // //                       child: CircularProgressIndicator(
// // // // //                           color: AppColors.primaryColor, strokeWidth: 2)))
// // // // //               : IconButton(
// // // // //                   icon: const Icon(Icons.refresh_rounded,
// // // // //                       color: AppColors.primaryColor),
// // // // //                   onPressed: _c.fetchMyAppointments)),
// // // // //           const SizedBox(width: 4),
// // // // //         ],
// // // // //         bottom: TabBar(
// // // // //           controller: _tab,
// // // // //           isScrollable: true,
// // // // //           tabAlignment: TabAlignment.start,
// // // // //           labelColor: AppColors.primaryColor,
// // // // //           unselectedLabelColor: AppColors.textSecondaryColor,
// // // // //           indicatorColor: AppColors.primaryColor,
// // // // //           indicatorWeight: 2.5,
// // // // //           labelPadding:
// // // // //               const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
// // // // //           labelStyle: GoogleFonts.poppins(
// // // // //               fontWeight: FontWeight.w600, fontSize: 13),
// // // // //           unselectedLabelStyle: GoogleFonts.poppins(
// // // // //               fontWeight: FontWeight.w500, fontSize: 13),
// // // // //           tabs: _tabs
// // // // //               .map((t) => Tab(
// // // // //                     child: Row(
// // // // //                       mainAxisSize: MainAxisSize.min,
// // // // //                       children: [
// // // // //                         Icon(t.$2, size: 15),
// // // // //                         const SizedBox(width: 5),
// // // // //                         Text(t.$1),
// // // // //                       ],
// // // // //                     ),
// // // // //                   ))
// // // // //               .toList(),
// // // // //         ),
// // // // //       ),
// // // // //       body: Obx(() {
// // // // //         if (_c.isLoading.value && _c.appointments.isEmpty) {
// // // // //           return _loader(context, size);
// // // // //         }
// // // // //         return TabBarView(
// // // // //           controller: _tab,
// // // // //           children: [
// // // // //             _buildList(context, size, _c.allAppointments),
// // // // //             _buildList(context, size, _c.scheduledList),
// // // // //             _buildList(context, size, _c.confirmedList),
// // // // //             _buildList(context, size, _c.completedList),
// // // // //             _buildList(context, size, _c.cancelledList),
// // // // //             _buildList(context, size, _c.noShowList),
// // // // //           ],
// // // // //         );
// // // // //       }),
// // // // //     );
// // // // //   }

// // // // //   Widget _buildList(
// // // // //       BuildContext context, CustomSize size, List<MyAppointmentItem> list) {
// // // // //     if (list.isEmpty) return _empty(context, size);
// // // // //     return RefreshIndicator(
// // // // //       color: AppColors.primaryColor,
// // // // //       onRefresh: _c.fetchMyAppointments,
// // // // //       child: ListView.builder(
// // // // //         padding: EdgeInsets.fromLTRB(
// // // // //           size.customWidth(context) * 0.045,
// // // // //           size.customHeight(context) * 0.02,
// // // // //           size.customWidth(context) * 0.045,
// // // // //           size.customHeight(context) * 0.04,
// // // // //         ),
// // // // //         itemCount: list.length,
// // // // //         itemBuilder: (_, i) => _appointmentCard(context, size, list[i]),
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   Widget _appointmentCard(
// // // // //       BuildContext context, CustomSize size, MyAppointmentItem appt) {
// // // // //     final statusMeta = _statusMeta(appt.status);

// // // // //     return GestureDetector(
// // // // //       onTap: () => Get.toNamed(
// // // // //         AppRoutes.myAppointmentDetail,
// // // // //         arguments: appt.appointmentId,
// // // // //       ),
// // // // //       child: Container(
// // // // //         margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.016),
// // // // //         decoration: BoxDecoration(
// // // // //           color: AppColors.whiteColor,
// // // // //           borderRadius: BorderRadius.circular(20),
// // // // //           boxShadow: [
// // // // //             BoxShadow(
// // // // //                 color: Colors.black.withOpacity(0.06),
// // // // //                 blurRadius: 14,
// // // // //                 offset: const Offset(0, 4))
// // // // //           ],
// // // // //         ),
// // // // //         child: Column(
// // // // //           children: [
// // // // //             // Status strip
// // // // //             Container(
// // // // //               height: 4,
// // // // //               decoration: BoxDecoration(
// // // // //                 color: statusMeta.color,
// // // // //                 borderRadius: const BorderRadius.vertical(
// // // // //                     top: Radius.circular(20)),
// // // // //               ),
// // // // //             ),
// // // // //             Padding(
// // // // //               padding: EdgeInsets.all(size.customWidth(context) * 0.042),
// // // // //               child: Column(
// // // // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                 children: [
// // // // //                   // Top row: avatar + info + status badge
// // // // //                   Row(
// // // // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                     children: [
// // // // //                       // Child avatar
// // // // //                       Container(
// // // // //                         width: 50,
// // // // //                         height: 50,
// // // // //                         decoration: BoxDecoration(
// // // // //                           gradient: LinearGradient(
// // // // //                             colors: [
// // // // //                               AppColors.primaryColor.withOpacity(0.7),
// // // // //                               AppColors.primaryColor
// // // // //                             ],
// // // // //                             begin: Alignment.topLeft,
// // // // //                             end: Alignment.bottomRight,
// // // // //                           ),
// // // // //                           borderRadius: BorderRadius.circular(14),
// // // // //                         ),
// // // // //                         child: Center(
// // // // //                           child: Text(
// // // // //                             appt.childInitials,
// // // // //                             style: GoogleFonts.poppins(
// // // // //                                 color: Colors.white,
// // // // //                                 fontSize: 16,
// // // // //                                 fontWeight: FontWeight.bold),
// // // // //                           ),
// // // // //                         ),
// // // // //                       ),
// // // // //                       SizedBox(width: size.customWidth(context) * 0.03),
// // // // //                       Expanded(
// // // // //                         child: Column(
// // // // //                           crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                           children: [
// // // // //                             Text(
// // // // //                               appt.children?.childName ?? 'Unknown Child',
// // // // //                               style: GoogleFonts.poppins(
// // // // //                                   fontSize: size.customWidth(context) * 0.04,
// // // // //                                   fontWeight: FontWeight.w700,
// // // // //                                   color: AppColors.textPrimaryColor),
// // // // //                               maxLines: 1,
// // // // //                               overflow: TextOverflow.ellipsis,
// // // // //                             ),
// // // // //                             const SizedBox(height: 2),
// // // // //                             Text(
// // // // //                               appt.expertUsers?.specialization ?? '',
// // // // //                               style: GoogleFonts.poppins(
// // // // //                                   fontSize: size.customWidth(context) * 0.031,
// // // // //                                   color: AppColors.textSecondaryColor),
// // // // //                               maxLines: 1,
// // // // //                               overflow: TextOverflow.ellipsis,
// // // // //                             ),
// // // // //                           ],
// // // // //                         ),
// // // // //                       ),
// // // // //                       const SizedBox(width: 8),
// // // // //                       Container(
// // // // //                         padding: const EdgeInsets.symmetric(
// // // // //                             horizontal: 10, vertical: 4),
// // // // //                         decoration: BoxDecoration(
// // // // //                           color: statusMeta.color.withOpacity(0.1),
// // // // //                           borderRadius: BorderRadius.circular(20),
// // // // //                         ),
// // // // //                         child: Text(
// // // // //                           statusMeta.label,
// // // // //                           style: GoogleFonts.poppins(
// // // // //                               fontSize: 10,
// // // // //                               fontWeight: FontWeight.w600,
// // // // //                               color: statusMeta.color),
// // // // //                         ),
// // // // //                       ),
// // // // //                     ],
// // // // //                   ),
// // // // //                   SizedBox(height: size.customHeight(context) * 0.014),
// // // // //                   Divider(
// // // // //                       height: 1,
// // // // //                       color: AppColors.greyColor.withOpacity(0.15)),
// // // // //                   SizedBox(height: size.customHeight(context) * 0.012),

// // // // //                   // Date, time, mode, fee row
// // // // //                   Wrap(
// // // // //                     spacing: 16,
// // // // //                     runSpacing: 6,
// // // // //                     children: [
// // // // //                       _infoChip(Icons.calendar_today_outlined,
// // // // //                           appt.formattedDate, AppColors.primaryColor),
// // // // //                       _infoChip(Icons.access_time_rounded,
// // // // //                           appt.formattedTime, AppColors.secondaryColor),
// // // // //                       _infoChip(
// // // // //                           _modeIcon(appt.bookedMode),
// // // // //                           appt.bookedMode[0].toUpperCase() +
// // // // //                               appt.bookedMode.substring(1),
// // // // //                           AppColors.accentColor),
// // // // //                       _infoChip(
// // // // //                           Icons.currency_exchange_rounded,
// // // // //                           '${appt.currency} ${appt.feeCharged.toStringAsFixed(0)}',
// // // // //                           AppColors.warningColor),
// // // // //                     ],
// // // // //                   ),

// // // // //                   // Cancellation reason
// // // // //                   if (appt.isCancelled &&
// // // // //                       appt.cancellationReason != null) ...[
// // // // //                     SizedBox(height: size.customHeight(context) * 0.01),
// // // // //                     Container(
// // // // //                       padding: const EdgeInsets.symmetric(
// // // // //                           horizontal: 10, vertical: 7),
// // // // //                       decoration: BoxDecoration(
// // // // //                         color: AppColors.errorColor.withOpacity(0.06),
// // // // //                         borderRadius: BorderRadius.circular(10),
// // // // //                       ),
// // // // //                       child: Row(
// // // // //                         children: [
// // // // //                           const Icon(Icons.info_outline_rounded,
// // // // //                               size: 13, color: AppColors.errorColor),
// // // // //                           const SizedBox(width: 6),
// // // // //                           Expanded(
// // // // //                             child: Text(
// // // // //                               appt.cancellationReason!,
// // // // //                               style: GoogleFonts.poppins(
// // // // //                                   fontSize: 12,
// // // // //                                   color: AppColors.errorColor),
// // // // //                               maxLines: 2,
// // // // //                               overflow: TextOverflow.ellipsis,
// // // // //                             ),
// // // // //                           ),
// // // // //                         ],
// // // // //                       ),
// // // // //                     ),
// // // // //                   ],
// // // // //                 ],
// // // // //               ),
// // // // //             ),
// // // // //           ],
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   Widget _infoChip(IconData icon, String label, Color color) {
// // // // //     return Row(
// // // // //       mainAxisSize: MainAxisSize.min,
// // // // //       children: [
// // // // //         Icon(icon, size: 13, color: color),
// // // // //         const SizedBox(width: 4),
// // // // //         Text(label,
// // // // //             style: GoogleFonts.poppins(
// // // // //                 fontSize: 12,
// // // // //                 color: AppColors.textSecondaryColor,
// // // // //                 fontWeight: FontWeight.w500)),
// // // // //       ],
// // // // //     );
// // // // //   }

// // // // //   Widget _loader(BuildContext context, CustomSize size) {
// // // // //     return Center(
// // // // //       child: Column(
// // // // //         mainAxisAlignment: MainAxisAlignment.center,
// // // // //         children: [
// // // // //           const CircularProgressIndicator(
// // // // //               color: AppColors.primaryColor, strokeWidth: 3),
// // // // //           SizedBox(height: size.customHeight(context) * 0.02),
// // // // //           Text('Loading appointments...',
// // // // //               style: GoogleFonts.poppins(
// // // // //                   color: AppColors.textSecondaryColor,
// // // // //                   fontSize: size.customWidth(context) * 0.036)),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   Widget _empty(BuildContext context, CustomSize size) {
// // // // //     return Center(
// // // // //       child: Column(
// // // // //         mainAxisAlignment: MainAxisAlignment.center,
// // // // //         children: [
// // // // //           Container(
// // // // //             width: 110,
// // // // //             height: 110,
// // // // //             decoration: BoxDecoration(
// // // // //                 color: AppColors.primaryColor.withOpacity(0.07),
// // // // //                 shape: BoxShape.circle),
// // // // //             child: const Icon(Icons.event_busy_outlined,
// // // // //                 size: 52, color: AppColors.primaryColor),
// // // // //           ),
// // // // //           SizedBox(height: size.customHeight(context) * 0.025),
// // // // //           Text('No appointments here',
// // // // //               style: GoogleFonts.poppins(
// // // // //                   fontSize: size.customWidth(context) * 0.044,
// // // // //                   fontWeight: FontWeight.bold,
// // // // //                   color: AppColors.textPrimaryColor)),
// // // // //           SizedBox(height: size.customHeight(context) * 0.008),
// // // // //           Text('Nothing to show in this category',
// // // // //               style: GoogleFonts.poppins(
// // // // //                   fontSize: size.customWidth(context) * 0.033,
// // // // //                   color: AppColors.textSecondaryColor)),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   _StatusMeta _statusMeta(String status) {
// // // // //     switch (status.toLowerCase()) {
// // // // //       case 'confirmed':
// // // // //         return _StatusMeta(AppColors.primaryColor, 'Confirmed');
// // // // //       case 'completed':
// // // // //         return _StatusMeta(AppColors.successColor, 'Completed');
// // // // //       case 'cancelled':
// // // // //         return _StatusMeta(AppColors.errorColor, 'Cancelled');
// // // // //       case 'no_show':
// // // // //         return _StatusMeta(AppColors.greyColor, 'No Show');
// // // // //       default:
// // // // //         return _StatusMeta(AppColors.warningColor, 'Scheduled');
// // // // //     }
// // // // //   }

// // // // //   IconData _modeIcon(String mode) {
// // // // //     switch (mode.toLowerCase()) {
// // // // //       case 'online':
// // // // //         return Icons.videocam_outlined;
// // // // //       case 'physical':
// // // // //         return Icons.location_on_outlined;
// // // // //       default:
// // // // //         return Icons.swap_horiz_rounded;
// // // // //     }
// // // // //   }
// // // // // }

// // // // // class _StatusMeta {
// // // // //   final Color color;
// // // // //   final String label;
// // // // //   _StatusMeta(this.color, this.label);
// // // // // }


// // // // // lib/view/expert/appointments/my_appointments_screen.dart
// // // // import 'package:flutter/material.dart';
// // // // import 'package:get/get.dart';
// // // // import 'package:google_fonts/google_fonts.dart';
// // // // import 'package:speechspectrum/constants/app_colors.dart';
// // // // import 'package:speechspectrum/constants/custom_size.dart';
// // // // import 'package:speechspectrum/controllers/my_appointment_controller.dart';
// // // // import 'package:speechspectrum/models/my_appointment_model.dart';
// // // // import 'package:speechspectrum/routes/app_routes.dart';

// // // // class MyAppointmentsScreen extends StatefulWidget {
// // // //   const MyAppointmentsScreen({super.key});

// // // //   @override
// // // //   State<MyAppointmentsScreen> createState() => _MyAppointmentsScreenState();
// // // // }

// // // // class _MyAppointmentsScreenState extends State<MyAppointmentsScreen>
// // // //     with SingleTickerProviderStateMixin {
// // // //   late final MyAppointmentController _c;
// // // //   late final TabController _tab;

// // // //   static const _tabs = [
// // // //     ('All', Icons.list_alt_rounded),
// // // //     ('Scheduled', Icons.schedule_rounded),
// // // //     ('Confirmed', Icons.check_circle_outline_rounded),
// // // //     ('Completed', Icons.task_alt_rounded),
// // // //     ('Cancelled', Icons.cancel_outlined),
// // // //     ('No Show', Icons.person_off_outlined),
// // // //   ];

// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     _tab = TabController(length: _tabs.length, vsync: this);
// // // //     _c = Get.isRegistered<MyAppointmentController>()
// // // //         ? Get.find<MyAppointmentController>()
// // // //         : Get.put(MyAppointmentController());
// // // //     WidgetsBinding.instance.addPostFrameCallback((_) {
// // // //       _c.fetchMyAppointments();
// // // //     });
// // // //   }

// // // //   @override
// // // //   void dispose() {
// // // //     _tab.dispose();
// // // //     super.dispose();
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     final size = CustomSize();
// // // //     return Scaffold(
// // // //       backgroundColor: AppColors.lightGreyColor,
// // // //       appBar: AppBar(
// // // //         backgroundColor: AppColors.whiteColor,
// // // //         elevation: 0,
// // // //         surfaceTintColor: Colors.transparent,
// // // //         leading: IconButton(
// // // //           icon: const Icon(Icons.arrow_back_ios_new_rounded,
// // // //               color: AppColors.textPrimaryColor, size: 20),
// // // //           onPressed: () => Get.back(),
// // // //         ),
// // // //         title: Text(
// // // //           'My Appointments',
// // // //           style: GoogleFonts.poppins(
// // // //               color: AppColors.textPrimaryColor,
// // // //               fontSize: 18,
// // // //               fontWeight: FontWeight.w600),
// // // //         ),
// // // //         actions: [
// // // //           Obx(() => _c.isLoading.value
// // // //               ? const Padding(
// // // //                   padding: EdgeInsets.all(14),
// // // //                   child: SizedBox(
// // // //                     width: 20,
// // // //                     height: 20,
// // // //                     child: CircularProgressIndicator(
// // // //                         color: AppColors.primaryColor, strokeWidth: 2),
// // // //                   ),
// // // //                 )
// // // //               : IconButton(
// // // //                   icon: const Icon(Icons.refresh_rounded,
// // // //                       color: AppColors.primaryColor),
// // // //                   onPressed: _c.fetchMyAppointments,
// // // //                 )),
// // // //           const SizedBox(width: 4),
// // // //         ],
// // // //         bottom: TabBar(
// // // //           controller: _tab,
// // // //           isScrollable: true,
// // // //           tabAlignment: TabAlignment.start,
// // // //           labelColor: AppColors.primaryColor,
// // // //           unselectedLabelColor: AppColors.textSecondaryColor,
// // // //           indicatorColor: AppColors.primaryColor,
// // // //           indicatorWeight: 3,
// // // //           labelPadding:
// // // //               const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
// // // //           labelStyle:
// // // //               GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12.5),
// // // //           unselectedLabelStyle:
// // // //               GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 12.5),
// // // //           tabs: _tabs
// // // //               .map((t) => Tab(
// // // //                     child: Row(
// // // //                       mainAxisSize: MainAxisSize.min,
// // // //                       children: [
// // // //                         Icon(t.$2, size: 14),
// // // //                         const SizedBox(width: 5),
// // // //                         Text(t.$1),
// // // //                       ],
// // // //                     ),
// // // //                   ))
// // // //               .toList(),
// // // //         ),
// // // //       ),
// // // //       body: Obx(() {
// // // //         if (_c.isLoading.value && _c.appointments.isEmpty) {
// // // //           return _buildLoader(context, size);
// // // //         }
// // // //         return TabBarView(
// // // //           controller: _tab,
// // // //           children: [
// // // //             _buildList(context, size, _c.allAppointments),
// // // //             _buildList(context, size, _c.scheduledList),
// // // //             _buildList(context, size, _c.confirmedList),
// // // //             _buildList(context, size, _c.completedList),
// // // //             _buildList(context, size, _c.cancelledList),
// // // //             _buildList(context, size, _c.noShowList),
// // // //           ],
// // // //         );
// // // //       }),
// // // //     );
// // // //   }

// // // //   Widget _buildList(
// // // //       BuildContext context, CustomSize size, List<MyAppointmentItem> list) {
// // // //     if (list.isEmpty) return _buildEmpty(context, size);
// // // //     return RefreshIndicator(
// // // //       color: AppColors.primaryColor,
// // // //       onRefresh: _c.fetchMyAppointments,
// // // //       child: ListView.builder(
// // // //         padding: EdgeInsets.fromLTRB(
// // // //           size.customWidth(context) * 0.045,
// // // //           size.customHeight(context) * 0.02,
// // // //           size.customWidth(context) * 0.045,
// // // //           size.customHeight(context) * 0.04,
// // // //         ),
// // // //         itemCount: list.length,
// // // //         itemBuilder: (_, i) => _appointmentCard(context, size, list[i]),
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _appointmentCard(
// // // //       BuildContext context, CustomSize size, MyAppointmentItem appt) {
// // // //     final meta = _getStatusMeta(appt.status);

// // // //     return GestureDetector(
// // // //       onTap: () {
// // // //         // Pass appointmentId as a String — no cast issues
// // // //         Get.toNamed(
// // // //           AppRoutes.myAppointmentDetail,
// // // //           arguments: appt.appointmentId,
// // // //         );
// // // //       },
// // // //       child: Container(
// // // //         margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.016),
// // // //         decoration: BoxDecoration(
// // // //           color: AppColors.whiteColor,
// // // //           borderRadius: BorderRadius.circular(20),
// // // //           boxShadow: [
// // // //             BoxShadow(
// // // //                 color: Colors.black.withOpacity(0.06),
// // // //                 blurRadius: 14,
// // // //                 offset: const Offset(0, 4))
// // // //           ],
// // // //         ),
// // // //         child: Column(
// // // //           children: [
// // // //             // Colored top strip
// // // //             Container(
// // // //               height: 4,
// // // //               decoration: BoxDecoration(
// // // //                 color: meta.color,
// // // //                 borderRadius:
// // // //                     const BorderRadius.vertical(top: Radius.circular(20)),
// // // //               ),
// // // //             ),
// // // //             Padding(
// // // //               padding: EdgeInsets.all(size.customWidth(context) * 0.042),
// // // //               child: Column(
// // // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // // //                 children: [
// // // //                   // Row: avatar + info + badge
// // // //                   Row(
// // // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // // //                     children: [
// // // //                       _childAvatar(appt.childInitials, 50),
// // // //                       SizedBox(width: size.customWidth(context) * 0.03),
// // // //                       Expanded(
// // // //                         child: Column(
// // // //                           crossAxisAlignment: CrossAxisAlignment.start,
// // // //                           children: [
// // // //                             Text(
// // // //                               appt.children?.childName ?? 'Unknown Child',
// // // //                               style: GoogleFonts.poppins(
// // // //                                   fontSize: size.customWidth(context) * 0.038,
// // // //                                   fontWeight: FontWeight.w700,
// // // //                                   color: AppColors.textPrimaryColor),
// // // //                               maxLines: 1,
// // // //                               overflow: TextOverflow.ellipsis,
// // // //                             ),
// // // //                             const SizedBox(height: 2),
// // // //                             Text(
// // // //                               appt.expertUsers?.fullName ?? '',
// // // //                               style: GoogleFonts.poppins(
// // // //                                   fontSize: size.customWidth(context) * 0.03,
// // // //                                   color: AppColors.primaryColor,
// // // //                                   fontWeight: FontWeight.w500),
// // // //                               maxLines: 1,
// // // //                               overflow: TextOverflow.ellipsis,
// // // //                             ),
// // // //                             Text(
// // // //                               appt.expertUsers?.specialization ?? '',
// // // //                               style: GoogleFonts.poppins(
// // // //                                   fontSize: size.customWidth(context) * 0.028,
// // // //                                   color: AppColors.textSecondaryColor),
// // // //                               maxLines: 1,
// // // //                               overflow: TextOverflow.ellipsis,
// // // //                             ),
// // // //                           ],
// // // //                         ),
// // // //                       ),
// // // //                       const SizedBox(width: 8),
// // // //                       _statusBadge(meta),
// // // //                     ],
// // // //                   ),
// // // //                   SizedBox(height: size.customHeight(context) * 0.012),
// // // //                   Divider(
// // // //                       height: 1,
// // // //                       color: AppColors.greyColor.withOpacity(0.15)),
// // // //                   SizedBox(height: size.customHeight(context) * 0.01),
// // // //                   // Info chips
// // // //                   Wrap(
// // // //                     spacing: 14,
// // // //                     runSpacing: 6,
// // // //                     children: [
// // // //                       _infoChip(Icons.calendar_today_outlined,
// // // //                           appt.formattedDate, AppColors.primaryColor),
// // // //                       _infoChip(Icons.access_time_rounded, appt.formattedTime,
// // // //                           AppColors.secondaryColor),
// // // //                       _infoChip(
// // // //                           _modeIcon(appt.bookedMode),
// // // //                           appt.bookedMode[0].toUpperCase() +
// // // //                               appt.bookedMode.substring(1),
// // // //                           AppColors.accentColor),
// // // //                       _infoChip(
// // // //                           Icons.payments_outlined,
// // // //                           '${appt.currency} ${appt.feeCharged.toStringAsFixed(0)}',
// // // //                           AppColors.warningColor),
// // // //                     ],
// // // //                   ),
// // // //                   // Cancellation reason
// // // //                   if (appt.isCancelled &&
// // // //                       appt.cancellationReason != null) ...[
// // // //                     SizedBox(height: size.customHeight(context) * 0.01),
// // // //                     Container(
// // // //                       padding: const EdgeInsets.symmetric(
// // // //                           horizontal: 10, vertical: 7),
// // // //                       decoration: BoxDecoration(
// // // //                         color: AppColors.errorColor.withOpacity(0.06),
// // // //                         borderRadius: BorderRadius.circular(10),
// // // //                       ),
// // // //                       child: Row(
// // // //                         children: [
// // // //                           const Icon(Icons.info_outline_rounded,
// // // //                               size: 13, color: AppColors.errorColor),
// // // //                           const SizedBox(width: 6),
// // // //                           Expanded(
// // // //                             child: Text(
// // // //                               'Reason: ${appt.cancellationReason}',
// // // //                               style: GoogleFonts.poppins(
// // // //                                   fontSize: 11.5,
// // // //                                   color: AppColors.errorColor),
// // // //                               maxLines: 2,
// // // //                               overflow: TextOverflow.ellipsis,
// // // //                             ),
// // // //                           ),
// // // //                         ],
// // // //                       ),
// // // //                     ),
// // // //                   ],
// // // //                   // Chevron
// // // //                   SizedBox(height: size.customHeight(context) * 0.008),
// // // //                   Row(
// // // //                     mainAxisAlignment: MainAxisAlignment.end,
// // // //                     children: [
// // // //                       Text('View Details',
// // // //                           style: GoogleFonts.poppins(
// // // //                               fontSize: 11,
// // // //                               color: AppColors.primaryColor,
// // // //                               fontWeight: FontWeight.w500)),
// // // //                       const SizedBox(width: 3),
// // // //                       const Icon(Icons.arrow_forward_ios_rounded,
// // // //                           size: 11, color: AppColors.primaryColor),
// // // //                     ],
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _childAvatar(String initials, double size) {
// // // //     return Container(
// // // //       width: size,
// // // //       height: size,
// // // //       decoration: BoxDecoration(
// // // //         gradient: const LinearGradient(
// // // //           colors: [AppColors.primaryColor, AppColors.secondaryColor],
// // // //           begin: Alignment.topLeft,
// // // //           end: Alignment.bottomRight,
// // // //         ),
// // // //         borderRadius: BorderRadius.circular(14),
// // // //       ),
// // // //       child: Center(
// // // //         child: Text(initials,
// // // //             style: GoogleFonts.poppins(
// // // //                 color: Colors.white,
// // // //                 fontSize: size * 0.32,
// // // //                 fontWeight: FontWeight.bold)),
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _statusBadge(_StatusMeta meta) {
// // // //     return Container(
// // // //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
// // // //       decoration: BoxDecoration(
// // // //         color: meta.color.withOpacity(0.1),
// // // //         borderRadius: BorderRadius.circular(20),
// // // //         border: Border.all(color: meta.color.withOpacity(0.3)),
// // // //       ),
// // // //       child: Text(meta.label,
// // // //           style: GoogleFonts.poppins(
// // // //               fontSize: 10,
// // // //               fontWeight: FontWeight.w600,
// // // //               color: meta.color)),
// // // //     );
// // // //   }

// // // //   Widget _infoChip(IconData icon, String label, Color color) {
// // // //     return Row(
// // // //       mainAxisSize: MainAxisSize.min,
// // // //       children: [
// // // //         Icon(icon, size: 13, color: color),
// // // //         const SizedBox(width: 4),
// // // //         Text(label,
// // // //             style: GoogleFonts.poppins(
// // // //                 fontSize: 11.5,
// // // //                 color: AppColors.textSecondaryColor,
// // // //                 fontWeight: FontWeight.w500)),
// // // //       ],
// // // //     );
// // // //   }

// // // //   Widget _buildLoader(BuildContext context, CustomSize size) {
// // // //     return Center(
// // // //       child: Column(
// // // //         mainAxisAlignment: MainAxisAlignment.center,
// // // //         children: [
// // // //           const CircularProgressIndicator(
// // // //               color: AppColors.primaryColor, strokeWidth: 3),
// // // //           SizedBox(height: size.customHeight(context) * 0.02),
// // // //           Text('Loading appointments...',
// // // //               style: GoogleFonts.poppins(
// // // //                   color: AppColors.textSecondaryColor, fontSize: 14)),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _buildEmpty(BuildContext context, CustomSize size) {
// // // //     return Center(
// // // //       child: Column(
// // // //         mainAxisAlignment: MainAxisAlignment.center,
// // // //         children: [
// // // //           Container(
// // // //             width: 100,
// // // //             height: 100,
// // // //             decoration: BoxDecoration(
// // // //                 color: AppColors.primaryColor.withOpacity(0.07),
// // // //                 shape: BoxShape.circle),
// // // //             child: const Icon(Icons.event_busy_outlined,
// // // //                 size: 48, color: AppColors.primaryColor),
// // // //           ),
// // // //           SizedBox(height: size.customHeight(context) * 0.022),
// // // //           Text('No Appointments Found',
// // // //               style: GoogleFonts.poppins(
// // // //                   fontSize: 16,
// // // //                   fontWeight: FontWeight.bold,
// // // //                   color: AppColors.textPrimaryColor)),
// // // //           const SizedBox(height: 6),
// // // //           Text('Nothing to show in this category',
// // // //               style: GoogleFonts.poppins(
// // // //                   fontSize: 13, color: AppColors.textSecondaryColor)),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }

// // // //   _StatusMeta _getStatusMeta(String status) {
// // // //     switch (status.toLowerCase()) {
// // // //       case 'confirmed':
// // // //         return _StatusMeta(AppColors.primaryColor, 'Confirmed');
// // // //       case 'completed':
// // // //         return _StatusMeta(AppColors.successColor, 'Completed');
// // // //       case 'cancelled':
// // // //         return _StatusMeta(AppColors.errorColor, 'Cancelled');
// // // //       case 'no_show':
// // // //         return _StatusMeta(AppColors.greyColor, 'No Show');
// // // //       default:
// // // //         return _StatusMeta(AppColors.warningColor, 'Scheduled');
// // // //     }
// // // //   }

// // // //   IconData _modeIcon(String mode) {
// // // //     switch (mode.toLowerCase()) {
// // // //       case 'online':
// // // //         return Icons.videocam_outlined;
// // // //       case 'physical':
// // // //         return Icons.location_on_outlined;
// // // //       default:
// // // //         return Icons.swap_horiz_rounded;
// // // //     }
// // // //   }
// // // // }

// // // // class _StatusMeta {
// // // //   final Color color;
// // // //   final String label;
// // // //   _StatusMeta(this.color, this.label);
// // // // }



// // // // lib/view/expert/appointments/my_appointments_screen.dart
// // // import 'package:flutter/material.dart';
// // // import 'package:get/get.dart';
// // // import 'package:google_fonts/google_fonts.dart';
// // // import 'package:speechspectrum/constants/app_colors.dart';
// // // import 'package:speechspectrum/constants/custom_size.dart';
// // // import 'package:speechspectrum/controllers/my_appointment_controller.dart';
// // // import 'package:speechspectrum/models/my_appointment_model.dart';
// // // import 'package:speechspectrum/routes/app_routes.dart';

// // // class MyAppointmentsScreen extends StatefulWidget {
// // //   const MyAppointmentsScreen({super.key});

// // //   @override
// // //   State<MyAppointmentsScreen> createState() => _MyAppointmentsScreenState();
// // // }

// // // class _MyAppointmentsScreenState extends State<MyAppointmentsScreen>
// // //     with SingleTickerProviderStateMixin {
// // //   late final MyAppointmentController _c;
// // //   late final TabController _tab;

// // //   static const _tabs = [
// // //     ('All', Icons.list_alt_rounded),
// // //     ('Scheduled', Icons.schedule_rounded),
// // //     ('Confirmed', Icons.check_circle_outline_rounded),
// // //     ('Completed', Icons.task_alt_rounded),
// // //     ('Cancelled', Icons.cancel_outlined),
// // //     ('No Show', Icons.person_off_outlined),
// // //   ];

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _tab = TabController(length: _tabs.length, vsync: this);
// // //     _c = Get.isRegistered<MyAppointmentController>()
// // //         ? Get.find<MyAppointmentController>()
// // //         : Get.put(MyAppointmentController());
// // //     WidgetsBinding.instance.addPostFrameCallback((_) {
// // //       _c.fetchMyAppointments();
// // //     });
// // //   }

// // //   @override
// // //   void dispose() {
// // //     _tab.dispose();
// // //     super.dispose();
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final size = CustomSize();
// // //     return Scaffold(
// // //       backgroundColor: AppColors.lightGreyColor,
// // //       appBar: AppBar(
// // //         backgroundColor: AppColors.whiteColor,
// // //         elevation: 0,
// // //         surfaceTintColor: Colors.transparent,
// // //         leading: IconButton(
// // //           icon: const Icon(Icons.arrow_back_ios_new_rounded,
// // //               color: AppColors.textPrimaryColor, size: 20),
// // //           onPressed: () => Get.back(),
// // //         ),
// // //         title: Text(
// // //           'My Appointments',
// // //           style: GoogleFonts.poppins(
// // //               color: AppColors.textPrimaryColor,
// // //               fontSize: 18,
// // //               fontWeight: FontWeight.w600),
// // //         ),
// // //         actions: [
// // //           Obx(() => _c.isLoading.value
// // //               ? const Padding(
// // //                   padding: EdgeInsets.all(14),
// // //                   child: SizedBox(
// // //                     width: 20,
// // //                     height: 20,
// // //                     child: CircularProgressIndicator(
// // //                         color: AppColors.primaryColor, strokeWidth: 2),
// // //                   ),
// // //                 )
// // //               : IconButton(
// // //                   icon: const Icon(Icons.refresh_rounded,
// // //                       color: AppColors.primaryColor),
// // //                   onPressed: _c.fetchMyAppointments,
// // //                 )),
// // //           const SizedBox(width: 4),
// // //         ],
// // //         bottom: TabBar(
// // //           controller: _tab,
// // //           isScrollable: true,
// // //           tabAlignment: TabAlignment.start,
// // //           labelColor: AppColors.primaryColor,
// // //           unselectedLabelColor: AppColors.textSecondaryColor,
// // //           indicatorColor: AppColors.primaryColor,
// // //           indicatorWeight: 3,
// // //           labelPadding:
// // //               const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
// // //           labelStyle:
// // //               GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12.5),
// // //           unselectedLabelStyle:
// // //               GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 12.5),
// // //           tabs: _tabs
// // //               .map((t) => Tab(
// // //                     child: Row(
// // //                       mainAxisSize: MainAxisSize.min,
// // //                       children: [
// // //                         Icon(t.$2, size: 14),
// // //                         const SizedBox(width: 5),
// // //                         Text(t.$1),
// // //                       ],
// // //                     ),
// // //                   ))
// // //               .toList(),
// // //         ),
// // //       ),
// // //       body: Obx(() {
// // //         if (_c.isLoading.value && _c.appointments.isEmpty) {
// // //           return _buildLoader(context, size);
// // //         }
// // //         return TabBarView(
// // //           controller: _tab,
// // //           children: [
// // //             _buildList(context, size, _c.allAppointments),
// // //             _buildList(context, size, _c.scheduledList),
// // //             _buildList(context, size, _c.confirmedList),
// // //             _buildList(context, size, _c.completedList),
// // //             _buildList(context, size, _c.cancelledList),
// // //             _buildList(context, size, _c.noShowList),
// // //           ],
// // //         );
// // //       }),
// // //     );
// // //   }

// // //   Widget _buildList(
// // //       BuildContext context, CustomSize size, List<MyAppointmentItem> list) {
// // //     if (list.isEmpty) return _buildEmpty(context, size);
// // //     return RefreshIndicator(
// // //       color: AppColors.primaryColor,
// // //       onRefresh: _c.fetchMyAppointments,
// // //       child: ListView.builder(
// // //         padding: EdgeInsets.fromLTRB(
// // //           size.customWidth(context) * 0.045,
// // //           size.customHeight(context) * 0.02,
// // //           size.customWidth(context) * 0.045,
// // //           size.customHeight(context) * 0.04,
// // //         ),
// // //         itemCount: list.length,
// // //         itemBuilder: (_, i) => _appointmentCard(context, size, list[i]),
// // //       ),
// // //     );
// // //   }

// // //   Widget _appointmentCard(
// // //       BuildContext context, CustomSize size, MyAppointmentItem appt) {
// // //     final meta = _getStatusMeta(appt.status);

// // //     // A completed appointment with no records in the controller's cache.
// // //     // We check _c.appointmentRecordCounts which we populate lazily.
// // //     // For simplicity, the list screen shows the warning badge for ALL
// // //     // completed appointments — the detail screen shows the real state.
// // //     // If you want per-card accuracy you'd need a separate API call per card.
// // //     final bool showMissingNotesBadge = appt.isCompleted;

// // //     return GestureDetector(
// // //       onTap: () {
// // //         Get.toNamed(
// // //           AppRoutes.myAppointmentDetail,
// // //           arguments: appt.appointmentId,
// // //         );
// // //       },
// // //       child: Container(
// // //         margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.016),
// // //         decoration: BoxDecoration(
// // //           color: AppColors.whiteColor,
// // //           borderRadius: BorderRadius.circular(20),
// // //           // Highlight border for completed cards to draw attention
// // //           border: showMissingNotesBadge
// // //               ? Border.all(
// // //                   color: AppColors.warningColor.withOpacity(0.0),
// // //                   width: 0)
// // //               : null,
// // //           boxShadow: [
// // //             BoxShadow(
// // //                 color: Colors.black.withOpacity(0.06),
// // //                 blurRadius: 14,
// // //                 offset: const Offset(0, 4))
// // //           ],
// // //         ),
// // //         child: Column(
// // //           children: [
// // //             // Colored top strip
// // //             Container(
// // //               height: 4,
// // //               decoration: BoxDecoration(
// // //                 color: meta.color,
// // //                 borderRadius:
// // //                     const BorderRadius.vertical(top: Radius.circular(20)),
// // //               ),
// // //             ),
// // //             Padding(
// // //               padding: EdgeInsets.all(size.customWidth(context) * 0.042),
// // //               child: Column(
// // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // //                 children: [
// // //                   // Row: avatar + info + badge
// // //                   Row(
// // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // //                     children: [
// // //                       _childAvatar(appt.childInitials, 50),
// // //                       SizedBox(width: size.customWidth(context) * 0.03),
// // //                       Expanded(
// // //                         child: Column(
// // //                           crossAxisAlignment: CrossAxisAlignment.start,
// // //                           children: [
// // //                             Text(
// // //                               appt.children?.childName ?? 'Unknown Child',
// // //                               style: GoogleFonts.poppins(
// // //                                   fontSize: size.customWidth(context) * 0.038,
// // //                                   fontWeight: FontWeight.w700,
// // //                                   color: AppColors.textPrimaryColor),
// // //                               maxLines: 1,
// // //                               overflow: TextOverflow.ellipsis,
// // //                             ),
// // //                             const SizedBox(height: 2),
// // //                             Text(
// // //                               appt.expertUsers?.fullName ?? '',
// // //                               style: GoogleFonts.poppins(
// // //                                   fontSize: size.customWidth(context) * 0.03,
// // //                                   color: AppColors.primaryColor,
// // //                                   fontWeight: FontWeight.w500),
// // //                               maxLines: 1,
// // //                               overflow: TextOverflow.ellipsis,
// // //                             ),
// // //                             Text(
// // //                               appt.expertUsers?.specialization ?? '',
// // //                               style: GoogleFonts.poppins(
// // //                                   fontSize: size.customWidth(context) * 0.028,
// // //                                   color: AppColors.textSecondaryColor),
// // //                               maxLines: 1,
// // //                               overflow: TextOverflow.ellipsis,
// // //                             ),
// // //                           ],
// // //                         ),
// // //                       ),
// // //                       const SizedBox(width: 8),
// // //                       _statusBadge(meta),
// // //                     ],
// // //                   ),
// // //                   SizedBox(height: size.customHeight(context) * 0.012),
// // //                   Divider(
// // //                       height: 1,
// // //                       color: AppColors.greyColor.withOpacity(0.15)),
// // //                   SizedBox(height: size.customHeight(context) * 0.01),
// // //                   // Info chips
// // //                   Wrap(
// // //                     spacing: 14,
// // //                     runSpacing: 6,
// // //                     children: [
// // //                       _infoChip(Icons.calendar_today_outlined,
// // //                           appt.formattedDate, AppColors.primaryColor),
// // //                       _infoChip(Icons.access_time_rounded, appt.formattedTime,
// // //                           AppColors.secondaryColor),
// // //                       _infoChip(
// // //                           _modeIcon(appt.bookedMode),
// // //                           appt.bookedMode[0].toUpperCase() +
// // //                               appt.bookedMode.substring(1),
// // //                           AppColors.accentColor),
// // //                       _infoChip(
// // //                           Icons.payments_outlined,
// // //                           '${appt.currency} ${appt.feeCharged.toStringAsFixed(0)}',
// // //                           AppColors.warningColor),
// // //                     ],
// // //                   ),
// // //                   // Cancellation reason
// // //                   if (appt.isCancelled &&
// // //                       appt.cancellationReason != null) ...[
// // //                     SizedBox(height: size.customHeight(context) * 0.01),
// // //                     Container(
// // //                       padding: const EdgeInsets.symmetric(
// // //                           horizontal: 10, vertical: 7),
// // //                       decoration: BoxDecoration(
// // //                         color: AppColors.errorColor.withOpacity(0.06),
// // //                         borderRadius: BorderRadius.circular(10),
// // //                       ),
// // //                       child: Row(
// // //                         children: [
// // //                           const Icon(Icons.info_outline_rounded,
// // //                               size: 13, color: AppColors.errorColor),
// // //                           const SizedBox(width: 6),
// // //                           Expanded(
// // //                             child: Text(
// // //                               'Reason: ${appt.cancellationReason}',
// // //                               style: GoogleFonts.poppins(
// // //                                   fontSize: 11.5,
// // //                                   color: AppColors.errorColor),
// // //                               maxLines: 2,
// // //                               overflow: TextOverflow.ellipsis,
// // //                             ),
// // //                           ),
// // //                         ],
// // //                       ),
// // //                     ),
// // //                   ],

// // //                   // ── "Notes missing" warning for completed cards ──
// // //                   if (showMissingNotesBadge) ...[
// // //                     SizedBox(height: size.customHeight(context) * 0.01),
// // //                     Container(
// // //                       padding: const EdgeInsets.symmetric(
// // //                           horizontal: 10, vertical: 8),
// // //                       decoration: BoxDecoration(
// // //                         color: AppColors.warningColor.withOpacity(0.08),
// // //                         borderRadius: BorderRadius.circular(10),
// // //                         border: Border.all(
// // //                             color: AppColors.warningColor.withOpacity(0.3)),
// // //                       ),
// // //                       child: Row(
// // //                         children: [
// // //                           const Icon(Icons.note_add_rounded,
// // //                               size: 13, color: AppColors.warningColor),
// // //                           const SizedBox(width: 6),
// // //                           Expanded(
// // //                             child: Text(
// // //                               'Tap to view or add session notes',
// // //                               style: GoogleFonts.poppins(
// // //                                   fontSize: 11.5,
// // //                                   color: AppColors.warningColor,
// // //                                   fontWeight: FontWeight.w500),
// // //                             ),
// // //                           ),
// // //                           const Icon(Icons.arrow_forward_ios_rounded,
// // //                               size: 10, color: AppColors.warningColor),
// // //                         ],
// // //                       ),
// // //                     ),
// // //                   ],

// // //                   // Chevron
// // //                   SizedBox(height: size.customHeight(context) * 0.008),
// // //                   Row(
// // //                     mainAxisAlignment: MainAxisAlignment.end,
// // //                     children: [
// // //                       Text('View Details',
// // //                           style: GoogleFonts.poppins(
// // //                               fontSize: 11,
// // //                               color: AppColors.primaryColor,
// // //                               fontWeight: FontWeight.w500)),
// // //                       const SizedBox(width: 3),
// // //                       const Icon(Icons.arrow_forward_ios_rounded,
// // //                           size: 11, color: AppColors.primaryColor),
// // //                     ],
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _childAvatar(String initials, double size) {
// // //     return Container(
// // //       width: size,
// // //       height: size,
// // //       decoration: BoxDecoration(
// // //         gradient: const LinearGradient(
// // //           colors: [AppColors.primaryColor, AppColors.secondaryColor],
// // //           begin: Alignment.topLeft,
// // //           end: Alignment.bottomRight,
// // //         ),
// // //         borderRadius: BorderRadius.circular(14),
// // //       ),
// // //       child: Center(
// // //         child: Text(initials,
// // //             style: GoogleFonts.poppins(
// // //                 color: Colors.white,
// // //                 fontSize: size * 0.32,
// // //                 fontWeight: FontWeight.bold)),
// // //       ),
// // //     );
// // //   }

// // //   Widget _statusBadge(_StatusMeta meta) {
// // //     return Container(
// // //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
// // //       decoration: BoxDecoration(
// // //         color: meta.color.withOpacity(0.1),
// // //         borderRadius: BorderRadius.circular(20),
// // //         border: Border.all(color: meta.color.withOpacity(0.3)),
// // //       ),
// // //       child: Text(meta.label,
// // //           style: GoogleFonts.poppins(
// // //               fontSize: 10,
// // //               fontWeight: FontWeight.w600,
// // //               color: meta.color)),
// // //     );
// // //   }

// // //   Widget _infoChip(IconData icon, String label, Color color) {
// // //     return Row(
// // //       mainAxisSize: MainAxisSize.min,
// // //       children: [
// // //         Icon(icon, size: 13, color: color),
// // //         const SizedBox(width: 4),
// // //         Text(label,
// // //             style: GoogleFonts.poppins(
// // //                 fontSize: 11.5,
// // //                 color: AppColors.textSecondaryColor,
// // //                 fontWeight: FontWeight.w500)),
// // //       ],
// // //     );
// // //   }

// // //   Widget _buildLoader(BuildContext context, CustomSize size) {
// // //     return Center(
// // //       child: Column(
// // //         mainAxisAlignment: MainAxisAlignment.center,
// // //         children: [
// // //           const CircularProgressIndicator(
// // //               color: AppColors.primaryColor, strokeWidth: 3),
// // //           SizedBox(height: size.customHeight(context) * 0.02),
// // //           Text('Loading appointments...',
// // //               style: GoogleFonts.poppins(
// // //                   color: AppColors.textSecondaryColor, fontSize: 14)),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildEmpty(BuildContext context, CustomSize size) {
// // //     return Center(
// // //       child: Column(
// // //         mainAxisAlignment: MainAxisAlignment.center,
// // //         children: [
// // //           Container(
// // //             width: 100,
// // //             height: 100,
// // //             decoration: BoxDecoration(
// // //                 color: AppColors.primaryColor.withOpacity(0.07),
// // //                 shape: BoxShape.circle),
// // //             child: const Icon(Icons.event_busy_outlined,
// // //                 size: 48, color: AppColors.primaryColor),
// // //           ),
// // //           SizedBox(height: size.customHeight(context) * 0.022),
// // //           Text('No Appointments Found',
// // //               style: GoogleFonts.poppins(
// // //                   fontSize: 16,
// // //                   fontWeight: FontWeight.bold,
// // //                   color: AppColors.textPrimaryColor)),
// // //           const SizedBox(height: 6),
// // //           Text('Nothing to show in this category',
// // //               style: GoogleFonts.poppins(
// // //                   fontSize: 13, color: AppColors.textSecondaryColor)),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   _StatusMeta _getStatusMeta(String status) {
// // //     switch (status.toLowerCase()) {
// // //       case 'confirmed':
// // //         return _StatusMeta(AppColors.primaryColor, 'Confirmed');
// // //       case 'completed':
// // //         return _StatusMeta(AppColors.successColor, 'Completed');
// // //       case 'cancelled':
// // //         return _StatusMeta(AppColors.errorColor, 'Cancelled');
// // //       case 'no_show':
// // //         return _StatusMeta(AppColors.greyColor, 'No Show');
// // //       default:
// // //         return _StatusMeta(AppColors.warningColor, 'Scheduled');
// // //     }
// // //   }

// // //   IconData _modeIcon(String mode) {
// // //     switch (mode.toLowerCase()) {
// // //       case 'online':
// // //         return Icons.videocam_outlined;
// // //       case 'physical':
// // //         return Icons.location_on_outlined;
// // //       default:
// // //         return Icons.swap_horiz_rounded;
// // //     }
// // //   }
// // // }

// // // class _StatusMeta {
// // //   final Color color;
// // //   final String label;
// // //   _StatusMeta(this.color, this.label);
// // // }


// // // lib/view/expert/appointments/my_appointments_screen.dart
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:speechspectrum/constants/app_colors.dart';
// // import 'package:speechspectrum/constants/custom_size.dart';
// // import 'package:speechspectrum/controllers/my_appointment_controller.dart';
// // import 'package:speechspectrum/models/my_appointment_model.dart';
// // import 'package:speechspectrum/routes/app_routes.dart';

// // class MyAppointmentsScreen extends StatefulWidget {
// //   const MyAppointmentsScreen({super.key});

// //   @override
// //   State<MyAppointmentsScreen> createState() => _MyAppointmentsScreenState();
// // }

// // class _MyAppointmentsScreenState extends State<MyAppointmentsScreen>
// //     with SingleTickerProviderStateMixin {
// //   late final MyAppointmentController _c;
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
// //     _c = Get.isRegistered<MyAppointmentController>()
// //         ? Get.find<MyAppointmentController>()
// //         : Get.put(MyAppointmentController());
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
// //         title: Text(
// //           'My Appointments',
// //           style: GoogleFonts.poppins(
// //               color: AppColors.textPrimaryColor,
// //               fontSize: 18,
// //               fontWeight: FontWeight.w600),
// //         ),
// //         actions: [
// //           Obx(() => _c.isLoading.value
// //               ? const Padding(
// //                   padding: EdgeInsets.all(14),
// //                   child: SizedBox(
// //                     width: 20,
// //                     height: 20,
// //                     child: CircularProgressIndicator(
// //                         color: AppColors.primaryColor, strokeWidth: 2),
// //                   ),
// //                 )
// //               : IconButton(
// //                   icon: const Icon(Icons.refresh_rounded,
// //                       color: AppColors.primaryColor),
// //                   onPressed: _c.fetchMyAppointments,
// //                 )),
// //           const SizedBox(width: 4),
// //         ],
// //         bottom: TabBar(
// //           controller: _tab,
// //           isScrollable: true,
// //           tabAlignment: TabAlignment.start,
// //           labelColor: AppColors.primaryColor,
// //           unselectedLabelColor: AppColors.textSecondaryColor,
// //           indicatorColor: AppColors.primaryColor,
// //           indicatorWeight: 3,
// //           labelPadding:
// //               const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
// //           labelStyle:
// //               GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12.5),
// //           unselectedLabelStyle:
// //               GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 12.5),
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
// //         if (_c.isLoading.value && _c.appointments.isEmpty) {
// //           return _buildLoader(context, size);
// //         }
// //         return TabBarView(
// //           controller: _tab,
// //           children: [
// //             _buildList(context, size, _c.allAppointments),
// //             _buildList(context, size, _c.scheduledList),
// //             _buildList(context, size, _c.confirmedList),
// //             _buildList(context, size, _c.completedList),
// //             _buildList(context, size, _c.cancelledList),
// //             _buildList(context, size, _c.noShowList),
// //           ],
// //         );
// //       }),
// //     );
// //   }

// //   Widget _buildList(
// //       BuildContext context, CustomSize size, List<MyAppointmentItem> list) {
// //     if (list.isEmpty) return _buildEmpty(context, size);
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
// //         itemCount: list.length,
// //         itemBuilder: (_, i) => _appointmentCard(context, size, list[i]),
// //       ),
// //     );
// //   }

// //   Widget _appointmentCard(
// //       BuildContext context, CustomSize size, MyAppointmentItem appt) {
// //     final meta = _getStatusMeta(appt.status);

// //     return GestureDetector(
// //       onTap: () {
// //         // Pass full appointment data so header shows immediately (no "Unknown")
// //         Get.toNamed(
// //           AppRoutes.myAppointmentDetail,
// //           arguments: {
// //             'appointmentId': appt.appointmentId,
// //             'childName': appt.children?.childName ?? '',
// //             'expertName': appt.expertUsers?.fullName ?? '',
// //             'specialization': appt.expertUsers?.specialization ?? '',
// //             'childInitials': appt.childInitials,
// //             'status': appt.status,
// //           },
// //         );
// //       },
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
// //             // Colored top strip
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
// //                   // Row: avatar + info + badge
// //                   Row(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       _childAvatar(appt.childInitials, 50),
// //                       SizedBox(width: size.customWidth(context) * 0.03),
// //                       Expanded(
// //                         child: Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             Text(
// //                               appt.children?.childName ?? 'Unknown Child',
// //                               style: GoogleFonts.poppins(
// //                                   fontSize: size.customWidth(context) * 0.038,
// //                                   fontWeight: FontWeight.w700,
// //                                   color: AppColors.textPrimaryColor),
// //                               maxLines: 1,
// //                               overflow: TextOverflow.ellipsis,
// //                             ),
// //                             const SizedBox(height: 2),
// //                             Text(
// //                               appt.expertUsers?.fullName ?? '',
// //                               style: GoogleFonts.poppins(
// //                                   fontSize: size.customWidth(context) * 0.03,
// //                                   color: AppColors.primaryColor,
// //                                   fontWeight: FontWeight.w500),
// //                               maxLines: 1,
// //                               overflow: TextOverflow.ellipsis,
// //                             ),
// //                             Text(
// //                               appt.expertUsers?.specialization ?? '',
// //                               style: GoogleFonts.poppins(
// //                                   fontSize: size.customWidth(context) * 0.028,
// //                                   color: AppColors.textSecondaryColor),
// //                               maxLines: 1,
// //                               overflow: TextOverflow.ellipsis,
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                       const SizedBox(width: 8),
// //                       _statusBadge(meta),
// //                     ],
// //                   ),
// //                   SizedBox(height: size.customHeight(context) * 0.012),
// //                   Divider(
// //                       height: 1,
// //                       color: AppColors.greyColor.withOpacity(0.15)),
// //                   SizedBox(height: size.customHeight(context) * 0.01),
// //                   // Info chips
// //                   Wrap(
// //                     spacing: 14,
// //                     runSpacing: 6,
// //                     children: [
// //                       _infoChip(Icons.calendar_today_outlined,
// //                           appt.formattedDate, AppColors.primaryColor),
// //                       _infoChip(Icons.access_time_rounded, appt.formattedTime,
// //                           AppColors.secondaryColor),
// //                       _infoChip(
// //                           _modeIcon(appt.bookedMode),
// //                           appt.bookedMode[0].toUpperCase() +
// //                               appt.bookedMode.substring(1),
// //                           AppColors.accentColor),
// //                       _infoChip(
// //                           Icons.payments_outlined,
// //                           '${appt.currency} ${appt.feeCharged.toStringAsFixed(0)}',
// //                           AppColors.warningColor),
// //                     ],
// //                   ),
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
// //                       child: Row(
// //                         children: [
// //                           const Icon(Icons.info_outline_rounded,
// //                               size: 13, color: AppColors.errorColor),
// //                           const SizedBox(width: 6),
// //                           Expanded(
// //                             child: Text(
// //                               'Reason: ${appt.cancellationReason}',
// //                               style: GoogleFonts.poppins(
// //                                   fontSize: 11.5,
// //                                   color: AppColors.errorColor),
// //                               maxLines: 2,
// //                               overflow: TextOverflow.ellipsis,
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ],
// //                   // Chevron
// //                   SizedBox(height: size.customHeight(context) * 0.008),
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.end,
// //                     children: [
// //                       Text('View Details',
// //                           style: GoogleFonts.poppins(
// //                               fontSize: 11,
// //                               color: AppColors.primaryColor,
// //                               fontWeight: FontWeight.w500)),
// //                       const SizedBox(width: 3),
// //                       const Icon(Icons.arrow_forward_ios_rounded,
// //                           size: 11, color: AppColors.primaryColor),
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _childAvatar(String initials, double size) {
// //     return Container(
// //       width: size,
// //       height: size,
// //       decoration: BoxDecoration(
// //         gradient: const LinearGradient(
// //           colors: [AppColors.primaryColor, AppColors.secondaryColor],
// //           begin: Alignment.topLeft,
// //           end: Alignment.bottomRight,
// //         ),
// //         borderRadius: BorderRadius.circular(14),
// //       ),
// //       child: Center(
// //         child: Text(initials,
// //             style: GoogleFonts.poppins(
// //                 color: Colors.white,
// //                 fontSize: size * 0.32,
// //                 fontWeight: FontWeight.bold)),
// //       ),
// //     );
// //   }

// //   Widget _statusBadge(_StatusMeta meta) {
// //     return Container(
// //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
// //       decoration: BoxDecoration(
// //         color: meta.color.withOpacity(0.1),
// //         borderRadius: BorderRadius.circular(20),
// //         border: Border.all(color: meta.color.withOpacity(0.3)),
// //       ),
// //       child: Text(meta.label,
// //           style: GoogleFonts.poppins(
// //               fontSize: 10,
// //               fontWeight: FontWeight.w600,
// //               color: meta.color)),
// //     );
// //   }

// //   Widget _infoChip(IconData icon, String label, Color color) {
// //     return Row(
// //       mainAxisSize: MainAxisSize.min,
// //       children: [
// //         Icon(icon, size: 13, color: color),
// //         const SizedBox(width: 4),
// //         Text(label,
// //             style: GoogleFonts.poppins(
// //                 fontSize: 11.5,
// //                 color: AppColors.textSecondaryColor,
// //                 fontWeight: FontWeight.w500)),
// //       ],
// //     );
// //   }

// //   Widget _buildLoader(BuildContext context, CustomSize size) {
// //     return Center(
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           const CircularProgressIndicator(
// //               color: AppColors.primaryColor, strokeWidth: 3),
// //           SizedBox(height: size.customHeight(context) * 0.02),
// //           Text('Loading appointments...',
// //               style: GoogleFonts.poppins(
// //                   color: AppColors.textSecondaryColor, fontSize: 14)),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildEmpty(BuildContext context, CustomSize size) {
// //     return Center(
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           Container(
// //             width: 100,
// //             height: 100,
// //             decoration: BoxDecoration(
// //                 color: AppColors.primaryColor.withOpacity(0.07),
// //                 shape: BoxShape.circle),
// //             child: const Icon(Icons.event_busy_outlined,
// //                 size: 48, color: AppColors.primaryColor),
// //           ),
// //           SizedBox(height: size.customHeight(context) * 0.022),
// //           Text('No Appointments Found',
// //               style: GoogleFonts.poppins(
// //                   fontSize: 16,
// //                   fontWeight: FontWeight.bold,
// //                   color: AppColors.textPrimaryColor)),
// //           const SizedBox(height: 6),
// //           Text('Nothing to show in this category',
// //               style: GoogleFonts.poppins(
// //                   fontSize: 13, color: AppColors.textSecondaryColor)),
// //         ],
// //       ),
// //     );
// //   }

// //   _StatusMeta _getStatusMeta(String status) {
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

// // lib/view/expert/appointments/my_appointments_screen.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/my_appointment_controller.dart';
// import 'package:speechspectrum/models/my_appointment_model.dart';
// import 'package:speechspectrum/routes/app_routes.dart';

// class MyAppointmentsScreen extends StatefulWidget {
//   const MyAppointmentsScreen({super.key});

//   @override
//   State<MyAppointmentsScreen> createState() => _MyAppointmentsScreenState();
// }

// class _MyAppointmentsScreenState extends State<MyAppointmentsScreen>
//     with SingleTickerProviderStateMixin {
//   late final MyAppointmentController _c;
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
//     _c = Get.isRegistered<MyAppointmentController>()
//         ? Get.find<MyAppointmentController>()
//         : Get.put(MyAppointmentController());
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
//         title: Text(
//           'My Appointments',
//           style: GoogleFonts.poppins(
//               color: AppColors.textPrimaryColor,
//               fontSize: 18,
//               fontWeight: FontWeight.w600),
//         ),
//         actions: [
//           Obx(() => _c.isLoading.value
//               ? const Padding(
//                   padding: EdgeInsets.all(14),
//                   child: SizedBox(
//                     width: 20,
//                     height: 20,
//                     child: CircularProgressIndicator(
//                         color: AppColors.primaryColor, strokeWidth: 2),
//                   ),
//                 )
//               : IconButton(
//                   icon: const Icon(Icons.refresh_rounded,
//                       color: AppColors.primaryColor),
//                   onPressed: _c.fetchMyAppointments,
//                 )),
//           const SizedBox(width: 4),
//         ],
//         bottom: TabBar(
//           controller: _tab,
//           isScrollable: true,
//           tabAlignment: TabAlignment.start,
//           labelColor: AppColors.primaryColor,
//           unselectedLabelColor: AppColors.textSecondaryColor,
//           indicatorColor: AppColors.primaryColor,
//           indicatorWeight: 3,
//           labelPadding:
//               const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
//           labelStyle:
//               GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12.5),
//           unselectedLabelStyle:
//               GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 12.5),
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
//         if (_c.isLoading.value && _c.appointments.isEmpty) {
//           return _buildLoader(context, size);
//         }
//         return TabBarView(
//           controller: _tab,
//           children: [
//             _buildList(context, size, _c.allAppointments),
//             _buildList(context, size, _c.scheduledList),
//             _buildList(context, size, _c.confirmedList),
//             _buildList(context, size, _c.completedList),
//             _buildList(context, size, _c.cancelledList),
//             _buildList(context, size, _c.noShowList),
//           ],
//         );
//       }),
//     );
//   }

//   Widget _buildList(
//       BuildContext context, CustomSize size, List<MyAppointmentItem> list) {
//     if (list.isEmpty) return _buildEmpty(context, size);
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
//         itemCount: list.length,
//         itemBuilder: (_, i) => _appointmentCard(context, size, list[i]),
//       ),
//     );
//   }

//   Widget _appointmentCard(
//       BuildContext context, CustomSize size, MyAppointmentItem appt) {
//     final meta = _getStatusMeta(appt.status);

//     return GestureDetector(
//       onTap: () {
//         Get.toNamed(
//           AppRoutes.myAppointmentDetail,
//           arguments: {
//             'appointmentId': appt.appointmentId,
//             'childName': appt.children?.childName ?? '',
//             'expertName': appt.expertUsers?.fullName ?? '',
//             'specialization': appt.expertUsers?.specialization ?? '',
//             'childInitials': appt.childInitials,
//             'status': appt.status,
//           },
//         );
//       },
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
//             // Colored top strip
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
//                   // Row: avatar + info + badge
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       _childAvatar(appt.childInitials, 50),
//                       SizedBox(width: size.customWidth(context) * 0.03),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               appt.children?.childName ?? 'Unknown Child',
//                               style: GoogleFonts.poppins(
//                                   fontSize: size.customWidth(context) * 0.038,
//                                   fontWeight: FontWeight.w700,
//                                   color: AppColors.textPrimaryColor),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                             const SizedBox(height: 2),
//                             Text(
//                               appt.expertUsers?.fullName ?? '',
//                               style: GoogleFonts.poppins(
//                                   fontSize: size.customWidth(context) * 0.03,
//                                   color: AppColors.primaryColor,
//                                   fontWeight: FontWeight.w500),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                             Text(
//                               appt.expertUsers?.specialization ?? '',
//                               style: GoogleFonts.poppins(
//                                   fontSize: size.customWidth(context) * 0.028,
//                                   color: AppColors.textSecondaryColor),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       _statusBadge(meta),
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
//                       _infoChip(Icons.calendar_today_outlined,
//                           appt.formattedDate, AppColors.primaryColor),
//                       _infoChip(Icons.access_time_rounded, appt.formattedTime,
//                           AppColors.secondaryColor),
//                       _infoChip(
//                           _modeIcon(appt.bookedMode),
//                           appt.bookedMode[0].toUpperCase() +
//                               appt.bookedMode.substring(1),
//                           AppColors.accentColor),
//                       _infoChip(
//                           Icons.payments_outlined,
//                           '${appt.currency} ${appt.feeCharged.toStringAsFixed(0)}',
//                           AppColors.warningColor),
//                     ],
//                   ),
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
//                       child: Row(
//                         children: [
//                           const Icon(Icons.info_outline_rounded,
//                               size: 13, color: AppColors.errorColor),
//                           const SizedBox(width: 6),
//                           Expanded(
//                             child: Text(
//                               'Reason: ${appt.cancellationReason}',
//                               style: GoogleFonts.poppins(
//                                   fontSize: 11.5,
//                                   color: AppColors.errorColor),
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],

//                   // ── "Add session notes" amber hint for completed cards ──
//                   if (appt.isCompleted) ...[
//                     SizedBox(height: size.customHeight(context) * 0.01),
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 10, vertical: 8),
//                       decoration: BoxDecoration(
//                         color: AppColors.warningColor.withOpacity(0.07),
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(
//                             color: AppColors.warningColor.withOpacity(0.35)),
//                       ),
//                       child: Row(
//                         children: [
//                           const Icon(Icons.edit_note_rounded,
//                               size: 14, color: AppColors.warningColor),
//                           const SizedBox(width: 6),
//                           Expanded(
//                             child: Text(
//                               'Tap to view or add session notes',
//                               style: GoogleFonts.poppins(
//                                   fontSize: 11.5,
//                                   color: AppColors.warningColor,
//                                   fontWeight: FontWeight.w500),
//                             ),
//                           ),
//                           const Icon(Icons.arrow_forward_ios_rounded,
//                               size: 10, color: AppColors.warningColor),
//                         ],
//                       ),
//                     ),
//                   ],

//                   // Chevron
//                   SizedBox(height: size.customHeight(context) * 0.008),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Text('View Details',
//                           style: GoogleFonts.poppins(
//                               fontSize: 11,
//                               color: AppColors.primaryColor,
//                               fontWeight: FontWeight.w500)),
//                       const SizedBox(width: 3),
//                       const Icon(Icons.arrow_forward_ios_rounded,
//                           size: 11, color: AppColors.primaryColor),
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

//   Widget _childAvatar(String initials, double size) {
//     return Container(
//       width: size,
//       height: size,
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [AppColors.primaryColor, AppColors.secondaryColor],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(14),
//       ),
//       child: Center(
//         child: Text(initials,
//             style: GoogleFonts.poppins(
//                 color: Colors.white,
//                 fontSize: size * 0.32,
//                 fontWeight: FontWeight.bold)),
//       ),
//     );
//   }

//   Widget _statusBadge(_StatusMeta meta) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//       decoration: BoxDecoration(
//         color: meta.color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: meta.color.withOpacity(0.3)),
//       ),
//       child: Text(meta.label,
//           style: GoogleFonts.poppins(
//               fontSize: 10,
//               fontWeight: FontWeight.w600,
//               color: meta.color)),
//     );
//   }

//   Widget _infoChip(IconData icon, String label, Color color) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Icon(icon, size: 13, color: color),
//         const SizedBox(width: 4),
//         Text(label,
//             style: GoogleFonts.poppins(
//                 fontSize: 11.5,
//                 color: AppColors.textSecondaryColor,
//                 fontWeight: FontWeight.w500)),
//       ],
//     );
//   }

//   Widget _buildLoader(BuildContext context, CustomSize size) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const CircularProgressIndicator(
//               color: AppColors.primaryColor, strokeWidth: 3),
//           SizedBox(height: size.customHeight(context) * 0.02),
//           Text('Loading appointments...',
//               style: GoogleFonts.poppins(
//                   color: AppColors.textSecondaryColor, fontSize: 14)),
//         ],
//       ),
//     );
//   }

//   Widget _buildEmpty(BuildContext context, CustomSize size) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             width: 100,
//             height: 100,
//             decoration: BoxDecoration(
//                 color: AppColors.primaryColor.withOpacity(0.07),
//                 shape: BoxShape.circle),
//             child: const Icon(Icons.event_busy_outlined,
//                 size: 48, color: AppColors.primaryColor),
//           ),
//           SizedBox(height: size.customHeight(context) * 0.022),
//           Text('No Appointments Found',
//               style: GoogleFonts.poppins(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.textPrimaryColor)),
//           const SizedBox(height: 6),
//           Text('Nothing to show in this category',
//               style: GoogleFonts.poppins(
//                   fontSize: 13, color: AppColors.textSecondaryColor)),
//         ],
//       ),
//     );
//   }

//   _StatusMeta _getStatusMeta(String status) {
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

// lib/view/expert/appointments/my_appointments_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import 'package:speechspectrum/controllers/my_appointment_controller.dart';
import 'package:speechspectrum/models/my_appointment_model.dart';
import 'package:speechspectrum/routes/app_routes.dart';

class MyAppointmentsScreen extends StatefulWidget {
  const MyAppointmentsScreen({super.key});

  @override
  State<MyAppointmentsScreen> createState() => _MyAppointmentsScreenState();
}

class _MyAppointmentsScreenState extends State<MyAppointmentsScreen>
    with SingleTickerProviderStateMixin {
  late final MyAppointmentController _c;
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
    _c = Get.isRegistered<MyAppointmentController>()
        ? Get.find<MyAppointmentController>()
        : Get.put(MyAppointmentController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _c.fetchMyAppointments();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // When we return from AppointmentDetailScreen, jump to the right tab
    final idx = _c.pendingTabIndex.value;
    if (idx != null) {
      _c.pendingTabIndex.value = null; // consume so it doesn't fire again
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _tab.animateTo(idx);
      });
    }
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
        title: Text(
          'My Appointments',
          style: GoogleFonts.poppins(
              color: AppColors.textPrimaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
        actions: [
          Obx(() => _c.isLoading.value
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
                  icon: const Icon(Icons.refresh_rounded,
                      color: AppColors.primaryColor),
                  onPressed: _c.fetchMyAppointments,
                )),
          const SizedBox(width: 4),
        ],
        bottom: TabBar(
          controller: _tab,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          labelColor: AppColors.primaryColor,
          unselectedLabelColor: AppColors.textSecondaryColor,
          indicatorColor: AppColors.primaryColor,
          indicatorWeight: 3,
          labelPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
          labelStyle:
              GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12.5),
          unselectedLabelStyle:
              GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 12.5),
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
        if (_c.isLoading.value && _c.appointments.isEmpty) {
          return _buildLoader(context, size);
        }
        return TabBarView(
          controller: _tab,
          children: [
            _buildList(context, size, _c.allAppointments),
            _buildList(context, size, _c.scheduledList),
            _buildList(context, size, _c.confirmedList),
            _buildList(context, size, _c.completedList),
            _buildList(context, size, _c.cancelledList),
            _buildList(context, size, _c.noShowList),
          ],
        );
      }),
    );
  }

  Widget _buildList(
      BuildContext context, CustomSize size, List<MyAppointmentItem> list) {
    if (list.isEmpty) return _buildEmpty(context, size);
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
        itemCount: list.length,
        itemBuilder: (_, i) => _appointmentCard(context, size, list[i]),
      ),
    );
  }

  Widget _appointmentCard(
      BuildContext context, CustomSize size, MyAppointmentItem appt) {
    final meta = _getStatusMeta(appt.status);

    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppRoutes.myAppointmentDetail,
          arguments: {
            'appointmentId': appt.appointmentId,
            'childName': appt.children?.childName ?? '',
            'expertName': appt.expertUsers?.fullName ?? '',
            'specialization': appt.expertUsers?.specialization ?? '',
            'childInitials': appt.childInitials,
            'status': appt.status,
          },
        );
      },
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
            // Colored top strip
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
                  // Row: avatar + info + badge
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _childAvatar(appt.childInitials, 50),
                      SizedBox(width: size.customWidth(context) * 0.03),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              appt.children?.childName ?? 'Unknown Child',
                              style: GoogleFonts.poppins(
                                  fontSize: size.customWidth(context) * 0.038,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimaryColor),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              appt.expertUsers?.fullName ?? '',
                              style: GoogleFonts.poppins(
                                  fontSize: size.customWidth(context) * 0.03,
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w500),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              appt.expertUsers?.specialization ?? '',
                              style: GoogleFonts.poppins(
                                  fontSize: size.customWidth(context) * 0.028,
                                  color: AppColors.textSecondaryColor),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      _statusBadge(meta),
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
                      _infoChip(Icons.calendar_today_outlined,
                          appt.formattedDate, AppColors.primaryColor),
                      _infoChip(Icons.access_time_rounded, appt.formattedTime,
                          AppColors.secondaryColor),
                      _infoChip(
                          _modeIcon(appt.bookedMode),
                          appt.bookedMode[0].toUpperCase() +
                              appt.bookedMode.substring(1),
                          AppColors.accentColor),
                      _infoChip(
                          Icons.payments_outlined,
                          '${appt.currency} ${appt.feeCharged.toStringAsFixed(0)}',
                          AppColors.warningColor),
                    ],
                  ),
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
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline_rounded,
                              size: 13, color: AppColors.errorColor),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              'Reason: ${appt.cancellationReason}',
                              style: GoogleFonts.poppins(
                                  fontSize: 11.5,
                                  color: AppColors.errorColor),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  // ── "Add session notes" amber hint for completed cards ──
                  if (appt.isCompleted) ...[
                    SizedBox(height: size.customHeight(context) * 0.01),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.warningColor.withOpacity(0.07),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: AppColors.warningColor.withOpacity(0.35)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.edit_note_rounded,
                              size: 14, color: AppColors.warningColor),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              'Tap to view or add session notes',
                              style: GoogleFonts.poppins(
                                  fontSize: 11.5,
                                  color: AppColors.warningColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios_rounded,
                              size: 10, color: AppColors.warningColor),
                        ],
                      ),
                    ),
                  ],

                  // Chevron
                  SizedBox(height: size.customHeight(context) * 0.008),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('View Details',
                          style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w500)),
                      const SizedBox(width: 3),
                      const Icon(Icons.arrow_forward_ios_rounded,
                          size: 11, color: AppColors.primaryColor),
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

  Widget _childAvatar(String initials, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primaryColor, AppColors.secondaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Center(
        child: Text(initials,
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: size * 0.32,
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _statusBadge(_StatusMeta meta) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: meta.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: meta.color.withOpacity(0.3)),
      ),
      child: Text(meta.label,
          style: GoogleFonts.poppins(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: meta.color)),
    );
  }

  Widget _infoChip(IconData icon, String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: color),
        const SizedBox(width: 4),
        Text(label,
            style: GoogleFonts.poppins(
                fontSize: 11.5,
                color: AppColors.textSecondaryColor,
                fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildLoader(BuildContext context, CustomSize size) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
              color: AppColors.primaryColor, strokeWidth: 3),
          SizedBox(height: size.customHeight(context) * 0.02),
          Text('Loading appointments...',
              style: GoogleFonts.poppins(
                  color: AppColors.textSecondaryColor, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildEmpty(BuildContext context, CustomSize size) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.07),
                shape: BoxShape.circle),
            child: const Icon(Icons.event_busy_outlined,
                size: 48, color: AppColors.primaryColor),
          ),
          SizedBox(height: size.customHeight(context) * 0.022),
          Text('No Appointments Found',
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryColor)),
          const SizedBox(height: 6),
          Text('Nothing to show in this category',
              style: GoogleFonts.poppins(
                  fontSize: 13, color: AppColors.textSecondaryColor)),
        ],
      ),
    );
  }

  _StatusMeta _getStatusMeta(String status) {
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

class _StatusMeta {
  final Color color;
  final String label;
  _StatusMeta(this.color, this.label);
}