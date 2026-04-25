// // lib/view/parent/booking/expert_slots_booking_screen.dart
// //
// // Navigated from ExpertDetailScreen with args:
// //   {'expertId': String, 'expertName': String, 'childId': String, 'childName': String}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/parent_booking_controller.dart';
// import 'package:speechspectrum/models/parent_booking_model.dart';
// import 'package:speechspectrum/routes/app_routes.dart';

// class ExpertSlotsBookingScreen extends StatefulWidget {
//   const ExpertSlotsBookingScreen({super.key});

//   @override
//   State<ExpertSlotsBookingScreen> createState() =>
//       _ExpertSlotsBookingScreenState();
// }

// class _ExpertSlotsBookingScreenState extends State<ExpertSlotsBookingScreen> {
//   late final ParentBookingController _c;
//   late final String expertId;
//   late final String expertName;
//   late final String childId;
//   late final String childName;

//   @override
//   void initState() {
//     super.initState();
//     _c = Get.isRegistered<ParentBookingController>()
//         ? Get.find<ParentBookingController>()
//         : Get.put(ParentBookingController());

//     final args = Get.arguments as Map<String, dynamic>;
//     expertId = args['expertId'] ?? '';
//     expertName = args['expertName'] ?? 'Expert';
//     childId = args['childId'] ?? '';
//     childName = args['childName'] ?? 'Child';

//     _c.clearSelection();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _c.fetchExpertSlots(expertId);
//     });
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
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Book Appointment',
//                 style: GoogleFonts.poppins(
//                     color: AppColors.textPrimaryColor,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600)),
//             Text(expertName,
//                 style: GoogleFonts.poppins(
//                     color: AppColors.textSecondaryColor, fontSize: 12)),
//           ],
//         ),
//         actions: [
//           Obx(() => _c.isLoadingSlots.value
//               ? const Padding(
//                   padding: EdgeInsets.all(14),
//                   child: SizedBox(
//                       width: 20,
//                       height: 20,
//                       child: CircularProgressIndicator(
//                           color: AppColors.primaryColor, strokeWidth: 2)))
//               : IconButton(
//                   icon: const Icon(Icons.refresh_rounded,
//                       color: AppColors.primaryColor),
//                   onPressed: () => _c.fetchExpertSlots(expertId))),
//           const SizedBox(width: 4),
//         ],
//       ),
//       body: Obx(() {
//         if (_c.isLoadingSlots.value && _c.expertSlots.isEmpty) {
//           return _loader(context, size);
//         }
//         if (_c.expertSlots.isEmpty) return _empty(context, size);

//         return RefreshIndicator(
//           color: AppColors.primaryColor,
//           onRefresh: () => _c.fetchExpertSlots(expertId),
//           child: ListView(
//             physics: const BouncingScrollPhysics(
//                 parent: AlwaysScrollableScrollPhysics()),
//             padding: EdgeInsets.fromLTRB(
//               size.customWidth(context) * 0.045,
//               size.customHeight(context) * 0.02,
//               size.customWidth(context) * 0.045,
//               size.customHeight(context) * 0.12,
//             ),
//             children: [
//               // Child info banner
//               _childBanner(context, size),
//               SizedBox(height: size.customHeight(context) * 0.022),

//               // Availability header
//               _sectionTitle(context, size, 'Available Slots',
//                   '${_c.availableSlots.length} slot${_c.availableSlots.length != 1 ? 's' : ''} available'),
//               SizedBox(height: size.customHeight(context) * 0.016),

//               // Slots grouped by day
//               ..._buildDayGroups(context, size),
//             ],
//           ),
//         );
//       }),

//       // Book button
//       bottomNavigationBar: Obx(() {
//         final slot = _c.selectedSlot.value;
//         if (slot == null) return const SizedBox.shrink();
//         return _buildBookingBar(context, size, slot);
//       }),
//     );
//   }

//   Widget _childBanner(BuildContext context, CustomSize size) {
//     return Container(
//       padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [AppColors.primaryColor, AppColors.secondaryColor],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(18),
//         boxShadow: [
//           BoxShadow(
//               color: AppColors.primaryColor.withOpacity(0.25),
//               blurRadius: 14,
//               offset: const Offset(0, 4))
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 48,
//             height: 48,
//             decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(14)),
//             child: Center(
//               child: Text(
//                 childName.isNotEmpty ? childName[0].toUpperCase() : 'C',
//                 style: GoogleFonts.poppins(
//                     color: Colors.white,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//           SizedBox(width: size.customWidth(context) * 0.035),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Booking for',
//                     style: GoogleFonts.poppins(
//                         color: Colors.white.withOpacity(0.8), fontSize: 12)),
//                 Text(childName,
//                     style: GoogleFonts.poppins(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis),
//               ],
//             ),
//           ),
//           const Icon(Icons.child_care_rounded, color: Colors.white, size: 24),
//         ],
//       ),
//     );
//   }

