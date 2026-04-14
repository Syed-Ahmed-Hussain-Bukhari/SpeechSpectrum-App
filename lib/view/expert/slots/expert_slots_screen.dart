// // // lib/view/expert/slots/expert_slots_screen.dart
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:speechspectrum/constants/app_colors.dart';
// // import 'package:speechspectrum/constants/custom_size.dart';
// // import 'package:speechspectrum/controllers/slot_controller.dart';
// // import 'package:speechspectrum/models/slot_model.dart';
// // import 'package:speechspectrum/models/location_model.dart';

// // class ExpertSlotsScreen extends StatefulWidget {
// //   const ExpertSlotsScreen({super.key});

// //   @override
// //   State<ExpertSlotsScreen> createState() => _ExpertSlotsScreenState();
// // }

// // class _ExpertSlotsScreenState extends State<ExpertSlotsScreen> {
// //   late final SlotController _c;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _c = Get.isRegistered<SlotController>()
// //         ? Get.find<SlotController>()
// //         : Get.put(SlotController());
// //     WidgetsBinding.instance.addPostFrameCallback((_) {
// //       _c.fetchMySlots();
// //       _c.fetchMyLocations();
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final size = CustomSize();
// //     return Scaffold(
// //       backgroundColor: AppColors.lightGreyColor,
// //       appBar: _appBar(context, size),
// //       body: Obx(() {
// //         if (_c.isLoading.value && _c.mySlots.isEmpty) {
// //           return _loader(context, size);
// //         }
// //         return RefreshIndicator(
// //           color: AppColors.primaryColor,
// //           onRefresh: () async {
// //             await _c.fetchMySlots();
// //             await _c.fetchMyLocations();
// //           },
// //           child: ListView(
// //             physics: const BouncingScrollPhysics(
// //                 parent: AlwaysScrollableScrollPhysics()),
// //             padding: EdgeInsets.fromLTRB(
// //               size.customWidth(context) * 0.05,
// //               size.customHeight(context) * 0.02,
// //               size.customWidth(context) * 0.05,
// //               size.customHeight(context) * 0.12,
// //             ),
// //             children: [
// //               _headerBanner(context, size),
// //               SizedBox(height: size.customHeight(context) * 0.025),
// //               _weekDayGrid(context, size),
// //               SizedBox(height: size.customHeight(context) * 0.025),
// //               if (_c.mySlots.isEmpty)
// //                 _emptySlots(context, size)
// //               else ...[
// //                 _sectionTitle(context, size, 'Your Slots'),
// //                 SizedBox(height: size.customHeight(context) * 0.015),
// //                 ..._c.mySlots.map((s) => _slotCard(context, size, s)).toList(),
// //               ],
// //             ],
// //           ),
// //         );
// //       }),
// //       floatingActionButton: FloatingActionButton.extended(
// //         onPressed: () {
// //           _c.resetForm();
// //           _openSlotSheet(context, size);
// //         },
// //         backgroundColor: AppColors.primaryColor,
// //         icon: const Icon(Icons.add_alarm_rounded, color: Colors.white),
// //         label: Text('Add Slot',
// //             style: GoogleFonts.poppins(
// //                 color: Colors.white,
// //                 fontWeight: FontWeight.w600,
// //                 fontSize: 14)),
// //       ),
// //     );
// //   }

// //   PreferredSizeWidget _appBar(BuildContext context, CustomSize size) {
// //     return AppBar(
// //       backgroundColor: AppColors.whiteColor,
// //       elevation: 0,
// //       surfaceTintColor: Colors.transparent,
// //       leading: IconButton(
// //         icon: const Icon(Icons.arrow_back_ios_new_rounded,
// //             color: AppColors.textPrimaryColor, size: 20),
// //         onPressed: () => Get.back(),
// //       ),
// //       title: Text('My Slots',
// //           style: GoogleFonts.poppins(
// //               color: AppColors.textPrimaryColor,
// //               fontSize: 18,
// //               fontWeight: FontWeight.w600)),
// //       actions: [
// //         Obx(() => _c.isLoading.value
// //             ? const Padding(
// //                 padding: EdgeInsets.all(16),
// //                 child: SizedBox(
// //                     width: 20,
// //                     height: 20,
// //                     child: CircularProgressIndicator(
// //                         color: AppColors.primaryColor, strokeWidth: 2)),
// //               )
// //             : IconButton(
// //                 icon: const Icon(Icons.refresh_rounded,
// //                     color: AppColors.primaryColor),
// //                 onPressed: () {
// //                   _c.fetchMySlots();
// //                   _c.fetchMyLocations();
// //                 },
// //               )),
// //         const SizedBox(width: 4),
// //       ],
// //     );
// //   }

// //   Widget _headerBanner(BuildContext context, CustomSize size) {
// //     return Container(
// //       padding: EdgeInsets.all(size.customWidth(context) * 0.05),
// //       decoration: BoxDecoration(
// //         gradient: const LinearGradient(
// //           colors: [AppColors.primaryColor, AppColors.secondaryColor],
// //           begin: Alignment.topLeft,
// //           end: Alignment.bottomRight,
// //         ),
// //         borderRadius: BorderRadius.circular(22),
// //         boxShadow: [
// //           BoxShadow(
// //               color: AppColors.primaryColor.withOpacity(0.28),
// //               blurRadius: 18,
// //               offset: const Offset(0, 5))
// //         ],
// //       ),
// //       child: Row(
// //         children: [
// //           Container(
// //             padding: const EdgeInsets.all(12),
// //             decoration: BoxDecoration(
// //                 color: Colors.white.withOpacity(0.2),
// //                 borderRadius: BorderRadius.circular(14)),
// //             child: const Icon(Icons.calendar_month_rounded,
// //                 color: Colors.white, size: 28),
// //           ),
// //           SizedBox(width: size.customWidth(context) * 0.04),
// //           Expanded(
// //             child: Obx(() => Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text(
// //                       '${_c.mySlots.length} Slot${_c.mySlots.length != 1 ? 's' : ''} Created',
// //                       style: GoogleFonts.poppins(
// //                           color: Colors.white,
// //                           fontSize: size.customWidth(context) * 0.044,
// //                           fontWeight: FontWeight.bold),
// //                     ),
// //                     Text(
// //                       '${_c.createdDays.length} of 7 days covered this week',
// //                       style: GoogleFonts.poppins(
// //                           color: Colors.white.withOpacity(0.85),
// //                           fontSize: size.customWidth(context) * 0.031),
// //                     ),
// //                   ],
// //                 )),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _weekDayGrid(BuildContext context, CustomSize size) {
// //     return Obx(() {
// //       final days = SlotController.weekDays;
// //       return Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           _sectionTitle(context, size, 'Weekly Coverage'),
// //           SizedBox(height: size.customHeight(context) * 0.015),
// //           Row(
// //             children: days.map((day) {
// //               final hasSlot = _c.createdDays.contains(day);
// //               final shortDay = day.substring(0, 3);
// //               return Expanded(
// //                 child: GestureDetector(
// //                   onTap: () {
// //                     if (hasSlot) {
// //                       _showDaySlotsSheet(context, size, day);
// //                     } else {
// //                       _c.resetForm();
// //                       // Pre-select next occurrence of this day
// //                       final now = DateTime.now();
// //                       final targetWeekday = days.indexOf(day) + 1;
// //                       var diff = targetWeekday - now.weekday;
// //                       if (diff <= 0) diff += 7;
// //                       _c.selectedDate.value = now.add(Duration(days: diff));
// //                       _openSlotSheet(context, size);
// //                     }
// //                   },
// //                   child: Container(
// //                     margin: const EdgeInsets.symmetric(horizontal: 3),
// //                     padding: const EdgeInsets.symmetric(vertical: 10),
// //                     decoration: BoxDecoration(
// //                       color: hasSlot
// //                           ? AppColors.primaryColor
// //                           : AppColors.whiteColor,
// //                       borderRadius: BorderRadius.circular(12),
// //                       border: Border.all(
// //                         color: hasSlot
// //                             ? AppColors.primaryColor
// //                             : AppColors.greyColor.withOpacity(0.3),
// //                         width: 1,
// //                       ),
// //                       boxShadow: [
// //                         BoxShadow(
// //                             color: Colors.black.withOpacity(0.04),
// //                             blurRadius: 6,
// //                             offset: const Offset(0, 2))
// //                       ],
// //                     ),
// //                     child: Column(
// //                       mainAxisSize: MainAxisSize.min,
// //                       children: [
// //                         if (hasSlot)
// //                           const Icon(Icons.check_circle_rounded,
// //                               color: Colors.white, size: 14)
// //                         else
// //                           Icon(Icons.add_rounded,
// //                               color: AppColors.primaryColor.withOpacity(0.6),
// //                               size: 14),
// //                         const SizedBox(height: 4),
// //                         Text(
// //                           shortDay,
// //                           style: GoogleFonts.poppins(
// //                             fontSize: 11,
// //                             fontWeight: FontWeight.w600,
// //                             color: hasSlot
// //                                 ? Colors.white
// //                                 : AppColors.textSecondaryColor,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               );
// //             }).toList(),
// //           ),
// //         ],
// //       );
// //     });
// //   }

// //   Widget _sectionTitle(BuildContext context, CustomSize size, String title) {
// //     return Row(
// //       children: [
// //         Container(
// //           width: 4,
// //           height: 20,
// //           decoration: BoxDecoration(
// //               color: AppColors.primaryColor,
// //               borderRadius: BorderRadius.circular(2)),
// //         ),
// //         SizedBox(width: size.customWidth(context) * 0.025),
// //         Text(title,
// //             style: GoogleFonts.poppins(
// //                 fontSize: size.customWidth(context) * 0.042,
// //                 fontWeight: FontWeight.bold,
// //                 color: AppColors.textPrimaryColor)),
// //       ],
// //     );
// //   }

// //   Widget _slotCard(BuildContext context, CustomSize size, SlotItem slot) {
// //     Color statusColor;
// //     switch (slot.status.toLowerCase()) {
// //       case 'booked':
// //         statusColor = AppColors.warningColor;
// //         break;
// //       case 'cancelled':
// //         statusColor = AppColors.errorColor;
// //         break;
// //       default:
// //         statusColor = AppColors.successColor;
// //     }

// //     Color modeColor;
// //     IconData modeIcon;
// //     switch (slot.mode.toLowerCase()) {
// //       case 'online':
// //         modeColor = AppColors.accentColor;
// //         modeIcon = Icons.videocam_outlined;
// //         break;
// //       case 'physical':
// //         modeColor = AppColors.warningColor;
// //         modeIcon = Icons.location_on_outlined;
// //         break;
// //       default:
// //         modeColor = AppColors.primaryColor;
// //         modeIcon = Icons.swap_horiz_rounded;
// //     }

