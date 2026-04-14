// // // // // // // lib/view/expert/appointments/appointment_detail_screen.dart
// // // // // // import 'package:flutter/material.dart';
// // // // // // import 'package:get/get.dart';
// // // // // // import 'package:google_fonts/google_fonts.dart';
// // // // // // import 'package:speechspectrum/constants/app_colors.dart';
// // // // // // import 'package:speechspectrum/constants/custom_size.dart';
// // // // // // import 'package:speechspectrum/controllers/my_appointment_controller.dart';
// // // // // // import 'package:speechspectrum/models/my_appointment_model.dart';

// // // // // // class AppointmentDetailScreen extends StatefulWidget {
// // // // // //   const AppointmentDetailScreen({super.key});

// // // // // //   @override
// // // // // //   State<AppointmentDetailScreen> createState() =>
// // // // // //       _AppointmentDetailScreenState();
// // // // // // }

// // // // // // class _AppointmentDetailScreenState extends State<AppointmentDetailScreen> {
// // // // // //   late final MyAppointmentController _c;
// // // // // //   late final String _appointmentId;

// // // // // //   @override
// // // // // //   void initState() {
// // // // // //     super.initState();
// // // // // //     _c = Get.find<MyAppointmentController>();
// // // // // //     _appointmentId = Get.arguments as String;
// // // // // //     WidgetsBinding.instance.addPostFrameCallback((_) {
// // // // // //       _c.fetchAppointmentDetail(_appointmentId);
// // // // // //       _c.fetchRecords(_appointmentId);
// // // // // //     });
// // // // // //   }

// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     final size = CustomSize();

// // // // // //     return Scaffold(
// // // // // //       backgroundColor: AppColors.lightGreyColor,
// // // // // //       body: Obx(() {
// // // // // //         if (_c.isLoadingDetail.value) {
// // // // // //           return _loader(context, size);
// // // // // //         }
// // // // // //         final appt = _c.selectedAppointment.value;
// // // // // //         if (appt == null) {
// // // // // //           return _errorState(context, size);
// // // // // //         }
// // // // // //         return _buildContent(context, size, appt);
// // // // // //       }),
// // // // // //     );
// // // // // //   }

// // // // // //   Widget _buildContent(
// // // // // //       BuildContext context, CustomSize size, MyAppointmentItem appt) {
// // // // // //     final statusMeta = _statusMeta(appt.status);

// // // // // //     return CustomScrollView(
// // // // // //       slivers: [
// // // // // //         // ── SliverAppBar ──────────────────────────────────────
// // // // // //         SliverAppBar(
// // // // // //           expandedHeight: size.customHeight(context) * 0.22,
// // // // // //           pinned: true,
// // // // // //           backgroundColor: AppColors.primaryColor,
// // // // // //           surfaceTintColor: Colors.transparent,
// // // // // //           leading: GestureDetector(
// // // // // //             onTap: () => Get.back(),
// // // // // //             child: Container(
// // // // // //               margin: const EdgeInsets.all(8),
// // // // // //               decoration: BoxDecoration(
// // // // // //                   color: Colors.white.withOpacity(0.15),
// // // // // //                   borderRadius: BorderRadius.circular(12)),
// // // // // //               child: const Icon(Icons.arrow_back_ios_new_rounded,
// // // // // //                   color: Colors.white, size: 18),
// // // // // //             ),
// // // // // //           ),
// // // // // //           flexibleSpace: FlexibleSpaceBar(
// // // // // //             background: Container(
// // // // // //               decoration: const BoxDecoration(
// // // // // //                 gradient: LinearGradient(
// // // // // //                   colors: [AppColors.primaryColor, AppColors.secondaryColor],
// // // // // //                   begin: Alignment.topLeft,
// // // // // //                   end: Alignment.bottomRight,
// // // // // //                 ),
// // // // // //               ),
// // // // // //               child: SafeArea(
// // // // // //                 child: Padding(
// // // // // //                   padding: EdgeInsets.fromLTRB(
// // // // // //                     size.customWidth(context) * 0.05,
// // // // // //                     size.customHeight(context) * 0.06,
// // // // // //                     size.customWidth(context) * 0.05,
// // // // // //                     16,
// // // // // //                   ),
// // // // // //                   child: Row(
// // // // // //                     children: [
// // // // // //                       Container(
// // // // // //                         width: 64,
// // // // // //                         height: 64,
// // // // // //                         decoration: BoxDecoration(
// // // // // //                           color: Colors.white.withOpacity(0.2),
// // // // // //                           borderRadius: BorderRadius.circular(18),
// // // // // //                         ),
// // // // // //                         child: Center(
// // // // // //                           child: Text(
// // // // // //                             appt.childInitials,
// // // // // //                             style: GoogleFonts.poppins(
// // // // // //                                 color: Colors.white,
// // // // // //                                 fontSize: 22,
// // // // // //                                 fontWeight: FontWeight.bold),
// // // // // //                           ),
// // // // // //                         ),
// // // // // //                       ),
// // // // // //                       SizedBox(width: size.customWidth(context) * 0.04),
// // // // // //                       Expanded(
// // // // // //                         child: Column(
// // // // // //                           mainAxisSize: MainAxisSize.min,
// // // // // //                           crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //                           children: [
// // // // // //                             Text(
// // // // // //                               appt.children?.childName ?? 'Unknown',
// // // // // //                               style: GoogleFonts.poppins(
// // // // // //                                   color: Colors.white,
// // // // // //                                   fontSize: size.customWidth(context) * 0.046,
// // // // // //                                   fontWeight: FontWeight.bold),
// // // // // //                             ),
// // // // // //                             Text(
// // // // // //                               appt.expertUsers?.specialization ?? '',
// // // // // //                               style: GoogleFonts.poppins(
// // // // // //                                   color: Colors.white.withOpacity(0.85),
// // // // // //                                   fontSize: size.customWidth(context) * 0.032),
// // // // // //                             ),
// // // // // //                             const SizedBox(height: 6),
// // // // // //                             Container(
// // // // // //                               padding: const EdgeInsets.symmetric(
// // // // // //                                   horizontal: 12, vertical: 4),
// // // // // //                               decoration: BoxDecoration(
// // // // // //                                 color: statusMeta.color.withOpacity(0.2),
// // // // // //                                 borderRadius: BorderRadius.circular(20),
// // // // // //                                 border: Border.all(
// // // // // //                                     color: Colors.white.withOpacity(0.4)),
// // // // // //                               ),
// // // // // //                               child: Text(
// // // // // //                                 statusMeta.label,
// // // // // //                                 style: GoogleFonts.poppins(
// // // // // //                                     color: Colors.white,
// // // // // //                                     fontSize: 12,
// // // // // //                                     fontWeight: FontWeight.w600),
// // // // // //                               ),
// // // // // //                             ),
// // // // // //                           ],
// // // // // //                         ),
// // // // // //                       ),
// // // // // //                     ],
// // // // // //                   ),
// // // // // //                 ),
// // // // // //               ),
// // // // // //             ),
// // // // // //           ),
// // // // // //         ),

// // // // // //         // ── Body ──────────────────────────────────────────────
// // // // // //         SliverPadding(
// // // // // //           padding: EdgeInsets.fromLTRB(
// // // // // //             size.customWidth(context) * 0.045,
// // // // // //             size.customHeight(context) * 0.02,
// // // // // //             size.customWidth(context) * 0.045,
// // // // // //             size.customHeight(context) * 0.04,
// // // // // //           ),
// // // // // //           sliver: SliverList(
// // // // // //             delegate: SliverChildListDelegate([
// // // // // //               // Action buttons
// // // // // //               _actionButtons(context, size, appt),
// // // // // //               SizedBox(height: size.customHeight(context) * 0.022),

// // // // // //               // Appointment info card
// // // // // //               _infoCard(context, size, appt),
// // // // // //               SizedBox(height: size.customHeight(context) * 0.018),

// // // // // //               // Slot info card
// // // // // //               if (appt.appointmentSlots != null)
// // // // // //                 _slotCard(context, size, appt.appointmentSlots!),
// // // // // //               if (appt.appointmentSlots != null)
// // // // // //                 SizedBox(height: size.customHeight(context) * 0.018),

// // // // // //               // Expert info card
// // // // // //               if (appt.expertUsers != null)
// // // // // //                 _expertCard(context, size, appt.expertUsers!),
// // // // // //               if (appt.expertUsers != null)
// // // // // //                 SizedBox(height: size.customHeight(context) * 0.018),

// // // // // //               // Cancellation info
// // // // // //               if (appt.isCancelled) ...[
// // // // // //                 _cancellationCard(context, size, appt),
// // // // // //                 SizedBox(height: size.customHeight(context) * 0.018),
// // // // // //               ],

// // // // // //               // Session records
// // // // // //               _recordsSection(context, size, appt),
// // // // // //               SizedBox(height: size.customHeight(context) * 0.04),
// // // // // //             ]),
// // // // // //           ),
// // // // // //         ),
// // // // // //       ],
// // // // // //     );
// // // // // //   }

// // // // // //   Widget _actionButtons(
// // // // // //       BuildContext context, CustomSize size, MyAppointmentItem appt) {
// // // // // //     final buttons = <_ActionBtn>[];

// // // // // //     if (appt.isScheduled) {
// // // // // //       buttons.add(_ActionBtn(
// // // // // //           label: 'Confirm',
// // // // // //           icon: Icons.check_circle_outline_rounded,
// // // // // //           color: AppColors.primaryColor,
// // // // // //           onTap: () => _confirmDialog(context, appt.appointmentId)));
// // // // // //       buttons.add(_ActionBtn(
// // // // // //           label: 'Cancel',
// // // // // //           icon: Icons.cancel_outlined,
// // // // // //           color: AppColors.errorColor,
// // // // // //           onTap: () => _cancelDialog(context, appt.appointmentId)));
// // // // // //       buttons.add(_ActionBtn(
// // // // // //           label: 'No Show',
// // // // // //           icon: Icons.person_off_outlined,
// // // // // //           color: AppColors.greyColor,
// // // // // //           onTap: () => _noShowDialog(context, appt.appointmentId)));
// // // // // //     } else if (appt.isConfirmed) {
// // // // // //       buttons.add(_ActionBtn(
// // // // // //           label: 'Complete',
// // // // // //           icon: Icons.task_alt_rounded,
// // // // // //           color: AppColors.successColor,
// // // // // //           onTap: () => _completeDialog(context, appt.appointmentId)));
// // // // // //       buttons.add(_ActionBtn(
// // // // // //           label: 'Cancel',
// // // // // //           icon: Icons.cancel_outlined,
// // // // // //           color: AppColors.errorColor,
// // // // // //           onTap: () => _cancelDialog(context, appt.appointmentId)));
// // // // // //       buttons.add(_ActionBtn(
// // // // // //           label: 'No Show',
// // // // // //           icon: Icons.person_off_outlined,
// // // // // //           color: AppColors.greyColor,
// // // // // //           onTap: () => _noShowDialog(context, appt.appointmentId)));
// // // // // //     }

// // // // // //     if (buttons.isEmpty) return const SizedBox.shrink();

// // // // // //     return Row(
// // // // // //       children: buttons.map((b) {
// // // // // //         return Expanded(
// // // // // //           child: GestureDetector(
// // // // // //             onTap: b.onTap,
// // // // // //             child: Container(
// // // // // //               margin: const EdgeInsets.symmetric(horizontal: 4),
// // // // // //               padding: const EdgeInsets.symmetric(vertical: 12),
// // // // // //               decoration: BoxDecoration(
// // // // // //                 color: b.color.withOpacity(0.1),
// // // // // //                 borderRadius: BorderRadius.circular(14),
// // // // // //                 border: Border.all(color: b.color.withOpacity(0.3)),
// // // // // //               ),
// // // // // //               child: Column(
// // // // // //                 mainAxisSize: MainAxisSize.min,
// // // // // //                 children: [
// // // // // //                   Icon(b.icon, color: b.color, size: 22),
// // // // // //                   const SizedBox(height: 5),
// // // // // //                   Text(b.label,
// // // // // //                       style: GoogleFonts.poppins(
// // // // // //                           fontSize: 11,
// // // // // //                           fontWeight: FontWeight.w600,
// // // // // //                           color: b.color)),
// // // // // //                 ],
// // // // // //               ),
// // // // // //             ),
// // // // // //           ),
// // // // // //         );
// // // // // //       }).toList(),
// // // // // //     );
// // // // // //   }

// // // // // //   Widget _infoCard(
// // // // // //       BuildContext context, CustomSize size, MyAppointmentItem appt) {
// // // // // //     return _card(
// // // // // //       context,
// // // // // //       size,
// // // // // //       title: 'Appointment Details',
// // // // // //       icon: Icons.event_note_rounded,
// // // // // //       children: [
// // // // // //         _detailRow(context, size, 'Date', appt.formattedDate,
// // // // // //             Icons.calendar_today_outlined),
// // // // // //         _detailRow(context, size, 'Time', appt.formattedTime,
// // // // // //             Icons.access_time_rounded),
// // // // // //         _detailRow(context, size, 'Duration',
// // // // // //             '${appt.durationMinutes} minutes', Icons.timer_outlined),
// // // // // //         _detailRow(
// // // // // //             context,
// // // // // //             size,
// // // // // //             'Mode',
// // // // // //             appt.bookedMode[0].toUpperCase() + appt.bookedMode.substring(1),
// // // // // //             _modeIcon(appt.bookedMode)),
// // // // // //         _detailRow(context, size, 'Fee',
// // // // // //             '${appt.currency} ${appt.feeCharged.toStringAsFixed(0)}',
// // // // // //             Icons.payments_outlined),
// // // // // //         if (appt.meetLink != null)
// // // // // //           _detailRow(
// // // // // //               context, size, 'Meet Link', appt.meetLink!, Icons.link_rounded),
// // // // // //       ],
// // // // // //     );
// // // // // //   }

// // // // // //   Widget _slotCard(
// // // // // //       BuildContext context, CustomSize size, AppointmentSlot slot) {
// // // // // //     return _card(
// // // // // //       context,
// // // // // //       size,
// // // // // //       title: 'Slot Information',
// // // // // //       icon: Icons.calendar_month_rounded,
// // // // // //       children: [
// // // // // //         _detailRow(context, size, 'Slot Date', slot.slotDate,
// // // // // //             Icons.today_rounded),
// // // // // //         _detailRow(context, size, 'Slot Time',
// // // // // //             '${slot.formattedStart} – ${slot.formattedEnd}',
// // // // // //             Icons.schedule_rounded),
// // // // // //         _detailRow(context, size, 'Slot Mode',
// // // // // //             slot.mode[0].toUpperCase() + slot.mode.substring(1),
// // // // // //             _modeIcon(slot.mode)),
// // // // // //       ],
// // // // // //     );
// // // // // //   }

// // // // // //   Widget _expertCard(
// // // // // //       BuildContext context, CustomSize size, AppointmentExpert expert) {
// // // // // //     return _card(
// // // // // //       context,
// // // // // //       size,
// // // // // //       title: 'Expert Information',
// // // // // //       icon: Icons.person_outline_rounded,
// // // // // //       children: [
// // // // // //         _detailRow(context, size, 'Name', expert.fullName,
// // // // // //             Icons.badge_outlined),
// // // // // //         _detailRow(context, size, 'Specialization', expert.specialization,
// // // // // //             Icons.medical_information_outlined),
// // // // // //         if (expert.phone != null)
// // // // // //           _detailRow(context, size, 'Phone', expert.phone!,
// // // // // //               Icons.phone_outlined),
// // // // // //         if (expert.contactEmail != null)
// // // // // //           _detailRow(context, size, 'Email', expert.contactEmail!,
// // // // // //               Icons.email_outlined),
// // // // // //       ],
// // // // // //     );
// // // // // //   }

// // // // // //   Widget _cancellationCard(
// // // // // //       BuildContext context, CustomSize size, MyAppointmentItem appt) {
// // // // // //     return Container(
// // // // // //       padding: EdgeInsets.all(size.customWidth(context) * 0.045),
// // // // // //       decoration: BoxDecoration(
// // // // // //         color: AppColors.errorColor.withOpacity(0.05),
// // // // // //         borderRadius: BorderRadius.circular(18),
// // // // // //         border:
// // // // // //             Border.all(color: AppColors.errorColor.withOpacity(0.2)),
// // // // // //       ),
// // // // // //       child: Column(
// // // // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //         children: [
// // // // // //           Row(
// // // // // //             children: [
// // // // // //               const Icon(Icons.cancel_outlined,
// // // // // //                   color: AppColors.errorColor, size: 18),
// // // // // //               const SizedBox(width: 8),
// // // // // //               Text('Cancellation Info',
// // // // // //                   style: GoogleFonts.poppins(
// // // // // //                       fontSize: 14,
// // // // // //                       fontWeight: FontWeight.w600,
// // // // // //                       color: AppColors.errorColor)),
// // // // // //             ],
// // // // // //           ),
// // // // // //           const SizedBox(height: 12),
// // // // // //           if (appt.cancelledBy != null)
// // // // // //             _detailRow(context, size, 'Cancelled By',
// // // // // //                 appt.cancelledBy![0].toUpperCase() +
// // // // // //                     appt.cancelledBy!.substring(1),
// // // // // //                 Icons.person_outlined),
// // // // // //           if (appt.cancellationReason != null)
// // // // // //             _detailRow(context, size, 'Reason', appt.cancellationReason!,
// // // // // //                 Icons.info_outline_rounded),
// // // // // //         ],
// // // // // //       ),
// // // // // //     );
// // // // // //   }

// // // // // //   Widget _recordsSection(
// // // // // //       BuildContext context, CustomSize size, MyAppointmentItem appt) {
// // // // // //     return Column(
// // // // // //       crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //       children: [
// // // // // //         Row(
// // // // // //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // // //           children: [
// // // // // //             Row(
// // // // // //               children: [
// // // // // //                 Container(
// // // // // //                   width: 4,
// // // // // //                   height: 20,
// // // // // //                   decoration: BoxDecoration(
// // // // // //                       color: AppColors.primaryColor,
// // // // // //                       borderRadius: BorderRadius.circular(2)),
// // // // // //                 ),
// // // // // //                 const SizedBox(width: 10),
// // // // // //                 Text('Session Records',
// // // // // //                     style: GoogleFonts.poppins(
// // // // // //                         fontSize: size.customWidth(context) * 0.042,
// // // // // //                         fontWeight: FontWeight.bold,
// // // // // //                         color: AppColors.textPrimaryColor)),
// // // // // //               ],
// // // // // //             ),
// // // // // //             if (appt.isCompleted)
// // // // // //               GestureDetector(
// // // // // //                 onTap: () {
// // // // // //                   _c.clearRecordForm();
// // // // // //                   _openRecordSheet(context, size, appt.appointmentId);
// // // // // //                 },
// // // // // //                 child: Container(
// // // // // //                   padding: const EdgeInsets.symmetric(
// // // // // //                       horizontal: 12, vertical: 7),
// // // // // //                   decoration: BoxDecoration(
// // // // // //                     color: AppColors.primaryColor,
// // // // // //                     borderRadius: BorderRadius.circular(10),
// // // // // //                   ),
// // // // // //                   child: Row(
// // // // // //                     mainAxisSize: MainAxisSize.min,
// // // // // //                     children: [
// // // // // //                       const Icon(Icons.add_rounded,
// // // // // //                           color: Colors.white, size: 16),
// // // // // //                       const SizedBox(width: 4),
// // // // // //                       Text('Add',
// // // // // //                           style: GoogleFonts.poppins(
// // // // // //                               color: Colors.white,
// // // // // //                               fontWeight: FontWeight.w600,
// // // // // //                               fontSize: 12)),
// // // // // //                     ],
// // // // // //                   ),
// // // // // //                 ),
// // // // // //               ),
// // // // // //           ],
// // // // // //         ),
// // // // // //         SizedBox(height: size.customHeight(context) * 0.015),

// // // // // //         Obx(() {
// // // // // //           if (_c.isLoadingRecords.value) {
// // // // // //             return const Center(
// // // // // //               child: Padding(
// // // // // //                 padding: EdgeInsets.all(24),
// // // // // //                 child: CircularProgressIndicator(
// // // // // //                     color: AppColors.primaryColor, strokeWidth: 2),
// // // // // //               ),
// // // // // //             );
// // // // // //           }
// // // // // //           if (_c.records.isEmpty) {
// // // // // //             return Container(
// // // // // //               padding: const EdgeInsets.all(24),
// // // // // //               decoration: BoxDecoration(
// // // // // //                 color: AppColors.whiteColor,
// // // // // //                 borderRadius: BorderRadius.circular(18),
// // // // // //                 boxShadow: [
// // // // // //                   BoxShadow(
// // // // // //                       color: Colors.black.withOpacity(0.05),
// // // // // //                       blurRadius: 10,
// // // // // //                       offset: const Offset(0, 3))
// // // // // //                 ],
// // // // // //               ),
// // // // // //               child: Center(
// // // // // //                 child: Column(
// // // // // //                   children: [
// // // // // //                     Icon(Icons.note_outlined,
// // // // // //                         size: 40,
// // // // // //                         color: AppColors.textSecondaryColor
// // // // // //                             .withOpacity(0.4)),
// // // // // //                     const SizedBox(height: 10),
// // // // // //                     Text(
// // // // // //                       appt.isCompleted
// // // // // //                           ? 'No records yet. Tap "Add" to create one.'
// // // // // //                           : 'Records available for completed appointments only.',
// // // // // //                       textAlign: TextAlign.center,
// // // // // //                       style: GoogleFonts.poppins(
// // // // // //                           fontSize: 13,
// // // // // //                           color: AppColors.textSecondaryColor),
// // // // // //                     ),
// // // // // //                   ],
// // // // // //                 ),
// // // // // //               ),
// // // // // //             );
// // // // // //           }
// // // // // //           return Column(
// // // // // //             children: _c.records
// // // // // //                 .map((r) => _recordCard(context, size, r, appt))
// // // // // //                 .toList(),
// // // // // //           );
// // // // // //         }),
// // // // // //       ],
// // // // // //     );
// // // // // //   }

// // // // // //   Widget _recordCard(BuildContext context, CustomSize size,
// // // // // //       AppointmentRecordItem record, MyAppointmentItem appt) {
// // // // // //     return Container(
// // // // // //       margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.014),
// // // // // //       decoration: BoxDecoration(
// // // // // //         color: AppColors.whiteColor,
// // // // // //         borderRadius: BorderRadius.circular(18),
// // // // // //         boxShadow: [
// // // // // //           BoxShadow(
// // // // // //               color: Colors.black.withOpacity(0.05),
// // // // // //               blurRadius: 10,
// // // // // //               offset: const Offset(0, 3))
// // // // // //         ],
// // // // // //       ),
// // // // // //       child: Column(
// // // // // //         children: [
// // // // // //           Padding(
// // // // // //             padding: EdgeInsets.all(size.customWidth(context) * 0.042),
// // // // // //             child: Column(
// // // // // //               crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //               children: [
// // // // // //                 Row(
// // // // // //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // // //                   children: [
// // // // // //                     Row(
// // // // // //                       children: [
// // // // // //                         Container(
// // // // // //                           padding: const EdgeInsets.all(8),
// // // // // //                           decoration: BoxDecoration(
// // // // // //                               color: AppColors.primaryColor.withOpacity(0.1),
// // // // // //                               borderRadius: BorderRadius.circular(10)),
// // // // // //                           child: const Icon(Icons.description_outlined,
// // // // // //                               color: AppColors.primaryColor, size: 18),
// // // // // //                         ),
// // // // // //                         const SizedBox(width: 10),
// // // // // //                         Text('Session Note',
// // // // // //                             style: GoogleFonts.poppins(
// // // // // //                                 fontSize: 14,
// // // // // //                                 fontWeight: FontWeight.w600,
// // // // // //                                 color: AppColors.textPrimaryColor)),
// // // // // //                       ],
// // // // // //                     ),
// // // // // //                     Row(
// // // // // //                       children: [
// // // // // //                         Text(record.formattedDate,
// // // // // //                             style: GoogleFonts.poppins(
// // // // // //                                 fontSize: 11,
// // // // // //                                 color: AppColors.textSecondaryColor)),
// // // // // //                         if (appt.isCompleted) ...[
// // // // // //                           const SizedBox(width: 8),
// // // // // //                           GestureDetector(
// // // // // //                             onTap: () {
// // // // // //                               _c.populateRecordForm(record);
// // // // // //                               _openRecordSheet(context, size,
// // // // // //                                   appt.appointmentId,
// // // // // //                                   editingRecord: record);
// // // // // //                             },
// // // // // //                             child: Container(
// // // // // //                               padding: const EdgeInsets.all(5),
// // // // // //                               decoration: BoxDecoration(
// // // // // //                                   color: AppColors.warningColor
// // // // // //                                       .withOpacity(0.1),
// // // // // //                                   borderRadius: BorderRadius.circular(7)),
// // // // // //                               child: const Icon(Icons.edit_outlined,
// // // // // //                                   color: AppColors.warningColor,
// // // // // //                                   size: 15),
// // // // // //                             ),
// // // // // //                           ),
// // // // // //                         ],
// // // // // //                       ],
// // // // // //                     ),
// // // // // //                   ],
// // // // // //                 ),
// // // // // //                 SizedBox(height: size.customHeight(context) * 0.014),
// // // // // //                 _recordField(context, size, 'Notes', record.notes,
// // // // // //                     Icons.notes_rounded),
// // // // // //                 SizedBox(height: size.customHeight(context) * 0.01),
// // // // // //                 _recordField(context, size, 'Therapy Plan',
// // // // // //                     record.therapyPlan, Icons.health_and_safety_outlined),
// // // // // //                 SizedBox(height: size.customHeight(context) * 0.01),
// // // // // //                 _recordField(context, size, 'Progress Feedback',
// // // // // //                     record.progressFeedback, Icons.trending_up_rounded),
// // // // // //                 if (record.medication != null) ...[
// // // // // //                   SizedBox(height: size.customHeight(context) * 0.01),
// // // // // //                   _recordField(
// // // // // //                       context,
// // // // // //                       size,
// // // // // //                       'Medication',
// // // // // //                       record.medication!['name'] ?? 'None',
// // // // // //                       Icons.medication_outlined),
// // // // // //                 ],
// // // // // //               ],
// // // // // //             ),
// // // // // //           ),
// // // // // //         ],
// // // // // //       ),
// // // // // //     );
// // // // // //   }

// // // // // //   Widget _recordField(BuildContext context, CustomSize size, String label,
// // // // // //       String value, IconData icon) {
// // // // // //     return Row(
// // // // // //       crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //       children: [
// // // // // //         Icon(icon, size: 14, color: AppColors.primaryColor.withOpacity(0.7)),
// // // // // //         const SizedBox(width: 8),
// // // // // //         Expanded(
// // // // // //           child: Column(
// // // // // //             crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //             children: [
// // // // // //               Text(label,
// // // // // //                   style: GoogleFonts.poppins(
// // // // // //                       fontSize: 11,
// // // // // //                       color: AppColors.textSecondaryColor,
// // // // // //                       fontWeight: FontWeight.w500)),
// // // // // //               Text(value,
// // // // // //                   style: GoogleFonts.poppins(
// // // // // //                       fontSize: 13,
// // // // // //                       color: AppColors.textPrimaryColor)),
// // // // // //             ],
// // // // // //           ),
// // // // // //         ),
// // // // // //       ],
// // // // // //     );
// // // // // //   }

// // // // // //   Widget _card(
// // // // // //     BuildContext context,
// // // // // //     CustomSize size, {
// // // // // //     required String title,
// // // // // //     required IconData icon,
// // // // // //     required List<Widget> children,
// // // // // //   }) {
// // // // // //     return Container(
// // // // // //       padding: EdgeInsets.all(size.customWidth(context) * 0.045),
// // // // // //       decoration: BoxDecoration(
// // // // // //         color: AppColors.whiteColor,
// // // // // //         borderRadius: BorderRadius.circular(18),
// // // // // //         boxShadow: [
// // // // // //           BoxShadow(
// // // // // //               color: Colors.black.withOpacity(0.05),
// // // // // //               blurRadius: 10,
// // // // // //               offset: const Offset(0, 3))
// // // // // //         ],
// // // // // //       ),
// // // // // //       child: Column(
// // // // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //         children: [
// // // // // //           Row(
// // // // // //             children: [
// // // // // //               Container(
// // // // // //                 padding: const EdgeInsets.all(8),
// // // // // //                 decoration: BoxDecoration(
// // // // // //                     color: AppColors.primaryColor.withOpacity(0.1),
// // // // // //                     borderRadius: BorderRadius.circular(10)),
// // // // // //                 child:
// // // // // //                     Icon(icon, color: AppColors.primaryColor, size: 18),
// // // // // //               ),
// // // // // //               const SizedBox(width: 10),
// // // // // //               Text(title,
// // // // // //                   style: GoogleFonts.poppins(
// // // // // //                       fontSize: 14,
// // // // // //                       fontWeight: FontWeight.w600,
// // // // // //                       color: AppColors.textPrimaryColor)),
// // // // // //             ],
// // // // // //           ),
// // // // // //           SizedBox(height: size.customHeight(context) * 0.014),
// // // // // //           Divider(
// // // // // //               height: 1, color: AppColors.greyColor.withOpacity(0.15)),
// // // // // //           SizedBox(height: size.customHeight(context) * 0.012),
// // // // // //           ...children,
// // // // // //         ],
// // // // // //       ),
// // // // // //     );
// // // // // //   }

// // // // // //   Widget _detailRow(BuildContext context, CustomSize size, String label,
// // // // // //       String value, IconData icon) {
// // // // // //     return Padding(
// // // // // //       padding: EdgeInsets.only(bottom: size.customHeight(context) * 0.01),
// // // // // //       child: Row(
// // // // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //         children: [
// // // // // //           Icon(icon,
// // // // // //               size: 14, color: AppColors.textSecondaryColor),
// // // // // //           const SizedBox(width: 10),
// // // // // //           SizedBox(
// // // // // //             width: size.customWidth(context) * 0.25,
// // // // // //             child: Text(label,
// // // // // //                 style: GoogleFonts.poppins(
// // // // // //                     fontSize: 12,
// // // // // //                     color: AppColors.textSecondaryColor,
// // // // // //                     fontWeight: FontWeight.w500)),
// // // // // //           ),
// // // // // //           Expanded(
// // // // // //             child: Text(value,
// // // // // //                 style: GoogleFonts.poppins(
// // // // // //                     fontSize: 13,
// // // // // //                     color: AppColors.textPrimaryColor,
// // // // // //                     fontWeight: FontWeight.w500),
// // // // // //                 maxLines: 3,
// // // // // //                 overflow: TextOverflow.ellipsis),
// // // // // //           ),
// // // // // //         ],
// // // // // //       ),
// // // // // //     );
// // // // // //   }

// // // // // //   // ── Dialogs ────────────────────────────────────────────────

// // // // // //   void _confirmDialog(BuildContext context, String id) {
// // // // // //     _simpleConfirmDialog(
// // // // // //       context: context,
// // // // // //       title: 'Confirm Appointment?',
// // // // // //       message: 'This will confirm the appointment for the patient.',
// // // // // //       confirmLabel: 'Confirm',
// // // // // //       confirmColor: AppColors.primaryColor,
// // // // // //       icon: Icons.check_circle_outline_rounded,
// // // // // //       onConfirm: () async {
// // // // // //         final ok = await _c.confirmAppointment(id);
// // // // // //         if (ok && context.mounted) Navigator.pop(context);
// // // // // //       },
// // // // // //     );
// // // // // //   }

// // // // // //   void _completeDialog(BuildContext context, String id) {
// // // // // //     _simpleConfirmDialog(
// // // // // //       context: context,
// // // // // //       title: 'Mark as Completed?',
// // // // // //       message: 'This will mark the appointment as completed.',
// // // // // //       confirmLabel: 'Complete',
// // // // // //       confirmColor: AppColors.successColor,
// // // // // //       icon: Icons.task_alt_rounded,
// // // // // //       onConfirm: () async {
// // // // // //         final ok = await _c.completeAppointment(id);
// // // // // //         if (ok && context.mounted) Navigator.pop(context);
// // // // // //       },
// // // // // //     );
// // // // // //   }

// // // // // //   void _noShowDialog(BuildContext context, String id) {
// // // // // //     _simpleConfirmDialog(
// // // // // //       context: context,
// // // // // //       title: 'Mark as No Show?',
// // // // // //       message: 'Patient did not attend. Mark as no-show?',
// // // // // //       confirmLabel: 'No Show',
// // // // // //       confirmColor: AppColors.greyColor,
// // // // // //       icon: Icons.person_off_outlined,
// // // // // //       onConfirm: () async {
// // // // // //         final ok = await _c.markNoShow(id);
// // // // // //         if (ok && context.mounted) Navigator.pop(context);
// // // // // //       },
// // // // // //     );
// // // // // //   }

// // // // // //   void _cancelDialog(BuildContext context, String id) {
// // // // // //     showDialog(
// // // // // //       context: context,
// // // // // //       barrierDismissible: false,
// // // // // //       builder: (_) => _CancelDialog(id: id, controller: _c),
// // // // // //     );
// // // // // //   }

// // // // // //   void _simpleConfirmDialog({
// // // // // //     required BuildContext context,
// // // // // //     required String title,
// // // // // //     required String message,
// // // // // //     required String confirmLabel,
// // // // // //     required Color confirmColor,
// // // // // //     required IconData icon,
// // // // // //     required Future<void> Function() onConfirm,
// // // // // //   }) {
// // // // // //     showDialog(
// // // // // //       context: context,
// // // // // //       barrierDismissible: false,
// // // // // //       builder: (_) => _SimpleActionDialog(
// // // // // //         title: title,
// // // // // //         message: message,
// // // // // //         confirmLabel: confirmLabel,
// // // // // //         confirmColor: confirmColor,
// // // // // //         icon: icon,
// // // // // //         controller: _c,
// // // // // //         onConfirm: onConfirm,
// // // // // //       ),
// // // // // //     );
// // // // // //   }

// // // // // //   void _openRecordSheet(BuildContext context, CustomSize size,
// // // // // //       String appointmentId,
// // // // // //       {AppointmentRecordItem? editingRecord}) {
// // // // // //     showModalBottomSheet(
// // // // // //       context: context,
// // // // // //       isScrollControlled: true,
// // // // // //       backgroundColor: Colors.transparent,
// // // // // //       builder: (_) => ConstrainedBox(
// // // // // //         constraints: BoxConstraints(
// // // // // //             maxHeight: MediaQuery.of(context).size.height * 0.93),
// // // // // //         child: _RecordFormSheet(
// // // // // //           controller: _c,
// // // // // //           size: size,
// // // // // //           appointmentId: appointmentId,
// // // // // //           editingRecord: editingRecord,
// // // // // //         ),
// // // // // //       ),
// // // // // //     );
// // // // // //   }

// // // // // //   Widget _loader(BuildContext context, CustomSize size) {
// // // // // //     return Scaffold(
// // // // // //       appBar: AppBar(
// // // // // //           backgroundColor: AppColors.whiteColor,
// // // // // //           elevation: 0,
// // // // // //           leading: IconButton(
// // // // // //               icon: const Icon(Icons.arrow_back_ios_new_rounded,
// // // // // //                   color: AppColors.textPrimaryColor),
// // // // // //               onPressed: () => Get.back())),
// // // // // //       body: const Center(
// // // // // //         child: CircularProgressIndicator(
// // // // // //             color: AppColors.primaryColor, strokeWidth: 3),
// // // // // //       ),
// // // // // //     );
// // // // // //   }

// // // // // //   Widget _errorState(BuildContext context, CustomSize size) {
// // // // // //     return Scaffold(
// // // // // //       appBar: AppBar(
// // // // // //           backgroundColor: AppColors.whiteColor,
// // // // // //           elevation: 0,
// // // // // //           leading: IconButton(
// // // // // //               icon: const Icon(Icons.arrow_back_ios_new_rounded,
// // // // // //                   color: AppColors.textPrimaryColor),
// // // // // //               onPressed: () => Get.back())),
// // // // // //       body: Center(
// // // // // //         child: Text('Appointment not found',
// // // // // //             style: GoogleFonts.poppins(
// // // // // //                 color: AppColors.textSecondaryColor)),
// // // // // //       ),
// // // // // //     );
// // // // // //   }

// // // // // //   _StatusMeta _statusMeta(String status) {
// // // // // //     switch (status.toLowerCase()) {
// // // // // //       case 'confirmed':
// // // // // //         return _StatusMeta(AppColors.primaryColor, 'Confirmed');
// // // // // //       case 'completed':
// // // // // //         return _StatusMeta(AppColors.successColor, 'Completed');
// // // // // //       case 'cancelled':
// // // // // //         return _StatusMeta(AppColors.errorColor, 'Cancelled');
// // // // // //       case 'no_show':
// // // // // //         return _StatusMeta(AppColors.greyColor, 'No Show');
// // // // // //       default:
// // // // // //         return _StatusMeta(AppColors.warningColor, 'Scheduled');
// // // // // //     }
// // // // // //   }

// // // // // //   IconData _modeIcon(String mode) {
// // // // // //     switch (mode.toLowerCase()) {
// // // // // //       case 'online':
// // // // // //         return Icons.videocam_outlined;
// // // // // //       case 'physical':
// // // // // //         return Icons.location_on_outlined;
// // // // // //       default:
// // // // // //         return Icons.swap_horiz_rounded;
// // // // // //     }
// // // // // //   }
// // // // // // }

// // // // // // class _StatusMeta {
// // // // // //   final Color color;
// // // // // //   final String label;
// // // // // //   _StatusMeta(this.color, this.label);
// // // // // // }

// // // // // // class _ActionBtn {
// // // // // //   final String label;
// // // // // //   final IconData icon;
// // // // // //   final Color color;
// // // // // //   final VoidCallback onTap;
// // // // // //   _ActionBtn(
// // // // // //       {required this.label,
// // // // // //       required this.icon,
// // // // // //       required this.color,
// // // // // //       required this.onTap});
// // // // // // }

// // // // // // // ── Simple action confirm dialog ────────────────────────────────
// // // // // // class _SimpleActionDialog extends StatefulWidget {
// // // // // //   final String title, message, confirmLabel;
// // // // // //   final Color confirmColor;
// // // // // //   final IconData icon;
// // // // // //   final MyAppointmentController controller;
// // // // // //   final Future<void> Function() onConfirm;

// // // // // //   const _SimpleActionDialog({
// // // // // //     required this.title,
// // // // // //     required this.message,
// // // // // //     required this.confirmLabel,
// // // // // //     required this.confirmColor,
// // // // // //     required this.icon,
// // // // // //     required this.controller,
// // // // // //     required this.onConfirm,
// // // // // //   });

// // // // // //   @override
// // // // // //   State<_SimpleActionDialog> createState() => _SimpleActionDialogState();
// // // // // // }

// // // // // // class _SimpleActionDialogState extends State<_SimpleActionDialog> {
// // // // // //   bool _loading = false;

// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     return AlertDialog(
// // // // // //       shape:
// // // // // //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
// // // // // //       contentPadding: const EdgeInsets.all(24),
// // // // // //       content: Column(
// // // // // //         mainAxisSize: MainAxisSize.min,
// // // // // //         children: [
// // // // // //           Container(
// // // // // //             padding: const EdgeInsets.all(14),
// // // // // //             decoration: BoxDecoration(
// // // // // //                 color: widget.confirmColor.withOpacity(0.1),
// // // // // //                 shape: BoxShape.circle),
// // // // // //             child: Icon(widget.icon,
// // // // // //                 color: widget.confirmColor, size: 32),
// // // // // //           ),
// // // // // //           const SizedBox(height: 14),
// // // // // //           Text(widget.title,
// // // // // //               style: GoogleFonts.poppins(
// // // // // //                   fontSize: 17,
// // // // // //                   fontWeight: FontWeight.bold,
// // // // // //                   color: AppColors.textPrimaryColor),
// // // // // //               textAlign: TextAlign.center),
// // // // // //           const SizedBox(height: 8),
// // // // // //           Text(widget.message,
// // // // // //               style: GoogleFonts.poppins(
// // // // // //                   fontSize: 13, color: AppColors.textSecondaryColor),
// // // // // //               textAlign: TextAlign.center),
// // // // // //           const SizedBox(height: 22),
// // // // // //           Row(
// // // // // //             children: [
// // // // // //               Expanded(
// // // // // //                 child: OutlinedButton(
// // // // // //                   onPressed:
// // // // // //                       _loading ? null : () => Navigator.pop(context),
// // // // // //                   style: OutlinedButton.styleFrom(
// // // // // //                     foregroundColor: AppColors.textSecondaryColor,
// // // // // //                     side: BorderSide(
// // // // // //                         color: AppColors.greyColor.withOpacity(0.4)),
// // // // // //                     shape: RoundedRectangleBorder(
// // // // // //                         borderRadius: BorderRadius.circular(12)),
// // // // // //                     padding:
// // // // // //                         const EdgeInsets.symmetric(vertical: 12),
// // // // // //                   ),
// // // // // //                   child: Text('Cancel',
// // // // // //                       style: GoogleFonts.poppins(
// // // // // //                           fontWeight: FontWeight.w500, fontSize: 13)),
// // // // // //                 ),
// // // // // //               ),
// // // // // //               const SizedBox(width: 12),
// // // // // //               Expanded(
// // // // // //                 child: ElevatedButton(
// // // // // //                   onPressed: _loading
// // // // // //                       ? null
// // // // // //                       : () async {
// // // // // //                           setState(() => _loading = true);
// // // // // //                           await widget.onConfirm();
// // // // // //                           if (mounted) setState(() => _loading = false);
// // // // // //                         },
// // // // // //                   style: ElevatedButton.styleFrom(
// // // // // //                     backgroundColor: widget.confirmColor,
// // // // // //                     foregroundColor: Colors.white,
// // // // // //                     disabledBackgroundColor:
// // // // // //                         widget.confirmColor.withOpacity(0.5),
// // // // // //                     shape: RoundedRectangleBorder(
// // // // // //                         borderRadius: BorderRadius.circular(12)),
// // // // // //                     padding:
// // // // // //                         const EdgeInsets.symmetric(vertical: 12),
// // // // // //                     elevation: 0,
// // // // // //                   ),
// // // // // //                   child: _loading
// // // // // //                       ? const SizedBox(
// // // // // //                           width: 18,
// // // // // //                           height: 18,
// // // // // //                           child: CircularProgressIndicator(
// // // // // //                               color: Colors.white, strokeWidth: 2))
// // // // // //                       : Text(widget.confirmLabel,
// // // // // //                           style: GoogleFonts.poppins(
// // // // // //                               fontWeight: FontWeight.w600,
// // // // // //                               fontSize: 13)),
// // // // // //                 ),
// // // // // //               ),
// // // // // //             ],
// // // // // //           ),
// // // // // //         ],
// // // // // //       ),
// // // // // //     );
// // // // // //   }
// // // // // // }

// // // // // // // ── Cancel dialog with reason ───────────────────────────────────
// // // // // // class _CancelDialog extends StatefulWidget {
// // // // // //   final String id;
// // // // // //   final MyAppointmentController controller;

// // // // // //   const _CancelDialog({required this.id, required this.controller});

// // // // // //   @override
// // // // // //   State<_CancelDialog> createState() => _CancelDialogState();
// // // // // // }

// // // // // // class _CancelDialogState extends State<_CancelDialog> {
// // // // // //   final _reasonCtrl = TextEditingController();
// // // // // //   bool _loading = false;

// // // // // //   @override
// // // // // //   void dispose() {
// // // // // //     _reasonCtrl.dispose();
// // // // // //     super.dispose();
// // // // // //   }

// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     return AlertDialog(
// // // // // //       shape:
// // // // // //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
// // // // // //       contentPadding: const EdgeInsets.all(24),
// // // // // //       content: Column(
// // // // // //         mainAxisSize: MainAxisSize.min,
// // // // // //         children: [
// // // // // //           Container(
// // // // // //             padding: const EdgeInsets.all(14),
// // // // // //             decoration: BoxDecoration(
// // // // // //                 color: AppColors.errorColor.withOpacity(0.1),
// // // // // //                 shape: BoxShape.circle),
// // // // // //             child: const Icon(Icons.cancel_outlined,
// // // // // //                 color: AppColors.errorColor, size: 32),
// // // // // //           ),
// // // // // //           const SizedBox(height: 14),
// // // // // //           Text('Cancel Appointment?',
// // // // // //               style: GoogleFonts.poppins(
// // // // // //                   fontSize: 17,
// // // // // //                   fontWeight: FontWeight.bold,
// // // // // //                   color: AppColors.textPrimaryColor)),
// // // // // //           const SizedBox(height: 16),
// // // // // //           TextField(
// // // // // //             controller: _reasonCtrl,
// // // // // //             maxLines: 3,
// // // // // //             style: GoogleFonts.poppins(
// // // // // //                 fontSize: 13, color: AppColors.textPrimaryColor),
// // // // // //             decoration: InputDecoration(
// // // // // //               hintText: 'Enter cancellation reason...',
// // // // // //               hintStyle: GoogleFonts.poppins(
// // // // // //                   fontSize: 13,
// // // // // //                   color: AppColors.textSecondaryColor.withOpacity(0.7)),
// // // // // //               filled: true,
// // // // // //               fillColor: AppColors.lightGreyColor,
// // // // // //               contentPadding: const EdgeInsets.all(14),
// // // // // //               border: OutlineInputBorder(
// // // // // //                   borderRadius: BorderRadius.circular(12),
// // // // // //                   borderSide: BorderSide.none),
// // // // // //               enabledBorder: OutlineInputBorder(
// // // // // //                   borderRadius: BorderRadius.circular(12),
// // // // // //                   borderSide: BorderSide(
// // // // // //                       color: AppColors.greyColor.withOpacity(0.2))),
// // // // // //               focusedBorder: OutlineInputBorder(
// // // // // //                   borderRadius: BorderRadius.circular(12),
// // // // // //                   borderSide: const BorderSide(
// // // // // //                       color: AppColors.primaryColor, width: 1.5)),
// // // // // //             ),
// // // // // //           ),
// // // // // //           const SizedBox(height: 20),
// // // // // //           Row(
// // // // // //             children: [
// // // // // //               Expanded(
// // // // // //                 child: OutlinedButton(
// // // // // //                   onPressed:
// // // // // //                       _loading ? null : () => Navigator.pop(context),
// // // // // //                   style: OutlinedButton.styleFrom(
// // // // // //                     foregroundColor: AppColors.textSecondaryColor,
// // // // // //                     side: BorderSide(
// // // // // //                         color: AppColors.greyColor.withOpacity(0.4)),
// // // // // //                     shape: RoundedRectangleBorder(
// // // // // //                         borderRadius: BorderRadius.circular(12)),
// // // // // //                     padding:
// // // // // //                         const EdgeInsets.symmetric(vertical: 12),
// // // // // //                   ),
// // // // // //                   child: Text('Back',
// // // // // //                       style: GoogleFonts.poppins(
// // // // // //                           fontWeight: FontWeight.w500, fontSize: 13)),
// // // // // //                 ),
// // // // // //               ),
// // // // // //               const SizedBox(width: 12),
// // // // // //               Expanded(
// // // // // //                 child: ElevatedButton(
// // // // // //                   onPressed: _loading
// // // // // //                       ? null
// // // // // //                       : () async {
// // // // // //                           final reason = _reasonCtrl.text.trim();
// // // // // //                           if (reason.isEmpty) {
// // // // // //                             Get.snackbar('Required',
// // // // // //                                 'Please enter a cancellation reason',
// // // // // //                                 snackPosition: SnackPosition.BOTTOM,
// // // // // //                                 backgroundColor: AppColors.warningColor,
// // // // // //                                 colorText: Colors.white,
// // // // // //                                 margin: const EdgeInsets.all(16),
// // // // // //                                 borderRadius: 12);
// // // // // //                             return;
// // // // // //                           }
// // // // // //                           setState(() => _loading = true);
// // // // // //                           final ok = await widget.controller
// // // // // //                               .cancelAppointment(widget.id, reason);
// // // // // //                           if (mounted) setState(() => _loading = false);
// // // // // //                           if (ok && context.mounted) Navigator.pop(context);
// // // // // //                         },
// // // // // //                   style: ElevatedButton.styleFrom(
// // // // // //                     backgroundColor: AppColors.errorColor,
// // // // // //                     foregroundColor: Colors.white,
// // // // // //                     disabledBackgroundColor:
// // // // // //                         AppColors.errorColor.withOpacity(0.5),
// // // // // //                     shape: RoundedRectangleBorder(
// // // // // //                         borderRadius: BorderRadius.circular(12)),
// // // // // //                     padding:
// // // // // //                         const EdgeInsets.symmetric(vertical: 12),
// // // // // //                     elevation: 0,
// // // // // //                   ),
// // // // // //                   child: _loading
// // // // // //                       ? const SizedBox(
// // // // // //                           width: 18,
// // // // // //                           height: 18,
// // // // // //                           child: CircularProgressIndicator(
// // // // // //                               color: Colors.white, strokeWidth: 2))
// // // // // //                       : Text('Cancel Appt.',
// // // // // //                           style: GoogleFonts.poppins(
// // // // // //                               fontWeight: FontWeight.w600,
// // // // // //                               fontSize: 13)),
// // // // // //                 ),
// // // // // //               ),
// // // // // //             ],
// // // // // //           ),
// // // // // //         ],
// // // // // //       ),
// // // // // //     );
// // // // // //   }
// // // // // // }

// // // // // // // ── Record form bottom sheet ────────────────────────────────────
// // // // // // class _RecordFormSheet extends StatefulWidget {
// // // // // //   final MyAppointmentController controller;
// // // // // //   final CustomSize size;
// // // // // //   final String appointmentId;
// // // // // //   final AppointmentRecordItem? editingRecord;

// // // // // //   const _RecordFormSheet({
// // // // // //     required this.controller,
// // // // // //     required this.size,
// // // // // //     required this.appointmentId,
// // // // // //     this.editingRecord,
// // // // // //   });

// // // // // //   @override
// // // // // //   State<_RecordFormSheet> createState() => _RecordFormSheetState();
// // // // // // }

// // // // // // class _RecordFormSheetState extends State<_RecordFormSheet> {
// // // // // //   final _formKey = GlobalKey<FormState>();
// // // // // //   bool _saving = false;

// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     final size = widget.size;
// // // // // //     final isEdit = widget.editingRecord != null;

// // // // // //     return Container(
// // // // // //       decoration: const BoxDecoration(
// // // // // //         color: AppColors.whiteColor,
// // // // // //         borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
// // // // // //       ),
// // // // // //       padding:
// // // // // //           EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
// // // // // //       child: SingleChildScrollView(
// // // // // //         physics: const ClampingScrollPhysics(),
// // // // // //         padding: EdgeInsets.fromLTRB(
// // // // // //           size.customWidth(context) * 0.05,
// // // // // //           20,
// // // // // //           size.customWidth(context) * 0.05,
// // // // // //           size.customHeight(context) * 0.04,
// // // // // //         ),
// // // // // //         child: Form(
// // // // // //           key: _formKey,
// // // // // //           child: Column(
// // // // // //             crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //             mainAxisSize: MainAxisSize.min,
// // // // // //             children: [
// // // // // //               // Handle
// // // // // //               Center(
// // // // // //                 child: Container(
// // // // // //                   width: 44, height: 4,
// // // // // //                   decoration: BoxDecoration(
// // // // // //                       color: AppColors.greyColor.withOpacity(0.3),
// // // // // //                       borderRadius: BorderRadius.circular(2)),
// // // // // //                 ),
// // // // // //               ),
// // // // // //               const SizedBox(height: 20),

// // // // // //               // Header
// // // // // //               Row(
// // // // // //                 children: [
// // // // // //                   Container(
// // // // // //                     padding: const EdgeInsets.all(10),
// // // // // //                     decoration: BoxDecoration(
// // // // // //                         color: AppColors.primaryColor.withOpacity(0.1),
// // // // // //                         borderRadius: BorderRadius.circular(12)),
// // // // // //                     child: Icon(
// // // // // //                         isEdit
// // // // // //                             ? Icons.edit_note_rounded
// // // // // //                             : Icons.note_add_rounded,
// // // // // //                         color: AppColors.primaryColor, size: 22),
// // // // // //                   ),
// // // // // //                   const SizedBox(width: 12),
// // // // // //                   Expanded(
// // // // // //                     child: Column(
// // // // // //                       crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //                       children: [
// // // // // //                         Text(
// // // // // //                           isEdit ? 'Update Record' : 'New Session Record',
// // // // // //                           style: GoogleFonts.poppins(
// // // // // //                               fontSize: size.customWidth(context) * 0.044,
// // // // // //                               fontWeight: FontWeight.bold,
// // // // // //                               color: AppColors.textPrimaryColor),
// // // // // //                         ),
// // // // // //                         Text(
// // // // // //                           isEdit
// // // // // //                               ? 'Edit session details'
// // // // // //                               : 'Document this session',
// // // // // //                           style: GoogleFonts.poppins(
// // // // // //                               fontSize: size.customWidth(context) * 0.031,
// // // // // //                               color: AppColors.textSecondaryColor),
// // // // // //                         ),
// // // // // //                       ],
// // // // // //                     ),
// // // // // //                   ),
// // // // // //                 ],
// // // // // //               ),
// // // // // //               SizedBox(height: size.customHeight(context) * 0.025),

// // // // // //               _formField(context, size, 'Session Notes',
// // // // // //                   'Describe what happened during the session...',
// // // // // //                   Icons.notes_rounded, widget.controller.notesCtrl,
// // // // // //                   maxLines: 3, required: true),
// // // // // //               SizedBox(height: size.customHeight(context) * 0.018),

// // // // // //               _formField(context, size, 'Therapy Plan',
// // // // // //                   'Outline the plan for next sessions...',
// // // // // //                   Icons.health_and_safety_outlined,
// // // // // //                   widget.controller.therapyPlanCtrl,
// // // // // //                   maxLines: 3, required: true),
// // // // // //               SizedBox(height: size.customHeight(context) * 0.018),

// // // // // //               _formField(context, size, 'Progress Feedback',
// // // // // //                   'How did the patient progress?',
// // // // // //                   Icons.trending_up_rounded,
// // // // // //                   widget.controller.progressFeedbackCtrl,
// // // // // //                   maxLines: 2, required: true),
// // // // // //               SizedBox(height: size.customHeight(context) * 0.018),

// // // // // //               Text('Medication (optional)',
// // // // // //                   style: GoogleFonts.poppins(
// // // // // //                       fontSize: size.customWidth(context) * 0.036,
// // // // // //                       fontWeight: FontWeight.w600,
// // // // // //                       color: AppColors.textPrimaryColor)),
// // // // // //               SizedBox(height: size.customHeight(context) * 0.01),
// // // // // //               Row(
// // // // // //                 children: [
// // // // // //                   Expanded(
// // // // // //                     child: _formField(context, size, 'Name', 'e.g. None',
// // // // // //                         Icons.medication_outlined,
// // // // // //                         widget.controller.medicationNameCtrl,
// // // // // //                         maxLines: 1, required: false),
// // // // // //                   ),
// // // // // //                   SizedBox(width: size.customWidth(context) * 0.03),
// // // // // //                   Expanded(
// // // // // //                     child: _formField(context, size, 'Dosage',
// // // // // //                         'e.g. 5mg', Icons.science_outlined,
// // // // // //                         widget.controller.medicationDosageCtrl,
// // // // // //                         maxLines: 1, required: false),
// // // // // //                   ),
// // // // // //                 ],
// // // // // //               ),
// // // // // //               SizedBox(height: size.customHeight(context) * 0.03),

// // // // // //               SizedBox(
// // // // // //                 width: double.infinity,
// // // // // //                 child: ElevatedButton(
// // // // // //                   onPressed: _saving
// // // // // //                       ? null
// // // // // //                       : () async {
// // // // // //                           if (!_formKey.currentState!.validate()) return;
// // // // // //                           setState(() => _saving = true);
// // // // // //                           bool ok;
// // // // // //                           if (isEdit) {
// // // // // //                             ok = await widget.controller.updateRecord(
// // // // // //                                 widget.appointmentId,
// // // // // //                                 widget.editingRecord!.recordId);
// // // // // //                           } else {
// // // // // //                             ok = await widget.controller
// // // // // //                                 .createRecord(widget.appointmentId);
// // // // // //                           }
// // // // // //                           if (mounted) setState(() => _saving = false);
// // // // // //                           if (ok && context.mounted) Navigator.pop(context);
// // // // // //                         },
// // // // // //                   style: ElevatedButton.styleFrom(
// // // // // //                     backgroundColor: AppColors.primaryColor,
// // // // // //                     foregroundColor: Colors.white,
// // // // // //                     disabledBackgroundColor:
// // // // // //                         AppColors.primaryColor.withOpacity(0.4),
// // // // // //                     padding: EdgeInsets.symmetric(
// // // // // //                         vertical: size.customHeight(context) * 0.02),
// // // // // //                     shape: RoundedRectangleBorder(
// // // // // //                         borderRadius: BorderRadius.circular(16)),
// // // // // //                     elevation: 2,
// // // // // //                   ),
// // // // // //                   child: _saving
// // // // // //                       ? const SizedBox(
// // // // // //                           width: 22, height: 22,
// // // // // //                           child: CircularProgressIndicator(
// // // // // //                               color: Colors.white, strokeWidth: 2.5))
// // // // // //                       : Text(
// // // // // //                           isEdit ? 'Update Record' : 'Save Record',
// // // // // //                           style: GoogleFonts.poppins(
// // // // // //                               fontWeight: FontWeight.w600,
// // // // // //                               fontSize: size.customWidth(context) * 0.04)),
// // // // // //                 ),
// // // // // //               ),
// // // // // //             ],
// // // // // //           ),
// // // // // //         ),
// // // // // //       ),
// // // // // //     );
// // // // // //   }

// // // // // //   Widget _formField(
// // // // // //     BuildContext context,
// // // // // //     CustomSize size,
// // // // // //     String label,
// // // // // //     String hint,
// // // // // //     IconData icon,
// // // // // //     TextEditingController ctrl, {
// // // // // //     int maxLines = 1,
// // // // // //     bool required = true,
// // // // // //   }) {
// // // // // //     return Column(
// // // // // //       crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //       children: [
// // // // // //         Text(label,
// // // // // //             style: GoogleFonts.poppins(
// // // // // //                 fontSize: size.customWidth(context) * 0.034,
// // // // // //                 fontWeight: FontWeight.w600,
// // // // // //                 color: AppColors.textPrimaryColor)),
// // // // // //         const SizedBox(height: 6),
// // // // // //         TextFormField(
// // // // // //           controller: ctrl,
// // // // // //           maxLines: maxLines,
// // // // // //           validator: required
// // // // // //               ? (v) => v == null || v.trim().isEmpty
// // // // // //                   ? '$label is required'
// // // // // //                   : null
// // // // // //               : null,
// // // // // //           style: GoogleFonts.poppins(
// // // // // //               fontSize: 13, color: AppColors.textPrimaryColor),
// // // // // //           decoration: InputDecoration(
// // // // // //             hintText: hint,
// // // // // //             hintStyle: GoogleFonts.poppins(
// // // // // //                 fontSize: 13,
// // // // // //                 color: AppColors.textSecondaryColor.withOpacity(0.7)),
// // // // // //             prefixIcon: maxLines == 1
// // // // // //                 ? Icon(icon, color: AppColors.primaryColor, size: 20)
// // // // // //                 : null,
// // // // // //             filled: true,
// // // // // //             fillColor: AppColors.lightGreyColor,
// // // // // //             contentPadding: EdgeInsets.symmetric(
// // // // // //                 horizontal: 16, vertical: maxLines > 1 ? 14 : 0),
// // // // // //             border: OutlineInputBorder(
// // // // // //                 borderRadius: BorderRadius.circular(14),
// // // // // //                 borderSide: BorderSide.none),
// // // // // //             enabledBorder: OutlineInputBorder(
// // // // // //                 borderRadius: BorderRadius.circular(14),
// // // // // //                 borderSide: BorderSide(
// // // // // //                     color: AppColors.greyColor.withOpacity(0.2),
// // // // // //                     width: 1)),
// // // // // //             focusedBorder: OutlineInputBorder(
// // // // // //                 borderRadius: BorderRadius.circular(14),
// // // // // //                 borderSide: const BorderSide(
// // // // // //                     color: AppColors.primaryColor, width: 1.5)),
// // // // // //             errorBorder: OutlineInputBorder(
// // // // // //                 borderRadius: BorderRadius.circular(14),
// // // // // //                 borderSide: const BorderSide(
// // // // // //                     color: AppColors.errorColor, width: 1)),
// // // // // //           ),
// // // // // //         ),
// // // // // //       ],
// // // // // //     );
// // // // // //   }
// // // // // // }


// // // // // // lib/view/expert/appointments/appointment_detail_screen.dart
// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:get/get.dart';
// // // // // import 'package:google_fonts/google_fonts.dart';
// // // // // import 'package:speechspectrum/constants/app_colors.dart';
// // // // // import 'package:speechspectrum/constants/custom_size.dart';
// // // // // import 'package:speechspectrum/controllers/my_appointment_controller.dart';
// // // // // import 'package:speechspectrum/models/my_appointment_model.dart';

// // // // // class AppointmentDetailScreen extends StatefulWidget {
// // // // //   const AppointmentDetailScreen({super.key});

// // // // //   @override
// // // // //   State<AppointmentDetailScreen> createState() =>
// // // // //       _AppointmentDetailScreenState();
// // // // // }

// // // // // class _AppointmentDetailScreenState extends State<AppointmentDetailScreen> {
// // // // //   late final MyAppointmentController _c;
// // // // //   late final String _appointmentId;

// // // // //   @override
// // // // //   void initState() {
// // // // //     super.initState();
// // // // //     _c = Get.find<MyAppointmentController>();
// // // // //     _appointmentId = Get.arguments as String;
// // // // //     WidgetsBinding.instance.addPostFrameCallback((_) {
// // // // //       _c.fetchAppointmentDetail(_appointmentId);
// // // // //       _c.fetchRecords(_appointmentId);
// // // // //     });
// // // // //   }

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     final size = CustomSize();

// // // // //     return Scaffold(
// // // // //       backgroundColor: AppColors.lightGreyColor,
// // // // //       body: Obx(() {
// // // // //         if (_c.isLoadingDetail.value) {
// // // // //           return _loader(context, size);
// // // // //         }
// // // // //         final appt = _c.selectedAppointment.value;
// // // // //         if (appt == null) {
// // // // //           return _errorState(context, size);
// // // // //         }
// // // // //         return _buildContent(context, size, appt);
// // // // //       }),
// // // // //     );
// // // // //   }

// // // // //   Widget _buildContent(
// // // // //       BuildContext context, CustomSize size, MyAppointmentItem appt) {
// // // // //     final statusMeta = _statusMeta(appt.status);

// // // // //     return CustomScrollView(
// // // // //       slivers: [
// // // // //         // ── SliverAppBar ──────────────────────────────────────
// // // // //         SliverAppBar(
// // // // //           expandedHeight: size.customHeight(context) * 0.22,
// // // // //           pinned: true,
// // // // //           backgroundColor: AppColors.primaryColor,
// // // // //           surfaceTintColor: Colors.transparent,
// // // // //           leading: GestureDetector(
// // // // //             onTap: () => Get.back(),
// // // // //             child: Container(
// // // // //               margin: const EdgeInsets.all(8),
// // // // //               decoration: BoxDecoration(
// // // // //                   color: Colors.white.withOpacity(0.15),
// // // // //                   borderRadius: BorderRadius.circular(12)),
// // // // //               child: const Icon(Icons.arrow_back_ios_new_rounded,
// // // // //                   color: Colors.white, size: 18),
// // // // //             ),
// // // // //           ),
// // // // //           flexibleSpace: FlexibleSpaceBar(
// // // // //             background: Container(
// // // // //               decoration: const BoxDecoration(
// // // // //                 gradient: LinearGradient(
// // // // //                   colors: [AppColors.primaryColor, AppColors.secondaryColor],
// // // // //                   begin: Alignment.topLeft,
// // // // //                   end: Alignment.bottomRight,
// // // // //                 ),
// // // // //               ),
// // // // //               child: SafeArea(
// // // // //                 child: Padding(
// // // // //                   padding: EdgeInsets.fromLTRB(
// // // // //                     size.customWidth(context) * 0.05,
// // // // //                     size.customHeight(context) * 0.06,
// // // // //                     size.customWidth(context) * 0.05,
// // // // //                     16,
// // // // //                   ),
// // // // //                   child: Row(
// // // // //                     children: [
// // // // //                       Container(
// // // // //                         width: 64,
// // // // //                         height: 64,
// // // // //                         decoration: BoxDecoration(
// // // // //                           color: Colors.white.withOpacity(0.2),
// // // // //                           borderRadius: BorderRadius.circular(18),
// // // // //                         ),
// // // // //                         child: Center(
// // // // //                           child: Text(
// // // // //                             appt.childInitials,
// // // // //                             style: GoogleFonts.poppins(
// // // // //                                 color: Colors.white,
// // // // //                                 fontSize: 22,
// // // // //                                 fontWeight: FontWeight.bold),
// // // // //                           ),
// // // // //                         ),
// // // // //                       ),
// // // // //                       SizedBox(width: size.customWidth(context) * 0.04),
// // // // //                       Expanded(
// // // // //                         child: Column(
// // // // //                           mainAxisSize: MainAxisSize.min,
// // // // //                           crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                           children: [
// // // // //                             Text(
// // // // //                               appt.children?.childName ?? 'Unknown',
// // // // //                               style: GoogleFonts.poppins(
// // // // //                                   color: Colors.white,
// // // // //                                   fontSize: size.customWidth(context) * 0.046,
// // // // //                                   fontWeight: FontWeight.bold),
// // // // //                             ),
// // // // //                             Text(
// // // // //                               appt.expertUsers?.specialization ?? '',
// // // // //                               style: GoogleFonts.poppins(
// // // // //                                   color: Colors.white.withOpacity(0.85),
// // // // //                                   fontSize: size.customWidth(context) * 0.032),
// // // // //                             ),
// // // // //                             const SizedBox(height: 6),
// // // // //                             Container(
// // // // //                               padding: const EdgeInsets.symmetric(
// // // // //                                   horizontal: 12, vertical: 4),
// // // // //                               decoration: BoxDecoration(
// // // // //                                 color: statusMeta.color.withOpacity(0.2),
// // // // //                                 borderRadius: BorderRadius.circular(20),
// // // // //                                 border: Border.all(
// // // // //                                     color: Colors.white.withOpacity(0.4)),
// // // // //                               ),
// // // // //                               child: Text(
// // // // //                                 statusMeta.label,
// // // // //                                 style: GoogleFonts.poppins(
// // // // //                                     color: Colors.white,
// // // // //                                     fontSize: 12,
// // // // //                                     fontWeight: FontWeight.w600),
// // // // //                               ),
// // // // //                             ),
// // // // //                           ],
// // // // //                         ),
// // // // //                       ),
// // // // //                     ],
// // // // //                   ),
// // // // //                 ),
// // // // //               ),
// // // // //             ),
// // // // //           ),
// // // // //         ),

// // // // //         // ── Body ──────────────────────────────────────────────
// // // // //         SliverPadding(
// // // // //           padding: EdgeInsets.fromLTRB(
// // // // //             size.customWidth(context) * 0.045,
// // // // //             size.customHeight(context) * 0.02,
// // // // //             size.customWidth(context) * 0.045,
// // // // //             size.customHeight(context) * 0.04,
// // // // //           ),
// // // // //           sliver: SliverList(
// // // // //             delegate: SliverChildListDelegate([
// // // // //               // Action buttons
// // // // //               _actionButtons(context, size, appt),
// // // // //               SizedBox(height: size.customHeight(context) * 0.022),

// // // // //               // Appointment info card
// // // // //               _infoCard(context, size, appt),
// // // // //               SizedBox(height: size.customHeight(context) * 0.018),

// // // // //               // Slot info card
// // // // //               if (appt.appointmentSlots != null)
// // // // //                 _slotCard(context, size, appt.appointmentSlots!),
// // // // //               if (appt.appointmentSlots != null)
// // // // //                 SizedBox(height: size.customHeight(context) * 0.018),

// // // // //               // Expert info card
// // // // //               if (appt.expertUsers != null)
// // // // //                 _expertCard(context, size, appt.expertUsers!),
// // // // //               if (appt.expertUsers != null)
// // // // //                 SizedBox(height: size.customHeight(context) * 0.018),

// // // // //               // Cancellation info
// // // // //               if (appt.isCancelled) ...[
// // // // //                 _cancellationCard(context, size, appt),
// // // // //                 SizedBox(height: size.customHeight(context) * 0.018),
// // // // //               ],

// // // // //               // Session records
// // // // //               _recordsSection(context, size, appt),
// // // // //               SizedBox(height: size.customHeight(context) * 0.04),
// // // // //             ]),
// // // // //           ),
// // // // //         ),
// // // // //       ],
// // // // //     );
// // // // //   }

// // // // //   Widget _actionButtons(
// // // // //       BuildContext context, CustomSize size, MyAppointmentItem appt) {
// // // // //     final buttons = <_ActionBtn>[];

// // // // //     if (appt.isScheduled) {
// // // // //       buttons.add(_ActionBtn(
// // // // //           label: 'Confirm',
// // // // //           icon: Icons.check_circle_outline_rounded,
// // // // //           color: AppColors.primaryColor,
// // // // //           onTap: () => _confirmDialog(context, appt.appointmentId)));
// // // // //       buttons.add(_ActionBtn(
// // // // //           label: 'Cancel',
// // // // //           icon: Icons.cancel_outlined,
// // // // //           color: AppColors.errorColor,
// // // // //           onTap: () => _cancelDialog(context, appt.appointmentId)));
// // // // //       buttons.add(_ActionBtn(
// // // // //           label: 'No Show',
// // // // //           icon: Icons.person_off_outlined,
// // // // //           color: AppColors.greyColor,
// // // // //           onTap: () => _noShowDialog(context, appt.appointmentId)));
// // // // //     } else if (appt.isConfirmed) {
// // // // //       buttons.add(_ActionBtn(
// // // // //           label: 'Complete',
// // // // //           icon: Icons.task_alt_rounded,
// // // // //           color: AppColors.successColor,
// // // // //           onTap: () => _completeDialog(context, appt.appointmentId)));
// // // // //       buttons.add(_ActionBtn(
// // // // //           label: 'Cancel',
// // // // //           icon: Icons.cancel_outlined,
// // // // //           color: AppColors.errorColor,
// // // // //           onTap: () => _cancelDialog(context, appt.appointmentId)));
// // // // //       buttons.add(_ActionBtn(
// // // // //           label: 'No Show',
// // // // //           icon: Icons.person_off_outlined,
// // // // //           color: AppColors.greyColor,
// // // // //           onTap: () => _noShowDialog(context, appt.appointmentId)));
// // // // //     }

// // // // //     if (buttons.isEmpty) return const SizedBox.shrink();

// // // // //     return Row(
// // // // //       children: buttons.map((b) {
// // // // //         return Expanded(
// // // // //           child: GestureDetector(
// // // // //             onTap: b.onTap,
// // // // //             child: Container(
// // // // //               margin: const EdgeInsets.symmetric(horizontal: 4),
// // // // //               padding: const EdgeInsets.symmetric(vertical: 12),
// // // // //               decoration: BoxDecoration(
// // // // //                 color: b.color.withOpacity(0.1),
// // // // //                 borderRadius: BorderRadius.circular(14),
// // // // //                 border: Border.all(color: b.color.withOpacity(0.3)),
// // // // //               ),
// // // // //               child: Column(
// // // // //                 mainAxisSize: MainAxisSize.min,
// // // // //                 children: [
// // // // //                   Icon(b.icon, color: b.color, size: 22),
// // // // //                   const SizedBox(height: 5),
// // // // //                   Text(b.label,
// // // // //                       style: GoogleFonts.poppins(
// // // // //                           fontSize: 11,
// // // // //                           fontWeight: FontWeight.w600,
// // // // //                           color: b.color)),
// // // // //                 ],
// // // // //               ),
// // // // //             ),
// // // // //           ),
// // // // //         );
// // // // //       }).toList(),
// // // // //     );
// // // // //   }

// // // // //   Widget _infoCard(
// // // // //       BuildContext context, CustomSize size, MyAppointmentItem appt) {
// // // // //     return _card(
// // // // //       context,
// // // // //       size,
// // // // //       title: 'Appointment Details',
// // // // //       icon: Icons.event_note_rounded,
// // // // //       children: [
// // // // //         _detailRow(context, size, 'Date', appt.formattedDate,
// // // // //             Icons.calendar_today_outlined),
// // // // //         _detailRow(context, size, 'Time', appt.formattedTime,
// // // // //             Icons.access_time_rounded),
// // // // //         _detailRow(context, size, 'Duration',
// // // // //             '${appt.durationMinutes} minutes', Icons.timer_outlined),
// // // // //         _detailRow(
// // // // //             context,
// // // // //             size,
// // // // //             'Mode',
// // // // //             appt.bookedMode[0].toUpperCase() + appt.bookedMode.substring(1),
// // // // //             _modeIcon(appt.bookedMode)),
// // // // //         _detailRow(context, size, 'Fee',
// // // // //             '${appt.currency} ${appt.feeCharged.toStringAsFixed(0)}',
// // // // //             Icons.payments_outlined),
// // // // //         if (appt.meetLink != null)
// // // // //           _detailRow(
// // // // //               context, size, 'Meet Link', appt.meetLink!, Icons.link_rounded),
// // // // //       ],
// // // // //     );
// // // // //   }

// // // // //   Widget _slotCard(
// // // // //       BuildContext context, CustomSize size, AppointmentSlot slot) {
// // // // //     return _card(
// // // // //       context,
// // // // //       size,
// // // // //       title: 'Slot Information',
// // // // //       icon: Icons.calendar_month_rounded,
// // // // //       children: [
// // // // //         _detailRow(context, size, 'Slot Date', slot.slotDate,
// // // // //             Icons.today_rounded),
// // // // //         _detailRow(context, size, 'Slot Time',
// // // // //             '${slot.formattedStart} – ${slot.formattedEnd}',
// // // // //             Icons.schedule_rounded),
// // // // //         _detailRow(context, size, 'Slot Mode',
// // // // //             slot.mode[0].toUpperCase() + slot.mode.substring(1),
// // // // //             _modeIcon(slot.mode)),
// // // // //       ],
// // // // //     );
// // // // //   }

// // // // //   Widget _expertCard(
// // // // //       BuildContext context, CustomSize size, AppointmentExpert expert) {
// // // // //     return _card(
// // // // //       context,
// // // // //       size,
// // // // //       title: 'Expert Information',
// // // // //       icon: Icons.person_outline_rounded,
// // // // //       children: [
// // // // //         _detailRow(context, size, 'Name', expert.fullName,
// // // // //             Icons.badge_outlined),
// // // // //         _detailRow(context, size, 'Specialization', expert.specialization,
// // // // //             Icons.medical_information_outlined),
// // // // //         if (expert.phone != null)
// // // // //           _detailRow(context, size, 'Phone', expert.phone!,
// // // // //               Icons.phone_outlined),
// // // // //         if (expert.contactEmail != null)
// // // // //           _detailRow(context, size, 'Email', expert.contactEmail!,
// // // // //               Icons.email_outlined),
// // // // //       ],
// // // // //     );
// // // // //   }

// // // // //   Widget _cancellationCard(
// // // // //       BuildContext context, CustomSize size, MyAppointmentItem appt) {
// // // // //     return Container(
// // // // //       padding: EdgeInsets.all(size.customWidth(context) * 0.045),
// // // // //       decoration: BoxDecoration(
// // // // //         color: AppColors.errorColor.withOpacity(0.05),
// // // // //         borderRadius: BorderRadius.circular(18),
// // // // //         border:
// // // // //             Border.all(color: AppColors.errorColor.withOpacity(0.2)),
// // // // //       ),
// // // // //       child: Column(
// // // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // // //         children: [
// // // // //           Row(
// // // // //             children: [
// // // // //               const Icon(Icons.cancel_outlined,
// // // // //                   color: AppColors.errorColor, size: 18),
// // // // //               const SizedBox(width: 8),
// // // // //               Text('Cancellation Info',
// // // // //                   style: GoogleFonts.poppins(
// // // // //                       fontSize: 14,
// // // // //                       fontWeight: FontWeight.w600,
// // // // //                       color: AppColors.errorColor)),
// // // // //             ],
// // // // //           ),
// // // // //           const SizedBox(height: 12),
// // // // //           if (appt.cancelledBy != null)
// // // // //             _detailRow(context, size, 'Cancelled By',
// // // // //                 appt.cancelledBy![0].toUpperCase() +
// // // // //                     appt.cancelledBy!.substring(1),
// // // // //                 Icons.person_outlined),
// // // // //           if (appt.cancellationReason != null)
// // // // //             _detailRow(context, size, 'Reason', appt.cancellationReason!,
// // // // //                 Icons.info_outline_rounded),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   Widget _recordsSection(
// // // // //       BuildContext context, CustomSize size, MyAppointmentItem appt) {
// // // // //     return Column(
// // // // //       crossAxisAlignment: CrossAxisAlignment.start,
// // // // //       children: [
// // // // //         Row(
// // // // //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // //           children: [
// // // // //             Row(
// // // // //               children: [
// // // // //                 Container(
// // // // //                   width: 4,
// // // // //                   height: 20,
// // // // //                   decoration: BoxDecoration(
// // // // //                       color: AppColors.primaryColor,
// // // // //                       borderRadius: BorderRadius.circular(2)),
// // // // //                 ),
// // // // //                 const SizedBox(width: 10),
// // // // //                 Text('Session Records',
// // // // //                     style: GoogleFonts.poppins(
// // // // //                         fontSize: size.customWidth(context) * 0.042,
// // // // //                         fontWeight: FontWeight.bold,
// // // // //                         color: AppColors.textPrimaryColor)),
// // // // //               ],
// // // // //             ),
// // // // //             if (appt.isCompleted)
// // // // //               GestureDetector(
// // // // //                 onTap: () {
// // // // //                   _c.clearRecordForm();
// // // // //                   _openRecordSheet(context, size, appt.appointmentId);
// // // // //                 },
// // // // //                 child: Container(
// // // // //                   padding: const EdgeInsets.symmetric(
// // // // //                       horizontal: 12, vertical: 7),
// // // // //                   decoration: BoxDecoration(
// // // // //                     color: AppColors.primaryColor,
// // // // //                     borderRadius: BorderRadius.circular(10),
// // // // //                   ),
// // // // //                   child: Row(
// // // // //                     mainAxisSize: MainAxisSize.min,
// // // // //                     children: [
// // // // //                       const Icon(Icons.add_rounded,
// // // // //                           color: Colors.white, size: 16),
// // // // //                       const SizedBox(width: 4),
// // // // //                       Text('Add',
// // // // //                           style: GoogleFonts.poppins(
// // // // //                               color: Colors.white,
// // // // //                               fontWeight: FontWeight.w600,
// // // // //                               fontSize: 12)),
// // // // //                     ],
// // // // //                   ),
// // // // //                 ),
// // // // //               ),
// // // // //           ],
// // // // //         ),
// // // // //         SizedBox(height: size.customHeight(context) * 0.015),

// // // // //         Obx(() {
// // // // //           if (_c.isLoadingRecords.value) {
// // // // //             return const Center(
// // // // //               child: Padding(
// // // // //                 padding: EdgeInsets.all(24),
// // // // //                 child: CircularProgressIndicator(
// // // // //                     color: AppColors.primaryColor, strokeWidth: 2),
// // // // //               ),
// // // // //             );
// // // // //           }
// // // // //           if (_c.records.isEmpty) {
// // // // //             return Container(
// // // // //               padding: const EdgeInsets.all(24),
// // // // //               decoration: BoxDecoration(
// // // // //                 color: AppColors.whiteColor,
// // // // //                 borderRadius: BorderRadius.circular(18),
// // // // //                 boxShadow: [
// // // // //                   BoxShadow(
// // // // //                       color: Colors.black.withOpacity(0.05),
// // // // //                       blurRadius: 10,
// // // // //                       offset: const Offset(0, 3))
// // // // //                 ],
// // // // //               ),
// // // // //               child: Center(
// // // // //                 child: Column(
// // // // //                   children: [
// // // // //                     Icon(Icons.note_outlined,
// // // // //                         size: 40,
// // // // //                         color: AppColors.textSecondaryColor
// // // // //                             .withOpacity(0.4)),
// // // // //                     const SizedBox(height: 10),
// // // // //                     Text(
// // // // //                       appt.isCompleted
// // // // //                           ? 'No records yet. Tap "Add" to create one.'
// // // // //                           : 'Records available for completed appointments only.',
// // // // //                       textAlign: TextAlign.center,
// // // // //                       style: GoogleFonts.poppins(
// // // // //                           fontSize: 13,
// // // // //                           color: AppColors.textSecondaryColor),
// // // // //                     ),
// // // // //                   ],
// // // // //                 ),
// // // // //               ),
// // // // //             );
// // // // //           }
// // // // //           return Column(
// // // // //             children: _c.records
// // // // //                 .map((r) => _recordCard(context, size, r, appt))
// // // // //                 .toList(),
// // // // //           );
// // // // //         }),
// // // // //       ],
// // // // //     );
// // // // //   }

// // // // //   Widget _recordCard(BuildContext context, CustomSize size,
// // // // //       AppointmentRecordItem record, MyAppointmentItem appt) {
// // // // //     return Container(
// // // // //       margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.014),
// // // // //       decoration: BoxDecoration(
// // // // //         color: AppColors.whiteColor,
// // // // //         borderRadius: BorderRadius.circular(18),
// // // // //         boxShadow: [
// // // // //           BoxShadow(
// // // // //               color: Colors.black.withOpacity(0.05),
// // // // //               blurRadius: 10,
// // // // //               offset: const Offset(0, 3))
// // // // //         ],
// // // // //       ),
// // // // //       child: Column(
// // // // //         children: [
// // // // //           Padding(
// // // // //             padding: EdgeInsets.all(size.customWidth(context) * 0.042),
// // // // //             child: Column(
// // // // //               crossAxisAlignment: CrossAxisAlignment.start,
// // // // //               children: [
// // // // //                 Row(
// // // // //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // //                   children: [
// // // // //                     Row(
// // // // //                       children: [
// // // // //                         Container(
// // // // //                           padding: const EdgeInsets.all(8),
// // // // //                           decoration: BoxDecoration(
// // // // //                               color: AppColors.primaryColor.withOpacity(0.1),
// // // // //                               borderRadius: BorderRadius.circular(10)),
// // // // //                           child: const Icon(Icons.description_outlined,
// // // // //                               color: AppColors.primaryColor, size: 18),
// // // // //                         ),
// // // // //                         const SizedBox(width: 10),
// // // // //                         Text('Session Note',
// // // // //                             style: GoogleFonts.poppins(
// // // // //                                 fontSize: 14,
// // // // //                                 fontWeight: FontWeight.w600,
// // // // //                                 color: AppColors.textPrimaryColor)),
// // // // //                       ],
// // // // //                     ),
// // // // //                     Row(
// // // // //                       children: [
// // // // //                         Text(record.formattedDate,
// // // // //                             style: GoogleFonts.poppins(
// // // // //                                 fontSize: 11,
// // // // //                                 color: AppColors.textSecondaryColor)),
// // // // //                         if (appt.isCompleted) ...[
// // // // //                           const SizedBox(width: 8),
// // // // //                           GestureDetector(
// // // // //                             onTap: () {
// // // // //                               _c.populateRecordForm(record);
// // // // //                               _openRecordSheet(context, size,
// // // // //                                   appt.appointmentId,
// // // // //                                   editingRecord: record);
// // // // //                             },
// // // // //                             child: Container(
// // // // //                               padding: const EdgeInsets.all(5),
// // // // //                               decoration: BoxDecoration(
// // // // //                                   color: AppColors.warningColor
// // // // //                                       .withOpacity(0.1),
// // // // //                                   borderRadius: BorderRadius.circular(7)),
// // // // //                               child: const Icon(Icons.edit_outlined,
// // // // //                                   color: AppColors.warningColor,
// // // // //                                   size: 15),
// // // // //                             ),
// // // // //                           ),
// // // // //                         ],
// // // // //                       ],
// // // // //                     ),
// // // // //                   ],
// // // // //                 ),
// // // // //                 SizedBox(height: size.customHeight(context) * 0.014),
// // // // //                 _recordField(context, size, 'Notes', record.notes,
// // // // //                     Icons.notes_rounded),
// // // // //                 SizedBox(height: size.customHeight(context) * 0.01),
// // // // //                 _recordField(context, size, 'Therapy Plan',
// // // // //                     record.therapyPlan, Icons.health_and_safety_outlined),
// // // // //                 SizedBox(height: size.customHeight(context) * 0.01),
// // // // //                 _recordField(context, size, 'Progress Feedback',
// // // // //                     record.progressFeedback, Icons.trending_up_rounded),
// // // // //                 if (record.medication != null) ...[
// // // // //                   SizedBox(height: size.customHeight(context) * 0.01),
// // // // //                   _recordField(
// // // // //                       context,
// // // // //                       size,
// // // // //                       'Medication',
// // // // //                       record.medication!['name'] ?? 'None',
// // // // //                       Icons.medication_outlined),
// // // // //                 ],
// // // // //               ],
// // // // //             ),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   Widget _recordField(BuildContext context, CustomSize size, String label,
// // // // //       String value, IconData icon) {
// // // // //     return Row(
// // // // //       crossAxisAlignment: CrossAxisAlignment.start,
// // // // //       children: [
// // // // //         Icon(icon, size: 14, color: AppColors.primaryColor.withOpacity(0.7)),
// // // // //         const SizedBox(width: 8),
// // // // //         Expanded(
// // // // //           child: Column(
// // // // //             crossAxisAlignment: CrossAxisAlignment.start,
// // // // //             children: [
// // // // //               Text(label,
// // // // //                   style: GoogleFonts.poppins(
// // // // //                       fontSize: 11,
// // // // //                       color: AppColors.textSecondaryColor,
// // // // //                       fontWeight: FontWeight.w500)),
// // // // //               Text(value,
// // // // //                   style: GoogleFonts.poppins(
// // // // //                       fontSize: 13,
// // // // //                       color: AppColors.textPrimaryColor)),
// // // // //             ],
// // // // //           ),
// // // // //         ),
// // // // //       ],
// // // // //     );
// // // // //   }

// // // // //   Widget _card(
// // // // //     BuildContext context,
// // // // //     CustomSize size, {
// // // // //     required String title,
// // // // //     required IconData icon,
// // // // //     required List<Widget> children,
// // // // //   }) {
// // // // //     return Container(
// // // // //       padding: EdgeInsets.all(size.customWidth(context) * 0.045),
// // // // //       decoration: BoxDecoration(
// // // // //         color: AppColors.whiteColor,
// // // // //         borderRadius: BorderRadius.circular(18),
// // // // //         boxShadow: [
// // // // //           BoxShadow(
// // // // //               color: Colors.black.withOpacity(0.05),
// // // // //               blurRadius: 10,
// // // // //               offset: const Offset(0, 3))
// // // // //         ],
// // // // //       ),
// // // // //       child: Column(
// // // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // // //         children: [
// // // // //           Row(
// // // // //             children: [
// // // // //               Container(
// // // // //                 padding: const EdgeInsets.all(8),
// // // // //                 decoration: BoxDecoration(
// // // // //                     color: AppColors.primaryColor.withOpacity(0.1),
// // // // //                     borderRadius: BorderRadius.circular(10)),
// // // // //                 child:
// // // // //                     Icon(icon, color: AppColors.primaryColor, size: 18),
// // // // //               ),
// // // // //               const SizedBox(width: 10),
// // // // //               Text(title,
// // // // //                   style: GoogleFonts.poppins(
// // // // //                       fontSize: 14,
// // // // //                       fontWeight: FontWeight.w600,
// // // // //                       color: AppColors.textPrimaryColor)),
// // // // //             ],
// // // // //           ),
// // // // //           SizedBox(height: size.customHeight(context) * 0.014),
// // // // //           Divider(
// // // // //               height: 1, color: AppColors.greyColor.withOpacity(0.15)),
// // // // //           SizedBox(height: size.customHeight(context) * 0.012),
// // // // //           ...children,
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   Widget _detailRow(BuildContext context, CustomSize size, String label,
// // // // //       String value, IconData icon) {
// // // // //     return Padding(
// // // // //       padding: EdgeInsets.only(bottom: size.customHeight(context) * 0.01),
// // // // //       child: Row(
// // // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // // //         children: [
// // // // //           Icon(icon,
// // // // //               size: 14, color: AppColors.textSecondaryColor),
// // // // //           const SizedBox(width: 10),
// // // // //           SizedBox(
// // // // //             width: size.customWidth(context) * 0.25,
// // // // //             child: Text(label,
// // // // //                 style: GoogleFonts.poppins(
// // // // //                     fontSize: 12,
// // // // //                     color: AppColors.textSecondaryColor,
// // // // //                     fontWeight: FontWeight.w500)),
// // // // //           ),
// // // // //           Expanded(
// // // // //             child: Text(value,
// // // // //                 style: GoogleFonts.poppins(
// // // // //                     fontSize: 13,
// // // // //                     color: AppColors.textPrimaryColor,
// // // // //                     fontWeight: FontWeight.w500),
// // // // //                 maxLines: 3,
// // // // //                 overflow: TextOverflow.ellipsis),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   // ── Dialogs ────────────────────────────────────────────────

// // // // //   void _confirmDialog(BuildContext context, String id) {
// // // // //     _simpleConfirmDialog(
// // // // //       context: context,
// // // // //       title: 'Confirm Appointment?',
// // // // //       message: 'This will confirm the appointment for the patient.',
// // // // //       confirmLabel: 'Confirm',
// // // // //       confirmColor: AppColors.primaryColor,
// // // // //       icon: Icons.check_circle_outline_rounded,
// // // // //       onConfirm: () => _c.confirmAppointment(id),
// // // // //     );
// // // // //   }

// // // // //   void _completeDialog(BuildContext context, String id) {
// // // // //     _simpleConfirmDialog(
// // // // //       context: context,
// // // // //       title: 'Mark as Completed?',
// // // // //       message: 'This will mark the appointment as completed.',
// // // // //       confirmLabel: 'Complete',
// // // // //       confirmColor: AppColors.successColor,
// // // // //       icon: Icons.task_alt_rounded,
// // // // //       onConfirm: () => _c.completeAppointment(id),
// // // // //     );
// // // // //   }

// // // // //   void _noShowDialog(BuildContext context, String id) {
// // // // //     _simpleConfirmDialog(
// // // // //       context: context,
// // // // //       title: 'Mark as No Show?',
// // // // //       message: 'Patient did not attend. Mark as no-show?',
// // // // //       confirmLabel: 'No Show',
// // // // //       confirmColor: AppColors.greyColor,
// // // // //       icon: Icons.person_off_outlined,
// // // // //       onConfirm: () => _c.markNoShow(id),
// // // // //     );
// // // // //   }

// // // // //   void _cancelDialog(BuildContext context, String id) {
// // // // //     showDialog(
// // // // //       context: context,
// // // // //       barrierDismissible: false,
// // // // //       builder: (_) => _CancelDialog(id: id, controller: _c),
// // // // //     );
// // // // //   }

// // // // //   void _simpleConfirmDialog({
// // // // //     required BuildContext context,
// // // // //     required String title,
// // // // //     required String message,
// // // // //     required String confirmLabel,
// // // // //     required Color confirmColor,
// // // // //     required IconData icon,
// // // // //     required Future<bool> Function() onConfirm,
// // // // //   }) {
// // // // //     showDialog(
// // // // //       context: context,
// // // // //       barrierDismissible: false,
// // // // //       builder: (_) => _SimpleActionDialog(
// // // // //         title: title,
// // // // //         message: message,
// // // // //         confirmLabel: confirmLabel,
// // // // //         confirmColor: confirmColor,
// // // // //         icon: icon,
// // // // //         controller: _c,
// // // // //         onConfirm: onConfirm,
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   void _openRecordSheet(BuildContext context, CustomSize size,
// // // // //       String appointmentId,
// // // // //       {AppointmentRecordItem? editingRecord}) {
// // // // //     showModalBottomSheet(
// // // // //       context: context,
// // // // //       isScrollControlled: true,
// // // // //       backgroundColor: Colors.transparent,
// // // // //       builder: (_) => ConstrainedBox(
// // // // //         constraints: BoxConstraints(
// // // // //             maxHeight: MediaQuery.of(context).size.height * 0.93),
// // // // //         child: _RecordFormSheet(
// // // // //           controller: _c,
// // // // //           size: size,
// // // // //           appointmentId: appointmentId,
// // // // //           editingRecord: editingRecord,
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   Widget _loader(BuildContext context, CustomSize size) {
// // // // //     return Scaffold(
// // // // //       appBar: AppBar(
// // // // //           backgroundColor: AppColors.whiteColor,
// // // // //           elevation: 0,
// // // // //           leading: IconButton(
// // // // //               icon: const Icon(Icons.arrow_back_ios_new_rounded,
// // // // //                   color: AppColors.textPrimaryColor),
// // // // //               onPressed: () => Get.back())),
// // // // //       body: const Center(
// // // // //         child: CircularProgressIndicator(
// // // // //             color: AppColors.primaryColor, strokeWidth: 3),
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   Widget _errorState(BuildContext context, CustomSize size) {
// // // // //     return Scaffold(
// // // // //       appBar: AppBar(
// // // // //           backgroundColor: AppColors.whiteColor,
// // // // //           elevation: 0,
// // // // //           leading: IconButton(
// // // // //               icon: const Icon(Icons.arrow_back_ios_new_rounded,
// // // // //                   color: AppColors.textPrimaryColor),
// // // // //               onPressed: () => Get.back())),
// // // // //       body: Center(
// // // // //         child: Text('Appointment not found',
// // // // //             style: GoogleFonts.poppins(
// // // // //                 color: AppColors.textSecondaryColor)),
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

// // // // // class _ActionBtn {
// // // // //   final String label;
// // // // //   final IconData icon;
// // // // //   final Color color;
// // // // //   final VoidCallback onTap;
// // // // //   _ActionBtn(
// // // // //       {required this.label,
// // // // //       required this.icon,
// // // // //       required this.color,
// // // // //       required this.onTap});
// // // // // }

// // // // // // ── Simple action confirm dialog ────────────────────────────────
// // // // // class _SimpleActionDialog extends StatefulWidget {
// // // // //   final String title, message, confirmLabel;
// // // // //   final Color confirmColor;
// // // // //   final IconData icon;
// // // // //   final MyAppointmentController controller;
// // // // //   final Future<bool> Function() onConfirm;

// // // // //   const _SimpleActionDialog({
// // // // //     required this.title,
// // // // //     required this.message,
// // // // //     required this.confirmLabel,
// // // // //     required this.confirmColor,
// // // // //     required this.icon,
// // // // //     required this.controller,
// // // // //     required this.onConfirm,
// // // // //   });

// // // // //   @override
// // // // //   State<_SimpleActionDialog> createState() => _SimpleActionDialogState();
// // // // // }

// // // // // class _SimpleActionDialogState extends State<_SimpleActionDialog> {
// // // // //   bool _loading = false;

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return AlertDialog(
// // // // //       shape:
// // // // //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
// // // // //       contentPadding: const EdgeInsets.all(24),
// // // // //       content: Column(
// // // // //         mainAxisSize: MainAxisSize.min,
// // // // //         children: [
// // // // //           Container(
// // // // //             padding: const EdgeInsets.all(14),
// // // // //             decoration: BoxDecoration(
// // // // //                 color: widget.confirmColor.withOpacity(0.1),
// // // // //                 shape: BoxShape.circle),
// // // // //             child: Icon(widget.icon,
// // // // //                 color: widget.confirmColor, size: 32),
// // // // //           ),
// // // // //           const SizedBox(height: 14),
// // // // //           Text(widget.title,
// // // // //               style: GoogleFonts.poppins(
// // // // //                   fontSize: 17,
// // // // //                   fontWeight: FontWeight.bold,
// // // // //                   color: AppColors.textPrimaryColor),
// // // // //               textAlign: TextAlign.center),
// // // // //           const SizedBox(height: 8),
// // // // //           Text(widget.message,
// // // // //               style: GoogleFonts.poppins(
// // // // //                   fontSize: 13, color: AppColors.textSecondaryColor),
// // // // //               textAlign: TextAlign.center),
// // // // //           const SizedBox(height: 22),
// // // // //           Row(
// // // // //             children: [
// // // // //               Expanded(
// // // // //                 child: OutlinedButton(
// // // // //                   onPressed:
// // // // //                       _loading ? null : () => Navigator.pop(context),
// // // // //                   style: OutlinedButton.styleFrom(
// // // // //                     foregroundColor: AppColors.textSecondaryColor,
// // // // //                     side: BorderSide(
// // // // //                         color: AppColors.greyColor.withOpacity(0.4)),
// // // // //                     shape: RoundedRectangleBorder(
// // // // //                         borderRadius: BorderRadius.circular(12)),
// // // // //                     padding:
// // // // //                         const EdgeInsets.symmetric(vertical: 12),
// // // // //                   ),
// // // // //                   child: Text('Cancel',
// // // // //                       style: GoogleFonts.poppins(
// // // // //                           fontWeight: FontWeight.w500, fontSize: 13)),
// // // // //                 ),
// // // // //               ),
// // // // //               const SizedBox(width: 12),
// // // // //               Expanded(
// // // // //                 child: ElevatedButton(
// // // // //                   onPressed: _loading
// // // // //                       ? null
// // // // //                       : () async {
// // // // //                           setState(() => _loading = true);
// // // // //                           final ok = await widget.onConfirm();
// // // // //                           if (!mounted) return;
// // // // //                           setState(() => _loading = false);
// // // // //                           if (ok) Navigator.pop(context);
// // // // //                         },
// // // // //                   style: ElevatedButton.styleFrom(
// // // // //                     backgroundColor: widget.confirmColor,
// // // // //                     foregroundColor: Colors.white,
// // // // //                     disabledBackgroundColor:
// // // // //                         widget.confirmColor.withOpacity(0.5),
// // // // //                     shape: RoundedRectangleBorder(
// // // // //                         borderRadius: BorderRadius.circular(12)),
// // // // //                     padding:
// // // // //                         const EdgeInsets.symmetric(vertical: 12),
// // // // //                     elevation: 0,
// // // // //                   ),
// // // // //                   child: _loading
// // // // //                       ? const SizedBox(
// // // // //                           width: 18,
// // // // //                           height: 18,
// // // // //                           child: CircularProgressIndicator(
// // // // //                               color: Colors.white, strokeWidth: 2))
// // // // //                       : Text(widget.confirmLabel,
// // // // //                           style: GoogleFonts.poppins(
// // // // //                               fontWeight: FontWeight.w600,
// // // // //                               fontSize: 13)),
// // // // //                 ),
// // // // //               ),
// // // // //             ],
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }

// // // // // // ── Cancel dialog with reason ───────────────────────────────────
// // // // // class _CancelDialog extends StatefulWidget {
// // // // //   final String id;
// // // // //   final MyAppointmentController controller;

// // // // //   const _CancelDialog({required this.id, required this.controller});

// // // // //   @override
// // // // //   State<_CancelDialog> createState() => _CancelDialogState();
// // // // // }

// // // // // class _CancelDialogState extends State<_CancelDialog> {
// // // // //   final _reasonCtrl = TextEditingController();
// // // // //   bool _loading = false;

// // // // //   @override
// // // // //   void dispose() {
// // // // //     _reasonCtrl.dispose();
// // // // //     super.dispose();
// // // // //   }

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return AlertDialog(
// // // // //       shape:
// // // // //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
// // // // //       contentPadding: const EdgeInsets.all(24),
// // // // //       content: Column(
// // // // //         mainAxisSize: MainAxisSize.min,
// // // // //         children: [
// // // // //           Container(
// // // // //             padding: const EdgeInsets.all(14),
// // // // //             decoration: BoxDecoration(
// // // // //                 color: AppColors.errorColor.withOpacity(0.1),
// // // // //                 shape: BoxShape.circle),
// // // // //             child: const Icon(Icons.cancel_outlined,
// // // // //                 color: AppColors.errorColor, size: 32),
// // // // //           ),
// // // // //           const SizedBox(height: 14),
// // // // //           Text('Cancel Appointment?',
// // // // //               style: GoogleFonts.poppins(
// // // // //                   fontSize: 17,
// // // // //                   fontWeight: FontWeight.bold,
// // // // //                   color: AppColors.textPrimaryColor)),
// // // // //           const SizedBox(height: 16),
// // // // //           TextField(
// // // // //             controller: _reasonCtrl,
// // // // //             maxLines: 3,
// // // // //             style: GoogleFonts.poppins(
// // // // //                 fontSize: 13, color: AppColors.textPrimaryColor),
// // // // //             decoration: InputDecoration(
// // // // //               hintText: 'Enter cancellation reason...',
// // // // //               hintStyle: GoogleFonts.poppins(
// // // // //                   fontSize: 13,
// // // // //                   color: AppColors.textSecondaryColor.withOpacity(0.7)),
// // // // //               filled: true,
// // // // //               fillColor: AppColors.lightGreyColor,
// // // // //               contentPadding: const EdgeInsets.all(14),
// // // // //               border: OutlineInputBorder(
// // // // //                   borderRadius: BorderRadius.circular(12),
// // // // //                   borderSide: BorderSide.none),
// // // // //               enabledBorder: OutlineInputBorder(
// // // // //                   borderRadius: BorderRadius.circular(12),
// // // // //                   borderSide: BorderSide(
// // // // //                       color: AppColors.greyColor.withOpacity(0.2))),
// // // // //               focusedBorder: OutlineInputBorder(
// // // // //                   borderRadius: BorderRadius.circular(12),
// // // // //                   borderSide: const BorderSide(
// // // // //                       color: AppColors.primaryColor, width: 1.5)),
// // // // //             ),
// // // // //           ),
// // // // //           const SizedBox(height: 20),
// // // // //           Row(
// // // // //             children: [
// // // // //               Expanded(
// // // // //                 child: OutlinedButton(
// // // // //                   onPressed:
// // // // //                       _loading ? null : () => Navigator.pop(context),
// // // // //                   style: OutlinedButton.styleFrom(
// // // // //                     foregroundColor: AppColors.textSecondaryColor,
// // // // //                     side: BorderSide(
// // // // //                         color: AppColors.greyColor.withOpacity(0.4)),
// // // // //                     shape: RoundedRectangleBorder(
// // // // //                         borderRadius: BorderRadius.circular(12)),
// // // // //                     padding:
// // // // //                         const EdgeInsets.symmetric(vertical: 12),
// // // // //                   ),
// // // // //                   child: Text('Back',
// // // // //                       style: GoogleFonts.poppins(
// // // // //                           fontWeight: FontWeight.w500, fontSize: 13)),
// // // // //                 ),
// // // // //               ),
// // // // //               const SizedBox(width: 12),
// // // // //               Expanded(
// // // // //                 child: ElevatedButton(
// // // // //                   onPressed: _loading
// // // // //                       ? null
// // // // //                       : () async {
// // // // //                           final reason = _reasonCtrl.text.trim();
// // // // //                           if (reason.isEmpty) {
// // // // //                             Get.snackbar('Required',
// // // // //                                 'Please enter a cancellation reason',
// // // // //                                 snackPosition: SnackPosition.BOTTOM,
// // // // //                                 backgroundColor: AppColors.warningColor,
// // // // //                                 colorText: Colors.white,
// // // // //                                 margin: const EdgeInsets.all(16),
// // // // //                                 borderRadius: 12);
// // // // //                             return;
// // // // //                           }
// // // // //                           setState(() => _loading = true);
// // // // //                           final ok = await widget.controller
// // // // //                               .cancelAppointment(widget.id, reason);
// // // // //                           if (mounted) setState(() => _loading = false);
// // // // //                           if (ok && context.mounted) Navigator.pop(context);
// // // // //                         },
// // // // //                   style: ElevatedButton.styleFrom(
// // // // //                     backgroundColor: AppColors.errorColor,
// // // // //                     foregroundColor: Colors.white,
// // // // //                     disabledBackgroundColor:
// // // // //                         AppColors.errorColor.withOpacity(0.5),
// // // // //                     shape: RoundedRectangleBorder(
// // // // //                         borderRadius: BorderRadius.circular(12)),
// // // // //                     padding:
// // // // //                         const EdgeInsets.symmetric(vertical: 12),
// // // // //                     elevation: 0,
// // // // //                   ),
// // // // //                   child: _loading
// // // // //                       ? const SizedBox(
// // // // //                           width: 18,
// // // // //                           height: 18,
// // // // //                           child: CircularProgressIndicator(
// // // // //                               color: Colors.white, strokeWidth: 2))
// // // // //                       : Text('Cancel Appt.',
// // // // //                           style: GoogleFonts.poppins(
// // // // //                               fontWeight: FontWeight.w600,
// // // // //                               fontSize: 13)),
// // // // //                 ),
// // // // //               ),
// // // // //             ],
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }

// // // // // // ── Record form bottom sheet ────────────────────────────────────
// // // // // class _RecordFormSheet extends StatefulWidget {
// // // // //   final MyAppointmentController controller;
// // // // //   final CustomSize size;
// // // // //   final String appointmentId;
// // // // //   final AppointmentRecordItem? editingRecord;

// // // // //   const _RecordFormSheet({
// // // // //     required this.controller,
// // // // //     required this.size,
// // // // //     required this.appointmentId,
// // // // //     this.editingRecord,
// // // // //   });

// // // // //   @override
// // // // //   State<_RecordFormSheet> createState() => _RecordFormSheetState();
// // // // // }

// // // // // class _RecordFormSheetState extends State<_RecordFormSheet> {
// // // // //   final _formKey = GlobalKey<FormState>();
// // // // //   bool _saving = false;

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     final size = widget.size;
// // // // //     final isEdit = widget.editingRecord != null;

// // // // //     return Container(
// // // // //       decoration: const BoxDecoration(
// // // // //         color: AppColors.whiteColor,
// // // // //         borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
// // // // //       ),
// // // // //       padding:
// // // // //           EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
// // // // //       child: SingleChildScrollView(
// // // // //         physics: const ClampingScrollPhysics(),
// // // // //         padding: EdgeInsets.fromLTRB(
// // // // //           size.customWidth(context) * 0.05,
// // // // //           20,
// // // // //           size.customWidth(context) * 0.05,
// // // // //           size.customHeight(context) * 0.04,
// // // // //         ),
// // // // //         child: Form(
// // // // //           key: _formKey,
// // // // //           child: Column(
// // // // //             crossAxisAlignment: CrossAxisAlignment.start,
// // // // //             mainAxisSize: MainAxisSize.min,
// // // // //             children: [
// // // // //               // Handle
// // // // //               Center(
// // // // //                 child: Container(
// // // // //                   width: 44, height: 4,
// // // // //                   decoration: BoxDecoration(
// // // // //                       color: AppColors.greyColor.withOpacity(0.3),
// // // // //                       borderRadius: BorderRadius.circular(2)),
// // // // //                 ),
// // // // //               ),
// // // // //               const SizedBox(height: 20),

// // // // //               // Header
// // // // //               Row(
// // // // //                 children: [
// // // // //                   Container(
// // // // //                     padding: const EdgeInsets.all(10),
// // // // //                     decoration: BoxDecoration(
// // // // //                         color: AppColors.primaryColor.withOpacity(0.1),
// // // // //                         borderRadius: BorderRadius.circular(12)),
// // // // //                     child: Icon(
// // // // //                         isEdit
// // // // //                             ? Icons.edit_note_rounded
// // // // //                             : Icons.note_add_rounded,
// // // // //                         color: AppColors.primaryColor, size: 22),
// // // // //                   ),
// // // // //                   const SizedBox(width: 12),
// // // // //                   Expanded(
// // // // //                     child: Column(
// // // // //                       crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                       children: [
// // // // //                         Text(
// // // // //                           isEdit ? 'Update Record' : 'New Session Record',
// // // // //                           style: GoogleFonts.poppins(
// // // // //                               fontSize: size.customWidth(context) * 0.044,
// // // // //                               fontWeight: FontWeight.bold,
// // // // //                               color: AppColors.textPrimaryColor),
// // // // //                         ),
// // // // //                         Text(
// // // // //                           isEdit
// // // // //                               ? 'Edit session details'
// // // // //                               : 'Document this session',
// // // // //                           style: GoogleFonts.poppins(
// // // // //                               fontSize: size.customWidth(context) * 0.031,
// // // // //                               color: AppColors.textSecondaryColor),
// // // // //                         ),
// // // // //                       ],
// // // // //                     ),
// // // // //                   ),
// // // // //                 ],
// // // // //               ),
// // // // //               SizedBox(height: size.customHeight(context) * 0.025),

// // // // //               _formField(context, size, 'Session Notes',
// // // // //                   'Describe what happened during the session...',
// // // // //                   Icons.notes_rounded, widget.controller.notesCtrl,
// // // // //                   maxLines: 3, required: true),
// // // // //               SizedBox(height: size.customHeight(context) * 0.018),

// // // // //               _formField(context, size, 'Therapy Plan',
// // // // //                   'Outline the plan for next sessions...',
// // // // //                   Icons.health_and_safety_outlined,
// // // // //                   widget.controller.therapyPlanCtrl,
// // // // //                   maxLines: 3, required: true),
// // // // //               SizedBox(height: size.customHeight(context) * 0.018),

// // // // //               _formField(context, size, 'Progress Feedback',
// // // // //                   'How did the patient progress?',
// // // // //                   Icons.trending_up_rounded,
// // // // //                   widget.controller.progressFeedbackCtrl,
// // // // //                   maxLines: 2, required: true),
// // // // //               SizedBox(height: size.customHeight(context) * 0.018),

// // // // //               Text('Medication (optional)',
// // // // //                   style: GoogleFonts.poppins(
// // // // //                       fontSize: size.customWidth(context) * 0.036,
// // // // //                       fontWeight: FontWeight.w600,
// // // // //                       color: AppColors.textPrimaryColor)),
// // // // //               SizedBox(height: size.customHeight(context) * 0.01),
// // // // //               Row(
// // // // //                 children: [
// // // // //                   Expanded(
// // // // //                     child: _formField(context, size, 'Name', 'e.g. None',
// // // // //                         Icons.medication_outlined,
// // // // //                         widget.controller.medicationNameCtrl,
// // // // //                         maxLines: 1, required: false),
// // // // //                   ),
// // // // //                   SizedBox(width: size.customWidth(context) * 0.03),
// // // // //                   Expanded(
// // // // //                     child: _formField(context, size, 'Dosage',
// // // // //                         'e.g. 5mg', Icons.science_outlined,
// // // // //                         widget.controller.medicationDosageCtrl,
// // // // //                         maxLines: 1, required: false),
// // // // //                   ),
// // // // //                 ],
// // // // //               ),
// // // // //               SizedBox(height: size.customHeight(context) * 0.03),

// // // // //               SizedBox(
// // // // //                 width: double.infinity,
// // // // //                 child: ElevatedButton(
// // // // //                   onPressed: _saving
// // // // //                       ? null
// // // // //                       : () async {
// // // // //                           if (!_formKey.currentState!.validate()) return;
// // // // //                           setState(() => _saving = true);
// // // // //                           bool ok;
// // // // //                           if (isEdit) {
// // // // //                             ok = await widget.controller.updateRecord(
// // // // //                                 widget.appointmentId,
// // // // //                                 widget.editingRecord!.recordId);
// // // // //                           } else {
// // // // //                             ok = await widget.controller
// // // // //                                 .createRecord(widget.appointmentId);
// // // // //                           }
// // // // //                           if (mounted) setState(() => _saving = false);
// // // // //                           if (ok && context.mounted) Navigator.pop(context);
// // // // //                         },
// // // // //                   style: ElevatedButton.styleFrom(
// // // // //                     backgroundColor: AppColors.primaryColor,
// // // // //                     foregroundColor: Colors.white,
// // // // //                     disabledBackgroundColor:
// // // // //                         AppColors.primaryColor.withOpacity(0.4),
// // // // //                     padding: EdgeInsets.symmetric(
// // // // //                         vertical: size.customHeight(context) * 0.02),
// // // // //                     shape: RoundedRectangleBorder(
// // // // //                         borderRadius: BorderRadius.circular(16)),
// // // // //                     elevation: 2,
// // // // //                   ),
// // // // //                   child: _saving
// // // // //                       ? const SizedBox(
// // // // //                           width: 22, height: 22,
// // // // //                           child: CircularProgressIndicator(
// // // // //                               color: Colors.white, strokeWidth: 2.5))
// // // // //                       : Text(
// // // // //                           isEdit ? 'Update Record' : 'Save Record',
// // // // //                           style: GoogleFonts.poppins(
// // // // //                               fontWeight: FontWeight.w600,
// // // // //                               fontSize: size.customWidth(context) * 0.04)),
// // // // //                 ),
// // // // //               ),
// // // // //             ],
// // // // //           ),
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   Widget _formField(
// // // // //     BuildContext context,
// // // // //     CustomSize size,
// // // // //     String label,
// // // // //     String hint,
// // // // //     IconData icon,
// // // // //     TextEditingController ctrl, {
// // // // //     int maxLines = 1,
// // // // //     bool required = true,
// // // // //   }) {
// // // // //     return Column(
// // // // //       crossAxisAlignment: CrossAxisAlignment.start,
// // // // //       children: [
// // // // //         Text(label,
// // // // //             style: GoogleFonts.poppins(
// // // // //                 fontSize: size.customWidth(context) * 0.034,
// // // // //                 fontWeight: FontWeight.w600,
// // // // //                 color: AppColors.textPrimaryColor)),
// // // // //         const SizedBox(height: 6),
// // // // //         TextFormField(
// // // // //           controller: ctrl,
// // // // //           maxLines: maxLines,
// // // // //           validator: required
// // // // //               ? (v) => v == null || v.trim().isEmpty
// // // // //                   ? '$label is required'
// // // // //                   : null
// // // // //               : null,
// // // // //           style: GoogleFonts.poppins(
// // // // //               fontSize: 13, color: AppColors.textPrimaryColor),
// // // // //           decoration: InputDecoration(
// // // // //             hintText: hint,
// // // // //             hintStyle: GoogleFonts.poppins(
// // // // //                 fontSize: 13,
// // // // //                 color: AppColors.textSecondaryColor.withOpacity(0.7)),
// // // // //             prefixIcon: maxLines == 1
// // // // //                 ? Icon(icon, color: AppColors.primaryColor, size: 20)
// // // // //                 : null,
// // // // //             filled: true,
// // // // //             fillColor: AppColors.lightGreyColor,
// // // // //             contentPadding: EdgeInsets.symmetric(
// // // // //                 horizontal: 16, vertical: maxLines > 1 ? 14 : 0),
// // // // //             border: OutlineInputBorder(
// // // // //                 borderRadius: BorderRadius.circular(14),
// // // // //                 borderSide: BorderSide.none),
// // // // //             enabledBorder: OutlineInputBorder(
// // // // //                 borderRadius: BorderRadius.circular(14),
// // // // //                 borderSide: BorderSide(
// // // // //                     color: AppColors.greyColor.withOpacity(0.2),
// // // // //                     width: 1)),
// // // // //             focusedBorder: OutlineInputBorder(
// // // // //                 borderRadius: BorderRadius.circular(14),
// // // // //                 borderSide: const BorderSide(
// // // // //                     color: AppColors.primaryColor, width: 1.5)),
// // // // //             errorBorder: OutlineInputBorder(
// // // // //                 borderRadius: BorderRadius.circular(14),
// // // // //                 borderSide: const BorderSide(
// // // // //                     color: AppColors.errorColor, width: 1)),
// // // // //           ),
// // // // //         ),
// // // // //       ],
// // // // //     );
// // // // //   }
// // // // // }


// // // // // lib/view/expert/appointments/appointment_detail_screen.dart
// // // // import 'package:flutter/material.dart';
// // // // import 'package:get/get.dart';
// // // // import 'package:google_fonts/google_fonts.dart';
// // // // import 'package:speechspectrum/constants/app_colors.dart';
// // // // import 'package:speechspectrum/constants/custom_size.dart';
// // // // import 'package:speechspectrum/controllers/my_appointment_controller.dart';
// // // // import 'package:speechspectrum/models/my_appointment_model.dart';

// // // // class AppointmentDetailScreen extends StatefulWidget {
// // // //   const AppointmentDetailScreen({super.key});

// // // //   @override
// // // //   State<AppointmentDetailScreen> createState() =>
// // // //       _AppointmentDetailScreenState();
// // // // }

// // // // class _AppointmentDetailScreenState extends State<AppointmentDetailScreen> {
// // // //   late final MyAppointmentController _c;
// // // //   late final String _appointmentId;

// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     _c = Get.find<MyAppointmentController>();
// // // //     // Safe cast: arguments is always a String from our navigation
// // // //     _appointmentId = Get.arguments?.toString() ?? '';
// // // //     WidgetsBinding.instance.addPostFrameCallback((_) {
// // // //       if (_appointmentId.isNotEmpty) {
// // // //         _c.fetchAppointmentDetail(_appointmentId);
// // // //         _c.fetchRecords(_appointmentId);
// // // //       }
// // // //     });
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     final size = CustomSize();
// // // //     return Scaffold(
// // // //       backgroundColor: AppColors.lightGreyColor,
// // // //       body: Obx(() {
// // // //         if (_c.isLoadingDetail.value) return _buildLoader();
// // // //         final appt = _c.selectedAppointment.value;
// // // //         if (appt == null) return _buildError();
// // // //         return _buildBody(context, size, appt);
// // // //       }),
// // // //     );
// // // //   }

// // // //   // ── Main body ──────────────────────────────────────────────
// // // //   Widget _buildBody(
// // // //       BuildContext context, CustomSize size, MyAppointmentItem appt) {
// // // //     final meta = _statusMeta(appt.status);

// // // //     return CustomScrollView(
// // // //       slivers: [
// // // //         // ── SliverAppBar ──────────────────────────────────────
// // // //         SliverAppBar(
// // // //           expandedHeight: size.customHeight(context) * 0.26,
// // // //           pinned: true,
// // // //           backgroundColor: AppColors.primaryColor,
// // // //           surfaceTintColor: Colors.transparent,
// // // //           leading: GestureDetector(
// // // //             onTap: () => Get.back(),
// // // //             child: Container(
// // // //               margin: const EdgeInsets.all(8),
// // // //               decoration: BoxDecoration(
// // // //                   color: Colors.white.withOpacity(0.2),
// // // //                   borderRadius: BorderRadius.circular(12)),
// // // //               child: const Icon(Icons.arrow_back_ios_new_rounded,
// // // //                   color: Colors.white, size: 18),
// // // //             ),
// // // //           ),
// // // //           flexibleSpace: FlexibleSpaceBar(
// // // //             background: Container(
// // // //               decoration: const BoxDecoration(
// // // //                 gradient: LinearGradient(
// // // //                   colors: [AppColors.primaryColor, AppColors.secondaryColor],
// // // //                   begin: Alignment.topLeft,
// // // //                   end: Alignment.bottomRight,
// // // //                 ),
// // // //               ),
// // // //               child: SafeArea(
// // // //                 child: Padding(
// // // //                   padding: EdgeInsets.fromLTRB(
// // // //                     size.customWidth(context) * 0.05,
// // // //                     size.customHeight(context) * 0.07,
// // // //                     size.customWidth(context) * 0.05,
// // // //                     16,
// // // //                   ),
// // // //                   child: Column(
// // // //                     mainAxisAlignment: MainAxisAlignment.end,
// // // //                     children: [
// // // //                       Row(
// // // //                         children: [
// // // //                           // Avatar
// // // //                           Container(
// // // //                             width: 68,
// // // //                             height: 68,
// // // //                             decoration: BoxDecoration(
// // // //                               color: Colors.white.withOpacity(0.2),
// // // //                               borderRadius: BorderRadius.circular(20),
// // // //                               border: Border.all(
// // // //                                   color: Colors.white.withOpacity(0.4),
// // // //                                   width: 2),
// // // //                             ),
// // // //                             child: Center(
// // // //                               child: Text(
// // // //                                 appt.childInitials,
// // // //                                 style: GoogleFonts.poppins(
// // // //                                     color: Colors.white,
// // // //                                     fontSize: 24,
// // // //                                     fontWeight: FontWeight.bold),
// // // //                               ),
// // // //                             ),
// // // //                           ),
// // // //                           SizedBox(width: size.customWidth(context) * 0.04),
// // // //                           Expanded(
// // // //                             child: Column(
// // // //                               crossAxisAlignment: CrossAxisAlignment.start,
// // // //                               children: [
// // // //                                 Text(
// // // //                                   appt.children?.childName ?? 'Unknown',
// // // //                                   style: GoogleFonts.poppins(
// // // //                                       color: Colors.white,
// // // //                                       fontSize:
// // // //                                           size.customWidth(context) * 0.048,
// // // //                                       fontWeight: FontWeight.bold),
// // // //                                 ),
// // // //                                 const SizedBox(height: 2),
// // // //                                 Text(
// // // //                                   appt.expertUsers?.fullName ?? '',
// // // //                                   style: GoogleFonts.poppins(
// // // //                                       color: Colors.white.withOpacity(0.9),
// // // //                                       fontSize:
// // // //                                           size.customWidth(context) * 0.033),
// // // //                                 ),
// // // //                                 Text(
// // // //                                   appt.expertUsers?.specialization ?? '',
// // // //                                   style: GoogleFonts.poppins(
// // // //                                       color: Colors.white.withOpacity(0.75),
// // // //                                       fontSize:
// // // //                                           size.customWidth(context) * 0.029),
// // // //                                 ),
// // // //                                 const SizedBox(height: 8),
// // // //                                 // Status chip
// // // //                                 Container(
// // // //                                   padding: const EdgeInsets.symmetric(
// // // //                                       horizontal: 12, vertical: 5),
// // // //                                   decoration: BoxDecoration(
// // // //                                     color: meta.color.withOpacity(0.25),
// // // //                                     borderRadius: BorderRadius.circular(20),
// // // //                                     border: Border.all(
// // // //                                         color: Colors.white.withOpacity(0.4)),
// // // //                                   ),
// // // //                                   child: Row(
// // // //                                     mainAxisSize: MainAxisSize.min,
// // // //                                     children: [
// // // //                                       Icon(meta.icon,
// // // //                                           color: Colors.white, size: 13),
// // // //                                       const SizedBox(width: 5),
// // // //                                       Text(
// // // //                                         meta.label,
// // // //                                         style: GoogleFonts.poppins(
// // // //                                             color: Colors.white,
// // // //                                             fontSize: 12,
// // // //                                             fontWeight: FontWeight.w600),
// // // //                                       ),
// // // //                                     ],
// // // //                                   ),
// // // //                                 ),
// // // //                               ],
// // // //                             ),
// // // //                           ),
// // // //                         ],
// // // //                       ),
// // // //                     ],
// // // //                   ),
// // // //                 ),
// // // //               ),
// // // //             ),
// // // //           ),
// // // //         ),

// // // //         // ── Sliver body ───────────────────────────────────────
// // // //         SliverPadding(
// // // //           padding: EdgeInsets.fromLTRB(
// // // //             size.customWidth(context) * 0.045,
// // // //             size.customHeight(context) * 0.02,
// // // //             size.customWidth(context) * 0.045,
// // // //             size.customHeight(context) * 0.06,
// // // //           ),
// // // //           sliver: SliverList(
// // // //             delegate: SliverChildListDelegate([
// // // //               // Action buttons row
// // // //               _buildActionButtons(context, size, appt),
// // // //               SizedBox(height: size.customHeight(context) * 0.022),

// // // //               // Appointment info card
// // // //               _buildInfoCard(context, size, appt),
// // // //               SizedBox(height: size.customHeight(context) * 0.018),

// // // //               // Slot card
// // // //               if (appt.appointmentSlots != null) ...[
// // // //                 _buildSlotCard(context, size, appt.appointmentSlots!),
// // // //                 SizedBox(height: size.customHeight(context) * 0.018),
// // // //               ],

// // // //               // Expert card
// // // //               if (appt.expertUsers != null) ...[
// // // //                 _buildExpertCard(context, size, appt.expertUsers!),
// // // //                 SizedBox(height: size.customHeight(context) * 0.018),
// // // //               ],

// // // //               // Cancellation card
// // // //               if (appt.isCancelled) ...[
// // // //                 _buildCancellationCard(context, size, appt),
// // // //                 SizedBox(height: size.customHeight(context) * 0.018),
// // // //               ],

// // // //               // Session records
// // // //               _buildRecordsSection(context, size, appt),
// // // //             ]),
// // // //           ),
// // // //         ),
// // // //       ],
// // // //     );
// // // //   }

// // // //   // ── Action buttons ─────────────────────────────────────────
// // // //   Widget _buildActionButtons(
// // // //       BuildContext context, CustomSize size, MyAppointmentItem appt) {
// // // //     final List<_ActionBtn> buttons = [];

// // // //     if (appt.isScheduled) {
// // // //       buttons.addAll([
// // // //         _ActionBtn(
// // // //           label: 'Confirm',
// // // //           icon: Icons.check_circle_outline_rounded,
// // // //           color: AppColors.primaryColor,
// // // //           onTap: () => _showConfirmDialog(context, appt.appointmentId),
// // // //         ),
// // // //         _ActionBtn(
// // // //           label: 'Cancel',
// // // //           icon: Icons.cancel_outlined,
// // // //           color: AppColors.errorColor,
// // // //           onTap: () => _showCancelDialog(context, appt.appointmentId),
// // // //         ),
// // // //         _ActionBtn(
// // // //           label: 'No Show',
// // // //           icon: Icons.person_off_outlined,
// // // //           color: AppColors.greyColor,
// // // //           onTap: () => _showNoShowDialog(context, appt.appointmentId),
// // // //         ),
// // // //       ]);
// // // //     } else if (appt.isConfirmed) {
// // // //       buttons.addAll([
// // // //         _ActionBtn(
// // // //           label: 'Complete',
// // // //           icon: Icons.task_alt_rounded,
// // // //           color: AppColors.successColor,
// // // //           // GATE: must create notes before completing
// // // //           onTap: () => _showCompleteGate(context, size, appt),
// // // //         ),
// // // //         _ActionBtn(
// // // //           label: 'Cancel',
// // // //           icon: Icons.cancel_outlined,
// // // //           color: AppColors.errorColor,
// // // //           onTap: () => _showCancelDialog(context, appt.appointmentId),
// // // //         ),
// // // //         _ActionBtn(
// // // //           label: 'No Show',
// // // //           icon: Icons.person_off_outlined,
// // // //           color: AppColors.greyColor,
// // // //           onTap: () => _showNoShowDialog(context, appt.appointmentId),
// // // //         ),
// // // //       ]);
// // // //     }

// // // //     if (buttons.isEmpty) return const SizedBox.shrink();

// // // //     return Row(
// // // //       children: buttons.map((b) {
// // // //         return Expanded(
// // // //           child: GestureDetector(
// // // //             onTap: b.onTap,
// // // //             child: Container(
// // // //               margin: const EdgeInsets.symmetric(horizontal: 4),
// // // //               padding: const EdgeInsets.symmetric(vertical: 14),
// // // //               decoration: BoxDecoration(
// // // //                 color: b.color.withOpacity(0.09),
// // // //                 borderRadius: BorderRadius.circular(16),
// // // //                 border: Border.all(color: b.color.withOpacity(0.35)),
// // // //               ),
// // // //               child: Column(
// // // //                 mainAxisSize: MainAxisSize.min,
// // // //                 children: [
// // // //                   Icon(b.icon, color: b.color, size: 22),
// // // //                   const SizedBox(height: 5),
// // // //                   Text(
// // // //                     b.label,
// // // //                     style: GoogleFonts.poppins(
// // // //                         fontSize: 11,
// // // //                         fontWeight: FontWeight.w600,
// // // //                         color: b.color),
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //             ),
// // // //           ),
// // // //         );
// // // //       }).toList(),
// // // //     );
// // // //   }

// // // //   // ── Info card ──────────────────────────────────────────────
// // // //   Widget _buildInfoCard(
// // // //       BuildContext context, CustomSize size, MyAppointmentItem appt) {
// // // //     return _card(
// // // //       context,
// // // //       size,
// // // //       title: 'Appointment Details',
// // // //       icon: Icons.event_note_rounded,
// // // //       iconColor: AppColors.primaryColor,
// // // //       children: [
// // // //         _row(context, size, 'Date', appt.formattedDate,
// // // //             Icons.calendar_today_outlined),
// // // //         _row(context, size, 'Time', appt.formattedTime,
// // // //             Icons.access_time_rounded),
// // // //         _row(context, size, 'Duration', '${appt.durationMinutes} minutes',
// // // //             Icons.timer_outlined),
// // // //         _row(
// // // //             context,
// // // //             size,
// // // //             'Mode',
// // // //             appt.bookedMode[0].toUpperCase() + appt.bookedMode.substring(1),
// // // //             _modeIcon(appt.bookedMode)),
// // // //         _row(
// // // //             context,
// // // //             size,
// // // //             'Fee',
// // // //             '${appt.currency} ${appt.feeCharged.toStringAsFixed(0)}',
// // // //             Icons.payments_outlined),
// // // //         if (appt.meetLink != null && appt.meetLink!.isNotEmpty)
// // // //           _row(context, size, 'Meet Link', appt.meetLink!, Icons.link_rounded),
// // // //       ],
// // // //     );
// // // //   }

// // // //   // ── Slot card ──────────────────────────────────────────────
// // // //   Widget _buildSlotCard(
// // // //       BuildContext context, CustomSize size, AppointmentSlot slot) {
// // // //     return _card(
// // // //       context,
// // // //       size,
// // // //       title: 'Slot Information',
// // // //       icon: Icons.calendar_month_rounded,
// // // //       iconColor: AppColors.secondaryColor,
// // // //       children: [
// // // //         _row(context, size, 'Date', slot.slotDate, Icons.today_rounded),
// // // //         _row(context, size, 'Time',
// // // //             '${slot.formattedStart} – ${slot.formattedEnd}',
// // // //             Icons.schedule_rounded),
// // // //         _row(
// // // //             context,
// // // //             size,
// // // //             'Mode',
// // // //             slot.mode.isNotEmpty
// // // //                 ? slot.mode[0].toUpperCase() + slot.mode.substring(1)
// // // //                 : slot.mode,
// // // //             _modeIcon(slot.mode)),
// // // //         if (slot.status != null)
// // // //           _row(context, size, 'Slot Status',
// // // //               slot.status![0].toUpperCase() + slot.status!.substring(1),
// // // //               Icons.info_outline_rounded),
// // // //       ],
// // // //     );
// // // //   }

// // // //   // ── Expert card ────────────────────────────────────────────
// // // //   Widget _buildExpertCard(
// // // //       BuildContext context, CustomSize size, AppointmentExpert expert) {
// // // //     return _card(
// // // //       context,
// // // //       size,
// // // //       title: 'Expert Information',
// // // //       icon: Icons.person_outline_rounded,
// // // //       iconColor: AppColors.accentColor,
// // // //       children: [
// // // //         _row(context, size, 'Name', expert.fullName, Icons.badge_outlined),
// // // //         _row(context, size, 'Specialization', expert.specialization,
// // // //             Icons.medical_information_outlined),
// // // //         if (expert.phone != null && expert.phone!.isNotEmpty)
// // // //           _row(context, size, 'Phone', expert.phone!, Icons.phone_outlined),
// // // //         if (expert.contactEmail != null && expert.contactEmail!.isNotEmpty)
// // // //           _row(context, size, 'Email', expert.contactEmail!,
// // // //               Icons.email_outlined),
// // // //       ],
// // // //     );
// // // //   }

// // // //   // ── Cancellation card ──────────────────────────────────────
// // // //   Widget _buildCancellationCard(
// // // //       BuildContext context, CustomSize size, MyAppointmentItem appt) {
// // // //     return Container(
// // // //       padding: EdgeInsets.all(size.customWidth(context) * 0.045),
// // // //       decoration: BoxDecoration(
// // // //         color: AppColors.errorColor.withOpacity(0.05),
// // // //         borderRadius: BorderRadius.circular(18),
// // // //         border: Border.all(color: AppColors.errorColor.withOpacity(0.25)),
// // // //       ),
// // // //       child: Column(
// // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // //         children: [
// // // //           Row(
// // // //             children: [
// // // //               Container(
// // // //                 padding: const EdgeInsets.all(7),
// // // //                 decoration: BoxDecoration(
// // // //                     color: AppColors.errorColor.withOpacity(0.12),
// // // //                     borderRadius: BorderRadius.circular(9)),
// // // //                 child: const Icon(Icons.cancel_outlined,
// // // //                     color: AppColors.errorColor, size: 17),
// // // //               ),
// // // //               const SizedBox(width: 10),
// // // //               Text('Cancellation Info',
// // // //                   style: GoogleFonts.poppins(
// // // //                       fontSize: 14,
// // // //                       fontWeight: FontWeight.w600,
// // // //                       color: AppColors.errorColor)),
// // // //             ],
// // // //           ),
// // // //           const SizedBox(height: 14),
// // // //           if (appt.cancelledBy != null)
// // // //             _row(
// // // //                 context,
// // // //                 size,
// // // //                 'Cancelled By',
// // // //                 appt.cancelledBy![0].toUpperCase() +
// // // //                     appt.cancelledBy!.substring(1),
// // // //                 Icons.person_outlined),
// // // //           if (appt.cancellationReason != null)
// // // //             _row(context, size, 'Reason', appt.cancellationReason!,
// // // //                 Icons.info_outline_rounded),
// // // //           if (appt.cancelledAt != null)
// // // //             _row(context, size, 'Cancelled At', _formatDateTime(appt.cancelledAt!),
// // // //                 Icons.schedule_rounded),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }

// // // //   // ── Records section ────────────────────────────────────────
// // // //   Widget _buildRecordsSection(
// // // //       BuildContext context, CustomSize size, MyAppointmentItem appt) {
// // // //     // Only show records section for completed appointments (or when records exist)
// // // //     if (!appt.isCompleted && !appt.isConfirmed) {
// // // //       return const SizedBox.shrink();
// // // //     }

// // // //     return Column(
// // // //       crossAxisAlignment: CrossAxisAlignment.start,
// // // //       children: [
// // // //         // Header
// // // //         Row(
// // // //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // //           children: [
// // // //             Row(
// // // //               children: [
// // // //                 Container(
// // // //                   width: 4,
// // // //                   height: 20,
// // // //                   decoration: BoxDecoration(
// // // //                       color: AppColors.primaryColor,
// // // //                       borderRadius: BorderRadius.circular(2)),
// // // //                 ),
// // // //                 const SizedBox(width: 10),
// // // //                 Text(
// // // //                   'Session Records',
// // // //                   style: GoogleFonts.poppins(
// // // //                       fontSize: size.customWidth(context) * 0.042,
// // // //                       fontWeight: FontWeight.bold,
// // // //                       color: AppColors.textPrimaryColor),
// // // //                 ),
// // // //               ],
// // // //             ),
// // // //             // Add button — only for completed
// // // //             if (appt.isCompleted)
// // // //               GestureDetector(
// // // //                 onTap: () {
// // // //                   _c.clearRecordForm();
// // // //                   _openRecordSheet(context, size, appt.appointmentId);
// // // //                 },
// // // //                 child: Container(
// // // //                   padding:
// // // //                       const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
// // // //                   decoration: BoxDecoration(
// // // //                     color: AppColors.primaryColor,
// // // //                     borderRadius: BorderRadius.circular(10),
// // // //                   ),
// // // //                   child: Row(
// // // //                     mainAxisSize: MainAxisSize.min,
// // // //                     children: [
// // // //                       const Icon(Icons.add_rounded,
// // // //                           color: Colors.white, size: 16),
// // // //                       const SizedBox(width: 4),
// // // //                       Text('Add Note',
// // // //                           style: GoogleFonts.poppins(
// // // //                               color: Colors.white,
// // // //                               fontWeight: FontWeight.w600,
// // // //                               fontSize: 12)),
// // // //                     ],
// // // //                   ),
// // // //                 ),
// // // //               ),
// // // //           ],
// // // //         ),
// // // //         SizedBox(height: size.customHeight(context) * 0.015),

// // // //         Obx(() {
// // // //           if (_c.isLoadingRecords.value) {
// // // //             return const Center(
// // // //               child: Padding(
// // // //                 padding: EdgeInsets.all(30),
// // // //                 child: CircularProgressIndicator(
// // // //                     color: AppColors.primaryColor, strokeWidth: 2),
// // // //               ),
// // // //             );
// // // //           }
// // // //           if (_c.records.isEmpty) {
// // // //             return _buildEmptyRecords(context, size, appt);
// // // //           }
// // // //           return Column(
// // // //             children: _c.records
// // // //                 .map((r) => _buildRecordCard(context, size, r, appt))
// // // //                 .toList(),
// // // //           );
// // // //         }),
// // // //       ],
// // // //     );
// // // //   }

// // // //   Widget _buildEmptyRecords(
// // // //       BuildContext context, CustomSize size, MyAppointmentItem appt) {
// // // //     return Container(
// // // //       padding: const EdgeInsets.all(28),
// // // //       decoration: BoxDecoration(
// // // //         color: AppColors.whiteColor,
// // // //         borderRadius: BorderRadius.circular(18),
// // // //         boxShadow: [
// // // //           BoxShadow(
// // // //               color: Colors.black.withOpacity(0.04),
// // // //               blurRadius: 10,
// // // //               offset: const Offset(0, 3))
// // // //         ],
// // // //       ),
// // // //       child: Center(
// // // //         child: Column(
// // // //           children: [
// // // //             Icon(Icons.note_outlined,
// // // //                 size: 44,
// // // //                 color: AppColors.textSecondaryColor.withOpacity(0.35)),
// // // //             const SizedBox(height: 12),
// // // //             Text(
// // // //               appt.isCompleted
// // // //                   ? 'No session notes yet.\nTap "Add Note" to document this session.'
// // // //                   : 'Session notes will be available\nafter the appointment is completed.',
// // // //               textAlign: TextAlign.center,
// // // //               style: GoogleFonts.poppins(
// // // //                   fontSize: 13, color: AppColors.textSecondaryColor),
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _buildRecordCard(BuildContext context, CustomSize size,
// // // //       AppointmentRecordItem record, MyAppointmentItem appt) {
// // // //     return Container(
// // // //       margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.014),
// // // //       decoration: BoxDecoration(
// // // //         color: AppColors.whiteColor,
// // // //         borderRadius: BorderRadius.circular(18),
// // // //         boxShadow: [
// // // //           BoxShadow(
// // // //               color: Colors.black.withOpacity(0.05),
// // // //               blurRadius: 10,
// // // //               offset: const Offset(0, 3))
// // // //         ],
// // // //       ),
// // // //       child: Padding(
// // // //         padding: EdgeInsets.all(size.customWidth(context) * 0.042),
// // // //         child: Column(
// // // //           crossAxisAlignment: CrossAxisAlignment.start,
// // // //           children: [
// // // //             // Record header
// // // //             Row(
// // // //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // //               children: [
// // // //                 Row(
// // // //                   children: [
// // // //                     Container(
// // // //                       padding: const EdgeInsets.all(8),
// // // //                       decoration: BoxDecoration(
// // // //                           color: AppColors.primaryColor.withOpacity(0.1),
// // // //                           borderRadius: BorderRadius.circular(10)),
// // // //                       child: const Icon(Icons.description_outlined,
// // // //                           color: AppColors.primaryColor, size: 18),
// // // //                     ),
// // // //                     const SizedBox(width: 10),
// // // //                     Column(
// // // //                       crossAxisAlignment: CrossAxisAlignment.start,
// // // //                       children: [
// // // //                         Text('Session Note',
// // // //                             style: GoogleFonts.poppins(
// // // //                                 fontSize: 14,
// // // //                                 fontWeight: FontWeight.w600,
// // // //                                 color: AppColors.textPrimaryColor)),
// // // //                         Text(record.formattedDate,
// // // //                             style: GoogleFonts.poppins(
// // // //                                 fontSize: 11,
// // // //                                 color: AppColors.textSecondaryColor)),
// // // //                       ],
// // // //                     ),
// // // //                   ],
// // // //                 ),
// // // //                 // Edit button — only for completed
// // // //                 if (appt.isCompleted)
// // // //                   GestureDetector(
// // // //                     onTap: () {
// // // //                       _c.populateRecordForm(record);
// // // //                       _openRecordSheet(context, size, appt.appointmentId,
// // // //                           editingRecord: record);
// // // //                     },
// // // //                     child: Container(
// // // //                       padding: const EdgeInsets.all(7),
// // // //                       decoration: BoxDecoration(
// // // //                           color: AppColors.warningColor.withOpacity(0.1),
// // // //                           borderRadius: BorderRadius.circular(9)),
// // // //                       child: const Icon(Icons.edit_outlined,
// // // //                           color: AppColors.warningColor, size: 16),
// // // //                     ),
// // // //                   ),
// // // //               ],
// // // //             ),
// // // //             SizedBox(height: size.customHeight(context) * 0.012),
// // // //             Divider(height: 1, color: AppColors.greyColor.withOpacity(0.15)),
// // // //             SizedBox(height: size.customHeight(context) * 0.012),

// // // //             _recordField('Notes', record.notes, Icons.notes_rounded),
// // // //             SizedBox(height: size.customHeight(context) * 0.01),
// // // //             _recordField('Therapy Plan', record.therapyPlan,
// // // //                 Icons.health_and_safety_outlined),
// // // //             SizedBox(height: size.customHeight(context) * 0.01),
// // // //             _recordField('Progress Feedback', record.progressFeedback,
// // // //                 Icons.trending_up_rounded),
// // // //             if (record.medication != null &&
// // // //                 record.medication!['name'] != null &&
// // // //                 record.medication!['name'].toString().toLowerCase() !=
// // // //                     'none') ...[
// // // //               SizedBox(height: size.customHeight(context) * 0.01),
// // // //               _recordField(
// // // //                   'Medication',
// // // //                   '${record.medication!['name']}${record.medication!['dosage'] != null ? ' — ${record.medication!['dosage']}' : ''}',
// // // //                   Icons.medication_outlined),
// // // //             ],
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _recordField(String label, String value, IconData icon) {
// // // //     return Row(
// // // //       crossAxisAlignment: CrossAxisAlignment.start,
// // // //       children: [
// // // //         Icon(icon, size: 14, color: AppColors.primaryColor.withOpacity(0.7)),
// // // //         const SizedBox(width: 8),
// // // //         Expanded(
// // // //           child: Column(
// // // //             crossAxisAlignment: CrossAxisAlignment.start,
// // // //             children: [
// // // //               Text(label,
// // // //                   style: GoogleFonts.poppins(
// // // //                       fontSize: 11,
// // // //                       color: AppColors.textSecondaryColor,
// // // //                       fontWeight: FontWeight.w500)),
// // // //               const SizedBox(height: 2),
// // // //               Text(value,
// // // //                   style: GoogleFonts.poppins(
// // // //                       fontSize: 13, color: AppColors.textPrimaryColor)),
// // // //             ],
// // // //           ),
// // // //         ),
// // // //       ],
// // // //     );
// // // //   }

// // // //   // ── Shared card widget ─────────────────────────────────────
// // // //   Widget _card(
// // // //     BuildContext context,
// // // //     CustomSize size, {
// // // //     required String title,
// // // //     required IconData icon,
// // // //     required Color iconColor,
// // // //     required List<Widget> children,
// // // //   }) {
// // // //     return Container(
// // // //       padding: EdgeInsets.all(size.customWidth(context) * 0.045),
// // // //       decoration: BoxDecoration(
// // // //         color: AppColors.whiteColor,
// // // //         borderRadius: BorderRadius.circular(18),
// // // //         boxShadow: [
// // // //           BoxShadow(
// // // //               color: Colors.black.withOpacity(0.05),
// // // //               blurRadius: 10,
// // // //               offset: const Offset(0, 3))
// // // //         ],
// // // //       ),
// // // //       child: Column(
// // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // //         children: [
// // // //           Row(
// // // //             children: [
// // // //               Container(
// // // //                 padding: const EdgeInsets.all(8),
// // // //                 decoration: BoxDecoration(
// // // //                     color: iconColor.withOpacity(0.1),
// // // //                     borderRadius: BorderRadius.circular(10)),
// // // //                 child: Icon(icon, color: iconColor, size: 18),
// // // //               ),
// // // //               const SizedBox(width: 10),
// // // //               Text(title,
// // // //                   style: GoogleFonts.poppins(
// // // //                       fontSize: 14,
// // // //                       fontWeight: FontWeight.w600,
// // // //                       color: AppColors.textPrimaryColor)),
// // // //             ],
// // // //           ),
// // // //           SizedBox(height: size.customHeight(context) * 0.014),
// // // //           Divider(height: 1, color: AppColors.greyColor.withOpacity(0.15)),
// // // //           SizedBox(height: size.customHeight(context) * 0.012),
// // // //           ...children,
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _row(BuildContext context, CustomSize size, String label, String value,
// // // //       IconData icon) {
// // // //     return Padding(
// // // //       padding: EdgeInsets.only(bottom: size.customHeight(context) * 0.01),
// // // //       child: Row(
// // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // //         children: [
// // // //           Icon(icon, size: 14, color: AppColors.textSecondaryColor),
// // // //           const SizedBox(width: 10),
// // // //           SizedBox(
// // // //             width: size.customWidth(context) * 0.26,
// // // //             child: Text(label,
// // // //                 style: GoogleFonts.poppins(
// // // //                     fontSize: 12,
// // // //                     color: AppColors.textSecondaryColor,
// // // //                     fontWeight: FontWeight.w500)),
// // // //           ),
// // // //           Expanded(
// // // //             child: Text(
// // // //               value,
// // // //               style: GoogleFonts.poppins(
// // // //                   fontSize: 13,
// // // //                   color: AppColors.textPrimaryColor,
// // // //                   fontWeight: FontWeight.w500),
// // // //               maxLines: 3,
// // // //               overflow: TextOverflow.ellipsis,
// // // //             ),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }

// // // //   // ── Dialogs ────────────────────────────────────────────────

// // // //   /// Gate: before completing, must fill notes
// // // //   void _showCompleteGate(
// // // //       BuildContext context, CustomSize size, MyAppointmentItem appt) {
// // // //     _c.clearRecordForm();
// // // //     showModalBottomSheet(
// // // //       context: context,
// // // //       isScrollControlled: true,
// // // //       backgroundColor: Colors.transparent,
// // // //       builder: (_) => _CompleteWithNotesSheet(
// // // //         controller: _c,
// // // //         size: size,
// // // //         appointmentId: appt.appointmentId,
// // // //       ),
// // // //     );
// // // //   }

// // // //   void _showConfirmDialog(BuildContext context, String id) {
// // // //     showDialog(
// // // //       context: context,
// // // //       barrierDismissible: false,
// // // //       builder: (_) => _ActionDialog(
// // // //         title: 'Confirm Appointment?',
// // // //         message: 'This will confirm the appointment for the patient.',
// // // //         confirmLabel: 'Yes, Confirm',
// // // //         confirmColor: AppColors.primaryColor,
// // // //         icon: Icons.check_circle_outline_rounded,
// // // //         onConfirm: () async {
// // // //           final ok = await _c.confirmAppointment(id);
// // // //           return ok;
// // // //         },
// // // //       ),
// // // //     );
// // // //   }

// // // //   void _showCancelDialog(BuildContext context, String id) {
// // // //     showDialog(
// // // //       context: context,
// // // //       barrierDismissible: false,
// // // //       builder: (_) => _CancelDialog(id: id, controller: _c),
// // // //     );
// // // //   }

// // // //   void _showNoShowDialog(BuildContext context, String id) {
// // // //     showDialog(
// // // //       context: context,
// // // //       barrierDismissible: false,
// // // //       builder: (_) => _ActionDialog(
// // // //         title: 'Mark as No Show?',
// // // //         message: 'Patient did not attend the session. Mark as no-show?',
// // // //         confirmLabel: 'Mark No Show',
// // // //         confirmColor: AppColors.greyColor,
// // // //         icon: Icons.person_off_outlined,
// // // //         onConfirm: () async {
// // // //           final ok = await _c.markNoShow(id);
// // // //           return ok;
// // // //         },
// // // //       ),
// // // //     );
// // // //   }

// // // //   void _openRecordSheet(BuildContext context, CustomSize size,
// // // //       String appointmentId,
// // // //       {AppointmentRecordItem? editingRecord}) {
// // // //     showModalBottomSheet(
// // // //       context: context,
// // // //       isScrollControlled: true,
// // // //       backgroundColor: Colors.transparent,
// // // //       builder: (_) => ConstrainedBox(
// // // //         constraints:
// // // //             BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.93),
// // // //         child: _RecordFormSheet(
// // // //           controller: _c,
// // // //           size: size,
// // // //           appointmentId: appointmentId,
// // // //           editingRecord: editingRecord,
// // // //           onSaved: () {},
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }

// // // //   // ── Helpers ────────────────────────────────────────────────
// // // //   Widget _buildLoader() {
// // // //     return Scaffold(
// // // //       appBar: AppBar(
// // // //           backgroundColor: AppColors.whiteColor,
// // // //           elevation: 0,
// // // //           surfaceTintColor: Colors.transparent,
// // // //           leading: IconButton(
// // // //             icon: const Icon(Icons.arrow_back_ios_new_rounded,
// // // //                 color: AppColors.textPrimaryColor),
// // // //             onPressed: () => Get.back(),
// // // //           )),
// // // //       body: const Center(
// // // //         child: CircularProgressIndicator(
// // // //             color: AppColors.primaryColor, strokeWidth: 3),
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _buildError() {
// // // //     return Scaffold(
// // // //       appBar: AppBar(
// // // //           backgroundColor: AppColors.whiteColor,
// // // //           elevation: 0,
// // // //           surfaceTintColor: Colors.transparent,
// // // //           leading: IconButton(
// // // //             icon: const Icon(Icons.arrow_back_ios_new_rounded,
// // // //                 color: AppColors.textPrimaryColor),
// // // //             onPressed: () => Get.back(),
// // // //           )),
// // // //       body: Center(
// // // //         child: Column(
// // // //           mainAxisAlignment: MainAxisAlignment.center,
// // // //           children: [
// // // //             const Icon(Icons.error_outline_rounded,
// // // //                 size: 60, color: AppColors.errorColor),
// // // //             const SizedBox(height: 16),
// // // //             Text('Appointment not found',
// // // //                 style: GoogleFonts.poppins(
// // // //                     fontSize: 16, color: AppColors.textPrimaryColor)),
// // // //             const SizedBox(height: 8),
// // // //             TextButton(
// // // //               onPressed: () => Get.back(),
// // // //               child: Text('Go Back',
// // // //                   style: GoogleFonts.poppins(color: AppColors.primaryColor)),
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }

// // // //   String _formatDateTime(String raw) {
// // // //     try {
// // // //       final dt = DateTime.parse(raw).toLocal();
// // // //       const months = [
// // // //         '',
// // // //         'Jan',
// // // //         'Feb',
// // // //         'Mar',
// // // //         'Apr',
// // // //         'May',
// // // //         'Jun',
// // // //         'Jul',
// // // //         'Aug',
// // // //         'Sep',
// // // //         'Oct',
// // // //         'Nov',
// // // //         'Dec'
// // // //       ];
// // // //       int h = dt.hour;
// // // //       final m = dt.minute.toString().padLeft(2, '0');
// // // //       final ampm = h >= 12 ? 'PM' : 'AM';
// // // //       if (h > 12) h -= 12;
// // // //       if (h == 0) h = 12;
// // // //       return '${dt.day} ${months[dt.month]} ${dt.year}, $h:$m $ampm';
// // // //     } catch (_) {
// // // //       return raw;
// // // //     }
// // // //   }

// // // //   _StatusMeta _statusMeta(String status) {
// // // //     switch (status.toLowerCase()) {
// // // //       case 'confirmed':
// // // //         return _StatusMeta(
// // // //             AppColors.primaryColor, 'Confirmed', Icons.check_circle_outlined);
// // // //       case 'completed':
// // // //         return _StatusMeta(
// // // //             AppColors.successColor, 'Completed', Icons.task_alt_rounded);
// // // //       case 'cancelled':
// // // //         return _StatusMeta(
// // // //             AppColors.errorColor, 'Cancelled', Icons.cancel_outlined);
// // // //       case 'no_show':
// // // //         return _StatusMeta(
// // // //             AppColors.greyColor, 'No Show', Icons.person_off_outlined);
// // // //       default:
// // // //         return _StatusMeta(
// // // //             AppColors.warningColor, 'Scheduled', Icons.schedule_rounded);
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

// // // // // ── Data classes ───────────────────────────────────────────────
// // // // class _StatusMeta {
// // // //   final Color color;
// // // //   final String label;
// // // //   final IconData icon;
// // // //   _StatusMeta(this.color, this.label, this.icon);
// // // // }

// // // // class _ActionBtn {
// // // //   final String label;
// // // //   final IconData icon;
// // // //   final Color color;
// // // //   final VoidCallback onTap;
// // // //   _ActionBtn(
// // // //       {required this.label,
// // // //       required this.icon,
// // // //       required this.color,
// // // //       required this.onTap});
// // // // }

// // // // // ══════════════════════════════════════════════════════════════
// // // // // Generic action confirm dialog
// // // // // ══════════════════════════════════════════════════════════════
// // // // class _ActionDialog extends StatefulWidget {
// // // //   final String title;
// // // //   final String message;
// // // //   final String confirmLabel;
// // // //   final Color confirmColor;
// // // //   final IconData icon;
// // // //   final Future<bool> Function() onConfirm;

// // // //   const _ActionDialog({
// // // //     required this.title,
// // // //     required this.message,
// // // //     required this.confirmLabel,
// // // //     required this.confirmColor,
// // // //     required this.icon,
// // // //     required this.onConfirm,
// // // //   });

// // // //   @override
// // // //   State<_ActionDialog> createState() => _ActionDialogState();
// // // // }

// // // // class _ActionDialogState extends State<_ActionDialog> {
// // // //   bool _loading = false;

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return AlertDialog(
// // // //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
// // // //       contentPadding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
// // // //       content: Column(
// // // //         mainAxisSize: MainAxisSize.min,
// // // //         children: [
// // // //           Container(
// // // //             padding: const EdgeInsets.all(16),
// // // //             decoration: BoxDecoration(
// // // //                 color: widget.confirmColor.withOpacity(0.1),
// // // //                 shape: BoxShape.circle),
// // // //             child:
// // // //                 Icon(widget.icon, color: widget.confirmColor, size: 34),
// // // //           ),
// // // //           const SizedBox(height: 16),
// // // //           Text(widget.title,
// // // //               style: GoogleFonts.poppins(
// // // //                   fontSize: 17,
// // // //                   fontWeight: FontWeight.bold,
// // // //                   color: AppColors.textPrimaryColor),
// // // //               textAlign: TextAlign.center),
// // // //           const SizedBox(height: 8),
// // // //           Text(widget.message,
// // // //               style: GoogleFonts.poppins(
// // // //                   fontSize: 13, color: AppColors.textSecondaryColor),
// // // //               textAlign: TextAlign.center),
// // // //           const SizedBox(height: 24),
// // // //           Row(
// // // //             children: [
// // // //               Expanded(
// // // //                 child: OutlinedButton(
// // // //                   onPressed: _loading ? null : () => Navigator.pop(context),
// // // //                   style: OutlinedButton.styleFrom(
// // // //                     foregroundColor: AppColors.textSecondaryColor,
// // // //                     side: BorderSide(
// // // //                         color: AppColors.greyColor.withOpacity(0.5)),
// // // //                     shape: RoundedRectangleBorder(
// // // //                         borderRadius: BorderRadius.circular(12)),
// // // //                     padding: const EdgeInsets.symmetric(vertical: 13),
// // // //                   ),
// // // //                   child: Text('Cancel',
// // // //                       style: GoogleFonts.poppins(
// // // //                           fontWeight: FontWeight.w500, fontSize: 13)),
// // // //                 ),
// // // //               ),
// // // //               const SizedBox(width: 12),
// // // //               Expanded(
// // // //                 child: ElevatedButton(
// // // //                   onPressed: _loading
// // // //                       ? null
// // // //                       : () async {
// // // //                           setState(() => _loading = true);
// // // //                           final ok = await widget.onConfirm();
// // // //                           if (mounted) {
// // // //                             setState(() => _loading = false);
// // // //                             if (ok) Navigator.pop(context);
// // // //                           }
// // // //                         },
// // // //                   style: ElevatedButton.styleFrom(
// // // //                     backgroundColor: widget.confirmColor,
// // // //                     foregroundColor: Colors.white,
// // // //                     disabledBackgroundColor:
// // // //                         widget.confirmColor.withOpacity(0.5),
// // // //                     shape: RoundedRectangleBorder(
// // // //                         borderRadius: BorderRadius.circular(12)),
// // // //                     padding: const EdgeInsets.symmetric(vertical: 13),
// // // //                     elevation: 0,
// // // //                   ),
// // // //                   child: _loading
// // // //                       ? const SizedBox(
// // // //                           width: 18,
// // // //                           height: 18,
// // // //                           child: CircularProgressIndicator(
// // // //                               color: Colors.white, strokeWidth: 2))
// // // //                       : Text(widget.confirmLabel,
// // // //                           style: GoogleFonts.poppins(
// // // //                               fontWeight: FontWeight.w600, fontSize: 13)),
// // // //                 ),
// // // //               ),
// // // //             ],
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // // // ══════════════════════════════════════════════════════════════
// // // // // Cancel dialog with reason input
// // // // // ══════════════════════════════════════════════════════════════
// // // // class _CancelDialog extends StatefulWidget {
// // // //   final String id;
// // // //   final MyAppointmentController controller;

// // // //   const _CancelDialog({required this.id, required this.controller});

// // // //   @override
// // // //   State<_CancelDialog> createState() => _CancelDialogState();
// // // // }

// // // // class _CancelDialogState extends State<_CancelDialog> {
// // // //   final _reasonCtrl = TextEditingController();
// // // //   bool _loading = false;

// // // //   @override
// // // //   void dispose() {
// // // //     _reasonCtrl.dispose();
// // // //     super.dispose();
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return AlertDialog(
// // // //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
// // // //       contentPadding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
// // // //       content: Column(
// // // //         mainAxisSize: MainAxisSize.min,
// // // //         children: [
// // // //           Container(
// // // //             padding: const EdgeInsets.all(16),
// // // //             decoration: BoxDecoration(
// // // //                 color: AppColors.errorColor.withOpacity(0.1),
// // // //                 shape: BoxShape.circle),
// // // //             child: const Icon(Icons.cancel_outlined,
// // // //                 color: AppColors.errorColor, size: 34),
// // // //           ),
// // // //           const SizedBox(height: 16),
// // // //           Text('Cancel Appointment',
// // // //               style: GoogleFonts.poppins(
// // // //                   fontSize: 17,
// // // //                   fontWeight: FontWeight.bold,
// // // //                   color: AppColors.textPrimaryColor),
// // // //               textAlign: TextAlign.center),
// // // //           const SizedBox(height: 6),
// // // //           Text('Please provide a cancellation reason.',
// // // //               style: GoogleFonts.poppins(
// // // //                   fontSize: 13, color: AppColors.textSecondaryColor),
// // // //               textAlign: TextAlign.center),
// // // //           const SizedBox(height: 18),
// // // //           TextField(
// // // //             controller: _reasonCtrl,
// // // //             maxLines: 3,
// // // //             style: GoogleFonts.poppins(
// // // //                 fontSize: 13, color: AppColors.textPrimaryColor),
// // // //             decoration: InputDecoration(
// // // //               hintText: 'Enter reason here...',
// // // //               hintStyle: GoogleFonts.poppins(
// // // //                   fontSize: 13,
// // // //                   color: AppColors.textSecondaryColor.withOpacity(0.6)),
// // // //               filled: true,
// // // //               fillColor: AppColors.lightGreyColor,
// // // //               contentPadding: const EdgeInsets.all(14),
// // // //               border: OutlineInputBorder(
// // // //                   borderRadius: BorderRadius.circular(12),
// // // //                   borderSide: BorderSide.none),
// // // //               enabledBorder: OutlineInputBorder(
// // // //                   borderRadius: BorderRadius.circular(12),
// // // //                   borderSide: BorderSide(
// // // //                       color: AppColors.greyColor.withOpacity(0.25))),
// // // //               focusedBorder: OutlineInputBorder(
// // // //                   borderRadius: BorderRadius.circular(12),
// // // //                   borderSide: const BorderSide(
// // // //                       color: AppColors.primaryColor, width: 1.5)),
// // // //             ),
// // // //           ),
// // // //           const SizedBox(height: 20),
// // // //           Row(
// // // //             children: [
// // // //               Expanded(
// // // //                 child: OutlinedButton(
// // // //                   onPressed: _loading ? null : () => Navigator.pop(context),
// // // //                   style: OutlinedButton.styleFrom(
// // // //                     foregroundColor: AppColors.textSecondaryColor,
// // // //                     side: BorderSide(
// // // //                         color: AppColors.greyColor.withOpacity(0.5)),
// // // //                     shape: RoundedRectangleBorder(
// // // //                         borderRadius: BorderRadius.circular(12)),
// // // //                     padding: const EdgeInsets.symmetric(vertical: 13),
// // // //                   ),
// // // //                   child: Text('Back',
// // // //                       style: GoogleFonts.poppins(
// // // //                           fontWeight: FontWeight.w500, fontSize: 13)),
// // // //                 ),
// // // //               ),
// // // //               const SizedBox(width: 12),
// // // //               Expanded(
// // // //                 child: ElevatedButton(
// // // //                   onPressed: _loading
// // // //                       ? null
// // // //                       : () async {
// // // //                           final reason = _reasonCtrl.text.trim();
// // // //                           if (reason.isEmpty) {
// // // //                             Get.snackbar(
// // // //                               'Required',
// // // //                               'Please enter a cancellation reason',
// // // //                               snackPosition: SnackPosition.BOTTOM,
// // // //                               backgroundColor: AppColors.warningColor,
// // // //                               colorText: Colors.white,
// // // //                               margin: const EdgeInsets.all(16),
// // // //                               borderRadius: 12,
// // // //                             );
// // // //                             return;
// // // //                           }
// // // //                           setState(() => _loading = true);
// // // //                           final ok = await widget.controller
// // // //                               .cancelAppointment(widget.id, reason);
// // // //                           if (mounted) {
// // // //                             setState(() => _loading = false);
// // // //                             if (ok) Navigator.pop(context);
// // // //                           }
// // // //                         },
// // // //                   style: ElevatedButton.styleFrom(
// // // //                     backgroundColor: AppColors.errorColor,
// // // //                     foregroundColor: Colors.white,
// // // //                     disabledBackgroundColor:
// // // //                         AppColors.errorColor.withOpacity(0.5),
// // // //                     shape: RoundedRectangleBorder(
// // // //                         borderRadius: BorderRadius.circular(12)),
// // // //                     padding: const EdgeInsets.symmetric(vertical: 13),
// // // //                     elevation: 0,
// // // //                   ),
// // // //                   child: _loading
// // // //                       ? const SizedBox(
// // // //                           width: 18,
// // // //                           height: 18,
// // // //                           child: CircularProgressIndicator(
// // // //                               color: Colors.white, strokeWidth: 2))
// // // //                       : Text('Cancel Appt.',
// // // //                           style: GoogleFonts.poppins(
// // // //                               fontWeight: FontWeight.w600, fontSize: 13)),
// // // //                 ),
// // // //               ),
// // // //             ],
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // // // ══════════════════════════════════════════════════════════════
// // // // // Complete-with-Notes gate sheet
// // // // // Must fill notes BEFORE the appointment is marked complete
// // // // // ══════════════════════════════════════════════════════════════
// // // // class _CompleteWithNotesSheet extends StatefulWidget {
// // // //   final MyAppointmentController controller;
// // // //   final CustomSize size;
// // // //   final String appointmentId;

// // // //   const _CompleteWithNotesSheet({
// // // //     required this.controller,
// // // //     required this.size,
// // // //     required this.appointmentId,
// // // //   });

// // // //   @override
// // // //   State<_CompleteWithNotesSheet> createState() =>
// // // //       _CompleteWithNotesSheetState();
// // // // }

// // // // class _CompleteWithNotesSheetState extends State<_CompleteWithNotesSheet> {
// // // //   final _formKey = GlobalKey<FormState>();
// // // //   bool _saving = false;

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     final size = widget.size;

// // // //     return Container(
// // // //       decoration: const BoxDecoration(
// // // //         color: AppColors.whiteColor,
// // // //         borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
// // // //       ),
// // // //       padding:
// // // //           EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
// // // //       child: SingleChildScrollView(
// // // //         physics: const ClampingScrollPhysics(),
// // // //         padding: EdgeInsets.fromLTRB(
// // // //           size.customWidth(context) * 0.05,
// // // //           20,
// // // //           size.customWidth(context) * 0.05,
// // // //           size.customHeight(context) * 0.04,
// // // //         ),
// // // //         child: Form(
// // // //           key: _formKey,
// // // //           child: Column(
// // // //             crossAxisAlignment: CrossAxisAlignment.start,
// // // //             mainAxisSize: MainAxisSize.min,
// // // //             children: [
// // // //               // Handle bar
// // // //               Center(
// // // //                 child: Container(
// // // //                   width: 44,
// // // //                   height: 4,
// // // //                   decoration: BoxDecoration(
// // // //                       color: AppColors.greyColor.withOpacity(0.3),
// // // //                       borderRadius: BorderRadius.circular(2)),
// // // //                 ),
// // // //               ),
// // // //               const SizedBox(height: 20),

// // // //               // Header
// // // //               Row(
// // // //                 children: [
// // // //                   Container(
// // // //                     padding: const EdgeInsets.all(10),
// // // //                     decoration: BoxDecoration(
// // // //                         color: AppColors.successColor.withOpacity(0.1),
// // // //                         borderRadius: BorderRadius.circular(12)),
// // // //                     child: const Icon(Icons.task_alt_rounded,
// // // //                         color: AppColors.successColor, size: 22),
// // // //                   ),
// // // //                   const SizedBox(width: 12),
// // // //                   Expanded(
// // // //                     child: Column(
// // // //                       crossAxisAlignment: CrossAxisAlignment.start,
// // // //                       children: [
// // // //                         Text(
// // // //                           'Complete Appointment',
// // // //                           style: GoogleFonts.poppins(
// // // //                               fontSize: size.customWidth(context) * 0.042,
// // // //                               fontWeight: FontWeight.bold,
// // // //                               color: AppColors.textPrimaryColor),
// // // //                         ),
// // // //                         Text(
// // // //                           'Add session notes to complete',
// // // //                           style: GoogleFonts.poppins(
// // // //                               fontSize: size.customWidth(context) * 0.031,
// // // //                               color: AppColors.textSecondaryColor),
// // // //                         ),
// // // //                       ],
// // // //                     ),
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //               const SizedBox(height: 6),
// // // //               Container(
// // // //                 margin: const EdgeInsets.symmetric(vertical: 12),
// // // //                 padding:
// // // //                     const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
// // // //                 decoration: BoxDecoration(
// // // //                   color: AppColors.warningColor.withOpacity(0.08),
// // // //                   borderRadius: BorderRadius.circular(10),
// // // //                   border: Border.all(
// // // //                       color: AppColors.warningColor.withOpacity(0.3)),
// // // //                 ),
// // // //                 child: Row(
// // // //                   children: [
// // // //                     const Icon(Icons.info_outline_rounded,
// // // //                         color: AppColors.warningColor, size: 16),
// // // //                     const SizedBox(width: 8),
// // // //                     Expanded(
// // // //                       child: Text(
// // // //                         'Session notes are required before marking as completed.',
// // // //                         style: GoogleFonts.poppins(
// // // //                             fontSize: 12,
// // // //                             color: AppColors.warningColor),
// // // //                       ),
// // // //                     ),
// // // //                   ],
// // // //                 ),
// // // //               ),
// // // //               SizedBox(height: size.customHeight(context) * 0.01),

// // // //               _field(context, size, 'Session Notes *',
// // // //                   'What happened during the session?',
// // // //                   Icons.notes_rounded, widget.controller.notesCtrl,
// // // //                   maxLines: 3, required: true),
// // // //               SizedBox(height: size.customHeight(context) * 0.016),

// // // //               _field(context, size, 'Therapy Plan *',
// // // //                   'Plan for upcoming sessions...',
// // // //                   Icons.health_and_safety_outlined,
// // // //                   widget.controller.therapyPlanCtrl,
// // // //                   maxLines: 3, required: true),
// // // //               SizedBox(height: size.customHeight(context) * 0.016),

// // // //               _field(context, size, 'Progress Feedback *',
// // // //                   'How did the patient progress?',
// // // //                   Icons.trending_up_rounded,
// // // //                   widget.controller.progressFeedbackCtrl,
// // // //                   maxLines: 2, required: true),
// // // //               SizedBox(height: size.customHeight(context) * 0.016),

// // // //               Text('Medication (optional)',
// // // //                   style: GoogleFonts.poppins(
// // // //                       fontSize: size.customWidth(context) * 0.034,
// // // //                       fontWeight: FontWeight.w600,
// // // //                       color: AppColors.textPrimaryColor)),
// // // //               const SizedBox(height: 8),
// // // //               Row(
// // // //                 children: [
// // // //                   Expanded(
// // // //                     child: _field(context, size, 'Name', 'e.g. None',
// // // //                         Icons.medication_outlined,
// // // //                         widget.controller.medicationNameCtrl,
// // // //                         maxLines: 1, required: false),
// // // //                   ),
// // // //                   SizedBox(width: size.customWidth(context) * 0.03),
// // // //                   Expanded(
// // // //                     child: _field(context, size, 'Dosage', 'e.g. 5mg',
// // // //                         Icons.science_outlined,
// // // //                         widget.controller.medicationDosageCtrl,
// // // //                         maxLines: 1, required: false),
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //               SizedBox(height: size.customHeight(context) * 0.028),

// // // //               // Two buttons: Save Notes + Mark Complete in one shot
// // // //               SizedBox(
// // // //                 width: double.infinity,
// // // //                 child: ElevatedButton.icon(
// // // //                   onPressed: _saving
// // // //                       ? null
// // // //                       : () async {
// // // //                           if (!_formKey.currentState!.validate()) return;
// // // //                           setState(() => _saving = true);

// // // //                           // Step 1: create the record
// // // //                           final recordOk = await widget.controller
// // // //                               .createRecord(widget.appointmentId);

// // // //                           if (!recordOk) {
// // // //                             if (mounted) setState(() => _saving = false);
// // // //                             return;
// // // //                           }

// // // //                           // Step 2: complete the appointment
// // // //                           final completeOk = await widget.controller
// // // //                               .completeAppointment(widget.appointmentId);

// // // //                           if (mounted) setState(() => _saving = false);
// // // //                           if (completeOk && context.mounted) {
// // // //                             Navigator.pop(context);
// // // //                           }
// // // //                         },
// // // //                   icon: _saving
// // // //                       ? const SizedBox(
// // // //                           width: 18,
// // // //                           height: 18,
// // // //                           child: CircularProgressIndicator(
// // // //                               color: Colors.white, strokeWidth: 2))
// // // //                       : const Icon(Icons.task_alt_rounded, size: 20),
// // // //                   label: Text(
// // // //                     _saving ? 'Saving...' : 'Save Notes & Complete',
// // // //                     style: GoogleFonts.poppins(
// // // //                         fontWeight: FontWeight.w600,
// // // //                         fontSize: size.customWidth(context) * 0.038),
// // // //                   ),
// // // //                   style: ElevatedButton.styleFrom(
// // // //                     backgroundColor: AppColors.successColor,
// // // //                     foregroundColor: Colors.white,
// // // //                     disabledBackgroundColor:
// // // //                         AppColors.successColor.withOpacity(0.4),
// // // //                     padding: EdgeInsets.symmetric(
// // // //                         vertical: size.customHeight(context) * 0.02),
// // // //                     shape: RoundedRectangleBorder(
// // // //                         borderRadius: BorderRadius.circular(16)),
// // // //                     elevation: 2,
// // // //                   ),
// // // //                 ),
// // // //               ),
// // // //               SizedBox(height: size.customHeight(context) * 0.008),
// // // //               SizedBox(
// // // //                 width: double.infinity,
// // // //                 child: TextButton(
// // // //                   onPressed: _saving ? null : () => Navigator.pop(context),
// // // //                   child: Text('Cancel',
// // // //                       style: GoogleFonts.poppins(
// // // //                           color: AppColors.textSecondaryColor,
// // // //                           fontWeight: FontWeight.w500)),
// // // //                 ),
// // // //               ),
// // // //             ],
// // // //           ),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _field(
// // // //     BuildContext context,
// // // //     CustomSize size,
// // // //     String label,
// // // //     String hint,
// // // //     IconData icon,
// // // //     TextEditingController ctrl, {
// // // //     int maxLines = 1,
// // // //     bool required = true,
// // // //   }) {
// // // //     return Column(
// // // //       crossAxisAlignment: CrossAxisAlignment.start,
// // // //       children: [
// // // //         Text(label,
// // // //             style: GoogleFonts.poppins(
// // // //                 fontSize: size.customWidth(context) * 0.033,
// // // //                 fontWeight: FontWeight.w600,
// // // //                 color: AppColors.textPrimaryColor)),
// // // //         const SizedBox(height: 6),
// // // //         TextFormField(
// // // //           controller: ctrl,
// // // //           maxLines: maxLines,
// // // //           validator: required
// // // //               ? (v) =>
// // // //                   (v == null || v.trim().isEmpty) ? '$label is required' : null
// // // //               : null,
// // // //           style: GoogleFonts.poppins(
// // // //               fontSize: 13, color: AppColors.textPrimaryColor),
// // // //           decoration: InputDecoration(
// // // //             hintText: hint,
// // // //             hintStyle: GoogleFonts.poppins(
// // // //                 fontSize: 13,
// // // //                 color: AppColors.textSecondaryColor.withOpacity(0.6)),
// // // //             prefixIcon: maxLines == 1
// // // //                 ? Icon(icon, color: AppColors.primaryColor, size: 19)
// // // //                 : null,
// // // //             filled: true,
// // // //             fillColor: AppColors.lightGreyColor,
// // // //             contentPadding: EdgeInsets.symmetric(
// // // //                 horizontal: 16, vertical: maxLines > 1 ? 14 : 0),
// // // //             border: OutlineInputBorder(
// // // //                 borderRadius: BorderRadius.circular(14),
// // // //                 borderSide: BorderSide.none),
// // // //             enabledBorder: OutlineInputBorder(
// // // //                 borderRadius: BorderRadius.circular(14),
// // // //                 borderSide: BorderSide(
// // // //                     color: AppColors.greyColor.withOpacity(0.2))),
// // // //             focusedBorder: OutlineInputBorder(
// // // //                 borderRadius: BorderRadius.circular(14),
// // // //                 borderSide: const BorderSide(
// // // //                     color: AppColors.primaryColor, width: 1.5)),
// // // //             errorBorder: OutlineInputBorder(
// // // //                 borderRadius: BorderRadius.circular(14),
// // // //                 borderSide: const BorderSide(
// // // //                     color: AppColors.errorColor, width: 1)),
// // // //             focusedErrorBorder: OutlineInputBorder(
// // // //                 borderRadius: BorderRadius.circular(14),
// // // //                 borderSide: const BorderSide(
// // // //                     color: AppColors.errorColor, width: 1.5)),
// // // //           ),
// // // //         ),
// // // //       ],
// // // //     );
// // // //   }
// // // // }

// // // // // ══════════════════════════════════════════════════════════════
// // // // // Record form sheet (Add / Edit for completed appointments)
// // // // // ══════════════════════════════════════════════════════════════
// // // // class _RecordFormSheet extends StatefulWidget {
// // // //   final MyAppointmentController controller;
// // // //   final CustomSize size;
// // // //   final String appointmentId;
// // // //   final AppointmentRecordItem? editingRecord;
// // // //   final VoidCallback? onSaved;

// // // //   const _RecordFormSheet({
// // // //     required this.controller,
// // // //     required this.size,
// // // //     required this.appointmentId,
// // // //     this.editingRecord,
// // // //     this.onSaved,
// // // //   });

// // // //   @override
// // // //   State<_RecordFormSheet> createState() => _RecordFormSheetState();
// // // // }

// // // // class _RecordFormSheetState extends State<_RecordFormSheet> {
// // // //   final _formKey = GlobalKey<FormState>();
// // // //   bool _saving = false;

// // // //   bool get _isEdit => widget.editingRecord != null;

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     final size = widget.size;

// // // //     return Container(
// // // //       decoration: const BoxDecoration(
// // // //         color: AppColors.whiteColor,
// // // //         borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
// // // //       ),
// // // //       padding:
// // // //           EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
// // // //       child: SingleChildScrollView(
// // // //         physics: const ClampingScrollPhysics(),
// // // //         padding: EdgeInsets.fromLTRB(
// // // //           size.customWidth(context) * 0.05,
// // // //           20,
// // // //           size.customWidth(context) * 0.05,
// // // //           size.customHeight(context) * 0.04,
// // // //         ),
// // // //         child: Form(
// // // //           key: _formKey,
// // // //           child: Column(
// // // //             crossAxisAlignment: CrossAxisAlignment.start,
// // // //             mainAxisSize: MainAxisSize.min,
// // // //             children: [
// // // //               Center(
// // // //                 child: Container(
// // // //                   width: 44,
// // // //                   height: 4,
// // // //                   decoration: BoxDecoration(
// // // //                       color: AppColors.greyColor.withOpacity(0.3),
// // // //                       borderRadius: BorderRadius.circular(2)),
// // // //                 ),
// // // //               ),
// // // //               const SizedBox(height: 20),

// // // //               Row(
// // // //                 children: [
// // // //                   Container(
// // // //                     padding: const EdgeInsets.all(10),
// // // //                     decoration: BoxDecoration(
// // // //                         color: AppColors.primaryColor.withOpacity(0.1),
// // // //                         borderRadius: BorderRadius.circular(12)),
// // // //                     child: Icon(
// // // //                       _isEdit ? Icons.edit_note_rounded : Icons.note_add_rounded,
// // // //                       color: AppColors.primaryColor,
// // // //                       size: 22,
// // // //                     ),
// // // //                   ),
// // // //                   const SizedBox(width: 12),
// // // //                   Expanded(
// // // //                     child: Column(
// // // //                       crossAxisAlignment: CrossAxisAlignment.start,
// // // //                       children: [
// // // //                         Text(
// // // //                           _isEdit ? 'Update Session Record' : 'New Session Record',
// // // //                           style: GoogleFonts.poppins(
// // // //                               fontSize: size.customWidth(context) * 0.042,
// // // //                               fontWeight: FontWeight.bold,
// // // //                               color: AppColors.textPrimaryColor),
// // // //                         ),
// // // //                         Text(
// // // //                           _isEdit ? 'Edit session details' : 'Document this session',
// // // //                           style: GoogleFonts.poppins(
// // // //                               fontSize: size.customWidth(context) * 0.031,
// // // //                               color: AppColors.textSecondaryColor),
// // // //                         ),
// // // //                       ],
// // // //                     ),
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //               SizedBox(height: size.customHeight(context) * 0.022),

// // // //               _field(context, size, 'Session Notes *',
// // // //                   'Describe what happened during the session...',
// // // //                   Icons.notes_rounded, widget.controller.notesCtrl,
// // // //                   maxLines: 3, required: true),
// // // //               SizedBox(height: size.customHeight(context) * 0.016),

// // // //               _field(context, size, 'Therapy Plan *',
// // // //                   'Outline the plan for next sessions...',
// // // //                   Icons.health_and_safety_outlined,
// // // //                   widget.controller.therapyPlanCtrl,
// // // //                   maxLines: 3, required: true),
// // // //               SizedBox(height: size.customHeight(context) * 0.016),

// // // //               _field(context, size, 'Progress Feedback *',
// // // //                   'How did the patient progress?',
// // // //                   Icons.trending_up_rounded,
// // // //                   widget.controller.progressFeedbackCtrl,
// // // //                   maxLines: 2, required: true),
// // // //               SizedBox(height: size.customHeight(context) * 0.016),

// // // //               Text('Medication (optional)',
// // // //                   style: GoogleFonts.poppins(
// // // //                       fontSize: size.customWidth(context) * 0.034,
// // // //                       fontWeight: FontWeight.w600,
// // // //                       color: AppColors.textPrimaryColor)),
// // // //               const SizedBox(height: 8),
// // // //               Row(
// // // //                 children: [
// // // //                   Expanded(
// // // //                     child: _field(context, size, 'Name', 'e.g. None',
// // // //                         Icons.medication_outlined,
// // // //                         widget.controller.medicationNameCtrl,
// // // //                         maxLines: 1, required: false),
// // // //                   ),
// // // //                   SizedBox(width: size.customWidth(context) * 0.03),
// // // //                   Expanded(
// // // //                     child: _field(context, size, 'Dosage', 'e.g. 5mg',
// // // //                         Icons.science_outlined,
// // // //                         widget.controller.medicationDosageCtrl,
// // // //                         maxLines: 1, required: false),
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //               SizedBox(height: size.customHeight(context) * 0.028),

// // // //               SizedBox(
// // // //                 width: double.infinity,
// // // //                 child: ElevatedButton(
// // // //                   onPressed: _saving
// // // //                       ? null
// // // //                       : () async {
// // // //                           if (!_formKey.currentState!.validate()) return;
// // // //                           setState(() => _saving = true);
// // // //                           bool ok;
// // // //                           if (_isEdit) {
// // // //                             ok = await widget.controller.updateRecord(
// // // //                               widget.appointmentId,
// // // //                               widget.editingRecord!.recordId,
// // // //                             );
// // // //                           } else {
// // // //                             ok = await widget.controller
// // // //                                 .createRecord(widget.appointmentId);
// // // //                           }
// // // //                           if (mounted) setState(() => _saving = false);
// // // //                           if (ok && context.mounted) {
// // // //                             widget.onSaved?.call();
// // // //                             Navigator.pop(context);
// // // //                           }
// // // //                         },
// // // //                   style: ElevatedButton.styleFrom(
// // // //                     backgroundColor: AppColors.primaryColor,
// // // //                     foregroundColor: Colors.white,
// // // //                     disabledBackgroundColor:
// // // //                         AppColors.primaryColor.withOpacity(0.4),
// // // //                     padding: EdgeInsets.symmetric(
// // // //                         vertical: size.customHeight(context) * 0.02),
// // // //                     shape: RoundedRectangleBorder(
// // // //                         borderRadius: BorderRadius.circular(16)),
// // // //                     elevation: 2,
// // // //                   ),
// // // //                   child: _saving
// // // //                       ? const SizedBox(
// // // //                           width: 22,
// // // //                           height: 22,
// // // //                           child: CircularProgressIndicator(
// // // //                               color: Colors.white, strokeWidth: 2.5))
// // // //                       : Text(
// // // //                           _isEdit ? 'Update Record' : 'Save Record',
// // // //                           style: GoogleFonts.poppins(
// // // //                               fontWeight: FontWeight.w600,
// // // //                               fontSize: size.customWidth(context) * 0.038),
// // // //                         ),
// // // //                 ),
// // // //               ),
// // // //             ],
// // // //           ),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _field(
// // // //     BuildContext context,
// // // //     CustomSize size,
// // // //     String label,
// // // //     String hint,
// // // //     IconData icon,
// // // //     TextEditingController ctrl, {
// // // //     int maxLines = 1,
// // // //     bool required = true,
// // // //   }) {
// // // //     return Column(
// // // //       crossAxisAlignment: CrossAxisAlignment.start,
// // // //       children: [
// // // //         Text(label,
// // // //             style: GoogleFonts.poppins(
// // // //                 fontSize: size.customWidth(context) * 0.033,
// // // //                 fontWeight: FontWeight.w600,
// // // //                 color: AppColors.textPrimaryColor)),
// // // //         const SizedBox(height: 6),
// // // //         TextFormField(
// // // //           controller: ctrl,
// // // //           maxLines: maxLines,
// // // //           validator: required
// // // //               ? (v) =>
// // // //                   (v == null || v.trim().isEmpty) ? '$label is required' : null
// // // //               : null,
// // // //           style: GoogleFonts.poppins(
// // // //               fontSize: 13, color: AppColors.textPrimaryColor),
// // // //           decoration: InputDecoration(
// // // //             hintText: hint,
// // // //             hintStyle: GoogleFonts.poppins(
// // // //                 fontSize: 13,
// // // //                 color: AppColors.textSecondaryColor.withOpacity(0.6)),
// // // //             prefixIcon: maxLines == 1
// // // //                 ? Icon(icon, color: AppColors.primaryColor, size: 19)
// // // //                 : null,
// // // //             filled: true,
// // // //             fillColor: AppColors.lightGreyColor,
// // // //             contentPadding: EdgeInsets.symmetric(
// // // //                 horizontal: 16, vertical: maxLines > 1 ? 14 : 0),
// // // //             border: OutlineInputBorder(
// // // //                 borderRadius: BorderRadius.circular(14),
// // // //                 borderSide: BorderSide.none),
// // // //             enabledBorder: OutlineInputBorder(
// // // //                 borderRadius: BorderRadius.circular(14),
// // // //                 borderSide: BorderSide(
// // // //                     color: AppColors.greyColor.withOpacity(0.2))),
// // // //             focusedBorder: OutlineInputBorder(
// // // //                 borderRadius: BorderRadius.circular(14),
// // // //                 borderSide: const BorderSide(
// // // //                     color: AppColors.primaryColor, width: 1.5)),
// // // //             errorBorder: OutlineInputBorder(
// // // //                 borderRadius: BorderRadius.circular(14),
// // // //                 borderSide:
// // // //                     const BorderSide(color: AppColors.errorColor, width: 1)),
// // // //             focusedErrorBorder: OutlineInputBorder(
// // // //                 borderRadius: BorderRadius.circular(14),
// // // //                 borderSide: const BorderSide(
// // // //                     color: AppColors.errorColor, width: 1.5)),
// // // //           ),
// // // //         ),
// // // //       ],
// // // //     );
// // // //   }
// // // // }



// // // // lib/view/expert/appointments/appointment_detail_screen.dart
// // // import 'package:flutter/material.dart';
// // // import 'package:get/get.dart';
// // // import 'package:google_fonts/google_fonts.dart';
// // // import 'package:speechspectrum/constants/app_colors.dart';
// // // import 'package:speechspectrum/constants/custom_size.dart';
// // // import 'package:speechspectrum/controllers/my_appointment_controller.dart';
// // // import 'package:speechspectrum/models/my_appointment_model.dart';

// // // class AppointmentDetailScreen extends StatefulWidget {
// // //   const AppointmentDetailScreen({super.key});

// // //   @override
// // //   State<AppointmentDetailScreen> createState() =>
// // //       _AppointmentDetailScreenState();
// // // }

// // // class _AppointmentDetailScreenState extends State<AppointmentDetailScreen> {
// // //   late final MyAppointmentController _c;
// // //   late final String _appointmentId;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _c = Get.find<MyAppointmentController>();
// // //     _appointmentId = Get.arguments?.toString() ?? '';
// // //     WidgetsBinding.instance.addPostFrameCallback((_) {
// // //       if (_appointmentId.isNotEmpty) {
// // //         _c.fetchAppointmentDetail(_appointmentId);
// // //         _c.fetchRecords(_appointmentId);
// // //       }
// // //     });
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final size = CustomSize();
// // //     return Scaffold(
// // //       backgroundColor: AppColors.lightGreyColor,
// // //       body: Obx(() {
// // //         if (_c.isLoadingDetail.value) return _buildLoader();
// // //         final appt = _c.selectedAppointment.value;
// // //         if (appt == null) return _buildError();
// // //         return _buildBody(context, size, appt);
// // //       }),
// // //     );
// // //   }

// // //   // ── Main body ──────────────────────────────────────────────
// // //   Widget _buildBody(
// // //       BuildContext context, CustomSize size, MyAppointmentItem appt) {
// // //     final meta = _statusMeta(appt.status);

// // //     return CustomScrollView(
// // //       slivers: [
// // //         // ── SliverAppBar ──────────────────────────────────────
// // //         SliverAppBar(
// // //           expandedHeight: size.customHeight(context) * 0.26,
// // //           pinned: true,
// // //           backgroundColor: AppColors.primaryColor,
// // //           surfaceTintColor: Colors.transparent,
// // //           leading: GestureDetector(
// // //             onTap: () => Get.back(),
// // //             child: Container(
// // //               margin: const EdgeInsets.all(8),
// // //               decoration: BoxDecoration(
// // //                   color: Colors.white.withOpacity(0.2),
// // //                   borderRadius: BorderRadius.circular(12)),
// // //               child: const Icon(Icons.arrow_back_ios_new_rounded,
// // //                   color: Colors.white, size: 18),
// // //             ),
// // //           ),
// // //           flexibleSpace: FlexibleSpaceBar(
// // //             background: Container(
// // //               decoration: const BoxDecoration(
// // //                 gradient: LinearGradient(
// // //                   colors: [AppColors.primaryColor, AppColors.secondaryColor],
// // //                   begin: Alignment.topLeft,
// // //                   end: Alignment.bottomRight,
// // //                 ),
// // //               ),
// // //               child: SafeArea(
// // //                 child: Padding(
// // //                   padding: EdgeInsets.fromLTRB(
// // //                     size.customWidth(context) * 0.05,
// // //                     size.customHeight(context) * 0.07,
// // //                     size.customWidth(context) * 0.05,
// // //                     16,
// // //                   ),
// // //                   child: Column(
// // //                     mainAxisAlignment: MainAxisAlignment.end,
// // //                     children: [
// // //                       Row(
// // //                         children: [
// // //                           // Avatar
// // //                           Container(
// // //                             width: 68,
// // //                             height: 68,
// // //                             decoration: BoxDecoration(
// // //                               color: Colors.white.withOpacity(0.2),
// // //                               borderRadius: BorderRadius.circular(20),
// // //                               border: Border.all(
// // //                                   color: Colors.white.withOpacity(0.4),
// // //                                   width: 2),
// // //                             ),
// // //                             child: Center(
// // //                               child: Text(
// // //                                 appt.childInitials,
// // //                                 style: GoogleFonts.poppins(
// // //                                     color: Colors.white,
// // //                                     fontSize: 24,
// // //                                     fontWeight: FontWeight.bold),
// // //                               ),
// // //                             ),
// // //                           ),
// // //                           SizedBox(width: size.customWidth(context) * 0.04),
// // //                           Expanded(
// // //                             child: Column(
// // //                               crossAxisAlignment: CrossAxisAlignment.start,
// // //                               children: [
// // //                                 Text(
// // //                                   appt.children?.childName ?? 'Unknown',
// // //                                   style: GoogleFonts.poppins(
// // //                                       color: Colors.white,
// // //                                       fontSize:
// // //                                           size.customWidth(context) * 0.048,
// // //                                       fontWeight: FontWeight.bold),
// // //                                 ),
// // //                                 const SizedBox(height: 2),
// // //                                 Text(
// // //                                   appt.expertUsers?.fullName ?? '',
// // //                                   style: GoogleFonts.poppins(
// // //                                       color: Colors.white.withOpacity(0.9),
// // //                                       fontSize:
// // //                                           size.customWidth(context) * 0.033),
// // //                                 ),
// // //                                 Text(
// // //                                   appt.expertUsers?.specialization ?? '',
// // //                                   style: GoogleFonts.poppins(
// // //                                       color: Colors.white.withOpacity(0.75),
// // //                                       fontSize:
// // //                                           size.customWidth(context) * 0.029),
// // //                                 ),
// // //                                 const SizedBox(height: 8),
// // //                                 // Status chip
// // //                                 Container(
// // //                                   padding: const EdgeInsets.symmetric(
// // //                                       horizontal: 12, vertical: 5),
// // //                                   decoration: BoxDecoration(
// // //                                     color: meta.color.withOpacity(0.25),
// // //                                     borderRadius: BorderRadius.circular(20),
// // //                                     border: Border.all(
// // //                                         color: Colors.white.withOpacity(0.4)),
// // //                                   ),
// // //                                   child: Row(
// // //                                     mainAxisSize: MainAxisSize.min,
// // //                                     children: [
// // //                                       Icon(meta.icon,
// // //                                           color: Colors.white, size: 13),
// // //                                       const SizedBox(width: 5),
// // //                                       Text(
// // //                                         meta.label,
// // //                                         style: GoogleFonts.poppins(
// // //                                             color: Colors.white,
// // //                                             fontSize: 12,
// // //                                             fontWeight: FontWeight.w600),
// // //                                       ),
// // //                                     ],
// // //                                   ),
// // //                                 ),
// // //                               ],
// // //                             ),
// // //                           ),
// // //                         ],
// // //                       ),
// // //                     ],
// // //                   ),
// // //                 ),
// // //               ),
// // //             ),
// // //           ),
// // //         ),

// // //         // ── Sliver body ───────────────────────────────────────
// // //         SliverPadding(
// // //           padding: EdgeInsets.fromLTRB(
// // //             size.customWidth(context) * 0.045,
// // //             size.customHeight(context) * 0.02,
// // //             size.customWidth(context) * 0.045,
// // //             size.customHeight(context) * 0.06,
// // //           ),
// // //           sliver: SliverList(
// // //             delegate: SliverChildListDelegate([
// // //               // Action buttons row
// // //               _buildActionButtons(context, size, appt),
// // //               SizedBox(height: size.customHeight(context) * 0.022),

// // //               // Appointment info card
// // //               _buildInfoCard(context, size, appt),
// // //               SizedBox(height: size.customHeight(context) * 0.018),

// // //               // Slot card
// // //               if (appt.appointmentSlots != null) ...[
// // //                 _buildSlotCard(context, size, appt.appointmentSlots!),
// // //                 SizedBox(height: size.customHeight(context) * 0.018),
// // //               ],

// // //               // Expert card
// // //               if (appt.expertUsers != null) ...[
// // //                 _buildExpertCard(context, size, appt.expertUsers!),
// // //                 SizedBox(height: size.customHeight(context) * 0.018),
// // //               ],

// // //               // Cancellation card
// // //               if (appt.isCancelled) ...[
// // //                 _buildCancellationCard(context, size, appt),
// // //                 SizedBox(height: size.customHeight(context) * 0.018),
// // //               ],

// // //               // Session records
// // //               _buildRecordsSection(context, size, appt),
// // //             ]),
// // //           ),
// // //         ),
// // //       ],
// // //     );
// // //   }

// // //   // ── Action buttons ─────────────────────────────────────────
// // //   Widget _buildActionButtons(
// // //       BuildContext context, CustomSize size, MyAppointmentItem appt) {
// // //     final List<_ActionBtn> buttons = [];

// // //     if (appt.isScheduled) {
// // //       buttons.addAll([
// // //         _ActionBtn(
// // //           label: 'Confirm',
// // //           icon: Icons.check_circle_outline_rounded,
// // //           color: AppColors.primaryColor,
// // //           onTap: () => _showConfirmDialog(context, appt.appointmentId),
// // //         ),
// // //         _ActionBtn(
// // //           label: 'Cancel',
// // //           icon: Icons.cancel_outlined,
// // //           color: AppColors.errorColor,
// // //           onTap: () => _showCancelDialog(context, appt.appointmentId),
// // //         ),
// // //         _ActionBtn(
// // //           label: 'No Show',
// // //           icon: Icons.person_off_outlined,
// // //           color: AppColors.greyColor,
// // //           onTap: () => _showNoShowDialog(context, appt.appointmentId),
// // //         ),
// // //       ]);
// // //     } else if (appt.isConfirmed) {
// // //       buttons.addAll([
// // //         _ActionBtn(
// // //           label: 'Complete',
// // //           icon: Icons.task_alt_rounded,
// // //           color: AppColors.successColor,
// // //           // NEW FLOW: complete API first, then show notes sheet
// // //           onTap: () => _showCompleteConfirmDialog(context, size, appt),
// // //         ),
// // //         _ActionBtn(
// // //           label: 'Cancel',
// // //           icon: Icons.cancel_outlined,
// // //           color: AppColors.errorColor,
// // //           onTap: () => _showCancelDialog(context, appt.appointmentId),
// // //         ),
// // //         _ActionBtn(
// // //           label: 'No Show',
// // //           icon: Icons.person_off_outlined,
// // //           color: AppColors.greyColor,
// // //           onTap: () => _showNoShowDialog(context, appt.appointmentId),
// // //         ),
// // //       ]);
// // //     }

// // //     if (buttons.isEmpty) return const SizedBox.shrink();

// // //     return Row(
// // //       children: buttons.map((b) {
// // //         return Expanded(
// // //           child: GestureDetector(
// // //             onTap: b.onTap,
// // //             child: Container(
// // //               margin: const EdgeInsets.symmetric(horizontal: 4),
// // //               padding: const EdgeInsets.symmetric(vertical: 14),
// // //               decoration: BoxDecoration(
// // //                 color: b.color.withOpacity(0.09),
// // //                 borderRadius: BorderRadius.circular(16),
// // //                 border: Border.all(color: b.color.withOpacity(0.35)),
// // //               ),
// // //               child: Column(
// // //                 mainAxisSize: MainAxisSize.min,
// // //                 children: [
// // //                   Icon(b.icon, color: b.color, size: 22),
// // //                   const SizedBox(height: 5),
// // //                   Text(
// // //                     b.label,
// // //                     style: GoogleFonts.poppins(
// // //                         fontSize: 11,
// // //                         fontWeight: FontWeight.w600,
// // //                         color: b.color),
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),
// // //           ),
// // //         );
// // //       }).toList(),
// // //     );
// // //   }

// // //   // ── Info card ──────────────────────────────────────────────
// // //   Widget _buildInfoCard(
// // //       BuildContext context, CustomSize size, MyAppointmentItem appt) {
// // //     return _card(
// // //       context,
// // //       size,
// // //       title: 'Appointment Details',
// // //       icon: Icons.event_note_rounded,
// // //       iconColor: AppColors.primaryColor,
// // //       children: [
// // //         _row(context, size, 'Date', appt.formattedDate,
// // //             Icons.calendar_today_outlined),
// // //         _row(context, size, 'Time', appt.formattedTime,
// // //             Icons.access_time_rounded),
// // //         _row(context, size, 'Duration', '${appt.durationMinutes} minutes',
// // //             Icons.timer_outlined),
// // //         _row(
// // //             context,
// // //             size,
// // //             'Mode',
// // //             appt.bookedMode[0].toUpperCase() + appt.bookedMode.substring(1),
// // //             _modeIcon(appt.bookedMode)),
// // //         _row(
// // //             context,
// // //             size,
// // //             'Fee',
// // //             '${appt.currency} ${appt.feeCharged.toStringAsFixed(0)}',
// // //             Icons.payments_outlined),
// // //         if (appt.meetLink != null && appt.meetLink!.isNotEmpty)
// // //           _row(context, size, 'Meet Link', appt.meetLink!, Icons.link_rounded),
// // //       ],
// // //     );
// // //   }

// // //   // ── Slot card ──────────────────────────────────────────────
// // //   Widget _buildSlotCard(
// // //       BuildContext context, CustomSize size, AppointmentSlot slot) {
// // //     return _card(
// // //       context,
// // //       size,
// // //       title: 'Slot Information',
// // //       icon: Icons.calendar_month_rounded,
// // //       iconColor: AppColors.secondaryColor,
// // //       children: [
// // //         _row(context, size, 'Date', slot.slotDate, Icons.today_rounded),
// // //         _row(context, size, 'Time',
// // //             '${slot.formattedStart} – ${slot.formattedEnd}',
// // //             Icons.schedule_rounded),
// // //         _row(
// // //             context,
// // //             size,
// // //             'Mode',
// // //             slot.mode.isNotEmpty
// // //                 ? slot.mode[0].toUpperCase() + slot.mode.substring(1)
// // //                 : slot.mode,
// // //             _modeIcon(slot.mode)),
// // //         if (slot.status != null)
// // //           _row(context, size, 'Slot Status',
// // //               slot.status![0].toUpperCase() + slot.status!.substring(1),
// // //               Icons.info_outline_rounded),
// // //       ],
// // //     );
// // //   }

// // //   // ── Expert card ────────────────────────────────────────────
// // //   Widget _buildExpertCard(
// // //       BuildContext context, CustomSize size, AppointmentExpert expert) {
// // //     return _card(
// // //       context,
// // //       size,
// // //       title: 'Expert Information',
// // //       icon: Icons.person_outline_rounded,
// // //       iconColor: AppColors.accentColor,
// // //       children: [
// // //         _row(context, size, 'Name', expert.fullName, Icons.badge_outlined),
// // //         _row(context, size, 'Specialization', expert.specialization,
// // //             Icons.medical_information_outlined),
// // //         if (expert.phone != null && expert.phone!.isNotEmpty)
// // //           _row(context, size, 'Phone', expert.phone!, Icons.phone_outlined),
// // //         if (expert.contactEmail != null && expert.contactEmail!.isNotEmpty)
// // //           _row(context, size, 'Email', expert.contactEmail!,
// // //               Icons.email_outlined),
// // //       ],
// // //     );
// // //   }

// // //   // ── Cancellation card ──────────────────────────────────────
// // //   Widget _buildCancellationCard(
// // //       BuildContext context, CustomSize size, MyAppointmentItem appt) {
// // //     return Container(
// // //       padding: EdgeInsets.all(size.customWidth(context) * 0.045),
// // //       decoration: BoxDecoration(
// // //         color: AppColors.errorColor.withOpacity(0.05),
// // //         borderRadius: BorderRadius.circular(18),
// // //         border: Border.all(color: AppColors.errorColor.withOpacity(0.25)),
// // //       ),
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           Row(
// // //             children: [
// // //               Container(
// // //                 padding: const EdgeInsets.all(7),
// // //                 decoration: BoxDecoration(
// // //                     color: AppColors.errorColor.withOpacity(0.12),
// // //                     borderRadius: BorderRadius.circular(9)),
// // //                 child: const Icon(Icons.cancel_outlined,
// // //                     color: AppColors.errorColor, size: 17),
// // //               ),
// // //               const SizedBox(width: 10),
// // //               Text('Cancellation Info',
// // //                   style: GoogleFonts.poppins(
// // //                       fontSize: 14,
// // //                       fontWeight: FontWeight.w600,
// // //                       color: AppColors.errorColor)),
// // //             ],
// // //           ),
// // //           const SizedBox(height: 14),
// // //           if (appt.cancelledBy != null)
// // //             _row(
// // //                 context,
// // //                 size,
// // //                 'Cancelled By',
// // //                 appt.cancelledBy![0].toUpperCase() +
// // //                     appt.cancelledBy!.substring(1),
// // //                 Icons.person_outlined),
// // //           if (appt.cancellationReason != null)
// // //             _row(context, size, 'Reason', appt.cancellationReason!,
// // //                 Icons.info_outline_rounded),
// // //           if (appt.cancelledAt != null)
// // //             _row(context, size, 'Cancelled At',
// // //                 _formatDateTime(appt.cancelledAt!), Icons.schedule_rounded),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   // ── Records section ────────────────────────────────────────
// // //   Widget _buildRecordsSection(
// // //       BuildContext context, CustomSize size, MyAppointmentItem appt) {
// // //     // Only show for completed appointments
// // //     if (!appt.isCompleted) {
// // //       return const SizedBox.shrink();
// // //     }

// // //     return Column(
// // //       crossAxisAlignment: CrossAxisAlignment.start,
// // //       children: [
// // //         // Header
// // //         Row(
// // //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //           children: [
// // //             Row(
// // //               children: [
// // //                 Container(
// // //                   width: 4,
// // //                   height: 20,
// // //                   decoration: BoxDecoration(
// // //                       color: AppColors.primaryColor,
// // //                       borderRadius: BorderRadius.circular(2)),
// // //                 ),
// // //                 const SizedBox(width: 10),
// // //                 Text(
// // //                   'Session Records',
// // //                   style: GoogleFonts.poppins(
// // //                       fontSize: size.customWidth(context) * 0.042,
// // //                       fontWeight: FontWeight.bold,
// // //                       color: AppColors.textPrimaryColor),
// // //                 ),
// // //               ],
// // //             ),
// // //             // Add button
// // //             GestureDetector(
// // //               onTap: () {
// // //                 _c.clearRecordForm();
// // //                 _openRecordSheet(context, size, appt.appointmentId);
// // //               },
// // //               child: Container(
// // //                 padding:
// // //                     const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
// // //                 decoration: BoxDecoration(
// // //                   color: AppColors.primaryColor,
// // //                   borderRadius: BorderRadius.circular(10),
// // //                 ),
// // //                 child: Row(
// // //                   mainAxisSize: MainAxisSize.min,
// // //                   children: [
// // //                     const Icon(Icons.add_rounded,
// // //                         color: Colors.white, size: 16),
// // //                     const SizedBox(width: 4),
// // //                     Text('Add Note',
// // //                         style: GoogleFonts.poppins(
// // //                             color: Colors.white,
// // //                             fontWeight: FontWeight.w600,
// // //                             fontSize: 12)),
// // //                   ],
// // //                 ),
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //         SizedBox(height: size.customHeight(context) * 0.015),

// // //         Obx(() {
// // //           if (_c.isLoadingRecords.value) {
// // //             return const Center(
// // //               child: Padding(
// // //                 padding: EdgeInsets.all(30),
// // //                 child: CircularProgressIndicator(
// // //                     color: AppColors.primaryColor, strokeWidth: 2),
// // //               ),
// // //             );
// // //           }
// // //           if (_c.records.isEmpty) {
// // //             // ── HIGHLIGHTED empty state for completed with no notes ──
// // //             return _buildMissingNotesHighlight(context, size, appt);
// // //           }
// // //           return Column(
// // //             children: _c.records
// // //                 .map((r) => _buildRecordCard(context, size, r, appt))
// // //                 .toList(),
// // //           );
// // //         }),
// // //       ],
// // //     );
// // //   }

// // //   /// Prominent highlighted banner when appointment is completed but notes are missing
// // //   Widget _buildMissingNotesHighlight(
// // //       BuildContext context, CustomSize size, MyAppointmentItem appt) {
// // //     return GestureDetector(
// // //       onTap: () {
// // //         _c.clearRecordForm();
// // //         _openRecordSheet(context, size, appt.appointmentId);
// // //       },
// // //       child: Container(
// // //         padding: const EdgeInsets.all(20),
// // //         decoration: BoxDecoration(
// // //           color: AppColors.warningColor.withOpacity(0.07),
// // //           borderRadius: BorderRadius.circular(18),
// // //           border: Border.all(
// // //               color: AppColors.warningColor.withOpacity(0.5), width: 1.5),
// // //         ),
// // //         child: Row(
// // //           children: [
// // //             Container(
// // //               padding: const EdgeInsets.all(12),
// // //               decoration: BoxDecoration(
// // //                 color: AppColors.warningColor.withOpacity(0.15),
// // //                 borderRadius: BorderRadius.circular(14),
// // //               ),
// // //               child: const Icon(Icons.note_add_rounded,
// // //                   color: AppColors.warningColor, size: 28),
// // //             ),
// // //             const SizedBox(width: 16),
// // //             Expanded(
// // //               child: Column(
// // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // //                 children: [
// // //                   Text(
// // //                     'Session notes missing!',
// // //                     style: GoogleFonts.poppins(
// // //                         fontSize: 14,
// // //                         fontWeight: FontWeight.bold,
// // //                         color: AppColors.warningColor),
// // //                   ),
// // //                   const SizedBox(height: 4),
// // //                   Text(
// // //                     'This appointment is completed but has no session notes. Tap to add notes now.',
// // //                     style: GoogleFonts.poppins(
// // //                         fontSize: 12,
// // //                         color: AppColors.warningColor.withOpacity(0.8)),
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),
// // //             const SizedBox(width: 8),
// // //             Container(
// // //               padding: const EdgeInsets.all(8),
// // //               decoration: BoxDecoration(
// // //                 color: AppColors.warningColor,
// // //                 borderRadius: BorderRadius.circular(10),
// // //               ),
// // //               child: const Icon(Icons.arrow_forward_rounded,
// // //                   color: Colors.white, size: 16),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildRecordCard(BuildContext context, CustomSize size,
// // //       AppointmentRecordItem record, MyAppointmentItem appt) {
// // //     return Container(
// // //       margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.014),
// // //       decoration: BoxDecoration(
// // //         color: AppColors.whiteColor,
// // //         borderRadius: BorderRadius.circular(18),
// // //         boxShadow: [
// // //           BoxShadow(
// // //               color: Colors.black.withOpacity(0.05),
// // //               blurRadius: 10,
// // //               offset: const Offset(0, 3))
// // //         ],
// // //       ),
// // //       child: Padding(
// // //         padding: EdgeInsets.all(size.customWidth(context) * 0.042),
// // //         child: Column(
// // //           crossAxisAlignment: CrossAxisAlignment.start,
// // //           children: [
// // //             // Record header
// // //             Row(
// // //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //               children: [
// // //                 Row(
// // //                   children: [
// // //                     Container(
// // //                       padding: const EdgeInsets.all(8),
// // //                       decoration: BoxDecoration(
// // //                           color: AppColors.primaryColor.withOpacity(0.1),
// // //                           borderRadius: BorderRadius.circular(10)),
// // //                       child: const Icon(Icons.description_outlined,
// // //                           color: AppColors.primaryColor, size: 18),
// // //                     ),
// // //                     const SizedBox(width: 10),
// // //                     Column(
// // //                       crossAxisAlignment: CrossAxisAlignment.start,
// // //                       children: [
// // //                         Text('Session Note',
// // //                             style: GoogleFonts.poppins(
// // //                                 fontSize: 14,
// // //                                 fontWeight: FontWeight.w600,
// // //                                 color: AppColors.textPrimaryColor)),
// // //                         Text(record.formattedDate,
// // //                             style: GoogleFonts.poppins(
// // //                                 fontSize: 11,
// // //                                 color: AppColors.textSecondaryColor)),
// // //                       ],
// // //                     ),
// // //                   ],
// // //                 ),
// // //                 // Edit button
// // //                 GestureDetector(
// // //                   onTap: () {
// // //                     _c.populateRecordForm(record);
// // //                     _openRecordSheet(context, size, appt.appointmentId,
// // //                         editingRecord: record);
// // //                   },
// // //                   child: Container(
// // //                     padding: const EdgeInsets.all(7),
// // //                     decoration: BoxDecoration(
// // //                         color: AppColors.warningColor.withOpacity(0.1),
// // //                         borderRadius: BorderRadius.circular(9)),
// // //                     child: const Icon(Icons.edit_outlined,
// // //                         color: AppColors.warningColor, size: 16),
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //             SizedBox(height: size.customHeight(context) * 0.012),
// // //             Divider(height: 1, color: AppColors.greyColor.withOpacity(0.15)),
// // //             SizedBox(height: size.customHeight(context) * 0.012),

// // //             _recordField('Notes', record.notes, Icons.notes_rounded),
// // //             SizedBox(height: size.customHeight(context) * 0.01),
// // //             _recordField('Therapy Plan', record.therapyPlan,
// // //                 Icons.health_and_safety_outlined),
// // //             SizedBox(height: size.customHeight(context) * 0.01),
// // //             _recordField('Progress Feedback', record.progressFeedback,
// // //                 Icons.trending_up_rounded),
// // //             if (record.medication != null &&
// // //                 record.medication!['name'] != null &&
// // //                 record.medication!['name'].toString().toLowerCase() !=
// // //                     'none') ...[
// // //               SizedBox(height: size.customHeight(context) * 0.01),
// // //               _recordField(
// // //                   'Medication',
// // //                   '${record.medication!['name']}${record.medication!['dosage'] != null ? ' — ${record.medication!['dosage']}' : ''}',
// // //                   Icons.medication_outlined),
// // //             ],
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _recordField(String label, String value, IconData icon) {
// // //     return Row(
// // //       crossAxisAlignment: CrossAxisAlignment.start,
// // //       children: [
// // //         Icon(icon, size: 14, color: AppColors.primaryColor.withOpacity(0.7)),
// // //         const SizedBox(width: 8),
// // //         Expanded(
// // //           child: Column(
// // //             crossAxisAlignment: CrossAxisAlignment.start,
// // //             children: [
// // //               Text(label,
// // //                   style: GoogleFonts.poppins(
// // //                       fontSize: 11,
// // //                       color: AppColors.textSecondaryColor,
// // //                       fontWeight: FontWeight.w500)),
// // //               const SizedBox(height: 2),
// // //               Text(value,
// // //                   style: GoogleFonts.poppins(
// // //                       fontSize: 13, color: AppColors.textPrimaryColor)),
// // //             ],
// // //           ),
// // //         ),
// // //       ],
// // //     );
// // //   }

// // //   // ── Shared card widget ─────────────────────────────────────
// // //   Widget _card(
// // //     BuildContext context,
// // //     CustomSize size, {
// // //     required String title,
// // //     required IconData icon,
// // //     required Color iconColor,
// // //     required List<Widget> children,
// // //   }) {
// // //     return Container(
// // //       padding: EdgeInsets.all(size.customWidth(context) * 0.045),
// // //       decoration: BoxDecoration(
// // //         color: AppColors.whiteColor,
// // //         borderRadius: BorderRadius.circular(18),
// // //         boxShadow: [
// // //           BoxShadow(
// // //               color: Colors.black.withOpacity(0.05),
// // //               blurRadius: 10,
// // //               offset: const Offset(0, 3))
// // //         ],
// // //       ),
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           Row(
// // //             children: [
// // //               Container(
// // //                 padding: const EdgeInsets.all(8),
// // //                 decoration: BoxDecoration(
// // //                     color: iconColor.withOpacity(0.1),
// // //                     borderRadius: BorderRadius.circular(10)),
// // //                 child: Icon(icon, color: iconColor, size: 18),
// // //               ),
// // //               const SizedBox(width: 10),
// // //               Text(title,
// // //                   style: GoogleFonts.poppins(
// // //                       fontSize: 14,
// // //                       fontWeight: FontWeight.w600,
// // //                       color: AppColors.textPrimaryColor)),
// // //             ],
// // //           ),
// // //           SizedBox(height: size.customHeight(context) * 0.014),
// // //           Divider(height: 1, color: AppColors.greyColor.withOpacity(0.15)),
// // //           SizedBox(height: size.customHeight(context) * 0.012),
// // //           ...children,
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _row(BuildContext context, CustomSize size, String label, String value,
// // //       IconData icon) {
// // //     return Padding(
// // //       padding: EdgeInsets.only(bottom: size.customHeight(context) * 0.01),
// // //       child: Row(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           Icon(icon, size: 14, color: AppColors.textSecondaryColor),
// // //           const SizedBox(width: 10),
// // //           SizedBox(
// // //             width: size.customWidth(context) * 0.26,
// // //             child: Text(label,
// // //                 style: GoogleFonts.poppins(
// // //                     fontSize: 12,
// // //                     color: AppColors.textSecondaryColor,
// // //                     fontWeight: FontWeight.w500)),
// // //           ),
// // //           Expanded(
// // //             child: Text(
// // //               value,
// // //               style: GoogleFonts.poppins(
// // //                   fontSize: 13,
// // //                   color: AppColors.textPrimaryColor,
// // //                   fontWeight: FontWeight.w500),
// // //               maxLines: 3,
// // //               overflow: TextOverflow.ellipsis,
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   // ── Dialogs ────────────────────────────────────────────────

// // //   /// NEW FLOW: First show confirm dialog to complete the appointment,
// // //   /// then on success immediately open the notes sheet.
// // //   void _showCompleteConfirmDialog(
// // //       BuildContext context, CustomSize size, MyAppointmentItem appt) {
// // //     showDialog(
// // //       context: context,
// // //       barrierDismissible: false,
// // //       builder: (_) => _ActionDialog(
// // //         title: 'Complete Appointment?',
// // //         message:
// // //             'Mark this appointment as completed. You will be asked to add session notes next.',
// // //         confirmLabel: 'Yes, Complete',
// // //         confirmColor: AppColors.successColor,
// // //         icon: Icons.task_alt_rounded,
// // //         onConfirm: () async {
// // //           final ok = await _c.completeAppointment(appt.appointmentId);
// // //           return ok;
// // //         },
// // //         // After completion succeeds → open notes sheet
// // //         onSuccess: () {
// // //           _c.clearRecordForm();
// // //           _openPostCompleteNotesSheet(context, size, appt.appointmentId);
// // //         },
// // //       ),
// // //     );
// // //   }

// // //   void _showConfirmDialog(BuildContext context, String id) {
// // //     showDialog(
// // //       context: context,
// // //       barrierDismissible: false,
// // //       builder: (_) => _ActionDialog(
// // //         title: 'Confirm Appointment?',
// // //         message: 'This will confirm the appointment for the patient.',
// // //         confirmLabel: 'Yes, Confirm',
// // //         confirmColor: AppColors.primaryColor,
// // //         icon: Icons.check_circle_outline_rounded,
// // //         onConfirm: () async {
// // //           final ok = await _c.confirmAppointment(id);
// // //           return ok;
// // //         },
// // //       ),
// // //     );
// // //   }

// // //   void _showCancelDialog(BuildContext context, String id) {
// // //     showDialog(
// // //       context: context,
// // //       barrierDismissible: false,
// // //       builder: (_) => _CancelDialog(id: id, controller: _c),
// // //     );
// // //   }

// // //   void _showNoShowDialog(BuildContext context, String id) {
// // //     showDialog(
// // //       context: context,
// // //       barrierDismissible: false,
// // //       builder: (_) => _ActionDialog(
// // //         title: 'Mark as No Show?',
// // //         message: 'Patient did not attend the session. Mark as no-show?',
// // //         confirmLabel: 'Mark No Show',
// // //         confirmColor: AppColors.greyColor,
// // //         icon: Icons.person_off_outlined,
// // //         onConfirm: () async {
// // //           final ok = await _c.markNoShow(id);
// // //           return ok;
// // //         },
// // //       ),
// // //     );
// // //   }

// // //   /// Opens notes sheet AFTER completion — user must save notes.
// // //   /// This sheet auto-opens right after the appointment is marked complete.
// // //   void _openPostCompleteNotesSheet(
// // //       BuildContext context, CustomSize size, String appointmentId) {
// // //     showModalBottomSheet(
// // //       context: context,
// // //       isScrollControlled: true,
// // //       isDismissible: false, // force user to either save or skip consciously
// // //       enableDrag: false,
// // //       backgroundColor: Colors.transparent,
// // //       builder: (_) => ConstrainedBox(
// // //         constraints:
// // //             BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.93),
// // //         child: _RecordFormSheet(
// // //           controller: _c,
// // //           size: size,
// // //           appointmentId: appointmentId,
// // //           editingRecord: null,
// // //           isPostComplete: true, // signals this is the mandatory post-complete flow
// // //           onSaved: () {},
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   void _openRecordSheet(BuildContext context, CustomSize size,
// // //       String appointmentId,
// // //       {AppointmentRecordItem? editingRecord}) {
// // //     showModalBottomSheet(
// // //       context: context,
// // //       isScrollControlled: true,
// // //       backgroundColor: Colors.transparent,
// // //       builder: (_) => ConstrainedBox(
// // //         constraints:
// // //             BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.93),
// // //         child: _RecordFormSheet(
// // //           controller: _c,
// // //           size: size,
// // //           appointmentId: appointmentId,
// // //           editingRecord: editingRecord,
// // //           isPostComplete: false,
// // //           onSaved: () {},
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   // ── Helpers ────────────────────────────────────────────────
// // //   Widget _buildLoader() {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //           backgroundColor: AppColors.whiteColor,
// // //           elevation: 0,
// // //           surfaceTintColor: Colors.transparent,
// // //           leading: IconButton(
// // //             icon: const Icon(Icons.arrow_back_ios_new_rounded,
// // //                 color: AppColors.textPrimaryColor),
// // //             onPressed: () => Get.back(),
// // //           )),
// // //       body: const Center(
// // //         child: CircularProgressIndicator(
// // //             color: AppColors.primaryColor, strokeWidth: 3),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildError() {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //           backgroundColor: AppColors.whiteColor,
// // //           elevation: 0,
// // //           surfaceTintColor: Colors.transparent,
// // //           leading: IconButton(
// // //             icon: const Icon(Icons.arrow_back_ios_new_rounded,
// // //                 color: AppColors.textPrimaryColor),
// // //             onPressed: () => Get.back(),
// // //           )),
// // //       body: Center(
// // //         child: Column(
// // //           mainAxisAlignment: MainAxisAlignment.center,
// // //           children: [
// // //             const Icon(Icons.error_outline_rounded,
// // //                 size: 60, color: AppColors.errorColor),
// // //             const SizedBox(height: 16),
// // //             Text('Appointment not found',
// // //                 style: GoogleFonts.poppins(
// // //                     fontSize: 16, color: AppColors.textPrimaryColor)),
// // //             const SizedBox(height: 8),
// // //             TextButton(
// // //               onPressed: () => Get.back(),
// // //               child: Text('Go Back',
// // //                   style: GoogleFonts.poppins(color: AppColors.primaryColor)),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   String _formatDateTime(String raw) {
// // //     try {
// // //       final dt = DateTime.parse(raw).toLocal();
// // //       const months = [
// // //         '',
// // //         'Jan',
// // //         'Feb',
// // //         'Mar',
// // //         'Apr',
// // //         'May',
// // //         'Jun',
// // //         'Jul',
// // //         'Aug',
// // //         'Sep',
// // //         'Oct',
// // //         'Nov',
// // //         'Dec'
// // //       ];
// // //       int h = dt.hour;
// // //       final m = dt.minute.toString().padLeft(2, '0');
// // //       final ampm = h >= 12 ? 'PM' : 'AM';
// // //       if (h > 12) h -= 12;
// // //       if (h == 0) h = 12;
// // //       return '${dt.day} ${months[dt.month]} ${dt.year}, $h:$m $ampm';
// // //     } catch (_) {
// // //       return raw;
// // //     }
// // //   }

// // //   _StatusMeta _statusMeta(String status) {
// // //     switch (status.toLowerCase()) {
// // //       case 'confirmed':
// // //         return _StatusMeta(
// // //             AppColors.primaryColor, 'Confirmed', Icons.check_circle_outlined);
// // //       case 'completed':
// // //         return _StatusMeta(
// // //             AppColors.successColor, 'Completed', Icons.task_alt_rounded);
// // //       case 'cancelled':
// // //         return _StatusMeta(
// // //             AppColors.errorColor, 'Cancelled', Icons.cancel_outlined);
// // //       case 'no_show':
// // //         return _StatusMeta(
// // //             AppColors.greyColor, 'No Show', Icons.person_off_outlined);
// // //       default:
// // //         return _StatusMeta(
// // //             AppColors.warningColor, 'Scheduled', Icons.schedule_rounded);
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

// // // // ── Data classes ───────────────────────────────────────────────
// // // class _StatusMeta {
// // //   final Color color;
// // //   final String label;
// // //   final IconData icon;
// // //   _StatusMeta(this.color, this.label, this.icon);
// // // }

// // // class _ActionBtn {
// // //   final String label;
// // //   final IconData icon;
// // //   final Color color;
// // //   final VoidCallback onTap;
// // //   _ActionBtn(
// // //       {required this.label,
// // //       required this.icon,
// // //       required this.color,
// // //       required this.onTap});
// // // }

// // // // ══════════════════════════════════════════════════════════════
// // // // Generic action confirm dialog
// // // // Added optional [onSuccess] callback — fires after dialog closes on success
// // // // ══════════════════════════════════════════════════════════════
// // // class _ActionDialog extends StatefulWidget {
// // //   final String title;
// // //   final String message;
// // //   final String confirmLabel;
// // //   final Color confirmColor;
// // //   final IconData icon;
// // //   final Future<bool> Function() onConfirm;
// // //   final VoidCallback? onSuccess; // <-- NEW: called after pop on success

// // //   const _ActionDialog({
// // //     required this.title,
// // //     required this.message,
// // //     required this.confirmLabel,
// // //     required this.confirmColor,
// // //     required this.icon,
// // //     required this.onConfirm,
// // //     this.onSuccess,
// // //   });

// // //   @override
// // //   State<_ActionDialog> createState() => _ActionDialogState();
// // // }

// // // class _ActionDialogState extends State<_ActionDialog> {
// // //   bool _loading = false;

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return AlertDialog(
// // //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
// // //       contentPadding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
// // //       content: Column(
// // //         mainAxisSize: MainAxisSize.min,
// // //         children: [
// // //           Container(
// // //             padding: const EdgeInsets.all(16),
// // //             decoration: BoxDecoration(
// // //                 color: widget.confirmColor.withOpacity(0.1),
// // //                 shape: BoxShape.circle),
// // //             child: Icon(widget.icon, color: widget.confirmColor, size: 34),
// // //           ),
// // //           const SizedBox(height: 16),
// // //           Text(widget.title,
// // //               style: GoogleFonts.poppins(
// // //                   fontSize: 17,
// // //                   fontWeight: FontWeight.bold,
// // //                   color: AppColors.textPrimaryColor),
// // //               textAlign: TextAlign.center),
// // //           const SizedBox(height: 8),
// // //           Text(widget.message,
// // //               style: GoogleFonts.poppins(
// // //                   fontSize: 13, color: AppColors.textSecondaryColor),
// // //               textAlign: TextAlign.center),
// // //           const SizedBox(height: 24),
// // //           Row(
// // //             children: [
// // //               Expanded(
// // //                 child: OutlinedButton(
// // //                   onPressed: _loading ? null : () => Navigator.pop(context),
// // //                   style: OutlinedButton.styleFrom(
// // //                     foregroundColor: AppColors.textSecondaryColor,
// // //                     side: BorderSide(
// // //                         color: AppColors.greyColor.withOpacity(0.5)),
// // //                     shape: RoundedRectangleBorder(
// // //                         borderRadius: BorderRadius.circular(12)),
// // //                     padding: const EdgeInsets.symmetric(vertical: 13),
// // //                   ),
// // //                   child: Text('Cancel',
// // //                       style: GoogleFonts.poppins(
// // //                           fontWeight: FontWeight.w500, fontSize: 13)),
// // //                 ),
// // //               ),
// // //               const SizedBox(width: 12),
// // //               Expanded(
// // //                 child: ElevatedButton(
// // //                   onPressed: _loading
// // //                       ? null
// // //                       : () async {
// // //                           setState(() => _loading = true);
// // //                           final ok = await widget.onConfirm();
// // //                           if (mounted) {
// // //                             setState(() => _loading = false);
// // //                             if (ok) {
// // //                               Navigator.pop(context);
// // //                               // Fire onSuccess AFTER dialog is closed
// // //                               widget.onSuccess?.call();
// // //                             }
// // //                           }
// // //                         },
// // //                   style: ElevatedButton.styleFrom(
// // //                     backgroundColor: widget.confirmColor,
// // //                     foregroundColor: Colors.white,
// // //                     disabledBackgroundColor:
// // //                         widget.confirmColor.withOpacity(0.5),
// // //                     shape: RoundedRectangleBorder(
// // //                         borderRadius: BorderRadius.circular(12)),
// // //                     padding: const EdgeInsets.symmetric(vertical: 13),
// // //                     elevation: 0,
// // //                   ),
// // //                   child: _loading
// // //                       ? const SizedBox(
// // //                           width: 18,
// // //                           height: 18,
// // //                           child: CircularProgressIndicator(
// // //                               color: Colors.white, strokeWidth: 2))
// // //                       : Text(widget.confirmLabel,
// // //                           style: GoogleFonts.poppins(
// // //                               fontWeight: FontWeight.w600, fontSize: 13)),
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }

// // // // ══════════════════════════════════════════════════════════════
// // // // Cancel dialog with reason input
// // // // ══════════════════════════════════════════════════════════════
// // // class _CancelDialog extends StatefulWidget {
// // //   final String id;
// // //   final MyAppointmentController controller;

// // //   const _CancelDialog({required this.id, required this.controller});

// // //   @override
// // //   State<_CancelDialog> createState() => _CancelDialogState();
// // // }

// // // class _CancelDialogState extends State<_CancelDialog> {
// // //   final _reasonCtrl = TextEditingController();
// // //   bool _loading = false;

// // //   @override
// // //   void dispose() {
// // //     _reasonCtrl.dispose();
// // //     super.dispose();
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return AlertDialog(
// // //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
// // //       contentPadding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
// // //       content: Column(
// // //         mainAxisSize: MainAxisSize.min,
// // //         children: [
// // //           Container(
// // //             padding: const EdgeInsets.all(16),
// // //             decoration: BoxDecoration(
// // //                 color: AppColors.errorColor.withOpacity(0.1),
// // //                 shape: BoxShape.circle),
// // //             child: const Icon(Icons.cancel_outlined,
// // //                 color: AppColors.errorColor, size: 34),
// // //           ),
// // //           const SizedBox(height: 16),
// // //           Text('Cancel Appointment',
// // //               style: GoogleFonts.poppins(
// // //                   fontSize: 17,
// // //                   fontWeight: FontWeight.bold,
// // //                   color: AppColors.textPrimaryColor),
// // //               textAlign: TextAlign.center),
// // //           const SizedBox(height: 6),
// // //           Text('Please provide a cancellation reason.',
// // //               style: GoogleFonts.poppins(
// // //                   fontSize: 13, color: AppColors.textSecondaryColor),
// // //               textAlign: TextAlign.center),
// // //           const SizedBox(height: 18),
// // //           TextField(
// // //             controller: _reasonCtrl,
// // //             maxLines: 3,
// // //             style: GoogleFonts.poppins(
// // //                 fontSize: 13, color: AppColors.textPrimaryColor),
// // //             decoration: InputDecoration(
// // //               hintText: 'Enter reason here...',
// // //               hintStyle: GoogleFonts.poppins(
// // //                   fontSize: 13,
// // //                   color: AppColors.textSecondaryColor.withOpacity(0.6)),
// // //               filled: true,
// // //               fillColor: AppColors.lightGreyColor,
// // //               contentPadding: const EdgeInsets.all(14),
// // //               border: OutlineInputBorder(
// // //                   borderRadius: BorderRadius.circular(12),
// // //                   borderSide: BorderSide.none),
// // //               enabledBorder: OutlineInputBorder(
// // //                   borderRadius: BorderRadius.circular(12),
// // //                   borderSide: BorderSide(
// // //                       color: AppColors.greyColor.withOpacity(0.25))),
// // //               focusedBorder: OutlineInputBorder(
// // //                   borderRadius: BorderRadius.circular(12),
// // //                   borderSide: const BorderSide(
// // //                       color: AppColors.primaryColor, width: 1.5)),
// // //             ),
// // //           ),
// // //           const SizedBox(height: 20),
// // //           Row(
// // //             children: [
// // //               Expanded(
// // //                 child: OutlinedButton(
// // //                   onPressed: _loading ? null : () => Navigator.pop(context),
// // //                   style: OutlinedButton.styleFrom(
// // //                     foregroundColor: AppColors.textSecondaryColor,
// // //                     side: BorderSide(
// // //                         color: AppColors.greyColor.withOpacity(0.5)),
// // //                     shape: RoundedRectangleBorder(
// // //                         borderRadius: BorderRadius.circular(12)),
// // //                     padding: const EdgeInsets.symmetric(vertical: 13),
// // //                   ),
// // //                   child: Text('Back',
// // //                       style: GoogleFonts.poppins(
// // //                           fontWeight: FontWeight.w500, fontSize: 13)),
// // //                 ),
// // //               ),
// // //               const SizedBox(width: 12),
// // //               Expanded(
// // //                 child: ElevatedButton(
// // //                   onPressed: _loading
// // //                       ? null
// // //                       : () async {
// // //                           final reason = _reasonCtrl.text.trim();
// // //                           if (reason.isEmpty) {
// // //                             Get.snackbar(
// // //                               'Required',
// // //                               'Please enter a cancellation reason',
// // //                               snackPosition: SnackPosition.BOTTOM,
// // //                               backgroundColor: AppColors.warningColor,
// // //                               colorText: Colors.white,
// // //                               margin: const EdgeInsets.all(16),
// // //                               borderRadius: 12,
// // //                             );
// // //                             return;
// // //                           }
// // //                           setState(() => _loading = true);
// // //                           final ok = await widget.controller
// // //                               .cancelAppointment(widget.id, reason);
// // //                           if (mounted) {
// // //                             setState(() => _loading = false);
// // //                             if (ok) Navigator.pop(context);
// // //                           }
// // //                         },
// // //                   style: ElevatedButton.styleFrom(
// // //                     backgroundColor: AppColors.errorColor,
// // //                     foregroundColor: Colors.white,
// // //                     disabledBackgroundColor:
// // //                         AppColors.errorColor.withOpacity(0.5),
// // //                     shape: RoundedRectangleBorder(
// // //                         borderRadius: BorderRadius.circular(12)),
// // //                     padding: const EdgeInsets.symmetric(vertical: 13),
// // //                     elevation: 0,
// // //                   ),
// // //                   child: _loading
// // //                       ? const SizedBox(
// // //                           width: 18,
// // //                           height: 18,
// // //                           child: CircularProgressIndicator(
// // //                               color: Colors.white, strokeWidth: 2))
// // //                       : Text('Cancel Appt.',
// // //                           style: GoogleFonts.poppins(
// // //                               fontWeight: FontWeight.w600, fontSize: 13)),
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }

// // // // ══════════════════════════════════════════════════════════════
// // // // Record form sheet (Add / Edit for completed appointments)
// // // // [isPostComplete] = true means this opened right after completion —
// // // // shows a special header and a "Skip for now" option instead of just closing.
// // // // ══════════════════════════════════════════════════════════════
// // // class _RecordFormSheet extends StatefulWidget {
// // //   final MyAppointmentController controller;
// // //   final CustomSize size;
// // //   final String appointmentId;
// // //   final AppointmentRecordItem? editingRecord;
// // //   final bool isPostComplete;
// // //   final VoidCallback? onSaved;

// // //   const _RecordFormSheet({
// // //     required this.controller,
// // //     required this.size,
// // //     required this.appointmentId,
// // //     this.editingRecord,
// // //     this.isPostComplete = false,
// // //     this.onSaved,
// // //   });

// // //   @override
// // //   State<_RecordFormSheet> createState() => _RecordFormSheetState();
// // // }

// // // class _RecordFormSheetState extends State<_RecordFormSheet> {
// // //   final _formKey = GlobalKey<FormState>();
// // //   bool _saving = false;

// // //   bool get _isEdit => widget.editingRecord != null;

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final size = widget.size;

// // //     return Container(
// // //       decoration: const BoxDecoration(
// // //         color: AppColors.whiteColor,
// // //         borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
// // //       ),
// // //       padding:
// // //           EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
// // //       child: SingleChildScrollView(
// // //         physics: const ClampingScrollPhysics(),
// // //         padding: EdgeInsets.fromLTRB(
// // //           size.customWidth(context) * 0.05,
// // //           20,
// // //           size.customWidth(context) * 0.05,
// // //           size.customHeight(context) * 0.04,
// // //         ),
// // //         child: Form(
// // //           key: _formKey,
// // //           child: Column(
// // //             crossAxisAlignment: CrossAxisAlignment.start,
// // //             mainAxisSize: MainAxisSize.min,
// // //             children: [
// // //               // Handle bar
// // //               Center(
// // //                 child: Container(
// // //                   width: 44,
// // //                   height: 4,
// // //                   decoration: BoxDecoration(
// // //                       color: AppColors.greyColor.withOpacity(0.3),
// // //                       borderRadius: BorderRadius.circular(2)),
// // //                 ),
// // //               ),
// // //               const SizedBox(height: 20),

// // //               // ── Header ──────────────────────────────────────
// // //               Row(
// // //                 children: [
// // //                   Container(
// // //                     padding: const EdgeInsets.all(10),
// // //                     decoration: BoxDecoration(
// // //                         color: (widget.isPostComplete
// // //                                 ? AppColors.successColor
// // //                                 : AppColors.primaryColor)
// // //                             .withOpacity(0.1),
// // //                         borderRadius: BorderRadius.circular(12)),
// // //                     child: Icon(
// // //                       _isEdit
// // //                           ? Icons.edit_note_rounded
// // //                           : widget.isPostComplete
// // //                               ? Icons.task_alt_rounded
// // //                               : Icons.note_add_rounded,
// // //                       color: widget.isPostComplete
// // //                           ? AppColors.successColor
// // //                           : AppColors.primaryColor,
// // //                       size: 22,
// // //                     ),
// // //                   ),
// // //                   const SizedBox(width: 12),
// // //                   Expanded(
// // //                     child: Column(
// // //                       crossAxisAlignment: CrossAxisAlignment.start,
// // //                       children: [
// // //                         Text(
// // //                           _isEdit
// // //                               ? 'Update Session Record'
// // //                               : widget.isPostComplete
// // //                                   ? 'Appointment Completed!'
// // //                                   : 'New Session Record',
// // //                           style: GoogleFonts.poppins(
// // //                               fontSize: size.customWidth(context) * 0.042,
// // //                               fontWeight: FontWeight.bold,
// // //                               color: AppColors.textPrimaryColor),
// // //                         ),
// // //                         Text(
// // //                           _isEdit
// // //                               ? 'Edit session details'
// // //                               : widget.isPostComplete
// // //                                   ? 'Now add session notes to document this session'
// // //                                   : 'Document this session',
// // //                           style: GoogleFonts.poppins(
// // //                               fontSize: size.customWidth(context) * 0.031,
// // //                               color: AppColors.textSecondaryColor),
// // //                         ),
// // //                       ],
// // //                     ),
// // //                   ),
// // //                 ],
// // //               ),

// // //               // Post-complete info banner
// // //               if (widget.isPostComplete) ...[
// // //                 const SizedBox(height: 12),
// // //                 Container(
// // //                   padding:
// // //                       const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
// // //                   decoration: BoxDecoration(
// // //                     color: AppColors.successColor.withOpacity(0.07),
// // //                     borderRadius: BorderRadius.circular(12),
// // //                     border: Border.all(
// // //                         color: AppColors.successColor.withOpacity(0.3)),
// // //                   ),
// // //                   child: Row(
// // //                     children: [
// // //                       const Icon(Icons.check_circle_rounded,
// // //                           color: AppColors.successColor, size: 16),
// // //                       const SizedBox(width: 8),
// // //                       Expanded(
// // //                         child: Text(
// // //                           'Great! The appointment is now marked as completed. Please add session notes below.',
// // //                           style: GoogleFonts.poppins(
// // //                               fontSize: 12,
// // //                               color: AppColors.successColor),
// // //                         ),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                 ),
// // //               ],

// // //               SizedBox(height: size.customHeight(context) * 0.022),

// // //               // ── Form fields ──────────────────────────────────
// // //               _field(context, size, 'Session Notes *',
// // //                   'Describe what happened during the session...',
// // //                   Icons.notes_rounded, widget.controller.notesCtrl,
// // //                   maxLines: 3, required: true),
// // //               SizedBox(height: size.customHeight(context) * 0.016),

// // //               _field(context, size, 'Therapy Plan *',
// // //                   'Outline the plan for next sessions...',
// // //                   Icons.health_and_safety_outlined,
// // //                   widget.controller.therapyPlanCtrl,
// // //                   maxLines: 3, required: true),
// // //               SizedBox(height: size.customHeight(context) * 0.016),

// // //               _field(context, size, 'Progress Feedback *',
// // //                   'How did the patient progress?',
// // //                   Icons.trending_up_rounded,
// // //                   widget.controller.progressFeedbackCtrl,
// // //                   maxLines: 2, required: true),
// // //               SizedBox(height: size.customHeight(context) * 0.016),

// // //               Text('Medication (optional)',
// // //                   style: GoogleFonts.poppins(
// // //                       fontSize: size.customWidth(context) * 0.034,
// // //                       fontWeight: FontWeight.w600,
// // //                       color: AppColors.textPrimaryColor)),
// // //               const SizedBox(height: 8),
// // //               Row(
// // //                 children: [
// // //                   Expanded(
// // //                     child: _field(context, size, 'Name', 'e.g. None',
// // //                         Icons.medication_outlined,
// // //                         widget.controller.medicationNameCtrl,
// // //                         maxLines: 1, required: false),
// // //                   ),
// // //                   SizedBox(width: size.customWidth(context) * 0.03),
// // //                   Expanded(
// // //                     child: _field(context, size, 'Dosage', 'e.g. 5mg',
// // //                         Icons.science_outlined,
// // //                         widget.controller.medicationDosageCtrl,
// // //                         maxLines: 1, required: false),
// // //                   ),
// // //                 ],
// // //               ),
// // //               SizedBox(height: size.customHeight(context) * 0.028),

// // //               // ── Save button ──────────────────────────────────
// // //               SizedBox(
// // //                 width: double.infinity,
// // //                 child: ElevatedButton(
// // //                   onPressed: _saving
// // //                       ? null
// // //                       : () async {
// // //                           if (!_formKey.currentState!.validate()) return;
// // //                           setState(() => _saving = true);
// // //                           bool ok;
// // //                           if (_isEdit) {
// // //                             ok = await widget.controller.updateRecord(
// // //                               widget.appointmentId,
// // //                               widget.editingRecord!.recordId,
// // //                             );
// // //                           } else {
// // //                             ok = await widget.controller
// // //                                 .createRecord(widget.appointmentId);
// // //                           }
// // //                           if (mounted) setState(() => _saving = false);
// // //                           if (ok && context.mounted) {
// // //                             widget.onSaved?.call();
// // //                             Navigator.pop(context);
// // //                           }
// // //                         },
// // //                   style: ElevatedButton.styleFrom(
// // //                     backgroundColor: widget.isPostComplete
// // //                         ? AppColors.successColor
// // //                         : AppColors.primaryColor,
// // //                     foregroundColor: Colors.white,
// // //                     disabledBackgroundColor: (widget.isPostComplete
// // //                             ? AppColors.successColor
// // //                             : AppColors.primaryColor)
// // //                         .withOpacity(0.4),
// // //                     padding: EdgeInsets.symmetric(
// // //                         vertical: size.customHeight(context) * 0.02),
// // //                     shape: RoundedRectangleBorder(
// // //                         borderRadius: BorderRadius.circular(16)),
// // //                     elevation: 2,
// // //                   ),
// // //                   child: _saving
// // //                       ? const SizedBox(
// // //                           width: 22,
// // //                           height: 22,
// // //                           child: CircularProgressIndicator(
// // //                               color: Colors.white, strokeWidth: 2.5))
// // //                       : Text(
// // //                           _isEdit ? 'Update Record' : 'Save Session Notes',
// // //                           style: GoogleFonts.poppins(
// // //                               fontWeight: FontWeight.w600,
// // //                               fontSize: size.customWidth(context) * 0.038),
// // //                         ),
// // //                 ),
// // //               ),

// // //               // Skip button — only shown in post-complete flow
// // //               if (widget.isPostComplete && !_isEdit) ...[
// // //                 SizedBox(height: size.customHeight(context) * 0.008),
// // //                 SizedBox(
// // //                   width: double.infinity,
// // //                   child: TextButton(
// // //                     onPressed: _saving
// // //                         ? null
// // //                         : () => Navigator.pop(context),
// // //                     child: Text(
// // //                       'Skip for now (add later from session records)',
// // //                       style: GoogleFonts.poppins(
// // //                           color: AppColors.textSecondaryColor,
// // //                           fontWeight: FontWeight.w500,
// // //                           fontSize: 12),
// // //                       textAlign: TextAlign.center,
// // //                     ),
// // //                   ),
// // //                 ),
// // //               ],
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _field(
// // //     BuildContext context,
// // //     CustomSize size,
// // //     String label,
// // //     String hint,
// // //     IconData icon,
// // //     TextEditingController ctrl, {
// // //     int maxLines = 1,
// // //     bool required = true,
// // //   }) {
// // //     return Column(
// // //       crossAxisAlignment: CrossAxisAlignment.start,
// // //       children: [
// // //         Text(label,
// // //             style: GoogleFonts.poppins(
// // //                 fontSize: size.customWidth(context) * 0.033,
// // //                 fontWeight: FontWeight.w600,
// // //                 color: AppColors.textPrimaryColor)),
// // //         const SizedBox(height: 6),
// // //         TextFormField(
// // //           controller: ctrl,
// // //           maxLines: maxLines,
// // //           validator: required
// // //               ? (v) =>
// // //                   (v == null || v.trim().isEmpty) ? '$label is required' : null
// // //               : null,
// // //           style: GoogleFonts.poppins(
// // //               fontSize: 13, color: AppColors.textPrimaryColor),
// // //           decoration: InputDecoration(
// // //             hintText: hint,
// // //             hintStyle: GoogleFonts.poppins(
// // //                 fontSize: 13,
// // //                 color: AppColors.textSecondaryColor.withOpacity(0.6)),
// // //             prefixIcon: maxLines == 1
// // //                 ? Icon(icon, color: AppColors.primaryColor, size: 19)
// // //                 : null,
// // //             filled: true,
// // //             fillColor: AppColors.lightGreyColor,
// // //             contentPadding: EdgeInsets.symmetric(
// // //                 horizontal: 16, vertical: maxLines > 1 ? 14 : 0),
// // //             border: OutlineInputBorder(
// // //                 borderRadius: BorderRadius.circular(14),
// // //                 borderSide: BorderSide.none),
// // //             enabledBorder: OutlineInputBorder(
// // //                 borderRadius: BorderRadius.circular(14),
// // //                 borderSide: BorderSide(
// // //                     color: AppColors.greyColor.withOpacity(0.2))),
// // //             focusedBorder: OutlineInputBorder(
// // //                 borderRadius: BorderRadius.circular(14),
// // //                 borderSide: const BorderSide(
// // //                     color: AppColors.primaryColor, width: 1.5)),
// // //             errorBorder: OutlineInputBorder(
// // //                 borderRadius: BorderRadius.circular(14),
// // //                 borderSide:
// // //                     const BorderSide(color: AppColors.errorColor, width: 1)),
// // //             focusedErrorBorder: OutlineInputBorder(
// // //                 borderRadius: BorderRadius.circular(14),
// // //                 borderSide: const BorderSide(
// // //                     color: AppColors.errorColor, width: 1.5)),
// // //           ),
// // //         ),
// // //       ],
// // //     );
// // //   }
// // // }


// // // lib/view/expert/appointments/appointment_detail_screen.dart
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:speechspectrum/constants/app_colors.dart';
// // import 'package:speechspectrum/constants/custom_size.dart';
// // import 'package:speechspectrum/controllers/my_appointment_controller.dart';
// // import 'package:speechspectrum/models/my_appointment_model.dart';

// // class AppointmentDetailScreen extends StatefulWidget {
// //   const AppointmentDetailScreen({super.key});

// //   @override
// //   State<AppointmentDetailScreen> createState() =>
// //       _AppointmentDetailScreenState();
// // }

// // class _AppointmentDetailScreenState extends State<AppointmentDetailScreen> {
// //   late final MyAppointmentController _c;
// //   late final String _appointmentId;

// //   // These come instantly from navigation arguments — no "Unknown" flash
// //   late final String _argChildName;
// //   late final String _argExpertName;
// //   late final String _argSpecialization;
// //   late final String _argChildInitials;
// //   late final String _argStatus;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _c = Get.find<MyAppointmentController>();

// //     // Parse arguments — supports both Map (new) and plain String (legacy)
// //     final args = Get.arguments;
// //     if (args is Map) {
// //       _appointmentId = (args['appointmentId'] ?? '').toString();
// //       _argChildName = (args['childName'] ?? '').toString();
// //       _argExpertName = (args['expertName'] ?? '').toString();
// //       _argSpecialization = (args['specialization'] ?? '').toString();
// //       _argChildInitials = (args['childInitials'] ?? '').toString();
// //       _argStatus = (args['status'] ?? '').toString();
// //     } else {
// //       _appointmentId = args?.toString() ?? '';
// //       _argChildName = '';
// //       _argExpertName = '';
// //       _argSpecialization = '';
// //       _argChildInitials = '';
// //       _argStatus = '';
// //     }

// //     WidgetsBinding.instance.addPostFrameCallback((_) {
// //       if (_appointmentId.isNotEmpty) {
// //         _c.fetchAppointmentDetail(_appointmentId);
// //         _c.fetchRecords(_appointmentId);
// //       }
// //     });
// //   }

// //   // ── Header values: use API data once loaded, else fall back to args ──
// //   String get _displayChildName {
// //     final fromApi = _c.selectedAppointment.value?.children?.childName ?? '';
// //     return fromApi.isNotEmpty ? fromApi : _argChildName;
// //   }

// //   String get _displayExpertName {
// //     final fromApi = _c.selectedAppointment.value?.expertUsers?.fullName ?? '';
// //     return fromApi.isNotEmpty ? fromApi : _argExpertName;
// //   }

// //   String get _displaySpecialization {
// //     final fromApi =
// //         _c.selectedAppointment.value?.expertUsers?.specialization ?? '';
// //     return fromApi.isNotEmpty ? fromApi : _argSpecialization;
// //   }

// //   String get _displayInitials {
// //     final fromApi = _c.selectedAppointment.value?.childInitials ?? '';
// //     return fromApi.isNotEmpty ? fromApi : _argChildInitials;
// //   }

// //   String get _displayStatus {
// //     final fromApi = _c.selectedAppointment.value?.status ?? '';
// //     return fromApi.isNotEmpty ? fromApi : _argStatus;
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final size = CustomSize();
// //     return Scaffold(
// //       backgroundColor: AppColors.lightGreyColor,
// //       body: Obx(() {
// //         // Show skeleton header + loader while detail is loading
// //         if (_c.isLoadingDetail.value &&
// //             _c.selectedAppointment.value == null) {
// //           return _buildLoadingWithHeader(context, size);
// //         }
// //         final appt = _c.selectedAppointment.value;
// //         if (appt == null) return _buildError();
// //         return _buildBody(context, size, appt);
// //       }),
// //     );
// //   }

// //   // ── Loading state: header already shows names from args ───────────────
// //   Widget _buildLoadingWithHeader(BuildContext context, CustomSize size) {
// //     final meta = _statusMeta(_argStatus);
// //     return CustomScrollView(
// //       slivers: [
// //         SliverAppBar(
// //           expandedHeight: size.customHeight(context) * 0.26,
// //           pinned: true,
// //           backgroundColor: AppColors.primaryColor,
// //           surfaceTintColor: Colors.transparent,
// //           leading: GestureDetector(
// //             onTap: () => Get.back(),
// //             child: Container(
// //               margin: const EdgeInsets.all(8),
// //               decoration: BoxDecoration(
// //                   color: Colors.white.withOpacity(0.2),
// //                   borderRadius: BorderRadius.circular(12)),
// //               child: const Icon(Icons.arrow_back_ios_new_rounded,
// //                   color: Colors.white, size: 18),
// //             ),
// //           ),
// //           flexibleSpace: FlexibleSpaceBar(
// //             background: _buildHeaderBackground(
// //               context,
// //               size,
// //               initials: _argChildInitials,
// //               childName: _argChildName,
// //               expertName: _argExpertName,
// //               specialization: _argSpecialization,
// //               status: _argStatus,
// //               meta: meta,
// //             ),
// //           ),
// //         ),
// //         const SliverFillRemaining(
// //           child: Center(
// //             child: CircularProgressIndicator(
// //                 color: AppColors.primaryColor, strokeWidth: 3),
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   // ── Main body ──────────────────────────────────────────────
// //   Widget _buildBody(
// //       BuildContext context, CustomSize size, MyAppointmentItem appt) {
// //     final meta = _statusMeta(appt.status);

// //     return CustomScrollView(
// //       slivers: [
// //         // ── SliverAppBar ──────────────────────────────────────
// //         SliverAppBar(
// //           expandedHeight: size.customHeight(context) * 0.26,
// //           pinned: true,
// //           backgroundColor: AppColors.primaryColor,
// //           surfaceTintColor: Colors.transparent,
// //           leading: GestureDetector(
// //             onTap: () => Get.back(),
// //             child: Container(
// //               margin: const EdgeInsets.all(8),
// //               decoration: BoxDecoration(
// //                   color: Colors.white.withOpacity(0.2),
// //                   borderRadius: BorderRadius.circular(12)),
// //               child: const Icon(Icons.arrow_back_ios_new_rounded,
// //                   color: Colors.white, size: 18),
// //             ),
// //           ),
// //           flexibleSpace: FlexibleSpaceBar(
// //             background: _buildHeaderBackground(
// //               context,
// //               size,
// //               initials: appt.childInitials,
// //               childName: appt.children?.childName ?? _argChildName,
// //               expertName: appt.expertUsers?.fullName ?? _argExpertName,
// //               specialization:
// //                   appt.expertUsers?.specialization ?? _argSpecialization,
// //               status: appt.status,
// //               meta: meta,
// //             ),
// //           ),
// //         ),

// //         // ── Sliver body ───────────────────────────────────────
// //         SliverPadding(
// //           padding: EdgeInsets.fromLTRB(
// //             size.customWidth(context) * 0.045,
// //             size.customHeight(context) * 0.02,
// //             size.customWidth(context) * 0.045,
// //             size.customHeight(context) * 0.06,
// //           ),
// //           sliver: SliverList(
// //             delegate: SliverChildListDelegate([
// //               // Action buttons row
// //               _buildActionButtons(context, size, appt),
// //               SizedBox(height: size.customHeight(context) * 0.022),

// //               // Appointment info card
// //               _buildInfoCard(context, size, appt),
// //               SizedBox(height: size.customHeight(context) * 0.018),

// //               // Slot card
// //               if (appt.appointmentSlots != null) ...[
// //                 _buildSlotCard(context, size, appt.appointmentSlots!),
// //                 SizedBox(height: size.customHeight(context) * 0.018),
// //               ],

// //               // Expert card
// //               if (appt.expertUsers != null) ...[
// //                 _buildExpertCard(context, size, appt.expertUsers!),
// //                 SizedBox(height: size.customHeight(context) * 0.018),
// //               ],

// //               // Cancellation card
// //               if (appt.isCancelled) ...[
// //                 _buildCancellationCard(context, size, appt),
// //                 SizedBox(height: size.customHeight(context) * 0.018),
// //               ],

// //               // Session records
// //               _buildRecordsSection(context, size, appt),
// //             ]),
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   // ── Shared header background widget ───────────────────────
// //   Widget _buildHeaderBackground(
// //     BuildContext context,
// //     CustomSize size, {
// //     required String initials,
// //     required String childName,
// //     required String expertName,
// //     required String specialization,
// //     required String status,
// //     required _StatusMeta meta,
// //   }) {
// //     return Container(
// //       decoration: const BoxDecoration(
// //         gradient: LinearGradient(
// //           colors: [AppColors.primaryColor, AppColors.secondaryColor],
// //           begin: Alignment.topLeft,
// //           end: Alignment.bottomRight,
// //         ),
// //       ),
// //       child: SafeArea(
// //         child: Padding(
// //           padding: EdgeInsets.fromLTRB(
// //             size.customWidth(context) * 0.05,
// //             size.customHeight(context) * 0.07,
// //             size.customWidth(context) * 0.05,
// //             16,
// //           ),
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.end,
// //             children: [
// //               Row(
// //                 children: [
// //                   // Avatar
// //                   Container(
// //                     width: 68,
// //                     height: 68,
// //                     decoration: BoxDecoration(
// //                       color: Colors.white.withOpacity(0.2),
// //                       borderRadius: BorderRadius.circular(20),
// //                       border: Border.all(
// //                           color: Colors.white.withOpacity(0.4), width: 2),
// //                     ),
// //                     child: Center(
// //                       child: Text(
// //                         initials.isNotEmpty ? initials : 'C',
// //                         style: GoogleFonts.poppins(
// //                             color: Colors.white,
// //                             fontSize: 24,
// //                             fontWeight: FontWeight.bold),
// //                       ),
// //                     ),
// //                   ),
// //                   SizedBox(width: size.customWidth(context) * 0.04),
// //                   Expanded(
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         Text(
// //                           childName.isNotEmpty ? childName : 'Loading...',
// //                           style: GoogleFonts.poppins(
// //                               color: Colors.white,
// //                               fontSize: size.customWidth(context) * 0.048,
// //                               fontWeight: FontWeight.bold),
// //                         ),
// //                         const SizedBox(height: 2),
// //                         if (expertName.isNotEmpty)
// //                           Text(
// //                             expertName,
// //                             style: GoogleFonts.poppins(
// //                                 color: Colors.white.withOpacity(0.9),
// //                                 fontSize: size.customWidth(context) * 0.033),
// //                           ),
// //                         if (specialization.isNotEmpty)
// //                           Text(
// //                             specialization,
// //                             style: GoogleFonts.poppins(
// //                                 color: Colors.white.withOpacity(0.75),
// //                                 fontSize: size.customWidth(context) * 0.029),
// //                           ),
// //                         const SizedBox(height: 8),
// //                         // Status chip
// //                         if (status.isNotEmpty)
// //                           Container(
// //                             padding: const EdgeInsets.symmetric(
// //                                 horizontal: 12, vertical: 5),
// //                             decoration: BoxDecoration(
// //                               color: meta.color.withOpacity(0.25),
// //                               borderRadius: BorderRadius.circular(20),
// //                               border: Border.all(
// //                                   color: Colors.white.withOpacity(0.4)),
// //                             ),
// //                             child: Row(
// //                               mainAxisSize: MainAxisSize.min,
// //                               children: [
// //                                 Icon(meta.icon,
// //                                     color: Colors.white, size: 13),
// //                                 const SizedBox(width: 5),
// //                                 Text(
// //                                   meta.label,
// //                                   style: GoogleFonts.poppins(
// //                                       color: Colors.white,
// //                                       fontSize: 12,
// //                                       fontWeight: FontWeight.w600),
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                       ],
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   // ── Action buttons ─────────────────────────────────────────
// //   Widget _buildActionButtons(
// //       BuildContext context, CustomSize size, MyAppointmentItem appt) {
// //     final List<_ActionBtn> buttons = [];

// //     if (appt.isScheduled) {
// //       buttons.addAll([
// //         _ActionBtn(
// //           label: 'Confirm',
// //           icon: Icons.check_circle_outline_rounded,
// //           color: AppColors.primaryColor,
// //           onTap: () => _showConfirmDialog(context, appt.appointmentId),
// //         ),
// //         _ActionBtn(
// //           label: 'Cancel',
// //           icon: Icons.cancel_outlined,
// //           color: AppColors.errorColor,
// //           onTap: () => _showCancelDialog(context, appt.appointmentId),
// //         ),
// //         _ActionBtn(
// //           label: 'No Show',
// //           icon: Icons.person_off_outlined,
// //           color: AppColors.greyColor,
// //           onTap: () => _showNoShowDialog(context, appt.appointmentId),
// //         ),
// //       ]);
// //     } else if (appt.isConfirmed) {
// //       buttons.addAll([
// //         _ActionBtn(
// //           label: 'Complete',
// //           icon: Icons.task_alt_rounded,
// //           color: AppColors.successColor,
// //           onTap: () => _showCompleteGate(context, size, appt),
// //         ),
// //         _ActionBtn(
// //           label: 'Cancel',
// //           icon: Icons.cancel_outlined,
// //           color: AppColors.errorColor,
// //           onTap: () => _showCancelDialog(context, appt.appointmentId),
// //         ),
// //         _ActionBtn(
// //           label: 'No Show',
// //           icon: Icons.person_off_outlined,
// //           color: AppColors.greyColor,
// //           onTap: () => _showNoShowDialog(context, appt.appointmentId),
// //         ),
// //       ]);
// //     }

// //     if (buttons.isEmpty) return const SizedBox.shrink();

// //     return Row(
// //       children: buttons.map((b) {
// //         return Expanded(
// //           child: GestureDetector(
// //             onTap: b.onTap,
// //             child: Container(
// //               margin: const EdgeInsets.symmetric(horizontal: 4),
// //               padding: const EdgeInsets.symmetric(vertical: 14),
// //               decoration: BoxDecoration(
// //                 color: b.color.withOpacity(0.09),
// //                 borderRadius: BorderRadius.circular(16),
// //                 border: Border.all(color: b.color.withOpacity(0.35)),
// //               ),
// //               child: Column(
// //                 mainAxisSize: MainAxisSize.min,
// //                 children: [
// //                   Icon(b.icon, color: b.color, size: 22),
// //                   const SizedBox(height: 5),
// //                   Text(
// //                     b.label,
// //                     style: GoogleFonts.poppins(
// //                         fontSize: 11,
// //                         fontWeight: FontWeight.w600,
// //                         color: b.color),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         );
// //       }).toList(),
// //     );
// //   }

// //   // ── Info card ──────────────────────────────────────────────
// //   Widget _buildInfoCard(
// //       BuildContext context, CustomSize size, MyAppointmentItem appt) {
// //     return _card(
// //       context,
// //       size,
// //       title: 'Appointment Details',
// //       icon: Icons.event_note_rounded,
// //       iconColor: AppColors.primaryColor,
// //       children: [
// //         _row(context, size, 'Date', appt.formattedDate,
// //             Icons.calendar_today_outlined),
// //         _row(context, size, 'Time', appt.formattedTime,
// //             Icons.access_time_rounded),
// //         _row(context, size, 'Duration', '${appt.durationMinutes} minutes',
// //             Icons.timer_outlined),
// //         _row(
// //             context,
// //             size,
// //             'Mode',
// //             appt.bookedMode[0].toUpperCase() + appt.bookedMode.substring(1),
// //             _modeIcon(appt.bookedMode)),
// //         _row(
// //             context,
// //             size,
// //             'Fee',
// //             '${appt.currency} ${appt.feeCharged.toStringAsFixed(0)}',
// //             Icons.payments_outlined),
// //         if (appt.meetLink != null && appt.meetLink!.isNotEmpty)
// //           _row(context, size, 'Meet Link', appt.meetLink!, Icons.link_rounded),
// //       ],
// //     );
// //   }

// //   // ── Slot card ──────────────────────────────────────────────
// //   Widget _buildSlotCard(
// //       BuildContext context, CustomSize size, AppointmentSlot slot) {
// //     return _card(
// //       context,
// //       size,
// //       title: 'Slot Information',
// //       icon: Icons.calendar_month_rounded,
// //       iconColor: AppColors.secondaryColor,
// //       children: [
// //         _row(context, size, 'Date', slot.slotDate, Icons.today_rounded),
// //         _row(context, size, 'Time',
// //             '${slot.formattedStart} – ${slot.formattedEnd}',
// //             Icons.schedule_rounded),
// //         _row(
// //             context,
// //             size,
// //             'Mode',
// //             slot.mode.isNotEmpty
// //                 ? slot.mode[0].toUpperCase() + slot.mode.substring(1)
// //                 : slot.mode,
// //             _modeIcon(slot.mode)),
// //         if (slot.status != null)
// //           _row(context, size, 'Slot Status',
// //               slot.status![0].toUpperCase() + slot.status!.substring(1),
// //               Icons.info_outline_rounded),
// //       ],
// //     );
// //   }

// //   // ── Expert card ────────────────────────────────────────────
// //   Widget _buildExpertCard(
// //       BuildContext context, CustomSize size, AppointmentExpert expert) {
// //     return _card(
// //       context,
// //       size,
// //       title: 'Expert Information',
// //       icon: Icons.person_outline_rounded,
// //       iconColor: AppColors.accentColor,
// //       children: [
// //         _row(context, size, 'Name', expert.fullName, Icons.badge_outlined),
// //         _row(context, size, 'Specialization', expert.specialization,
// //             Icons.medical_information_outlined),
// //         if (expert.phone != null && expert.phone!.isNotEmpty)
// //           _row(context, size, 'Phone', expert.phone!, Icons.phone_outlined),
// //         if (expert.contactEmail != null && expert.contactEmail!.isNotEmpty)
// //           _row(context, size, 'Email', expert.contactEmail!,
// //               Icons.email_outlined),
// //       ],
// //     );
// //   }

// //   // ── Cancellation card ──────────────────────────────────────
// //   Widget _buildCancellationCard(
// //       BuildContext context, CustomSize size, MyAppointmentItem appt) {
// //     return Container(
// //       padding: EdgeInsets.all(size.customWidth(context) * 0.045),
// //       decoration: BoxDecoration(
// //         color: AppColors.errorColor.withOpacity(0.05),
// //         borderRadius: BorderRadius.circular(18),
// //         border: Border.all(color: AppColors.errorColor.withOpacity(0.25)),
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Row(
// //             children: [
// //               Container(
// //                 padding: const EdgeInsets.all(7),
// //                 decoration: BoxDecoration(
// //                     color: AppColors.errorColor.withOpacity(0.12),
// //                     borderRadius: BorderRadius.circular(9)),
// //                 child: const Icon(Icons.cancel_outlined,
// //                     color: AppColors.errorColor, size: 17),
// //               ),
// //               const SizedBox(width: 10),
// //               Text('Cancellation Info',
// //                   style: GoogleFonts.poppins(
// //                       fontSize: 14,
// //                       fontWeight: FontWeight.w600,
// //                       color: AppColors.errorColor)),
// //             ],
// //           ),
// //           const SizedBox(height: 14),
// //           if (appt.cancelledBy != null)
// //             _row(
// //                 context,
// //                 size,
// //                 'Cancelled By',
// //                 appt.cancelledBy![0].toUpperCase() +
// //                     appt.cancelledBy!.substring(1),
// //                 Icons.person_outlined),
// //           if (appt.cancellationReason != null)
// //             _row(context, size, 'Reason', appt.cancellationReason!,
// //                 Icons.info_outline_rounded),
// //           if (appt.cancelledAt != null)
// //             _row(context, size, 'Cancelled At',
// //                 _formatDateTime(appt.cancelledAt!), Icons.schedule_rounded),
// //         ],
// //       ),
// //     );
// //   }

// //   // ── Records section ────────────────────────────────────────
// //   Widget _buildRecordsSection(
// //       BuildContext context, CustomSize size, MyAppointmentItem appt) {
// //     if (!appt.isCompleted && !appt.isConfirmed) {
// //       return const SizedBox.shrink();
// //     }

// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //           children: [
// //             Row(
// //               children: [
// //                 Container(
// //                   width: 4,
// //                   height: 20,
// //                   decoration: BoxDecoration(
// //                       color: AppColors.primaryColor,
// //                       borderRadius: BorderRadius.circular(2)),
// //                 ),
// //                 const SizedBox(width: 10),
// //                 Text(
// //                   'Session Records',
// //                   style: GoogleFonts.poppins(
// //                       fontSize: size.customWidth(context) * 0.042,
// //                       fontWeight: FontWeight.bold,
// //                       color: AppColors.textPrimaryColor),
// //                 ),
// //               ],
// //             ),
// //             if (appt.isCompleted)
// //               GestureDetector(
// //                 onTap: () {
// //                   _c.clearRecordForm();
// //                   _openRecordSheet(context, size, appt.appointmentId);
// //                 },
// //                 child: Container(
// //                   padding:
// //                       const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
// //                   decoration: BoxDecoration(
// //                     color: AppColors.primaryColor,
// //                     borderRadius: BorderRadius.circular(10),
// //                   ),
// //                   child: Row(
// //                     mainAxisSize: MainAxisSize.min,
// //                     children: [
// //                       const Icon(Icons.add_rounded,
// //                           color: Colors.white, size: 16),
// //                       const SizedBox(width: 4),
// //                       Text('Add Note',
// //                           style: GoogleFonts.poppins(
// //                               color: Colors.white,
// //                               fontWeight: FontWeight.w600,
// //                               fontSize: 12)),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //           ],
// //         ),
// //         SizedBox(height: size.customHeight(context) * 0.015),

// //         Obx(() {
// //           if (_c.isLoadingRecords.value) {
// //             return const Center(
// //               child: Padding(
// //                 padding: EdgeInsets.all(30),
// //                 child: CircularProgressIndicator(
// //                     color: AppColors.primaryColor, strokeWidth: 2),
// //               ),
// //             );
// //           }
// //           if (_c.records.isEmpty) {
// //             return _buildEmptyRecords(context, size, appt);
// //           }
// //           return Column(
// //             children: _c.records
// //                 .map((r) => _buildRecordCard(context, size, r, appt))
// //                 .toList(),
// //           );
// //         }),
// //       ],
// //     );
// //   }

// //   Widget _buildEmptyRecords(
// //       BuildContext context, CustomSize size, MyAppointmentItem appt) {
// //     return Container(
// //       padding: const EdgeInsets.all(28),
// //       decoration: BoxDecoration(
// //         color: AppColors.whiteColor,
// //         borderRadius: BorderRadius.circular(18),
// //         boxShadow: [
// //           BoxShadow(
// //               color: Colors.black.withOpacity(0.04),
// //               blurRadius: 10,
// //               offset: const Offset(0, 3))
// //         ],
// //       ),
// //       child: Center(
// //         child: Column(
// //           children: [
// //             Icon(Icons.note_outlined,
// //                 size: 44,
// //                 color: AppColors.textSecondaryColor.withOpacity(0.35)),
// //             const SizedBox(height: 12),
// //             Text(
// //               appt.isCompleted
// //                   ? 'No session notes yet.\nTap "Add Note" to document this session.'
// //                   : 'Session notes will be available\nafter the appointment is completed.',
// //               textAlign: TextAlign.center,
// //               style: GoogleFonts.poppins(
// //                   fontSize: 13, color: AppColors.textSecondaryColor),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildRecordCard(BuildContext context, CustomSize size,
// //       AppointmentRecordItem record, MyAppointmentItem appt) {
// //     return Container(
// //       margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.014),
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
// //       child: Padding(
// //         padding: EdgeInsets.all(size.customWidth(context) * 0.042),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 Row(
// //                   children: [
// //                     Container(
// //                       padding: const EdgeInsets.all(8),
// //                       decoration: BoxDecoration(
// //                           color: AppColors.primaryColor.withOpacity(0.1),
// //                           borderRadius: BorderRadius.circular(10)),
// //                       child: const Icon(Icons.description_outlined,
// //                           color: AppColors.primaryColor, size: 18),
// //                     ),
// //                     const SizedBox(width: 10),
// //                     Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         Text('Session Note',
// //                             style: GoogleFonts.poppins(
// //                                 fontSize: 14,
// //                                 fontWeight: FontWeight.w600,
// //                                 color: AppColors.textPrimaryColor)),
// //                         Text(record.formattedDate,
// //                             style: GoogleFonts.poppins(
// //                                 fontSize: 11,
// //                                 color: AppColors.textSecondaryColor)),
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //                 if (appt.isCompleted)
// //                   GestureDetector(
// //                     onTap: () {
// //                       _c.populateRecordForm(record);
// //                       _openRecordSheet(context, size, appt.appointmentId,
// //                           editingRecord: record);
// //                     },
// //                     child: Container(
// //                       padding: const EdgeInsets.all(7),
// //                       decoration: BoxDecoration(
// //                           color: AppColors.warningColor.withOpacity(0.1),
// //                           borderRadius: BorderRadius.circular(9)),
// //                       child: const Icon(Icons.edit_outlined,
// //                           color: AppColors.warningColor, size: 16),
// //                     ),
// //                   ),
// //               ],
// //             ),
// //             SizedBox(height: size.customHeight(context) * 0.012),
// //             Divider(height: 1, color: AppColors.greyColor.withOpacity(0.15)),
// //             SizedBox(height: size.customHeight(context) * 0.012),

// //             _recordField('Notes', record.notes, Icons.notes_rounded),
// //             SizedBox(height: size.customHeight(context) * 0.01),
// //             _recordField('Therapy Plan', record.therapyPlan,
// //                 Icons.health_and_safety_outlined),
// //             SizedBox(height: size.customHeight(context) * 0.01),
// //             _recordField('Progress Feedback', record.progressFeedback,
// //                 Icons.trending_up_rounded),
// //             if (record.medication != null &&
// //                 record.medication!['name'] != null &&
// //                 record.medication!['name'].toString().toLowerCase() !=
// //                     'none') ...[
// //               SizedBox(height: size.customHeight(context) * 0.01),
// //               _recordField(
// //                   'Medication',
// //                   '${record.medication!['name']}${record.medication!['dosage'] != null ? ' — ${record.medication!['dosage']}' : ''}',
// //                   Icons.medication_outlined),
// //             ],
// //           ],
// //         ),
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
// //               const SizedBox(height: 2),
// //               Text(value,
// //                   style: GoogleFonts.poppins(
// //                       fontSize: 13, color: AppColors.textPrimaryColor)),
// //             ],
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   // ── Shared card widget ─────────────────────────────────────
// //   Widget _card(
// //     BuildContext context,
// //     CustomSize size, {
// //     required String title,
// //     required IconData icon,
// //     required Color iconColor,
// //     required List<Widget> children,
// //   }) {
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
// //           Row(
// //             children: [
// //               Container(
// //                 padding: const EdgeInsets.all(8),
// //                 decoration: BoxDecoration(
// //                     color: iconColor.withOpacity(0.1),
// //                     borderRadius: BorderRadius.circular(10)),
// //                 child: Icon(icon, color: iconColor, size: 18),
// //               ),
// //               const SizedBox(width: 10),
// //               Text(title,
// //                   style: GoogleFonts.poppins(
// //                       fontSize: 14,
// //                       fontWeight: FontWeight.w600,
// //                       color: AppColors.textPrimaryColor)),
// //             ],
// //           ),
// //           SizedBox(height: size.customHeight(context) * 0.014),
// //           Divider(height: 1, color: AppColors.greyColor.withOpacity(0.15)),
// //           SizedBox(height: size.customHeight(context) * 0.012),
// //           ...children,
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _row(BuildContext context, CustomSize size, String label, String value,
// //       IconData icon) {
// //     return Padding(
// //       padding: EdgeInsets.only(bottom: size.customHeight(context) * 0.01),
// //       child: Row(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Icon(icon, size: 14, color: AppColors.textSecondaryColor),
// //           const SizedBox(width: 10),
// //           SizedBox(
// //             width: size.customWidth(context) * 0.26,
// //             child: Text(label,
// //                 style: GoogleFonts.poppins(
// //                     fontSize: 12,
// //                     color: AppColors.textSecondaryColor,
// //                     fontWeight: FontWeight.w500)),
// //           ),
// //           Expanded(
// //             child: Text(
// //               value,
// //               style: GoogleFonts.poppins(
// //                   fontSize: 13,
// //                   color: AppColors.textPrimaryColor,
// //                   fontWeight: FontWeight.w500),
// //               maxLines: 3,
// //               overflow: TextOverflow.ellipsis,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   // ── Dialogs ────────────────────────────────────────────────

// //   void _showCompleteGate(
// //       BuildContext context, CustomSize size, MyAppointmentItem appt) {
// //     _c.clearRecordForm();
// //     showModalBottomSheet(
// //       context: context,
// //       isScrollControlled: true,
// //       backgroundColor: Colors.transparent,
// //       builder: (_) => _CompleteWithNotesSheet(
// //         controller: _c,
// //         size: size,
// //         appointmentId: appt.appointmentId,
// //         // After completing, pop the bottom sheet AND go back to list
// //         onCompleted: () {
// //           Navigator.pop(context); // close sheet
// //           Get.back();             // go back to appointments list
// //         },
// //       ),
// //     );
// //   }

// //   void _showConfirmDialog(BuildContext context, String id) {
// //     showDialog(
// //       context: context,
// //       barrierDismissible: false,
// //       builder: (_) => _ActionDialog(
// //         title: 'Confirm Appointment?',
// //         message: 'This will confirm the appointment for the patient.',
// //         confirmLabel: 'Yes, Confirm',
// //         confirmColor: AppColors.primaryColor,
// //         icon: Icons.check_circle_outline_rounded,
// //         onConfirm: () async {
// //           final ok = await _c.confirmAppointment(id);
// //           if (ok) {
// //             // Close dialog then go back to list
// //             Navigator.pop(context);
// //             Get.back();
// //           }
// //           return ok;
// //         },
// //       ),
// //     );
// //   }

// //   void _showCancelDialog(BuildContext context, String id) {
// //     showDialog(
// //       context: context,
// //       barrierDismissible: false,
// //       builder: (_) => _CancelDialog(
// //         id: id,
// //         controller: _c,
// //         onCancelled: () {
// //           Navigator.pop(context); // close dialog
// //           Get.back();             // go back to list
// //         },
// //       ),
// //     );
// //   }

// //   void _showNoShowDialog(BuildContext context, String id) {
// //     showDialog(
// //       context: context,
// //       barrierDismissible: false,
// //       builder: (_) => _ActionDialog(
// //         title: 'Mark as No Show?',
// //         message: 'Patient did not attend the session. Mark as no-show?',
// //         confirmLabel: 'Mark No Show',
// //         confirmColor: AppColors.greyColor,
// //         icon: Icons.person_off_outlined,
// //         onConfirm: () async {
// //           final ok = await _c.markNoShow(id);
// //           if (ok) {
// //             Navigator.pop(context);
// //             Get.back();
// //           }
// //           return ok;
// //         },
// //       ),
// //     );
// //   }

// //   void _openRecordSheet(BuildContext context, CustomSize size,
// //       String appointmentId,
// //       {AppointmentRecordItem? editingRecord}) {
// //     showModalBottomSheet(
// //       context: context,
// //       isScrollControlled: true,
// //       backgroundColor: Colors.transparent,
// //       builder: (_) => ConstrainedBox(
// //         constraints:
// //             BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.93),
// //         child: _RecordFormSheet(
// //           controller: _c,
// //           size: size,
// //           appointmentId: appointmentId,
// //           editingRecord: editingRecord,
// //           onSaved: () {},
// //         ),
// //       ),
// //     );
// //   }

// //   // ── Helpers ────────────────────────────────────────────────
// //   Widget _buildError() {
// //     return Scaffold(
// //       appBar: AppBar(
// //           backgroundColor: AppColors.whiteColor,
// //           elevation: 0,
// //           surfaceTintColor: Colors.transparent,
// //           leading: IconButton(
// //             icon: const Icon(Icons.arrow_back_ios_new_rounded,
// //                 color: AppColors.textPrimaryColor),
// //             onPressed: () => Get.back(),
// //           )),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             const Icon(Icons.error_outline_rounded,
// //                 size: 60, color: AppColors.errorColor),
// //             const SizedBox(height: 16),
// //             Text('Appointment not found',
// //                 style: GoogleFonts.poppins(
// //                     fontSize: 16, color: AppColors.textPrimaryColor)),
// //             const SizedBox(height: 8),
// //             TextButton(
// //               onPressed: () => Get.back(),
// //               child: Text('Go Back',
// //                   style: GoogleFonts.poppins(color: AppColors.primaryColor)),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   String _formatDateTime(String raw) {
// //     try {
// //       final dt = DateTime.parse(raw).toLocal();
// //       const months = [
// //         '',
// //         'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
// //         'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
// //       ];
// //       int h = dt.hour;
// //       final m = dt.minute.toString().padLeft(2, '0');
// //       final ampm = h >= 12 ? 'PM' : 'AM';
// //       if (h > 12) h -= 12;
// //       if (h == 0) h = 12;
// //       return '${dt.day} ${months[dt.month]} ${dt.year}, $h:$m $ampm';
// //     } catch (_) {
// //       return raw;
// //     }
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

// // // ── Data classes ───────────────────────────────────────────────
// // class _StatusMeta {
// //   final Color color;
// //   final String label;
// //   final IconData icon;
// //   _StatusMeta(this.color, this.label, this.icon);
// // }

// // class _ActionBtn {
// //   final String label;
// //   final IconData icon;
// //   final Color color;
// //   final VoidCallback onTap;
// //   _ActionBtn(
// //       {required this.label,
// //       required this.icon,
// //       required this.color,
// //       required this.onTap});
// // }

// // // ══════════════════════════════════════════════════════════════
// // // Generic action confirm dialog
// // // ══════════════════════════════════════════════════════════════
// // class _ActionDialog extends StatefulWidget {
// //   final String title;
// //   final String message;
// //   final String confirmLabel;
// //   final Color confirmColor;
// //   final IconData icon;
// //   // Returns true = success; navigation is handled inside onConfirm by caller
// //   final Future<bool> Function() onConfirm;

// //   const _ActionDialog({
// //     required this.title,
// //     required this.message,
// //     required this.confirmLabel,
// //     required this.confirmColor,
// //     required this.icon,
// //     required this.onConfirm,
// //   });

// //   @override
// //   State<_ActionDialog> createState() => _ActionDialogState();
// // }

// // class _ActionDialogState extends State<_ActionDialog> {
// //   bool _loading = false;

// //   @override
// //   Widget build(BuildContext context) {
// //     return AlertDialog(
// //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
// //       contentPadding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
// //       content: Column(
// //         mainAxisSize: MainAxisSize.min,
// //         children: [
// //           Container(
// //             padding: const EdgeInsets.all(16),
// //             decoration: BoxDecoration(
// //                 color: widget.confirmColor.withOpacity(0.1),
// //                 shape: BoxShape.circle),
// //             child: Icon(widget.icon, color: widget.confirmColor, size: 34),
// //           ),
// //           const SizedBox(height: 16),
// //           Text(widget.title,
// //               style: GoogleFonts.poppins(
// //                   fontSize: 17,
// //                   fontWeight: FontWeight.bold,
// //                   color: AppColors.textPrimaryColor),
// //               textAlign: TextAlign.center),
// //           const SizedBox(height: 8),
// //           Text(widget.message,
// //               style: GoogleFonts.poppins(
// //                   fontSize: 13, color: AppColors.textSecondaryColor),
// //               textAlign: TextAlign.center),
// //           const SizedBox(height: 24),
// //           Row(
// //             children: [
// //               Expanded(
// //                 child: OutlinedButton(
// //                   onPressed:
// //                       _loading ? null : () => Navigator.pop(context),
// //                   style: OutlinedButton.styleFrom(
// //                     foregroundColor: AppColors.textSecondaryColor,
// //                     side: BorderSide(
// //                         color: AppColors.greyColor.withOpacity(0.5)),
// //                     shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(12)),
// //                     padding: const EdgeInsets.symmetric(vertical: 13),
// //                   ),
// //                   child: Text('Cancel',
// //                       style: GoogleFonts.poppins(
// //                           fontWeight: FontWeight.w500, fontSize: 13)),
// //                 ),
// //               ),
// //               const SizedBox(width: 12),
// //               Expanded(
// //                 child: ElevatedButton(
// //                   onPressed: _loading
// //                       ? null
// //                       : () async {
// //                           setState(() => _loading = true);
// //                           // onConfirm handles navigation on success
// //                           await widget.onConfirm();
// //                           if (mounted) setState(() => _loading = false);
// //                         },
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: widget.confirmColor,
// //                     foregroundColor: Colors.white,
// //                     disabledBackgroundColor:
// //                         widget.confirmColor.withOpacity(0.5),
// //                     shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(12)),
// //                     padding: const EdgeInsets.symmetric(vertical: 13),
// //                     elevation: 0,
// //                   ),
// //                   child: _loading
// //                       ? const SizedBox(
// //                           width: 18,
// //                           height: 18,
// //                           child: CircularProgressIndicator(
// //                               color: Colors.white, strokeWidth: 2))
// //                       : Text(widget.confirmLabel,
// //                           style: GoogleFonts.poppins(
// //                               fontWeight: FontWeight.w600, fontSize: 13)),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // // ══════════════════════════════════════════════════════════════
// // // Cancel dialog with reason input + onCancelled callback
// // // ══════════════════════════════════════════════════════════════
// // class _CancelDialog extends StatefulWidget {
// //   final String id;
// //   final MyAppointmentController controller;
// //   final VoidCallback? onCancelled;

// //   const _CancelDialog({
// //     required this.id,
// //     required this.controller,
// //     this.onCancelled,
// //   });

// //   @override
// //   State<_CancelDialog> createState() => _CancelDialogState();
// // }

// // class _CancelDialogState extends State<_CancelDialog> {
// //   final _reasonCtrl = TextEditingController();
// //   bool _loading = false;

// //   @override
// //   void dispose() {
// //     _reasonCtrl.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return AlertDialog(
// //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
// //       contentPadding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
// //       content: Column(
// //         mainAxisSize: MainAxisSize.min,
// //         children: [
// //           Container(
// //             padding: const EdgeInsets.all(16),
// //             decoration: BoxDecoration(
// //                 color: AppColors.errorColor.withOpacity(0.1),
// //                 shape: BoxShape.circle),
// //             child: const Icon(Icons.cancel_outlined,
// //                 color: AppColors.errorColor, size: 34),
// //           ),
// //           const SizedBox(height: 16),
// //           Text('Cancel Appointment',
// //               style: GoogleFonts.poppins(
// //                   fontSize: 17,
// //                   fontWeight: FontWeight.bold,
// //                   color: AppColors.textPrimaryColor),
// //               textAlign: TextAlign.center),
// //           const SizedBox(height: 6),
// //           Text('Please provide a cancellation reason.',
// //               style: GoogleFonts.poppins(
// //                   fontSize: 13, color: AppColors.textSecondaryColor),
// //               textAlign: TextAlign.center),
// //           const SizedBox(height: 18),
// //           TextField(
// //             controller: _reasonCtrl,
// //             maxLines: 3,
// //             style: GoogleFonts.poppins(
// //                 fontSize: 13, color: AppColors.textPrimaryColor),
// //             decoration: InputDecoration(
// //               hintText: 'Enter reason here...',
// //               hintStyle: GoogleFonts.poppins(
// //                   fontSize: 13,
// //                   color: AppColors.textSecondaryColor.withOpacity(0.6)),
// //               filled: true,
// //               fillColor: AppColors.lightGreyColor,
// //               contentPadding: const EdgeInsets.all(14),
// //               border: OutlineInputBorder(
// //                   borderRadius: BorderRadius.circular(12),
// //                   borderSide: BorderSide.none),
// //               enabledBorder: OutlineInputBorder(
// //                   borderRadius: BorderRadius.circular(12),
// //                   borderSide: BorderSide(
// //                       color: AppColors.greyColor.withOpacity(0.25))),
// //               focusedBorder: OutlineInputBorder(
// //                   borderRadius: BorderRadius.circular(12),
// //                   borderSide: const BorderSide(
// //                       color: AppColors.primaryColor, width: 1.5)),
// //             ),
// //           ),
// //           const SizedBox(height: 20),
// //           Row(
// //             children: [
// //               Expanded(
// //                 child: OutlinedButton(
// //                   onPressed:
// //                       _loading ? null : () => Navigator.pop(context),
// //                   style: OutlinedButton.styleFrom(
// //                     foregroundColor: AppColors.textSecondaryColor,
// //                     side: BorderSide(
// //                         color: AppColors.greyColor.withOpacity(0.5)),
// //                     shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(12)),
// //                     padding: const EdgeInsets.symmetric(vertical: 13),
// //                   ),
// //                   child: Text('Back',
// //                       style: GoogleFonts.poppins(
// //                           fontWeight: FontWeight.w500, fontSize: 13)),
// //                 ),
// //               ),
// //               const SizedBox(width: 12),
// //               Expanded(
// //                 child: ElevatedButton(
// //                   onPressed: _loading
// //                       ? null
// //                       : () async {
// //                           final reason = _reasonCtrl.text.trim();
// //                           if (reason.isEmpty) {
// //                             Get.snackbar(
// //                               'Required',
// //                               'Please enter a cancellation reason',
// //                               snackPosition: SnackPosition.BOTTOM,
// //                               backgroundColor: AppColors.warningColor,
// //                               colorText: Colors.white,
// //                               margin: const EdgeInsets.all(16),
// //                               borderRadius: 12,
// //                             );
// //                             return;
// //                           }
// //                           setState(() => _loading = true);
// //                           final ok = await widget.controller
// //                               .cancelAppointment(widget.id, reason);
// //                           if (mounted) setState(() => _loading = false);
// //                           if (ok) {
// //                             // onCancelled handles both pop + Get.back()
// //                             widget.onCancelled?.call();
// //                           }
// //                         },
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: AppColors.errorColor,
// //                     foregroundColor: Colors.white,
// //                     disabledBackgroundColor:
// //                         AppColors.errorColor.withOpacity(0.5),
// //                     shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(12)),
// //                     padding: const EdgeInsets.symmetric(vertical: 13),
// //                     elevation: 0,
// //                   ),
// //                   child: _loading
// //                       ? const SizedBox(
// //                           width: 18,
// //                           height: 18,
// //                           child: CircularProgressIndicator(
// //                               color: Colors.white, strokeWidth: 2))
// //                       : Text('Cancel Appt.',
// //                           style: GoogleFonts.poppins(
// //                               fontWeight: FontWeight.w600, fontSize: 13)),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // // ══════════════════════════════════════════════════════════════
// // // Complete-with-Notes gate sheet
// // // ══════════════════════════════════════════════════════════════
// // class _CompleteWithNotesSheet extends StatefulWidget {
// //   final MyAppointmentController controller;
// //   final CustomSize size;
// //   final String appointmentId;
// //   final VoidCallback? onCompleted;

// //   const _CompleteWithNotesSheet({
// //     required this.controller,
// //     required this.size,
// //     required this.appointmentId,
// //     this.onCompleted,
// //   });

// //   @override
// //   State<_CompleteWithNotesSheet> createState() =>
// //       _CompleteWithNotesSheetState();
// // }

// // class _CompleteWithNotesSheetState extends State<_CompleteWithNotesSheet> {
// //   final _formKey = GlobalKey<FormState>();
// //   bool _saving = false;

// //   @override
// //   Widget build(BuildContext context) {
// //     final size = widget.size;

// //     return Container(
// //       decoration: const BoxDecoration(
// //         color: AppColors.whiteColor,
// //         borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
// //       ),
// //       padding:
// //           EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
// //       child: SingleChildScrollView(
// //         physics: const ClampingScrollPhysics(),
// //         padding: EdgeInsets.fromLTRB(
// //           size.customWidth(context) * 0.05,
// //           20,
// //           size.customWidth(context) * 0.05,
// //           size.customHeight(context) * 0.04,
// //         ),
// //         child: Form(
// //           key: _formKey,
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               Center(
// //                 child: Container(
// //                   width: 44,
// //                   height: 4,
// //                   decoration: BoxDecoration(
// //                       color: AppColors.greyColor.withOpacity(0.3),
// //                       borderRadius: BorderRadius.circular(2)),
// //                 ),
// //               ),
// //               const SizedBox(height: 20),

// //               Row(
// //                 children: [
// //                   Container(
// //                     padding: const EdgeInsets.all(10),
// //                     decoration: BoxDecoration(
// //                         color: AppColors.successColor.withOpacity(0.1),
// //                         borderRadius: BorderRadius.circular(12)),
// //                     child: const Icon(Icons.task_alt_rounded,
// //                         color: AppColors.successColor, size: 22),
// //                   ),
// //                   const SizedBox(width: 12),
// //                   Expanded(
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         Text(
// //                           'Complete Appointment',
// //                           style: GoogleFonts.poppins(
// //                               fontSize: size.customWidth(context) * 0.042,
// //                               fontWeight: FontWeight.bold,
// //                               color: AppColors.textPrimaryColor),
// //                         ),
// //                         Text(
// //                           'Add session notes to complete',
// //                           style: GoogleFonts.poppins(
// //                               fontSize: size.customWidth(context) * 0.031,
// //                               color: AppColors.textSecondaryColor),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //               const SizedBox(height: 6),
// //               Container(
// //                 margin: const EdgeInsets.symmetric(vertical: 12),
// //                 padding:
// //                     const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
// //                 decoration: BoxDecoration(
// //                   color: AppColors.warningColor.withOpacity(0.08),
// //                   borderRadius: BorderRadius.circular(10),
// //                   border: Border.all(
// //                       color: AppColors.warningColor.withOpacity(0.3)),
// //                 ),
// //                 child: Row(
// //                   children: [
// //                     const Icon(Icons.info_outline_rounded,
// //                         color: AppColors.warningColor, size: 16),
// //                     const SizedBox(width: 8),
// //                     Expanded(
// //                       child: Text(
// //                         'Session notes are required before marking as completed.',
// //                         style: GoogleFonts.poppins(
// //                             fontSize: 12, color: AppColors.warningColor),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               SizedBox(height: size.customHeight(context) * 0.01),

// //               _field(context, size, 'Session Notes *',
// //                   'What happened during the session?',
// //                   Icons.notes_rounded, widget.controller.notesCtrl,
// //                   maxLines: 3, required: true),
// //               SizedBox(height: size.customHeight(context) * 0.016),

// //               _field(context, size, 'Therapy Plan *',
// //                   'Plan for upcoming sessions...',
// //                   Icons.health_and_safety_outlined,
// //                   widget.controller.therapyPlanCtrl,
// //                   maxLines: 3, required: true),
// //               SizedBox(height: size.customHeight(context) * 0.016),

// //               _field(context, size, 'Progress Feedback *',
// //                   'How did the patient progress?',
// //                   Icons.trending_up_rounded,
// //                   widget.controller.progressFeedbackCtrl,
// //                   maxLines: 2, required: true),
// //               SizedBox(height: size.customHeight(context) * 0.016),

// //               Text('Medication (optional)',
// //                   style: GoogleFonts.poppins(
// //                       fontSize: size.customWidth(context) * 0.034,
// //                       fontWeight: FontWeight.w600,
// //                       color: AppColors.textPrimaryColor)),
// //               const SizedBox(height: 8),
// //               Row(
// //                 children: [
// //                   Expanded(
// //                     child: _field(context, size, 'Name', 'e.g. None',
// //                         Icons.medication_outlined,
// //                         widget.controller.medicationNameCtrl,
// //                         maxLines: 1, required: false),
// //                   ),
// //                   SizedBox(width: size.customWidth(context) * 0.03),
// //                   Expanded(
// //                     child: _field(context, size, 'Dosage', 'e.g. 5mg',
// //                         Icons.science_outlined,
// //                         widget.controller.medicationDosageCtrl,
// //                         maxLines: 1, required: false),
// //                   ),
// //                 ],
// //               ),
// //               SizedBox(height: size.customHeight(context) * 0.028),

// //               SizedBox(
// //                 width: double.infinity,
// //                 child: ElevatedButton.icon(
// //                   onPressed: _saving
// //                       ? null
// //                       : () async {
// //                           if (!_formKey.currentState!.validate()) return;
// //                           setState(() => _saving = true);

// //                           // Step 1: create the record
// //                           final recordOk = await widget.controller
// //                               .createRecord(widget.appointmentId);

// //                           if (!recordOk) {
// //                             if (mounted) setState(() => _saving = false);
// //                             return;
// //                           }

// //                           // Step 2: complete the appointment
// //                           final completeOk = await widget.controller
// //                               .completeAppointment(widget.appointmentId);

// //                           if (mounted) setState(() => _saving = false);
// //                           if (completeOk) {
// //                             // Caller handles: pop sheet + Get.back() to list
// //                             widget.onCompleted?.call();
// //                           }
// //                         },
// //                   icon: _saving
// //                       ? const SizedBox(
// //                           width: 18,
// //                           height: 18,
// //                           child: CircularProgressIndicator(
// //                               color: Colors.white, strokeWidth: 2))
// //                       : const Icon(Icons.task_alt_rounded, size: 20),
// //                   label: Text(
// //                     _saving ? 'Saving...' : 'Save Notes & Complete',
// //                     style: GoogleFonts.poppins(
// //                         fontWeight: FontWeight.w600,
// //                         fontSize: size.customWidth(context) * 0.038),
// //                   ),
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: AppColors.successColor,
// //                     foregroundColor: Colors.white,
// //                     disabledBackgroundColor:
// //                         AppColors.successColor.withOpacity(0.4),
// //                     padding: EdgeInsets.symmetric(
// //                         vertical: size.customHeight(context) * 0.02),
// //                     shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(16)),
// //                     elevation: 2,
// //                   ),
// //                 ),
// //               ),
// //               SizedBox(height: size.customHeight(context) * 0.008),
// //               SizedBox(
// //                 width: double.infinity,
// //                 child: TextButton(
// //                   onPressed:
// //                       _saving ? null : () => Navigator.pop(context),
// //                   child: Text('Cancel',
// //                       style: GoogleFonts.poppins(
// //                           color: AppColors.textSecondaryColor,
// //                           fontWeight: FontWeight.w500)),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _field(
// //     BuildContext context,
// //     CustomSize size,
// //     String label,
// //     String hint,
// //     IconData icon,
// //     TextEditingController ctrl, {
// //     int maxLines = 1,
// //     bool required = true,
// //   }) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Text(label,
// //             style: GoogleFonts.poppins(
// //                 fontSize: size.customWidth(context) * 0.033,
// //                 fontWeight: FontWeight.w600,
// //                 color: AppColors.textPrimaryColor)),
// //         const SizedBox(height: 6),
// //         TextFormField(
// //           controller: ctrl,
// //           maxLines: maxLines,
// //           validator: required
// //               ? (v) => (v == null || v.trim().isEmpty)
// //                   ? '$label is required'
// //                   : null
// //               : null,
// //           style: GoogleFonts.poppins(
// //               fontSize: 13, color: AppColors.textPrimaryColor),
// //           decoration: InputDecoration(
// //             hintText: hint,
// //             hintStyle: GoogleFonts.poppins(
// //                 fontSize: 13,
// //                 color: AppColors.textSecondaryColor.withOpacity(0.6)),
// //             prefixIcon: maxLines == 1
// //                 ? Icon(icon, color: AppColors.primaryColor, size: 19)
// //                 : null,
// //             filled: true,
// //             fillColor: AppColors.lightGreyColor,
// //             contentPadding: EdgeInsets.symmetric(
// //                 horizontal: 16, vertical: maxLines > 1 ? 14 : 0),
// //             border: OutlineInputBorder(
// //                 borderRadius: BorderRadius.circular(14),
// //                 borderSide: BorderSide.none),
// //             enabledBorder: OutlineInputBorder(
// //                 borderRadius: BorderRadius.circular(14),
// //                 borderSide:
// //                     BorderSide(color: AppColors.greyColor.withOpacity(0.2))),
// //             focusedBorder: OutlineInputBorder(
// //                 borderRadius: BorderRadius.circular(14),
// //                 borderSide: const BorderSide(
// //                     color: AppColors.primaryColor, width: 1.5)),
// //             errorBorder: OutlineInputBorder(
// //                 borderRadius: BorderRadius.circular(14),
// //                 borderSide: const BorderSide(
// //                     color: AppColors.errorColor, width: 1)),
// //             focusedErrorBorder: OutlineInputBorder(
// //                 borderRadius: BorderRadius.circular(14),
// //                 borderSide: const BorderSide(
// //                     color: AppColors.errorColor, width: 1.5)),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }

// // // ══════════════════════════════════════════════════════════════
// // // Record form sheet (Add / Edit for completed appointments)
// // // ══════════════════════════════════════════════════════════════
// // class _RecordFormSheet extends StatefulWidget {
// //   final MyAppointmentController controller;
// //   final CustomSize size;
// //   final String appointmentId;
// //   final AppointmentRecordItem? editingRecord;
// //   final VoidCallback? onSaved;

// //   const _RecordFormSheet({
// //     required this.controller,
// //     required this.size,
// //     required this.appointmentId,
// //     this.editingRecord,
// //     this.onSaved,
// //   });

// //   @override
// //   State<_RecordFormSheet> createState() => _RecordFormSheetState();
// // }

// // class _RecordFormSheetState extends State<_RecordFormSheet> {
// //   final _formKey = GlobalKey<FormState>();
// //   bool _saving = false;

// //   bool get _isEdit => widget.editingRecord != null;

// //   @override
// //   Widget build(BuildContext context) {
// //     final size = widget.size;

// //     return Container(
// //       decoration: const BoxDecoration(
// //         color: AppColors.whiteColor,
// //         borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
// //       ),
// //       padding:
// //           EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
// //       child: SingleChildScrollView(
// //         physics: const ClampingScrollPhysics(),
// //         padding: EdgeInsets.fromLTRB(
// //           size.customWidth(context) * 0.05,
// //           20,
// //           size.customWidth(context) * 0.05,
// //           size.customHeight(context) * 0.04,
// //         ),
// //         child: Form(
// //           key: _formKey,
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               Center(
// //                 child: Container(
// //                   width: 44,
// //                   height: 4,
// //                   decoration: BoxDecoration(
// //                       color: AppColors.greyColor.withOpacity(0.3),
// //                       borderRadius: BorderRadius.circular(2)),
// //                 ),
// //               ),
// //               const SizedBox(height: 20),

// //               Row(
// //                 children: [
// //                   Container(
// //                     padding: const EdgeInsets.all(10),
// //                     decoration: BoxDecoration(
// //                         color: AppColors.primaryColor.withOpacity(0.1),
// //                         borderRadius: BorderRadius.circular(12)),
// //                     child: Icon(
// //                       _isEdit
// //                           ? Icons.edit_note_rounded
// //                           : Icons.note_add_rounded,
// //                       color: AppColors.primaryColor,
// //                       size: 22,
// //                     ),
// //                   ),
// //                   const SizedBox(width: 12),
// //                   Expanded(
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         Text(
// //                           _isEdit
// //                               ? 'Update Session Record'
// //                               : 'New Session Record',
// //                           style: GoogleFonts.poppins(
// //                               fontSize: size.customWidth(context) * 0.042,
// //                               fontWeight: FontWeight.bold,
// //                               color: AppColors.textPrimaryColor),
// //                         ),
// //                         Text(
// //                           _isEdit
// //                               ? 'Edit session details'
// //                               : 'Document this session',
// //                           style: GoogleFonts.poppins(
// //                               fontSize: size.customWidth(context) * 0.031,
// //                               color: AppColors.textSecondaryColor),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //               SizedBox(height: size.customHeight(context) * 0.022),

// //               _field(context, size, 'Session Notes *',
// //                   'Describe what happened during the session...',
// //                   Icons.notes_rounded, widget.controller.notesCtrl,
// //                   maxLines: 3, required: true),
// //               SizedBox(height: size.customHeight(context) * 0.016),

// //               _field(context, size, 'Therapy Plan *',
// //                   'Outline the plan for next sessions...',
// //                   Icons.health_and_safety_outlined,
// //                   widget.controller.therapyPlanCtrl,
// //                   maxLines: 3, required: true),
// //               SizedBox(height: size.customHeight(context) * 0.016),

// //               _field(context, size, 'Progress Feedback *',
// //                   'How did the patient progress?',
// //                   Icons.trending_up_rounded,
// //                   widget.controller.progressFeedbackCtrl,
// //                   maxLines: 2, required: true),
// //               SizedBox(height: size.customHeight(context) * 0.016),

// //               Text('Medication (optional)',
// //                   style: GoogleFonts.poppins(
// //                       fontSize: size.customWidth(context) * 0.034,
// //                       fontWeight: FontWeight.w600,
// //                       color: AppColors.textPrimaryColor)),
// //               const SizedBox(height: 8),
// //               Row(
// //                 children: [
// //                   Expanded(
// //                     child: _field(context, size, 'Name', 'e.g. None',
// //                         Icons.medication_outlined,
// //                         widget.controller.medicationNameCtrl,
// //                         maxLines: 1, required: false),
// //                   ),
// //                   SizedBox(width: size.customWidth(context) * 0.03),
// //                   Expanded(
// //                     child: _field(context, size, 'Dosage', 'e.g. 5mg',
// //                         Icons.science_outlined,
// //                         widget.controller.medicationDosageCtrl,
// //                         maxLines: 1, required: false),
// //                   ),
// //                 ],
// //               ),
// //               SizedBox(height: size.customHeight(context) * 0.028),

// //               SizedBox(
// //                 width: double.infinity,
// //                 child: ElevatedButton(
// //                   onPressed: _saving
// //                       ? null
// //                       : () async {
// //                           if (!_formKey.currentState!.validate()) return;
// //                           setState(() => _saving = true);
// //                           bool ok;
// //                           if (_isEdit) {
// //                             ok = await widget.controller.updateRecord(
// //                               widget.appointmentId,
// //                               widget.editingRecord!.recordId,
// //                             );
// //                           } else {
// //                             ok = await widget.controller
// //                                 .createRecord(widget.appointmentId);
// //                           }
// //                           if (mounted) setState(() => _saving = false);
// //                           if (ok && context.mounted) {
// //                             widget.onSaved?.call();
// //                             Navigator.pop(context);
// //                           }
// //                         },
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: AppColors.primaryColor,
// //                     foregroundColor: Colors.white,
// //                     disabledBackgroundColor:
// //                         AppColors.primaryColor.withOpacity(0.4),
// //                     padding: EdgeInsets.symmetric(
// //                         vertical: size.customHeight(context) * 0.02),
// //                     shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(16)),
// //                     elevation: 2,
// //                   ),
// //                   child: _saving
// //                       ? const SizedBox(
// //                           width: 22,
// //                           height: 22,
// //                           child: CircularProgressIndicator(
// //                               color: Colors.white, strokeWidth: 2.5))
// //                       : Text(
// //                           _isEdit ? 'Update Record' : 'Save Record',
// //                           style: GoogleFonts.poppins(
// //                               fontWeight: FontWeight.w600,
// //                               fontSize: size.customWidth(context) * 0.038),
// //                         ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _field(
// //     BuildContext context,
// //     CustomSize size,
// //     String label,
// //     String hint,
// //     IconData icon,
// //     TextEditingController ctrl, {
// //     int maxLines = 1,
// //     bool required = true,
// //   }) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Text(label,
// //             style: GoogleFonts.poppins(
// //                 fontSize: size.customWidth(context) * 0.033,
// //                 fontWeight: FontWeight.w600,
// //                 color: AppColors.textPrimaryColor)),
// //         const SizedBox(height: 6),
// //         TextFormField(
// //           controller: ctrl,
// //           maxLines: maxLines,
// //           validator: required
// //               ? (v) => (v == null || v.trim().isEmpty)
// //                   ? '$label is required'
// //                   : null
// //               : null,
// //           style: GoogleFonts.poppins(
// //               fontSize: 13, color: AppColors.textPrimaryColor),
// //           decoration: InputDecoration(
// //             hintText: hint,
// //             hintStyle: GoogleFonts.poppins(
// //                 fontSize: 13,
// //                 color: AppColors.textSecondaryColor.withOpacity(0.6)),
// //             prefixIcon: maxLines == 1
// //                 ? Icon(icon, color: AppColors.primaryColor, size: 19)
// //                 : null,
// //             filled: true,
// //             fillColor: AppColors.lightGreyColor,
// //             contentPadding: EdgeInsets.symmetric(
// //                 horizontal: 16, vertical: maxLines > 1 ? 14 : 0),
// //             border: OutlineInputBorder(
// //                 borderRadius: BorderRadius.circular(14),
// //                 borderSide: BorderSide.none),
// //             enabledBorder: OutlineInputBorder(
// //                 borderRadius: BorderRadius.circular(14),
// //                 borderSide:
// //                     BorderSide(color: AppColors.greyColor.withOpacity(0.2))),
// //             focusedBorder: OutlineInputBorder(
// //                 borderRadius: BorderRadius.circular(14),
// //                 borderSide: const BorderSide(
// //                     color: AppColors.primaryColor, width: 1.5)),
// //             errorBorder: OutlineInputBorder(
// //                 borderRadius: BorderRadius.circular(14),
// //                 borderSide: const BorderSide(
// //                     color: AppColors.errorColor, width: 1)),
// //             focusedErrorBorder: OutlineInputBorder(
// //                 borderRadius: BorderRadius.circular(14),
// //                 borderSide: const BorderSide(
// //                     color: AppColors.errorColor, width: 1.5)),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }



// // lib/view/expert/appointments/appointment_detail_screen.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/my_appointment_controller.dart';
// import 'package:speechspectrum/models/my_appointment_model.dart';

// class AppointmentDetailScreen extends StatefulWidget {
//   const AppointmentDetailScreen({super.key});

//   @override
//   State<AppointmentDetailScreen> createState() =>
//       _AppointmentDetailScreenState();
// }

// class _AppointmentDetailScreenState extends State<AppointmentDetailScreen> {
//   late final MyAppointmentController _c;
//   late final String _appointmentId;

//   late final String _argChildName;
//   late final String _argExpertName;
//   late final String _argSpecialization;
//   late final String _argChildInitials;
//   late final String _argStatus;

//   @override
//   void initState() {
//     super.initState();
//     _c = Get.find<MyAppointmentController>();

//     final args = Get.arguments;
//     if (args is Map) {
//       _appointmentId = (args['appointmentId'] ?? '').toString();
//       _argChildName = (args['childName'] ?? '').toString();
//       _argExpertName = (args['expertName'] ?? '').toString();
//       _argSpecialization = (args['specialization'] ?? '').toString();
//       _argChildInitials = (args['childInitials'] ?? '').toString();
//       _argStatus = (args['status'] ?? '').toString();
//     } else {
//       _appointmentId = args?.toString() ?? '';
//       _argChildName = '';
//       _argExpertName = '';
//       _argSpecialization = '';
//       _argChildInitials = '';
//       _argStatus = '';
//     }

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (_appointmentId.isNotEmpty) {
//         _c.fetchAppointmentDetail(_appointmentId);
//         _c.fetchRecords(_appointmentId);
//       }
//     });
//   }

//   String get _displayChildName {
//     final fromApi = _c.selectedAppointment.value?.children?.childName ?? '';
//     return fromApi.isNotEmpty ? fromApi : _argChildName;
//   }

//   String get _displayExpertName {
//     final fromApi = _c.selectedAppointment.value?.expertUsers?.fullName ?? '';
//     return fromApi.isNotEmpty ? fromApi : _argExpertName;
//   }

//   String get _displaySpecialization {
//     final fromApi =
//         _c.selectedAppointment.value?.expertUsers?.specialization ?? '';
//     return fromApi.isNotEmpty ? fromApi : _argSpecialization;
//   }

//   String get _displayInitials {
//     final fromApi = _c.selectedAppointment.value?.childInitials ?? '';
//     return fromApi.isNotEmpty ? fromApi : _argChildInitials;
//   }

//   String get _displayStatus {
//     final fromApi = _c.selectedAppointment.value?.status ?? '';
//     return fromApi.isNotEmpty ? fromApi : _argStatus;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();
//     return Scaffold(
//       backgroundColor: AppColors.lightGreyColor,
//       body: Obx(() {
//         if (_c.isLoadingDetail.value &&
//             _c.selectedAppointment.value == null) {
//           return _buildLoadingWithHeader(context, size);
//         }
//         final appt = _c.selectedAppointment.value;
//         if (appt == null) return _buildError();
//         return _buildBody(context, size, appt);
//       }),
//     );
//   }

//   Widget _buildLoadingWithHeader(BuildContext context, CustomSize size) {
//     final meta = _statusMeta(_argStatus);
//     return CustomScrollView(
//       slivers: [
//         SliverAppBar(
//           expandedHeight: size.customHeight(context) * 0.26,
//           pinned: true,
//           backgroundColor: AppColors.primaryColor,
//           surfaceTintColor: Colors.transparent,
//           leading: GestureDetector(
//             onTap: () => Get.back(),
//             child: Container(
//               margin: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.2),
//                   borderRadius: BorderRadius.circular(12)),
//               child: const Icon(Icons.arrow_back_ios_new_rounded,
//                   color: Colors.white, size: 18),
//             ),
//           ),
//           flexibleSpace: FlexibleSpaceBar(
//             background: _buildHeaderBackground(
//               context,
//               size,
//               initials: _argChildInitials,
//               childName: _argChildName,
//               expertName: _argExpertName,
//               specialization: _argSpecialization,
//               status: _argStatus,
//               meta: meta,
//             ),
//           ),
//         ),
//         const SliverFillRemaining(
//           child: Center(
//             child: CircularProgressIndicator(
//                 color: AppColors.primaryColor, strokeWidth: 3),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildBody(
//       BuildContext context, CustomSize size, MyAppointmentItem appt) {
//     final meta = _statusMeta(appt.status);

//     return CustomScrollView(
//       slivers: [
//         SliverAppBar(
//           expandedHeight: size.customHeight(context) * 0.26,
//           pinned: true,
//           backgroundColor: AppColors.primaryColor,
//           surfaceTintColor: Colors.transparent,
//           leading: GestureDetector(
//             onTap: () => Get.back(),
//             child: Container(
//               margin: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.2),
//                   borderRadius: BorderRadius.circular(12)),
//               child: const Icon(Icons.arrow_back_ios_new_rounded,
//                   color: Colors.white, size: 18),
//             ),
//           ),
//           flexibleSpace: FlexibleSpaceBar(
//             background: _buildHeaderBackground(
//               context,
//               size,
//               initials: appt.childInitials,
//               childName: appt.children?.childName ?? _argChildName,
//               expertName: appt.expertUsers?.fullName ?? _argExpertName,
//               specialization:
//                   appt.expertUsers?.specialization ?? _argSpecialization,
//               status: appt.status,
//               meta: meta,
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
//               _buildActionButtons(context, size, appt),
//               SizedBox(height: size.customHeight(context) * 0.022),

//               _buildInfoCard(context, size, appt),
//               SizedBox(height: size.customHeight(context) * 0.018),

//               if (appt.appointmentSlots != null) ...[
//                 _buildSlotCard(context, size, appt.appointmentSlots!),
//                 SizedBox(height: size.customHeight(context) * 0.018),
//               ],

//               if (appt.expertUsers != null) ...[
//                 _buildExpertCard(context, size, appt.expertUsers!),
//                 SizedBox(height: size.customHeight(context) * 0.018),
//               ],

//               if (appt.isCancelled) ...[
//                 _buildCancellationCard(context, size, appt),
//                 SizedBox(height: size.customHeight(context) * 0.018),
//               ],

//               _buildRecordsSection(context, size, appt),
//             ]),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildHeaderBackground(
//     BuildContext context,
//     CustomSize size, {
//     required String initials,
//     required String childName,
//     required String expertName,
//     required String specialization,
//     required String status,
//     required _StatusMeta meta,
//   }) {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [AppColors.primaryColor, AppColors.secondaryColor],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       child: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.fromLTRB(
//             size.customWidth(context) * 0.05,
//             size.customHeight(context) * 0.07,
//             size.customWidth(context) * 0.05,
//             16,
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     width: 68,
//                     height: 68,
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.2),
//                       borderRadius: BorderRadius.circular(20),
//                       border: Border.all(
//                           color: Colors.white.withOpacity(0.4), width: 2),
//                     ),
//                     child: Center(
//                       child: Text(
//                         initials.isNotEmpty ? initials : 'C',
//                         style: GoogleFonts.poppins(
//                             color: Colors.white,
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: size.customWidth(context) * 0.04),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           childName.isNotEmpty ? childName : 'Loading...',
//                           style: GoogleFonts.poppins(
//                               color: Colors.white,
//                               fontSize: size.customWidth(context) * 0.048,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(height: 2),
//                         if (expertName.isNotEmpty)
//                           Text(
//                             expertName,
//                             style: GoogleFonts.poppins(
//                                 color: Colors.white.withOpacity(0.9),
//                                 fontSize: size.customWidth(context) * 0.033),
//                           ),
//                         if (specialization.isNotEmpty)
//                           Text(
//                             specialization,
//                             style: GoogleFonts.poppins(
//                                 color: Colors.white.withOpacity(0.75),
//                                 fontSize: size.customWidth(context) * 0.029),
//                           ),
//                         const SizedBox(height: 8),
//                         if (status.isNotEmpty)
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 12, vertical: 5),
//                             decoration: BoxDecoration(
//                               color: meta.color.withOpacity(0.25),
//                               borderRadius: BorderRadius.circular(20),
//                               border: Border.all(
//                                   color: Colors.white.withOpacity(0.4)),
//                             ),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Icon(meta.icon,
//                                     color: Colors.white, size: 13),
//                                 const SizedBox(width: 5),
//                                 Text(
//                                   meta.label,
//                                   style: GoogleFonts.poppins(
//                                       color: Colors.white,
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w600),
//                                 ),
//                               ],
//                             ),
//                           ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // ── Action buttons ─────────────────────────────────────────
//   Widget _buildActionButtons(
//       BuildContext context, CustomSize size, MyAppointmentItem appt) {
//     final List<_ActionBtn> buttons = [];

//     if (appt.isScheduled) {
//       buttons.addAll([
//         _ActionBtn(
//           label: 'Confirm',
//           icon: Icons.check_circle_outline_rounded,
//           color: AppColors.primaryColor,
//           onTap: () => _showConfirmDialog(context, appt.appointmentId),
//         ),
//         _ActionBtn(
//           label: 'Cancel',
//           icon: Icons.cancel_outlined,
//           color: AppColors.errorColor,
//           onTap: () => _showCancelDialog(context, appt.appointmentId),
//         ),
//         _ActionBtn(
//           label: 'No Show',
//           icon: Icons.person_off_outlined,
//           color: AppColors.greyColor,
//           onTap: () => _showNoShowDialog(context, appt.appointmentId),
//         ),
//       ]);
//     } else if (appt.isConfirmed) {
//       buttons.addAll([
//         _ActionBtn(
//           label: 'Complete',
//           icon: Icons.task_alt_rounded,
//           color: AppColors.successColor,
//           onTap: () => _showCompleteDialog(context, size, appt),
//         ),
//         _ActionBtn(
//           label: 'Cancel',
//           icon: Icons.cancel_outlined,
//           color: AppColors.errorColor,
//           onTap: () => _showCancelDialog(context, appt.appointmentId),
//         ),
//         _ActionBtn(
//           label: 'No Show',
//           icon: Icons.person_off_outlined,
//           color: AppColors.greyColor,
//           onTap: () => _showNoShowDialog(context, appt.appointmentId),
//         ),
//       ]);
//     }

//     if (buttons.isEmpty) return const SizedBox.shrink();

//     return Row(
//       children: buttons.map((b) {
//         return Expanded(
//           child: GestureDetector(
//             onTap: b.onTap,
//             child: Container(
//               margin: const EdgeInsets.symmetric(horizontal: 4),
//               padding: const EdgeInsets.symmetric(vertical: 14),
//               decoration: BoxDecoration(
//                 color: b.color.withOpacity(0.09),
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(color: b.color.withOpacity(0.35)),
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(b.icon, color: b.color, size: 22),
//                   const SizedBox(height: 5),
//                   Text(
//                     b.label,
//                     style: GoogleFonts.poppins(
//                         fontSize: 11,
//                         fontWeight: FontWeight.w600,
//                         color: b.color),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }

//   // ── Info card ──────────────────────────────────────────────
//   Widget _buildInfoCard(
//       BuildContext context, CustomSize size, MyAppointmentItem appt) {
//     return _card(
//       context,
//       size,
//       title: 'Appointment Details',
//       icon: Icons.event_note_rounded,
//       iconColor: AppColors.primaryColor,
//       children: [
//         _row(context, size, 'Date', appt.formattedDate,
//             Icons.calendar_today_outlined),
//         _row(context, size, 'Time', appt.formattedTime,
//             Icons.access_time_rounded),
//         _row(context, size, 'Duration', '${appt.durationMinutes} minutes',
//             Icons.timer_outlined),
//         _row(
//             context,
//             size,
//             'Mode',
//             appt.bookedMode[0].toUpperCase() + appt.bookedMode.substring(1),
//             _modeIcon(appt.bookedMode)),
//         _row(
//             context,
//             size,
//             'Fee',
//             '${appt.currency} ${appt.feeCharged.toStringAsFixed(0)}',
//             Icons.payments_outlined),
//         if (appt.meetLink != null && appt.meetLink!.isNotEmpty)
//           _row(context, size, 'Meet Link', appt.meetLink!, Icons.link_rounded),
//       ],
//     );
//   }

//   // ── Slot card ──────────────────────────────────────────────
//   Widget _buildSlotCard(
//       BuildContext context, CustomSize size, AppointmentSlot slot) {
//     return _card(
//       context,
//       size,
//       title: 'Slot Information',
//       icon: Icons.calendar_month_rounded,
//       iconColor: AppColors.secondaryColor,
//       children: [
//         _row(context, size, 'Date', slot.slotDate, Icons.today_rounded),
//         _row(context, size, 'Time',
//             '${slot.formattedStart} – ${slot.formattedEnd}',
//             Icons.schedule_rounded),
//         _row(
//             context,
//             size,
//             'Mode',
//             slot.mode.isNotEmpty
//                 ? slot.mode[0].toUpperCase() + slot.mode.substring(1)
//                 : slot.mode,
//             _modeIcon(slot.mode)),
//         if (slot.status != null)
//           _row(context, size, 'Slot Status',
//               slot.status![0].toUpperCase() + slot.status!.substring(1),
//               Icons.info_outline_rounded),
//       ],
//     );
//   }

//   // ── Expert card ────────────────────────────────────────────
//   Widget _buildExpertCard(
//       BuildContext context, CustomSize size, AppointmentExpert expert) {
//     return _card(
//       context,
//       size,
//       title: 'Expert Information',
//       icon: Icons.person_outline_rounded,
//       iconColor: AppColors.accentColor,
//       children: [
//         _row(context, size, 'Name', expert.fullName, Icons.badge_outlined),
//         _row(context, size, 'Specialization', expert.specialization,
//             Icons.medical_information_outlined),
//         if (expert.phone != null && expert.phone!.isNotEmpty)
//           _row(context, size, 'Phone', expert.phone!, Icons.phone_outlined),
//         if (expert.contactEmail != null && expert.contactEmail!.isNotEmpty)
//           _row(context, size, 'Email', expert.contactEmail!,
//               Icons.email_outlined),
//       ],
//     );
//   }

//   // ── Cancellation card ──────────────────────────────────────
//   Widget _buildCancellationCard(
//       BuildContext context, CustomSize size, MyAppointmentItem appt) {
//     return Container(
//       padding: EdgeInsets.all(size.customWidth(context) * 0.045),
//       decoration: BoxDecoration(
//         color: AppColors.errorColor.withOpacity(0.05),
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(color: AppColors.errorColor.withOpacity(0.25)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(7),
//                 decoration: BoxDecoration(
//                     color: AppColors.errorColor.withOpacity(0.12),
//                     borderRadius: BorderRadius.circular(9)),
//                 child: const Icon(Icons.cancel_outlined,
//                     color: AppColors.errorColor, size: 17),
//               ),
//               const SizedBox(width: 10),
//               Text('Cancellation Info',
//                   style: GoogleFonts.poppins(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.errorColor)),
//             ],
//           ),
//           const SizedBox(height: 14),
//           if (appt.cancelledBy != null)
//             _row(
//                 context,
//                 size,
//                 'Cancelled By',
//                 appt.cancelledBy![0].toUpperCase() +
//                     appt.cancelledBy!.substring(1),
//                 Icons.person_outlined),
//           if (appt.cancellationReason != null)
//             _row(context, size, 'Reason', appt.cancellationReason!,
//                 Icons.info_outline_rounded),
//           if (appt.cancelledAt != null)
//             _row(context, size, 'Cancelled At',
//                 _formatDateTime(appt.cancelledAt!), Icons.schedule_rounded),
//         ],
//       ),
//     );
//   }

//   // ── Records section ────────────────────────────────────────
//   Widget _buildRecordsSection(
//       BuildContext context, CustomSize size, MyAppointmentItem appt) {
//     // Only show records section for completed appointments
//     if (!appt.isCompleted) return const SizedBox.shrink();

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 Container(
//                   width: 4,
//                   height: 20,
//                   decoration: BoxDecoration(
//                       color: AppColors.primaryColor,
//                       borderRadius: BorderRadius.circular(2)),
//                 ),
//                 const SizedBox(width: 10),
//                 Text(
//                   'Session Records',
//                   style: GoogleFonts.poppins(
//                       fontSize: size.customWidth(context) * 0.042,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.textPrimaryColor),
//                 ),
//               ],
//             ),
//             // "Add Note" button — always visible for completed appointments
//             GestureDetector(
//               onTap: () {
//                 _c.clearRecordForm();
//                 _openRecordSheet(context, size, appt.appointmentId);
//               },
//               child: Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
//                 decoration: BoxDecoration(
//                   color: AppColors.primaryColor,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const Icon(Icons.add_rounded,
//                         color: Colors.white, size: 16),
//                     const SizedBox(width: 4),
//                     Text('Add Note',
//                         style: GoogleFonts.poppins(
//                             color: Colors.white,
//                             fontWeight: FontWeight.w600,
//                             fontSize: 12)),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: size.customHeight(context) * 0.015),

//         Obx(() {
//           if (_c.isLoadingRecords.value) {
//             return const Center(
//               child: Padding(
//                 padding: EdgeInsets.all(30),
//                 child: CircularProgressIndicator(
//                     color: AppColors.primaryColor, strokeWidth: 2),
//               ),
//             );
//           }
//           if (_c.records.isEmpty) {
//             // Highlighted "missing notes" prompt for completed with no records
//             return _buildMissingNotesHighlight(context, size, appt);
//           }
//           return Column(
//             children: _c.records
//                 .map((r) => _buildRecordCard(context, size, r, appt))
//                 .toList(),
//           );
//         }),
//       ],
//     );
//   }

//   /// Prominent warning banner shown when a completed appointment has no notes
//   Widget _buildMissingNotesHighlight(
//       BuildContext context, CustomSize size, MyAppointmentItem appt) {
//     return GestureDetector(
//       onTap: () {
//         _c.clearRecordForm();
//         _openRecordSheet(context, size, appt.appointmentId);
//       },
//       child: Container(
//         padding: EdgeInsets.all(size.customWidth(context) * 0.045),
//         decoration: BoxDecoration(
//           color: AppColors.warningColor.withOpacity(0.07),
//           borderRadius: BorderRadius.circular(18),
//           border: Border.all(
//               color: AppColors.warningColor.withOpacity(0.5), width: 1.5),
//         ),
//         child: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                   color: AppColors.warningColor.withOpacity(0.15),
//                   borderRadius: BorderRadius.circular(12)),
//               child: const Icon(Icons.warning_amber_rounded,
//                   color: AppColors.warningColor, size: 24),
//             ),
//             const SizedBox(width: 14),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Session notes missing!',
//                     style: GoogleFonts.poppins(
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                         color: AppColors.warningColor),
//                   ),
//                   const SizedBox(height: 3),
//                   Text(
//                     'Tap here to add session notes now.',
//                     style: GoogleFonts.poppins(
//                         fontSize: 12,
//                         color: AppColors.warningColor.withOpacity(0.85)),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(width: 8),
//             const Icon(Icons.arrow_forward_ios_rounded,
//                 size: 14, color: AppColors.warningColor),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildRecordCard(BuildContext context, CustomSize size,
//       AppointmentRecordItem record, MyAppointmentItem appt) {
//     return Container(
//       margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.014),
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
//       child: Padding(
//         padding: EdgeInsets.all(size.customWidth(context) * 0.042),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                           color: AppColors.primaryColor.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(10)),
//                       child: const Icon(Icons.description_outlined,
//                           color: AppColors.primaryColor, size: 18),
//                     ),
//                     const SizedBox(width: 10),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('Session Note',
//                             style: GoogleFonts.poppins(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w600,
//                                 color: AppColors.textPrimaryColor)),
//                         Text(record.formattedDate,
//                             style: GoogleFonts.poppins(
//                                 fontSize: 11,
//                                 color: AppColors.textSecondaryColor)),
//                       ],
//                     ),
//                   ],
//                 ),
//                 // Edit button always visible for completed appointments
//                 GestureDetector(
//                   onTap: () {
//                     _c.populateRecordForm(record);
//                     _openRecordSheet(context, size, appt.appointmentId,
//                         editingRecord: record);
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.all(7),
//                     decoration: BoxDecoration(
//                         color: AppColors.warningColor.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(9)),
//                     child: const Icon(Icons.edit_outlined,
//                         color: AppColors.warningColor, size: 16),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: size.customHeight(context) * 0.012),
//             Divider(height: 1, color: AppColors.greyColor.withOpacity(0.15)),
//             SizedBox(height: size.customHeight(context) * 0.012),

//             _recordField('Notes', record.notes, Icons.notes_rounded),
//             SizedBox(height: size.customHeight(context) * 0.01),
//             _recordField('Therapy Plan', record.therapyPlan,
//                 Icons.health_and_safety_outlined),
//             SizedBox(height: size.customHeight(context) * 0.01),
//             _recordField('Progress Feedback', record.progressFeedback,
//                 Icons.trending_up_rounded),
//             if (record.medication != null &&
//                 record.medication!['name'] != null &&
//                 record.medication!['name'].toString().toLowerCase() !=
//                     'none') ...[
//               SizedBox(height: size.customHeight(context) * 0.01),
//               _recordField(
//                   'Medication',
//                   '${record.medication!['name']}${record.medication!['dosage'] != null ? ' — ${record.medication!['dosage']}' : ''}',
//                   Icons.medication_outlined),
//             ],
//           ],
//         ),
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
//               const SizedBox(height: 2),
//               Text(value,
//                   style: GoogleFonts.poppins(
//                       fontSize: 13, color: AppColors.textPrimaryColor)),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   // ── Shared card widget ─────────────────────────────────────
//   Widget _card(
//     BuildContext context,
//     CustomSize size, {
//     required String title,
//     required IconData icon,
//     required Color iconColor,
//     required List<Widget> children,
//   }) {
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
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                     color: iconColor.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(10)),
//                 child: Icon(icon, color: iconColor, size: 18),
//               ),
//               const SizedBox(width: 10),
//               Text(title,
//                   style: GoogleFonts.poppins(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.textPrimaryColor)),
//             ],
//           ),
//           SizedBox(height: size.customHeight(context) * 0.014),
//           Divider(height: 1, color: AppColors.greyColor.withOpacity(0.15)),
//           SizedBox(height: size.customHeight(context) * 0.012),
//           ...children,
//         ],
//       ),
//     );
//   }

//   Widget _row(BuildContext context, CustomSize size, String label, String value,
//       IconData icon) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: size.customHeight(context) * 0.01),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, size: 14, color: AppColors.textSecondaryColor),
//           const SizedBox(width: 10),
//           SizedBox(
//             width: size.customWidth(context) * 0.26,
//             child: Text(label,
//                 style: GoogleFonts.poppins(
//                     fontSize: 12,
//                     color: AppColors.textSecondaryColor,
//                     fontWeight: FontWeight.w500)),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               style: GoogleFonts.poppins(
//                   fontSize: 13,
//                   color: AppColors.textPrimaryColor,
//                   fontWeight: FontWeight.w500),
//               maxLines: 3,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ── Dialogs ────────────────────────────────────────────────

//   /// NEW FLOW: Complete API first → then open notes sheet on success
//   void _showCompleteDialog(
//       BuildContext context, CustomSize size, MyAppointmentItem appt) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (_) => _ActionDialog(
//         title: 'Mark as Completed?',
//         message:
//             'This will complete the appointment. You will be asked to add session notes next.',
//         confirmLabel: 'Yes, Complete',
//         confirmColor: AppColors.successColor,
//         icon: Icons.task_alt_rounded,
//         onConfirm: () async {
//           final ok = await _c.completeAppointment(appt.appointmentId);
//           return ok;
//         },
//         onSuccess: () {
//           // Dialog is already closed by _ActionDialog on success.
//           // Now open the post-complete notes sheet.
//           _openPostCompleteNotesSheet(context, size, appt.appointmentId);
//         },
//       ),
//     );
//   }

//   /// Opens the mandatory notes sheet right after completing an appointment.
//   void _openPostCompleteNotesSheet(
//       BuildContext context, CustomSize size, String appointmentId) {
//     _c.clearRecordForm();
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       isDismissible: false,
//       enableDrag: false,
//       backgroundColor: Colors.transparent,
//       builder: (_) => ConstrainedBox(
//         constraints:
//             BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.93),
//         child: _PostCompleteNotesSheet(
//           controller: _c,
//           size: size,
//           appointmentId: appointmentId,
//           onDone: () {
//             Navigator.pop(context); // close sheet
//             Get.back();             // go back to list
//           },
//         ),
//       ),
//     );
//   }

//   void _showConfirmDialog(BuildContext context, String id) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (_) => _ActionDialog(
//         title: 'Confirm Appointment?',
//         message: 'This will confirm the appointment for the patient.',
//         confirmLabel: 'Yes, Confirm',
//         confirmColor: AppColors.primaryColor,
//         icon: Icons.check_circle_outline_rounded,
//         onConfirm: () async {
//           final ok = await _c.confirmAppointment(id);
//           return ok;
//         },
//         onSuccess: () {
//           Navigator.pop(context);
//           Get.back();
//         },
//       ),
//     );
//   }

//   void _showCancelDialog(BuildContext context, String id) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (_) => _CancelDialog(
//         id: id,
//         controller: _c,
//         onCancelled: () {
//           Navigator.pop(context);
//           Get.back();
//         },
//       ),
//     );
//   }

//   void _showNoShowDialog(BuildContext context, String id) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (_) => _ActionDialog(
//         title: 'Mark as No Show?',
//         message: 'Patient did not attend the session. Mark as no-show?',
//         confirmLabel: 'Mark No Show',
//         confirmColor: AppColors.greyColor,
//         icon: Icons.person_off_outlined,
//         onConfirm: () async {
//           final ok = await _c.markNoShow(id);
//           return ok;
//         },
//         onSuccess: () {
//           Navigator.pop(context);
//           Get.back();
//         },
//       ),
//     );
//   }

//   void _openRecordSheet(BuildContext context, CustomSize size,
//       String appointmentId,
//       {AppointmentRecordItem? editingRecord}) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (_) => ConstrainedBox(
//         constraints:
//             BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.93),
//         child: _RecordFormSheet(
//           controller: _c,
//           size: size,
//           appointmentId: appointmentId,
//           editingRecord: editingRecord,
//           onSaved: () {},
//         ),
//       ),
//     );
//   }

//   // ── Helpers ────────────────────────────────────────────────
//   Widget _buildError() {
//     return Scaffold(
//       appBar: AppBar(
//           backgroundColor: AppColors.whiteColor,
//           elevation: 0,
//           surfaceTintColor: Colors.transparent,
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back_ios_new_rounded,
//                 color: AppColors.textPrimaryColor),
//             onPressed: () => Get.back(),
//           )),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(Icons.error_outline_rounded,
//                 size: 60, color: AppColors.errorColor),
//             const SizedBox(height: 16),
//             Text('Appointment not found',
//                 style: GoogleFonts.poppins(
//                     fontSize: 16, color: AppColors.textPrimaryColor)),
//             const SizedBox(height: 8),
//             TextButton(
//               onPressed: () => Get.back(),
//               child: Text('Go Back',
//                   style: GoogleFonts.poppins(color: AppColors.primaryColor)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   String _formatDateTime(String raw) {
//     try {
//       final dt = DateTime.parse(raw).toLocal();
//       const months = [
//         '',
//         'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
//         'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
//       ];
//       int h = dt.hour;
//       final m = dt.minute.toString().padLeft(2, '0');
//       final ampm = h >= 12 ? 'PM' : 'AM';
//       if (h > 12) h -= 12;
//       if (h == 0) h = 12;
//       return '${dt.day} ${months[dt.month]} ${dt.year}, $h:$m $ampm';
//     } catch (_) {
//       return raw;
//     }
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

// // ── Data classes ───────────────────────────────────────────────
// class _StatusMeta {
//   final Color color;
//   final String label;
//   final IconData icon;
//   _StatusMeta(this.color, this.label, this.icon);
// }

// class _ActionBtn {
//   final String label;
//   final IconData icon;
//   final Color color;
//   final VoidCallback onTap;
//   _ActionBtn(
//       {required this.label,
//       required this.icon,
//       required this.color,
//       required this.onTap});
// }

// // ══════════════════════════════════════════════════════════════
// // Generic action confirm dialog
// // ══════════════════════════════════════════════════════════════
// class _ActionDialog extends StatefulWidget {
//   final String title;
//   final String message;
//   final String confirmLabel;
//   final Color confirmColor;
//   final IconData icon;
//   final Future<bool> Function() onConfirm;
//   /// Called after dialog is popped on success — use this to open next sheet
//   final VoidCallback? onSuccess;

//   const _ActionDialog({
//     required this.title,
//     required this.message,
//     required this.confirmLabel,
//     required this.confirmColor,
//     required this.icon,
//     required this.onConfirm,
//     this.onSuccess,
//   });

//   @override
//   State<_ActionDialog> createState() => _ActionDialogState();
// }

// class _ActionDialogState extends State<_ActionDialog> {
//   bool _loading = false;

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
//       contentPadding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//                 color: widget.confirmColor.withOpacity(0.1),
//                 shape: BoxShape.circle),
//             child: Icon(widget.icon, color: widget.confirmColor, size: 34),
//           ),
//           const SizedBox(height: 16),
//           Text(widget.title,
//               style: GoogleFonts.poppins(
//                   fontSize: 17,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.textPrimaryColor),
//               textAlign: TextAlign.center),
//           const SizedBox(height: 8),
//           Text(widget.message,
//               style: GoogleFonts.poppins(
//                   fontSize: 13, color: AppColors.textSecondaryColor),
//               textAlign: TextAlign.center),
//           const SizedBox(height: 24),
//           Row(
//             children: [
//               Expanded(
//                 child: OutlinedButton(
//                   onPressed:
//                       _loading ? null : () => Navigator.pop(context),
//                   style: OutlinedButton.styleFrom(
//                     foregroundColor: AppColors.textSecondaryColor,
//                     side: BorderSide(
//                         color: AppColors.greyColor.withOpacity(0.5)),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12)),
//                     padding: const EdgeInsets.symmetric(vertical: 13),
//                   ),
//                   child: Text('Cancel',
//                       style: GoogleFonts.poppins(
//                           fontWeight: FontWeight.w500, fontSize: 13)),
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: ElevatedButton(
//                   onPressed: _loading
//                       ? null
//                       : () async {
//                           setState(() => _loading = true);
//                           final ok = await widget.onConfirm();
//                           if (!mounted) return;
//                           setState(() => _loading = false);
//                           if (ok) {
//                             Navigator.pop(context);
//                             // Fire onSuccess after dialog is off the stack
//                             WidgetsBinding.instance.addPostFrameCallback((_) {
//                               widget.onSuccess?.call();
//                             });
//                           }
//                         },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: widget.confirmColor,
//                     foregroundColor: Colors.white,
//                     disabledBackgroundColor:
//                         widget.confirmColor.withOpacity(0.5),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12)),
//                     padding: const EdgeInsets.symmetric(vertical: 13),
//                     elevation: 0,
//                   ),
//                   child: _loading
//                       ? const SizedBox(
//                           width: 18,
//                           height: 18,
//                           child: CircularProgressIndicator(
//                               color: Colors.white, strokeWidth: 2))
//                       : Text(widget.confirmLabel,
//                           style: GoogleFonts.poppins(
//                               fontWeight: FontWeight.w600, fontSize: 13)),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ══════════════════════════════════════════════════════════════
// // Cancel dialog with reason input
// // ══════════════════════════════════════════════════════════════
// class _CancelDialog extends StatefulWidget {
//   final String id;
//   final MyAppointmentController controller;
//   final VoidCallback? onCancelled;

//   const _CancelDialog({
//     required this.id,
//     required this.controller,
//     this.onCancelled,
//   });

//   @override
//   State<_CancelDialog> createState() => _CancelDialogState();
// }

// class _CancelDialogState extends State<_CancelDialog> {
//   final _reasonCtrl = TextEditingController();
//   bool _loading = false;

//   @override
//   void dispose() {
//     _reasonCtrl.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
//       contentPadding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//                 color: AppColors.errorColor.withOpacity(0.1),
//                 shape: BoxShape.circle),
//             child: const Icon(Icons.cancel_outlined,
//                 color: AppColors.errorColor, size: 34),
//           ),
//           const SizedBox(height: 16),
//           Text('Cancel Appointment',
//               style: GoogleFonts.poppins(
//                   fontSize: 17,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.textPrimaryColor),
//               textAlign: TextAlign.center),
//           const SizedBox(height: 6),
//           Text('Please provide a cancellation reason.',
//               style: GoogleFonts.poppins(
//                   fontSize: 13, color: AppColors.textSecondaryColor),
//               textAlign: TextAlign.center),
//           const SizedBox(height: 18),
//           TextField(
//             controller: _reasonCtrl,
//             maxLines: 3,
//             style: GoogleFonts.poppins(
//                 fontSize: 13, color: AppColors.textPrimaryColor),
//             decoration: InputDecoration(
//               hintText: 'Enter reason here...',
//               hintStyle: GoogleFonts.poppins(
//                   fontSize: 13,
//                   color: AppColors.textSecondaryColor.withOpacity(0.6)),
//               filled: true,
//               fillColor: AppColors.lightGreyColor,
//               contentPadding: const EdgeInsets.all(14),
//               border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: BorderSide.none),
//               enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: BorderSide(
//                       color: AppColors.greyColor.withOpacity(0.25))),
//               focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: const BorderSide(
//                       color: AppColors.primaryColor, width: 1.5)),
//             ),
//           ),
//           const SizedBox(height: 20),
//           Row(
//             children: [
//               Expanded(
//                 child: OutlinedButton(
//                   onPressed:
//                       _loading ? null : () => Navigator.pop(context),
//                   style: OutlinedButton.styleFrom(
//                     foregroundColor: AppColors.textSecondaryColor,
//                     side: BorderSide(
//                         color: AppColors.greyColor.withOpacity(0.5)),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12)),
//                     padding: const EdgeInsets.symmetric(vertical: 13),
//                   ),
//                   child: Text('Back',
//                       style: GoogleFonts.poppins(
//                           fontWeight: FontWeight.w500, fontSize: 13)),
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: ElevatedButton(
//                   onPressed: _loading
//                       ? null
//                       : () async {
//                           final reason = _reasonCtrl.text.trim();
//                           if (reason.isEmpty) {
//                             Get.snackbar(
//                               'Required',
//                               'Please enter a cancellation reason',
//                               snackPosition: SnackPosition.BOTTOM,
//                               backgroundColor: AppColors.warningColor,
//                               colorText: Colors.white,
//                               margin: const EdgeInsets.all(16),
//                               borderRadius: 12,
//                             );
//                             return;
//                           }
//                           setState(() => _loading = true);
//                           final ok = await widget.controller
//                               .cancelAppointment(widget.id, reason);
//                           if (mounted) setState(() => _loading = false);
//                           if (ok) {
//                             widget.onCancelled?.call();
//                           }
//                         },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.errorColor,
//                     foregroundColor: Colors.white,
//                     disabledBackgroundColor:
//                         AppColors.errorColor.withOpacity(0.5),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12)),
//                     padding: const EdgeInsets.symmetric(vertical: 13),
//                     elevation: 0,
//                   ),
//                   child: _loading
//                       ? const SizedBox(
//                           width: 18,
//                           height: 18,
//                           child: CircularProgressIndicator(
//                               color: Colors.white, strokeWidth: 2))
//                       : Text('Cancel Appt.',
//                           style: GoogleFonts.poppins(
//                               fontWeight: FontWeight.w600, fontSize: 13)),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ══════════════════════════════════════════════════════════════
// // Post-complete notes sheet
// // Shown automatically right after completing an appointment.
// // isDismissible=false / enableDrag=false so it can't be swiped away.
// // Has a "Skip for now" text button as a deliberate escape hatch.
// // ══════════════════════════════════════════════════════════════
// class _PostCompleteNotesSheet extends StatefulWidget {
//   final MyAppointmentController controller;
//   final CustomSize size;
//   final String appointmentId;
//   final VoidCallback? onDone;

//   const _PostCompleteNotesSheet({
//     required this.controller,
//     required this.size,
//     required this.appointmentId,
//     this.onDone,
//   });

//   @override
//   State<_PostCompleteNotesSheet> createState() =>
//       _PostCompleteNotesSheetState();
// }

// class _PostCompleteNotesSheetState extends State<_PostCompleteNotesSheet> {
//   final _formKey = GlobalKey<FormState>();
//   bool _saving = false;

//   @override
//   Widget build(BuildContext context) {
//     final size = widget.size;

//     return Container(
//       decoration: const BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
//       ),
//       padding:
//           EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//       child: SingleChildScrollView(
//         physics: const ClampingScrollPhysics(),
//         padding: EdgeInsets.fromLTRB(
//           size.customWidth(context) * 0.05,
//           20,
//           size.customWidth(context) * 0.05,
//           size.customHeight(context) * 0.04,
//         ),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // Handle bar
//               Center(
//                 child: Container(
//                   width: 44,
//                   height: 4,
//                   decoration: BoxDecoration(
//                       color: AppColors.greyColor.withOpacity(0.3),
//                       borderRadius: BorderRadius.circular(2)),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // ── Success header ──────────────────────────────
//               Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: AppColors.successColor.withOpacity(0.08),
//                   borderRadius: BorderRadius.circular(16),
//                   border: Border.all(
//                       color: AppColors.successColor.withOpacity(0.3)),
//                 ),
//                 child: Row(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                           color: AppColors.successColor.withOpacity(0.15),
//                           borderRadius: BorderRadius.circular(12)),
//                       child: const Icon(Icons.task_alt_rounded,
//                           color: AppColors.successColor, size: 24),
//                     ),
//                     const SizedBox(width: 14),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Appointment Completed!',
//                             style: GoogleFonts.poppins(
//                                 fontSize: size.customWidth(context) * 0.04,
//                                 fontWeight: FontWeight.bold,
//                                 color: AppColors.successColor),
//                           ),
//                           Text(
//                             'Please add session notes below.',
//                             style: GoogleFonts.poppins(
//                                 fontSize: size.customWidth(context) * 0.03,
//                                 color:
//                                     AppColors.successColor.withOpacity(0.8)),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: size.customHeight(context) * 0.018),

//               // ── Fields ──────────────────────────────────────
//               _field(context, size, 'Session Notes *',
//                   'What happened during the session?',
//                   Icons.notes_rounded, widget.controller.notesCtrl,
//                   maxLines: 3, required: true),
//               SizedBox(height: size.customHeight(context) * 0.016),

//               _field(context, size, 'Therapy Plan *',
//                   'Plan for upcoming sessions...',
//                   Icons.health_and_safety_outlined,
//                   widget.controller.therapyPlanCtrl,
//                   maxLines: 3, required: true),
//               SizedBox(height: size.customHeight(context) * 0.016),

//               _field(context, size, 'Progress Feedback *',
//                   'How did the patient progress?',
//                   Icons.trending_up_rounded,
//                   widget.controller.progressFeedbackCtrl,
//                   maxLines: 2, required: true),
//               SizedBox(height: size.customHeight(context) * 0.016),

//               Text('Medication (optional)',
//                   style: GoogleFonts.poppins(
//                       fontSize: size.customWidth(context) * 0.034,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.textPrimaryColor)),
//               const SizedBox(height: 8),
//               Row(
//                 children: [
//                   Expanded(
//                     child: _field(context, size, 'Name', 'e.g. None',
//                         Icons.medication_outlined,
//                         widget.controller.medicationNameCtrl,
//                         maxLines: 1, required: false),
//                   ),
//                   SizedBox(width: size.customWidth(context) * 0.03),
//                   Expanded(
//                     child: _field(context, size, 'Dosage', 'e.g. 5mg',
//                         Icons.science_outlined,
//                         widget.controller.medicationDosageCtrl,
//                         maxLines: 1, required: false),
//                   ),
//                 ],
//               ),
//               SizedBox(height: size.customHeight(context) * 0.028),

//               // ── Save button ─────────────────────────────────
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton.icon(
//                   onPressed: _saving
//                       ? null
//                       : () async {
//                           if (!_formKey.currentState!.validate()) return;
//                           setState(() => _saving = true);
//                           final ok = await widget.controller
//                               .createRecord(widget.appointmentId);
//                           if (mounted) setState(() => _saving = false);
//                           if (ok) {
//                             widget.onDone?.call();
//                           }
//                         },
//                   icon: _saving
//                       ? const SizedBox(
//                           width: 18,
//                           height: 18,
//                           child: CircularProgressIndicator(
//                               color: Colors.white, strokeWidth: 2))
//                       : const Icon(Icons.save_rounded, size: 20),
//                   label: Text(
//                     _saving ? 'Saving...' : 'Save Session Notes',
//                     style: GoogleFonts.poppins(
//                         fontWeight: FontWeight.w600,
//                         fontSize: size.customWidth(context) * 0.038),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.successColor,
//                     foregroundColor: Colors.white,
//                     disabledBackgroundColor:
//                         AppColors.successColor.withOpacity(0.4),
//                     padding: EdgeInsets.symmetric(
//                         vertical: size.customHeight(context) * 0.02),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(16)),
//                     elevation: 2,
//                   ),
//                 ),
//               ),
//               SizedBox(height: size.customHeight(context) * 0.008),

//               // ── Deliberate skip option ──────────────────────
//               SizedBox(
//                 width: double.infinity,
//                 child: TextButton(
//                   onPressed: _saving
//                       ? null
//                       : () {
//                           widget.onDone?.call();
//                         },
//                   child: Text(
//                     'Skip for now (add later from session records)',
//                     style: GoogleFonts.poppins(
//                         color: AppColors.textSecondaryColor,
//                         fontWeight: FontWeight.w500,
//                         fontSize: 12),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _field(
//     BuildContext context,
//     CustomSize size,
//     String label,
//     String hint,
//     IconData icon,
//     TextEditingController ctrl, {
//     int maxLines = 1,
//     bool required = true,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label,
//             style: GoogleFonts.poppins(
//                 fontSize: size.customWidth(context) * 0.033,
//                 fontWeight: FontWeight.w600,
//                 color: AppColors.textPrimaryColor)),
//         const SizedBox(height: 6),
//         TextFormField(
//           controller: ctrl,
//           maxLines: maxLines,
//           validator: required
//               ? (v) => (v == null || v.trim().isEmpty)
//                   ? '$label is required'
//                   : null
//               : null,
//           style: GoogleFonts.poppins(
//               fontSize: 13, color: AppColors.textPrimaryColor),
//           decoration: InputDecoration(
//             hintText: hint,
//             hintStyle: GoogleFonts.poppins(
//                 fontSize: 13,
//                 color: AppColors.textSecondaryColor.withOpacity(0.6)),
//             prefixIcon: maxLines == 1
//                 ? Icon(icon, color: AppColors.primaryColor, size: 19)
//                 : null,
//             filled: true,
//             fillColor: AppColors.lightGreyColor,
//             contentPadding: EdgeInsets.symmetric(
//                 horizontal: 16, vertical: maxLines > 1 ? 14 : 0),
//             border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(14),
//                 borderSide: BorderSide.none),
//             enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(14),
//                 borderSide:
//                     BorderSide(color: AppColors.greyColor.withOpacity(0.2))),
//             focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(14),
//                 borderSide: const BorderSide(
//                     color: AppColors.primaryColor, width: 1.5)),
//             errorBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(14),
//                 borderSide: const BorderSide(
//                     color: AppColors.errorColor, width: 1)),
//             focusedErrorBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(14),
//                 borderSide: const BorderSide(
//                     color: AppColors.errorColor, width: 1.5)),
//           ),
//         ),
//       ],
//     );
//   }
// }

// // ══════════════════════════════════════════════════════════════
// // Record form sheet (Add / Edit for completed appointments)
// // ══════════════════════════════════════════════════════════════
// class _RecordFormSheet extends StatefulWidget {
//   final MyAppointmentController controller;
//   final CustomSize size;
//   final String appointmentId;
//   final AppointmentRecordItem? editingRecord;
//   final VoidCallback? onSaved;

//   const _RecordFormSheet({
//     required this.controller,
//     required this.size,
//     required this.appointmentId,
//     this.editingRecord,
//     this.onSaved,
//   });

//   @override
//   State<_RecordFormSheet> createState() => _RecordFormSheetState();
// }

// class _RecordFormSheetState extends State<_RecordFormSheet> {
//   final _formKey = GlobalKey<FormState>();
//   bool _saving = false;

//   bool get _isEdit => widget.editingRecord != null;

//   @override
//   Widget build(BuildContext context) {
//     final size = widget.size;

//     return Container(
//       decoration: const BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
//       ),
//       padding:
//           EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//       child: SingleChildScrollView(
//         physics: const ClampingScrollPhysics(),
//         padding: EdgeInsets.fromLTRB(
//           size.customWidth(context) * 0.05,
//           20,
//           size.customWidth(context) * 0.05,
//           size.customHeight(context) * 0.04,
//         ),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Center(
//                 child: Container(
//                   width: 44,
//                   height: 4,
//                   decoration: BoxDecoration(
//                       color: AppColors.greyColor.withOpacity(0.3),
//                       borderRadius: BorderRadius.circular(2)),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               Row(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                         color: AppColors.primaryColor.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(12)),
//                     child: Icon(
//                       _isEdit
//                           ? Icons.edit_note_rounded
//                           : Icons.note_add_rounded,
//                       color: AppColors.primaryColor,
//                       size: 22,
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           _isEdit
//                               ? 'Update Session Record'
//                               : 'New Session Record',
//                           style: GoogleFonts.poppins(
//                               fontSize: size.customWidth(context) * 0.042,
//                               fontWeight: FontWeight.bold,
//                               color: AppColors.textPrimaryColor),
//                         ),
//                         Text(
//                           _isEdit
//                               ? 'Edit session details'
//                               : 'Document this session',
//                           style: GoogleFonts.poppins(
//                               fontSize: size.customWidth(context) * 0.031,
//                               color: AppColors.textSecondaryColor),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: size.customHeight(context) * 0.022),

//               _field(context, size, 'Session Notes *',
//                   'Describe what happened during the session...',
//                   Icons.notes_rounded, widget.controller.notesCtrl,
//                   maxLines: 3, required: true),
//               SizedBox(height: size.customHeight(context) * 0.016),

//               _field(context, size, 'Therapy Plan *',
//                   'Outline the plan for next sessions...',
//                   Icons.health_and_safety_outlined,
//                   widget.controller.therapyPlanCtrl,
//                   maxLines: 3, required: true),
//               SizedBox(height: size.customHeight(context) * 0.016),

//               _field(context, size, 'Progress Feedback *',
//                   'How did the patient progress?',
//                   Icons.trending_up_rounded,
//                   widget.controller.progressFeedbackCtrl,
//                   maxLines: 2, required: true),
//               SizedBox(height: size.customHeight(context) * 0.016),

//               Text('Medication (optional)',
//                   style: GoogleFonts.poppins(
//                       fontSize: size.customWidth(context) * 0.034,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.textPrimaryColor)),
//               const SizedBox(height: 8),
//               Row(
//                 children: [
//                   Expanded(
//                     child: _field(context, size, 'Name', 'e.g. None',
//                         Icons.medication_outlined,
//                         widget.controller.medicationNameCtrl,
//                         maxLines: 1, required: false),
//                   ),
//                   SizedBox(width: size.customWidth(context) * 0.03),
//                   Expanded(
//                     child: _field(context, size, 'Dosage', 'e.g. 5mg',
//                         Icons.science_outlined,
//                         widget.controller.medicationDosageCtrl,
//                         maxLines: 1, required: false),
//                   ),
//                 ],
//               ),
//               SizedBox(height: size.customHeight(context) * 0.028),

//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: _saving
//                       ? null
//                       : () async {
//                           if (!_formKey.currentState!.validate()) return;
//                           setState(() => _saving = true);
//                           bool ok;
//                           if (_isEdit) {
//                             ok = await widget.controller.updateRecord(
//                               widget.appointmentId,
//                               widget.editingRecord!.recordId,
//                             );
//                           } else {
//                             ok = await widget.controller
//                                 .createRecord(widget.appointmentId);
//                           }
//                           if (mounted) setState(() => _saving = false);
//                           if (ok && context.mounted) {
//                             widget.onSaved?.call();
//                             Navigator.pop(context);
//                           }
//                         },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.primaryColor,
//                     foregroundColor: Colors.white,
//                     disabledBackgroundColor:
//                         AppColors.primaryColor.withOpacity(0.4),
//                     padding: EdgeInsets.symmetric(
//                         vertical: size.customHeight(context) * 0.02),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(16)),
//                     elevation: 2,
//                   ),
//                   child: _saving
//                       ? const SizedBox(
//                           width: 22,
//                           height: 22,
//                           child: CircularProgressIndicator(
//                               color: Colors.white, strokeWidth: 2.5))
//                       : Text(
//                           _isEdit ? 'Update Record' : 'Save Record',
//                           style: GoogleFonts.poppins(
//                               fontWeight: FontWeight.w600,
//                               fontSize: size.customWidth(context) * 0.038),
//                         ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _field(
//     BuildContext context,
//     CustomSize size,
//     String label,
//     String hint,
//     IconData icon,
//     TextEditingController ctrl, {
//     int maxLines = 1,
//     bool required = true,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label,
//             style: GoogleFonts.poppins(
//                 fontSize: size.customWidth(context) * 0.033,
//                 fontWeight: FontWeight.w600,
//                 color: AppColors.textPrimaryColor)),
//         const SizedBox(height: 6),
//         TextFormField(
//           controller: ctrl,
//           maxLines: maxLines,
//           validator: required
//               ? (v) => (v == null || v.trim().isEmpty)
//                   ? '$label is required'
//                   : null
//               : null,
//           style: GoogleFonts.poppins(
//               fontSize: 13, color: AppColors.textPrimaryColor),
//           decoration: InputDecoration(
//             hintText: hint,
//             hintStyle: GoogleFonts.poppins(
//                 fontSize: 13,
//                 color: AppColors.textSecondaryColor.withOpacity(0.6)),
//             prefixIcon: maxLines == 1
//                 ? Icon(icon, color: AppColors.primaryColor, size: 19)
//                 : null,
//             filled: true,
//             fillColor: AppColors.lightGreyColor,
//             contentPadding: EdgeInsets.symmetric(
//                 horizontal: 16, vertical: maxLines > 1 ? 14 : 0),
//             border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(14),
//                 borderSide: BorderSide.none),
//             enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(14),
//                 borderSide:
//                     BorderSide(color: AppColors.greyColor.withOpacity(0.2))),
//             focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(14),
//                 borderSide: const BorderSide(
//                     color: AppColors.primaryColor, width: 1.5)),
//             errorBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(14),
//                 borderSide: const BorderSide(
//                     color: AppColors.errorColor, width: 1)),
//             focusedErrorBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(14),
//                 borderSide: const BorderSide(
//                     color: AppColors.errorColor, width: 1.5)),
//           ),
//         ),
//       ],
//     );
//   }
// }


// lib/view/expert/appointments/appointment_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import 'package:speechspectrum/controllers/my_appointment_controller.dart';
import 'package:speechspectrum/models/my_appointment_model.dart';

class AppointmentDetailScreen extends StatefulWidget {
  const AppointmentDetailScreen({super.key});

  @override
  State<AppointmentDetailScreen> createState() =>
      _AppointmentDetailScreenState();
}

class _AppointmentDetailScreenState extends State<AppointmentDetailScreen> {
  late final MyAppointmentController _c;
  late final String _appointmentId;

  late final String _argChildName;
  late final String _argExpertName;
  late final String _argSpecialization;
  late final String _argChildInitials;
  late final String _argStatus;

  @override
  void initState() {
    super.initState();
    _c = Get.find<MyAppointmentController>();

    final args = Get.arguments;
    if (args is Map) {
      _appointmentId = (args['appointmentId'] ?? '').toString();
      _argChildName = (args['childName'] ?? '').toString();
      _argExpertName = (args['expertName'] ?? '').toString();
      _argSpecialization = (args['specialization'] ?? '').toString();
      _argChildInitials = (args['childInitials'] ?? '').toString();
      _argStatus = (args['status'] ?? '').toString();
    } else {
      _appointmentId = args?.toString() ?? '';
      _argChildName = '';
      _argExpertName = '';
      _argSpecialization = '';
      _argChildInitials = '';
      _argStatus = '';
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_appointmentId.isNotEmpty) {
        _c.fetchAppointmentDetail(_appointmentId);
        _c.fetchRecords(_appointmentId);
      }
    });
  }

  String get _displayChildName {
    final fromApi = _c.selectedAppointment.value?.children?.childName ?? '';
    return fromApi.isNotEmpty ? fromApi : _argChildName;
  }

  String get _displayExpertName {
    final fromApi = _c.selectedAppointment.value?.expertUsers?.fullName ?? '';
    return fromApi.isNotEmpty ? fromApi : _argExpertName;
  }

  String get _displaySpecialization {
    final fromApi =
        _c.selectedAppointment.value?.expertUsers?.specialization ?? '';
    return fromApi.isNotEmpty ? fromApi : _argSpecialization;
  }

  String get _displayInitials {
    final fromApi = _c.selectedAppointment.value?.childInitials ?? '';
    return fromApi.isNotEmpty ? fromApi : _argChildInitials;
  }

  String get _displayStatus {
    final fromApi = _c.selectedAppointment.value?.status ?? '';
    return fromApi.isNotEmpty ? fromApi : _argStatus;
  }

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();
    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      body: Obx(() {
        if (_c.isLoadingDetail.value &&
            _c.selectedAppointment.value == null) {
          return _buildLoadingWithHeader(context, size);
        }
        final appt = _c.selectedAppointment.value;
        if (appt == null) return _buildError();
        return _buildBody(context, size, appt);
      }),
    );
  }

  Widget _buildLoadingWithHeader(BuildContext context, CustomSize size) {
    final meta = _statusMeta(_argStatus);
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: size.customHeight(context) * 0.26,
          pinned: true,
          backgroundColor: AppColors.primaryColor,
          surfaceTintColor: Colors.transparent,
          leading: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.white, size: 18),
            ),
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: _buildHeaderBackground(
              context,
              size,
              initials: _argChildInitials,
              childName: _argChildName,
              expertName: _argExpertName,
              specialization: _argSpecialization,
              status: _argStatus,
              meta: meta,
            ),
          ),
        ),
        const SliverFillRemaining(
          child: Center(
            child: CircularProgressIndicator(
                color: AppColors.primaryColor, strokeWidth: 3),
          ),
        ),
      ],
    );
  }

  Widget _buildBody(
      BuildContext context, CustomSize size, MyAppointmentItem appt) {
    final meta = _statusMeta(appt.status);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: size.customHeight(context) * 0.26,
          pinned: true,
          backgroundColor: AppColors.primaryColor,
          surfaceTintColor: Colors.transparent,
          leading: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.white, size: 18),
            ),
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: _buildHeaderBackground(
              context,
              size,
              initials: appt.childInitials,
              childName: appt.children?.childName ?? _argChildName,
              expertName: appt.expertUsers?.fullName ?? _argExpertName,
              specialization:
                  appt.expertUsers?.specialization ?? _argSpecialization,
              status: appt.status,
              meta: meta,
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
              _buildActionButtons(context, size, appt),
              SizedBox(height: size.customHeight(context) * 0.022),

              _buildInfoCard(context, size, appt),
              SizedBox(height: size.customHeight(context) * 0.018),

              if (appt.appointmentSlots != null) ...[
                _buildSlotCard(context, size, appt.appointmentSlots!),
                SizedBox(height: size.customHeight(context) * 0.018),
              ],

              if (appt.expertUsers != null) ...[
                _buildExpertCard(context, size, appt.expertUsers!),
                SizedBox(height: size.customHeight(context) * 0.018),
              ],

              if (appt.isCancelled) ...[
                _buildCancellationCard(context, size, appt),
                SizedBox(height: size.customHeight(context) * 0.018),
              ],

              _buildRecordsSection(context, size, appt),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderBackground(
    BuildContext context,
    CustomSize size, {
    required String initials,
    required String childName,
    required String expertName,
    required String specialization,
    required String status,
    required _StatusMeta meta,
  }) {
    return Container(
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
            size.customHeight(context) * 0.07,
            size.customWidth(context) * 0.05,
            16,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Container(
                    width: 68,
                    height: 68,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: Colors.white.withOpacity(0.4), width: 2),
                    ),
                    child: Center(
                      child: Text(
                        initials.isNotEmpty ? initials : 'C',
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(width: size.customWidth(context) * 0.04),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          childName.isNotEmpty ? childName : 'Loading...',
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: size.customWidth(context) * 0.048,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 2),
                        if (expertName.isNotEmpty)
                          Text(
                            expertName,
                            style: GoogleFonts.poppins(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: size.customWidth(context) * 0.033),
                          ),
                        if (specialization.isNotEmpty)
                          Text(
                            specialization,
                            style: GoogleFonts.poppins(
                                color: Colors.white.withOpacity(0.75),
                                fontSize: size.customWidth(context) * 0.029),
                          ),
                        const SizedBox(height: 8),
                        if (status.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 5),
                            decoration: BoxDecoration(
                              color: meta.color.withOpacity(0.25),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: Colors.white.withOpacity(0.4)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(meta.icon,
                                    color: Colors.white, size: 13),
                                const SizedBox(width: 5),
                                Text(
                                  meta.label,
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Action buttons ─────────────────────────────────────────
  Widget _buildActionButtons(
      BuildContext context, CustomSize size, MyAppointmentItem appt) {
    final List<_ActionBtn> buttons = [];

    if (appt.isScheduled) {
      buttons.addAll([
        _ActionBtn(
          label: 'Confirm',
          icon: Icons.check_circle_outline_rounded,
          color: AppColors.primaryColor,
          onTap: () => _showConfirmDialog(context, appt.appointmentId),
        ),
        _ActionBtn(
          label: 'Cancel',
          icon: Icons.cancel_outlined,
          color: AppColors.errorColor,
          onTap: () => _showCancelDialog(context, appt.appointmentId),
        ),
        _ActionBtn(
          label: 'No Show',
          icon: Icons.person_off_outlined,
          color: AppColors.greyColor,
          onTap: () => _showNoShowDialog(context, appt.appointmentId),
        ),
      ]);
    } else if (appt.isConfirmed) {
      buttons.addAll([
        _ActionBtn(
          label: 'Complete',
          icon: Icons.task_alt_rounded,
          color: AppColors.successColor,
          onTap: () => _showCompleteDialog(context, size, appt),
        ),
        _ActionBtn(
          label: 'Cancel',
          icon: Icons.cancel_outlined,
          color: AppColors.errorColor,
          onTap: () => _showCancelDialog(context, appt.appointmentId),
        ),
        _ActionBtn(
          label: 'No Show',
          icon: Icons.person_off_outlined,
          color: AppColors.greyColor,
          onTap: () => _showNoShowDialog(context, appt.appointmentId),
        ),
      ]);
    }

    if (buttons.isEmpty) return const SizedBox.shrink();

    return Row(
      children: buttons.map((b) {
        return Expanded(
          child: GestureDetector(
            onTap: b.onTap,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: b.color.withOpacity(0.09),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: b.color.withOpacity(0.35)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(b.icon, color: b.color, size: 22),
                  const SizedBox(height: 5),
                  Text(
                    b.label,
                    style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: b.color),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // ── Info card ──────────────────────────────────────────────
  Widget _buildInfoCard(
      BuildContext context, CustomSize size, MyAppointmentItem appt) {
    return _card(
      context,
      size,
      title: 'Appointment Details',
      icon: Icons.event_note_rounded,
      iconColor: AppColors.primaryColor,
      children: [
        _row(context, size, 'Date', appt.formattedDate,
            Icons.calendar_today_outlined),
        _row(context, size, 'Time', appt.formattedTime,
            Icons.access_time_rounded),
        _row(context, size, 'Duration', '${appt.durationMinutes} minutes',
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
        if (appt.meetLink != null && appt.meetLink!.isNotEmpty)
          _row(context, size, 'Meet Link', appt.meetLink!, Icons.link_rounded),
      ],
    );
  }

  // ── Slot card ──────────────────────────────────────────────
  Widget _buildSlotCard(
      BuildContext context, CustomSize size, AppointmentSlot slot) {
    return _card(
      context,
      size,
      title: 'Slot Information',
      icon: Icons.calendar_month_rounded,
      iconColor: AppColors.secondaryColor,
      children: [
        _row(context, size, 'Date', slot.slotDate, Icons.today_rounded),
        _row(context, size, 'Time',
            '${slot.formattedStart} – ${slot.formattedEnd}',
            Icons.schedule_rounded),
        _row(
            context,
            size,
            'Mode',
            slot.mode.isNotEmpty
                ? slot.mode[0].toUpperCase() + slot.mode.substring(1)
                : slot.mode,
            _modeIcon(slot.mode)),
        if (slot.status != null)
          _row(context, size, 'Slot Status',
              slot.status![0].toUpperCase() + slot.status!.substring(1),
              Icons.info_outline_rounded),
      ],
    );
  }

  // ── Expert card ────────────────────────────────────────────
  Widget _buildExpertCard(
      BuildContext context, CustomSize size, AppointmentExpert expert) {
    return _card(
      context,
      size,
      title: 'Expert Information',
      icon: Icons.person_outline_rounded,
      iconColor: AppColors.accentColor,
      children: [
        _row(context, size, 'Name', expert.fullName, Icons.badge_outlined),
        _row(context, size, 'Specialization', expert.specialization,
            Icons.medical_information_outlined),
        if (expert.phone != null && expert.phone!.isNotEmpty)
          _row(context, size, 'Phone', expert.phone!, Icons.phone_outlined),
        if (expert.contactEmail != null && expert.contactEmail!.isNotEmpty)
          _row(context, size, 'Email', expert.contactEmail!,
              Icons.email_outlined),
      ],
    );
  }

  // ── Cancellation card ──────────────────────────────────────
  Widget _buildCancellationCard(
      BuildContext context, CustomSize size, MyAppointmentItem appt) {
    return Container(
      padding: EdgeInsets.all(size.customWidth(context) * 0.045),
      decoration: BoxDecoration(
        color: AppColors.errorColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.errorColor.withOpacity(0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                    color: AppColors.errorColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(9)),
                child: const Icon(Icons.cancel_outlined,
                    color: AppColors.errorColor, size: 17),
              ),
              const SizedBox(width: 10),
              Text('Cancellation Info',
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.errorColor)),
            ],
          ),
          const SizedBox(height: 14),
          if (appt.cancelledBy != null)
            _row(
                context,
                size,
                'Cancelled By',
                appt.cancelledBy![0].toUpperCase() +
                    appt.cancelledBy!.substring(1),
                Icons.person_outlined),
          if (appt.cancellationReason != null)
            _row(context, size, 'Reason', appt.cancellationReason!,
                Icons.info_outline_rounded),
          if (appt.cancelledAt != null)
            _row(context, size, 'Cancelled At',
                _formatDateTime(appt.cancelledAt!), Icons.schedule_rounded),
        ],
      ),
    );
  }

  // ── Records section ────────────────────────────────────────
  Widget _buildRecordsSection(
      BuildContext context, CustomSize size, MyAppointmentItem appt) {
    // Only show records section for completed appointments
    if (!appt.isCompleted) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 4,
                  height: 20,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(2)),
                ),
                const SizedBox(width: 10),
                Text(
                  'Session Records',
                  style: GoogleFonts.poppins(
                      fontSize: size.customWidth(context) * 0.042,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimaryColor),
                ),
              ],
            ),
            // "Add Note" button — always visible for completed appointments
            GestureDetector(
              onTap: () {
                _c.clearRecordForm();
                _openRecordSheet(context, size, appt.appointmentId);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.add_rounded,
                        color: Colors.white, size: 16),
                    const SizedBox(width: 4),
                    Text('Add Note',
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 12)),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: size.customHeight(context) * 0.015),

        Obx(() {
          if (_c.isLoadingRecords.value) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(30),
                child: CircularProgressIndicator(
                    color: AppColors.primaryColor, strokeWidth: 2),
              ),
            );
          }
          if (_c.records.isEmpty) {
            // Highlighted "missing notes" prompt for completed with no records
            return _buildMissingNotesHighlight(context, size, appt);
          }
          return Column(
            children: _c.records
                .map((r) => _buildRecordCard(context, size, r, appt))
                .toList(),
          );
        }),
      ],
    );
  }

  /// Prominent warning banner shown when a completed appointment has no notes
  Widget _buildMissingNotesHighlight(
      BuildContext context, CustomSize size, MyAppointmentItem appt) {
    return GestureDetector(
      onTap: () {
        _c.clearRecordForm();
        _openRecordSheet(context, size, appt.appointmentId);
      },
      child: Container(
        padding: EdgeInsets.all(size.customWidth(context) * 0.045),
        decoration: BoxDecoration(
          color: AppColors.warningColor.withOpacity(0.07),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
              color: AppColors.warningColor.withOpacity(0.5), width: 1.5),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: AppColors.warningColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.warning_amber_rounded,
                  color: AppColors.warningColor, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Session notes missing!',
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.warningColor),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Tap here to add session notes now.',
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: AppColors.warningColor.withOpacity(0.85)),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward_ios_rounded,
                size: 14, color: AppColors.warningColor),
          ],
        ),
      ),
    );
  }

  Widget _buildRecordCard(BuildContext context, CustomSize size,
      AppointmentRecordItem record, MyAppointmentItem appt) {
    return Container(
      margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.014),
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
      child: Padding(
        padding: EdgeInsets.all(size.customWidth(context) * 0.042),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(Icons.description_outlined,
                          color: AppColors.primaryColor, size: 18),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Session Note',
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimaryColor)),
                        Text(record.formattedDate,
                            style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: AppColors.textSecondaryColor)),
                      ],
                    ),
                  ],
                ),
                // Edit button always visible for completed appointments
                GestureDetector(
                  onTap: () {
                    _c.populateRecordForm(record);
                    _openRecordSheet(context, size, appt.appointmentId,
                        editingRecord: record);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                        color: AppColors.warningColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(9)),
                    child: const Icon(Icons.edit_outlined,
                        color: AppColors.warningColor, size: 16),
                  ),
                ),
              ],
            ),
            SizedBox(height: size.customHeight(context) * 0.012),
            Divider(height: 1, color: AppColors.greyColor.withOpacity(0.15)),
            SizedBox(height: size.customHeight(context) * 0.012),

            _recordField('Notes', record.notes, Icons.notes_rounded),
            SizedBox(height: size.customHeight(context) * 0.01),
            _recordField('Therapy Plan', record.therapyPlan,
                Icons.health_and_safety_outlined),
            SizedBox(height: size.customHeight(context) * 0.01),
            _recordField('Progress Feedback', record.progressFeedback,
                Icons.trending_up_rounded),
            if (record.medication != null &&
                record.medication!['name'] != null &&
                record.medication!['name'].toString().toLowerCase() !=
                    'none') ...[
              SizedBox(height: size.customHeight(context) * 0.01),
              _recordField(
                  'Medication',
                  '${record.medication!['name']}${record.medication!['dosage'] != null ? ' — ${record.medication!['dosage']}' : ''}',
                  Icons.medication_outlined),
            ],
          ],
        ),
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
              const SizedBox(height: 2),
              Text(value,
                  style: GoogleFonts.poppins(
                      fontSize: 13, color: AppColors.textPrimaryColor)),
            ],
          ),
        ),
      ],
    );
  }

  // ── Shared card widget ─────────────────────────────────────
  Widget _card(
    BuildContext context,
    CustomSize size, {
    required String title,
    required IconData icon,
    required Color iconColor,
    required List<Widget> children,
  }) {
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
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10)),
                child: Icon(icon, color: iconColor, size: 18),
              ),
              const SizedBox(width: 10),
              Text(title,
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimaryColor)),
            ],
          ),
          SizedBox(height: size.customHeight(context) * 0.014),
          Divider(height: 1, color: AppColors.greyColor.withOpacity(0.15)),
          SizedBox(height: size.customHeight(context) * 0.012),
          ...children,
        ],
      ),
    );
  }

  Widget _row(BuildContext context, CustomSize size, String label, String value,
      IconData icon) {
    return Padding(
      padding: EdgeInsets.only(bottom: size.customHeight(context) * 0.01),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 14, color: AppColors.textSecondaryColor),
          const SizedBox(width: 10),
          SizedBox(
            width: size.customWidth(context) * 0.26,
            child: Text(label,
                style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColors.textSecondaryColor,
                    fontWeight: FontWeight.w500)),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: AppColors.textPrimaryColor,
                  fontWeight: FontWeight.w500),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // ── Dialogs ────────────────────────────────────────────────

  /// NEW FLOW: Complete API first → then open notes sheet on success
  void _showCompleteDialog(
      BuildContext context, CustomSize size, MyAppointmentItem appt) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => _ActionDialog(
        title: 'Mark as Completed?',
        message:
            'This will complete the appointment. You will be asked to add session notes next.',
        confirmLabel: 'Yes, Complete',
        confirmColor: AppColors.successColor,
        icon: Icons.task_alt_rounded,
        onConfirm: () async {
          final ok = await _c.completeAppointment(appt.appointmentId);
          return ok;
        },
        onSuccess: () {
          // Dialog is already closed by _ActionDialog on success.
          // Now open the post-complete notes sheet.
          _openPostCompleteNotesSheet(context, size, appt.appointmentId);
        },
      ),
    );
  }

  /// Opens the mandatory notes sheet right after completing an appointment.
  void _openPostCompleteNotesSheet(
      BuildContext context, CustomSize size, String appointmentId) {
    _c.clearRecordForm();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (_) => ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.93),
        child: _PostCompleteNotesSheet(
          controller: _c,
          size: size,
          appointmentId: appointmentId,
          onDone: () {
            _c.pendingTabIndex.value = 3; // jump to Completed tab
            Navigator.pop(context); // close sheet
            Get.back();             // go back to list
          },
        ),
      ),
    );
  }

  void _showConfirmDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => _ActionDialog(
        title: 'Confirm Appointment?',
        message: 'This will confirm the appointment for the patient.',
        confirmLabel: 'Yes, Confirm',
        confirmColor: AppColors.primaryColor,
        icon: Icons.check_circle_outline_rounded,
        onConfirm: () async {
          final ok = await _c.confirmAppointment(id);
          return ok;
        },
        onSuccess: () {
          _c.pendingTabIndex.value = 2; // jump to Confirmed tab
          Navigator.pop(context);
          Get.back();
        },
      ),
    );
  }

  void _showCancelDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => _CancelDialog(
        id: id,
        controller: _c,
        onCancelled: () {
          _c.pendingTabIndex.value = 4; // jump to Cancelled tab
          Navigator.pop(context);
          Get.back();
        },
      ),
    );
  }

  void _showNoShowDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => _ActionDialog(
        title: 'Mark as No Show?',
        message: 'Patient did not attend the session. Mark as no-show?',
        confirmLabel: 'Mark No Show',
        confirmColor: AppColors.greyColor,
        icon: Icons.person_off_outlined,
        onConfirm: () async {
          final ok = await _c.markNoShow(id);
          return ok;
        },
        onSuccess: () {
          _c.pendingTabIndex.value = 5; // jump to No Show tab
          Navigator.pop(context);
          Get.back();
        },
      ),
    );
  }

  void _openRecordSheet(BuildContext context, CustomSize size,
      String appointmentId,
      {AppointmentRecordItem? editingRecord}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.93),
        child: _RecordFormSheet(
          controller: _c,
          size: size,
          appointmentId: appointmentId,
          editingRecord: editingRecord,
          onSaved: () {},
        ),
      ),
    );
  }

  // ── Helpers ────────────────────────────────────────────────
  Widget _buildError() {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: AppColors.textPrimaryColor),
            onPressed: () => Get.back(),
          )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline_rounded,
                size: 60, color: AppColors.errorColor),
            const SizedBox(height: 16),
            Text('Appointment not found',
                style: GoogleFonts.poppins(
                    fontSize: 16, color: AppColors.textPrimaryColor)),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => Get.back(),
              child: Text('Go Back',
                  style: GoogleFonts.poppins(color: AppColors.primaryColor)),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDateTime(String raw) {
    try {
      final dt = DateTime.parse(raw).toLocal();
      const months = [
        '',
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
      ];
      int h = dt.hour;
      final m = dt.minute.toString().padLeft(2, '0');
      final ampm = h >= 12 ? 'PM' : 'AM';
      if (h > 12) h -= 12;
      if (h == 0) h = 12;
      return '${dt.day} ${months[dt.month]} ${dt.year}, $h:$m $ampm';
    } catch (_) {
      return raw;
    }
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

// ── Data classes ───────────────────────────────────────────────
class _StatusMeta {
  final Color color;
  final String label;
  final IconData icon;
  _StatusMeta(this.color, this.label, this.icon);
}

class _ActionBtn {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  _ActionBtn(
      {required this.label,
      required this.icon,
      required this.color,
      required this.onTap});
}

// ══════════════════════════════════════════════════════════════
// Generic action confirm dialog
// ══════════════════════════════════════════════════════════════
class _ActionDialog extends StatefulWidget {
  final String title;
  final String message;
  final String confirmLabel;
  final Color confirmColor;
  final IconData icon;
  final Future<bool> Function() onConfirm;
  /// Called after dialog is popped on success — use this to open next sheet
  final VoidCallback? onSuccess;

  const _ActionDialog({
    required this.title,
    required this.message,
    required this.confirmLabel,
    required this.confirmColor,
    required this.icon,
    required this.onConfirm,
    this.onSuccess,
  });

  @override
  State<_ActionDialog> createState() => _ActionDialogState();
}

class _ActionDialogState extends State<_ActionDialog> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      contentPadding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: widget.confirmColor.withOpacity(0.1),
                shape: BoxShape.circle),
            child: Icon(widget.icon, color: widget.confirmColor, size: 34),
          ),
          const SizedBox(height: 16),
          Text(widget.title,
              style: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryColor),
              textAlign: TextAlign.center),
          const SizedBox(height: 8),
          Text(widget.message,
              style: GoogleFonts.poppins(
                  fontSize: 13, color: AppColors.textSecondaryColor),
              textAlign: TextAlign.center),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed:
                      _loading ? null : () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textSecondaryColor,
                    side: BorderSide(
                        color: AppColors.greyColor.withOpacity(0.5)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 13),
                  ),
                  child: Text('Cancel',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, fontSize: 13)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: _loading
                      ? null
                      : () async {
                          setState(() => _loading = true);
                          final ok = await widget.onConfirm();
                          if (!mounted) return;
                          setState(() => _loading = false);
                          if (ok) {
                            Navigator.pop(context);
                            // Fire onSuccess after dialog is off the stack
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              widget.onSuccess?.call();
                            });
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.confirmColor,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor:
                        widget.confirmColor.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    elevation: 0,
                  ),
                  child: _loading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2))
                      : Text(widget.confirmLabel,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600, fontSize: 13)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
// Cancel dialog with reason input
// ══════════════════════════════════════════════════════════════
class _CancelDialog extends StatefulWidget {
  final String id;
  final MyAppointmentController controller;
  final VoidCallback? onCancelled;

  const _CancelDialog({
    required this.id,
    required this.controller,
    this.onCancelled,
  });

  @override
  State<_CancelDialog> createState() => _CancelDialogState();
}

class _CancelDialogState extends State<_CancelDialog> {
  final _reasonCtrl = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _reasonCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      contentPadding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: AppColors.errorColor.withOpacity(0.1),
                shape: BoxShape.circle),
            child: const Icon(Icons.cancel_outlined,
                color: AppColors.errorColor, size: 34),
          ),
          const SizedBox(height: 16),
          Text('Cancel Appointment',
              style: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryColor),
              textAlign: TextAlign.center),
          const SizedBox(height: 6),
          Text('Please provide a cancellation reason.',
              style: GoogleFonts.poppins(
                  fontSize: 13, color: AppColors.textSecondaryColor),
              textAlign: TextAlign.center),
          const SizedBox(height: 18),
          TextField(
            controller: _reasonCtrl,
            maxLines: 3,
            style: GoogleFonts.poppins(
                fontSize: 13, color: AppColors.textPrimaryColor),
            decoration: InputDecoration(
              hintText: 'Enter reason here...',
              hintStyle: GoogleFonts.poppins(
                  fontSize: 13,
                  color: AppColors.textSecondaryColor.withOpacity(0.6)),
              filled: true,
              fillColor: AppColors.lightGreyColor,
              contentPadding: const EdgeInsets.all(14),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                      color: AppColors.greyColor.withOpacity(0.25))),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                      color: AppColors.primaryColor, width: 1.5)),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed:
                      _loading ? null : () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textSecondaryColor,
                    side: BorderSide(
                        color: AppColors.greyColor.withOpacity(0.5)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 13),
                  ),
                  child: Text('Back',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, fontSize: 13)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: _loading
                      ? null
                      : () async {
                          final reason = _reasonCtrl.text.trim();
                          if (reason.isEmpty) {
                            Get.snackbar(
                              'Required',
                              'Please enter a cancellation reason',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppColors.warningColor,
                              colorText: Colors.white,
                              margin: const EdgeInsets.all(16),
                              borderRadius: 12,
                            );
                            return;
                          }
                          setState(() => _loading = true);
                          final ok = await widget.controller
                              .cancelAppointment(widget.id, reason);
                          if (mounted) setState(() => _loading = false);
                          if (ok) {
                            widget.onCancelled?.call();
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.errorColor,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor:
                        AppColors.errorColor.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    elevation: 0,
                  ),
                  child: _loading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2))
                      : Text('Cancel Appt.',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600, fontSize: 13)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
// Post-complete notes sheet
// Shown automatically right after completing an appointment.
// isDismissible=false / enableDrag=false so it can't be swiped away.
// Has a "Skip for now" text button as a deliberate escape hatch.
// ══════════════════════════════════════════════════════════════
class _PostCompleteNotesSheet extends StatefulWidget {
  final MyAppointmentController controller;
  final CustomSize size;
  final String appointmentId;
  final VoidCallback? onDone;

  const _PostCompleteNotesSheet({
    required this.controller,
    required this.size,
    required this.appointmentId,
    this.onDone,
  });

  @override
  State<_PostCompleteNotesSheet> createState() =>
      _PostCompleteNotesSheetState();
}

class _PostCompleteNotesSheetState extends State<_PostCompleteNotesSheet> {
  final _formKey = GlobalKey<FormState>();
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    final size = widget.size;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(
          size.customWidth(context) * 0.05,
          20,
          size.customWidth(context) * 0.05,
          size.customHeight(context) * 0.04,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 44,
                  height: 4,
                  decoration: BoxDecoration(
                      color: AppColors.greyColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(2)),
                ),
              ),
              const SizedBox(height: 20),

              // ── Success header ──────────────────────────────
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.successColor.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: AppColors.successColor.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: AppColors.successColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12)),
                      child: const Icon(Icons.task_alt_rounded,
                          color: AppColors.successColor, size: 24),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Appointment Completed!',
                            style: GoogleFonts.poppins(
                                fontSize: size.customWidth(context) * 0.04,
                                fontWeight: FontWeight.bold,
                                color: AppColors.successColor),
                          ),
                          Text(
                            'Please add session notes below.',
                            style: GoogleFonts.poppins(
                                fontSize: size.customWidth(context) * 0.03,
                                color:
                                    AppColors.successColor.withOpacity(0.8)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.customHeight(context) * 0.018),

              // ── Fields ──────────────────────────────────────
              _field(context, size, 'Session Notes *',
                  'What happened during the session?',
                  Icons.notes_rounded, widget.controller.notesCtrl,
                  maxLines: 3, required: true),
              SizedBox(height: size.customHeight(context) * 0.016),

              _field(context, size, 'Therapy Plan *',
                  'Plan for upcoming sessions...',
                  Icons.health_and_safety_outlined,
                  widget.controller.therapyPlanCtrl,
                  maxLines: 3, required: true),
              SizedBox(height: size.customHeight(context) * 0.016),

              _field(context, size, 'Progress Feedback *',
                  'How did the patient progress?',
                  Icons.trending_up_rounded,
                  widget.controller.progressFeedbackCtrl,
                  maxLines: 2, required: true),
              SizedBox(height: size.customHeight(context) * 0.016),

              Text('Medication (optional)',
                  style: GoogleFonts.poppins(
                      fontSize: size.customWidth(context) * 0.034,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimaryColor)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _field(context, size, 'Name', 'e.g. None',
                        Icons.medication_outlined,
                        widget.controller.medicationNameCtrl,
                        maxLines: 1, required: false),
                  ),
                  SizedBox(width: size.customWidth(context) * 0.03),
                  Expanded(
                    child: _field(context, size, 'Dosage', 'e.g. 5mg',
                        Icons.science_outlined,
                        widget.controller.medicationDosageCtrl,
                        maxLines: 1, required: false),
                  ),
                ],
              ),
              SizedBox(height: size.customHeight(context) * 0.028),

              // ── Save button ─────────────────────────────────
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _saving
                      ? null
                      : () async {
                          if (!_formKey.currentState!.validate()) return;
                          setState(() => _saving = true);
                          final ok = await widget.controller
                              .createRecord(widget.appointmentId);
                          if (mounted) setState(() => _saving = false);
                          if (ok) {
                            widget.onDone?.call();
                          }
                        },
                  icon: _saving
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2))
                      : const Icon(Icons.save_rounded, size: 20),
                  label: Text(
                    _saving ? 'Saving...' : 'Save Session Notes',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: size.customWidth(context) * 0.038),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.successColor,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor:
                        AppColors.successColor.withOpacity(0.4),
                    padding: EdgeInsets.symmetric(
                        vertical: size.customHeight(context) * 0.02),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    elevation: 2,
                  ),
                ),
              ),
              SizedBox(height: size.customHeight(context) * 0.008),

              // ── Deliberate skip option ──────────────────────
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: _saving
                      ? null
                      : () {
                          widget.onDone?.call();
                        },
                  child: Text(
                    'Skip for now (add later from session records)',
                    style: GoogleFonts.poppins(
                        color: AppColors.textSecondaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(
    BuildContext context,
    CustomSize size,
    String label,
    String hint,
    IconData icon,
    TextEditingController ctrl, {
    int maxLines = 1,
    bool required = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.poppins(
                fontSize: size.customWidth(context) * 0.033,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimaryColor)),
        const SizedBox(height: 6),
        TextFormField(
          controller: ctrl,
          maxLines: maxLines,
          validator: required
              ? (v) => (v == null || v.trim().isEmpty)
                  ? '$label is required'
                  : null
              : null,
          style: GoogleFonts.poppins(
              fontSize: 13, color: AppColors.textPrimaryColor),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.poppins(
                fontSize: 13,
                color: AppColors.textSecondaryColor.withOpacity(0.6)),
            prefixIcon: maxLines == 1
                ? Icon(icon, color: AppColors.primaryColor, size: 19)
                : null,
            filled: true,
            fillColor: AppColors.lightGreyColor,
            contentPadding: EdgeInsets.symmetric(
                horizontal: 16, vertical: maxLines > 1 ? 14 : 0),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide:
                    BorderSide(color: AppColors.greyColor.withOpacity(0.2))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(
                    color: AppColors.primaryColor, width: 1.5)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(
                    color: AppColors.errorColor, width: 1)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(
                    color: AppColors.errorColor, width: 1.5)),
          ),
        ),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════
// Record form sheet (Add / Edit for completed appointments)
// ══════════════════════════════════════════════════════════════
class _RecordFormSheet extends StatefulWidget {
  final MyAppointmentController controller;
  final CustomSize size;
  final String appointmentId;
  final AppointmentRecordItem? editingRecord;
  final VoidCallback? onSaved;

  const _RecordFormSheet({
    required this.controller,
    required this.size,
    required this.appointmentId,
    this.editingRecord,
    this.onSaved,
  });

  @override
  State<_RecordFormSheet> createState() => _RecordFormSheetState();
}

class _RecordFormSheetState extends State<_RecordFormSheet> {
  final _formKey = GlobalKey<FormState>();
  bool _saving = false;

  bool get _isEdit => widget.editingRecord != null;

  @override
  Widget build(BuildContext context) {
    final size = widget.size;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(
          size.customWidth(context) * 0.05,
          20,
          size.customWidth(context) * 0.05,
          size.customHeight(context) * 0.04,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 44,
                  height: 4,
                  decoration: BoxDecoration(
                      color: AppColors.greyColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(2)),
                ),
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12)),
                    child: Icon(
                      _isEdit
                          ? Icons.edit_note_rounded
                          : Icons.note_add_rounded,
                      color: AppColors.primaryColor,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _isEdit
                              ? 'Update Session Record'
                              : 'New Session Record',
                          style: GoogleFonts.poppins(
                              fontSize: size.customWidth(context) * 0.042,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimaryColor),
                        ),
                        Text(
                          _isEdit
                              ? 'Edit session details'
                              : 'Document this session',
                          style: GoogleFonts.poppins(
                              fontSize: size.customWidth(context) * 0.031,
                              color: AppColors.textSecondaryColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.customHeight(context) * 0.022),

              _field(context, size, 'Session Notes *',
                  'Describe what happened during the session...',
                  Icons.notes_rounded, widget.controller.notesCtrl,
                  maxLines: 3, required: true),
              SizedBox(height: size.customHeight(context) * 0.016),

              _field(context, size, 'Therapy Plan *',
                  'Outline the plan for next sessions...',
                  Icons.health_and_safety_outlined,
                  widget.controller.therapyPlanCtrl,
                  maxLines: 3, required: true),
              SizedBox(height: size.customHeight(context) * 0.016),

              _field(context, size, 'Progress Feedback *',
                  'How did the patient progress?',
                  Icons.trending_up_rounded,
                  widget.controller.progressFeedbackCtrl,
                  maxLines: 2, required: true),
              SizedBox(height: size.customHeight(context) * 0.016),

              Text('Medication (optional)',
                  style: GoogleFonts.poppins(
                      fontSize: size.customWidth(context) * 0.034,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimaryColor)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _field(context, size, 'Name', 'e.g. None',
                        Icons.medication_outlined,
                        widget.controller.medicationNameCtrl,
                        maxLines: 1, required: false),
                  ),
                  SizedBox(width: size.customWidth(context) * 0.03),
                  Expanded(
                    child: _field(context, size, 'Dosage', 'e.g. 5mg',
                        Icons.science_outlined,
                        widget.controller.medicationDosageCtrl,
                        maxLines: 1, required: false),
                  ),
                ],
              ),
              SizedBox(height: size.customHeight(context) * 0.028),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saving
                      ? null
                      : () async {
                          if (!_formKey.currentState!.validate()) return;
                          setState(() => _saving = true);
                          bool ok;
                          if (_isEdit) {
                            ok = await widget.controller.updateRecord(
                              widget.appointmentId,
                              widget.editingRecord!.recordId,
                            );
                          } else {
                            ok = await widget.controller
                                .createRecord(widget.appointmentId);
                          }
                          if (mounted) setState(() => _saving = false);
                          if (ok && context.mounted) {
                            widget.onSaved?.call();
                            Navigator.pop(context);
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor:
                        AppColors.primaryColor.withOpacity(0.4),
                    padding: EdgeInsets.symmetric(
                        vertical: size.customHeight(context) * 0.02),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    elevation: 2,
                  ),
                  child: _saving
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2.5))
                      : Text(
                          _isEdit ? 'Update Record' : 'Save Record',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: size.customWidth(context) * 0.038),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(
    BuildContext context,
    CustomSize size,
    String label,
    String hint,
    IconData icon,
    TextEditingController ctrl, {
    int maxLines = 1,
    bool required = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.poppins(
                fontSize: size.customWidth(context) * 0.033,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimaryColor)),
        const SizedBox(height: 6),
        TextFormField(
          controller: ctrl,
          maxLines: maxLines,
          validator: required
              ? (v) => (v == null || v.trim().isEmpty)
                  ? '$label is required'
                  : null
              : null,
          style: GoogleFonts.poppins(
              fontSize: 13, color: AppColors.textPrimaryColor),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.poppins(
                fontSize: 13,
                color: AppColors.textSecondaryColor.withOpacity(0.6)),
            prefixIcon: maxLines == 1
                ? Icon(icon, color: AppColors.primaryColor, size: 19)
                : null,
            filled: true,
            fillColor: AppColors.lightGreyColor,
            contentPadding: EdgeInsets.symmetric(
                horizontal: 16, vertical: maxLines > 1 ? 14 : 0),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide:
                    BorderSide(color: AppColors.greyColor.withOpacity(0.2))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(
                    color: AppColors.primaryColor, width: 1.5)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(
                    color: AppColors.errorColor, width: 1)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(
                    color: AppColors.errorColor, width: 1.5)),
          ),
        ),
      ],
    );
  }
}