//   List<Widget> _buildDayGroups(BuildContext context, CustomSize size) {
//     final byDay = _c.slotsByDay;
//     if (byDay.isEmpty) return [];

//     const dayOrder = [
//       'Monday', 'Tuesday', 'Wednesday', 'Thursday',
//       'Friday', 'Saturday', 'Sunday'
//     ];

//     final widgets = <Widget>[];
//     for (final day in dayOrder) {
//       final slots = byDay[day];
//       if (slots == null || slots.isEmpty) continue;

//       widgets.add(
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Day header
//             _dayHeader(context, size, day, slots.length),
//             SizedBox(height: size.customHeight(context) * 0.01),
//             ...slots.map((s) => _slotCard(context, size, s)).toList(),
//             SizedBox(height: size.customHeight(context) * 0.015),
//           ],
//         ),
//       );
//     }
//     return widgets;
//   }

//   Widget _dayHeader(
//       BuildContext context, CustomSize size, String day, int count) {
//     return Row(
//       children: [
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//           decoration: BoxDecoration(
//             color: AppColors.primaryColor.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(10),
//             border: Border.all(
//                 color: AppColors.primaryColor.withOpacity(0.3), width: 1),
//           ),
//           child: Text(day,
//               style: GoogleFonts.poppins(
//                   fontSize: 13,
//                   fontWeight: FontWeight.w600,
//                   color: AppColors.primaryColor)),
//         ),
//         const SizedBox(width: 8),
//         Text('$count slot${count != 1 ? 's' : ''}',
//             style: GoogleFonts.poppins(
//                 fontSize: 12, color: AppColors.textSecondaryColor)),
//       ],
//     );
//   }

//   Widget _slotCard(
//       BuildContext context, CustomSize size, ExpertSlotItem slot) {
//     return Obx(() {
//       final isSelected = _c.selectedSlot.value?.slotId == slot.slotId;
//       final isAvail = slot.isAvailable;

//       return GestureDetector(
//         onTap: isAvail ? () => _c.selectSlot(slot) : null,
//         child: Container(
//           margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.012),
//           decoration: BoxDecoration(
//             color: isSelected
//                 ? AppColors.primaryColor.withOpacity(0.05)
//                 : AppColors.whiteColor,
//             borderRadius: BorderRadius.circular(18),
//             border: Border.all(
//               color: isSelected
//                   ? AppColors.primaryColor
//                   : isAvail
//                       ? AppColors.greyColor.withOpacity(0.2)
//                       : AppColors.greyColor.withOpacity(0.1),
//               width: isSelected ? 2 : 1,
//             ),
//             boxShadow: [
//               BoxShadow(
//                   color: Colors.black.withOpacity(isSelected ? 0.08 : 0.04),
//                   blurRadius: isSelected ? 12 : 8,
//                   offset: const Offset(0, 3))
//             ],
//           ),
//           child: Padding(
//             padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//             child: Row(
//               children: [
//                 // Date badge
//                 Container(
//                   width: 52,
//                   height: 58,
//                   decoration: BoxDecoration(
//                     color: isSelected
//                         ? AppColors.primaryColor
//                         : AppColors.primaryColor.withOpacity(0.08),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(slot.dayOfWeek,
//                           style: GoogleFonts.poppins(
//                               fontSize: 10,
//                               color: isSelected
//                                   ? Colors.white
//                                   : AppColors.primaryColor,
//                               fontWeight: FontWeight.w600)),
//                       Text(
//                         slot.slotDate.split('-').length > 2
//                             ? slot.slotDate.split('-')[2]
//                             : '',
//                         style: GoogleFonts.poppins(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: isSelected
//                                 ? Colors.white
//                                 : AppColors.primaryColor),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(width: size.customWidth(context) * 0.03),

//                 // Slot info
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Time
//                       Row(
//                         children: [
//                           Icon(Icons.access_time_rounded,
//                               size: 13,
//                               color: isSelected
//                                   ? AppColors.primaryColor
//                                   : AppColors.textSecondaryColor),
//                           const SizedBox(width: 4),
//                           Text(
//                             '${slot.formattedStartTime} – ${slot.formattedEndTime}',
//                             style: GoogleFonts.poppins(
//                                 fontSize: size.customWidth(context) * 0.036,
//                                 fontWeight: FontWeight.w600,
//                                 color: AppColors.textPrimaryColor),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: size.customHeight(context) * 0.005),