// //     return Container(
// //       margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.015),
// //       decoration: BoxDecoration(
// //         color: AppColors.whiteColor,
// //         borderRadius: BorderRadius.circular(20),
// //         boxShadow: [
// //           BoxShadow(
// //               color: Colors.black.withOpacity(0.06),
// //               blurRadius: 14,
// //               offset: const Offset(0, 4))
// //         ],
// //       ),
// //       child: Column(
// //         children: [
// //           Padding(
// //             padding: EdgeInsets.all(size.customWidth(context) * 0.042),
// //             child: Row(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 // Day badge
// //                 Container(
// //                   width: 54,
// //                   height: 60,
// //                   decoration: BoxDecoration(
// //                     color: AppColors.primaryColor.withOpacity(0.1),
// //                     borderRadius: BorderRadius.circular(14),
// //                   ),
// //                   child: Column(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: [
// //                       Text(slot.dayOfWeek,
// //                           style: GoogleFonts.poppins(
// //                               fontSize: 11,
// //                               color: AppColors.primaryColor,
// //                               fontWeight: FontWeight.w600)),
// //                       Text(
// //                         slot.slotDate.split('-')[2],
// //                         style: GoogleFonts.poppins(
// //                             fontSize: 18,
// //                             fontWeight: FontWeight.bold,
// //                             color: AppColors.primaryColor),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //                 SizedBox(width: size.customWidth(context) * 0.035),
// //                 Expanded(
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Row(
// //                         children: [
// //                           const Icon(Icons.access_time_rounded,
// //                               size: 14, color: AppColors.textSecondaryColor),
// //                           const SizedBox(width: 4),
// //                           Text(
// //                             '${slot.formattedStartTime} – ${slot.formattedEndTime}',
// //                             style: GoogleFonts.poppins(
// //                                 fontSize: size.customWidth(context) * 0.038,
// //                                 fontWeight: FontWeight.w600,
// //                                 color: AppColors.textPrimaryColor),
// //                           ),
// //                         ],
// //                       ),
// //                       SizedBox(height: size.customHeight(context) * 0.006),
// //                       Row(
// //                         children: [
// //                           Icon(modeIcon, size: 13, color: modeColor),
// //                           const SizedBox(width: 4),
// //                           Text(
// //                             slot.mode[0].toUpperCase() + slot.mode.substring(1),
// //                             style: GoogleFonts.poppins(
// //                                 fontSize: 12,
// //                                 color: modeColor,
// //                                 fontWeight: FontWeight.w500),
// //                           ),
// //                           const SizedBox(width: 10),
// //                           if (slot.feeOnline != null) ...[
// //                             Icon(Icons.videocam_outlined,
// //                                 size: 12, color: AppColors.accentColor),
// //                             const SizedBox(width: 3),
// //                             Text(
// //                               '${slot.currency} ${slot.feeOnline!.toStringAsFixed(0)}',
// //                               style: GoogleFonts.poppins(
// //                                   fontSize: 11,
// //                                   color: AppColors.textSecondaryColor),
// //                             ),
// //                             const SizedBox(width: 6),
// //                           ],
// //                           if (slot.feePhysical != null) ...[
// //                             Icon(Icons.location_on_outlined,
// //                                 size: 12, color: AppColors.warningColor),
// //                             const SizedBox(width: 3),
// //                             Text(
// //                               '${slot.currency} ${slot.feePhysical!.toStringAsFixed(0)}',
// //                               style: GoogleFonts.poppins(
// //                                   fontSize: 11,
// //                                   color: AppColors.textSecondaryColor),
// //                             ),
// //                           ],
// //                         ],
// //                       ),
// //                       if (slot.isRecurring &&
// //                           slot.recurrenceRule != null) ...[
// //                         SizedBox(height: size.customHeight(context) * 0.004),
// //                         Row(children: [
// //                           Icon(Icons.repeat_rounded,
// //                               size: 12,
// //                               color:
// //                                   AppColors.primaryColor.withOpacity(0.7)),
// //                           const SizedBox(width: 3),
// //                           Expanded(
// //                             child: Text(
// //                               slot.recurrenceRule!,
// //                               style: GoogleFonts.poppins(
// //                                   fontSize: 11,
// //                                   color: AppColors.primaryColor
// //                                       .withOpacity(0.7)),
// //                               maxLines: 1,
// //                               overflow: TextOverflow.ellipsis,
// //                             ),
// //                           ),
// //                         ]),
// //                       ],
// //                     ],
// //                   ),
// //                 ),
// //                 // Status badge
// //                 Container(
// //                   padding: const EdgeInsets.symmetric(
// //                       horizontal: 10, vertical: 4),
// //                   decoration: BoxDecoration(
// //                     color: statusColor.withOpacity(0.1),
// //                     borderRadius: BorderRadius.circular(20),
// //                   ),
// //                   child: Text(
// //                     slot.status[0].toUpperCase() + slot.status.substring(1),
// //                     style: GoogleFonts.poppins(
// //                         fontSize: 11,
// //                         fontWeight: FontWeight.w600,
// //                         color: statusColor),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           Divider(height: 1, color: AppColors.greyColor.withOpacity(0.15)),
// //           // Actions row
// //           Padding(
// //             padding: EdgeInsets.symmetric(
// //                 horizontal: size.customWidth(context) * 0.02,
// //                 vertical: size.customHeight(context) * 0.005),
// //             child: Row(
// //               children: [
// //                 _action(
// //                   icon: Icons.edit_outlined,
// //                   label: 'Edit',
// //                   color: AppColors.warningColor,
// //                   onTap: () {
// //                     _c.populateFormFromSlot(slot);
// //                     _openSlotSheet(context, size, editingSlot: slot);
// //                   },
// //                 ),
// //                 _action(
// //                   icon: Icons.delete_outline_rounded,
// //                   label: 'Delete',
// //                   color: AppColors.errorColor,
// //                   onTap: () => _showDeleteConfirm(context, slot),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _action(
// //       {required IconData icon,
// //       required String label,
// //       required Color color,
// //       required VoidCallback onTap}) {
// //     return Expanded(
// //       child: InkWell(
// //         onTap: onTap,
// //         borderRadius: BorderRadius.circular(10),
// //         child: Padding(
// //           padding: const EdgeInsets.symmetric(vertical: 10),
// //           child: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               Icon(icon, color: color, size: 19),
// //               const SizedBox(height: 4),
// //               Text(label,
// //                   style: GoogleFonts.poppins(
// //                       fontSize: 11,
// //                       fontWeight: FontWeight.w500,
// //                       color: color)),
// //             ],
// //           ),
// //         ),
// //       ),
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
// //           Text('Loading your slots...',
// //               style: GoogleFonts.poppins(
// //                   color: AppColors.textSecondaryColor,
// //                   fontSize: size.customWidth(context) * 0.036)),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _emptySlots(BuildContext context, CustomSize size) {
// //     return Center(
// //       child: Column(
// //         children: [
// //           SizedBox(height: size.customHeight(context) * 0.04),
// //           Container(
// //             width: 120,
// //             height: 120,
// //             decoration: BoxDecoration(
// //                 color: AppColors.primaryColor.withOpacity(0.08),
// //                 shape: BoxShape.circle),
// //             child: const Icon(Icons.calendar_today_outlined,
// //                 size: 58, color: AppColors.primaryColor),
// //           ),
// //           SizedBox(height: size.customHeight(context) * 0.025),
// //           Text('No Slots Yet',
// //               style: GoogleFonts.poppins(
// //                   fontSize: size.customWidth(context) * 0.05,
// //                   fontWeight: FontWeight.bold,
// //                   color: AppColors.textPrimaryColor)),
// //           SizedBox(height: size.customHeight(context) * 0.01),
// //           Text(
// //             'Tap "Add Slot" or tap a day\nto create your first availability slot.',
// //             textAlign: TextAlign.center,
// //             style: GoogleFonts.poppins(
// //                 fontSize: size.customWidth(context) * 0.034,
// //                 color: AppColors.textSecondaryColor,
// //                 height: 1.6),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   // ── Sheets & Dialogs ────────────────────────────────────────

// //   void _openSlotSheet(BuildContext context, CustomSize size,
// //       {SlotItem? editingSlot}) {
// //     showModalBottomSheet(
// //       context: context,
// //       isScrollControlled: true,
// //       backgroundColor: Colors.transparent,
// //       enableDrag: true,
// //       builder: (_) => ConstrainedBox(
// //         constraints: BoxConstraints(
// //             maxHeight: MediaQuery.of(context).size.height * 0.94),
// //         child: _SlotFormSheet(
// //           controller: _c,
// //           size: size,
// //           editingSlot: editingSlot,
// //           onCreated: (dayName) => _showAddAnotherDay(context, size, dayName),
// //         ),
// //       ),
// //     );
// //   }

// //   void _showDaySlotsSheet(
// //       BuildContext context, CustomSize size, String dayName) {
// //     final slots = _c.getSlotsForDay(dayName);
// //     showModalBottomSheet(
// //       context: context,
// //       isScrollControlled: true,
// //       backgroundColor: Colors.transparent,
// //       builder: (_) => ConstrainedBox(
// //         constraints: BoxConstraints(
// //             maxHeight: MediaQuery.of(context).size.height * 0.75),
// //         child: Container(
// //           decoration: const BoxDecoration(
// //             color: AppColors.whiteColor,
// //             borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
// //           ),
// //           padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
// //           child: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             crossAxisAlignment: CrossAxisAlignment.start,
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
// //               const SizedBox(height: 16),
// //               Row(
// //                 children: [
// //                   Container(
// //                     padding: const EdgeInsets.all(8),
// //                     decoration: BoxDecoration(
// //                         color: AppColors.primaryColor.withOpacity(0.1),
// //                         borderRadius: BorderRadius.circular(10)),
// //                     child: const Icon(Icons.calendar_today_rounded,
// //                         color: AppColors.primaryColor, size: 20),
// //                   ),
// //                   const SizedBox(width: 12),
// //                   Text('$dayName Slots',
// //                       style: GoogleFonts.poppins(
// //                           fontSize: 18,
// //                           fontWeight: FontWeight.bold,
// //                           color: AppColors.textPrimaryColor)),
// //                 ],
// //               ),
// //               const SizedBox(height: 16),
// //               Flexible(
// //                 child: ListView.builder(
// //                   shrinkWrap: true,
// //                   itemCount: slots.length,
// //                   itemBuilder: (_, i) => _slotCard(context, size, slots[i]),
// //                 ),
// //               ),
// //               const SizedBox(height: 12),
// //               SizedBox(
// //                 width: double.infinity,
// //                 child: OutlinedButton.icon(
// //                   onPressed: () {
// //                     Navigator.pop(context);
// //                     _c.resetForm();
// //                     final now = DateTime.now();
// //                     final targetWeekday =
// //                         SlotController.weekDays.indexOf(dayName) + 1;
// //                     var diff = targetWeekday - now.weekday;
// //                     if (diff <= 0) diff += 7;
// //                     _c.selectedDate.value = now.add(Duration(days: diff));
// //                     _openSlotSheet(context, size);
// //                   },
// //                   style: OutlinedButton.styleFrom(
// //                     foregroundColor: AppColors.primaryColor,
// //                     side: BorderSide(
// //                         color: AppColors.primaryColor.withOpacity(0.5)),
// //                     shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(14)),
// //                     padding: const EdgeInsets.symmetric(vertical: 13),
// //                   ),
// //                   icon: const Icon(Icons.add_rounded, size: 18),
// //                   label: Text('Add another slot on $dayName',
// //                       style: GoogleFonts.poppins(
// //                           fontWeight: FontWeight.w500, fontSize: 14)),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   void _showAddAnotherDay(
// //       BuildContext context, CustomSize size, String justCreatedDay) {
// //     final remaining = SlotController.weekDays
// //         .where((d) => !_c.createdDays.contains(d))
// //         .toList();

// //     showModalBottomSheet(
// //       context: context,
// //       backgroundColor: Colors.transparent,
// //       builder: (_) => Container(
// //         decoration: const BoxDecoration(
// //           color: AppColors.whiteColor,
// //           borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
// //         ),
// //         padding: const EdgeInsets.fromLTRB(20, 20, 20, 36),
// //         child: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             Center(
// //               child: Container(
// //                 width: 44,
// //                 height: 4,
// //                 decoration: BoxDecoration(
// //                     color: AppColors.greyColor.withOpacity(0.3),
// //                     borderRadius: BorderRadius.circular(2)),
// //               ),
// //             ),
// //             const SizedBox(height: 20),
// //             Container(
// //               padding: const EdgeInsets.all(14),
// //               decoration: BoxDecoration(
// //                   color: AppColors.successColor.withOpacity(0.1),
// //                   shape: BoxShape.circle),
// //               child: const Icon(Icons.check_circle_rounded,
// //                   color: AppColors.successColor, size: 32),
// //             ),
// //             const SizedBox(height: 12),
// //             Text(
// //               '$justCreatedDay slot created! ✓',
// //               style: GoogleFonts.poppins(
// //                   fontSize: 17,
// //                   fontWeight: FontWeight.bold,
// //                   color: AppColors.textPrimaryColor),
// //             ),
// //             const SizedBox(height: 6),
// //             Text(
// //               remaining.isEmpty
// //                   ? 'You have slots for all 7 days! 🎉'
// //                   : 'Do you want to add a slot for another day?',
// //               textAlign: TextAlign.center,
// //               style: GoogleFonts.poppins(
// //                   fontSize: 13,
// //                   color: AppColors.textSecondaryColor),
// //             ),
// //             const SizedBox(height: 20),
// //             if (remaining.isNotEmpty) ...[
// //               Wrap(
// //                 spacing: 8,
// //                 runSpacing: 8,
// //                 alignment: WrapAlignment.center,
// //                 children: remaining.map((day) {
// //                   return GestureDetector(
// //                     onTap: () {
// //                       Navigator.pop(context);
// //                       _c.resetForm();
// //                       final now = DateTime.now();
// //                       final targetWeekday =
// //                           SlotController.weekDays.indexOf(day) + 1;
// //                       var diff = targetWeekday - now.weekday;
// //                       if (diff <= 0) diff += 7;
// //                       _c.selectedDate.value = now.add(Duration(days: diff));
// //                       _openSlotSheet(context, size);
// //                     },
// //                     child: Container(
// //                       padding: const EdgeInsets.symmetric(
// //                           horizontal: 16, vertical: 10),
// //                       decoration: BoxDecoration(
// //                         color: AppColors.primaryColor.withOpacity(0.08),
// //                         borderRadius: BorderRadius.circular(12),
// //                         border: Border.all(
// //                             color: AppColors.primaryColor.withOpacity(0.3)),
// //                       ),
// //                       child: Text(day,
// //                           style: GoogleFonts.poppins(
// //                               fontSize: 13,
// //                               fontWeight: FontWeight.w600,
// //                               color: AppColors.primaryColor)),
// //                     ),
// //                   );
// //                 }).toList(),
// //               ),
// //               const SizedBox(height: 16),
// //             ],
// //             SizedBox(
// //               width: double.infinity,
// //               child: OutlinedButton(
// //                 onPressed: () => Navigator.pop(context),
// //                 style: OutlinedButton.styleFrom(
// //                   foregroundColor: AppColors.textSecondaryColor,
// //                   side: BorderSide(
// //                       color: AppColors.greyColor.withOpacity(0.4)),
// //                   shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(14)),
// //                   padding: const EdgeInsets.symmetric(vertical: 13),
// //                 ),
// //                 child: Text("I'm done for now",
// //                     style: GoogleFonts.poppins(
// //                         fontWeight: FontWeight.w500, fontSize: 14)),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   void _showDeleteConfirm(BuildContext context, SlotItem slot) {
// //     showDialog(
// //       context: context,
// //       barrierDismissible: false,
// //       builder: (_) => _DeleteSlotDialog(slot: slot, controller: _c),
// //     );
// //   }
// // }

// // // ═══════════════════════════════════════════════════════════════
// // //   Slot Form Bottom Sheet
// // // ═══════════════════════════════════════════════════════════════
// // class _SlotFormSheet extends StatefulWidget {
// //   final SlotController controller;
// //   final CustomSize size;
// //   final SlotItem? editingSlot;
// //   final void Function(String dayName) onCreated;

// //   const _SlotFormSheet({
// //     required this.controller,
// //     required this.size,
// //     this.editingSlot,
// //     required this.onCreated,
// //   });

// //   @override
// //   State<_SlotFormSheet> createState() => _SlotFormSheetState();
// // }

// // class _SlotFormSheetState extends State<_SlotFormSheet> {
// //   final _formKey = GlobalKey<FormState>();
// //   bool _saving = false;
// //   late SlotController _c;

// //   // Local mirror of reactive fields for pure setState rebuilds
// //   String _mode = 'both';
// //   bool _recurring = false;
// //   DateTime? _date;
// //   TimeOfDay? _startTime;
// //   TimeOfDay? _endTime;
// //   String _status = 'available';
// //   String _locationId = '';
// //   String _locationLabel = 'None';

// //   @override
// //   void initState() {
// //     super.initState();
// //     _c = widget.controller;
// //     // Mirror from controller
// //     _mode = _c.selectedMode.value;
// //     _recurring = _c.isRecurring.value;
// //     _date = _c.selectedDate.value;
// //     _startTime = _c.selectedStartTime.value;
// //     _endTime = _c.selectedEndTime.value;
// //     _status = _c.selectedStatus.value;
// //     _locationId = _c.selectedLocationId.value;
// //     _locationLabel = _c.selectedLocationLabel.value.isEmpty
// //         ? 'None'
// //         : _c.selectedLocationLabel.value;
// //   }

// //   void _sync() {
// //     _c.selectedMode.value = _mode;
// //     _c.isRecurring.value = _recurring;
// //     _c.selectedDate.value = _date;
// //     _c.selectedStartTime.value = _startTime;
// //     _c.selectedEndTime.value = _endTime;
// //     _c.selectedStatus.value = _status;
// //     _c.selectedLocationId.value = _locationId;
// //   }

// //   String _fmtTime(TimeOfDay? t) {
// //     if (t == null) return 'Select';
// //     final h = t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod;
// //     final m = t.minute.toString().padLeft(2, '0');
// //     final p = t.period == DayPeriod.am ? 'AM' : 'PM';
// //     return '$h:$m $p';
// //   }

// //   String _fmtDate(DateTime? d) {
// //     if (d == null) return 'Select date';
// //     const months = [
// //       '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
// //       'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
// //     ];
// //     const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
// //     return '${days[d.weekday - 1]}, ${d.day} ${months[d.month]} ${d.year}';
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final size = widget.size;
// //     final isEdit = widget.editingSlot != null;

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
// //               // Handle
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

// //               // Header
// //               Row(
// //                 children: [
// //                   Container(
// //                     padding: const EdgeInsets.all(10),
// //                     decoration: BoxDecoration(
// //                         color: AppColors.primaryColor.withOpacity(0.1),
// //                         borderRadius: BorderRadius.circular(12)),
// //                     child: Icon(
// //                         isEdit
// //                             ? Icons.edit_calendar_rounded
// //                             : Icons.add_alarm_rounded,
// //                         color: AppColors.primaryColor,
// //                         size: 22),
// //                   ),
// //                   const SizedBox(width: 12),
// //                   Expanded(
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         Text(
// //                           isEdit ? 'Edit Slot' : 'Create Slot',
// //                           style: GoogleFonts.poppins(
// //                               fontSize: size.customWidth(context) * 0.046,
// //                               fontWeight: FontWeight.bold,
// //                               color: AppColors.textPrimaryColor),
// //                         ),
// //                         Text(
// //                           isEdit
// //                               ? 'Update availability slot'
// //                               : 'Set your availability',
// //                           style: GoogleFonts.poppins(
// //                               fontSize: size.customWidth(context) * 0.031,
// //                               color: AppColors.textSecondaryColor),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //               SizedBox(height: size.customHeight(context) * 0.025),

// //               // ── Date picker ──────────────────────────────────
// //               _label(context, size, 'Date'),
// //               const SizedBox(height: 8),
// //               _pickerTile(
// //                 icon: Icons.calendar_today_rounded,
// //                 value: _fmtDate(_date),
// //                 hasValue: _date != null,
// //                 color: AppColors.primaryColor,
// //                 onTap: () async {
// //                   final picked = await showDatePicker(
// //                     context: context,
// //                     initialDate: _date ?? DateTime.now(),
// //                     firstDate: DateTime.now(),
// //                     lastDate:
// //                         DateTime.now().add(const Duration(days: 365)),
// //                     builder: (ctx, child) => Theme(
// //                       data: Theme.of(ctx).copyWith(
// //                         colorScheme: const ColorScheme.light(
// //                             primary: AppColors.primaryColor),
// //                       ),
// //                       child: child!,
// //                     ),
// //                   );
// //                   if (picked != null) setState(() => _date = picked);
// //                 },
// //               ),
// //               SizedBox(height: size.customHeight(context) * 0.018),

// //               // ── Time pickers ─────────────────────────────────
// //               Row(
// //                 children: [
// //                   Expanded(
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         _label(context, size, 'Start Time'),
// //                         const SizedBox(height: 8),
// //                         _pickerTile(
// //                           icon: Icons.access_time_rounded,
// //                           value: _fmtTime(_startTime),
// //                           hasValue: _startTime != null,
// //                           color: AppColors.primaryColor,
// //                           onTap: () async {
// //                             final t = await showTimePicker(
// //                               context: context,
// //                               initialTime:
// //                                   _startTime ?? const TimeOfDay(hour: 9, minute: 0),
// //                               builder: (ctx, child) => Theme(
// //                                 data: Theme.of(ctx).copyWith(
// //                                     colorScheme: const ColorScheme.light(
// //                                         primary: AppColors.primaryColor)),
// //                                 child: child!,
// //                               ),
// //                             );
// //                             if (t != null) setState(() => _startTime = t);
// //                           },
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                   SizedBox(width: size.customWidth(context) * 0.03),
// //                   Expanded(
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         _label(context, size, 'End Time'),
// //                         const SizedBox(height: 8),
// //                         _pickerTile(
// //                           icon: Icons.access_time_filled_rounded,
// //                           value: _fmtTime(_endTime),
// //                           hasValue: _endTime != null,
// //                           color: AppColors.secondaryColor,
// //                           onTap: () async {
// //                             final t = await showTimePicker(
// //                               context: context,
// //                               initialTime: _endTime ??
// //                                   const TimeOfDay(hour: 9, minute: 30),
// //                               builder: (ctx, child) => Theme(
// //                                 data: Theme.of(ctx).copyWith(
// //                                     colorScheme: const ColorScheme.light(
// //                                         primary: AppColors.secondaryColor)),
// //                                 child: child!,
// //                               ),
// //                             );
// //                             if (t != null) setState(() => _endTime = t);
// //                           },
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //               SizedBox(height: size.customHeight(context) * 0.018),

// //               // ── Mode selector ────────────────────────────────
// //               _label(context, size, 'Consultation Mode'),
// //               const SizedBox(height: 10),
// //               Row(
// //                 children: [
// //                   _modeChip('online', 'Online',
// //                       Icons.videocam_outlined, AppColors.accentColor),
// //                   SizedBox(width: size.customWidth(context) * 0.025),
// //                   _modeChip('physical', 'Physical',
// //                       Icons.location_on_outlined, AppColors.warningColor),
// //                   SizedBox(width: size.customWidth(context) * 0.025),
// //                   _modeChip('both', 'Both',
// //                       Icons.swap_horiz_rounded, AppColors.primaryColor),
// //                 ],
// //               ),
// //               SizedBox(height: size.customHeight(context) * 0.018),

// //               // ── Fee fields ───────────────────────────────────
// //               if (_mode != 'physical') ...[
// //                 _label(context, size, 'Online Fee'),
// //                 const SizedBox(height: 8),
// //                 _feeField(
// //                     ctrl: _c.feeOnlineCtrl,
// //                     hint: 'e.g. 2500',
// //                     icon: Icons.videocam_outlined,
// //                     color: AppColors.accentColor),
// //                 SizedBox(height: size.customHeight(context) * 0.018),
// //               ],
// //               if (_mode != 'online') ...[
// //                 _label(context, size, 'Physical Fee'),
// //                 const SizedBox(height: 8),
// //                 _feeField(
// //                     ctrl: _c.feePhysicalCtrl,
// //                     hint: 'e.g. 3000',
// //                     icon: Icons.location_on_outlined,
// //                     color: AppColors.warningColor),
// //                 SizedBox(height: size.customHeight(context) * 0.018),
// //               ],

// //               // ── Currency ──────────────────────────────────────
// //               _label(context, size, 'Currency'),
// //               const SizedBox(height: 8),
// //               _feeField(
// //                   ctrl: _c.currencyCtrl,
// //                   hint: 'PKR',
// //                   icon: Icons.currency_exchange_rounded,
// //                   color: AppColors.primaryColor),
// //               SizedBox(height: size.customHeight(context) * 0.018),

// //               // ── Location picker ───────────────────────────────
// //               _label(context, size, 'Location (optional)'),
// //               const SizedBox(height: 8),
// //               _locationSelector(context, size),
// //               SizedBox(height: size.customHeight(context) * 0.018),

// //               // ── Status ───────────────────────────────────────
// //               _label(context, size, 'Status'),
// //               const SizedBox(height: 10),
// //               Row(
// //                 children: [
// //                   _statusChip('available', AppColors.successColor),
// //                   SizedBox(width: size.customWidth(context) * 0.025),
// //                   _statusChip('cancelled', AppColors.errorColor),
// //                 ],
// //               ),
// //               SizedBox(height: size.customHeight(context) * 0.018),

// //               // ── Recurring ────────────────────────────────────
// //               _recurringToggle(context, size),
// //               if (_recurring) ...[
// //                 SizedBox(height: size.customHeight(context) * 0.015),
// //                 _label(context, size, 'Recurrence Rule'),
// //                 const SizedBox(height: 8),
// //                 TextFormField(
// //                   controller: _c.recurrenceCtrl,
// //                   style: GoogleFonts.poppins(
// //                       fontSize: 14, color: AppColors.textPrimaryColor),
// //                   decoration: _inputDeco(
// //                       hint: 'e.g. Weekly Every Monday',
// //                       icon: Icons.repeat_rounded,
// //                       iconColor: AppColors.primaryColor),
// //                 ),
// //               ],
// //               SizedBox(height: size.customHeight(context) * 0.03),

// //               // ── Submit ────────────────────────────────────────
// //               SizedBox(
// //                 width: double.infinity,
// //                 child: ElevatedButton(
// //                   onPressed: _saving
// //                       ? null
// //                       : () async {
// //                           _sync();
// //                           setState(() => _saving = true);
// //                           bool ok;
// //                           String dayName = '';
// //                           if (isEdit) {
// //                             ok = await _c.updateSlot(
// //                                 widget.editingSlot!.slotId);
// //                           } else {
// //                             ok = await _c.createSlot();
// //                             dayName = _c.selectedDayName;
// //                           }
// //                           if (mounted) setState(() => _saving = false);
// //                           if (ok && context.mounted) {
// //                             Navigator.pop(context);
// //                             if (!isEdit && dayName.isNotEmpty) {
// //                               widget.onCreated(dayName);
// //                             }
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
// //                           isEdit ? 'Update Slot' : 'Create Slot',
// //                           style: GoogleFonts.poppins(
// //                               fontWeight: FontWeight.w600,
// //                               fontSize:
// //                                   widget.size.customWidth(context) * 0.042),
// //                         ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _modeChip(
// //       String value, String label, IconData icon, Color color) {
// //     final selected = _mode == value;
// //     return Expanded(
// //       child: GestureDetector(
// //         onTap: () => setState(() => _mode = value),
// //         child: Container(
// //           padding: const EdgeInsets.symmetric(vertical: 12),
// //           decoration: BoxDecoration(
// //             color: selected ? color : color.withOpacity(0.06),
// //             borderRadius: BorderRadius.circular(12),
// //             border: Border.all(
// //                 color: selected ? color : color.withOpacity(0.25),
// //                 width: selected ? 0 : 1),
// //           ),
// //           child: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               Icon(icon,
// //                   color: selected ? Colors.white : color, size: 20),
// //               const SizedBox(height: 4),
// //               Text(label,
// //                   style: GoogleFonts.poppins(
// //                       fontSize: 11,
// //                       fontWeight: FontWeight.w600,
// //                       color: selected
// //                           ? Colors.white
// //                           : AppColors.textSecondaryColor)),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _statusChip(String value, Color color) {
// //     final selected = _status == value;
// //     return GestureDetector(
// //       onTap: () => setState(() => _status = value),
// //       child: Container(
// //         padding:
// //             const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
// //         decoration: BoxDecoration(
// //           color: selected ? color : color.withOpacity(0.06),
// //           borderRadius: BorderRadius.circular(12),
// //           border: Border.all(
// //               color: selected ? color : color.withOpacity(0.25),
// //               width: 1),
// //         ),
// //         child: Text(
// //           value[0].toUpperCase() + value.substring(1),
// //           style: GoogleFonts.poppins(
// //               fontSize: 13,
// //               fontWeight: FontWeight.w600,
// //               color: selected ? Colors.white : color),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _recurringToggle(BuildContext context, CustomSize size) {
// //     return Container(
// //       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
// //       decoration: BoxDecoration(
// //         color: AppColors.lightGreyColor,
// //         borderRadius: BorderRadius.circular(14),
// //         border: Border.all(
// //             color: AppColors.greyColor.withOpacity(0.2), width: 1),
// //       ),
// //       child: Row(
// //         children: [
// //           Icon(Icons.repeat_rounded,
// //               color: _recurring
// //                   ? AppColors.primaryColor
// //                   : AppColors.textSecondaryColor,
// //               size: 22),
// //           const SizedBox(width: 12),
// //           Expanded(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text('Recurring Slot',
// //                     style: GoogleFonts.poppins(
// //                         fontSize: 14,
// //                         fontWeight: FontWeight.w600,
// //                         color: AppColors.textPrimaryColor)),
// //                 Text('Repeat weekly on this day',
// //                     style: GoogleFonts.poppins(
// //                         fontSize: 12,
// //                         color: AppColors.textSecondaryColor)),
// //               ],
// //             ),
// //           ),
// //           Switch(
// //             value: _recurring,
// //             onChanged: (v) => setState(() => _recurring = v),
// //             activeColor: AppColors.primaryColor,
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _locationSelector(BuildContext context, CustomSize size) {
// //     return GestureDetector(
// //       onTap: () => _showLocationPicker(context),
// //       child: Container(
// //         padding:
// //             const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
// //         decoration: BoxDecoration(
// //           color: AppColors.lightGreyColor,
// //           borderRadius: BorderRadius.circular(14),
// //           border: Border.all(
// //               color: _locationId.isNotEmpty
// //                   ? AppColors.primaryColor.withOpacity(0.4)
// //                   : AppColors.greyColor.withOpacity(0.2),
// //               width: 1),
// //         ),
// //         child: Row(
// //           children: [
// //             Icon(Icons.location_on_outlined,
// //                 color: _locationId.isNotEmpty
// //                     ? AppColors.primaryColor
// //                     : AppColors.textSecondaryColor,
// //                 size: 22),
// //             const SizedBox(width: 12),
// //             Expanded(
// //               child: Text(
// //                 _locationId.isEmpty ? 'No location selected' : _locationLabel,
// //                 style: GoogleFonts.poppins(
// //                     fontSize: 14,
// //                     color: _locationId.isEmpty
// //                         ? AppColors.textSecondaryColor.withOpacity(0.7)
// //                         : AppColors.textPrimaryColor,
// //                     fontWeight: _locationId.isNotEmpty
// //                         ? FontWeight.w500
// //                         : FontWeight.normal),
// //               ),
// //             ),
// //             const Icon(Icons.chevron_right_rounded,
// //                 color: AppColors.textSecondaryColor, size: 20),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   void _showLocationPicker(BuildContext context) {
// //     final locs = _c.myLocations;
// //     showModalBottomSheet(
// //       context: context,
// //       backgroundColor: Colors.transparent,
// //       isScrollControlled: true,
// //       builder: (_) => ConstrainedBox(
// //         constraints: BoxConstraints(
// //             maxHeight: MediaQuery.of(context).size.height * 0.6),
// //         child: Container(
// //           decoration: const BoxDecoration(
// //               color: AppColors.whiteColor,
// //               borderRadius:
// //                   BorderRadius.vertical(top: Radius.circular(24))),
// //           padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
// //           child: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Center(
// //                 child: Container(
// //                     width: 44,
// //                     height: 4,
// //                     decoration: BoxDecoration(
// //                         color: AppColors.greyColor.withOpacity(0.3),
// //                         borderRadius: BorderRadius.circular(2))),
// //               ),
// //               const SizedBox(height: 16),
// //               Text('Select Location',
// //                   style: GoogleFonts.poppins(
// //                       fontSize: 17,
// //                       fontWeight: FontWeight.bold,
// //                       color: AppColors.textPrimaryColor)),
// //               const SizedBox(height: 14),
// //               // None option
// //               _locationTile(
// //                 label: 'No location',
// //                 sublabel: 'Skip location selection',
// //                 icon: Icons.location_off_outlined,
// //                 selected: _locationId.isEmpty,
// //                 onTap: () {
// //                   setState(() {
// //                     _locationId = '';
// //                     _locationLabel = 'None';
// //                   });
// //                   Navigator.pop(context);
// //                 },
// //               ),
// //               const SizedBox(height: 8),
// //               if (locs.isEmpty)
// //                 Padding(
// //                   padding: const EdgeInsets.all(12),
// //                   child: Text(
// //                     'No locations found. Add locations in the Locations section.',
// //                     style: GoogleFonts.poppins(
// //                         fontSize: 13,
// //                         color: AppColors.textSecondaryColor),
// //                     textAlign: TextAlign.center,
// //                   ),
// //                 )
// //               else
// //                 Flexible(
// //                   child: ListView.builder(
// //                     shrinkWrap: true,
// //                     itemCount: locs.length,
// //                     itemBuilder: (_, i) {
// //                       final loc = locs[i];
// //                       return Padding(
// //                         padding: const EdgeInsets.only(bottom: 8),
// //                         child: _locationTile(
// //                           label: loc.label,
// //                           sublabel: '${loc.address}, ${loc.city}',
// //                           icon: Icons.business_rounded,
// //                           selected: _locationId == loc.locationId,
// //                           onTap: () {
// //                             setState(() {
// //                               _locationId = loc.locationId;
// //                               _locationLabel = loc.label;
// //                             });
// //                             Navigator.pop(context);
// //                           },
// //                         ),
// //                       );
// //                     },
// //                   ),
// //                 ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _locationTile({
// //     required String label,
// //     required String sublabel,
// //     required IconData icon,
// //     required bool selected,
// //     required VoidCallback onTap,
// //   }) {
// //     return GestureDetector(
// //       onTap: onTap,
// //       child: Container(
// //         padding:
// //             const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
// //         decoration: BoxDecoration(
// //           color: selected
// //               ? AppColors.primaryColor.withOpacity(0.08)
// //               : AppColors.lightGreyColor,
// //           borderRadius: BorderRadius.circular(14),
// //           border: Border.all(
// //               color: selected
// //                   ? AppColors.primaryColor.withOpacity(0.4)
// //                   : AppColors.greyColor.withOpacity(0.2),
// //               width: 1),
// //         ),
// //         child: Row(
// //           children: [
// //             Icon(icon,
// //                 color: selected
// //                     ? AppColors.primaryColor
// //                     : AppColors.textSecondaryColor,
// //                 size: 22),
// //             const SizedBox(width: 12),
// //             Expanded(
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(label,
// //                       style: GoogleFonts.poppins(
// //                           fontSize: 14,
// //                           fontWeight: FontWeight.w600,
// //                           color: selected
// //                               ? AppColors.primaryColor
// //                               : AppColors.textPrimaryColor)),
// //                   Text(sublabel,
// //                       style: GoogleFonts.poppins(
// //                           fontSize: 12,
// //                           color: AppColors.textSecondaryColor)),
// //                 ],
// //               ),
// //             ),
// //             if (selected)
// //               const Icon(Icons.check_circle_rounded,
// //                   color: AppColors.primaryColor, size: 20),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _pickerTile({
// //     required IconData icon,
// //     required String value,
// //     required bool hasValue,
// //     required Color color,
// //     required VoidCallback onTap,
// //   }) {
// //     return GestureDetector(
// //       onTap: onTap,
// //       child: Container(
// //         width: double.infinity,
// //         padding:
// //             const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
// //         decoration: BoxDecoration(
// //           color: AppColors.lightGreyColor,
// //           borderRadius: BorderRadius.circular(14),
// //           border: Border.all(
// //               color: hasValue
// //                   ? color.withOpacity(0.4)
// //                   : AppColors.greyColor.withOpacity(0.2),
// //               width: 1),
// //         ),
// //         child: Row(
// //           children: [
// //             Icon(icon,
// //                 color: hasValue ? color : AppColors.textSecondaryColor,
// //                 size: 20),
// //             const SizedBox(width: 10),
// //             Text(value,
// //                 style: GoogleFonts.poppins(
// //                     fontSize: 14,
// //                     color: hasValue
// //                         ? AppColors.textPrimaryColor
// //                         : AppColors.textSecondaryColor.withOpacity(0.7),
// //                     fontWeight: hasValue
// //                         ? FontWeight.w500
// //                         : FontWeight.normal)),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _feeField({
// //     required TextEditingController ctrl,
// //     required String hint,
// //     required IconData icon,
// //     required Color color,
// //   }) {
// //     return TextFormField(
// //       controller: ctrl,
// //       keyboardType:
// //           const TextInputType.numberWithOptions(decimal: true),
// //       style: GoogleFonts.poppins(
// //           fontSize: 14, color: AppColors.textPrimaryColor),
// //       decoration: _inputDeco(hint: hint, icon: icon, iconColor: color),
// //     );
// //   }

// //   InputDecoration _inputDeco(
// //       {required String hint,
// //       required IconData icon,
// //       required Color iconColor}) {
// //     return InputDecoration(
// //       hintText: hint,
// //       hintStyle: GoogleFonts.poppins(
// //           fontSize: 14,
// //           color: AppColors.textSecondaryColor.withOpacity(0.7)),
// //       prefixIcon: Icon(icon, color: iconColor, size: 20),
// //       filled: true,
// //       fillColor: AppColors.lightGreyColor,
// //       contentPadding:
// //           const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
// //       border: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(14),
// //           borderSide: BorderSide.none),
// //       enabledBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(14),
// //           borderSide: BorderSide(
// //               color: AppColors.greyColor.withOpacity(0.2), width: 1)),
// //       focusedBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(14),
// //           borderSide:
// //               const BorderSide(color: AppColors.primaryColor, width: 1.5)),
// //     );
// //   }

// //   Widget _label(BuildContext context, CustomSize size, String text) {
// //     return Text(text,
// //         style: GoogleFonts.poppins(
// //             fontSize: size.customWidth(context) * 0.036,
// //             fontWeight: FontWeight.w600,
// //             color: AppColors.textPrimaryColor));
// //   }
// // }

// // // ═══════════════════════════════════════════════════════════════
// // //   Delete Slot Dialog
// // // ═══════════════════════════════════════════════════════════════
// // class _DeleteSlotDialog extends StatefulWidget {
// //   final SlotItem slot;
// //   final SlotController controller;

// //   const _DeleteSlotDialog({required this.slot, required this.controller});

// //   @override
// //   State<_DeleteSlotDialog> createState() => _DeleteSlotDialogState();
// // }

// // class _DeleteSlotDialogState extends State<_DeleteSlotDialog> {
// //   bool _deleting = false;

// //   @override
// //   Widget build(BuildContext context) {
// //     return AlertDialog(
// //       shape:
// //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
// //       contentPadding: const EdgeInsets.all(24),
// //       content: Column(
// //         mainAxisSize: MainAxisSize.min,
// //         children: [
// //           Container(
// //             padding: const EdgeInsets.all(16),
// //             decoration: BoxDecoration(
// //                 color: AppColors.errorColor.withOpacity(0.1),
// //                 shape: BoxShape.circle),
// //             child: const Icon(Icons.delete_forever_rounded,
// //                 color: AppColors.errorColor, size: 36),
// //           ),
// //           const SizedBox(height: 16),
// //           Text('Delete Slot?',
// //               style: GoogleFonts.poppins(
// //                   fontSize: 18,
// //                   fontWeight: FontWeight.bold,
// //                   color: AppColors.textPrimaryColor)),
// //           const SizedBox(height: 8),
// //           Text(
// //             '${widget.slot.formattedDate}\n${widget.slot.formattedStartTime} – ${widget.slot.formattedEndTime}',
// //             textAlign: TextAlign.center,
// //             style: GoogleFonts.poppins(
// //                 fontSize: 14,
// //                 color: AppColors.textSecondaryColor,
// //                 height: 1.5),
// //           ),
// //           const SizedBox(height: 24),
// //           Row(
// //             children: [
// //               Expanded(
// //                 child: OutlinedButton(
// //                   onPressed:
// //                       _deleting ? null : () => Navigator.pop(context),
// //                   style: OutlinedButton.styleFrom(
// //                     foregroundColor: AppColors.textSecondaryColor,
// //                     side: BorderSide(
// //                         color: AppColors.greyColor.withOpacity(0.4)),
// //                     shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(12)),
// //                     padding:
// //                         const EdgeInsets.symmetric(vertical: 13),
// //                   ),
// //                   child: Text('Cancel',
// //                       style: GoogleFonts.poppins(
// //                           fontWeight: FontWeight.w500, fontSize: 14)),
// //                 ),
// //               ),
// //               const SizedBox(width: 12),
// //               Expanded(
// //                 child: ElevatedButton(
// //                   onPressed: _deleting
// //                       ? null
// //                       : () async {
// //                           setState(() => _deleting = true);
// //                           final ok = await widget.controller
// //                               .deleteSlot(widget.slot.slotId);
// //                           if (mounted)
// //                             setState(() => _deleting = false);
// //                           if (ok && context.mounted)
// //                             Navigator.pop(context);
// //                         },
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: AppColors.errorColor,
// //                     foregroundColor: Colors.white,
// //                     disabledBackgroundColor:
// //                         AppColors.errorColor.withOpacity(0.5),
// //                     shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(12)),
// //                     padding:
// //                         const EdgeInsets.symmetric(vertical: 13),
// //                     elevation: 0,
// //                   ),
// //                   child: _deleting
// //                       ? const SizedBox(
// //                           width: 18,
// //                           height: 18,
// //                           child: CircularProgressIndicator(
// //                               color: Colors.white, strokeWidth: 2))
// //                       : Text('Delete',
// //                           style: GoogleFonts.poppins(
// //                               fontWeight: FontWeight.w600,
// //                               fontSize: 14)),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // lib/view/expert/slots/expert_slots_screen.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/slot_controller.dart';
// import 'package:speechspectrum/models/slot_model.dart';
// import 'package:speechspectrum/models/location_model.dart';

// class ExpertSlotsScreen extends StatefulWidget {
//   const ExpertSlotsScreen({super.key});

//   @override
//   State<ExpertSlotsScreen> createState() => _ExpertSlotsScreenState();
// }

// class _ExpertSlotsScreenState extends State<ExpertSlotsScreen> {
//   late final SlotController _c;

//   @override
//   void initState() {
//     super.initState();
//     _c = Get.isRegistered<SlotController>()
//         ? Get.find<SlotController>()
//         : Get.put(SlotController());
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _c.fetchMySlots();
//       _c.fetchMyLocations();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();
//     return Scaffold(
//       backgroundColor: AppColors.lightGreyColor,
//       appBar: _appBar(context, size),
//       body: Obx(() {
//         if (_c.isLoading.value && _c.mySlots.isEmpty) {
//           return _loader(context, size);
//         }
//         return RefreshIndicator(
//           color: AppColors.primaryColor,
//           onRefresh: () async {
//             await _c.fetchMySlots();
//             await _c.fetchMyLocations();
//           },
//           child: ListView(
//             physics: const BouncingScrollPhysics(
//                 parent: AlwaysScrollableScrollPhysics()),
//             padding: EdgeInsets.fromLTRB(
//               size.customWidth(context) * 0.05,
//               size.customHeight(context) * 0.02,
//               size.customWidth(context) * 0.05,
//               size.customHeight(context) * 0.12,
//             ),
//             children: [
//               _headerBanner(context, size),
//               SizedBox(height: size.customHeight(context) * 0.025),
//               _weekDayGrid(context, size),
//               SizedBox(height: size.customHeight(context) * 0.025),
//               if (_c.mySlots.isEmpty)
//                 _emptySlots(context, size)
//               else ...[
//                 _sectionTitle(context, size, 'Your Slots'),
//                 SizedBox(height: size.customHeight(context) * 0.015),
//                 ..._c.mySlots.map((s) => _slotCard(context, size, s)).toList(),
//               ],
//             ],
//           ),
//         );
//       }),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {
//           _c.resetForm();
//           _openSlotSheet(context, size);
//         },
//         backgroundColor: AppColors.primaryColor,
//         icon: const Icon(Icons.add_alarm_rounded, color: Colors.white),
//         label: Text('Add Slot',
//             style: GoogleFonts.poppins(
//                 color: Colors.white,
//                 fontWeight: FontWeight.w600,
//                 fontSize: 14)),
//       ),
//     );
//   }

//   PreferredSizeWidget _appBar(BuildContext context, CustomSize size) {
//     return AppBar(
//       backgroundColor: AppColors.whiteColor,
//       elevation: 0,
//       surfaceTintColor: Colors.transparent,
//       leading: IconButton(
//         icon: const Icon(Icons.arrow_back_ios_new_rounded,
//             color: AppColors.textPrimaryColor, size: 20),
//         onPressed: () => Get.back(),
//       ),
//       title: Text('My Slots',
//           style: GoogleFonts.poppins(
//               color: AppColors.textPrimaryColor,
//               fontSize: 18,
//               fontWeight: FontWeight.w600)),
//       actions: [
//         Obx(() => _c.isLoading.value
//             ? const Padding(
//                 padding: EdgeInsets.all(16),
//                 child: SizedBox(
//                     width: 20,
//                     height: 20,
//                     child: CircularProgressIndicator(
//                         color: AppColors.primaryColor, strokeWidth: 2)),
//               )
//             : IconButton(
//                 icon: const Icon(Icons.refresh_rounded,
//                     color: AppColors.primaryColor),
//                 onPressed: () {
//                   _c.fetchMySlots();
//                   _c.fetchMyLocations();
//                 },
//               )),
//         const SizedBox(width: 4),
//       ],
//     );
//   }

//   Widget _headerBanner(BuildContext context, CustomSize size) {
//     return Container(
//       padding: EdgeInsets.all(size.customWidth(context) * 0.05),
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [AppColors.primaryColor, AppColors.secondaryColor],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(22),
//         boxShadow: [
//           BoxShadow(
//               color: AppColors.primaryColor.withOpacity(0.28),
//               blurRadius: 18,
//               offset: const Offset(0, 5))
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(14)),
//             child: const Icon(Icons.calendar_month_rounded,
//                 color: Colors.white, size: 28),
//           ),
//           SizedBox(width: size.customWidth(context) * 0.04),
//           Expanded(
//             child: Obx(() => Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       '${_c.mySlots.length} Slot${_c.mySlots.length != 1 ? 's' : ''} Created',
//                       style: GoogleFonts.poppins(
//                           color: Colors.white,
//                           fontSize: size.customWidth(context) * 0.044,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       '${_c.createdDays.length} of 7 days covered this week',
//                       style: GoogleFonts.poppins(
//                           color: Colors.white.withOpacity(0.85),
//                           fontSize: size.customWidth(context) * 0.031),
//                     ),
//                   ],
//                 )),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _weekDayGrid(BuildContext context, CustomSize size) {
//     return Obx(() {
//       final days = SlotController.weekDays;
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _sectionTitle(context, size, 'Weekly Coverage'),
//           SizedBox(height: size.customHeight(context) * 0.015),
//           Row(
//             children: days.map((day) {
//               final hasSlot = _c.createdDays.contains(day);
//               final shortDay = day.substring(0, 3);
//               return Expanded(
//                 child: GestureDetector(
//                   onTap: () {
//                     if (hasSlot) {
//                       _showDaySlotsSheet(context, size, day);
//                     } else {
//                       _c.resetForm();
//                       // Pre-select next occurrence of this day
//                       final now = DateTime.now();
//                       final targetWeekday = days.indexOf(day) + 1;
//                       var diff = targetWeekday - now.weekday;
//                       if (diff <= 0) diff += 7;
//                       _c.selectedDate.value = now.add(Duration(days: diff));
//                       _openSlotSheet(context, size);
//                     }
//                   },
//                   child: Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 3),
//                     padding: const EdgeInsets.symmetric(vertical: 10),
//                     decoration: BoxDecoration(
//                       color: hasSlot
//                           ? AppColors.primaryColor
//                           : AppColors.whiteColor,
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(
//                         color: hasSlot
//                             ? AppColors.primaryColor
//                             : AppColors.greyColor.withOpacity(0.3),
//                         width: 1,
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                             color: Colors.black.withOpacity(0.04),
//                             blurRadius: 6,
//                             offset: const Offset(0, 2))
//                       ],
//                     ),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         if (hasSlot)
//                           const Icon(Icons.check_circle_rounded,
//                               color: Colors.white, size: 14)
//                         else
//                           Icon(Icons.add_rounded,
//                               color: AppColors.primaryColor.withOpacity(0.6),
//                               size: 14),
//                         const SizedBox(height: 4),
//                         Text(
//                           shortDay,
//                           style: GoogleFonts.poppins(
//                             fontSize: 11,
//                             fontWeight: FontWeight.w600,
//                             color: hasSlot
//                                 ? Colors.white
//                                 : AppColors.textSecondaryColor,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             }).toList(),
//           ),
//         ],
//       );
//     });
//   }

//   Widget _sectionTitle(BuildContext context, CustomSize size, String title) {
//     return Row(
//       children: [
//         Container(
//           width: 4,
//           height: 20,
//           decoration: BoxDecoration(
//               color: AppColors.primaryColor,
//               borderRadius: BorderRadius.circular(2)),
//         ),
//         SizedBox(width: size.customWidth(context) * 0.025),
//         Text(title,
//             style: GoogleFonts.poppins(
//                 fontSize: size.customWidth(context) * 0.042,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.textPrimaryColor)),
//       ],
//     );
//   }

//   Widget _slotCard(BuildContext context, CustomSize size, SlotItem slot) {
//     Color statusColor;
//     switch (slot.status.toLowerCase()) {
//       case 'booked':
//         statusColor = AppColors.warningColor;
//         break;
//       case 'cancelled':
//         statusColor = AppColors.errorColor;
//         break;
//       default:
//         statusColor = AppColors.successColor;
//     }

//     Color modeColor;
//     IconData modeIcon;
//     switch (slot.mode.toLowerCase()) {
//       case 'online':
//         modeColor = AppColors.accentColor;
//         modeIcon = Icons.videocam_outlined;
//         break;
//       case 'physical':
//         modeColor = AppColors.warningColor;
//         modeIcon = Icons.location_on_outlined;
//         break;
//       default:
//         modeColor = AppColors.primaryColor;
//         modeIcon = Icons.swap_horiz_rounded;
//     }

//     return Container(
//       margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.015),
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withOpacity(0.06),
//               blurRadius: 14,
//               offset: const Offset(0, 4))
//         ],
//       ),
//       child: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(size.customWidth(context) * 0.042),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Day badge
//                 Container(
//                   width: 52,
//                   height: 58,
//                   decoration: BoxDecoration(
//                     color: AppColors.primaryColor.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(14),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(slot.dayOfWeek,
//                           style: GoogleFonts.poppins(
//                               fontSize: 10,
//                               color: AppColors.primaryColor,
//                               fontWeight: FontWeight.w600)),
//                       Text(
//                         slot.slotDate.split('-')[2],
//                         style: GoogleFonts.poppins(
//                             fontSize: 17,
//                             fontWeight: FontWeight.bold,
//                             color: AppColors.primaryColor),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(width: size.customWidth(context) * 0.03),

//                 // All content in Expanded — no sibling badge fighting for space
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Top row: time + status badge
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           const Icon(Icons.access_time_rounded,
//                               size: 13,
//                               color: AppColors.textSecondaryColor),
//                           const SizedBox(width: 4),
//                           Expanded(
//                             child: Text(
//                               '${slot.formattedStartTime} – ${slot.formattedEndTime}',
//                               style: GoogleFonts.poppins(
//                                   fontSize: size.customWidth(context) * 0.036,
//                                   fontWeight: FontWeight.w600,
//                                   color: AppColors.textPrimaryColor),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                           const SizedBox(width: 8),
//                           // Status badge inside Expanded — never overflows
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 9, vertical: 3),
//                             decoration: BoxDecoration(
//                               color: statusColor.withOpacity(0.1),
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             child: Text(
//                               slot.status[0].toUpperCase() +
//                                   slot.status.substring(1),
//                               style: GoogleFonts.poppins(
//                                   fontSize: 10,
//                                   fontWeight: FontWeight.w600,
//                                   color: statusColor),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: size.customHeight(context) * 0.007),

//                       // Mode chip
//                       Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Icon(modeIcon, size: 12, color: modeColor),
//                           const SizedBox(width: 4),
//                           Text(
//                             slot.mode[0].toUpperCase() +
//                                 slot.mode.substring(1),
//                             style: GoogleFonts.poppins(
//                                 fontSize: 11,
//                                 color: modeColor,
//                                 fontWeight: FontWeight.w500),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: size.customHeight(context) * 0.005),

//                       // Fees — use Wrap so they wrap on small screens
//                       Wrap(
//                         spacing: 10,
//                         runSpacing: 4,
//                         children: [
//                           if (slot.feeOnline != null)
//                             Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Icon(Icons.videocam_outlined,
//                                     size: 11,
//                                     color: AppColors.accentColor),
//                                 const SizedBox(width: 3),
//                                 Text(
//                                   '${slot.currency} ${slot.feeOnline!.toStringAsFixed(0)}',
//                                   style: GoogleFonts.poppins(
//                                       fontSize: 11,
//                                       color: AppColors.textSecondaryColor),
//                                 ),
//                               ],
//                             ),
//                           if (slot.feePhysical != null)
//                             Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Icon(Icons.location_on_outlined,
//                                     size: 11,
//                                     color: AppColors.warningColor),
//                                 const SizedBox(width: 3),
//                                 Text(
//                                   '${slot.currency} ${slot.feePhysical!.toStringAsFixed(0)}',
//                                   style: GoogleFonts.poppins(
//                                       fontSize: 11,
//                                       color: AppColors.textSecondaryColor),
//                                 ),
//                               ],
//                             ),
//                         ],
//                       ),

//                       // Recurrence
//                       if (slot.isRecurring && slot.recurrenceRule != null) ...[
//                         SizedBox(height: size.customHeight(context) * 0.004),
//                         Row(children: [
//                           Icon(Icons.repeat_rounded,
//                               size: 11,
//                               color: AppColors.primaryColor.withOpacity(0.7)),
//                           const SizedBox(width: 3),
//                           Expanded(
//                             child: Text(
//                               slot.recurrenceRule!,
//                               style: GoogleFonts.poppins(
//                                   fontSize: 11,
//                                   color:
//                                       AppColors.primaryColor.withOpacity(0.7)),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                         ]),
//                       ],
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Divider(height: 1, color: AppColors.greyColor.withOpacity(0.15)),
//           // Actions row
//           Padding(
//             padding: EdgeInsets.symmetric(
//                 horizontal: size.customWidth(context) * 0.02,
//                 vertical: size.customHeight(context) * 0.005),
//             child: Row(
//               children: [
//                 _action(
//                   icon: Icons.edit_outlined,
//                   label: 'Edit',
//                   color: AppColors.warningColor,
//                   onTap: () {
//                     _c.populateFormFromSlot(slot);
//                     _openSlotSheet(context, size, editingSlot: slot);
//                   },
//                 ),
//                 _action(
//                   icon: Icons.delete_outline_rounded,
//                   label: 'Delete',
//                   color: AppColors.errorColor,
//                   onTap: () => _showDeleteConfirm(context, slot),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _action(
//       {required IconData icon,
//       required String label,
//       required Color color,
//       required VoidCallback onTap}) {
//     return Expanded(
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(10),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 10),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(icon, color: color, size: 19),
//               const SizedBox(height: 4),
//               Text(label,
//                   style: GoogleFonts.poppins(
//                       fontSize: 11,
//                       fontWeight: FontWeight.w500,
//                       color: color)),
//             ],
//           ),
//         ),
//       ),
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
//           Text('Loading your slots...',
//               style: GoogleFonts.poppins(
//                   color: AppColors.textSecondaryColor,
//                   fontSize: size.customWidth(context) * 0.036)),
//         ],
//       ),
//     );
//   }

//   Widget _emptySlots(BuildContext context, CustomSize size) {
//     return Center(
//       child: Column(
//         children: [
//           SizedBox(height: size.customHeight(context) * 0.04),
//           Container(
//             width: 120,
//             height: 120,
//             decoration: BoxDecoration(
//                 color: AppColors.primaryColor.withOpacity(0.08),
//                 shape: BoxShape.circle),
//             child: const Icon(Icons.calendar_today_outlined,
//                 size: 58, color: AppColors.primaryColor),
//           ),
//           SizedBox(height: size.customHeight(context) * 0.025),
//           Text('No Slots Yet',
//               style: GoogleFonts.poppins(
//                   fontSize: size.customWidth(context) * 0.05,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.textPrimaryColor)),
//           SizedBox(height: size.customHeight(context) * 0.01),
//           Text(
//             'Tap "Add Slot" or tap a day\nto create your first availability slot.',
//             textAlign: TextAlign.center,
//             style: GoogleFonts.poppins(
//                 fontSize: size.customWidth(context) * 0.034,
//                 color: AppColors.textSecondaryColor,
//                 height: 1.6),
//           ),
//         ],
//       ),
//     );
//   }

//   // ── Sheets & Dialogs ────────────────────────────────────────

//   void _openSlotSheet(BuildContext context, CustomSize size,
//       {SlotItem? editingSlot}) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       enableDrag: true,
//       builder: (_) => ConstrainedBox(
//         constraints: BoxConstraints(
//             maxHeight: MediaQuery.of(context).size.height * 0.94),
//         child: _SlotFormSheet(
//           controller: _c,
//           size: size,
//           editingSlot: editingSlot,
//           onCreated: (dayName) => _showAddAnotherDay(context, size, dayName),
//         ),
//       ),
//     );
//   }

//   void _showDaySlotsSheet(
//       BuildContext context, CustomSize size, String dayName) {
//     final slots = _c.getSlotsForDay(dayName);
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (_) => ConstrainedBox(
//         constraints: BoxConstraints(
//             maxHeight: MediaQuery.of(context).size.height * 0.75),
//         child: Container(
//           decoration: const BoxDecoration(
//             color: AppColors.whiteColor,
//             borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
//           ),
//           padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
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
//               const SizedBox(height: 16),
//               Row(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                         color: AppColors.primaryColor.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(10)),
//                     child: const Icon(Icons.calendar_today_rounded,
//                         color: AppColors.primaryColor, size: 20),
//                   ),
//                   const SizedBox(width: 12),
//                   Text('$dayName Slots',
//                       style: GoogleFonts.poppins(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: AppColors.textPrimaryColor)),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               Flexible(
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: slots.length,
//                   itemBuilder: (_, i) => _slotCard(context, size, slots[i]),
//                 ),
//               ),
//               const SizedBox(height: 12),
//               SizedBox(
//                 width: double.infinity,
//                 child: OutlinedButton.icon(
//                   onPressed: () {
//                     Navigator.pop(context);
//                     _c.resetForm();
//                     final now = DateTime.now();
//                     final targetWeekday =
//                         SlotController.weekDays.indexOf(dayName) + 1;
//                     var diff = targetWeekday - now.weekday;
//                     if (diff <= 0) diff += 7;
//                     _c.selectedDate.value = now.add(Duration(days: diff));
//                     _openSlotSheet(context, size);
//                   },
//                   style: OutlinedButton.styleFrom(
//                     foregroundColor: AppColors.primaryColor,
//                     side: BorderSide(
//                         color: AppColors.primaryColor.withOpacity(0.5)),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(14)),
//                     padding: const EdgeInsets.symmetric(vertical: 13),
//                   ),
//                   icon: const Icon(Icons.add_rounded, size: 18),
//                   label: Text('Add another slot on $dayName',
//                       style: GoogleFonts.poppins(
//                           fontWeight: FontWeight.w500, fontSize: 14)),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _showAddAnotherDay(
//       BuildContext context, CustomSize size, String justCreatedDay) {
//     final remaining = SlotController.weekDays
//         .where((d) => !_c.createdDays.contains(d))
//         .toList();

//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.transparent,
//       builder: (_) => Container(
//         decoration: const BoxDecoration(
//           color: AppColors.whiteColor,
//           borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
//         ),
//         padding: const EdgeInsets.fromLTRB(20, 20, 20, 36),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Center(
//               child: Container(
//                 width: 44,
//                 height: 4,
//                 decoration: BoxDecoration(
//                     color: AppColors.greyColor.withOpacity(0.3),
//                     borderRadius: BorderRadius.circular(2)),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Container(
//               padding: const EdgeInsets.all(14),
//               decoration: BoxDecoration(
//                   color: AppColors.successColor.withOpacity(0.1),
//                   shape: BoxShape.circle),
//               child: const Icon(Icons.check_circle_rounded,
//                   color: AppColors.successColor, size: 32),
//             ),
//             const SizedBox(height: 12),
//             Text(
//               '$justCreatedDay slot created! ✓',
//               style: GoogleFonts.poppins(
//                   fontSize: 17,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.textPrimaryColor),
//             ),
//             const SizedBox(height: 6),
//             Text(
//               remaining.isEmpty
//                   ? 'You have slots for all 7 days! 🎉'
//                   : 'Do you want to add a slot for another day?',
//               textAlign: TextAlign.center,
//               style: GoogleFonts.poppins(
//                   fontSize: 13,
//                   color: AppColors.textSecondaryColor),
//             ),
//             const SizedBox(height: 20),
//             if (remaining.isNotEmpty) ...[
//               Wrap(
//                 spacing: 8,
//                 runSpacing: 8,
//                 alignment: WrapAlignment.center,
//                 children: remaining.map((day) {
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context);
//                       _c.resetForm();
//                       final now = DateTime.now();
//                       final targetWeekday =
//                           SlotController.weekDays.indexOf(day) + 1;
//                       var diff = targetWeekday - now.weekday;
//                       if (diff <= 0) diff += 7;
//                       _c.selectedDate.value = now.add(Duration(days: diff));
//                       _openSlotSheet(context, size);
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 16, vertical: 10),
//                       decoration: BoxDecoration(
//                         color: AppColors.primaryColor.withOpacity(0.08),
//                         borderRadius: BorderRadius.circular(12),
//                         border: Border.all(
//                             color: AppColors.primaryColor.withOpacity(0.3)),
//                       ),
//                       child: Text(day,
//                           style: GoogleFonts.poppins(
//                               fontSize: 13,
//                               fontWeight: FontWeight.w600,
//                               color: AppColors.primaryColor)),
//                     ),
//                   );
//                 }).toList(),
//               ),
//               const SizedBox(height: 16),
//             ],
//             SizedBox(
//               width: double.infinity,
//               child: OutlinedButton(
//                 onPressed: () => Navigator.pop(context),
//                 style: OutlinedButton.styleFrom(
//                   foregroundColor: AppColors.textSecondaryColor,
//                   side: BorderSide(
//                       color: AppColors.greyColor.withOpacity(0.4)),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(14)),
//                   padding: const EdgeInsets.symmetric(vertical: 13),
//                 ),
//                 child: Text("I'm done for now",
//                     style: GoogleFonts.poppins(
//                         fontWeight: FontWeight.w500, fontSize: 14)),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showDeleteConfirm(BuildContext context, SlotItem slot) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (_) => _DeleteSlotDialog(slot: slot, controller: _c),
//     );
//   }
// }

// // ═══════════════════════════════════════════════════════════════
// //   Slot Form Bottom Sheet
// // ═══════════════════════════════════════════════════════════════
// class _SlotFormSheet extends StatefulWidget {
//   final SlotController controller;
//   final CustomSize size;
//   final SlotItem? editingSlot;
//   final void Function(String dayName) onCreated;

//   const _SlotFormSheet({
//     required this.controller,
//     required this.size,
//     this.editingSlot,
//     required this.onCreated,
//   });

//   @override
//   State<_SlotFormSheet> createState() => _SlotFormSheetState();
// }

// class _SlotFormSheetState extends State<_SlotFormSheet> {
//   final _formKey = GlobalKey<FormState>();
//   bool _saving = false;
//   late SlotController _c;

//   // Local mirror of reactive fields for pure setState rebuilds
//   String _mode = 'both';
//   bool _recurring = false;
//   DateTime? _date;
//   TimeOfDay? _startTime;
//   TimeOfDay? _endTime;
//   String _status = 'available';
//   String _locationId = '';
//   String _locationLabel = 'None';

//   @override
//   void initState() {
//     super.initState();
//     _c = widget.controller;
//     // Mirror from controller
//     _mode = _c.selectedMode.value;
//     _recurring = _c.isRecurring.value;
//     _date = _c.selectedDate.value;
//     _startTime = _c.selectedStartTime.value;
//     _endTime = _c.selectedEndTime.value;
//     _status = _c.selectedStatus.value;
//     _locationId = _c.selectedLocationId.value;
//     _locationLabel = _c.selectedLocationLabel.value.isEmpty
//         ? 'None'
//         : _c.selectedLocationLabel.value;
//   }

//   void _sync() {
//     _c.selectedMode.value = _mode;
//     _c.isRecurring.value = _recurring;
//     _c.selectedDate.value = _date;
//     _c.selectedStartTime.value = _startTime;
//     _c.selectedEndTime.value = _endTime;
//     _c.selectedStatus.value = _status;
//     _c.selectedLocationId.value = _locationId;
//   }

//   String _fmtTime(TimeOfDay? t) {
//     if (t == null) return 'Select';
//     final h = t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod;
//     final m = t.minute.toString().padLeft(2, '0');
//     final p = t.period == DayPeriod.am ? 'AM' : 'PM';
//     return '$h:$m $p';
//   }

//   String _fmtDate(DateTime? d) {
//     if (d == null) return 'Select date';
//     const months = [
//       '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
//       'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
//     ];
//     const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
//     return '${days[d.weekday - 1]}, ${d.day} ${months[d.month]} ${d.year}';
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = widget.size;
//     final isEdit = widget.editingSlot != null;

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
//               // Handle
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

//               // Header
//               Row(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                         color: AppColors.primaryColor.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(12)),
//                     child: Icon(
//                         isEdit
//                             ? Icons.edit_calendar_rounded
//                             : Icons.add_alarm_rounded,
//                         color: AppColors.primaryColor,
//                         size: 22),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           isEdit ? 'Edit Slot' : 'Create Slot',
//                           style: GoogleFonts.poppins(
//                               fontSize: size.customWidth(context) * 0.046,
//                               fontWeight: FontWeight.bold,
//                               color: AppColors.textPrimaryColor),
//                         ),
//                         Text(
//                           isEdit
//                               ? 'Update availability slot'
//                               : 'Set your availability',
//                           style: GoogleFonts.poppins(
//                               fontSize: size.customWidth(context) * 0.031,
//                               color: AppColors.textSecondaryColor),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: size.customHeight(context) * 0.025),

//               // ── Date picker ──────────────────────────────────
//               _label(context, size, 'Date'),
//               const SizedBox(height: 8),
//               _pickerTile(
//                 icon: Icons.calendar_today_rounded,
//                 value: _fmtDate(_date),
//                 hasValue: _date != null,
//                 color: AppColors.primaryColor,
//                 onTap: () async {
//                   final picked = await showDatePicker(
//                     context: context,
//                     initialDate: _date ?? DateTime.now(),
//                     firstDate: DateTime.now(),
//                     lastDate:
//                         DateTime.now().add(const Duration(days: 365)),
//                     builder: (ctx, child) => Theme(
//                       data: Theme.of(ctx).copyWith(
//                         colorScheme: const ColorScheme.light(
//                             primary: AppColors.primaryColor),
//                       ),
//                       child: child!,
//                     ),
//                   );
//                   if (picked != null) setState(() => _date = picked);
//                 },
//               ),
//               SizedBox(height: size.customHeight(context) * 0.018),

//               // ── Time pickers ─────────────────────────────────
//               Row(
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         _label(context, size, 'Start Time'),
//                         const SizedBox(height: 8),
//                         _pickerTile(
//                           icon: Icons.access_time_rounded,
//                           value: _fmtTime(_startTime),
//                           hasValue: _startTime != null,
//                           color: AppColors.primaryColor,
//                           onTap: () async {
//                             final t = await showTimePicker(
//                               context: context,
//                               initialTime:
//                                   _startTime ?? const TimeOfDay(hour: 9, minute: 0),
//                               builder: (ctx, child) => Theme(
//                                 data: Theme.of(ctx).copyWith(
//                                     colorScheme: const ColorScheme.light(
//                                         primary: AppColors.primaryColor)),
//                                 child: child!,
//                               ),
//                             );
//                             if (t != null) setState(() => _startTime = t);
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(width: size.customWidth(context) * 0.03),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         _label(context, size, 'End Time'),
//                         const SizedBox(height: 8),
//                         _pickerTile(
//                           icon: Icons.access_time_filled_rounded,
//                           value: _fmtTime(_endTime),
//                           hasValue: _endTime != null,
//                           color: AppColors.secondaryColor,
//                           onTap: () async {
//                             final t = await showTimePicker(
//                               context: context,
//                               initialTime: _endTime ??
//                                   const TimeOfDay(hour: 9, minute: 30),
//                               builder: (ctx, child) => Theme(
//                                 data: Theme.of(ctx).copyWith(
//                                     colorScheme: const ColorScheme.light(
//                                         primary: AppColors.secondaryColor)),
//                                 child: child!,
//                               ),
//                             );
//                             if (t != null) setState(() => _endTime = t);
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: size.customHeight(context) * 0.018),

//               // ── Mode selector ────────────────────────────────
//               _label(context, size, 'Consultation Mode'),
//               const SizedBox(height: 10),
//               Row(
//                 children: [
//                   _modeChip('online', 'Online',
//                       Icons.videocam_outlined, AppColors.accentColor),
//                   SizedBox(width: size.customWidth(context) * 0.025),
//                   _modeChip('physical', 'Physical',
//                       Icons.location_on_outlined, AppColors.warningColor),
//                   SizedBox(width: size.customWidth(context) * 0.025),
//                   _modeChip('both', 'Both',
//                       Icons.swap_horiz_rounded, AppColors.primaryColor),
//                 ],
//               ),
//               SizedBox(height: size.customHeight(context) * 0.018),

//               // ── Fee fields ───────────────────────────────────
//               if (_mode != 'physical') ...[
//                 _label(context, size, 'Online Fee'),
//                 const SizedBox(height: 8),
//                 _feeField(
//                     ctrl: _c.feeOnlineCtrl,
//                     hint: 'e.g. 2500',
//                     icon: Icons.videocam_outlined,
//                     color: AppColors.accentColor),
//                 SizedBox(height: size.customHeight(context) * 0.018),
//               ],
//               if (_mode != 'online') ...[
//                 _label(context, size, 'Physical Fee'),
//                 const SizedBox(height: 8),
//                 _feeField(
//                     ctrl: _c.feePhysicalCtrl,
//                     hint: 'e.g. 3000',
//                     icon: Icons.location_on_outlined,
//                     color: AppColors.warningColor),
//                 SizedBox(height: size.customHeight(context) * 0.018),
//               ],

//               // ── Currency ──────────────────────────────────────
//               _label(context, size, 'Currency'),
//               const SizedBox(height: 8),
//               _feeField(
//                   ctrl: _c.currencyCtrl,
//                   hint: 'PKR',
//                   icon: Icons.currency_exchange_rounded,
//                   color: AppColors.primaryColor),
//               SizedBox(height: size.customHeight(context) * 0.018),

//               // ── Location picker ───────────────────────────────
//               _label(context, size, 'Location (optional)'),
//               const SizedBox(height: 8),
//               _locationSelector(context, size),
//               SizedBox(height: size.customHeight(context) * 0.018),

//               // ── Status ───────────────────────────────────────
//               _label(context, size, 'Status'),
//               const SizedBox(height: 10),
//               Row(
//                 children: [
//                   _statusChip('available', AppColors.successColor),
//                   SizedBox(width: size.customWidth(context) * 0.025),
//                   _statusChip('cancelled', AppColors.errorColor),
//                 ],
//               ),
//               SizedBox(height: size.customHeight(context) * 0.018),

//               // ── Recurring ────────────────────────────────────
//               _recurringToggle(context, size),
//               if (_recurring) ...[
//                 SizedBox(height: size.customHeight(context) * 0.015),
//                 _label(context, size, 'Recurrence Rule'),
//                 const SizedBox(height: 8),
//                 TextFormField(
//                   controller: _c.recurrenceCtrl,
//                   style: GoogleFonts.poppins(
//                       fontSize: 14, color: AppColors.textPrimaryColor),
//                   decoration: _inputDeco(
//                       hint: 'e.g. Weekly Every Monday',
//                       icon: Icons.repeat_rounded,
//                       iconColor: AppColors.primaryColor),
//                 ),
//               ],
//               SizedBox(height: size.customHeight(context) * 0.03),

//               // ── Submit ────────────────────────────────────────
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: _saving
//                       ? null
//                       : () async {
//                           _sync();
//                           setState(() => _saving = true);
//                           bool ok;
//                           String dayName = '';
//                           if (isEdit) {
//                             ok = await _c.updateSlot(
//                                 widget.editingSlot!.slotId);
//                           } else {
//                             ok = await _c.createSlot();
//                             dayName = _c.selectedDayName;
//                           }
//                           if (mounted) setState(() => _saving = false);
//                           if (ok && context.mounted) {
//                             Navigator.pop(context);
//                             if (!isEdit && dayName.isNotEmpty) {
//                               widget.onCreated(dayName);
//                             }
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
//                           isEdit ? 'Update Slot' : 'Create Slot',
//                           style: GoogleFonts.poppins(
//                               fontWeight: FontWeight.w600,
//                               fontSize:
//                                   widget.size.customWidth(context) * 0.042),
//                         ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _modeChip(
//       String value, String label, IconData icon, Color color) {
//     final selected = _mode == value;
//     return Expanded(
//       child: GestureDetector(
//         onTap: () => setState(() => _mode = value),
//         child: Container(
//           padding: const EdgeInsets.symmetric(vertical: 12),
//           decoration: BoxDecoration(
//             color: selected ? color : color.withOpacity(0.06),
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(
//                 color: selected ? color : color.withOpacity(0.25),
//                 width: selected ? 0 : 1),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(icon,
//                   color: selected ? Colors.white : color, size: 20),
//               const SizedBox(height: 4),
//               Text(label,
//                   style: GoogleFonts.poppins(
//                       fontSize: 11,
//                       fontWeight: FontWeight.w600,
//                       color: selected
//                           ? Colors.white
//                           : AppColors.textSecondaryColor)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _statusChip(String value, Color color) {
//     final selected = _status == value;
//     return GestureDetector(
//       onTap: () => setState(() => _status = value),
//       child: Container(
//         padding:
//             const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
//         decoration: BoxDecoration(
//           color: selected ? color : color.withOpacity(0.06),
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//               color: selected ? color : color.withOpacity(0.25),
//               width: 1),
//         ),
//         child: Text(
//           value[0].toUpperCase() + value.substring(1),
//           style: GoogleFonts.poppins(
//               fontSize: 13,
//               fontWeight: FontWeight.w600,
//               color: selected ? Colors.white : color),
//         ),
//       ),
//     );
//   }

//   Widget _recurringToggle(BuildContext context, CustomSize size) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//       decoration: BoxDecoration(
//         color: AppColors.lightGreyColor,
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(
//             color: AppColors.greyColor.withOpacity(0.2), width: 1),
//       ),
//       child: Row(
//         children: [
//           Icon(Icons.repeat_rounded,
//               color: _recurring
//                   ? AppColors.primaryColor
//                   : AppColors.textSecondaryColor,
//               size: 22),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Recurring Slot',
//                     style: GoogleFonts.poppins(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                         color: AppColors.textPrimaryColor)),
//                 Text('Repeat weekly on this day',
//                     style: GoogleFonts.poppins(
//                         fontSize: 12,
//                         color: AppColors.textSecondaryColor)),
//               ],
//             ),
//           ),
//           Switch(
//             value: _recurring,
//             onChanged: (v) => setState(() => _recurring = v),
//             activeColor: AppColors.primaryColor,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _locationSelector(BuildContext context, CustomSize size) {
//     return GestureDetector(
//       onTap: () => _showLocationPicker(context),
//       child: Container(
//         padding:
//             const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
//         decoration: BoxDecoration(
//           color: AppColors.lightGreyColor,
//           borderRadius: BorderRadius.circular(14),
//           border: Border.all(
//               color: _locationId.isNotEmpty
//                   ? AppColors.primaryColor.withOpacity(0.4)
//                   : AppColors.greyColor.withOpacity(0.2),
//               width: 1),
//         ),
//         child: Row(
//           children: [
//             Icon(Icons.location_on_outlined,
//                 color: _locationId.isNotEmpty
//                     ? AppColors.primaryColor
//                     : AppColors.textSecondaryColor,
//                 size: 22),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Text(
//                 _locationId.isEmpty ? 'No location selected' : _locationLabel,
//                 style: GoogleFonts.poppins(
//                     fontSize: 14,
//                     color: _locationId.isEmpty
//                         ? AppColors.textSecondaryColor.withOpacity(0.7)
//                         : AppColors.textPrimaryColor,
//                     fontWeight: _locationId.isNotEmpty
//                         ? FontWeight.w500
//                         : FontWeight.normal),
//               ),
//             ),
//             const Icon(Icons.chevron_right_rounded,
//                 color: AppColors.textSecondaryColor, size: 20),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showLocationPicker(BuildContext context) {
//     final locs = _c.myLocations;
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.transparent,
//       isScrollControlled: true,
//       builder: (_) => ConstrainedBox(
//         constraints: BoxConstraints(
//             maxHeight: MediaQuery.of(context).size.height * 0.6),
//         child: Container(
//           decoration: const BoxDecoration(
//               color: AppColors.whiteColor,
//               borderRadius:
//                   BorderRadius.vertical(top: Radius.circular(24))),
//           padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(
//                 child: Container(
//                     width: 44,
//                     height: 4,
//                     decoration: BoxDecoration(
//                         color: AppColors.greyColor.withOpacity(0.3),
//                         borderRadius: BorderRadius.circular(2))),
//               ),
//               const SizedBox(height: 16),
//               Text('Select Location',
//                   style: GoogleFonts.poppins(
//                       fontSize: 17,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.textPrimaryColor)),
//               const SizedBox(height: 14),
//               // None option
//               _locationTile(
//                 label: 'No location',
//                 sublabel: 'Skip location selection',
//                 icon: Icons.location_off_outlined,
//                 selected: _locationId.isEmpty,
//                 onTap: () {
//                   setState(() {
//                     _locationId = '';
//                     _locationLabel = 'None';
//                   });
//                   Navigator.pop(context);
//                 },
//               ),
//               const SizedBox(height: 8),
//               if (locs.isEmpty)
//                 Padding(
//                   padding: const EdgeInsets.all(12),
//                   child: Text(
//                     'No locations found. Add locations in the Locations section.',
//                     style: GoogleFonts.poppins(
//                         fontSize: 13,
//                         color: AppColors.textSecondaryColor),
//                     textAlign: TextAlign.center,
//                   ),
//                 )
//               else
//                 Flexible(
//                   child: ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: locs.length,
//                     itemBuilder: (_, i) {
//                       final loc = locs[i];
//                       return Padding(
//                         padding: const EdgeInsets.only(bottom: 8),
//                         child: _locationTile(
//                           label: loc.label,
//                           sublabel: '${loc.address}, ${loc.city}',
//                           icon: Icons.business_rounded,
//                           selected: _locationId == loc.locationId,
//                           onTap: () {
//                             setState(() {
//                               _locationId = loc.locationId;
//                               _locationLabel = loc.label;
//                             });
//                             Navigator.pop(context);
//                           },
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _locationTile({
//     required String label,
//     required String sublabel,
//     required IconData icon,
//     required bool selected,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding:
//             const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//         decoration: BoxDecoration(
//           color: selected
//               ? AppColors.primaryColor.withOpacity(0.08)
//               : AppColors.lightGreyColor,
//           borderRadius: BorderRadius.circular(14),
//           border: Border.all(
//               color: selected
//                   ? AppColors.primaryColor.withOpacity(0.4)
//                   : AppColors.greyColor.withOpacity(0.2),
//               width: 1),
//         ),
//         child: Row(
//           children: [
//             Icon(icon,
//                 color: selected
//                     ? AppColors.primaryColor
//                     : AppColors.textSecondaryColor,
//                 size: 22),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(label,
//                       style: GoogleFonts.poppins(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                           color: selected
//                               ? AppColors.primaryColor
//                               : AppColors.textPrimaryColor)),
//                   Text(sublabel,
//                       style: GoogleFonts.poppins(
//                           fontSize: 12,
//                           color: AppColors.textSecondaryColor)),
//                 ],
//               ),
//             ),
//             if (selected)
//               const Icon(Icons.check_circle_rounded,
//                   color: AppColors.primaryColor, size: 20),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _pickerTile({
//     required IconData icon,
//     required String value,
//     required bool hasValue,
//     required Color color,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: double.infinity,
//         padding:
//             const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
//         decoration: BoxDecoration(
//           color: AppColors.lightGreyColor,
//           borderRadius: BorderRadius.circular(14),
//           border: Border.all(
//               color: hasValue
//                   ? color.withOpacity(0.4)
//                   : AppColors.greyColor.withOpacity(0.2),
//               width: 1),
//         ),
//         child: Row(
//           children: [
//             Icon(icon,
//                 color: hasValue ? color : AppColors.textSecondaryColor,
//                 size: 20),
//             const SizedBox(width: 10),
//             Text(value,
//                 style: GoogleFonts.poppins(
//                     fontSize: 14,
//                     color: hasValue
//                         ? AppColors.textPrimaryColor
//                         : AppColors.textSecondaryColor.withOpacity(0.7),
//                     fontWeight: hasValue
//                         ? FontWeight.w500
//                         : FontWeight.normal)),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _feeField({
//     required TextEditingController ctrl,
//     required String hint,
//     required IconData icon,
//     required Color color,
//   }) {
//     return TextFormField(
//       controller: ctrl,
//       keyboardType:
//           const TextInputType.numberWithOptions(decimal: true),
//       style: GoogleFonts.poppins(
//           fontSize: 14, color: AppColors.textPrimaryColor),
//       decoration: _inputDeco(hint: hint, icon: icon, iconColor: color),
//     );
//   }

//   InputDecoration _inputDeco(
//       {required String hint,
//       required IconData icon,
//       required Color iconColor}) {
//     return InputDecoration(
//       hintText: hint,
//       hintStyle: GoogleFonts.poppins(
//           fontSize: 14,
//           color: AppColors.textSecondaryColor.withOpacity(0.7)),
//       prefixIcon: Icon(icon, color: iconColor, size: 20),
//       filled: true,
//       fillColor: AppColors.lightGreyColor,
//       contentPadding:
//           const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//       border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(14),
//           borderSide: BorderSide.none),
//       enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(14),
//           borderSide: BorderSide(
//               color: AppColors.greyColor.withOpacity(0.2), width: 1)),
//       focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(14),
//           borderSide:
//               const BorderSide(color: AppColors.primaryColor, width: 1.5)),
//     );
//   }

//   Widget _label(BuildContext context, CustomSize size, String text) {
//     return Text(text,
//         style: GoogleFonts.poppins(
//             fontSize: size.customWidth(context) * 0.036,
//             fontWeight: FontWeight.w600,
//             color: AppColors.textPrimaryColor));
//   }
// }

// // ═══════════════════════════════════════════════════════════════
// //   Delete Slot Dialog
// // ═══════════════════════════════════════════════════════════════
// class _DeleteSlotDialog extends StatefulWidget {
//   final SlotItem slot;
//   final SlotController controller;

//   const _DeleteSlotDialog({required this.slot, required this.controller});

//   @override
//   State<_DeleteSlotDialog> createState() => _DeleteSlotDialogState();
// }

// class _DeleteSlotDialogState extends State<_DeleteSlotDialog> {
//   bool _deleting = false;

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       shape:
//           RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
//       contentPadding: const EdgeInsets.all(24),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//                 color: AppColors.errorColor.withOpacity(0.1),
//                 shape: BoxShape.circle),
//             child: const Icon(Icons.delete_forever_rounded,
//                 color: AppColors.errorColor, size: 36),
//           ),
//           const SizedBox(height: 16),
//           Text('Delete Slot?',
//               style: GoogleFonts.poppins(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.textPrimaryColor)),
//           const SizedBox(height: 8),
//           Text(
//             '${widget.slot.formattedDate}\n${widget.slot.formattedStartTime} – ${widget.slot.formattedEndTime}',
//             textAlign: TextAlign.center,
//             style: GoogleFonts.poppins(
//                 fontSize: 14,
//                 color: AppColors.textSecondaryColor,
//                 height: 1.5),
//           ),
//           const SizedBox(height: 24),
//           Row(
//             children: [
//               Expanded(
//                 child: OutlinedButton(
//                   onPressed:
//                       _deleting ? null : () => Navigator.pop(context),
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
//                           fontWeight: FontWeight.w500, fontSize: 14)),
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: ElevatedButton(
//                   onPressed: _deleting
//                       ? null
//                       : () async {
//                           setState(() => _deleting = true);
//                           final ok = await widget.controller
//                               .deleteSlot(widget.slot.slotId);
//                           if (mounted)
//                             setState(() => _deleting = false);
//                           if (ok && context.mounted)
//                             Navigator.pop(context);
//                         },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.errorColor,
//                     foregroundColor: Colors.white,
//                     disabledBackgroundColor:
//                         AppColors.errorColor.withOpacity(0.5),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12)),
//                     padding:
//                         const EdgeInsets.symmetric(vertical: 13),
//                     elevation: 0,
//                   ),
//                   child: _deleting
//                       ? const SizedBox(
//                           width: 18,
//                           height: 18,
//                           child: CircularProgressIndicator(
//                               color: Colors.white, strokeWidth: 2))
//                       : Text('Delete',
//                           style: GoogleFonts.poppins(
//                               fontWeight: FontWeight.w600,
//                               fontSize: 14)),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// lib/view/expert/slots/expert_slots_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import 'package:speechspectrum/controllers/slot_controller.dart';
import 'package:speechspectrum/models/slot_model.dart';
import 'package:speechspectrum/models/location_model.dart';

class ExpertSlotsScreen extends StatefulWidget {
  const ExpertSlotsScreen({super.key});

  @override
  State<ExpertSlotsScreen> createState() => _ExpertSlotsScreenState();
}

class _ExpertSlotsScreenState extends State<ExpertSlotsScreen> {
  late final SlotController _c;

  @override
  void initState() {
    super.initState();
    _c = Get.isRegistered<SlotController>()
        ? Get.find<SlotController>()
        : Get.put(SlotController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _c.fetchMySlots();
      _c.fetchMyLocations();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();
    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      appBar: _appBar(context, size),
      body: Obx(() {
        if (_c.isLoading.value && _c.mySlots.isEmpty) {
          return _loader(context, size);
        }
        return RefreshIndicator(
          color: AppColors.primaryColor,
          onRefresh: () async {
            await _c.fetchMySlots();
            await _c.fetchMyLocations();
          },
          child: ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            padding: EdgeInsets.fromLTRB(
              size.customWidth(context) * 0.05,
              size.customHeight(context) * 0.02,
              size.customWidth(context) * 0.05,
              size.customHeight(context) * 0.12,
            ),
            children: [
              _headerBanner(context, size),
              SizedBox(height: size.customHeight(context) * 0.025),
              _weekDayGrid(context, size),
              SizedBox(height: size.customHeight(context) * 0.025),
              if (_c.mySlots.isEmpty)
                _emptySlots(context, size)
              else ...[
                _sectionTitle(context, size, 'Your Slots'),
                SizedBox(height: size.customHeight(context) * 0.015),
                ..._c.mySlots.map((s) => _slotCard(context, size, s)).toList(),
              ],
            ],
          ),
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _c.resetForm();
          _openSlotSheet(context, size);
        },
        backgroundColor: AppColors.primaryColor,
        icon: const Icon(Icons.add_alarm_rounded, color: Colors.white),
        label: Text('Add Slot',
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14)),
      ),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context, CustomSize size) {
    return AppBar(
      backgroundColor: AppColors.whiteColor,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded,
            color: AppColors.textPrimaryColor, size: 20),
        onPressed: () => Get.back(),
      ),
      title: Text('My Slots',
          style: GoogleFonts.poppins(
              color: AppColors.textPrimaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w600)),
      actions: [
        Obx(() => _c.isLoading.value
            ? const Padding(
                padding: EdgeInsets.all(16),
                child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                        color: AppColors.primaryColor, strokeWidth: 2)),
              )
            : IconButton(
                icon: const Icon(Icons.refresh_rounded,
                    color: AppColors.primaryColor),
                onPressed: () {
                  _c.fetchMySlots();
                  _c.fetchMyLocations();
                },
              )),
        const SizedBox(width: 4),
      ],
    );
  }

  Widget _headerBanner(BuildContext context, CustomSize size) {
    return Container(
      padding: EdgeInsets.all(size.customWidth(context) * 0.05),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primaryColor, AppColors.secondaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.28),
              blurRadius: 18,
              offset: const Offset(0, 5))
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(14)),
            child: const Icon(Icons.calendar_month_rounded,
                color: Colors.white, size: 28),
          ),
          SizedBox(width: size.customWidth(context) * 0.04),
          Expanded(
            child: Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_c.mySlots.length} Slot${_c.mySlots.length != 1 ? 's' : ''} Created',
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: size.customWidth(context) * 0.044,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${_c.createdDays.length} of 7 days covered this week',
                      style: GoogleFonts.poppins(
                          color: Colors.white.withOpacity(0.85),
                          fontSize: size.customWidth(context) * 0.031),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  Widget _weekDayGrid(BuildContext context, CustomSize size) {
    return Obx(() {
      final days = SlotController.weekDays;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(context, size, 'Weekly Coverage'),
          SizedBox(height: size.customHeight(context) * 0.015),
          Row(
            children: days.map((day) {
              final hasSlot = _c.createdDays.contains(day);
              final shortDay = day.substring(0, 3);
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (hasSlot) {
                      _showDaySlotsSheet(context, size, day);
                    } else {
                      _c.resetForm();
                      // Pre-select next occurrence of this day
                      final now = DateTime.now();
                      final targetWeekday = days.indexOf(day) + 1;
                      var diff = targetWeekday - now.weekday;
                      if (diff <= 0) diff += 7;
                      _c.selectedDate.value = now.add(Duration(days: diff));
                      _openSlotSheet(context, size);
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: hasSlot
                          ? AppColors.primaryColor
                          : AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: hasSlot
                            ? AppColors.primaryColor
                            : AppColors.greyColor.withOpacity(0.3),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 6,
                            offset: const Offset(0, 2))
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (hasSlot)
                          const Icon(Icons.check_circle_rounded,
                              color: Colors.white, size: 14)
                        else
                          Icon(Icons.add_rounded,
                              color: AppColors.primaryColor.withOpacity(0.6),
                              size: 14),
                        const SizedBox(height: 4),
                        Text(
                          shortDay,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: hasSlot
                                ? Colors.white
                                : AppColors.textSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      );
    });
  }

  Widget _sectionTitle(BuildContext context, CustomSize size, String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(2)),
        ),
        SizedBox(width: size.customWidth(context) * 0.025),
        Text(title,
            style: GoogleFonts.poppins(
                fontSize: size.customWidth(context) * 0.042,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimaryColor)),
      ],
    );
  }

  Widget _slotCard(BuildContext context, CustomSize size, SlotItem slot) {
    Color statusColor;
    switch (slot.status.toLowerCase()) {
      case 'booked':
        statusColor = AppColors.warningColor;
        break;
      case 'cancelled':
        statusColor = AppColors.errorColor;
        break;
      default:
        statusColor = AppColors.successColor;
    }

    Color modeColor;
    IconData modeIcon;
    switch (slot.mode.toLowerCase()) {
      case 'online':
        modeColor = AppColors.accentColor;
        modeIcon = Icons.videocam_outlined;
        break;
      case 'physical':
        modeColor = AppColors.warningColor;
        modeIcon = Icons.location_on_outlined;
        break;
      default:
        modeColor = AppColors.primaryColor;
        modeIcon = Icons.swap_horiz_rounded;
    }

    return Container(
      margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.015),
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
          Padding(
            padding: EdgeInsets.all(size.customWidth(context) * 0.042),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Day badge
                Container(
                  width: 52,
                  height: 58,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(slot.dayOfWeek,
                          style: GoogleFonts.poppins(
                              fontSize: 10,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w600)),
                      Text(
                        slot.slotDate.split('-')[2],
                        style: GoogleFonts.poppins(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: size.customWidth(context) * 0.03),

                // All content in Expanded — no sibling badge fighting for space
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top row: time + status badge
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(Icons.access_time_rounded,
                              size: 13,
                              color: AppColors.textSecondaryColor),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              '${slot.formattedStartTime} – ${slot.formattedEndTime}',
                              style: GoogleFonts.poppins(
                                  fontSize: size.customWidth(context) * 0.036,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimaryColor),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Status badge inside Expanded — never overflows
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 9, vertical: 3),
                            decoration: BoxDecoration(
                              color: statusColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              slot.status[0].toUpperCase() +
                                  slot.status.substring(1),
                              style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: statusColor),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.customHeight(context) * 0.007),

                      // Mode chip
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(modeIcon, size: 12, color: modeColor),
                          const SizedBox(width: 4),
                          Text(
                            slot.mode[0].toUpperCase() +
                                slot.mode.substring(1),
                            style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: modeColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(height: size.customHeight(context) * 0.005),

                      // Fees — use Wrap so they wrap on small screens
                      Wrap(
                        spacing: 10,
                        runSpacing: 4,
                        children: [
                          if (slot.feeOnline != null)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.videocam_outlined,
                                    size: 11,
                                    color: AppColors.accentColor),
                                const SizedBox(width: 3),
                                Text(
                                  '${slot.currency} ${slot.feeOnline!.toStringAsFixed(0)}',
                                  style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      color: AppColors.textSecondaryColor),
                                ),
                              ],
                            ),
                          if (slot.feePhysical != null)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.location_on_outlined,
                                    size: 11,
                                    color: AppColors.warningColor),
                                const SizedBox(width: 3),
                                Text(
                                  '${slot.currency} ${slot.feePhysical!.toStringAsFixed(0)}',
                                  style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      color: AppColors.textSecondaryColor),
                                ),
                              ],
                            ),
                        ],
                      ),

                      // Recurrence
                      if (slot.isRecurring && slot.recurrenceRule != null) ...[
                        SizedBox(height: size.customHeight(context) * 0.004),
                        Row(children: [
                          Icon(Icons.repeat_rounded,
                              size: 11,
                              color: AppColors.primaryColor.withOpacity(0.7)),
                          const SizedBox(width: 3),
                          Expanded(
                            child: Text(
                              slot.recurrenceRule!,
                              style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  color:
                                      AppColors.primaryColor.withOpacity(0.7)),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ]),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: AppColors.greyColor.withOpacity(0.15)),
          // Actions row
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.customWidth(context) * 0.02,
                vertical: size.customHeight(context) * 0.005),
            child: Row(
              children: [
                _action(
                  icon: Icons.edit_outlined,
                  label: 'Edit',
                  color: AppColors.warningColor,
                  onTap: () {
                    _c.populateFormFromSlot(slot);
                    _openSlotSheet(context, size, editingSlot: slot);
                  },
                ),
                _action(
                  icon: Icons.delete_outline_rounded,
                  label: 'Delete',
                  color: AppColors.errorColor,
                  onTap: () => _showDeleteConfirm(context, slot),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _action(
      {required IconData icon,
      required String label,
      required Color color,
      required VoidCallback onTap}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 19),
              const SizedBox(height: 4),
              Text(label,
                  style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: color)),
            ],
          ),
        ),
      ),
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
          Text('Loading your slots...',
              style: GoogleFonts.poppins(
                  color: AppColors.textSecondaryColor,
                  fontSize: size.customWidth(context) * 0.036)),
        ],
      ),
    );
  }

  Widget _emptySlots(BuildContext context, CustomSize size) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: size.customHeight(context) * 0.04),
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.08),
                shape: BoxShape.circle),
            child: const Icon(Icons.calendar_today_outlined,
                size: 58, color: AppColors.primaryColor),
          ),
          SizedBox(height: size.customHeight(context) * 0.025),
          Text('No Slots Yet',
              style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.05,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryColor)),
          SizedBox(height: size.customHeight(context) * 0.01),
          Text(
            'Tap "Add Slot" or tap a day\nto create your first availability slot.',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontSize: size.customWidth(context) * 0.034,
                color: AppColors.textSecondaryColor,
                height: 1.6),
          ),
        ],
      ),
    );
  }

  // ── Sheets & Dialogs ────────────────────────────────────────

  void _openSlotSheet(BuildContext context, CustomSize size,
      {SlotItem? editingSlot}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: true,
      builder: (_) => ConstrainedBox(
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.94),
        child: _SlotFormSheet(
          controller: _c,
          size: size,
          editingSlot: editingSlot,
          onCreated: (dayName) => _showAddAnotherDay(context, size, dayName),
        ),
      ),
    );
  }

  void _showDaySlotsSheet(
      BuildContext context, CustomSize size, String dayName) {
    final slots = _c.getSlotsForDay(dayName);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ConstrainedBox(
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.75),
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
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
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Icon(Icons.calendar_today_rounded,
                        color: AppColors.primaryColor, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Text('$dayName Slots',
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimaryColor)),
                ],
              ),
              const SizedBox(height: 16),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: slots.length,
                  itemBuilder: (_, i) => _slotCard(context, size, slots[i]),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    _c.resetForm();
                    final now = DateTime.now();
                    final targetWeekday =
                        SlotController.weekDays.indexOf(dayName) + 1;
                    var diff = targetWeekday - now.weekday;
                    if (diff <= 0) diff += 7;
                    _c.selectedDate.value = now.add(Duration(days: diff));
                    _openSlotSheet(context, size);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primaryColor,
                    side: BorderSide(
                        color: AppColors.primaryColor.withOpacity(0.5)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    padding: const EdgeInsets.symmetric(vertical: 13),
                  ),
                  icon: const Icon(Icons.add_rounded, size: 18),
                  label: Text('Add another slot on $dayName',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, fontSize: 14)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddAnotherDay(
      BuildContext context, CustomSize size, String justCreatedDay) {
    final remaining = SlotController.weekDays
        .where((d) => !_c.createdDays.contains(d))
        .toList();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        decoration: const BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 36),
        child: Column(
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
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                  color: AppColors.successColor.withOpacity(0.1),
                  shape: BoxShape.circle),
              child: const Icon(Icons.check_circle_rounded,
                  color: AppColors.successColor, size: 32),
            ),
            const SizedBox(height: 12),
            Text(
              '$justCreatedDay slot created! ✓',
              style: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryColor),
            ),
            const SizedBox(height: 6),
            Text(
              remaining.isEmpty
                  ? 'You have slots for all 7 days! 🎉'
                  : 'Do you want to add a slot for another day?',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: AppColors.textSecondaryColor),
            ),
            const SizedBox(height: 20),
            if (remaining.isNotEmpty) ...[
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: remaining.map((day) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      _c.resetForm();
                      final now = DateTime.now();
                      final targetWeekday =
                          SlotController.weekDays.indexOf(day) + 1;
                      var diff = targetWeekday - now.weekday;
                      if (diff <= 0) diff += 7;
                      _c.selectedDate.value = now.add(Duration(days: diff));
                      _openSlotSheet(context, size);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: AppColors.primaryColor.withOpacity(0.3)),
                      ),
                      child: Text(day,
                          style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor)),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
            ],
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.textSecondaryColor,
                  side: BorderSide(
                      color: AppColors.greyColor.withOpacity(0.4)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  padding: const EdgeInsets.symmetric(vertical: 13),
                ),
                child: Text("I'm done for now",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500, fontSize: 14)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirm(BuildContext context, SlotItem slot) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => _DeleteSlotDialog(slot: slot, controller: _c),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//   Slot Form Bottom Sheet
