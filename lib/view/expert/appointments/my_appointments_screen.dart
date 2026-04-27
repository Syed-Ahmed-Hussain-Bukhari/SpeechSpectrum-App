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
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     // When we return from AppointmentDetailScreen, jump to the right tab
//     final idx = _c.pendingTabIndex.value;
//     if (idx != null) {
//       _c.pendingTabIndex.value = null; // consume so it doesn't fire again
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         if (mounted) _tab.animateTo(idx);
//       });
//     }
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
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     final idx = _c.pendingTabIndex.value;
//     if (idx != null) {
//       _c.pendingTabIndex.value = null;
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         if (mounted) _tab.animateTo(idx);
//       });
//     }
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
//                   // ── Header row ──────────────────────────────
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
//                       // Status badge + payment badge stacked
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           _statusBadge(meta),
//                           // Payment badge — only on Scheduled cards
//                           if (appt.isScheduled) ...[
//                             const SizedBox(height: 4),
//                             _paymentBadgeSmall(appt.isPaid),
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

//                   // ── SCHEDULED: Payment status highlight ──────
//                   if (appt.isScheduled) ...[
//                     SizedBox(height: size.customHeight(context) * 0.01),
//                     _paymentHighlightBanner(appt.isPaid),
//                   ],

//                   // ── CONFIRMED: Meeting link banner ────────────
//                   if (appt.isConfirmed &&
//                       appt.meetLink != null &&
//                       appt.meetLink!.isNotEmpty) ...[
//                     SizedBox(height: size.customHeight(context) * 0.01),
//                     _meetLinkBanner(appt.meetLink!),
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

//                   // Completed hint
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

//   // ── Small payment badge shown in card header ───────────────
//   Widget _paymentBadgeSmall(bool isPaid) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//       decoration: BoxDecoration(
//         color: isPaid
//             ? AppColors.successColor.withOpacity(0.12)
//             : AppColors.warningColor.withOpacity(0.12),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(
//           color: isPaid
//               ? AppColors.successColor.withOpacity(0.4)
//               : AppColors.warningColor.withOpacity(0.4),
//         ),
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