//                       // Mode & fees
//                       Wrap(
//                         spacing: 8,
//                         runSpacing: 4,
//                         children: [
//                           _chip(
//                               _modeIcon(slot.mode),
//                               slot.mode[0].toUpperCase() +
//                                   slot.mode.substring(1),
//                               AppColors.primaryColor),
//                           if (slot.feeOnline != null)
//                             _chip(Icons.videocam_outlined,
//                                 '${slot.currency} ${slot.feeOnline!.toStringAsFixed(0)}',
//                                 AppColors.accentColor),
//                           if (slot.feePhysical != null)
//                             _chip(Icons.location_on_outlined,
//                                 '${slot.currency} ${slot.feePhysical!.toStringAsFixed(0)}',
//                                 AppColors.warningColor),
//                         ],
//                       ),

//                       // Recurrence
//                       if (slot.isRecurring && slot.recurrenceRule != null) ...[
//                         SizedBox(height: size.customHeight(context) * 0.004),
//                         Row(
//                           children: [
//                             Icon(Icons.repeat_rounded,
//                                 size: 11,
//                                 color: AppColors.primaryColor.withOpacity(0.6)),
//                             const SizedBox(width: 3),
//                             Expanded(
//                               child: Text(slot.recurrenceRule!,
//                                   style: GoogleFonts.poppins(
//                                       fontSize: 11,
//                                       color: AppColors.primaryColor
//                                           .withOpacity(0.6)),
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis),
//                             ),
//                           ],
//                         ),
//                       ],

//                       // Location
//                       if (slot.expertLocations != null) ...[
//                         SizedBox(height: size.customHeight(context) * 0.004),
//                         Row(children: [
//                           const Icon(Icons.business_rounded,
//                               size: 11,
//                               color: AppColors.textSecondaryColor),
//                           const SizedBox(width: 3),
//                           Expanded(
//                             child: Text(
//                                 '${slot.expertLocations!.label}, ${slot.expertLocations!.city}',
//                                 style: GoogleFonts.poppins(
//                                     fontSize: 11,
//                                     color: AppColors.textSecondaryColor),
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis),
//                           ),
//                         ]),
//                       ],
//                     ],
//                   ),
//                 ),

//                 // Right: status + selection indicator
//                 Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 8, vertical: 4),
//                       decoration: BoxDecoration(
//                         color: isAvail
//                             ? AppColors.successColor.withOpacity(0.1)
//                             : AppColors.greyColor.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Text(
//                         isAvail ? 'Open' : slot.status,
//                         style: GoogleFonts.poppins(
//                             fontSize: 10,
//                             fontWeight: FontWeight.w600,
//                             color: isAvail
//                                 ? AppColors.successColor
//                                 : AppColors.greyColor),
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     if (isAvail)
//                       Icon(
//                         isSelected
//                             ? Icons.check_circle_rounded
//                             : Icons.radio_button_unchecked_rounded,
//                         color: isSelected
//                             ? AppColors.primaryColor
//                             : AppColors.greyColor,
//                         size: 22,
//                       ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     });
//   }

//   Widget _chip(IconData icon, String label, Color color) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Icon(icon, size: 11, color: color),
//         const SizedBox(width: 3),
//         Text(label,
//             style: GoogleFonts.poppins(
//                 fontSize: 11,
//                 color: AppColors.textSecondaryColor,
//                 fontWeight: FontWeight.w500)),
//       ],
//     );
//   }

//   Widget _buildBookingBar(
//       BuildContext context, CustomSize size, ExpertSlotItem slot) {
//     return Container(
//       padding: EdgeInsets.fromLTRB(
//         size.customWidth(context) * 0.05,
//         16,
//         size.customWidth(context) * 0.05,
//         MediaQuery.of(context).padding.bottom + 16,
//       ),
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withOpacity(0.08),
//               blurRadius: 16,
//               offset: const Offset(0, -4))
//         ],
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // Mode selector (only for 'both' slots)
//           if (slot.mode == 'both') ...[
//             Row(
//               children: [
//                 Text('Mode:',
//                     style: GoogleFonts.poppins(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w500,
//                         color: AppColors.textPrimaryColor)),
//                 const SizedBox(width: 12),
//                 Obx(() => _modeBtn('online', Icons.videocam_outlined,
//                     'Online', AppColors.accentColor)),
//                 const SizedBox(width: 8),
//                 Obx(() => _modeBtn('physical', Icons.location_on_outlined,
//                     'Physical', AppColors.warningColor)),
//               ],
//             ),
//             const SizedBox(height: 12),
//           ],