// ═══════════════════════════════════════════════════════════════
class _SlotFormSheet extends StatefulWidget {
  final SlotController controller;
  final CustomSize size;
  final SlotItem? editingSlot;
  final void Function(String dayName) onCreated;

  const _SlotFormSheet({
    required this.controller,
    required this.size,
    this.editingSlot,
    required this.onCreated,
  });

  @override
  State<_SlotFormSheet> createState() => _SlotFormSheetState();
}

class _SlotFormSheetState extends State<_SlotFormSheet> {
  final _formKey = GlobalKey<FormState>();
  bool _saving = false;
  late SlotController _c;

  // Local mirror of reactive fields for pure setState rebuilds
  String _mode = 'both';
  bool _recurring = false;
  DateTime? _date;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  String _status = 'available';
  String _locationId = '';
  String _locationLabel = 'None';

  @override
  void initState() {
    super.initState();
    _c = widget.controller;
    // Mirror from controller
    _mode = _c.selectedMode.value;
    _recurring = _c.isRecurring.value;
    _date = _c.selectedDate.value;
    _startTime = _c.selectedStartTime.value;
    _endTime = _c.selectedEndTime.value;
    _status = _c.selectedStatus.value;
    _locationId = _c.selectedLocationId.value;
    _locationLabel = _c.selectedLocationLabel.value.isEmpty
        ? 'None'
        : _c.selectedLocationLabel.value;
  }