//   // ── Payment highlight banner inside card body (Scheduled only) ─
//   Widget _paymentHighlightBanner(bool isPaid) {
//     if (isPaid) {
//       return Container(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//         decoration: BoxDecoration(
//           color: AppColors.successColor.withOpacity(0.07),
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(
//               color: AppColors.successColor.withOpacity(0.3), width: 1),
//         ),
//         child: Row(
//           children: [
//             const Icon(Icons.check_circle_rounded,
//                 color: AppColors.successColor, size: 15),
//             const SizedBox(width: 7),
//             Text(
//               'Payment complete',
//               style: GoogleFonts.poppins(
//                   fontSize: 12,
//                   color: AppColors.successColor,
//                   fontWeight: FontWeight.w600),
//             ),
//           ],
//         ),
//       );
//     }

//     // Pending — amber warning (no button, just info for the expert)
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//       decoration: BoxDecoration(
//         color: AppColors.warningColor.withOpacity(0.07),
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(
//             color: AppColors.warningColor.withOpacity(0.4), width: 1),
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.warning_amber_rounded,
//               color: AppColors.warningColor, size: 15),
//           const SizedBox(width: 7),
//           Expanded(
//             child: Text(
//               'Payment pending — patient has not paid yet',
//               style: GoogleFonts.poppins(
//                   fontSize: 11.5,
//                   color: AppColors.warningColor,
//                   fontWeight: FontWeight.w500),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ── Meeting link banner (Confirmed cards only) ─────────────
//   Widget _meetLinkBanner(String url) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//       decoration: BoxDecoration(
//         color: const Color(0xFF2196F3).withOpacity(0.07),
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(
//             color: const Color(0xFF2196F3).withOpacity(0.3), width: 1),
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.videocam_rounded,
//               color: Color(0xFF2196F3), size: 15),
//           const SizedBox(width: 7),
//           Expanded(
//             child: Text(
//               'Meeting link available — tap card to view',
//               style: GoogleFonts.poppins(
//                   fontSize: 11.5,
//                   color: const Color(0xFF2196F3),
//                   fontWeight: FontWeight.w500),
//             ),
//           ),
//           const Icon(Icons.arrow_forward_ios_rounded,
//               size: 10, color: Color(0xFF2196F3)),
//         ],
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


// // lib/view/expert/appointments/my_appointments_screen.dart
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
// import 'package:speechspectrum/controllers/my_appointment_controller.dart';
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
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     final idx = _c.pendingTabIndex.value;
//     if (idx != null) {
//       _c.pendingTabIndex.value = null;
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         if (mounted) _tab.animateTo(idx);
//       });
//     }
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
//                   // ── Header row ──────────────────────────────
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
//                       // Status badge + payment badge stacked
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           _statusBadge(meta),
//                           // Payment badge — only on Scheduled cards
//                           if (appt.isScheduled) ...[
//                             const SizedBox(height: 4),
//                             _paymentBadgeSmall(appt.isPaid),
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

//                   // ── SCHEDULED: Payment status highlight ──────
//                   if (appt.isScheduled) ...[
//                     SizedBox(height: size.customHeight(context) * 0.01),
//                     _paymentHighlightBanner(appt.isPaid),
//                   ],

//                   // ── CONFIRMED: Meeting link banner — TAPPABLE ─
//                   if (appt.isConfirmed &&
//                       appt.meetLink != null &&
//                       appt.meetLink!.isNotEmpty) ...[
//                     SizedBox(height: size.customHeight(context) * 0.01),
//                     _meetLinkBanner(context, appt.meetLink!),
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

//                   // Completed hint
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

//   // ── Small payment badge shown in card header ───────────────
//   Widget _paymentBadgeSmall(bool isPaid) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//       decoration: BoxDecoration(
//         color: isPaid
//             ? AppColors.successColor.withOpacity(0.12)
//             : AppColors.warningColor.withOpacity(0.12),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(
//           color: isPaid
//               ? AppColors.successColor.withOpacity(0.4)
//               : AppColors.warningColor.withOpacity(0.4),
//         ),
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

//   // ── Payment highlight banner inside card body (Scheduled only) ─
//   Widget _paymentHighlightBanner(bool isPaid) {
//     if (isPaid) {
//       return Container(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//         decoration: BoxDecoration(
//           color: AppColors.successColor.withOpacity(0.07),
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(
//               color: AppColors.successColor.withOpacity(0.3), width: 1),
//         ),
//         child: Row(
//           children: [
//             const Icon(Icons.check_circle_rounded,
//                 color: AppColors.successColor, size: 15),
//             const SizedBox(width: 7),
//             Text(
//               'Payment complete',
//               style: GoogleFonts.poppins(
//                   fontSize: 12,
//                   color: AppColors.successColor,
//                   fontWeight: FontWeight.w600),
//             ),
//           ],
//         ),
//       );
//     }

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//       decoration: BoxDecoration(
//         color: AppColors.warningColor.withOpacity(0.07),
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(
//             color: AppColors.warningColor.withOpacity(0.4), width: 1),
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.warning_amber_rounded,
//               color: AppColors.warningColor, size: 15),
//           const SizedBox(width: 7),
//           Expanded(
//             child: Text(
//               'Payment pending — patient has not paid yet',
//               style: GoogleFonts.poppins(
//                   fontSize: 11.5,
//                   color: AppColors.warningColor,
//                   fontWeight: FontWeight.w500),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ── Meeting link banner (Confirmed cards) — NOW TAPPABLE ───
//   Widget _meetLinkBanner(BuildContext context, String url) {
//     return GestureDetector(
//       // Stop the card's onTap from firing so we open the link directly
//       onTap: () {
//         // Prevent event bubbling to card GestureDetector
//         _openUrl(url);
//       },
//       behavior: HitTestBehavior.opaque,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//         decoration: BoxDecoration(
//           color: const Color(0xFF2196F3).withOpacity(0.07),
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(
//               color: const Color(0xFF2196F3).withOpacity(0.3), width: 1),
//         ),
//         child: Row(
//           children: [
//             const Icon(Icons.videocam_rounded,
//                 color: Color(0xFF2196F3), size: 15),
//             const SizedBox(width: 7),
//             Expanded(
//               child: Text(
//                 'Tap to join meeting',
//                 style: GoogleFonts.poppins(
//                     fontSize: 11.5,
//                     color: const Color(0xFF2196F3),
//                     fontWeight: FontWeight.w600),
//               ),
//             ),
//             // Copy icon
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
//               child: const Padding(
//                 padding: EdgeInsets.only(right: 6),
//                 child: Icon(Icons.copy_outlined,
//                     size: 13, color: Color(0xFF2196F3)),
//               ),
//             ),
//             const Icon(Icons.open_in_new_rounded,
//                 size: 13, color: Color(0xFF2196F3)),
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


// // lib/view/expert/appointments/my_appointments_screen.dart
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
// import 'package:speechspectrum/controllers/my_appointment_controller.dart';
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
//     } catch (_) {}
//   }
//   if (await canLaunchUrl(uri)) {
//     await launchUrl(uri, mode: LaunchMode.externalApplication);
//   } else {
//     await launchUrl(uri, mode: LaunchMode.platformDefault);
//   }
// }

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
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     final idx = _c.pendingTabIndex.value;
//     if (idx != null) {
//       _c.pendingTabIndex.value = null;
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         if (mounted) _tab.animateTo(idx);
//       });
//     }
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
//                   // ── Header row ──────────────────────────────
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
//                       // Status badge — payment badge ONLY for confirmed
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           _statusBadge(meta),
//                           if (appt.isConfirmed) ...[
//                             const SizedBox(height: 4),
//                             _paymentBadgeSmall(appt.isPaid),
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

//                   // ── CONFIRMED ONLY: payment banner inside card body ──
//                   if (appt.isConfirmed) ...[
//                     SizedBox(height: size.customHeight(context) * 0.01),
//                     _paymentHighlightBanner(appt.isPaid),
//                   ],

//                   // ── CONFIRMED: Meeting link banner ────────────────────
//                   if (appt.isConfirmed &&
//                       appt.meetLink != null &&
//                       appt.meetLink!.isNotEmpty) ...[
//                     SizedBox(height: size.customHeight(context) * 0.01),
//                     _meetLinkBanner(context, appt.meetLink!),
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

//                   // Completed hint
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

//   // ── Payment badge — shown only on Confirmed cards ──────────
//   Widget _paymentBadgeSmall(bool isPaid) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//       decoration: BoxDecoration(
//         color: isPaid
//             ? AppColors.successColor.withOpacity(0.12)
//             : AppColors.warningColor.withOpacity(0.12),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(
//           color: isPaid
//               ? AppColors.successColor.withOpacity(0.4)
//               : AppColors.warningColor.withOpacity(0.4),
//         ),
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

//   // ── Payment banner inside card body — Confirmed only ──────
//   Widget _paymentHighlightBanner(bool isPaid) {
//     if (isPaid) {
//       return Container(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//         decoration: BoxDecoration(
//           color: AppColors.successColor.withOpacity(0.07),
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(
//               color: AppColors.successColor.withOpacity(0.3), width: 1),
//         ),
//         child: Row(
//           children: [
//             const Icon(Icons.check_circle_rounded,
//                 color: AppColors.successColor, size: 15),
//             const SizedBox(width: 7),
//             Text(
//               'Payment complete',
//               style: GoogleFonts.poppins(
//                   fontSize: 12,
//                   color: AppColors.successColor,
//                   fontWeight: FontWeight.w600),
//             ),
//           ],
//         ),
//       );
//     }

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//       decoration: BoxDecoration(
//         color: AppColors.warningColor.withOpacity(0.07),
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(
//             color: AppColors.warningColor.withOpacity(0.4), width: 1),
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.warning_amber_rounded,
//               color: AppColors.warningColor, size: 15),
//           const SizedBox(width: 7),
//           Expanded(
//             child: Text(
//               'Payment pending — patient has not paid yet',
//               style: GoogleFonts.poppins(
//                   fontSize: 11.5,
//                   color: AppColors.warningColor,
//                   fontWeight: FontWeight.w500),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ── Meeting link banner — Confirmed cards only ─────────────
//   Widget _meetLinkBanner(BuildContext context, String url) {
//     return GestureDetector(
//       onTap: () => _openUrl(url),
//       behavior: HitTestBehavior.opaque,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//         decoration: BoxDecoration(
//           color: const Color(0xFF2196F3).withOpacity(0.07),
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(
//               color: const Color(0xFF2196F3).withOpacity(0.3), width: 1),
//         ),
//         child: Row(
//           children: [
//             const Icon(Icons.videocam_rounded,
//                 color: Color(0xFF2196F3), size: 15),
//             const SizedBox(width: 7),
//             Expanded(
//               child: Text(
//                 'Tap to join meeting',
//                 style: GoogleFonts.poppins(
//                     fontSize: 11.5,
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
//               child: const Padding(
//                 padding: EdgeInsets.only(right: 6),
//                 child: Icon(Icons.copy_outlined,
//                     size: 13, color: Color(0xFF2196F3)),
//               ),
//             ),
//             const Icon(Icons.open_in_new_rounded,
//                 size: 13, color: Color(0xFF2196F3)),
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

// // lib/view/expert/appointments/my_appointments_screen.dart
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
// import 'package:speechspectrum/controllers/my_appointment_controller.dart';
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
//     } catch (_) {}
//   }
//   if (await canLaunchUrl(uri)) {
//     await launchUrl(uri, mode: LaunchMode.externalApplication);
//   } else {
//     await launchUrl(uri, mode: LaunchMode.platformDefault);
//   }
// }

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
//     ('Requested', Icons.schedule_rounded),       // ← label only changed
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
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     final idx = _c.pendingTabIndex.value;
//     if (idx != null) {
//       _c.pendingTabIndex.value = null;
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         if (mounted) _tab.animateTo(idx);
//       });
//     }
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
//                   // ── Header row ──────────────────────────────
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
//                       // Status badge — payment badge ONLY for confirmed
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           _statusBadge(meta),
//                           if (appt.isConfirmed) ...[
//                             const SizedBox(height: 4),
//                             _paymentBadgeSmall(appt.isPaid),
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

//                   // ── CONFIRMED ONLY: payment banner inside card body ──
//                   if (appt.isConfirmed) ...[
//                     SizedBox(height: size.customHeight(context) * 0.01),
//                     _paymentHighlightBanner(appt.isPaid),
//                   ],

//                   // ── CONFIRMED: Meeting link banner ────────────────────
//                   if (appt.isConfirmed &&
//                       appt.meetLink != null &&
//                       appt.meetLink!.isNotEmpty) ...[
//                     SizedBox(height: size.customHeight(context) * 0.01),
//                     _meetLinkBanner(context, appt.meetLink!),
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

//                   // Completed hint
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

//   // ── Payment badge — shown only on Confirmed cards ──────────
//   Widget _paymentBadgeSmall(bool isPaid) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//       decoration: BoxDecoration(
//         color: isPaid
//             ? AppColors.successColor.withOpacity(0.12)
//             : AppColors.warningColor.withOpacity(0.12),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(
//           color: isPaid
//               ? AppColors.successColor.withOpacity(0.4)
//               : AppColors.warningColor.withOpacity(0.4),
//         ),
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

//   // ── Payment banner inside card body — Confirmed only ──────
//   Widget _paymentHighlightBanner(bool isPaid) {
//     if (isPaid) {
//       return Container(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//         decoration: BoxDecoration(
//           color: AppColors.successColor.withOpacity(0.07),
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(
//               color: AppColors.successColor.withOpacity(0.3), width: 1),
//         ),
//         child: Row(
//           children: [
//             const Icon(Icons.check_circle_rounded,
//                 color: AppColors.successColor, size: 15),
//             const SizedBox(width: 7),
//             Text(
//               'Payment complete',
//               style: GoogleFonts.poppins(
//                   fontSize: 12,
//                   color: AppColors.successColor,
//                   fontWeight: FontWeight.w600),
//             ),
//           ],
//         ),
//       );
//     }

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//       decoration: BoxDecoration(
//         color: AppColors.warningColor.withOpacity(0.07),
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(
//             color: AppColors.warningColor.withOpacity(0.4), width: 1),
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.warning_amber_rounded,
//               color: AppColors.warningColor, size: 15),
//           const SizedBox(width: 7),
//           Expanded(
//             child: Text(
//               'Payment pending — patient has not paid yet',
//               style: GoogleFonts.poppins(
//                   fontSize: 11.5,
//                   color: AppColors.warningColor,
//                   fontWeight: FontWeight.w500),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ── Meeting link banner — Confirmed cards only ─────────────
//   Widget _meetLinkBanner(BuildContext context, String url) {
//     return GestureDetector(
//       onTap: () => _openUrl(url),
//       behavior: HitTestBehavior.opaque,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//         decoration: BoxDecoration(
//           color: const Color(0xFF2196F3).withOpacity(0.07),
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(
//               color: const Color(0xFF2196F3).withOpacity(0.3), width: 1),
//         ),
//         child: Row(
//           children: [
//             const Icon(Icons.videocam_rounded,
//                 color: Color(0xFF2196F3), size: 15),
//             const SizedBox(width: 7),
//             Expanded(
//               child: Text(
//                 'Tap to join meeting',
//                 style: GoogleFonts.poppins(
//                     fontSize: 11.5,
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
//               child: const Padding(
//                 padding: EdgeInsets.only(right: 6),
//                 child: Icon(Icons.copy_outlined,
//                     size: 13, color: Color(0xFF2196F3)),
//               ),
//             ),
//             const Icon(Icons.open_in_new_rounded,
//                 size: 13, color: Color(0xFF2196F3)),
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
//         return _StatusMeta(AppColors.warningColor, 'Requested'); // ← label only
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


// // lib/view/expert/appointments/my_appointments_screen.dart
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
// import 'package:speechspectrum/controllers/my_appointment_controller.dart';
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
//     } catch (_) {}
//   }
//   if (await canLaunchUrl(uri)) {
//     await launchUrl(uri, mode: LaunchMode.externalApplication);
//   } else {
//     await launchUrl(uri, mode: LaunchMode.platformDefault);
//   }
// }

// class MyAppointmentsScreen extends StatefulWidget {
//   const MyAppointmentsScreen({super.key});

//   @override
//   State<MyAppointmentsScreen> createState() => _MyAppointmentsScreenState();
// }

// class _MyAppointmentsScreenState extends State<MyAppointmentsScreen>
//     with SingleTickerProviderStateMixin {
//   late final MyAppointmentController _c;
//   late final TabController _tab;

//   // Tab index constants — keep in sync with pendingTabIndex usage
//   static const int _kTabAll = 0;
//   static const int _kTabRequested = 1;
//   static const int _kTabConfirmed = 2;
//   static const int _kTabCompleted = 3;
//   static const int _kTabCancelled = 4;
//   static const int _kTabNoShow = 5;
//   static const int _kTabExpired = 6;

//   static const _tabs = [
//     ('All', Icons.list_alt_rounded),
//     ('Requested', Icons.schedule_rounded),
//     ('Confirmed', Icons.check_circle_outline_rounded),
//     ('Completed', Icons.task_alt_rounded),
//     ('Cancelled', Icons.cancel_outlined),
//     ('No Show', Icons.person_off_outlined),
//     ('Expired', Icons.timer_off_outlined),
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
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     final idx = _c.pendingTabIndex.value;
//     if (idx != null) {
//       _c.pendingTabIndex.value = null;
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         if (mounted) _tab.animateTo(idx);
//       });
//     }
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
//                         // Give Expired tab a distinct orange-red colour hint
//                         Icon(
//                           t.$2,
//                           size: 14,
//                           color: t.$1 == 'Expired'
//                               ? const Color(0xFFE65100)
//                               : null,
//                         ),
//                         const SizedBox(width: 5),
//                         Text(
//                           t.$1,
//                           style: t.$1 == 'Expired'
//                               ? GoogleFonts.poppins(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 12.5,
//                                   color: const Color(0xFFE65100))
//                               : null,
//                         ),
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
//             _buildList(context, size, _c.scheduledList, showDateBadge: true),
//             _buildList(context, size, _c.confirmedList),
//             _buildList(context, size, _c.completedList),
//             _buildList(context, size, _c.cancelledList),
//             _buildList(context, size, _c.noShowList),
//             _buildExpiredList(context, size, _c.expiredList),
//           ],
//         );
//       }),
//     );
//   }

//   // ── List builders ──────────────────────────────────────────

//   Widget _buildList(
//     BuildContext context,
//     CustomSize size,
//     List<MyAppointmentItem> list, {
//     bool showDateBadge = false,
//   }) {
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
//         itemBuilder: (_, i) =>
//             _appointmentCard(context, size, list[i], showDateBadge: showDateBadge),
//       ),
//     );
//   }

//   Widget _buildExpiredList(
//     BuildContext context,
//     CustomSize size,
//     List<MyAppointmentItem> list,
//   ) {
//     if (list.isEmpty) {
//       return _buildEmptyExpired(context, size);
//     }
//     return RefreshIndicator(
//       color: const Color(0xFFE65100),
//       onRefresh: _c.fetchMyAppointments,
//       child: ListView.builder(
//         padding: EdgeInsets.fromLTRB(
//           size.customWidth(context) * 0.045,
//           size.customHeight(context) * 0.02,
//           size.customWidth(context) * 0.045,
//           size.customHeight(context) * 0.04,
//         ),
//         itemCount: list.length + 1, // +1 for header banner
//         itemBuilder: (_, i) {
//           if (i == 0) return _buildExpiredBanner(context, size);
//           return _appointmentCard(context, size, list[i - 1],
//               forceExpired: true);
//         },
//       ),
//     );
//   }

//   Widget _buildExpiredBanner(BuildContext context, CustomSize size) {
//     return Container(
//       margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.016),
//       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//       decoration: BoxDecoration(
//         color: const Color(0xFFE65100).withOpacity(0.08),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: const Color(0xFFE65100).withOpacity(0.35)),
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.timer_off_outlined,
//               color: Color(0xFFE65100), size: 20),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Text(
//               'These appointments passed without being completed or cancelled. '
//               'You can still Cancel or mark No Show if needed.',
//               style: GoogleFonts.poppins(
//                   fontSize: 12,
//                   color: const Color(0xFFE65100),
//                   fontWeight: FontWeight.w500),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ── Appointment card ───────────────────────────────────────

//   Widget _appointmentCard(
//     BuildContext context,
//     CustomSize size,
//     MyAppointmentItem appt, {
//     bool showDateBadge = false,
//     bool forceExpired = false,
//   }) {
//     final bool isExpiredCard = forceExpired || appt.isExpired;
//     final meta = _getStatusMeta(appt.status, isExpired: isExpiredCard);

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
//             'isExpired': isExpiredCard,
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
//                   // ── Header row ────────────────────────────
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       _childAvatar(appt.childInitials, 50),
//                       SizedBox(width: size.customWidth(context) * 0.03),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // Date badge for Requested tab (shows upcoming date clearly)
//                             if (showDateBadge) ...[
//                               _upcomingDateBadge(appt),
//                               const SizedBox(height: 4),
//                             ],
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
//                       // Status badge + payment badge
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           _statusBadge(meta),
//                           if (appt.isConfirmed && !isExpiredCard) ...[
//                             const SizedBox(height: 4),
//                             _paymentBadgeSmall(appt.isPaid),
//                           ],
//                           if (isExpiredCard) ...[
//                             const SizedBox(height: 4),
//                             _expiredBadgeSmall(),
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

//                   // ── CONFIRMED (non-expired): payment banner ──
//                   if (appt.isConfirmed && !isExpiredCard) ...[
//                     SizedBox(height: size.customHeight(context) * 0.01),
//                     _paymentHighlightBanner(appt.isPaid),
//                   ],

//                   // ── CONFIRMED (non-expired): meeting link ────
//                   if (appt.isConfirmed &&
//                       !isExpiredCard &&
//                       appt.meetLink != null &&
//                       appt.meetLink!.isNotEmpty) ...[
//                     SizedBox(height: size.customHeight(context) * 0.01),
//                     _meetLinkBanner(context, appt.meetLink!),
//                   ],

//                   // ── EXPIRED: show expired meeting link hint ──
//                   if (isExpiredCard &&
//                       appt.meetLink != null &&
//                       appt.meetLink!.isNotEmpty) ...[
//                     SizedBox(height: size.customHeight(context) * 0.01),
//                     _meetLinkExpiredBanner(),
//                   ],

//                   // ── EXPIRED: action hint ─────────────────────
//                   if (isExpiredCard) ...[
//                     SizedBox(height: size.customHeight(context) * 0.01),
//                     _expiredActionHint(context, size),
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

//                   // Completed hint
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

//   // ── Upcoming date badge (Requested tab) ────────────────────
//   Widget _upcomingDateBadge(MyAppointmentItem appt) {
//     try {
//       final dt = DateTime.parse(appt.scheduledAt).toLocal();
//       final now = DateTime.now();
//       final diff = dt.difference(now);
//       String label;
//       if (diff.inDays == 0) {
//         label = 'Today';
//       } else if (diff.inDays == 1) {
//         label = 'Tomorrow';
//       } else if (diff.inDays <= 7) {
//         label = 'In ${diff.inDays} days';
//       } else {
//         const months = [
//           '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
//           'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
//         ];
//         label = '${dt.day} ${months[dt.month]}';
//       }
//       return Container(
//         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//         decoration: BoxDecoration(
//           color: AppColors.primaryColor.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Text(
//           label,
//           style: GoogleFonts.poppins(
//               fontSize: 10,
//               fontWeight: FontWeight.w600,
//               color: AppColors.primaryColor),
//         ),
//       );
//     } catch (_) {
//       return const SizedBox.shrink();
//     }
//   }

//   // ── Expired badge (small, on card header) ─────────────────
//   Widget _expiredBadgeSmall() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//       decoration: BoxDecoration(
//         color: const Color(0xFFE65100).withOpacity(0.12),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: const Color(0xFFE65100).withOpacity(0.4)),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const Icon(Icons.timer_off_outlined,
//               size: 9, color: Color(0xFFE65100)),
//           const SizedBox(width: 3),
//           Text(
//             'Expired',
//             style: GoogleFonts.poppins(
//                 fontSize: 9,
//                 fontWeight: FontWeight.w600,
//                 color: const Color(0xFFE65100)),
//           ),
//         ],
//       ),
//     );
//   }

//   // ── Expired meeting-link banner ────────────────────────────
//   Widget _meetLinkExpiredBanner() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//       decoration: BoxDecoration(
//         color: const Color(0xFFE65100).withOpacity(0.07),
//         borderRadius: BorderRadius.circular(10),
//         border:
//             Border.all(color: const Color(0xFFE65100).withOpacity(0.3), width: 1),
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.videocam_off_rounded,
//               color: Color(0xFFE65100), size: 15),
//           const SizedBox(width: 7),
//           Expanded(
//             child: Text(
//               'Meeting link expired — session time has passed',
//               style: GoogleFonts.poppins(
//                   fontSize: 11.5,
//                   color: const Color(0xFFE65100),
//                   fontWeight: FontWeight.w500),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ── Expired action hint ────────────────────────────────────
//   Widget _expiredActionHint(BuildContext context, CustomSize size) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//       decoration: BoxDecoration(
//         color: AppColors.greyColor.withOpacity(0.07),
//         borderRadius: BorderRadius.circular(10),
//         border:
//             Border.all(color: AppColors.greyColor.withOpacity(0.3), width: 1),
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.touch_app_outlined,
//               color: AppColors.textSecondaryColor, size: 14),
//           const SizedBox(width: 7),
//           Expanded(
//             child: Text(
//               'Tap to Cancel or mark No Show',
//               style: GoogleFonts.poppins(
//                   fontSize: 11.5,
//                   color: AppColors.textSecondaryColor,
//                   fontWeight: FontWeight.w500),
//             ),
//           ),
//           const Icon(Icons.arrow_forward_ios_rounded,
//               size: 10, color: AppColors.textSecondaryColor),
//         ],
//       ),
//     );
//   }

//   // ── Payment badge — shown only on Confirmed (non-expired) cards ──
//   Widget _paymentBadgeSmall(bool isPaid) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//       decoration: BoxDecoration(
//         color: isPaid
//             ? AppColors.successColor.withOpacity(0.12)
//             : AppColors.warningColor.withOpacity(0.12),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(
//           color: isPaid
//               ? AppColors.successColor.withOpacity(0.4)
//               : AppColors.warningColor.withOpacity(0.4),
//         ),
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

//   // ── Payment banner inside card body — Confirmed only ──────
//   Widget _paymentHighlightBanner(bool isPaid) {
//     if (isPaid) {
//       return Container(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//         decoration: BoxDecoration(
//           color: AppColors.successColor.withOpacity(0.07),
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(
//               color: AppColors.successColor.withOpacity(0.3), width: 1),
//         ),
//         child: Row(
//           children: [
//             const Icon(Icons.check_circle_rounded,
//                 color: AppColors.successColor, size: 15),
//             const SizedBox(width: 7),
//             Text(
//               'Payment complete',
//               style: GoogleFonts.poppins(
//                   fontSize: 12,
//                   color: AppColors.successColor,
//                   fontWeight: FontWeight.w600),
//             ),
//           ],
//         ),
//       );
//     }

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//       decoration: BoxDecoration(
//         color: AppColors.warningColor.withOpacity(0.07),
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(
//             color: AppColors.warningColor.withOpacity(0.4), width: 1),
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.warning_amber_rounded,
//               color: AppColors.warningColor, size: 15),
//           const SizedBox(width: 7),
//           Expanded(
//             child: Text(
//               'Payment pending — patient has not paid yet',
//               style: GoogleFonts.poppins(
//                   fontSize: 11.5,
//                   color: AppColors.warningColor,
//                   fontWeight: FontWeight.w500),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ── Meeting link banner — Confirmed (non-expired) cards ────
//   Widget _meetLinkBanner(BuildContext context, String url) {
//     return GestureDetector(
//       onTap: () => _openUrl(url),
//       behavior: HitTestBehavior.opaque,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//         decoration: BoxDecoration(
//           color: const Color(0xFF2196F3).withOpacity(0.07),
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(
//               color: const Color(0xFF2196F3).withOpacity(0.3), width: 1),
//         ),
//         child: Row(
//           children: [
//             const Icon(Icons.videocam_rounded,
//                 color: Color(0xFF2196F3), size: 15),
//             const SizedBox(width: 7),
//             Expanded(
//               child: Text(
//                 'Tap to join meeting',
//                 style: GoogleFonts.poppins(
//                     fontSize: 11.5,
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
//               child: const Padding(
//                 padding: EdgeInsets.only(right: 6),
//                 child: Icon(Icons.copy_outlined,
//                     size: 13, color: Color(0xFF2196F3)),
//               ),
//             ),
//             const Icon(Icons.open_in_new_rounded,
//                 size: 13, color: Color(0xFF2196F3)),
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

//   Widget _buildEmptyExpired(BuildContext context, CustomSize size) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             width: 100,
//             height: 100,
//             decoration: BoxDecoration(
//                 color: const Color(0xFFE65100).withOpacity(0.07),
//                 shape: BoxShape.circle),
//             child: const Icon(Icons.timer_off_outlined,
//                 size: 48, color: Color(0xFFE65100)),
//           ),
//           SizedBox(height: size.customHeight(context) * 0.022),
//           Text('No Expired Appointments',
//               style: GoogleFonts.poppins(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.textPrimaryColor)),
//           const SizedBox(height: 6),
//           Text('All appointments are up to date',
//               style: GoogleFonts.poppins(
//                   fontSize: 13, color: AppColors.textSecondaryColor)),
//         ],
//       ),
//     );
//   }

//   // ── Status meta — pass isExpired so the label/colour adjusts ──
//   _StatusMeta _getStatusMeta(String status, {bool isExpired = false}) {
//     if (isExpired) {
//       // Even if status is 'scheduled'/'confirmed', show as Expired
//       return _StatusMeta(const Color(0xFFE65100), 'Expired');
//     }
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
//         return _StatusMeta(AppColors.warningColor, 'Requested');
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


// // lib/view/expert/appointments/my_appointments_screen.dart
// // UPDATED — added "Child Profile" button on every appointment card
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
// import 'package:speechspectrum/controllers/my_appointment_controller.dart';
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
//     } catch (_) {}
//   }
//   if (await canLaunchUrl(uri)) {
//     await launchUrl(uri, mode: LaunchMode.externalApplication);
//   } else {
//     await launchUrl(uri, mode: LaunchMode.platformDefault);
//   }
// }

// class MyAppointmentsScreen extends StatefulWidget {
//   const MyAppointmentsScreen({super.key});

//   @override
//   State<MyAppointmentsScreen> createState() => _MyAppointmentsScreenState();
// }

// class _MyAppointmentsScreenState extends State<MyAppointmentsScreen>
//     with SingleTickerProviderStateMixin {
//   late final MyAppointmentController _c;
//   late final TabController _tab;

//   static const int _kTabAll = 0;
//   static const int _kTabRequested = 1;
//   static const int _kTabConfirmed = 2;
//   static const int _kTabCompleted = 3;
//   static const int _kTabCancelled = 4;
//   static const int _kTabNoShow = 5;
//   static const int _kTabExpired = 6;

//   static const _tabs = [
//     ('All', Icons.list_alt_rounded),
//     ('Requested', Icons.schedule_rounded),
//     ('Confirmed', Icons.check_circle_outline_rounded),
//     ('Completed', Icons.task_alt_rounded),
//     ('Cancelled', Icons.cancel_outlined),
//     ('No Show', Icons.person_off_outlined),
//     ('Expired', Icons.timer_off_outlined),
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
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     final idx = _c.pendingTabIndex.value;
//     if (idx != null) {
//       _c.pendingTabIndex.value = null;
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         if (mounted) _tab.animateTo(idx);
//       });
//     }
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
//                         Icon(
//                           t.$2,
//                           size: 14,
//                           color: t.$1 == 'Expired'
//                               ? const Color(0xFFE65100)
//                               : null,
//                         ),
//                         const SizedBox(width: 5),
//                         Text(
//                           t.$1,
//                           style: t.$1 == 'Expired'
//                               ? GoogleFonts.poppins(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 12.5,
//                                   color: const Color(0xFFE65100))
//                               : null,
//                         ),
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
//             _buildList(context, size, _c.scheduledList, showDateBadge: true),
//             _buildList(context, size, _c.confirmedList),
//             _buildList(context, size, _c.completedList),
//             _buildList(context, size, _c.cancelledList),
//             _buildList(context, size, _c.noShowList),
//             _buildExpiredList(context, size, _c.expiredList),
//           ],
//         );
//       }),
//     );
//   }

//   // ── List builders ──────────────────────────────────────────

//   Widget _buildList(
//     BuildContext context,
//     CustomSize size,
//     List<MyAppointmentItem> list, {
//     bool showDateBadge = false,
//   }) {
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
//         itemBuilder: (_, i) =>
//             _appointmentCard(context, size, list[i], showDateBadge: showDateBadge),
//       ),
//     );
//   }

//   Widget _buildExpiredList(
//     BuildContext context,
//     CustomSize size,
//     List<MyAppointmentItem> list,
//   ) {
//     if (list.isEmpty) {
//       return _buildEmptyExpired(context, size);
//     }
//     return RefreshIndicator(
//       color: const Color(0xFFE65100),
//       onRefresh: _c.fetchMyAppointments,
//       child: ListView.builder(
//         padding: EdgeInsets.fromLTRB(
//           size.customWidth(context) * 0.045,
//           size.customHeight(context) * 0.02,
//           size.customWidth(context) * 0.045,
//           size.customHeight(context) * 0.04,
//         ),
//         itemCount: list.length + 1,
//         itemBuilder: (_, i) {
//           if (i == 0) return _buildExpiredBanner(context, size);
//           return _appointmentCard(context, size, list[i - 1],
//               forceExpired: true);
//         },
//       ),
//     );
//   }

//   Widget _buildExpiredBanner(BuildContext context, CustomSize size) {
//     return Container(
//       margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.016),
//       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//       decoration: BoxDecoration(
//         color: const Color(0xFFE65100).withOpacity(0.08),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: const Color(0xFFE65100).withOpacity(0.35)),
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.timer_off_outlined,
//               color: Color(0xFFE65100), size: 20),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Text(
//               'These appointments passed without being completed or cancelled. '
//               'You can still Cancel or mark No Show if needed.',
//               style: GoogleFonts.poppins(
//                   fontSize: 12,
//                   color: const Color(0xFFE65100),
//                   fontWeight: FontWeight.w500),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ── Appointment card ───────────────────────────────────────

//   Widget _appointmentCard(
//     BuildContext context,
//     CustomSize size,
//     MyAppointmentItem appt, {
//     bool showDateBadge = false,
//     bool forceExpired = false,
//   }) {
//     final bool isExpiredCard = forceExpired || appt.isExpired;
//     final meta = _getStatusMeta(appt.status, isExpired: isExpiredCard);

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
//             'isExpired': isExpiredCard,
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
//                   // ── Header row ────────────────────────────
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       _childAvatar(appt.childInitials, 50),
//                       SizedBox(width: size.customWidth(context) * 0.03),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             if (showDateBadge) ...[
//                               _upcomingDateBadge(appt),
//                               const SizedBox(height: 4),
//                             ],
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
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           _statusBadge(meta),
//                           if (appt.isConfirmed && !isExpiredCard) ...[
//                             const SizedBox(height: 4),
//                             _paymentBadgeSmall(appt.isPaid),
//                           ],
//                           if (isExpiredCard) ...[
//                             const SizedBox(height: 4),
//                             _expiredBadgeSmall(),
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

//                   // Confirmed: payment banner
//                   if (appt.isConfirmed && !isExpiredCard) ...[
//                     SizedBox(height: size.customHeight(context) * 0.01),
//                     _paymentHighlightBanner(appt.isPaid),
//                   ],

//                   // Confirmed: meeting link
//                   if (appt.isConfirmed &&
//                       !isExpiredCard &&
//                       appt.meetLink != null &&
//                       appt.meetLink!.isNotEmpty) ...[
//                     SizedBox(height: size.customHeight(context) * 0.01),
//                     _meetLinkBanner(context, appt.meetLink!),
//                   ],

//                   // Expired: meeting link hint
//                   if (isExpiredCard &&
//                       appt.meetLink != null &&
//                       appt.meetLink!.isNotEmpty) ...[
//                     SizedBox(height: size.customHeight(context) * 0.01),
//                     _meetLinkExpiredBanner(),
//                   ],

//                   // Expired: action hint
//                   if (isExpiredCard) ...[
//                     SizedBox(height: size.customHeight(context) * 0.01),
//                     _expiredActionHint(context, size),
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

//                   // Completed hint
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

//                   SizedBox(height: size.customHeight(context) * 0.01),

//                   // ── BOTTOM ROW: Child Profile + View Details ──
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       // Child Profile button
//                       GestureDetector(
//                         onTap: () {
//                           // Stop card's own onTap from firing
//                           Get.toNamed(
//                             AppRoutes.childProfile,
//                             arguments: {
//                               'childId': appt.childId,
//                               'childName':
//                                   appt.children?.childName ?? '',
//                             },
//                           );
//                         },
//                         behavior: HitTestBehavior.opaque,
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 10, vertical: 5),
//                           decoration: BoxDecoration(
//                             color: AppColors.secondaryColor
//                                 .withOpacity(0.08),
//                             borderRadius: BorderRadius.circular(20),
//                             border: Border.all(
//                                 color: AppColors.secondaryColor
//                                     .withOpacity(0.3)),
//                           ),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               const Icon(Icons.child_care_rounded,
//                                   size: 12,
//                                   color: AppColors.secondaryColor),
//                               const SizedBox(width: 4),
//                               Text(
//                                 'Child Profile',
//                                 style: GoogleFonts.poppins(
//                                     fontSize: 11,
//                                     color: AppColors.secondaryColor,
//                                     fontWeight: FontWeight.w600),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),

//                       // View Details arrow
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

//   // ── All helper widgets below are IDENTICAL to original ─────

//   Widget _upcomingDateBadge(MyAppointmentItem appt) {
//     try {
//       final dt = DateTime.parse(appt.scheduledAt).toLocal();
//       final now = DateTime.now();
//       final diff = dt.difference(now);
//       String label;
//       if (diff.inDays == 0) {
//         label = 'Today';
//       } else if (diff.inDays == 1) {
//         label = 'Tomorrow';
//       } else if (diff.inDays <= 7) {
//         label = 'In ${diff.inDays} days';
//       } else {
//         const months = [
//           '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
//           'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
//         ];
//         label = '${dt.day} ${months[dt.month]}';
//       }
//       return Container(
//         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//         decoration: BoxDecoration(
//           color: AppColors.primaryColor.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Text(
//           label,
//           style: GoogleFonts.poppins(
//               fontSize: 10,
//               fontWeight: FontWeight.w600,
//               color: AppColors.primaryColor),
//         ),
//       );
//     } catch (_) {
//       return const SizedBox.shrink();
//     }
//   }

//   Widget _expiredBadgeSmall() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//       decoration: BoxDecoration(
//         color: const Color(0xFFE65100).withOpacity(0.12),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: const Color(0xFFE65100).withOpacity(0.4)),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const Icon(Icons.timer_off_outlined,
//               size: 9, color: Color(0xFFE65100)),
//           const SizedBox(width: 3),
//           Text(
//             'Expired',
//             style: GoogleFonts.poppins(
//                 fontSize: 9,
//                 fontWeight: FontWeight.w600,
//                 color: const Color(0xFFE65100)),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _meetLinkExpiredBanner() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//       decoration: BoxDecoration(
//         color: const Color(0xFFE65100).withOpacity(0.07),
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(
//             color: const Color(0xFFE65100).withOpacity(0.3), width: 1),
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.videocam_off_rounded,
//               color: Color(0xFFE65100), size: 15),
//           const SizedBox(width: 7),
//           Expanded(
//             child: Text(
//               'Meeting link expired — session time has passed',
//               style: GoogleFonts.poppins(
//                   fontSize: 11.5,
//                   color: const Color(0xFFE65100),
//                   fontWeight: FontWeight.w500),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _expiredActionHint(BuildContext context, CustomSize size) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//       decoration: BoxDecoration(
//         color: AppColors.greyColor.withOpacity(0.07),
//         borderRadius: BorderRadius.circular(10),
//         border:
//             Border.all(color: AppColors.greyColor.withOpacity(0.3), width: 1),
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.touch_app_outlined,
//               color: AppColors.textSecondaryColor, size: 14),
//           const SizedBox(width: 7),
//           Expanded(
//             child: Text(
//               'Tap to Cancel or mark No Show',
//               style: GoogleFonts.poppins(
//                   fontSize: 11.5,
//                   color: AppColors.textSecondaryColor,
//                   fontWeight: FontWeight.w500),
//             ),
//           ),
//           const Icon(Icons.arrow_forward_ios_rounded,
//               size: 10, color: AppColors.textSecondaryColor),
//         ],
//       ),
//     );
//   }

//   Widget _paymentBadgeSmall(bool isPaid) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//       decoration: BoxDecoration(
//         color: isPaid
//             ? AppColors.successColor.withOpacity(0.12)
//             : AppColors.warningColor.withOpacity(0.12),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(
//           color: isPaid
//               ? AppColors.successColor.withOpacity(0.4)
//               : AppColors.warningColor.withOpacity(0.4),
//         ),
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

//   Widget _paymentHighlightBanner(bool isPaid) {
//     if (isPaid) {
//       return Container(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//         decoration: BoxDecoration(
//           color: AppColors.successColor.withOpacity(0.07),
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(
//               color: AppColors.successColor.withOpacity(0.3), width: 1),
//         ),
//         child: Row(
//           children: [
//             const Icon(Icons.check_circle_rounded,
//                 color: AppColors.successColor, size: 15),
//             const SizedBox(width: 7),
//             Text(
//               'Payment complete',
//               style: GoogleFonts.poppins(
//                   fontSize: 12,
//                   color: AppColors.successColor,
//                   fontWeight: FontWeight.w600),
//             ),
//           ],
//         ),
//       );
//     }

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//       decoration: BoxDecoration(
//         color: AppColors.warningColor.withOpacity(0.07),
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(
//             color: AppColors.warningColor.withOpacity(0.4), width: 1),
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.warning_amber_rounded,
//               color: AppColors.warningColor, size: 15),
//           const SizedBox(width: 7),
//           Expanded(
//             child: Text(
//               'Payment pending — patient has not paid yet',
//               style: GoogleFonts.poppins(
//                   fontSize: 11.5,
//                   color: AppColors.warningColor,
//                   fontWeight: FontWeight.w500),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _meetLinkBanner(BuildContext context, String url) {
//     return GestureDetector(
//       onTap: () => _openUrl(url),
//       behavior: HitTestBehavior.opaque,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//         decoration: BoxDecoration(
//           color: const Color(0xFF2196F3).withOpacity(0.07),
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(
//               color: const Color(0xFF2196F3).withOpacity(0.3), width: 1),
//         ),
//         child: Row(
//           children: [
//             const Icon(Icons.videocam_rounded,
//                 color: Color(0xFF2196F3), size: 15),
//             const SizedBox(width: 7),
//             Expanded(
//               child: Text(
//                 'Tap to join meeting',
//                 style: GoogleFonts.poppins(
//                     fontSize: 11.5,
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
//               child: const Padding(
//                 padding: EdgeInsets.only(right: 6),
//                 child: Icon(Icons.copy_outlined,
//                     size: 13, color: Color(0xFF2196F3)),
//               ),
//             ),
//             const Icon(Icons.open_in_new_rounded,
//                 size: 13, color: Color(0xFF2196F3)),
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

//   Widget _buildEmptyExpired(BuildContext context, CustomSize size) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             width: 100,
//             height: 100,
//             decoration: BoxDecoration(
//                 color: const Color(0xFFE65100).withOpacity(0.07),
//                 shape: BoxShape.circle),
//             child: const Icon(Icons.timer_off_outlined,
//                 size: 48, color: Color(0xFFE65100)),
//           ),
//           SizedBox(height: size.customHeight(context) * 0.022),
//           Text('No Expired Appointments',
//               style: GoogleFonts.poppins(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.textPrimaryColor)),
//           const SizedBox(height: 6),
//           Text('All appointments are up to date',
//               style: GoogleFonts.poppins(
//                   fontSize: 13, color: AppColors.textSecondaryColor)),
//         ],
//       ),
//     );
//   }

//   _StatusMeta _getStatusMeta(String status, {bool isExpired = false}) {
//     if (isExpired) {
//       return _StatusMeta(const Color(0xFFE65100), 'Expired');
//     }
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
//         return _StatusMeta(AppColors.warningColor, 'Requested');
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


// // lib/view/expert/appointments/my_appointments_screen.dart
// // UPDATED — "View Child Profile" button only on Scheduled & Confirmed cards
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
// import 'package:speechspectrum/controllers/my_appointment_controller.dart';
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
//     } catch (_) {}
//   }
//   if (await canLaunchUrl(uri)) {
//     await launchUrl(uri, mode: LaunchMode.externalApplication);
//   } else {
//     await launchUrl(uri, mode: LaunchMode.platformDefault);
//   }
// }

// class MyAppointmentsScreen extends StatefulWidget {
//   const MyAppointmentsScreen({super.key});

//   @override
//   State<MyAppointmentsScreen> createState() => _MyAppointmentsScreenState();
// }

// class _MyAppointmentsScreenState extends State<MyAppointmentsScreen>
//     with SingleTickerProviderStateMixin {
//   late final MyAppointmentController _c;
//   late final TabController _tab;

//   static const int _kTabAll = 0;
//   static const int _kTabRequested = 1;
//   static const int _kTabConfirmed = 2;
//   static const int _kTabCompleted = 3;
//   static const int _kTabCancelled = 4;
//   static const int _kTabNoShow = 5;
//   static const int _kTabExpired = 6;

//   static const _tabs = [
//     ('All', Icons.list_alt_rounded),
//     ('Requested', Icons.schedule_rounded),
//     ('Confirmed', Icons.check_circle_outline_rounded),
//     ('Completed', Icons.task_alt_rounded),
//     ('Cancelled', Icons.cancel_outlined),
//     ('No Show', Icons.person_off_outlined),
//     ('Expired', Icons.timer_off_outlined),
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
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     final idx = _c.pendingTabIndex.value;
//     if (idx != null) {
//       _c.pendingTabIndex.value = null;
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         if (mounted) _tab.animateTo(idx);
//       });
//     }
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
//                         Icon(
//                           t.$2,
//                           size: 14,
//                           color: t.$1 == 'Expired'
//                               ? const Color(0xFFE65100)
//                               : null,
//                         ),
//                         const SizedBox(width: 5),
//                         Text(
//                           t.$1,
//                           style: t.$1 == 'Expired'
//                               ? GoogleFonts.poppins(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 12.5,
//                                   color: const Color(0xFFE65100))
//                               : null,
//                         ),
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
//             _buildList(context, size, _c.scheduledList,
//                 showDateBadge: true, showChildProfileBtn: true),
//             _buildList(context, size, _c.confirmedList,
//                 showChildProfileBtn: true),
//             _buildList(context, size, _c.completedList),
//             _buildList(context, size, _c.cancelledList),
//             _buildList(context, size, _c.noShowList),
//             _buildExpiredList(context, size, _c.expiredList),
//           ],
//         );
//       }),
//     );
//   }

//   // ── List builders ──────────────────────────────────────────────────────────

//   Widget _buildList(
//     BuildContext context,
//     CustomSize size,
//     List<MyAppointmentItem> list, {
//     bool showDateBadge = false,
//     bool showChildProfileBtn = false,
//   }) {
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
//         itemBuilder: (_, i) => _appointmentCard(
//           context,
//           size,
//           list[i],
//           showDateBadge: showDateBadge,
//           showChildProfileBtn: showChildProfileBtn,
//         ),
//       ),
//     );
//   }

//   Widget _buildExpiredList(
//     BuildContext context,
//     CustomSize size,
//     List<MyAppointmentItem> list,
//   ) {
//     if (list.isEmpty) {
//       return _buildEmptyExpired(context, size);
//     }
//     return RefreshIndicator(
//       color: const Color(0xFFE65100),
//       onRefresh: _c.fetchMyAppointments,
//       child: ListView.builder(
//         padding: EdgeInsets.fromLTRB(
//           size.customWidth(context) * 0.045,
//           size.customHeight(context) * 0.02,
//           size.customWidth(context) * 0.045,
//           size.customHeight(context) * 0.04,
//         ),
//         itemCount: list.length + 1,
//         itemBuilder: (_, i) {
//           if (i == 0) return _buildExpiredBanner(context, size);
//           return _appointmentCard(context, size, list[i - 1],
//               forceExpired: true);
//         },
//       ),
//     );
//   }

//   Widget _buildExpiredBanner(BuildContext context, CustomSize size) {
//     return Container(
//       margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.016),
//       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//       decoration: BoxDecoration(
//         color: const Color(0xFFE65100).withOpacity(0.08),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: const Color(0xFFE65100).withOpacity(0.35)),
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.timer_off_outlined,
//               color: Color(0xFFE65100), size: 20),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Text(
//               'These appointments passed without being completed or cancelled. '
//               'You can still Cancel or mark No Show if needed.',
//               style: GoogleFonts.poppins(
//                   fontSize: 12,
//                   color: const Color(0xFFE65100),
//                   fontWeight: FontWeight.w500),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ── Appointment card ───────────────────────────────────────────────────────

//   Widget _appointmentCard(
//     BuildContext context,
//     CustomSize size,
//     MyAppointmentItem appt, {
//     bool showDateBadge = false,
//     bool forceExpired = false,
//     bool showChildProfileBtn = false,
//   }) {
//     final bool isExpiredCard = forceExpired || appt.isExpired;
//     final meta = _getStatusMeta(appt.status, isExpired: isExpiredCard);

//     // Only show child profile for scheduled & confirmed (not expired)
//     final bool canViewChildProfile =
//         showChildProfileBtn && !isExpiredCard;

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
//             'isExpired': isExpiredCard,
//             'childId': appt.childId,
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
//                   // Header row
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       _childAvatar(appt.childInitials, 50),
//                       SizedBox(width: size.customWidth(context) * 0.03),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             if (showDateBadge) ...[
//                               _upcomingDateBadge(appt),
//                               const SizedBox(height: 4),
//                             ],
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
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           _statusBadge(meta),
//                           if (appt.isConfirmed && !isExpiredCard) ...[
//                             const SizedBox(height: 4),
//                             _paymentBadgeSmall(appt.isPaid),
//                           ],
//                           if (isExpiredCard) ...[
//                             const SizedBox(height: 4),
//                             _expiredBadgeSmall(),
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
//                       _infoChip(Icons.calendar_today_outlined,
//                           appt.formattedDate, AppColors.primaryColor),
//                       _infoChip(Icons.access_time_rounded,
//                           appt.formattedTime, AppColors.secondaryColor),
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

//                   // Confirmed: payment banner
//                   if (appt.isConfirmed && !isExpiredCard) ...[
//                     SizedBox(height: size.customHeight(context) * 0.01),
//                     _paymentHighlightBanner(appt.isPaid),
//                   ],

//                   // Confirmed: meeting link
//                   if (appt.isConfirmed &&
//                       !isExpiredCard &&
//                       appt.meetLink != null &&
//                       appt.meetLink!.isNotEmpty) ...[
//                     SizedBox(height: size.customHeight(context) * 0.01),
//                     _meetLinkBanner(context, appt.meetLink!),
//                   ],

//                   // Expired: meeting link hint
//                   if (isExpiredCard &&
//                       appt.meetLink != null &&
//                       appt.meetLink!.isNotEmpty) ...[
//                     SizedBox(height: size.customHeight(context) * 0.01),
//                     _meetLinkExpiredBanner(),
//                   ],

//                   // Expired: action hint
//                   if (isExpiredCard) ...[
//                     SizedBox(height: size.customHeight(context) * 0.01),
//                     _expiredActionHint(context, size),
//                   ],

//                   // Cancellation reason
//                   if (appt.isCancelled && appt.cancellationReason != null) ...[
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

//                   // Completed hint
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

//                   SizedBox(height: size.customHeight(context) * 0.01),

//                   // ── BOTTOM ROW ───────────────────────────────────────────
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       // Child Profile button — only for scheduled/confirmed
//                       if (canViewChildProfile)
//                         GestureDetector(
//                           onTap: () {
//                             Get.toNamed(
//                               AppRoutes.expertChildProfile,
//                               arguments: {
//                                 'childId': appt.childId,
//                                 'childName':
//                                     appt.children?.childName ?? '',
//                               },
//                             );
//                           },
//                           behavior: HitTestBehavior.opaque,
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 10, vertical: 5),
//                             decoration: BoxDecoration(
//                               color: AppColors.secondaryColor
//                                   .withOpacity(0.08),
//                               borderRadius: BorderRadius.circular(20),
//                               border: Border.all(
//                                   color: AppColors.secondaryColor
//                                       .withOpacity(0.3)),
//                             ),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 const Icon(Icons.child_care_rounded,
//                                     size: 12,
//                                     color: AppColors.secondaryColor),
//                                 const SizedBox(width: 4),
//                                 Text(
//                                   'Child Profile',
//                                   style: GoogleFonts.poppins(
//                                       fontSize: 11,
//                                       color: AppColors.secondaryColor,
//                                       fontWeight: FontWeight.w600),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         )
//                       else
//                         const SizedBox.shrink(),

//                       // View Details arrow
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

//   // ── All helper widgets ─────────────────────────────────────────────────────

//   Widget _upcomingDateBadge(MyAppointmentItem appt) {
//     try {
//       final dt = DateTime.parse(appt.scheduledAt).toLocal();
//       final now = DateTime.now();
//       final diff = dt.difference(now);
//       String label;
//       if (diff.inDays == 0) {
//         label = 'Today';
//       } else if (diff.inDays == 1) {
//         label = 'Tomorrow';
//       } else if (diff.inDays <= 7) {
//         label = 'In ${diff.inDays} days';
//       } else {
//         const months = [
//           '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
//           'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
//         ];
//         label = '${dt.day} ${months[dt.month]}';
//       }
//       return Container(
//         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//         decoration: BoxDecoration(
//           color: AppColors.primaryColor.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Text(label,
//             style: GoogleFonts.poppins(
//                 fontSize: 10,
//                 fontWeight: FontWeight.w600,
//                 color: AppColors.primaryColor)),
//       );
//     } catch (_) {
//       return const SizedBox.shrink();
//     }
//   }

//   Widget _expiredBadgeSmall() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//       decoration: BoxDecoration(
//         color: const Color(0xFFE65100).withOpacity(0.12),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: const Color(0xFFE65100).withOpacity(0.4)),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const Icon(Icons.timer_off_outlined,
//               size: 9, color: Color(0xFFE65100)),
//           const SizedBox(width: 3),
//           Text('Expired',
//               style: GoogleFonts.poppins(
//                   fontSize: 9,
//                   fontWeight: FontWeight.w600,
//                   color: const Color(0xFFE65100))),
//         ],
//       ),
//     );
//   }

//   Widget _meetLinkExpiredBanner() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//       decoration: BoxDecoration(
//         color: const Color(0xFFE65100).withOpacity(0.07),
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(
//             color: const Color(0xFFE65100).withOpacity(0.3), width: 1),
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.videocam_off_rounded,
//               color: Color(0xFFE65100), size: 15),
//           const SizedBox(width: 7),
//           Expanded(
//             child: Text(
//               'Meeting link expired — session time has passed',
//               style: GoogleFonts.poppins(
//                   fontSize: 11.5,
//                   color: const Color(0xFFE65100),
//                   fontWeight: FontWeight.w500),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _expiredActionHint(BuildContext context, CustomSize size) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//       decoration: BoxDecoration(
//         color: AppColors.greyColor.withOpacity(0.07),
//         borderRadius: BorderRadius.circular(10),
//         border:
//             Border.all(color: AppColors.greyColor.withOpacity(0.3), width: 1),
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.touch_app_outlined,
//               color: AppColors.textSecondaryColor, size: 14),
//           const SizedBox(width: 7),
//           Expanded(
//             child: Text(
//               'Tap to Cancel or mark No Show',
//               style: GoogleFonts.poppins(
//                   fontSize: 11.5,
//                   color: AppColors.textSecondaryColor,
//                   fontWeight: FontWeight.w500),
//             ),
//           ),
//           const Icon(Icons.arrow_forward_ios_rounded,
//               size: 10, color: AppColors.textSecondaryColor),
//         ],
//       ),
//     );
//   }

//   Widget _paymentBadgeSmall(bool isPaid) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//       decoration: BoxDecoration(
//         color: isPaid
//             ? AppColors.successColor.withOpacity(0.12)
//             : AppColors.warningColor.withOpacity(0.12),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(
//           color: isPaid
//               ? AppColors.successColor.withOpacity(0.4)
//               : AppColors.warningColor.withOpacity(0.4),
//         ),
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
//                 fontSize: 9,
//                 fontWeight: FontWeight.w600,
//                 color:
//                     isPaid ? AppColors.successColor : AppColors.warningColor),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _paymentHighlightBanner(bool isPaid) {
//     if (isPaid) {
//       return Container(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//         decoration: BoxDecoration(
//           color: AppColors.successColor.withOpacity(0.07),
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(
//               color: AppColors.successColor.withOpacity(0.3), width: 1),
//         ),
//         child: Row(
//           children: [
//             const Icon(Icons.check_circle_rounded,
//                 color: AppColors.successColor, size: 15),
//             const SizedBox(width: 7),
//             Text('Payment complete',
//                 style: GoogleFonts.poppins(
//                     fontSize: 12,
//                     color: AppColors.successColor,
//                     fontWeight: FontWeight.w600)),
//           ],
//         ),
//       );
//     }

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//       decoration: BoxDecoration(
//         color: AppColors.warningColor.withOpacity(0.07),
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(
//             color: AppColors.warningColor.withOpacity(0.4), width: 1),
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.warning_amber_rounded,
//               color: AppColors.warningColor, size: 15),
//           const SizedBox(width: 7),
//           Expanded(
//             child: Text(
//               'Payment pending — patient has not paid yet',
//               style: GoogleFonts.poppins(
//                   fontSize: 11.5,
//                   color: AppColors.warningColor,
//                   fontWeight: FontWeight.w500),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _meetLinkBanner(BuildContext context, String url) {
//     return GestureDetector(
//       onTap: () => _openUrl(url),
//       behavior: HitTestBehavior.opaque,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//         decoration: BoxDecoration(
//           color: const Color(0xFF2196F3).withOpacity(0.07),
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(
//               color: const Color(0xFF2196F3).withOpacity(0.3), width: 1),
//         ),
//         child: Row(
//           children: [
//             const Icon(Icons.videocam_rounded,
//                 color: Color(0xFF2196F3), size: 15),
//             const SizedBox(width: 7),
//             Expanded(
//               child: Text('Tap to join meeting',
//                   style: GoogleFonts.poppins(
//                       fontSize: 11.5,
//                       color: const Color(0xFF2196F3),
//                       fontWeight: FontWeight.w600)),
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
//               child: const Padding(
//                 padding: EdgeInsets.only(right: 6),
//                 child: Icon(Icons.copy_outlined,
//                     size: 13, color: Color(0xFF2196F3)),
//               ),
//             ),
//             const Icon(Icons.open_in_new_rounded,
//                 size: 13, color: Color(0xFF2196F3)),
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

//   Widget _buildEmptyExpired(BuildContext context, CustomSize size) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             width: 100,
//             height: 100,
//             decoration: BoxDecoration(
//                 color: const Color(0xFFE65100).withOpacity(0.07),
//                 shape: BoxShape.circle),
//             child: const Icon(Icons.timer_off_outlined,
//                 size: 48, color: Color(0xFFE65100)),
//           ),
//           SizedBox(height: size.customHeight(context) * 0.022),
//           Text('No Expired Appointments',
//               style: GoogleFonts.poppins(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.textPrimaryColor)),
//           const SizedBox(height: 6),
//           Text('All appointments are up to date',
//               style: GoogleFonts.poppins(
//                   fontSize: 13, color: AppColors.textSecondaryColor)),
//         ],
//       ),
//     );
//   }

//   _StatusMeta _getStatusMeta(String status, {bool isExpired = false}) {
//     if (isExpired) {
//       return _StatusMeta(const Color(0xFFE65100), 'Expired');
//     }
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
//         return _StatusMeta(AppColors.warningColor, 'Requested');
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
// UPDATED — "View Child Profile" button on Scheduled & Confirmed cards (including in All tab)
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
import 'package:speechspectrum/controllers/my_appointment_controller.dart';
import 'package:speechspectrum/models/my_appointment_model.dart';
import 'package:speechspectrum/routes/app_routes.dart';

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

class MyAppointmentsScreen extends StatefulWidget {
  const MyAppointmentsScreen({super.key});

  @override
  State<MyAppointmentsScreen> createState() => _MyAppointmentsScreenState();
}

class _MyAppointmentsScreenState extends State<MyAppointmentsScreen>
    with SingleTickerProviderStateMixin {
  late final MyAppointmentController _c;
  late final TabController _tab;

  static const int _kTabAll = 0;
  static const int _kTabRequested = 1;
  static const int _kTabConfirmed = 2;
  static const int _kTabCompleted = 3;
  static const int _kTabCancelled = 4;
  static const int _kTabNoShow = 5;
  static const int _kTabExpired = 6;

  static const _tabs = [
    ('All', Icons.list_alt_rounded),
    ('Requested', Icons.schedule_rounded),
    ('Confirmed', Icons.check_circle_outline_rounded),
    ('Completed', Icons.task_alt_rounded),
    ('Cancelled', Icons.cancel_outlined),
    ('No Show', Icons.person_off_outlined),
    ('Expired', Icons.timer_off_outlined),
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
    final idx = _c.pendingTabIndex.value;
    if (idx != null) {
      _c.pendingTabIndex.value = null;
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
                        Icon(
                          t.$2,
                          size: 14,
                          color: t.$1 == 'Expired'
                              ? const Color(0xFFE65100)
                              : null,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          t.$1,
                          style: t.$1 == 'Expired'
                              ? GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.5,
                                  color: const Color(0xFFE65100))
                              : null,
                        ),
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
            // ✅ FIX: All tab now passes showChildProfileBtn: true
            // The card itself filters to only show it for scheduled/confirmed
            _buildList(context, size, _c.allAppointments,
                showChildProfileBtn: true),
            _buildList(context, size, _c.scheduledList,
                showDateBadge: true, showChildProfileBtn: true),
            _buildList(context, size, _c.confirmedList,
                showChildProfileBtn: true),
            _buildList(context, size, _c.completedList),
            _buildList(context, size, _c.cancelledList),
            _buildList(context, size, _c.noShowList),
            _buildExpiredList(context, size, _c.expiredList),
          ],
        );
      }),
    );
  }

  // ── List builders ──────────────────────────────────────────────────────────

  Widget _buildList(
    BuildContext context,
    CustomSize size,
    List<MyAppointmentItem> list, {
    bool showDateBadge = false,
    bool showChildProfileBtn = false,
  }) {
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
        itemBuilder: (_, i) => _appointmentCard(
          context,
          size,
          list[i],
          showDateBadge: showDateBadge,
          showChildProfileBtn: showChildProfileBtn,
        ),
      ),
    );
  }

  Widget _buildExpiredList(
    BuildContext context,
    CustomSize size,
    List<MyAppointmentItem> list,
  ) {
    if (list.isEmpty) {
      return _buildEmptyExpired(context, size);
    }
    return RefreshIndicator(
      color: const Color(0xFFE65100),
      onRefresh: _c.fetchMyAppointments,
      child: ListView.builder(
        padding: EdgeInsets.fromLTRB(
          size.customWidth(context) * 0.045,
          size.customHeight(context) * 0.02,
          size.customWidth(context) * 0.045,
          size.customHeight(context) * 0.04,
        ),
        itemCount: list.length + 1,
        itemBuilder: (_, i) {
          if (i == 0) return _buildExpiredBanner(context, size);
          return _appointmentCard(context, size, list[i - 1],
              forceExpired: true);
        },
      ),
    );
  }

  Widget _buildExpiredBanner(BuildContext context, CustomSize size) {
    return Container(
      margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.016),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFE65100).withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE65100).withOpacity(0.35)),
      ),
      child: Row(
        children: [
          const Icon(Icons.timer_off_outlined,
              color: Color(0xFFE65100), size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'These appointments passed without being completed or cancelled. '
              'You can still Cancel or mark No Show if needed.',
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFFE65100),
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  // ── Appointment card ───────────────────────────────────────────────────────

  Widget _appointmentCard(
    BuildContext context,
    CustomSize size,
    MyAppointmentItem appt, {
    bool showDateBadge = false,
    bool forceExpired = false,
    bool showChildProfileBtn = false,
  }) {
    final bool isExpiredCard = forceExpired || appt.isExpired;
    final meta = _getStatusMeta(appt.status, isExpired: isExpiredCard);

    // ✅ FIX: Only show child profile for scheduled & confirmed, never for expired.
    // This ensures correct behaviour in both the dedicated tabs AND the All tab.
    final String statusLower = appt.status.toLowerCase();
    final bool canViewChildProfile = showChildProfileBtn &&
        !isExpiredCard &&
        (statusLower == 'scheduled' || statusLower == 'confirmed');

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
            'isExpired': isExpiredCard,
            'childId': appt.childId,
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
                      _childAvatar(appt.childInitials, 50),
                      SizedBox(width: size.customWidth(context) * 0.03),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (showDateBadge) ...[
                              _upcomingDateBadge(appt),
                              const SizedBox(height: 4),
                            ],
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _statusBadge(meta),
                          if (appt.isConfirmed && !isExpiredCard) ...[
                            const SizedBox(height: 4),
                            _paymentBadgeSmall(appt.isPaid),
                          ],
                          if (isExpiredCard) ...[
                            const SizedBox(height: 4),
                            _expiredBadgeSmall(),
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
                      _infoChip(Icons.calendar_today_outlined,
                          appt.formattedDate, AppColors.primaryColor),
                      _infoChip(Icons.access_time_rounded,
                          appt.formattedTime, AppColors.secondaryColor),
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

                  // Confirmed: payment banner
                  if (appt.isConfirmed && !isExpiredCard) ...[
                    SizedBox(height: size.customHeight(context) * 0.01),
                    _paymentHighlightBanner(appt.isPaid),
                  ],

                  // Confirmed: meeting link
                  if (appt.isConfirmed &&
                      !isExpiredCard &&
                      appt.meetLink != null &&
                      appt.meetLink!.isNotEmpty) ...[
                    SizedBox(height: size.customHeight(context) * 0.01),
                    _meetLinkBanner(context, appt.meetLink!),
                  ],

                  // Expired: meeting link hint
                  if (isExpiredCard &&
                      appt.meetLink != null &&
                      appt.meetLink!.isNotEmpty) ...[
                    SizedBox(height: size.customHeight(context) * 0.01),
                    _meetLinkExpiredBanner(),
                  ],

                  // Expired: action hint
                  if (isExpiredCard) ...[
                    SizedBox(height: size.customHeight(context) * 0.01),
                    _expiredActionHint(context, size),
                  ],

                  // Cancellation reason
                  if (appt.isCancelled && appt.cancellationReason != null) ...[
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

                  // Completed hint
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

                  SizedBox(height: size.customHeight(context) * 0.01),

                  // ── BOTTOM ROW ───────────────────────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Child Profile button — only for scheduled/confirmed, never expired
                      if (canViewChildProfile)
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              AppRoutes.expertChildProfile,
                              arguments: {
                                'childId': appt.childId,
                                'childName':
                                    appt.children?.childName ?? '',
                              },
                            );
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: AppColors.secondaryColor
                                  .withOpacity(0.08),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: AppColors.secondaryColor
                                      .withOpacity(0.3)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.child_care_rounded,
                                    size: 12,
                                    color: AppColors.secondaryColor),
                                const SizedBox(width: 4),
                                Text(
                                  'Child Profile',
                                  style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      color: AppColors.secondaryColor,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        const SizedBox.shrink(),

                      // View Details arrow
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
                              size: 11, color: AppColors.primaryColor),
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

  // ── All helper widgets ─────────────────────────────────────────────────────

  Widget _upcomingDateBadge(MyAppointmentItem appt) {
    try {
      final dt = DateTime.parse(appt.scheduledAt).toLocal();
      final now = DateTime.now();
      final diff = dt.difference(now);
      String label;
      if (diff.inDays == 0) {
        label = 'Today';
      } else if (diff.inDays == 1) {
        label = 'Tomorrow';
      } else if (diff.inDays <= 7) {
        label = 'In ${diff.inDays} days';
      } else {
        const months = [
          '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
          'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
        ];
        label = '${dt.day} ${months[dt.month]}';
      }
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(label,
            style: GoogleFonts.poppins(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor)),
      );
    } catch (_) {
      return const SizedBox.shrink();
    }
  }

  Widget _expiredBadgeSmall() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFFE65100).withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE65100).withOpacity(0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.timer_off_outlined,
              size: 9, color: Color(0xFFE65100)),
          const SizedBox(width: 3),
          Text('Expired',
              style: GoogleFonts.poppins(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFE65100))),
        ],
      ),
    );
  }

  Widget _meetLinkExpiredBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE65100).withOpacity(0.07),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: const Color(0xFFE65100).withOpacity(0.3), width: 1),
      ),
      child: Row(
        children: [
          const Icon(Icons.videocam_off_rounded,
              color: Color(0xFFE65100), size: 15),
          const SizedBox(width: 7),
          Expanded(
            child: Text(
              'Meeting link expired — session time has passed',
              style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  color: const Color(0xFFE65100),
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _expiredActionHint(BuildContext context, CustomSize size) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.greyColor.withOpacity(0.07),
        borderRadius: BorderRadius.circular(10),
        border:
            Border.all(color: AppColors.greyColor.withOpacity(0.3), width: 1),
      ),
      child: Row(
        children: [
          const Icon(Icons.touch_app_outlined,
              color: AppColors.textSecondaryColor, size: 14),
          const SizedBox(width: 7),
          Expanded(
            child: Text(
              'Tap to Cancel or mark No Show',
              style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  color: AppColors.textSecondaryColor,
                  fontWeight: FontWeight.w500),
            ),
          ),
          const Icon(Icons.arrow_forward_ios_rounded,
              size: 10, color: AppColors.textSecondaryColor),
        ],
      ),
    );
  }

  Widget _paymentBadgeSmall(bool isPaid) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: isPaid
            ? AppColors.successColor.withOpacity(0.12)
            : AppColors.warningColor.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isPaid
              ? AppColors.successColor.withOpacity(0.4)
              : AppColors.warningColor.withOpacity(0.4),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isPaid ? Icons.check_circle_outline : Icons.pending_outlined,
            size: 9,
            color: isPaid ? AppColors.successColor : AppColors.warningColor,
          ),
          const SizedBox(width: 3),
          Text(
            isPaid ? 'Paid' : 'Unpaid',
            style: GoogleFonts.poppins(
                fontSize: 9,
                fontWeight: FontWeight.w600,
                color:
                    isPaid ? AppColors.successColor : AppColors.warningColor),
          ),
        ],
      ),
    );
  }

  Widget _paymentHighlightBanner(bool isPaid) {
    if (isPaid) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.successColor.withOpacity(0.07),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: AppColors.successColor.withOpacity(0.3), width: 1),
        ),
        child: Row(
          children: [
            const Icon(Icons.check_circle_rounded,
                color: AppColors.successColor, size: 15),
            const SizedBox(width: 7),
            Text('Payment complete',
                style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColors.successColor,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.warningColor.withOpacity(0.07),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: AppColors.warningColor.withOpacity(0.4), width: 1),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning_amber_rounded,
              color: AppColors.warningColor, size: 15),
          const SizedBox(width: 7),
          Expanded(
            child: Text(
              'Payment pending — patient has not paid yet',
              style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  color: AppColors.warningColor,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _meetLinkBanner(BuildContext context, String url) {
    return GestureDetector(
      onTap: () => _openUrl(url),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF2196F3).withOpacity(0.07),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: const Color(0xFF2196F3).withOpacity(0.3), width: 1),
        ),
        child: Row(
          children: [
            const Icon(Icons.videocam_rounded,
                color: Color(0xFF2196F3), size: 15),
            const SizedBox(width: 7),
            Expanded(
              child: Text('Tap to join meeting',
                  style: GoogleFonts.poppins(
                      fontSize: 11.5,
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
              child: const Padding(
                padding: EdgeInsets.only(right: 6),
                child: Icon(Icons.copy_outlined,
                    size: 13, color: Color(0xFF2196F3)),
              ),
            ),
            const Icon(Icons.open_in_new_rounded,
                size: 13, color: Color(0xFF2196F3)),
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

  Widget _buildEmptyExpired(BuildContext context, CustomSize size) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                color: const Color(0xFFE65100).withOpacity(0.07),
                shape: BoxShape.circle),
            child: const Icon(Icons.timer_off_outlined,
                size: 48, color: Color(0xFFE65100)),
          ),
          SizedBox(height: size.customHeight(context) * 0.022),
          Text('No Expired Appointments',
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryColor)),
          const SizedBox(height: 6),
          Text('All appointments are up to date',
              style: GoogleFonts.poppins(
                  fontSize: 13, color: AppColors.textSecondaryColor)),
        ],
      ),
    );
  }

  _StatusMeta _getStatusMeta(String status, {bool isExpired = false}) {
    if (isExpired) {
      return _StatusMeta(const Color(0xFFE65100), 'Expired');
    }
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
        return _StatusMeta(AppColors.warningColor, 'Requested');
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