//           // Fee display
//           Obx(() {
//             final fee = slot.feeFor(
//                 slot.mode == 'both' ? _c.selectedMode.value : slot.mode);
//             return Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       '${slot.formattedDate}  •  ${slot.formattedStartTime}',
//                       style: GoogleFonts.poppins(
//                           fontSize: 12,
//                           color: AppColors.textSecondaryColor),
//                     ),
//                     if (fee != null)
//                       Text(
//                         '${slot.currency} ${fee.toStringAsFixed(0)}',
//                         style: GoogleFonts.poppins(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: AppColors.primaryColor),
//                       ),
//                   ],
//                 ),
//                 Obx(() => ElevatedButton(
//                       onPressed: _c.isBooking.value
//                           ? null
//                           : () => _showConfirmBooking(context, size, slot),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.primaryColor,
//                         foregroundColor: Colors.white,
//                         disabledBackgroundColor:
//                             AppColors.primaryColor.withOpacity(0.5),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(14)),
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 28, vertical: 14),
//                         elevation: 0,
//                       ),
//                       child: _c.isBooking.value
//                           ? const SizedBox(
//                               width: 20,
//                               height: 20,
//                               child: CircularProgressIndicator(
//                                   color: Colors.white, strokeWidth: 2))
//                           : Text('Book Now',
//                               style: GoogleFonts.poppins(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 14)),
//                     )),
//               ],
//             );
//           }),
//         ],
//       ),
//     );
//   }

//   Widget _modeBtn(
//       String value, IconData icon, String label, Color color) {
//     final selected = _c.selectedMode.value == value;
//     return GestureDetector(
//       onTap: () => _c.setMode(value),
//       child: Container(
//         padding:
//             const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
//         decoration: BoxDecoration(
//           color: selected ? color : color.withOpacity(0.08),
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(
//               color: selected ? color : color.withOpacity(0.3),
//               width: 1),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(icon,
//                 color: selected ? Colors.white : color, size: 15),
//             const SizedBox(width: 4),
//             Text(label,
//                 style: GoogleFonts.poppins(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w600,
//                     color: selected ? Colors.white : color)),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showConfirmBooking(
//       BuildContext context, CustomSize size, ExpertSlotItem slot) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (_) => _BookingConfirmDialog(
//         slot: slot,
//         childName: childName,
//         childId: childId,
//         mode: _c.selectedMode.value,
//         controller: _c,
//       ),
//     );
//   }

//   Widget _sectionTitle(
//       BuildContext context, CustomSize size, String title, String sub) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Row(
//           children: [
//             Container(
//               width: 4,
//               height: 20,
//               decoration: BoxDecoration(
//                   color: AppColors.primaryColor,
//                   borderRadius: BorderRadius.circular(2)),
//             ),
//             const SizedBox(width: 10),
//             Text(title,
//                 style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.042,
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.textPrimaryColor)),
//           ],
//         ),
//         Text(sub,
//             style: GoogleFonts.poppins(
//                 fontSize: 12, color: AppColors.textSecondaryColor)),
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
//           Text('Loading availability...',
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
//           Text('No slots available',
//               style: GoogleFonts.poppins(
//                   fontSize: size.customWidth(context) * 0.046,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.textPrimaryColor)),
//           SizedBox(height: size.customHeight(context) * 0.01),
//           Text('This expert has no open slots yet.',
//               style: GoogleFonts.poppins(
//                   fontSize: size.customWidth(context) * 0.034,
//                   color: AppColors.textSecondaryColor)),
//         ],
//       ),
//     );
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

// // ── Booking Confirm Dialog ──────────────────────────────────────
// class _BookingConfirmDialog extends StatefulWidget {
//   final ExpertSlotItem slot;
//   final String childName;
//   final String childId;
//   final String mode;
//   final ParentBookingController controller;

//   const _BookingConfirmDialog({
//     required this.slot,
//     required this.childName,
//     required this.childId,
//     required this.mode,
//     required this.controller,
//   });

//   @override
//   State<_BookingConfirmDialog> createState() => _BookingConfirmDialogState();
// }

// class _BookingConfirmDialogState extends State<_BookingConfirmDialog> {
//   bool _loading = false;

//   @override
//   Widget build(BuildContext context) {
//     final fee = widget.slot.feeFor(widget.mode);

//     return AlertDialog(
//       shape:
//           RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
//       contentPadding: const EdgeInsets.all(24),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             padding: const EdgeInsets.all(14),
//             decoration: BoxDecoration(
//                 color: AppColors.primaryColor.withOpacity(0.1),
//                 shape: BoxShape.circle),
//             child: const Icon(Icons.event_available_rounded,
//                 color: AppColors.primaryColor, size: 34),
//           ),
//           const SizedBox(height: 14),
//           Text('Confirm Booking',
//               style: GoogleFonts.poppins(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.textPrimaryColor)),
//           const SizedBox(height: 16),