  void _sync() {
    _c.selectedMode.value = _mode;
    _c.isRecurring.value = _recurring;
    _c.selectedDate.value = _date;
    _c.selectedStartTime.value = _startTime;
    _c.selectedEndTime.value = _endTime;
    _c.selectedStatus.value = _status;
    _c.selectedLocationId.value = _locationId;
  }

  String _fmtTime(TimeOfDay? t) {
    if (t == null) return 'Select';
    final h = t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod;
    final m = t.minute.toString().padLeft(2, '0');
    final p = t.period == DayPeriod.am ? 'AM' : 'PM';
    return '$h:$m $p';
  }

  String _fmtDate(DateTime? d) {
    if (d == null) return 'Select date';
    const months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return '${days[d.weekday - 1]}, ${d.day} ${months[d.month]} ${d.year}';
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.size;
    final isEdit = widget.editingSlot != null;

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
              // Handle
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

              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12)),
                    child: Icon(
                        isEdit
                            ? Icons.edit_calendar_rounded
                            : Icons.add_alarm_rounded,
                        color: AppColors.primaryColor,
                        size: 22),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isEdit ? 'Edit Slot' : 'Create Slot',
                          style: GoogleFonts.poppins(
                              fontSize: size.customWidth(context) * 0.046,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimaryColor),
                        ),
                        Text(
                          isEdit
                              ? 'Update availability slot'
                              : 'Set your availability',
                          style: GoogleFonts.poppins(
                              fontSize: size.customWidth(context) * 0.031,
                              color: AppColors.textSecondaryColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.customHeight(context) * 0.025),

              // ── Date picker ──────────────────────────────────
              _label(context, size, 'Date'),
              const SizedBox(height: 8),
              _pickerTile(
                icon: Icons.calendar_today_rounded,
                value: _fmtDate(_date),
                hasValue: _date != null,
                color: AppColors.primaryColor,
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _date ?? DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate:
                        DateTime.now().add(const Duration(days: 365)),
                    builder: (ctx, child) => Theme(
                      data: Theme.of(ctx).copyWith(
                        colorScheme: const ColorScheme.light(
                            primary: AppColors.primaryColor),
                      ),
                      child: child!,
                    ),
                  );
                  if (picked != null) setState(() => _date = picked);
                },
              ),
              SizedBox(height: size.customHeight(context) * 0.018),

              // ── Time pickers ─────────────────────────────────
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _label(context, size, 'Start Time'),
                        const SizedBox(height: 8),
                        _pickerTile(
                          icon: Icons.access_time_rounded,
                          value: _fmtTime(_startTime),
                          hasValue: _startTime != null,
                          color: AppColors.primaryColor,
                          onTap: () async {
                            final t = await showTimePicker(
                              context: context,
                              initialTime:
                                  _startTime ?? const TimeOfDay(hour: 9, minute: 0),
                              builder: (ctx, child) => Theme(
                                data: Theme.of(ctx).copyWith(
                                    colorScheme: const ColorScheme.light(
                                        primary: AppColors.primaryColor)),
                                child: child!,
                              ),
                            );
                            if (t != null) setState(() => _startTime = t);
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: size.customWidth(context) * 0.03),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _label(context, size, 'End Time'),
                        const SizedBox(height: 8),
                        _pickerTile(
                          icon: Icons.access_time_filled_rounded,
                          value: _fmtTime(_endTime),
                          hasValue: _endTime != null,
                          color: AppColors.secondaryColor,
                          onTap: () async {
                            final t = await showTimePicker(
                              context: context,
                              initialTime: _endTime ??
                                  const TimeOfDay(hour: 9, minute: 30),
                              builder: (ctx, child) => Theme(
                                data: Theme.of(ctx).copyWith(
                                    colorScheme: const ColorScheme.light(
                                        primary: AppColors.secondaryColor)),
                                child: child!,
                              ),
                            );
                            if (t != null) setState(() => _endTime = t);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.customHeight(context) * 0.018),

              // ── Mode selector ────────────────────────────────
              _label(context, size, 'Consultation Mode'),
              const SizedBox(height: 10),
              Row(
                children: [
                  _modeChip('online', 'Online',
                      Icons.videocam_outlined, AppColors.accentColor),
                  SizedBox(width: size.customWidth(context) * 0.025),
                  _modeChip('physical', 'Physical',
                      Icons.location_on_outlined, AppColors.warningColor),
                  SizedBox(width: size.customWidth(context) * 0.025),
                  _modeChip('both', 'Both',
                      Icons.swap_horiz_rounded, AppColors.primaryColor),
                ],
              ),
              SizedBox(height: size.customHeight(context) * 0.018),

              // ── Fee fields ───────────────────────────────────
              if (_mode != 'physical') ...[
                _label(context, size, 'Online Fee'),
                const SizedBox(height: 8),
                _feeField(
                    ctrl: _c.feeOnlineCtrl,
                    hint: 'e.g. 2500',
                    icon: Icons.videocam_outlined,
                    color: AppColors.accentColor),
                SizedBox(height: size.customHeight(context) * 0.018),
              ],
              if (_mode != 'online') ...[
                _label(context, size, 'Physical Fee'),
                const SizedBox(height: 8),
                _feeField(
                    ctrl: _c.feePhysicalCtrl,
                    hint: 'e.g. 3000',
                    icon: Icons.location_on_outlined,
                    color: AppColors.warningColor),
                SizedBox(height: size.customHeight(context) * 0.018),
              ],

              // ── Currency ──────────────────────────────────────
              _label(context, size, 'Currency'),
              const SizedBox(height: 8),
              _feeField(
                  ctrl: _c.currencyCtrl,
                  hint: 'PKR',
                  icon: Icons.currency_exchange_rounded,
                  color: AppColors.primaryColor),
              SizedBox(height: size.customHeight(context) * 0.018),

              // ── Location picker ───────────────────────────────
              _label(context, size, 'Location (optional)'),
              const SizedBox(height: 8),
              _locationSelector(context, size),
              SizedBox(height: size.customHeight(context) * 0.018),

              // ── Status ───────────────────────────────────────
              _label(context, size, 'Status'),
              const SizedBox(height: 10),
              Row(
                children: [
                  _statusChip('available', AppColors.successColor),
                  SizedBox(width: size.customWidth(context) * 0.025),
                  _statusChip('cancelled', AppColors.errorColor),
                ],
              ),
              SizedBox(height: size.customHeight(context) * 0.018),

              // ── Recurring ────────────────────────────────────
              _recurringToggle(context, size),
              if (_recurring) ...[
                SizedBox(height: size.customHeight(context) * 0.015),
                _label(context, size, 'Recurrence Rule'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _c.recurrenceCtrl,
                  style: GoogleFonts.poppins(
                      fontSize: 14, color: AppColors.textPrimaryColor),
                  decoration: _inputDeco(
                      hint: 'e.g. Weekly Every Monday',
                      icon: Icons.repeat_rounded,
                      iconColor: AppColors.primaryColor),
                ),
              ],

              // ── Zoom topic (only for online/both on CREATE) ───
              if (!isEdit &&
                  (_mode == 'online' || _mode == 'both')) ...[
                SizedBox(height: size.customHeight(context) * 0.018),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2196F3).withOpacity(0.06),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                        color: const Color(0xFF2196F3).withOpacity(0.25),
                        width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.videocam_rounded,
                              color: Color(0xFF2196F3), size: 18),
                          const SizedBox(width: 8),
                          Text(
                            'Zoom Meeting (auto-generated)',
                            style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF2196F3)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _c.topicCtrl,
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: AppColors.textPrimaryColor),
                        decoration: _inputDeco(
                            hint: 'e.g. Speech Therapy Session',
                            icon: Icons.title_rounded,
                            iconColor: const Color(0xFF2196F3)),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'A Zoom link will be generated and attached to this slot.',
                        style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: AppColors.textSecondaryColor),
                      ),
                    ],
                  ),
                ),
              ],
              SizedBox(height: size.customHeight(context) * 0.03),

              // ── Submit ────────────────────────────────────────
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saving
                      ? null
                      : () async {
                          _sync();
                          setState(() => _saving = true);
                          bool ok;
                          String dayName = '';
                          if (isEdit) {
                            ok = await _c.updateSlot(
                                widget.editingSlot!.slotId);
                          } else {
                            ok = await _c.createSlot();
                            dayName = _c.selectedDayName;
                          }
                          if (mounted) setState(() => _saving = false);
                          if (ok && context.mounted) {
                            Navigator.pop(context);
                            if (!isEdit && dayName.isNotEmpty) {
                              widget.onCreated(dayName);
                            }
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
                          isEdit ? 'Update Slot' : 'Create Slot',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize:
                                  widget.size.customWidth(context) * 0.042),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _modeChip(
      String value, String label, IconData icon, Color color) {
    final selected = _mode == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _mode = value),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected ? color : color.withOpacity(0.06),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: selected ? color : color.withOpacity(0.25),
                width: selected ? 0 : 1),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon,
                  color: selected ? Colors.white : color, size: 20),
              const SizedBox(height: 4),
              Text(label,
                  style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: selected
                          ? Colors.white
                          : AppColors.textSecondaryColor)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusChip(String value, Color color) {
    final selected = _status == value;
    return GestureDetector(
      onTap: () => setState(() => _status = value),
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? color : color.withOpacity(0.06),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: selected ? color : color.withOpacity(0.25),
              width: 1),
        ),
        child: Text(
          value[0].toUpperCase() + value.substring(1),
          style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: selected ? Colors.white : color),
        ),
      ),
    );
  }

  Widget _recurringToggle(BuildContext context, CustomSize size) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.lightGreyColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
            color: AppColors.greyColor.withOpacity(0.2), width: 1),
      ),
      child: Row(
        children: [
          Icon(Icons.repeat_rounded,
              color: _recurring
                  ? AppColors.primaryColor
                  : AppColors.textSecondaryColor,
              size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Recurring Slot',
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimaryColor)),
                Text('Repeat weekly on this day',
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: AppColors.textSecondaryColor)),
              ],
            ),
          ),
          Switch(
            value: _recurring,
            onChanged: (v) => setState(() => _recurring = v),
            activeColor: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _locationSelector(BuildContext context, CustomSize size) {
    return GestureDetector(
      onTap: () => _showLocationPicker(context),
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.lightGreyColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
              color: _locationId.isNotEmpty
                  ? AppColors.primaryColor.withOpacity(0.4)
                  : AppColors.greyColor.withOpacity(0.2),
              width: 1),
        ),
        child: Row(
          children: [
            Icon(Icons.location_on_outlined,
                color: _locationId.isNotEmpty
                    ? AppColors.primaryColor
                    : AppColors.textSecondaryColor,
                size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                _locationId.isEmpty ? 'No location selected' : _locationLabel,
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: _locationId.isEmpty
                        ? AppColors.textSecondaryColor.withOpacity(0.7)
                        : AppColors.textPrimaryColor,
                    fontWeight: _locationId.isNotEmpty
                        ? FontWeight.w500
                        : FontWeight.normal),
              ),
            ),
            const Icon(Icons.chevron_right_rounded,
                color: AppColors.textSecondaryColor, size: 20),
          ],
        ),
      ),
    );
  }

  void _showLocationPicker(BuildContext context) {
    final locs = _c.myLocations;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => ConstrainedBox(
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.6),
        child: Container(
          decoration: const BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(24))),
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                    width: 44,
                    height: 4,
                    decoration: BoxDecoration(
                        color: AppColors.greyColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(2))),
              ),
              const SizedBox(height: 16),
              Text('Select Location',
                  style: GoogleFonts.poppins(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimaryColor)),
              const SizedBox(height: 14),
              // None option
              _locationTile(
                label: 'No location',
                sublabel: 'Skip location selection',
                icon: Icons.location_off_outlined,
                selected: _locationId.isEmpty,
                onTap: () {
                  setState(() {
                    _locationId = '';
                    _locationLabel = 'None';
                  });
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 8),
              if (locs.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    'No locations found. Add locations in the Locations section.',
                    style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: AppColors.textSecondaryColor),
                    textAlign: TextAlign.center,
                  ),
                )
              else
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: locs.length,
                    itemBuilder: (_, i) {
                      final loc = locs[i];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: _locationTile(
                          label: loc.label,
                          sublabel: '${loc.address}, ${loc.city}',
                          icon: Icons.business_rounded,
                          selected: _locationId == loc.locationId,
                          onTap: () {
                            setState(() {
                              _locationId = loc.locationId;
                              _locationLabel = loc.label;
                            });
                            Navigator.pop(context);
                          },
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _locationTile({
    required String label,
    required String sublabel,
    required IconData icon,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primaryColor.withOpacity(0.08)
              : AppColors.lightGreyColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
              color: selected
                  ? AppColors.primaryColor.withOpacity(0.4)
                  : AppColors.greyColor.withOpacity(0.2),
              width: 1),
        ),
        child: Row(
          children: [
            Icon(icon,
                color: selected
                    ? AppColors.primaryColor
                    : AppColors.textSecondaryColor,
                size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: selected
                              ? AppColors.primaryColor
                              : AppColors.textPrimaryColor)),
                  Text(sublabel,
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: AppColors.textSecondaryColor)),
                ],
              ),
            ),
            if (selected)
              const Icon(Icons.check_circle_rounded,
                  color: AppColors.primaryColor, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _pickerTile({
    required IconData icon,
    required String value,
    required bool hasValue,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.lightGreyColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
              color: hasValue
                  ? color.withOpacity(0.4)
                  : AppColors.greyColor.withOpacity(0.2),
              width: 1),
        ),
        child: Row(
          children: [
            Icon(icon,
                color: hasValue ? color : AppColors.textSecondaryColor,
                size: 20),
            const SizedBox(width: 10),
            Text(value,
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: hasValue
                        ? AppColors.textPrimaryColor
                        : AppColors.textSecondaryColor.withOpacity(0.7),
                    fontWeight: hasValue
                        ? FontWeight.w500
                        : FontWeight.normal)),
          ],
        ),
      ),
    );
  }

  Widget _feeField({
    required TextEditingController ctrl,
    required String hint,
    required IconData icon,
    required Color color,
  }) {
    return TextFormField(
      controller: ctrl,
      keyboardType:
          const TextInputType.numberWithOptions(decimal: true),
      style: GoogleFonts.poppins(
          fontSize: 14, color: AppColors.textPrimaryColor),
      decoration: _inputDeco(hint: hint, icon: icon, iconColor: color),
    );
  }

  InputDecoration _inputDeco(
      {required String hint,
      required IconData icon,
      required Color iconColor}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.poppins(
          fontSize: 14,
          color: AppColors.textSecondaryColor.withOpacity(0.7)),
      prefixIcon: Icon(icon, color: iconColor, size: 20),
      filled: true,
      fillColor: AppColors.lightGreyColor,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
              color: AppColors.greyColor.withOpacity(0.2), width: 1)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide:
              const BorderSide(color: AppColors.primaryColor, width: 1.5)),
    );
  }

  Widget _label(BuildContext context, CustomSize size, String text) {
    return Text(text,
        style: GoogleFonts.poppins(
            fontSize: size.customWidth(context) * 0.036,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimaryColor));
  }
}