//           // Summary rows
//           _summaryRow(Icons.child_care_rounded, 'Child', widget.childName),
//           _summaryRow(Icons.calendar_today_outlined, 'Date',
//               widget.slot.formattedDate),
//           _summaryRow(Icons.access_time_rounded, 'Time',
//               '${widget.slot.formattedStartTime} – ${widget.slot.formattedEndTime}'),
//           _summaryRow(
//               widget.mode == 'online'
//                   ? Icons.videocam_outlined
//                   : Icons.location_on_outlined,
//               'Mode',
//               widget.mode[0].toUpperCase() + widget.mode.substring(1)),
//           if (fee != null)
//             _summaryRow(Icons.payments_outlined, 'Fee',
//                 '${widget.slot.currency} ${fee.toStringAsFixed(0)}'),

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
//                         color: AppColors.greyColor.withOpacity(0.4)),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12)),
//                     padding:
//                         const EdgeInsets.symmetric(vertical: 13),
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
//                           final ok =
//                               await widget.controller.bookAppointment(
//                             childId: widget.childId,
//                           );
//                           if (mounted)
//                             setState(() => _loading = false);
//                           if (ok && context.mounted) {
//                             Navigator.pop(context); // close dialog
//                             Get.toNamed(AppRoutes.parentMyAppointments);
//                           }
//                         },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.primaryColor,
//                     foregroundColor: Colors.white,
//                     disabledBackgroundColor:
//                         AppColors.primaryColor.withOpacity(0.5),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12)),
//                     padding:
//                         const EdgeInsets.symmetric(vertical: 13),
//                     elevation: 0,
//                   ),
//                   child: _loading
//                       ? const SizedBox(
//                           width: 18,
//                           height: 18,
//                           child: CircularProgressIndicator(
//                               color: Colors.white, strokeWidth: 2))
//                       : Text('Confirm',
//                           style: GoogleFonts.poppins(
//                               fontWeight: FontWeight.w600,
//                               fontSize: 13)),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _summaryRow(IconData icon, String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8),
//       child: Row(
//         children: [
//           Icon(icon, size: 15, color: AppColors.primaryColor),
//           const SizedBox(width: 10),
//           SizedBox(
//             width: 60,
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
//                     fontWeight: FontWeight.w600),
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis),
//           ),
//         ],
//       ),
//     );
//   }
// }


// lib/view/parents/booking/expert_slots_booking_screen.dart
//
// Navigated from ExpertDetailScreen with args:
//   {'expertId': String, 'expertName': String, 'childId': String, 'childName': String}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import 'package:speechspectrum/controllers/parent_booking_controller.dart';
import 'package:speechspectrum/models/parent_booking_model.dart';
import 'package:speechspectrum/routes/app_routes.dart';

class ExpertSlotsBookingScreen extends StatefulWidget {
  const ExpertSlotsBookingScreen({super.key});

  @override
  State<ExpertSlotsBookingScreen> createState() =>
      _ExpertSlotsBookingScreenState();
}

class _ExpertSlotsBookingScreenState extends State<ExpertSlotsBookingScreen> {
  late final ParentBookingController _c;
  late final String expertId;
  late final String expertName;
  late final String childId;
  late final String childName;

  @override
  void initState() {
    super.initState();
    _c = Get.isRegistered<ParentBookingController>()
        ? Get.find<ParentBookingController>()
        : Get.put(ParentBookingController());

    final args = Get.arguments as Map<String, dynamic>;
    expertId = args['expertId'] ?? '';
    expertName = args['expertName'] ?? 'Expert';
    childId = args['childId'] ?? '';
    childName = args['childName'] ?? 'Child';

    _c.clearSelection();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _c.fetchExpertSlots(expertId);
    });
  }

  // ── Filter: only slots from today onward ──────────────────
  List<ExpertSlotItem> get _futureSlots {
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    return _c.expertSlots.where((s) {
      try {
        final d = DateTime.parse(s.slotDate);
        return !d.isBefore(todayDate);
      } catch (_) {
        return true;
      }
    }).toList();
  }

  Map<String, List<ExpertSlotItem>> get _futureSlotsByDay {
    final map = <String, List<ExpertSlotItem>>{};
    for (final slot in _futureSlots) {
      final day = slot.fullDayName;
      map.putIfAbsent(day, () => []).add(slot);
    }
    return map;
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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Book Appointment',
                style: GoogleFonts.poppins(
                    color: AppColors.textPrimaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600)),
            Text(expertName,
                style: GoogleFonts.poppins(
                    color: AppColors.textSecondaryColor, fontSize: 12)),
          ],
        ),
        actions: [
          Obx(() => _c.isLoadingSlots.value
              ? const Padding(
                  padding: EdgeInsets.all(14),
                  child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                          color: AppColors.primaryColor, strokeWidth: 2)))
              : IconButton(
                  icon: const Icon(Icons.refresh_rounded,
                      color: AppColors.primaryColor),
                  onPressed: () => _c.fetchExpertSlots(expertId))),
          const SizedBox(width: 4),
        ],
      ),

      // ── Body: single top-level Obx, NO nested Obx inside ──
      body: Obx(() {
        if (_c.isLoadingSlots.value && _c.expertSlots.isEmpty) {
          return _loader(context, size);
        }

        // Compute filtered list inside Obx so it reacts to expertSlots changes
        final today = DateTime.now();
        final todayDate = DateTime(today.year, today.month, today.day);

        final filtered = _c.expertSlots.where((s) {
          try {
            final d = DateTime.parse(s.slotDate);
            return !d.isBefore(todayDate);
          } catch (_) {
            return true;
          }
        }).toList();

        if (filtered.isEmpty) return _empty(context, size);

        // Group by day
        const dayOrder = [
          'Monday', 'Tuesday', 'Wednesday', 'Thursday',
          'Friday', 'Saturday', 'Sunday'
        ];
        final byDay = <String, List<ExpertSlotItem>>{};
        for (final slot in filtered) {
          byDay.putIfAbsent(slot.fullDayName, () => []).add(slot);
        }

        final availableCount =
            filtered.where((s) => s.isAvailable).length;

        return RefreshIndicator(
          color: AppColors.primaryColor,
          onRefresh: () => _c.fetchExpertSlots(expertId),
          child: ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            padding: EdgeInsets.fromLTRB(
              size.customWidth(context) * 0.045,
              size.customHeight(context) * 0.02,
              size.customWidth(context) * 0.045,
              size.customHeight(context) * 0.12,
            ),
            children: [
              // Child banner
              _childBanner(context, size),
              SizedBox(height: size.customHeight(context) * 0.022),

              // Section header
              _sectionTitle(
                context,
                size,
                'Available Slots',
                '$availableCount slot${availableCount != 1 ? 's' : ''} available',
              ),
              SizedBox(height: size.customHeight(context) * 0.016),

              // Day groups — plain widgets, NO Obx inside slot cards
              for (final day in dayOrder)
                if (byDay[day] != null && byDay[day]!.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _dayHeader(context, size, day, byDay[day]!.length),
                      SizedBox(height: size.customHeight(context) * 0.01),
                      for (final slot in byDay[day]!)
                        _SlotCard(
                          key: ValueKey(slot.slotId),
                          slot: slot,
                          controller: _c,
                          size: size,
                        ),
                      SizedBox(height: size.customHeight(context) * 0.015),
                    ],
                  ),
            ],
          ),
        );
      }),

      // ── Book bar: its own Obx, completely separate ─────────
      bottomNavigationBar: Obx(() {
        final slot = _c.selectedSlot.value;
        if (slot == null) return const SizedBox.shrink();
        return _BookingBar(
          slot: slot,
          controller: _c,
          childId: childId,
          childName: childName,
          size: size,
        );
      }),
    );
  }

  // ── Static helper widgets (no Obx) ────────────────────────

  Widget _childBanner(BuildContext context, CustomSize size) {
    return Container(
      padding: EdgeInsets.all(size.customWidth(context) * 0.04),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primaryColor, AppColors.secondaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.25),
              blurRadius: 14,
              offset: const Offset(0, 4))
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(14)),
            child: Center(
              child: Text(
                childName.isNotEmpty ? childName[0].toUpperCase() : 'C',
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(width: size.customWidth(context) * 0.035),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Booking for',
                    style: GoogleFonts.poppins(
                        color: Colors.white.withOpacity(0.8), fontSize: 12)),
                Text(childName,
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          const Icon(Icons.child_care_rounded, color: Colors.white, size: 24),
        ],
      ),
    );
  }

  Widget _dayHeader(
      BuildContext context, CustomSize size, String day, int count) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: AppColors.primaryColor.withOpacity(0.3), width: 1),
          ),
          child: Text(day,
              style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor)),
        ),
        const SizedBox(width: 8),
        Text('$count slot${count != 1 ? 's' : ''}',
            style: GoogleFonts.poppins(
                fontSize: 12, color: AppColors.textSecondaryColor)),
      ],
    );
  }

  Widget _sectionTitle(
      BuildContext context, CustomSize size, String title, String sub) {
    return Row(
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
            Text(title,
                style: GoogleFonts.poppins(
                    fontSize: size.customWidth(context) * 0.042,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimaryColor)),
          ],
        ),
        Text(sub,
            style: GoogleFonts.poppins(
                fontSize: 12, color: AppColors.textSecondaryColor)),
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
          Text('Loading availability...',
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
          Text('No upcoming slots',
              style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.046,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryColor)),
          SizedBox(height: size.customHeight(context) * 0.01),
          Text('All past slots have been filtered out.',
              style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.034,
                  color: AppColors.textSecondaryColor)),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
// _SlotCard — separate StatelessWidget with its OWN Obx scope
// This is the fix: each card owns its Obx, so GetX knows exactly
// which widget to rebuild when selectedSlot changes.
// ══════════════════════════════════════════════════════════════
class _SlotCard extends StatelessWidget {
  final ExpertSlotItem slot;
  final ParentBookingController controller;
  final CustomSize size;