// ═══════════════════════════════════════════════════════════════
//   Delete Slot Dialog
// ═══════════════════════════════════════════════════════════════
class _DeleteSlotDialog extends StatefulWidget {
  final SlotItem slot;
  final SlotController controller;

  const _DeleteSlotDialog({required this.slot, required this.controller});

  @override
  State<_DeleteSlotDialog> createState() => _DeleteSlotDialogState();
}

class _DeleteSlotDialogState extends State<_DeleteSlotDialog> {
  bool _deleting = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      contentPadding: const EdgeInsets.all(24),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: AppColors.errorColor.withOpacity(0.1),
                shape: BoxShape.circle),
            child: const Icon(Icons.delete_forever_rounded,
                color: AppColors.errorColor, size: 36),
          ),
          const SizedBox(height: 16),
          Text('Delete Slot?',
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryColor)),
          const SizedBox(height: 8),
          Text(
            '${widget.slot.formattedDate}\n${widget.slot.formattedStartTime} – ${widget.slot.formattedEndTime}',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontSize: 14,
                color: AppColors.textSecondaryColor,
                height: 1.5),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed:
                      _deleting ? null : () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textSecondaryColor,
                    side: BorderSide(
                        color: AppColors.greyColor.withOpacity(0.4)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    padding:
                        const EdgeInsets.symmetric(vertical: 13),
                  ),
                  child: Text('Cancel',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, fontSize: 14)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: _deleting
                      ? null
                      : () async {
                          setState(() => _deleting = true);
                          final ok = await widget.controller
                              .deleteSlot(widget.slot.slotId);
                          if (mounted)
                            setState(() => _deleting = false);
                          if (ok && context.mounted)
                            Navigator.pop(context);
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.errorColor,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor:
                        AppColors.errorColor.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    padding:
                        const EdgeInsets.symmetric(vertical: 13),
                    elevation: 0,
                  ),
                  child: _deleting
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2))
                      : Text('Delete',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 14)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}