  const _SlotCard({
    super.key,
    required this.slot,
    required this.controller,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    // Obx is at the TOP of this widget's build — clean scope
    return Obx(() {
      final isSelected = controller.selectedSlot.value?.slotId == slot.slotId;
      final isAvail = slot.isAvailable;

      return GestureDetector(
        onTap: isAvail ? () => controller.selectSlot(slot) : null,
        child: Container(
          margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.012),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primaryColor.withOpacity(0.05)
                : AppColors.whiteColor,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isSelected
                  ? AppColors.primaryColor
                  : isAvail
                      ? AppColors.greyColor.withOpacity(0.2)
                      : AppColors.greyColor.withOpacity(0.1),
              width: isSelected ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(isSelected ? 0.08 : 0.04),
                  blurRadius: isSelected ? 12 : 8,
                  offset: const Offset(0, 3))
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(size.customWidth(context) * 0.04),
            child: Row(
              children: [
                // Date badge
                Container(
                  width: 52,
                  height: 58,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primaryColor
                        : AppColors.primaryColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(slot.dayOfWeek,
                          style: GoogleFonts.poppins(
                              fontSize: 10,
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.primaryColor,
                              fontWeight: FontWeight.w600)),
                      Text(
                        slot.slotDate.split('-').length > 2
                            ? slot.slotDate.split('-')[2]
                            : '',
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isSelected
                                ? Colors.white
                                : AppColors.primaryColor),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: size.customWidth(context) * 0.03),

                // Slot info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Time
                      Row(
                        children: [
                          Icon(Icons.access_time_rounded,
                              size: 13,
                              color: isSelected
                                  ? AppColors.primaryColor
                                  : AppColors.textSecondaryColor),
                          const SizedBox(width: 4),
                          Text(
                            '${slot.formattedStartTime} – ${slot.formattedEndTime}',
                            style: GoogleFonts.poppins(
                                fontSize: size.customWidth(context) * 0.036,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimaryColor),
                          ),
                        ],
                      ),
                      SizedBox(height: size.customHeight(context) * 0.005),

                      // Mode & fees
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: [
                          _chip(_modeIcon(slot.mode),
                              slot.mode[0].toUpperCase() + slot.mode.substring(1),
                              AppColors.primaryColor),
                          if (slot.feeOnline != null)
                            _chip(Icons.videocam_outlined,
                                '${slot.currency} ${slot.feeOnline!.toStringAsFixed(0)}',
                                AppColors.accentColor),
                          if (slot.feePhysical != null)
                            _chip(Icons.location_on_outlined,
                                '${slot.currency} ${slot.feePhysical!.toStringAsFixed(0)}',
                                AppColors.warningColor),
                        ],
                      ),

                      // Recurrence
                      if (slot.isRecurring && slot.recurrenceRule != null) ...[
                        SizedBox(height: size.customHeight(context) * 0.004),
                        Row(
                          children: [
                            Icon(Icons.repeat_rounded,
                                size: 11,
                                color:
                                    AppColors.primaryColor.withOpacity(0.6)),
                            const SizedBox(width: 3),
                            Expanded(
                              child: Text(slot.recurrenceRule!,
                                  style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      color: AppColors.primaryColor
                                          .withOpacity(0.6)),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                      ],

                      // Location
                      if (slot.expertLocations != null) ...[
                        SizedBox(height: size.customHeight(context) * 0.004),
                        Row(children: [
                          const Icon(Icons.business_rounded,
                              size: 11,
                              color: AppColors.textSecondaryColor),
                          const SizedBox(width: 3),
                          Expanded(
                            child: Text(
                                '${slot.expertLocations!.label}, ${slot.expertLocations!.city}',
                                style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    color: AppColors.textSecondaryColor),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ]),
                      ],
                    ],
                  ),
                ),

                // Right: status + selection
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isAvail
                            ? AppColors.successColor.withOpacity(0.1)
                            : AppColors.greyColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        isAvail ? 'Open' : slot.status,
                        style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: isAvail
                                ? AppColors.successColor
                                : AppColors.greyColor),
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (isAvail)
                      Icon(
                        isSelected
                            ? Icons.check_circle_rounded
                            : Icons.radio_button_unchecked_rounded,
                        color: isSelected
                            ? AppColors.primaryColor
                            : AppColors.greyColor,
                        size: 22,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _chip(IconData icon, String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 11, color: color),
        const SizedBox(width: 3),
        Text(label,
            style: GoogleFonts.poppins(
                fontSize: 11,
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

// ══════════════════════════════════════════════════════════════
// _BookingBar — separate StatelessWidget, its own Obx scope
// ══════════════════════════════════════════════════════════════
class _BookingBar extends StatelessWidget {
  final ExpertSlotItem slot;
  final ParentBookingController controller;
  final String childId;
  final String childName;
  final CustomSize size;

  const _BookingBar({
    required this.slot,
    required this.controller,
    required this.childId,
    required this.childName,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        size.customWidth(context) * 0.05,
        16,
        size.customWidth(context) * 0.05,
        MediaQuery.of(context).padding.bottom + 16,
      ),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, -4))
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Mode selector (only for 'both' slots)
          if (slot.mode == 'both') ...[
            Obx(() => Row(
                  children: [
                    Text('Mode:',
                        style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimaryColor)),
                    const SizedBox(width: 12),
                    _modeBtn(context, 'online', Icons.videocam_outlined,
                        'Online', AppColors.accentColor),
                    const SizedBox(width: 8),
                    _modeBtn(context, 'physical', Icons.location_on_outlined,
                        'Physical', AppColors.warningColor),
                  ],
                )),
            const SizedBox(height: 12),
          ],

          // Fee + Book button
          Obx(() {
            final activeMode =
                slot.mode == 'both' ? controller.selectedMode.value : slot.mode;
            final fee = slot.feeFor(activeMode);

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${slot.formattedDate}  •  ${slot.formattedStartTime}',
                      style: GoogleFonts.poppins(
                          fontSize: 12, color: AppColors.textSecondaryColor),
                    ),
                    if (fee != null)
                      Text(
                        '${slot.currency} ${fee.toStringAsFixed(0)}',
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor),
                      ),
                  ],
                ),
                ElevatedButton(
                  onPressed: controller.isBooking.value
                      ? null
                      : () => _showConfirmBooking(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor:
                        AppColors.primaryColor.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28, vertical: 14),
                    elevation: 0,
                  ),
                  child: controller.isBooking.value
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2))
                      : Text('Book Now',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600, fontSize: 14)),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _modeBtn(BuildContext context, String value, IconData icon,
      String label, Color color) {
    final selected = controller.selectedMode.value == value;
    return GestureDetector(
      onTap: () => controller.setMode(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: selected ? color : color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: selected ? color : color.withOpacity(0.3), width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: selected ? Colors.white : color, size: 15),
            const SizedBox(width: 4),
            Text(label,
                style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: selected ? Colors.white : color)),
          ],
        ),
      ),
    );
  }

  void _showConfirmBooking(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => _BookingConfirmDialog(
        slot: slot,
        childName: childName,
        childId: childId,
        mode: controller.selectedMode.value,
        controller: controller,
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
// Booking Confirm Dialog — unchanged logic, no Obx needed here
// ══════════════════════════════════════════════════════════════
class _BookingConfirmDialog extends StatefulWidget {
  final ExpertSlotItem slot;
  final String childName;
  final String childId;
  final String mode;
  final ParentBookingController controller;

  const _BookingConfirmDialog({
    required this.slot,
    required this.childName,
    required this.childId,
    required this.mode,
    required this.controller,
  });

  @override
  State<_BookingConfirmDialog> createState() => _BookingConfirmDialogState();
}

class _BookingConfirmDialogState extends State<_BookingConfirmDialog> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final fee = widget.slot.feeFor(widget.mode);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      contentPadding: const EdgeInsets.all(24),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle),
            child: const Icon(Icons.event_available_rounded,
                color: AppColors.primaryColor, size: 34),
          ),
          const SizedBox(height: 14),
          Text('Confirm Booking',
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryColor)),
          const SizedBox(height: 16),
          _summaryRow(Icons.child_care_rounded, 'Child', widget.childName),
          _summaryRow(Icons.calendar_today_outlined, 'Date',
              widget.slot.formattedDate),
          _summaryRow(Icons.access_time_rounded, 'Time',
              '${widget.slot.formattedStartTime} – ${widget.slot.formattedEndTime}'),
          _summaryRow(
              widget.mode == 'online'
                  ? Icons.videocam_outlined
                  : Icons.location_on_outlined,
              'Mode',
              widget.mode[0].toUpperCase() + widget.mode.substring(1)),
          if (fee != null)
            _summaryRow(Icons.payments_outlined, 'Fee',
                '${widget.slot.currency} ${fee.toStringAsFixed(0)}'),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _loading ? null : () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textSecondaryColor,
                    side: BorderSide(
                        color: AppColors.greyColor.withOpacity(0.4)),
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
                          final ok =
                              await widget.controller.bookAppointment(
                            childId: widget.childId,
                          );
                          if (mounted) setState(() => _loading = false);
                          if (ok && context.mounted) {
                            Navigator.pop(context);
                            Get.toNamed(AppRoutes.parentMyAppointments);
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor:
                        AppColors.primaryColor.withOpacity(0.5),
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
                      : Text('Confirm',
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

  Widget _summaryRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 15, color: AppColors.primaryColor),
          const SizedBox(width: 10),
          SizedBox(
            width: 60,
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
                    fontWeight: FontWeight.w600),
                maxLines: 2,
                overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}