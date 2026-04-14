// // // lib/view/expert/location/expert_locations_screen.dart
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:get/get.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:url_launcher/url_launcher.dart';
// // import 'package:speechspectrum/constants/app_colors.dart';
// // import 'package:speechspectrum/constants/custom_size.dart';
// // import 'package:speechspectrum/controllers/location_controller.dart';
// // import 'package:speechspectrum/models/location_model.dart';

// // class ExpertLocationsScreen extends StatefulWidget {
// //   const ExpertLocationsScreen({super.key});

// //   @override
// //   State<ExpertLocationsScreen> createState() => _ExpertLocationsScreenState();
// // }

// // class _ExpertLocationsScreenState extends State<ExpertLocationsScreen> {
// //   late final LocationController controller;

// //   @override
// //   void initState() {
// //     super.initState();
// //     if (Get.isRegistered<LocationController>()) {
// //       controller = Get.find<LocationController>();
// //     } else {
// //       controller = Get.put(LocationController());
// //     }
// //     WidgetsBinding.instance.addPostFrameCallback((_) {
// //       controller.fetchMyLocations();
// //     });
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
// //           'My Locations',
// //           style: GoogleFonts.poppins(
// //             color: AppColors.textPrimaryColor,
// //             fontSize: 18,
// //             fontWeight: FontWeight.w600,
// //           ),
// //         ),
// //         actions: [
// //           Obx(() => controller.isLoading.value
// //               ? const Padding(
// //                   padding: EdgeInsets.all(16),
// //                   child: SizedBox(
// //                     width: 20,
// //                     height: 20,
// //                     child: CircularProgressIndicator(
// //                         color: AppColors.primaryColor, strokeWidth: 2),
// //                   ),
// //                 )
// //               : IconButton(
// //                   icon:
// //                       const Icon(Icons.refresh_rounded, color: AppColors.primaryColor),
// //                   onPressed: () => controller.fetchMyLocations(),
// //                   tooltip: 'Refresh',
// //                 )),
// //           SizedBox(width: size.customWidth(context) * 0.01),
// //         ],
// //       ),
// //       body: Obx(() {
// //         if (controller.isLoading.value) {
// //           return _buildLoadingState(context, size);
// //         }
// //         if (controller.myLocations.isEmpty) {
// //           return _buildEmptyState(context, size);
// //         }
// //         return RefreshIndicator(
// //           color: AppColors.primaryColor,
// //           onRefresh: () => controller.fetchMyLocations(),
// //           child: ListView(
// //             padding: EdgeInsets.all(size.customWidth(context) * 0.05),
// //             children: [
// //               _buildHeaderCard(context, size),
// //               SizedBox(height: size.customHeight(context) * 0.025),
// //               ...controller.myLocations
// //                   .map((loc) => _buildLocationCard(context, size, loc))
// //                   .toList(),
// //               SizedBox(height: size.customHeight(context) * 0.1),
// //             ],
// //           ),
// //         );
// //       }),
// //       floatingActionButton: _buildFAB(context, size),
// //     );
// //   }

// //   Widget _buildHeaderCard(BuildContext context, CustomSize size) {
// //     return Container(
// //       padding: EdgeInsets.all(size.customWidth(context) * 0.045),
// //       decoration: BoxDecoration(
// //         gradient: const LinearGradient(
// //           colors: [AppColors.primaryColor, AppColors.secondaryColor],
// //           begin: Alignment.topLeft,
// //           end: Alignment.bottomRight,
// //         ),
// //         borderRadius: BorderRadius.circular(20),
// //       ),
// //       child: Row(
// //         children: [
// //           Container(
// //             padding: const EdgeInsets.all(12),
// //             decoration: BoxDecoration(
// //               color: Colors.white.withOpacity(0.2),
// //               borderRadius: BorderRadius.circular(12),
// //             ),
// //             child: const Icon(Icons.location_on_rounded,
// //                 color: Colors.white, size: 28),
// //           ),
// //           SizedBox(width: size.customWidth(context) * 0.04),
// //           Expanded(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Obx(() => Text(
// //                       '${controller.myLocations.length} Location${controller.myLocations.length != 1 ? 's' : ''} Added',
// //                       style: GoogleFonts.poppins(
// //                         color: Colors.white,
// //                         fontSize: size.customWidth(context) * 0.042,
// //                         fontWeight: FontWeight.bold,
// //                       ),
// //                     )),
// //                 SizedBox(height: size.customHeight(context) * 0.004),
// //                 Text(
// //                   'Manage your clinic & office locations',
// //                   style: GoogleFonts.poppins(
// //                     color: Colors.white.withOpacity(0.85),
// //                     fontSize: size.customWidth(context) * 0.032,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildLocationCard(
// //       BuildContext context, CustomSize size, LocationItem location) {
// //     return Container(
// //       margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.018),
// //       decoration: BoxDecoration(
// //         color: AppColors.whiteColor,
// //         borderRadius: BorderRadius.circular(20),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.06),
// //             blurRadius: 16,
// //             offset: const Offset(0, 4),
// //           ),
// //         ],
// //       ),
// //       child: Column(
// //         children: [
// //           // Card Header
// //           Padding(
// //             padding: EdgeInsets.all(size.customWidth(context) * 0.045),
// //             child: Row(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 // Icon
// //                 Container(
// //                   width: 52,
// //                   height: 52,
// //                   decoration: BoxDecoration(
// //                     color: AppColors.primaryColor.withOpacity(0.1),
// //                     borderRadius: BorderRadius.circular(14),
// //                   ),
// //                   child: const Icon(Icons.business_rounded,
// //                       color: AppColors.primaryColor, size: 26),
// //                 ),
// //                 SizedBox(width: size.customWidth(context) * 0.035),
// //                 Expanded(
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Row(
// //                         children: [
// //                           Expanded(
// //                             child: Text(
// //                               location.label,
// //                               style: GoogleFonts.poppins(
// //                                 fontSize: size.customWidth(context) * 0.042,
// //                                 fontWeight: FontWeight.w700,
// //                                 color: AppColors.textPrimaryColor,
// //                               ),
// //                               maxLines: 1,
// //                               overflow: TextOverflow.ellipsis,
// //                             ),
// //                           ),
// //                           Container(
// //                             padding: const EdgeInsets.symmetric(
// //                                 horizontal: 10, vertical: 4),
// //                             decoration: BoxDecoration(
// //                               color: location.isActive
// //                                   ? AppColors.successColor.withOpacity(0.1)
// //                                   : AppColors.errorColor.withOpacity(0.1),
// //                               borderRadius: BorderRadius.circular(20),
// //                             ),
// //                             child: Text(
// //                               location.isActive ? 'Active' : 'Inactive',
// //                               style: GoogleFonts.poppins(
// //                                 fontSize: size.customWidth(context) * 0.028,
// //                                 fontWeight: FontWeight.w600,
// //                                 color: location.isActive
// //                                     ? AppColors.successColor
// //                                     : AppColors.errorColor,
// //                               ),
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                       SizedBox(height: size.customHeight(context) * 0.006),
// //                       Row(
// //                         children: [
// //                           const Icon(Icons.location_on_outlined,
// //                               size: 14,
// //                               color: AppColors.textSecondaryColor),
// //                           const SizedBox(width: 4),
// //                           Expanded(
// //                             child: Text(
// //                               location.address,
// //                               style: GoogleFonts.poppins(
// //                                 fontSize: size.customWidth(context) * 0.034,
// //                                 color: AppColors.textSecondaryColor,
// //                               ),
// //                               maxLines: 1,
// //                               overflow: TextOverflow.ellipsis,
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                       SizedBox(height: size.customHeight(context) * 0.004),
// //                       Row(
// //                         children: [
// //                           const Icon(Icons.location_city_outlined,
// //                               size: 14,
// //                               color: AppColors.textSecondaryColor),
// //                           const SizedBox(width: 4),
// //                           Text(
// //                             location.city,
// //                             style: GoogleFonts.poppins(
// //                               fontSize: size.customWidth(context) * 0.032,
// //                               color: AppColors.textSecondaryColor,
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),

// //           // Divider
// //           Divider(
// //             height: 1,
// //             color: AppColors.greyColor.withOpacity(0.15),
// //           ),

// //           // Action Row
// //           Padding(
// //             padding: EdgeInsets.symmetric(
// //               horizontal: size.customWidth(context) * 0.02,
// //               vertical: size.customHeight(context) * 0.005,
// //             ),
// //             child: Row(
// //               children: [
// //                 // Open in Maps
// //                 Expanded(
// //                   child: _buildActionButton(
// //                     icon: Icons.map_outlined,
// //                     label: 'Open Map',
// //                     color: AppColors.accentColor,
// //                     onTap: () => _openMapsUrl(location.mapsUrl),
// //                   ),
// //                 ),
// //                 // Copy URL
// //                 Expanded(
// //                   child: _buildActionButton(
// //                     icon: Icons.copy_outlined,
// //                     label: 'Copy Link',
// //                     color: AppColors.primaryColor,
// //                     onTap: () {
// //                       Clipboard.setData(ClipboardData(text: location.mapsUrl));
// //                       Get.snackbar(
// //                         'Copied!',
// //                         'Maps link copied to clipboard',
// //                         snackPosition: SnackPosition.BOTTOM,
// //                         backgroundColor: AppColors.textPrimaryColor,
// //                         colorText: AppColors.whiteColor,
// //                         margin: const EdgeInsets.all(16),
// //                         borderRadius: 12,
// //                         duration: const Duration(seconds: 2),
// //                       );
// //                     },
// //                   ),
// //                 ),
// //                 // Edit
// //                 Expanded(
// //                   child: _buildActionButton(
// //                     icon: Icons.edit_outlined,
// //                     label: 'Edit',
// //                     color: AppColors.warningColor,
// //                     onTap: () => _showLocationSheet(context, size,
// //                         existingLocation: location),
// //                   ),
// //                 ),
// //                 // Delete
// //                 Expanded(
// //                   child: _buildActionButton(
// //                     icon: Icons.delete_outline_rounded,
// //                     label: 'Delete',
// //                     color: AppColors.errorColor,
// //                     onTap: () =>
// //                         _showDeleteConfirmation(context, size, location),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildActionButton({
// //     required IconData icon,
// //     required String label,
// //     required Color color,
// //     required VoidCallback onTap,
// //   }) {
// //     return InkWell(
// //       onTap: onTap,
// //       borderRadius: BorderRadius.circular(12),
// //       child: Padding(
// //         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
// //         child: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             Icon(icon, color: color, size: 20),
// //             const SizedBox(height: 4),
// //             Text(
// //               label,
// //               style: GoogleFonts.poppins(
// //                 fontSize: 11,
// //                 fontWeight: FontWeight.w500,
// //                 color: color,
// //               ),
// //               textAlign: TextAlign.center,
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildFAB(BuildContext context, CustomSize size) {
// //     return FloatingActionButton.extended(
// //       onPressed: () => _showLocationSheet(context, size),
// //       backgroundColor: AppColors.primaryColor,
// //       elevation: 4,
// //       icon: const Icon(Icons.add_location_alt_rounded, color: Colors.white),
// //       label: Text(
// //         'Add Location',
// //         style: GoogleFonts.poppins(
// //           color: Colors.white,
// //           fontWeight: FontWeight.w600,
// //           fontSize: 14,
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildLoadingState(BuildContext context, CustomSize size) {
// //     return Center(
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           const CircularProgressIndicator(
// //               color: AppColors.primaryColor, strokeWidth: 3),
// //           SizedBox(height: size.customHeight(context) * 0.02),
// //           Text(
// //             'Loading locations...',
// //             style: GoogleFonts.poppins(
// //               color: AppColors.textSecondaryColor,
// //               fontSize: size.customWidth(context) * 0.038,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildEmptyState(BuildContext context, CustomSize size) {
// //     return Center(
// //       child: Padding(
// //         padding: EdgeInsets.all(size.customWidth(context) * 0.1),
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Container(
// //               width: 130,
// //               height: 130,
// //               decoration: BoxDecoration(
// //                 color: AppColors.primaryColor.withOpacity(0.08),
// //                 shape: BoxShape.circle,
// //               ),
// //               child: const Icon(Icons.add_location_alt_outlined,
// //                   size: 64, color: AppColors.primaryColor),
// //             ),
// //             SizedBox(height: size.customHeight(context) * 0.03),
// //             Text(
// //               'No Locations Yet',
// //               style: GoogleFonts.poppins(
// //                 fontSize: size.customWidth(context) * 0.052,
// //                 fontWeight: FontWeight.bold,
// //                 color: AppColors.textPrimaryColor,
// //               ),
// //             ),
// //             SizedBox(height: size.customHeight(context) * 0.012),
// //             Text(
// //               'Add your clinic or office locations\nso patients can find you easily',
// //               textAlign: TextAlign.center,
// //               style: GoogleFonts.poppins(
// //                 fontSize: size.customWidth(context) * 0.036,
// //                 color: AppColors.textSecondaryColor,
// //                 height: 1.6,
// //               ),
// //             ),
// //             SizedBox(height: size.customHeight(context) * 0.04),
// //             ElevatedButton.icon(
// //               onPressed: () => _showLocationSheet(context, size),
// //               style: ElevatedButton.styleFrom(
// //                 backgroundColor: AppColors.primaryColor,
// //                 foregroundColor: Colors.white,
// //                 padding: EdgeInsets.symmetric(
// //                   horizontal: size.customWidth(context) * 0.08,
// //                   vertical: size.customHeight(context) * 0.018,
// //                 ),
// //                 shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(14)),
// //                 elevation: 2,
// //               ),
// //               icon: const Icon(Icons.add_location_alt_rounded),
// //               label: Text(
// //                 'Add First Location',
// //                 style: GoogleFonts.poppins(
// //                     fontWeight: FontWeight.w600, fontSize: 15),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   // Bottom sheet for create / edit
// //   void _showLocationSheet(BuildContext context, CustomSize size,
// //       {LocationItem? existingLocation}) {
// //     final isEditing = existingLocation != null;

// //     if (isEditing) {
// //       controller.populateForm(existingLocation);
// //     } else {
// //       controller.clearForm();
// //     }

// //     showModalBottomSheet(
// //       context: context,
// //       isScrollControlled: true,
// //       backgroundColor: Colors.transparent,
// //       builder: (ctx) => _LocationFormSheet(
// //         controller: controller,
// //         size: size,
// //         isEditing: isEditing,
// //         existingLocation: existingLocation,
// //       ),
// //     );
// //   }

// //   // Delete confirmation dialog
// //   void _showDeleteConfirmation(
// //       BuildContext context, CustomSize size, LocationItem location) {
// //     showDialog(
// //       context: context,
// //       barrierDismissible: false,
// //       builder: (ctx) => AlertDialog(
// //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
// //         contentPadding: const EdgeInsets.all(24),
// //         content: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             Container(
// //               padding: const EdgeInsets.all(16),
// //               decoration: BoxDecoration(
// //                 color: AppColors.errorColor.withOpacity(0.1),
// //                 shape: BoxShape.circle,
// //               ),
// //               child: const Icon(Icons.delete_forever_rounded,
// //                   color: AppColors.errorColor, size: 36),
// //             ),
// //             const SizedBox(height: 16),
// //             Text(
// //               'Delete Location?',
// //               style: GoogleFonts.poppins(
// //                 fontSize: 18,
// //                 fontWeight: FontWeight.bold,
// //                 color: AppColors.textPrimaryColor,
// //               ),
// //             ),
// //             const SizedBox(height: 8),
// //             Text(
// //               '"${location.label}" will be permanently removed.',
// //               textAlign: TextAlign.center,
// //               style: GoogleFonts.poppins(
// //                 fontSize: 14,
// //                 color: AppColors.textSecondaryColor,
// //                 height: 1.5,
// //               ),
// //             ),
// //             const SizedBox(height: 24),
// //             Row(
// //               children: [
// //                 Expanded(
// //                   child: OutlinedButton(
// //                     onPressed: () => Navigator.pop(ctx),
// //                     style: OutlinedButton.styleFrom(
// //                       foregroundColor: AppColors.textSecondaryColor,
// //                       side: BorderSide(
// //                           color:
// //                               AppColors.greyColor.withOpacity(0.4)),
// //                       shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(12)),
// //                       padding: const EdgeInsets.symmetric(vertical: 13),
// //                     ),
// //                     child: Text('Cancel',
// //                         style: GoogleFonts.poppins(
// //                             fontWeight: FontWeight.w500, fontSize: 14)),
// //                   ),
// //                 ),
// //                 const SizedBox(width: 12),
// //                 Expanded(
// //                   child: Obx(() => ElevatedButton(
// //                         onPressed: controller.isDeleting.value
// //                             ? null
// //                             : () async {
// //                                 final success = await controller
// //                                     .deleteLocation(location.locationId);
// //                                 if (success && ctx.mounted) {
// //                                   Navigator.pop(ctx);
// //                                 }
// //                               },
// //                         style: ElevatedButton.styleFrom(
// //                           backgroundColor: AppColors.errorColor,
// //                           foregroundColor: Colors.white,
// //                           shape: RoundedRectangleBorder(
// //                               borderRadius: BorderRadius.circular(12)),
// //                           padding: const EdgeInsets.symmetric(vertical: 13),
// //                           elevation: 0,
// //                         ),
// //                         child: controller.isDeleting.value
// //                             ? const SizedBox(
// //                                 width: 18,
// //                                 height: 18,
// //                                 child: CircularProgressIndicator(
// //                                     color: Colors.white, strokeWidth: 2))
// //                             : Text('Delete',
// //                                 style: GoogleFonts.poppins(
// //                                     fontWeight: FontWeight.w600,
// //                                     fontSize: 14)),
// //                       )),
// //                 ),
// //               ],
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Future<void> _openMapsUrl(String url) async {
// //     try {
// //       final uri = Uri.parse(url);
// //       if (await canLaunchUrl(uri)) {
// //         await launchUrl(uri, mode: LaunchMode.externalApplication);
// //       } else {
// //         Get.snackbar('Error', 'Could not open map link',
// //             snackPosition: SnackPosition.BOTTOM,
// //             backgroundColor: AppColors.errorColor,
// //             colorText: Colors.white,
// //             margin: const EdgeInsets.all(16),
// //             borderRadius: 12);
// //       }
// //     } catch (e) {
// //       Get.snackbar('Error', 'Invalid map URL',
// //           snackPosition: SnackPosition.BOTTOM,
// //           backgroundColor: AppColors.errorColor,
// //           colorText: Colors.white,
// //           margin: const EdgeInsets.all(16),
// //           borderRadius: 12);
// //     }
// //   }
// // }

// // // ─────────────────────────────────────────
// // //   Location Form Bottom Sheet
// // // ─────────────────────────────────────────
// // class _LocationFormSheet extends StatefulWidget {
// //   final LocationController controller;
// //   final CustomSize size;
// //   final bool isEditing;
// //   final LocationItem? existingLocation;

// //   const _LocationFormSheet({
// //     required this.controller,
// //     required this.size,
// //     required this.isEditing,
// //     this.existingLocation,
// //   });

// //   @override
// //   State<_LocationFormSheet> createState() => _LocationFormSheetState();
// // }

// // class _LocationFormSheetState extends State<_LocationFormSheet> {
// //   final _formKey = GlobalKey<FormState>();

// //   @override
// //   Widget build(BuildContext context) {
// //     final size = widget.size;

// //     return Container(
// //       decoration: const BoxDecoration(
// //         color: AppColors.whiteColor,
// //         borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
// //       ),
// //       padding: EdgeInsets.only(
// //         bottom: MediaQuery.of(context).viewInsets.bottom,
// //       ),
// //       child: SingleChildScrollView(
// //         padding: EdgeInsets.fromLTRB(
// //           size.customWidth(context) * 0.05,
// //           24,
// //           size.customWidth(context) * 0.05,
// //           size.customHeight(context) * 0.04,
// //         ),
// //         child: Form(
// //           key: _formKey,
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               // Handle bar
// //               Center(
// //                 child: Container(
// //                   width: 44,
// //                   height: 4,
// //                   decoration: BoxDecoration(
// //                     color: AppColors.greyColor.withOpacity(0.3),
// //                     borderRadius: BorderRadius.circular(2),
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(height: 20),

// //               // Title
// //               Row(
// //                 children: [
// //                   Container(
// //                     padding: const EdgeInsets.all(10),
// //                     decoration: BoxDecoration(
// //                       color: AppColors.primaryColor.withOpacity(0.1),
// //                       borderRadius: BorderRadius.circular(12),
// //                     ),
// //                     child: Icon(
// //                       widget.isEditing
// //                           ? Icons.edit_location_alt_rounded
// //                           : Icons.add_location_alt_rounded,
// //                       color: AppColors.primaryColor,
// //                       size: 22,
// //                     ),
// //                   ),
// //                   const SizedBox(width: 12),
// //                   Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Text(
// //                         widget.isEditing ? 'Edit Location' : 'Add New Location',
// //                         style: GoogleFonts.poppins(
// //                           fontSize: size.customWidth(context) * 0.046,
// //                           fontWeight: FontWeight.bold,
// //                           color: AppColors.textPrimaryColor,
// //                         ),
// //                       ),
// //                       Text(
// //                         widget.isEditing
// //                             ? 'Update location details'
// //                             : 'Fill in your clinic details',
// //                         style: GoogleFonts.poppins(
// //                           fontSize: size.customWidth(context) * 0.032,
// //                           color: AppColors.textSecondaryColor,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //               SizedBox(height: size.customHeight(context) * 0.03),

// //               // Label
// //               _buildInputField(
// //                 controller: widget.controller.labelController,
// //                 label: 'Location Label',
// //                 hint: 'e.g. Main Clinic, Downtown Office',
// //                 icon: Icons.label_outline_rounded,
// //                 validator: (v) =>
// //                     v == null || v.trim().isEmpty ? 'Label is required' : null,
// //                 size: size,
// //                 context: context,
// //               ),
// //               SizedBox(height: size.customHeight(context) * 0.02),

// //               // Address
// //               _buildInputField(
// //                 controller: widget.controller.addressController,
// //                 label: 'Street Address',
// //                 hint: 'e.g. 123 DHA Phase 6',
// //                 icon: Icons.home_outlined,
// //                 validator: (v) =>
// //                     v == null || v.trim().isEmpty ? 'Address is required' : null,
// //                 size: size,
// //                 context: context,
// //                 onChanged: (_) => widget.controller.generateMapsUrl(),
// //               ),
// //               SizedBox(height: size.customHeight(context) * 0.02),

// //               // City
// //               _buildInputField(
// //                 controller: widget.controller.cityController,
// //                 label: 'City',
// //                 hint: 'e.g. Lahore, Karachi, Islamabad',
// //                 icon: Icons.location_city_outlined,
// //                 validator: (v) =>
// //                     v == null || v.trim().isEmpty ? 'City is required' : null,
// //                 size: size,
// //                 context: context,
// //                 onChanged: (_) => widget.controller.generateMapsUrl(),
// //               ),
// //               SizedBox(height: size.customHeight(context) * 0.02),

// //               // Maps URL
// //               _buildMapsUrlField(context, size),

// //               SizedBox(height: size.customHeight(context) * 0.035),

// //               // Submit Button
// //               SizedBox(
// //                 width: double.infinity,
// //                 child: Obx(() => ElevatedButton(
// //                       onPressed: widget.controller.isSaving.value
// //                           ? null
// //                           : () async {
// //                               if (!_formKey.currentState!.validate()) return;
// //                               bool success;
// //                               if (widget.isEditing) {
// //                                 success = await widget.controller.updateLocation(
// //                                     widget.existingLocation!.locationId);
// //                               } else {
// //                                 success = await widget.controller.createLocation();
// //                               }
// //                               if (success && context.mounted) {
// //                                 Navigator.pop(context);
// //                               }
// //                             },
// //                       style: ElevatedButton.styleFrom(
// //                         backgroundColor: AppColors.primaryColor,
// //                         foregroundColor: Colors.white,
// //                         disabledBackgroundColor:
// //                             AppColors.primaryColor.withOpacity(0.5),
// //                         padding: EdgeInsets.symmetric(
// //                             vertical: size.customHeight(context) * 0.02),
// //                         shape: RoundedRectangleBorder(
// //                             borderRadius: BorderRadius.circular(16)),
// //                         elevation: 2,
// //                       ),
// //                       child: widget.controller.isSaving.value
// //                           ? const SizedBox(
// //                               width: 22,
// //                               height: 22,
// //                               child: CircularProgressIndicator(
// //                                   color: Colors.white, strokeWidth: 2.5),
// //                             )
// //                           : Text(
// //                               widget.isEditing ? 'Update Location' : 'Save Location',
// //                               style: GoogleFonts.poppins(
// //                                 fontWeight: FontWeight.w600,
// //                                 fontSize: size.customWidth(context) * 0.042,
// //                               ),
// //                             ),
// //                     )),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildInputField({
// //     required TextEditingController controller,
// //     required String label,
// //     required String hint,
// //     required IconData icon,
// //     required CustomSize size,
// //     required BuildContext context,
// //     String? Function(String?)? validator,
// //     void Function(String)? onChanged,
// //     int maxLines = 1,
// //   }) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Text(
// //           label,
// //           style: GoogleFonts.poppins(
// //             fontSize: size.customWidth(context) * 0.036,
// //             fontWeight: FontWeight.w600,
// //             color: AppColors.textPrimaryColor,
// //           ),
// //         ),
// //         const SizedBox(height: 8),
// //         TextFormField(
// //           controller: controller,
// //           validator: validator,
// //           maxLines: maxLines,
// //           onChanged: onChanged,
// //           style: GoogleFonts.poppins(
// //             fontSize: size.customWidth(context) * 0.038,
// //             color: AppColors.textPrimaryColor,
// //           ),
// //           decoration: InputDecoration(
// //             hintText: hint,
// //             hintStyle: GoogleFonts.poppins(
// //               fontSize: size.customWidth(context) * 0.035,
// //               color: AppColors.textSecondaryColor.withOpacity(0.7),
// //             ),
// //             prefixIcon: Icon(icon, color: AppColors.primaryColor, size: 22),
// //             filled: true,
// //             fillColor: AppColors.lightGreyColor,
// //             contentPadding:
// //                 const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
// //             border: OutlineInputBorder(
// //               borderRadius: BorderRadius.circular(14),
// //               borderSide: BorderSide.none,
// //             ),
// //             enabledBorder: OutlineInputBorder(
// //               borderRadius: BorderRadius.circular(14),
// //               borderSide: BorderSide(
// //                   color: AppColors.greyColor.withOpacity(0.2), width: 1),
// //             ),
// //             focusedBorder: OutlineInputBorder(
// //               borderRadius: BorderRadius.circular(14),
// //               borderSide:
// //                   const BorderSide(color: AppColors.primaryColor, width: 1.5),
// //             ),
// //             errorBorder: OutlineInputBorder(
// //               borderRadius: BorderRadius.circular(14),
// //               borderSide:
// //                   const BorderSide(color: AppColors.errorColor, width: 1),
// //             ),
// //             focusedErrorBorder: OutlineInputBorder(
// //               borderRadius: BorderRadius.circular(14),
// //               borderSide:
// //                   const BorderSide(color: AppColors.errorColor, width: 1.5),
// //             ),
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   Widget _buildMapsUrlField(BuildContext context, CustomSize size) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //           children: [
// //             Text(
// //               'Google Maps URL',
// //               style: GoogleFonts.poppins(
// //                 fontSize: size.customWidth(context) * 0.036,
// //                 fontWeight: FontWeight.w600,
// //                 color: AppColors.textPrimaryColor,
// //               ),
// //             ),
// //             GestureDetector(
// //               onTap: () {
// //                 widget.controller.generateMapsUrl();
// //                 setState(() {});
// //               },
// //               child: Container(
// //                 padding:
// //                     const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
// //                 decoration: BoxDecoration(
// //                   color: AppColors.primaryColor.withOpacity(0.1),
// //                   borderRadius: BorderRadius.circular(8),
// //                 ),
// //                 child: Row(
// //                   mainAxisSize: MainAxisSize.min,
// //                   children: [
// //                     const Icon(Icons.auto_fix_high_rounded,
// //                         size: 14, color: AppColors.primaryColor),
// //                     const SizedBox(width: 4),
// //                     Text(
// //                       'Auto-generate',
// //                       style: GoogleFonts.poppins(
// //                         fontSize: size.customWidth(context) * 0.028,
// //                         color: AppColors.primaryColor,
// //                         fontWeight: FontWeight.w500,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //         const SizedBox(height: 8),
// //         TextFormField(
// //           controller: widget.controller.mapsUrlController,
// //           style: GoogleFonts.poppins(
// //             fontSize: size.customWidth(context) * 0.034,
// //             color: AppColors.textPrimaryColor,
// //           ),
// //           decoration: InputDecoration(
// //             hintText: 'https://maps.google.com/?q=...',
// //             hintStyle: GoogleFonts.poppins(
// //               fontSize: size.customWidth(context) * 0.032,
// //               color: AppColors.textSecondaryColor.withOpacity(0.7),
// //             ),
// //             prefixIcon: const Icon(Icons.map_outlined,
// //                 color: AppColors.accentColor, size: 22),
// //             suffixIcon: IconButton(
// //               icon: const Icon(Icons.open_in_new_rounded,
// //                   color: AppColors.accentColor, size: 18),
// //               tooltip: 'Preview in Maps',
// //               onPressed: () async {
// //                 final url = widget.controller.mapsUrlController.text.trim();
// //                 if (url.isEmpty) return;
// //                 final uri = Uri.tryParse(url);
// //                 if (uri != null && await canLaunchUrl(uri)) {
// //                   await launchUrl(uri, mode: LaunchMode.externalApplication);
// //                 }
// //               },
// //             ),
// //             filled: true,
// //             fillColor: AppColors.lightGreyColor,
// //             contentPadding:
// //                 const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
// //             border: OutlineInputBorder(
// //               borderRadius: BorderRadius.circular(14),
// //               borderSide: BorderSide.none,
// //             ),
// //             enabledBorder: OutlineInputBorder(
// //               borderRadius: BorderRadius.circular(14),
// //               borderSide: BorderSide(
// //                   color: AppColors.greyColor.withOpacity(0.2), width: 1),
// //             ),
// //             focusedBorder: OutlineInputBorder(
// //               borderRadius: BorderRadius.circular(14),
// //               borderSide:
// //                   const BorderSide(color: AppColors.primaryColor, width: 1.5),
// //             ),
// //           ),
// //         ),
// //         const SizedBox(height: 6),
// //         Text(
// //           'Tap "Auto-generate" to create URL from address above, or paste manually.',
// //           style: GoogleFonts.poppins(
// //             fontSize: size.customWidth(context) * 0.028,
// //             color: AppColors.textSecondaryColor,
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }


// // // lib/view/expert/location/expert_locations_screen.dart
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:get/get.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:latlong2/latlong.dart';
// // import 'package:speechspectrum/view/expert/location/flutter_map_view_widget.dart';
// // import 'package:url_launcher/url_launcher.dart';
// // import 'package:speechspectrum/constants/app_colors.dart';
// // import 'package:speechspectrum/constants/custom_size.dart';
// // import 'package:speechspectrum/controllers/location_controller.dart';
// // import 'package:speechspectrum/models/location_model.dart';
// // import 'package:speechspectrum/routes/app_routes.dart';
// // import 'map_picker_screen.dart';
// // import 'location_picker_screen.dart';

// // class ExpertLocationsScreen extends StatefulWidget {
// //   const ExpertLocationsScreen({super.key});

// //   @override
// //   State<ExpertLocationsScreen> createState() => _ExpertLocationsScreenState();
// // }

// // class _ExpertLocationsScreenState extends State<ExpertLocationsScreen> {
// //   late final LocationController controller;

// //   @override
// //   void initState() {
// //     super.initState();
// //     if (Get.isRegistered<LocationController>()) {
// //       controller = Get.find<LocationController>();
// //     } else {
// //       controller = Get.put(LocationController());
// //     }
// //     WidgetsBinding.instance.addPostFrameCallback((_) {
// //       controller.fetchMyLocations();
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final size = CustomSize();

// //     return Scaffold(
// //       backgroundColor: AppColors.lightGreyColor,
// //       appBar: _buildAppBar(context, size),
// //       body: Obx(() {
// //         if (controller.isLoading.value) {
// //           return _buildLoader(context, size);
// //         }
// //         if (controller.myLocations.isEmpty) {
// //           return _buildEmptyState(context, size);
// //         }
// //         return RefreshIndicator(
// //           color: AppColors.primaryColor,
// //           onRefresh: () => controller.fetchMyLocations(),
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
// //               _buildHeaderBanner(context, size),
// //               SizedBox(height: size.customHeight(context) * 0.025),
// //               ...controller.myLocations
// //                   .map((loc) => _buildLocationCard(context, size, loc))
// //                   .toList(),
// //             ],
// //           ),
// //         );
// //       }),
// //       floatingActionButton: _buildFAB(context, size),
// //     );
// //   }

// //   PreferredSizeWidget _buildAppBar(BuildContext context, CustomSize size) {
// //     return AppBar(
// //       backgroundColor: AppColors.whiteColor,
// //       elevation: 0,
// //       surfaceTintColor: Colors.transparent,
// //       leading: IconButton(
// //         icon: const Icon(Icons.arrow_back_ios_new_rounded,
// //             color: AppColors.textPrimaryColor, size: 20),
// //         onPressed: () => Get.back(),
// //       ),
// //       title: Text(
// //         'My Locations',
// //         style: GoogleFonts.poppins(
// //           color: AppColors.textPrimaryColor,
// //           fontSize: 18,
// //           fontWeight: FontWeight.w600,
// //         ),
// //       ),
// //       actions: [
// //         Obx(() => controller.isLoading.value
// //             ? const Padding(
// //                 padding: EdgeInsets.all(16),
// //                 child: SizedBox(
// //                   width: 20,
// //                   height: 20,
// //                   child: CircularProgressIndicator(
// //                       color: AppColors.primaryColor, strokeWidth: 2),
// //                 ),
// //               )
// //             : IconButton(
// //                 icon: const Icon(Icons.refresh_rounded,
// //                     color: AppColors.primaryColor),
// //                 onPressed: () => controller.fetchMyLocations(),
// //               )),
// //         SizedBox(width: size.customWidth(context) * 0.01),
// //       ],
// //     );
// //   }

// //   Widget _buildHeaderBanner(BuildContext context, CustomSize size) {
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
// //             color: AppColors.primaryColor.withOpacity(0.28),
// //             blurRadius: 18,
// //             offset: const Offset(0, 5),
// //           ),
// //         ],
// //       ),
// //       child: Row(
// //         children: [
// //           Container(
// //             padding: const EdgeInsets.all(12),
// //             decoration: BoxDecoration(
// //               color: Colors.white.withOpacity(0.2),
// //               borderRadius: BorderRadius.circular(14),
// //             ),
// //             child: const Icon(Icons.location_on_rounded,
// //                 color: Colors.white, size: 28),
// //           ),
// //           SizedBox(width: size.customWidth(context) * 0.04),
// //           Expanded(
// //             child: Obx(() => Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text(
// //                       '${controller.myLocations.length} Location${controller.myLocations.length != 1 ? 's' : ''} Added',
// //                       style: GoogleFonts.poppins(
// //                         color: Colors.white,
// //                         fontSize: size.customWidth(context) * 0.044,
// //                         fontWeight: FontWeight.bold,
// //                       ),
// //                     ),
// //                     Text(
// //                       'Tap + to add a new clinic or office',
// //                       style: GoogleFonts.poppins(
// //                         color: Colors.white.withOpacity(0.85),
// //                         fontSize: size.customWidth(context) * 0.031,
// //                       ),
// //                     ),
// //                   ],
// //                 )),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildLocationCard(
// //       BuildContext context, CustomSize size, LocationItem location) {
// //     return Container(
// //       margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.018),
// //       decoration: BoxDecoration(
// //         color: AppColors.whiteColor,
// //         borderRadius: BorderRadius.circular(22),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.06),
// //             blurRadius: 16,
// //             offset: const Offset(0, 4),
// //           ),
// //         ],
// //       ),
// //       child: Column(
// //         children: [
// //           // ── Card header ──────────────────────────────────────
// //           Padding(
// //             padding: EdgeInsets.all(size.customWidth(context) * 0.045),
// //             child: Row(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Container(
// //                   width: 54,
// //                   height: 54,
// //                   decoration: BoxDecoration(
// //                     color: AppColors.primaryColor.withOpacity(0.1),
// //                     borderRadius: BorderRadius.circular(15),
// //                   ),
// //                   child: const Icon(Icons.business_rounded,
// //                       color: AppColors.primaryColor, size: 26),
// //                 ),
// //                 SizedBox(width: size.customWidth(context) * 0.035),
// //                 Expanded(
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Row(
// //                         children: [
// //                           Expanded(
// //                             child: Text(
// //                               location.label,
// //                               style: GoogleFonts.poppins(
// //                                 fontSize: size.customWidth(context) * 0.042,
// //                                 fontWeight: FontWeight.w700,
// //                                 color: AppColors.textPrimaryColor,
// //                               ),
// //                               maxLines: 1,
// //                               overflow: TextOverflow.ellipsis,
// //                             ),
// //                           ),
// //                           const SizedBox(width: 8),
// //                           Container(
// //                             padding: const EdgeInsets.symmetric(
// //                                 horizontal: 10, vertical: 4),
// //                             decoration: BoxDecoration(
// //                               color: location.isActive
// //                                   ? AppColors.successColor.withOpacity(0.1)
// //                                   : AppColors.errorColor.withOpacity(0.1),
// //                               borderRadius: BorderRadius.circular(20),
// //                             ),
// //                             child: Text(
// //                               location.isActive ? 'Active' : 'Inactive',
// //                               style: GoogleFonts.poppins(
// //                                 fontSize: size.customWidth(context) * 0.027,
// //                                 fontWeight: FontWeight.w600,
// //                                 color: location.isActive
// //                                     ? AppColors.successColor
// //                                     : AppColors.errorColor,
// //                               ),
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                       SizedBox(height: size.customHeight(context) * 0.006),
// //                       _infoRow(
// //                         Icons.location_on_outlined,
// //                         location.address,
// //                         size,
// //                         context,
// //                       ),
// //                       SizedBox(height: size.customHeight(context) * 0.004),
// //                       _infoRow(
// //                         Icons.location_city_outlined,
// //                         location.city,
// //                         size,
// //                         context,
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),

// //           Divider(height: 1, color: AppColors.greyColor.withOpacity(0.15)),

// //           // ── Action buttons ───────────────────────────────────
// //           Padding(
// //             padding: EdgeInsets.symmetric(
// //               horizontal: size.customWidth(context) * 0.02,
// //               vertical: size.customHeight(context) * 0.006,
// //             ),
// //             child: Row(
// //               children: [
// //                 _cardAction(
// //                   icon: Icons.map_outlined,
// //                   label: 'View Map',
// //                   color: AppColors.accentColor,
// //                   onTap: () => _openInExternalMaps(location.mapsUrl),
// //                 ),
// //                 _cardAction(
// //                   icon: Icons.open_in_new_rounded,
// //                   label: 'In-App Map',
// //                   color: AppColors.primaryColor,
// //                   onTap: () => _openInAppMap(location),
// //                 ),
// //                 _cardAction(
// //                   icon: Icons.copy_outlined,
// //                   label: 'Copy Link',
// //                   color: AppColors.secondaryColor,
// //                   onTap: () {
// //                     Clipboard.setData(ClipboardData(text: location.mapsUrl));
// //                     Get.snackbar(
// //                       'Copied!',
// //                       'Maps link copied to clipboard',
// //                       snackPosition: SnackPosition.BOTTOM,
// //                       backgroundColor: AppColors.textPrimaryColor,
// //                       colorText: Colors.white,
// //                       margin: const EdgeInsets.all(16),
// //                       borderRadius: 12,
// //                       duration: const Duration(seconds: 2),
// //                     );
// //                   },
// //                 ),
// //                 _cardAction(
// //                   icon: Icons.edit_outlined,
// //                   label: 'Edit',
// //                   color: AppColors.warningColor,
// //                   onTap: () =>
// //                       _openLocationSheet(context, size, existing: location),
// //                 ),
// //                 _cardAction(
// //                   icon: Icons.delete_outline_rounded,
// //                   label: 'Delete',
// //                   color: AppColors.errorColor,
// //                   onTap: () =>
// //                       _showDeleteConfirm(context, size, location),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _infoRow(
// //       IconData icon, String text, CustomSize size, BuildContext context) {
// //     return Row(
// //       children: [
// //         Icon(icon, size: 13, color: AppColors.textSecondaryColor),
// //         const SizedBox(width: 4),
// //         Expanded(
// //           child: Text(
// //             text,
// //             style: GoogleFonts.poppins(
// //               fontSize: size.customWidth(context) * 0.032,
// //               color: AppColors.textSecondaryColor,
// //             ),
// //             maxLines: 1,
// //             overflow: TextOverflow.ellipsis,
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   Widget _cardAction({
// //     required IconData icon,
// //     required String label,
// //     required Color color,
// //     required VoidCallback onTap,
// //   }) {
// //     return Expanded(
// //       child: InkWell(
// //         onTap: onTap,
// //         borderRadius: BorderRadius.circular(10),
// //         child: Padding(
// //           padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
// //           child: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               Icon(icon, color: color, size: 19),
// //               const SizedBox(height: 4),
// //               Text(
// //                 label,
// //                 style: GoogleFonts.poppins(
// //                   fontSize: 10,
// //                   fontWeight: FontWeight.w500,
// //                   color: color,
// //                 ),
// //                 textAlign: TextAlign.center,
// //                 maxLines: 1,
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildFAB(BuildContext context, CustomSize size) {
// //     return FloatingActionButton.extended(
// //       onPressed: () => _openLocationSheet(context, size),
// //       backgroundColor: AppColors.primaryColor,
// //       elevation: 4,
// //       icon: const Icon(Icons.add_location_alt_rounded, color: Colors.white),
// //       label: Text(
// //         'Add Location',
// //         style: GoogleFonts.poppins(
// //           color: Colors.white,
// //           fontWeight: FontWeight.w600,
// //           fontSize: 14,
// //         ),
// //       ),
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
// //           Text(
// //             'Loading your locations...',
// //             style: GoogleFonts.poppins(
// //               color: AppColors.textSecondaryColor,
// //               fontSize: size.customWidth(context) * 0.036,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildEmptyState(BuildContext context, CustomSize size) {
// //     return Center(
// //       child: Padding(
// //         padding: EdgeInsets.all(size.customWidth(context) * 0.1),
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Container(
// //               width: 130,
// //               height: 130,
// //               decoration: BoxDecoration(
// //                 color: AppColors.primaryColor.withOpacity(0.08),
// //                 shape: BoxShape.circle,
// //               ),
// //               child: const Icon(Icons.add_location_alt_outlined,
// //                   size: 64, color: AppColors.primaryColor),
// //             ),
// //             SizedBox(height: size.customHeight(context) * 0.03),
// //             Text(
// //               'No Locations Yet',
// //               style: GoogleFonts.poppins(
// //                 fontSize: size.customWidth(context) * 0.052,
// //                 fontWeight: FontWeight.bold,
// //                 color: AppColors.textPrimaryColor,
// //               ),
// //             ),
// //             SizedBox(height: size.customHeight(context) * 0.012),
// //             Text(
// //               'Add your clinic or office locations\nso patients can find you easily.',
// //               textAlign: TextAlign.center,
// //               style: GoogleFonts.poppins(
// //                 fontSize: size.customWidth(context) * 0.035,
// //                 color: AppColors.textSecondaryColor,
// //                 height: 1.6,
// //               ),
// //             ),
// //             SizedBox(height: size.customHeight(context) * 0.04),
// //             ElevatedButton.icon(
// //               onPressed: () => _openLocationSheet(context, size),
// //               style: ElevatedButton.styleFrom(
// //                 backgroundColor: AppColors.primaryColor,
// //                 foregroundColor: Colors.white,
// //                 padding: EdgeInsets.symmetric(
// //                   horizontal: size.customWidth(context) * 0.08,
// //                   vertical: size.customHeight(context) * 0.018,
// //                 ),
// //                 shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(14)),
// //                 elevation: 2,
// //               ),
// //               icon: const Icon(Icons.add_location_alt_rounded),
// //               label: Text(
// //                 'Add First Location',
// //                 style: GoogleFonts.poppins(
// //                     fontWeight: FontWeight.w600, fontSize: 15),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   // ── Navigations ──────────────────────────────────────────────

// //   void _openLocationSheet(BuildContext context, CustomSize size,
// //       {LocationItem? existing}) {
// //     if (existing != null) {
// //       controller.populateForm(existing);
// //     } else {
// //       controller.clearForm();
// //     }
// //     showModalBottomSheet(
// //       context: context,
// //       isScrollControlled: true,
// //       backgroundColor: Colors.transparent,
// //       enableDrag: true,
// //       builder: (ctx) => _LocationFormSheet(
// //         controller: controller,
// //         size: size,
// //         isEditing: existing != null,
// //         existingLocation: existing,
// //       ),
// //     );
// //   }

// //   Future<void> _openInExternalMaps(String url) async {
// //     try {
// //       final uri = Uri.parse(url);
// //       if (await canLaunchUrl(uri)) {
// //         await launchUrl(uri, mode: LaunchMode.externalApplication);
// //       } else {
// //         _urlError();
// //       }
// //     } catch (_) {
// //       _urlError();
// //     }
// //   }

// //   /// Open in-app flutter_map viewer for a saved location
// //   void _openInAppMap(LocationItem location) {
// //     // Parse lat/lng from URL if possible, otherwise default to Lahore
// //     LatLng? initial;
// //     try {
// //       final uri = Uri.parse(location.mapsUrl);
// //       final q = uri.queryParameters['q'] ?? '';
// //       final parts = q.split(',');
// //       if (parts.length == 2) {
// //         final lat = double.tryParse(parts[0]);
// //         final lng = double.tryParse(parts[1]);
// //         if (lat != null && lng != null) initial = LatLng(lat, lng);
// //       }
// //     } catch (_) {}

// //     Get.to(() => _InAppMapViewScreen(location: location, initial: initial));
// //   }

// //   void _urlError() => Get.snackbar('Error', 'Could not open map',
// //       snackPosition: SnackPosition.BOTTOM,
// //       backgroundColor: AppColors.errorColor,
// //       colorText: Colors.white,
// //       margin: const EdgeInsets.all(16),
// //       borderRadius: 12);

// //   void _showDeleteConfirm(
// //       BuildContext context, CustomSize size, LocationItem location) {
// //     showDialog(
// //       context: context,
// //       barrierDismissible: false,
// //       builder: (ctx) => AlertDialog(
// //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
// //         contentPadding: const EdgeInsets.all(24),
// //         content: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             Container(
// //               padding: const EdgeInsets.all(16),
// //               decoration: BoxDecoration(
// //                 color: AppColors.errorColor.withOpacity(0.1),
// //                 shape: BoxShape.circle,
// //               ),
// //               child: const Icon(Icons.delete_forever_rounded,
// //                   color: AppColors.errorColor, size: 38),
// //             ),
// //             const SizedBox(height: 16),
// //             Text(
// //               'Delete Location?',
// //               style: GoogleFonts.poppins(
// //                 fontSize: 18,
// //                 fontWeight: FontWeight.bold,
// //                 color: AppColors.textPrimaryColor,
// //               ),
// //             ),
// //             const SizedBox(height: 8),
// //             Text(
// //               '"${location.label}" will be permanently removed.',
// //               textAlign: TextAlign.center,
// //               style: GoogleFonts.poppins(
// //                 fontSize: 14,
// //                 color: AppColors.textSecondaryColor,
// //                 height: 1.5,
// //               ),
// //             ),
// //             const SizedBox(height: 24),
// //             Row(
// //               children: [
// //                 Expanded(
// //                   child: OutlinedButton(
// //                     onPressed: () => Navigator.pop(ctx),
// //                     style: OutlinedButton.styleFrom(
// //                       foregroundColor: AppColors.textSecondaryColor,
// //                       side: BorderSide(
// //                           color: AppColors.greyColor.withOpacity(0.4)),
// //                       shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(12)),
// //                       padding: const EdgeInsets.symmetric(vertical: 13),
// //                     ),
// //                     child: Text('Cancel',
// //                         style: GoogleFonts.poppins(
// //                             fontWeight: FontWeight.w500, fontSize: 14)),
// //                   ),
// //                 ),
// //                 const SizedBox(width: 12),
// //                 Expanded(
// //                   child: Obx(() => ElevatedButton(
// //                         onPressed: controller.isDeleting.value
// //                             ? null
// //                             : () async {
// //                                 final ok = await controller
// //                                     .deleteLocation(location.locationId);
// //                                 if (ok && ctx.mounted) Navigator.pop(ctx);
// //                               },
// //                         style: ElevatedButton.styleFrom(
// //                           backgroundColor: AppColors.errorColor,
// //                           foregroundColor: Colors.white,
// //                           shape: RoundedRectangleBorder(
// //                               borderRadius: BorderRadius.circular(12)),
// //                           padding: const EdgeInsets.symmetric(vertical: 13),
// //                           elevation: 0,
// //                         ),
// //                         child: controller.isDeleting.value
// //                             ? const SizedBox(
// //                                 width: 18,
// //                                 height: 18,
// //                                 child: CircularProgressIndicator(
// //                                     color: Colors.white, strokeWidth: 2))
// //                             : Text('Delete',
// //                                 style: GoogleFonts.poppins(
// //                                     fontWeight: FontWeight.w600, fontSize: 14)),
// //                       )),
// //                 ),
// //               ],
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // // ═══════════════════════════════════════════════════════════════
// // //   Location Form Bottom Sheet
// // // ═══════════════════════════════════════════════════════════════
// // class _LocationFormSheet extends StatefulWidget {
// //   final LocationController controller;
// //   final CustomSize size;
// //   final bool isEditing;
// //   final LocationItem? existingLocation;

// //   const _LocationFormSheet({
// //     required this.controller,
// //     required this.size,
// //     required this.isEditing,
// //     this.existingLocation,
// //   });

// //   @override
// //   State<_LocationFormSheet> createState() => _LocationFormSheetState();
// // }

// // class _LocationFormSheetState extends State<_LocationFormSheet> {
// //   final _formKey = GlobalKey<FormState>();

// //   @override
// //   Widget build(BuildContext context) {
// //     final size = widget.size;

// //     return Container(
// //       decoration: const BoxDecoration(
// //         color: AppColors.whiteColor,
// //         borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
// //       ),
// //       padding: EdgeInsets.only(
// //           bottom: MediaQuery.of(context).viewInsets.bottom),
// //       child: SingleChildScrollView(
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
// //               // Handle bar
// //               Center(
// //                 child: Container(
// //                   width: 44,
// //                   height: 4,
// //                   decoration: BoxDecoration(
// //                     color: AppColors.greyColor.withOpacity(0.3),
// //                     borderRadius: BorderRadius.circular(2),
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(height: 20),

// //               // Title row
// //               Row(
// //                 children: [
// //                   Container(
// //                     padding: const EdgeInsets.all(10),
// //                     decoration: BoxDecoration(
// //                       color: AppColors.primaryColor.withOpacity(0.1),
// //                       borderRadius: BorderRadius.circular(12),
// //                     ),
// //                     child: Icon(
// //                       widget.isEditing
// //                           ? Icons.edit_location_alt_rounded
// //                           : Icons.add_location_alt_rounded,
// //                       color: AppColors.primaryColor,
// //                       size: 22,
// //                     ),
// //                   ),
// //                   const SizedBox(width: 12),
// //                   Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Text(
// //                         widget.isEditing
// //                             ? 'Edit Location'
// //                             : 'Add New Location',
// //                         style: GoogleFonts.poppins(
// //                           fontSize: size.customWidth(context) * 0.046,
// //                           fontWeight: FontWeight.bold,
// //                           color: AppColors.textPrimaryColor,
// //                         ),
// //                       ),
// //                       Text(
// //                         widget.isEditing
// //                             ? 'Update location details'
// //                             : 'Choose existing or fill manually',
// //                         style: GoogleFonts.poppins(
// //                           fontSize: size.customWidth(context) * 0.031,
// //                           color: AppColors.textSecondaryColor,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ],
// //               ),

// //               // ── Option tiles (only on CREATE) ─────────────────
// //               if (!widget.isEditing) ...[
// //                 SizedBox(height: size.customHeight(context) * 0.025),
// //                 Text(
// //                   'Quick options',
// //                   style: GoogleFonts.poppins(
// //                     fontSize: size.customWidth(context) * 0.034,
// //                     fontWeight: FontWeight.w600,
// //                     color: AppColors.textSecondaryColor,
// //                   ),
// //                 ),
// //                 const SizedBox(height: 10),
// //                 Row(
// //                   children: [
// //                     // Select from existing
// //                     Expanded(
// //                       child: _QuickOptionTile(
// //                         icon: Icons.list_alt_rounded,
// //                         label: 'Select existing',
// //                         sublabel: 'From saved locations',
// //                         color: AppColors.primaryColor,
// //                         onTap: () async {
// //                           final result = await Get.to<LocationItem>(
// //                             () => const LocationPickerScreen(),
// //                           );
// //                           if (result != null) {
// //                             widget.controller.populateFromExisting(result);
// //                             setState(() {});
// //                           }
// //                         },
// //                       ),
// //                     ),
// //                     const SizedBox(width: 12),
// //                     // Pick from map
// //                     Expanded(
// //                       child: _QuickOptionTile(
// //                         icon: Icons.map_rounded,
// //                         label: 'Pick on map',
// //                         sublabel: 'Tap to choose',
// //                         color: AppColors.accentColor,
// //                         onTap: () async {
// //                           final result = await Get.to<MapPickResult>(
// //                             () => const MapPickerScreen(),
// //                           );
// //                           if (result != null) {
// //                             widget.controller.populateFromMapPick(
// //                               address: result.address,
// //                               city: result.city,
// //                               mapsUrl: result.mapsUrl,
// //                             );
// //                             setState(() {});
// //                           }
// //                         },
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //                 SizedBox(height: size.customHeight(context) * 0.025),
// //                 Row(
// //                   children: [
// //                     Expanded(
// //                         child: Divider(
// //                             color: AppColors.greyColor.withOpacity(0.25))),
// //                     Padding(
// //                       padding: const EdgeInsets.symmetric(horizontal: 12),
// //                       child: Text(
// //                         'or fill manually',
// //                         style: GoogleFonts.poppins(
// //                           fontSize: size.customWidth(context) * 0.03,
// //                           color: AppColors.textSecondaryColor,
// //                         ),
// //                       ),
// //                     ),
// //                     Expanded(
// //                         child: Divider(
// //                             color: AppColors.greyColor.withOpacity(0.25))),
// //                   ],
// //                 ),
// //               ],

// //               // ── Form fields ───────────────────────────────────
// //               SizedBox(height: size.customHeight(context) * 0.022),

// //               _field(
// //                 ctx: context,
// //                 ctrl: widget.controller.labelController,
// //                 label: 'Location Label',
// //                 hint: 'e.g. Main Clinic, Downtown Office',
// //                 icon: Icons.label_outline_rounded,
// //                 size: size,
// //                 validator: (v) =>
// //                     v == null || v.trim().isEmpty ? 'Label is required' : null,
// //               ),
// //               SizedBox(height: size.customHeight(context) * 0.018),

// //               _field(
// //                 ctx: context,
// //                 ctrl: widget.controller.addressController,
// //                 label: 'Street Address',
// //                 hint: 'e.g. 123 DHA Phase 6',
// //                 icon: Icons.home_outlined,
// //                 size: size,
// //                 validator: (v) =>
// //                     v == null || v.trim().isEmpty ? 'Address is required' : null,
// //                 onChanged: (_) {
// //                   widget.controller.generateMapsUrl();
// //                   setState(() {});
// //                 },
// //               ),
// //               SizedBox(height: size.customHeight(context) * 0.018),

// //               _field(
// //                 ctx: context,
// //                 ctrl: widget.controller.cityController,
// //                 label: 'City',
// //                 hint: 'e.g. Lahore, Karachi, Islamabad',
// //                 icon: Icons.location_city_outlined,
// //                 size: size,
// //                 validator: (v) =>
// //                     v == null || v.trim().isEmpty ? 'City is required' : null,
// //                 onChanged: (_) {
// //                   widget.controller.generateMapsUrl();
// //                   setState(() {});
// //                 },
// //               ),
// //               SizedBox(height: size.customHeight(context) * 0.018),

// //               // Maps URL field
// //               _buildMapsUrlField(context, size),

// //               SizedBox(height: size.customHeight(context) * 0.03),

// //               // ── Edit: open in-app map button ──────────────────
// //               if (widget.isEditing) ...[
// //                 OutlinedButton.icon(
// //                   onPressed: () async {
// //                     LatLng? initial;
// //                     try {
// //                       final uri = Uri.parse(
// //                           widget.controller.mapsUrlController.text.trim());
// //                       final q = uri.queryParameters['q'] ?? '';
// //                       final parts = q.split(',');
// //                       if (parts.length == 2) {
// //                         final lat = double.tryParse(parts[0]);
// //                         final lng = double.tryParse(parts[1]);
// //                         if (lat != null && lng != null) {
// //                           initial = LatLng(lat, lng);
// //                         }
// //                       }
// //                     } catch (_) {}
// //                     final result = await Get.to<MapPickResult>(
// //                       () => MapPickerScreen(initialPosition: initial),
// //                     );
// //                     if (result != null) {
// //                       widget.controller.populateFromMapPick(
// //                         address: result.address,
// //                         city: result.city,
// //                         mapsUrl: result.mapsUrl,
// //                       );
// //                       setState(() {});
// //                     }
// //                   },
// //                   style: OutlinedButton.styleFrom(
// //                     foregroundColor: AppColors.primaryColor,
// //                     side: BorderSide(
// //                         color: AppColors.primaryColor.withOpacity(0.5)),
// //                     shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(14)),
// //                     padding: EdgeInsets.symmetric(
// //                         vertical: size.customHeight(context) * 0.016),
// //                     minimumSize: const Size(double.infinity, 0),
// //                   ),
// //                   icon: const Icon(Icons.map_rounded, size: 18),
// //                   label: Text(
// //                     'Pick new location on map',
// //                     style: GoogleFonts.poppins(
// //                         fontWeight: FontWeight.w500, fontSize: 14),
// //                   ),
// //                 ),
// //                 SizedBox(height: size.customHeight(context) * 0.018),
// //               ],

// //               // Submit button
// //               SizedBox(
// //                 width: double.infinity,
// //                 child: Obx(() => ElevatedButton(
// //                       onPressed: widget.controller.isSaving.value
// //                           ? null
// //                           : () async {
// //                               if (!_formKey.currentState!.validate()) return;
// //                               bool ok;
// //                               if (widget.isEditing) {
// //                                 ok = await widget.controller.updateLocation(
// //                                     widget.existingLocation!.locationId);
// //                               } else {
// //                                 ok = await widget.controller.createLocation();
// //                               }
// //                               if (ok && context.mounted) Navigator.pop(context);
// //                             },
// //                       style: ElevatedButton.styleFrom(
// //                         backgroundColor: AppColors.primaryColor,
// //                         foregroundColor: Colors.white,
// //                         disabledBackgroundColor:
// //                             AppColors.primaryColor.withOpacity(0.4),
// //                         padding: EdgeInsets.symmetric(
// //                             vertical: size.customHeight(context) * 0.02),
// //                         shape: RoundedRectangleBorder(
// //                             borderRadius: BorderRadius.circular(16)),
// //                         elevation: 2,
// //                       ),
// //                       child: widget.controller.isSaving.value
// //                           ? const SizedBox(
// //                               width: 22,
// //                               height: 22,
// //                               child: CircularProgressIndicator(
// //                                   color: Colors.white, strokeWidth: 2.5))
// //                           : Text(
// //                               widget.isEditing
// //                                   ? 'Update Location'
// //                                   : 'Save Location',
// //                               style: GoogleFonts.poppins(
// //                                 fontWeight: FontWeight.w600,
// //                                 fontSize: size.customWidth(context) * 0.042,
// //                               ),
// //                             ),
// //                     )),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildMapsUrlField(BuildContext context, CustomSize size) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //           children: [
// //             Text(
// //               'Google Maps URL',
// //               style: GoogleFonts.poppins(
// //                 fontSize: size.customWidth(context) * 0.036,
// //                 fontWeight: FontWeight.w600,
// //                 color: AppColors.textPrimaryColor,
// //               ),
// //             ),
// //             GestureDetector(
// //               onTap: () {
// //                 widget.controller.generateMapsUrl();
// //                 setState(() {});
// //               },
// //               child: Container(
// //                 padding:
// //                     const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
// //                 decoration: BoxDecoration(
// //                   color: AppColors.primaryColor.withOpacity(0.1),
// //                   borderRadius: BorderRadius.circular(8),
// //                 ),
// //                 child: Row(
// //                   mainAxisSize: MainAxisSize.min,
// //                   children: [
// //                     const Icon(Icons.auto_fix_high_rounded,
// //                         size: 13, color: AppColors.primaryColor),
// //                     const SizedBox(width: 4),
// //                     Text(
// //                       'Auto-generate',
// //                       style: GoogleFonts.poppins(
// //                         fontSize: size.customWidth(context) * 0.028,
// //                         color: AppColors.primaryColor,
// //                         fontWeight: FontWeight.w500,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //         const SizedBox(height: 8),
// //         TextFormField(
// //           controller: widget.controller.mapsUrlController,
// //           style: GoogleFonts.poppins(
// //             fontSize: size.customWidth(context) * 0.033,
// //             color: AppColors.textPrimaryColor,
// //           ),
// //           decoration: InputDecoration(
// //             hintText: 'https://maps.google.com/?q=...',
// //             hintStyle: GoogleFonts.poppins(
// //               fontSize: size.customWidth(context) * 0.031,
// //               color: AppColors.textSecondaryColor.withOpacity(0.7),
// //             ),
// //             prefixIcon:
// //                 const Icon(Icons.map_outlined, color: AppColors.accentColor, size: 22),
// //             suffixIcon: IconButton(
// //               icon: const Icon(Icons.open_in_new_rounded,
// //                   color: AppColors.accentColor, size: 18),
// //               tooltip: 'Preview in Maps',
// //               onPressed: () async {
// //                 final url =
// //                     widget.controller.mapsUrlController.text.trim();
// //                 if (url.isEmpty) return;
// //                 final uri = Uri.tryParse(url);
// //                 if (uri != null && await canLaunchUrl(uri)) {
// //                   await launchUrl(uri, mode: LaunchMode.externalApplication);
// //                 }
// //               },
// //             ),
// //             filled: true,
// //             fillColor: AppColors.lightGreyColor,
// //             contentPadding:
// //                 const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
// //             border: OutlineInputBorder(
// //               borderRadius: BorderRadius.circular(14),
// //               borderSide: BorderSide.none,
// //             ),
// //             enabledBorder: OutlineInputBorder(
// //               borderRadius: BorderRadius.circular(14),
// //               borderSide: BorderSide(
// //                   color: AppColors.greyColor.withOpacity(0.2), width: 1),
// //             ),
// //             focusedBorder: OutlineInputBorder(
// //               borderRadius: BorderRadius.circular(14),
// //               borderSide:
// //                   const BorderSide(color: AppColors.primaryColor, width: 1.5),
// //             ),
// //           ),
// //         ),
// //         const SizedBox(height: 5),
// //         Text(
// //           'Tap "Auto-generate" to build from address, or paste manually.',
// //           style: GoogleFonts.poppins(
// //             fontSize: size.customWidth(context) * 0.028,
// //             color: AppColors.textSecondaryColor,
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   Widget _field({
// //     required BuildContext ctx,
// //     required TextEditingController ctrl,
// //     required String label,
// //     required String hint,
// //     required IconData icon,
// //     required CustomSize size,
// //     String? Function(String?)? validator,
// //     void Function(String)? onChanged,
// //   }) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Text(
// //           label,
// //           style: GoogleFonts.poppins(
// //             fontSize: size.customWidth(ctx) * 0.036,
// //             fontWeight: FontWeight.w600,
// //             color: AppColors.textPrimaryColor,
// //           ),
// //         ),
// //         const SizedBox(height: 8),
// //         TextFormField(
// //           controller: ctrl,
// //           validator: validator,
// //           onChanged: onChanged,
// //           style: GoogleFonts.poppins(
// //             fontSize: size.customWidth(ctx) * 0.038,
// //             color: AppColors.textPrimaryColor,
// //           ),
// //           decoration: InputDecoration(
// //             hintText: hint,
// //             hintStyle: GoogleFonts.poppins(
// //               fontSize: size.customWidth(ctx) * 0.035,
// //               color: AppColors.textSecondaryColor.withOpacity(0.7),
// //             ),
// //             prefixIcon: Icon(icon, color: AppColors.primaryColor, size: 22),
// //             filled: true,
// //             fillColor: AppColors.lightGreyColor,
// //             contentPadding:
// //                 const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
// //             border: OutlineInputBorder(
// //               borderRadius: BorderRadius.circular(14),
// //               borderSide: BorderSide.none,
// //             ),
// //             enabledBorder: OutlineInputBorder(
// //               borderRadius: BorderRadius.circular(14),
// //               borderSide: BorderSide(
// //                   color: AppColors.greyColor.withOpacity(0.2), width: 1),
// //             ),
// //             focusedBorder: OutlineInputBorder(
// //               borderRadius: BorderRadius.circular(14),
// //               borderSide:
// //                   const BorderSide(color: AppColors.primaryColor, width: 1.5),
// //             ),
// //             errorBorder: OutlineInputBorder(
// //               borderRadius: BorderRadius.circular(14),
// //               borderSide:
// //                   const BorderSide(color: AppColors.errorColor, width: 1),
// //             ),
// //             focusedErrorBorder: OutlineInputBorder(
// //               borderRadius: BorderRadius.circular(14),
// //               borderSide:
// //                   const BorderSide(color: AppColors.errorColor, width: 1.5),
// //             ),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }

// // // ═══════════════════════════════════════════════════════════════
// // //   Quick option tile widget
// // // ═══════════════════════════════════════════════════════════════
// // class _QuickOptionTile extends StatelessWidget {
// //   final IconData icon;
// //   final String label;
// //   final String sublabel;
// //   final Color color;
// //   final VoidCallback onTap;

// //   const _QuickOptionTile({
// //     required this.icon,
// //     required this.label,
// //     required this.sublabel,
// //     required this.color,
// //     required this.onTap,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return GestureDetector(
// //       onTap: onTap,
// //       child: Container(
// //         padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
// //         decoration: BoxDecoration(
// //           color: color.withOpacity(0.07),
// //           borderRadius: BorderRadius.circular(14),
// //           border: Border.all(color: color.withOpacity(0.25), width: 1),
// //         ),
// //         child: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             Container(
// //               padding: const EdgeInsets.all(10),
// //               decoration: BoxDecoration(
// //                 color: color.withOpacity(0.12),
// //                 borderRadius: BorderRadius.circular(10),
// //               ),
// //               child: Icon(icon, color: color, size: 22),
// //             ),
// //             const SizedBox(height: 8),
// //             Text(
// //               label,
// //               style: GoogleFonts.poppins(
// //                 fontSize: 13,
// //                 fontWeight: FontWeight.w600,
// //                 color: AppColors.textPrimaryColor,
// //               ),
// //               textAlign: TextAlign.center,
// //             ),
// //             const SizedBox(height: 2),
// //             Text(
// //               sublabel,
// //               style: GoogleFonts.poppins(
// //                 fontSize: 11,
// //                 color: AppColors.textSecondaryColor,
// //               ),
// //               textAlign: TextAlign.center,
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // // ═══════════════════════════════════════════════════════════════
// // //   In-App Map View Screen (read-only / view existing pin)
// // // ═══════════════════════════════════════════════════════════════
// // class _InAppMapViewScreen extends StatelessWidget {
// //   final LocationItem location;
// //   final LatLng? initial;

// //   const _InAppMapViewScreen({required this.location, this.initial});

// //   @override
// //   Widget build(BuildContext context) {
// //     // Import flutter_map
// //     // ignore: unused_import
// //     final center = initial ?? const LatLng(31.5204, 74.3587);
// //     final size = CustomSize();

// //     return Scaffold(
// //       body: Stack(
// //         children: [
// //           // Flutter Map
// //           _FlutterMapView(center: center, label: location.label),

// //           // Top overlay
// //           Positioned(
// //             top: 0,
// //             left: 0,
// //             right: 0,
// //             child: Container(
// //               decoration: BoxDecoration(
// //                 gradient: LinearGradient(
// //                   begin: Alignment.topCenter,
// //                   end: Alignment.bottomCenter,
// //                   colors: [
// //                     Colors.black.withOpacity(0.65),
// //                     Colors.transparent,
// //                   ],
// //                 ),
// //               ),
// //               child: SafeArea(
// //                 child: Padding(
// //                   padding: const EdgeInsets.symmetric(
// //                       horizontal: 16, vertical: 8),
// //                   child: Row(
// //                     children: [
// //                       GestureDetector(
// //                         onTap: () => Get.back(),
// //                         child: Container(
// //                           padding: const EdgeInsets.all(10),
// //                           decoration: BoxDecoration(
// //                             color: Colors.white.withOpacity(0.15),
// //                             borderRadius: BorderRadius.circular(12),
// //                           ),
// //                           child: const Icon(
// //                               Icons.arrow_back_ios_new_rounded,
// //                               color: Colors.white,
// //                               size: 18),
// //                         ),
// //                       ),
// //                       const SizedBox(width: 12),
// //                       Expanded(
// //                         child: Text(
// //                           location.label,
// //                           style: GoogleFonts.poppins(
// //                             color: Colors.white,
// //                             fontSize: size.customWidth(context) * 0.042,
// //                             fontWeight: FontWeight.w600,
// //                           ),
// //                           overflow: TextOverflow.ellipsis,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ),

// //           // Bottom panel
// //           Positioned(
// //             bottom: 0,
// //             left: 0,
// //             right: 0,
// //             child: Container(
// //               decoration: const BoxDecoration(
// //                 color: AppColors.whiteColor,
// //                 borderRadius:
// //                     BorderRadius.vertical(top: Radius.circular(24)),
// //               ),
// //               child: SafeArea(
// //                 top: false,
// //                 child: Padding(
// //                   padding: EdgeInsets.fromLTRB(
// //                     size.customWidth(context) * 0.05,
// //                     20,
// //                     size.customWidth(context) * 0.05,
// //                     size.customHeight(context) * 0.025,
// //                   ),
// //                   child: Column(
// //                     mainAxisSize: MainAxisSize.min,
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Center(
// //                         child: Container(
// //                           width: 40,
// //                           height: 4,
// //                           margin: const EdgeInsets.only(bottom: 16),
// //                           decoration: BoxDecoration(
// //                             color: Colors.grey.withOpacity(0.3),
// //                             borderRadius: BorderRadius.circular(2),
// //                           ),
// //                         ),
// //                       ),
// //                       Text(
// //                         location.label,
// //                         style: GoogleFonts.poppins(
// //                           fontSize: size.customWidth(context) * 0.046,
// //                           fontWeight: FontWeight.bold,
// //                           color: AppColors.textPrimaryColor,
// //                         ),
// //                       ),
// //                       const SizedBox(height: 6),
// //                       Row(
// //                         children: [
// //                           const Icon(Icons.location_on_outlined,
// //                               size: 15,
// //                               color: AppColors.textSecondaryColor),
// //                           const SizedBox(width: 4),
// //                           Expanded(
// //                             child: Text(
// //                               '${location.address}, ${location.city}',
// //                               style: GoogleFonts.poppins(
// //                                 fontSize: size.customWidth(context) * 0.035,
// //                                 color: AppColors.textSecondaryColor,
// //                               ),
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                       const SizedBox(height: 16),
// //                       SizedBox(
// //                         width: double.infinity,
// //                         child: ElevatedButton.icon(
// //                           onPressed: () async {
// //                             final uri = Uri.parse(location.mapsUrl);
// //                             if (await canLaunchUrl(uri)) {
// //                               await launchUrl(uri,
// //                                   mode: LaunchMode.externalApplication);
// //                             }
// //                           },
// //                           style: ElevatedButton.styleFrom(
// //                             backgroundColor: AppColors.primaryColor,
// //                             foregroundColor: Colors.white,
// //                             shape: RoundedRectangleBorder(
// //                                 borderRadius: BorderRadius.circular(14)),
// //                             padding: const EdgeInsets.symmetric(vertical: 14),
// //                             elevation: 2,
// //                           ),
// //                           icon: const Icon(Icons.open_in_new_rounded,
// //                               size: 18),
// //                           label: Text(
// //                             'Open in Google Maps',
// //                             style: GoogleFonts.poppins(
// //                                 fontWeight: FontWeight.w600, fontSize: 14),
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // // Separated to avoid import issues at file top level
// // class _FlutterMapView extends StatelessWidget {
// //   final LatLng center;
// //   final String label;

// //   const _FlutterMapView({required this.center, required this.label});

// //   @override
// //   Widget build(BuildContext context) {
// //     // Uses flutter_map package
// //     // ignore: unused_import
// //     return Builder(builder: (ctx) {
// //       try {
// //         return _buildMap();
// //       } catch (e) {
// //         return Container(
// //           color: AppColors.lightGreyColor,
// //           child: Center(
// //             child: Text(
// //               'Map unavailable\nPlease add flutter_map to pubspec.yaml',
// //               textAlign: TextAlign.center,
// //               style: GoogleFonts.poppins(color: AppColors.textSecondaryColor),
// //             ),
// //           ),
// //         );
// //       }
// //     });
// //   }

// //   Widget _buildMap() {
// //     // flutter_map imports are at the top of the file
// //     return FlutterMapViewWidget(center: center, label: label);
// //   }
// // }

// // lib/view/expert/location/expert_locations_screen.dart
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:speechspectrum/view/expert/location/flutter_map_view_widget.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/location_controller.dart';
// import 'package:speechspectrum/models/location_model.dart';
// import 'map_picker_screen.dart';
// import 'location_picker_screen.dart';

// class ExpertLocationsScreen extends StatefulWidget {
//   const ExpertLocationsScreen({super.key});

//   @override
//   State<ExpertLocationsScreen> createState() => _ExpertLocationsScreenState();
// }

// class _ExpertLocationsScreenState extends State<ExpertLocationsScreen> {
//   // FIX 1: Proper GetX usage — avoids "improper use of GetX" error
//   late final LocationController controller;

//   @override
//   void initState() {
//     super.initState();
//     controller = Get.isRegistered<LocationController>()
//         ? Get.find<LocationController>()
//         : Get.put(LocationController());
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       controller.fetchMyLocations();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();

//     return Scaffold(
//       backgroundColor: AppColors.lightGreyColor,
//       appBar: _buildAppBar(context, size),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return _buildLoader(context, size);
//         }
//         if (controller.myLocations.isEmpty) {
//           return _buildEmptyState(context, size);
//         }
//         return RefreshIndicator(
//           color: AppColors.primaryColor,
//           onRefresh: () => controller.fetchMyLocations(),
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
//               _buildHeaderBanner(context, size),
//               SizedBox(height: size.customHeight(context) * 0.025),
//               ...controller.myLocations
//                   .map((loc) => _buildLocationCard(context, size, loc))
//                   .toList(),
//             ],
//           ),
//         );
//       }),
//       floatingActionButton: _buildFAB(context, size),
//     );
//   }

//   PreferredSizeWidget _buildAppBar(BuildContext context, CustomSize size) {
//     return AppBar(
//       backgroundColor: AppColors.whiteColor,
//       elevation: 0,
//       surfaceTintColor: Colors.transparent,
//       leading: IconButton(
//         icon: const Icon(Icons.arrow_back_ios_new_rounded,
//             color: AppColors.textPrimaryColor, size: 20),
//         onPressed: () => Get.back(),
//       ),
//       title: Text(
//         'My Locations',
//         style: GoogleFonts.poppins(
//           color: AppColors.textPrimaryColor,
//           fontSize: 18,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//       actions: [
//         Obx(() => controller.isLoading.value
//             ? const Padding(
//                 padding: EdgeInsets.all(16),
//                 child: SizedBox(
//                   width: 20,
//                   height: 20,
//                   child: CircularProgressIndicator(
//                       color: AppColors.primaryColor, strokeWidth: 2),
//                 ),
//               )
//             : IconButton(
//                 icon: const Icon(Icons.refresh_rounded,
//                     color: AppColors.primaryColor),
//                 onPressed: () => controller.fetchMyLocations(),
//               )),
//         SizedBox(width: size.customWidth(context) * 0.01),
//       ],
//     );
//   }

//   Widget _buildHeaderBanner(BuildContext context, CustomSize size) {
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
//             color: AppColors.primaryColor.withOpacity(0.28),
//             blurRadius: 18,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(14),
//             ),
//             child: const Icon(Icons.location_on_rounded,
//                 color: Colors.white, size: 28),
//           ),
//           SizedBox(width: size.customWidth(context) * 0.04),
//           Expanded(
//             child: Obx(() => Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       '${controller.myLocations.length} Location${controller.myLocations.length != 1 ? 's' : ''} Added',
//                       style: GoogleFonts.poppins(
//                         color: Colors.white,
//                         fontSize: size.customWidth(context) * 0.044,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       'Tap + to add a new clinic or office',
//                       style: GoogleFonts.poppins(
//                         color: Colors.white.withOpacity(0.85),
//                         fontSize: size.customWidth(context) * 0.031,
//                       ),
//                     ),
//                   ],
//                 )),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildLocationCard(
//       BuildContext context, CustomSize size, LocationItem location) {
//     return Container(
//       margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.018),
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(22),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.06),
//             blurRadius: 16,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(size.customWidth(context) * 0.045),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   width: 54,
//                   height: 54,
//                   decoration: BoxDecoration(
//                     color: AppColors.primaryColor.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: const Icon(Icons.business_rounded,
//                       color: AppColors.primaryColor, size: 26),
//                 ),
//                 SizedBox(width: size.customWidth(context) * 0.035),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Text(
//                               location.label,
//                               style: GoogleFonts.poppins(
//                                 fontSize: size.customWidth(context) * 0.042,
//                                 fontWeight: FontWeight.w700,
//                                 color: AppColors.textPrimaryColor,
//                               ),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                           const SizedBox(width: 8),
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 10, vertical: 4),
//                             decoration: BoxDecoration(
//                               color: location.isActive
//                                   ? AppColors.successColor.withOpacity(0.1)
//                                   : AppColors.errorColor.withOpacity(0.1),
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             child: Text(
//                               location.isActive ? 'Active' : 'Inactive',
//                               style: GoogleFonts.poppins(
//                                 fontSize: size.customWidth(context) * 0.027,
//                                 fontWeight: FontWeight.w600,
//                                 color: location.isActive
//                                     ? AppColors.successColor
//                                     : AppColors.errorColor,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: size.customHeight(context) * 0.006),
//                       _infoRow(Icons.location_on_outlined, location.address, size, context),
//                       SizedBox(height: size.customHeight(context) * 0.004),
//                       _infoRow(Icons.location_city_outlined, location.city, size, context),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           Divider(height: 1, color: AppColors.greyColor.withOpacity(0.15)),

//           // FIX 2: Removed "In-App Map" button — now only 4 actions: View Map, Copy Link, Edit, Delete
//           Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: size.customWidth(context) * 0.02,
//               vertical: size.customHeight(context) * 0.006,
//             ),
//             child: Row(
//               children: [
//                 // FIX: "View Map" opens external maps (was duplicate with "In-App Map")
//                 _cardAction(
//                   icon: Icons.map_outlined,
//                   label: 'View Map',
//                   color: AppColors.accentColor,
//                   onTap: () => _openInExternalMaps(location.mapsUrl),
//                 ),
//                 _cardAction(
//                   icon: Icons.copy_outlined,
//                   label: 'Copy Link',
//                   color: AppColors.secondaryColor,
//                   onTap: () {
//                     Clipboard.setData(ClipboardData(text: location.mapsUrl));
//                     Get.snackbar(
//                       'Copied!',
//                       'Maps link copied to clipboard',
//                       snackPosition: SnackPosition.BOTTOM,
//                       backgroundColor: AppColors.textPrimaryColor,
//                       colorText: Colors.white,
//                       margin: const EdgeInsets.all(16),
//                       borderRadius: 12,
//                       duration: const Duration(seconds: 2),
//                     );
//                   },
//                 ),
//                 _cardAction(
//                   icon: Icons.edit_outlined,
//                   label: 'Edit',
//                   color: AppColors.warningColor,
//                   onTap: () => _openLocationSheet(context, size, existing: location),
//                 ),
//                 _cardAction(
//                   icon: Icons.delete_outline_rounded,
//                   label: 'Delete',
//                   color: AppColors.errorColor,
//                   onTap: () => _showDeleteConfirm(context, size, location),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _infoRow(
//       IconData icon, String text, CustomSize size, BuildContext context) {
//     return Row(
//       children: [
//         Icon(icon, size: 13, color: AppColors.textSecondaryColor),
//         const SizedBox(width: 4),
//         Expanded(
//           child: Text(
//             text,
//             style: GoogleFonts.poppins(
//               fontSize: size.customWidth(context) * 0.032,
//               color: AppColors.textSecondaryColor,
//             ),
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _cardAction({
//     required IconData icon,
//     required String label,
//     required Color color,
//     required VoidCallback onTap,
//   }) {
//     return Expanded(
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(10),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(icon, color: color, size: 19),
//               const SizedBox(height: 4),
//               Text(
//                 label,
//                 style: GoogleFonts.poppins(
//                   fontSize: 10,
//                   fontWeight: FontWeight.w500,
//                   color: color,
//                 ),
//                 textAlign: TextAlign.center,
//                 maxLines: 1,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildFAB(BuildContext context, CustomSize size) {
//     return FloatingActionButton.extended(
//       onPressed: () => _openLocationSheet(context, size),
//       backgroundColor: AppColors.primaryColor,
//       elevation: 4,
//       icon: const Icon(Icons.add_location_alt_rounded, color: Colors.white),
//       label: Text(
//         'Add Location',
//         style: GoogleFonts.poppins(
//           color: Colors.white,
//           fontWeight: FontWeight.w600,
//           fontSize: 14,
//         ),
//       ),
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
//           Text(
//             'Loading your locations...',
//             style: GoogleFonts.poppins(
//               color: AppColors.textSecondaryColor,
//               fontSize: size.customWidth(context) * 0.036,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildEmptyState(BuildContext context, CustomSize size) {
//     return Center(
//       child: Padding(
//         padding: EdgeInsets.all(size.customWidth(context) * 0.1),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: 130,
//               height: 130,
//               decoration: BoxDecoration(
//                 color: AppColors.primaryColor.withOpacity(0.08),
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(Icons.add_location_alt_outlined,
//                   size: 64, color: AppColors.primaryColor),
//             ),
//             SizedBox(height: size.customHeight(context) * 0.03),
//             Text(
//               'No Locations Yet',
//               style: GoogleFonts.poppins(
//                 fontSize: size.customWidth(context) * 0.052,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.textPrimaryColor,
//               ),
//             ),
//             SizedBox(height: size.customHeight(context) * 0.012),
//             Text(
//               'Add your clinic or office locations\nso patients can find you easily.',
//               textAlign: TextAlign.center,
//               style: GoogleFonts.poppins(
//                 fontSize: size.customWidth(context) * 0.035,
//                 color: AppColors.textSecondaryColor,
//                 height: 1.6,
//               ),
//             ),
//             SizedBox(height: size.customHeight(context) * 0.04),
//             ElevatedButton.icon(
//               onPressed: () => _openLocationSheet(context, size),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.primaryColor,
//                 foregroundColor: Colors.white,
//                 padding: EdgeInsets.symmetric(
//                   horizontal: size.customWidth(context) * 0.08,
//                   vertical: size.customHeight(context) * 0.018,
//                 ),
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(14)),
//                 elevation: 2,
//               ),
//               icon: const Icon(Icons.add_location_alt_rounded),
//               label: Text(
//                 'Add First Location',
//                 style: GoogleFonts.poppins(
//                     fontWeight: FontWeight.w600, fontSize: 15),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _openLocationSheet(BuildContext context, CustomSize size,
//       {LocationItem? existing}) {
//     if (existing != null) {
//       controller.populateForm(existing);
//     } else {
//       controller.clearForm();
//     }
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       enableDrag: true,
//       builder: (ctx) => ConstrainedBox(
//         constraints: BoxConstraints(
//           maxHeight: MediaQuery.of(context).size.height * 0.92,
//         ),
//         child: _LocationFormSheet(
//           controller: controller,
//           size: size,
//           isEditing: existing != null,
//           existingLocation: existing,
//         ),
//       ),
//     );
//   }

//   Future<void> _openInExternalMaps(String url) async {
//     try {
//       final uri = Uri.parse(url);
//       if (await canLaunchUrl(uri)) {
//         await launchUrl(uri, mode: LaunchMode.externalApplication);
//       } else {
//         _urlError();
//       }
//     } catch (_) {
//       _urlError();
//     }
//   }

//   void _urlError() => Get.snackbar('Error', 'Could not open map',
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: AppColors.errorColor,
//       colorText: Colors.white,
//       margin: const EdgeInsets.all(16),
//       borderRadius: 12);

//   void _showDeleteConfirm(
//       BuildContext context, CustomSize size, LocationItem location) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (ctx) => _DeleteConfirmDialog(
//         location: location,
//         controller: controller,
//       ),
//     );
//   }
// }

// // ── Stateful delete dialog — no Obx needed ──────────────────────
// class _DeleteConfirmDialog extends StatefulWidget {
//   final LocationItem location;
//   final LocationController controller;

//   const _DeleteConfirmDialog({
//     required this.location,
//     required this.controller,
//   });

//   @override
//   State<_DeleteConfirmDialog> createState() => _DeleteConfirmDialogState();
// }

// class _DeleteConfirmDialogState extends State<_DeleteConfirmDialog> {
//   bool _deleting = false;

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
//       contentPadding: const EdgeInsets.all(24),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: AppColors.errorColor.withOpacity(0.1),
//               shape: BoxShape.circle,
//             ),
//             child: const Icon(Icons.delete_forever_rounded,
//                 color: AppColors.errorColor, size: 38),
//           ),
//           const SizedBox(height: 16),
//           Text(
//             'Delete Location?',
//             style: GoogleFonts.poppins(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: AppColors.textPrimaryColor,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             '"${widget.location.label}" will be permanently removed.',
//             textAlign: TextAlign.center,
//             style: GoogleFonts.poppins(
//               fontSize: 14,
//               color: AppColors.textSecondaryColor,
//               height: 1.5,
//             ),
//           ),
//           const SizedBox(height: 24),
//           Row(
//             children: [
//               Expanded(
//                 child: OutlinedButton(
//                   onPressed: _deleting ? null : () => Navigator.pop(context),
//                   style: OutlinedButton.styleFrom(
//                     foregroundColor: AppColors.textSecondaryColor,
//                     side: BorderSide(
//                         color: AppColors.greyColor.withOpacity(0.4)),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12)),
//                     padding: const EdgeInsets.symmetric(vertical: 13),
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
//                               .deleteLocation(widget.location.locationId);
//                           if (mounted) setState(() => _deleting = false);
//                           if (ok && context.mounted) Navigator.pop(context);
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
//                   child: _deleting
//                       ? const SizedBox(
//                           width: 18,
//                           height: 18,
//                           child: CircularProgressIndicator(
//                               color: Colors.white, strokeWidth: 2))
//                       : Text('Delete',
//                           style: GoogleFonts.poppins(
//                               fontWeight: FontWeight.w600, fontSize: 14)),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }  // ← closes _DeleteConfirmDialogState

// // ═══════════════════════════════════════════════════════════════
// //   Location Form Bottom Sheet
// // ═══════════════════════════════════════════════════════════════
// class _LocationFormSheet extends StatefulWidget {
//   final LocationController controller;
//   final CustomSize size;
//   final bool isEditing;
//   final LocationItem? existingLocation;

//   const _LocationFormSheet({
//     required this.controller,
//     required this.size,
//     required this.isEditing,
//     this.existingLocation,
//   });

//   @override
//   State<_LocationFormSheet> createState() => _LocationFormSheetState();
// }

// class _LocationFormSheetState extends State<_LocationFormSheet> {
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
//       // FIX 3: viewInsets padding prevents overflow when keyboard opens
//       padding: EdgeInsets.only(
//           bottom: MediaQuery.of(context).viewInsets.bottom),
//       child: SingleChildScrollView(
//         // FIX 3: shrinkWrap content — no unbounded height
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
//                     color: AppColors.greyColor.withOpacity(0.3),
//                     borderRadius: BorderRadius.circular(2),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // Title row
//               Row(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: AppColors.primaryColor.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Icon(
//                       widget.isEditing
//                           ? Icons.edit_location_alt_rounded
//                           : Icons.add_location_alt_rounded,
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
//                           widget.isEditing ? 'Edit Location' : 'Add New Location',
//                           style: GoogleFonts.poppins(
//                             fontSize: size.customWidth(context) * 0.046,
//                             fontWeight: FontWeight.bold,
//                             color: AppColors.textPrimaryColor,
//                           ),
//                         ),
//                         Text(
//                           widget.isEditing
//                               ? 'Update location details'
//                               : 'Choose existing or fill manually',
//                           style: GoogleFonts.poppins(
//                             fontSize: size.customWidth(context) * 0.031,
//                             color: AppColors.textSecondaryColor,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),

//               // ── Option tiles (only on CREATE) ─────────────────
//               if (!widget.isEditing) ...[
//                 SizedBox(height: size.customHeight(context) * 0.025),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: _QuickOptionTile(
//                         icon: Icons.list_alt_rounded,
//                         label: 'Select existing',
//                         sublabel: 'From saved locations',
//                         color: AppColors.primaryColor,
//                         onTap: () async {
//                           // Use Navigator.push to avoid GetX context issue in bottom sheet
//                           final result = await Navigator.of(context).push<LocationItem>(
//                             MaterialPageRoute(
//                               builder: (_) => const LocationPickerScreen(),
//                             ),
//                           );
//                           if (result != null && mounted) {
//                             widget.controller.populateFromExisting(result);
//                             setState(() {});
//                           }
//                         },
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: _QuickOptionTile(
//                         icon: Icons.map_rounded,
//                         label: 'Pick on map',
//                         sublabel: 'Tap to choose',
//                         color: AppColors.accentColor,
//                         onTap: () async {
//                           final result = await Navigator.of(context).push<MapPickResult>(
//                             MaterialPageRoute(
//                               builder: (_) => const MapPickerScreen(),
//                             ),
//                           );
//                           if (result != null && mounted) {
//                             widget.controller.populateFromMapPick(
//                               address: result.address,
//                               city: result.city,
//                               mapsUrl: result.mapsUrl,
//                             );
//                             setState(() {});
//                           }
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: size.customHeight(context) * 0.025),
//                 Row(
//                   children: [
//                     Expanded(child: Divider(color: AppColors.greyColor.withOpacity(0.25))),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 12),
//                       child: Text(
//                         'or fill manually',
//                         style: GoogleFonts.poppins(
//                           fontSize: size.customWidth(context) * 0.03,
//                           color: AppColors.textSecondaryColor,
//                         ),
//                       ),
//                     ),
//                     Expanded(child: Divider(color: AppColors.greyColor.withOpacity(0.25))),
//                   ],
//                 ),
//               ],

//               SizedBox(height: size.customHeight(context) * 0.022),

//               _field(
//                 ctx: context,
//                 ctrl: widget.controller.labelController,
//                 label: 'Location Label',
//                 hint: 'e.g. Main Clinic, Downtown Office',
//                 icon: Icons.label_outline_rounded,
//                 size: size,
//                 validator: (v) =>
//                     v == null || v.trim().isEmpty ? 'Label is required' : null,
//               ),
//               SizedBox(height: size.customHeight(context) * 0.018),

//               _field(
//                 ctx: context,
//                 ctrl: widget.controller.addressController,
//                 label: 'Street Address',
//                 hint: 'e.g. 123 DHA Phase 6',
//                 icon: Icons.home_outlined,
//                 size: size,
//                 validator: (v) =>
//                     v == null || v.trim().isEmpty ? 'Address is required' : null,
//               ),
//               SizedBox(height: size.customHeight(context) * 0.018),

//               _field(
//                 ctx: context,
//                 ctrl: widget.controller.cityController,
//                 label: 'City',
//                 hint: 'e.g. Lahore, Karachi, Islamabad',
//                 icon: Icons.location_city_outlined,
//                 size: size,
//                 validator: (v) =>
//                     v == null || v.trim().isEmpty ? 'City is required' : null,
//               ),
//               SizedBox(height: size.customHeight(context) * 0.018),

//               // FIX 5: Maps URL — removed auto-generate button, updated hint text
//               _buildMapsUrlField(context, size),

//               SizedBox(height: size.customHeight(context) * 0.03),

//               // Edit: pick on map button
//               if (widget.isEditing) ...[
//                 OutlinedButton.icon(
//                   onPressed: () async {
//                     LatLng? initial;
//                     try {
//                       final uri = Uri.parse(
//                           widget.controller.mapsUrlController.text.trim());
//                       final q = uri.queryParameters['q'] ?? '';
//                       final parts = q.split(',');
//                       if (parts.length == 2) {
//                         final lat = double.tryParse(parts[0]);
//                         final lng = double.tryParse(parts[1]);
//                         if (lat != null && lng != null) {
//                           initial = LatLng(lat, lng);
//                         }
//                       }
//                     } catch (_) {}
//                     final result = await Navigator.of(context).push<MapPickResult>(
//                       MaterialPageRoute(
//                         builder: (_) => MapPickerScreen(initialPosition: initial),
//                       ),
//                     );
//                     if (result != null && mounted) {
//                       widget.controller.populateFromMapPick(
//                         address: result.address,
//                         city: result.city,
//                         mapsUrl: result.mapsUrl,
//                       );
//                       setState(() {});
//                     }
//                   },
//                   style: OutlinedButton.styleFrom(
//                     foregroundColor: AppColors.primaryColor,
//                     side: BorderSide(color: AppColors.primaryColor.withOpacity(0.5)),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
//                     padding: EdgeInsets.symmetric(vertical: size.customHeight(context) * 0.016),
//                     minimumSize: const Size(double.infinity, 0),
//                   ),
//                   icon: const Icon(Icons.map_rounded, size: 18),
//                   label: Text('Pick new location on map',
//                       style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14)),
//                 ),
//                 SizedBox(height: size.customHeight(context) * 0.018),
//               ],

//               // Submit button
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: _saving
//                       ? null
//                       : () async {
//                           if (!_formKey.currentState!.validate()) return;
//                           setState(() => _saving = true);
//                           bool ok;
//                           if (widget.isEditing) {
//                             ok = await widget.controller.updateLocation(
//                                 widget.existingLocation!.locationId);
//                           } else {
//                             ok = await widget.controller.createLocation();
//                           }
//                           if (mounted) setState(() => _saving = false);
//                           if (ok && context.mounted) Navigator.pop(context);
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
//                           widget.isEditing ? 'Update Location' : 'Save Location',
//                           style: GoogleFonts.poppins(
//                             fontWeight: FontWeight.w600,
//                             fontSize: size.customWidth(context) * 0.042,
//                           ),
//                         ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // FIX 5: Removed auto-generate button row, updated hint to "Selected from map or paste manually"
//   Widget _buildMapsUrlField(BuildContext context, CustomSize size) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Google Maps URL',
//           style: GoogleFonts.poppins(
//             fontSize: size.customWidth(context) * 0.036,
//             fontWeight: FontWeight.w600,
//             color: AppColors.textPrimaryColor,
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           controller: widget.controller.mapsUrlController,
//           style: GoogleFonts.poppins(
//             fontSize: size.customWidth(context) * 0.033,
//             color: AppColors.textPrimaryColor,
//           ),
//           decoration: InputDecoration(
//             // FIX 5: Updated hint text as requested
//             hintText: 'Selected from map or paste manually',
//             hintStyle: GoogleFonts.poppins(
//               fontSize: size.customWidth(context) * 0.031,
//               color: AppColors.textSecondaryColor.withOpacity(0.7),
//             ),
//             prefixIcon: const Icon(Icons.map_outlined, color: AppColors.accentColor, size: 22),
//             suffixIcon: IconButton(
//               icon: const Icon(Icons.open_in_new_rounded,
//                   color: AppColors.accentColor, size: 18),
//               tooltip: 'Preview in Maps',
//               onPressed: () async {
//                 final url = widget.controller.mapsUrlController.text.trim();
//                 if (url.isEmpty) return;
//                 final uri = Uri.tryParse(url);
//                 if (uri != null && await canLaunchUrl(uri)) {
//                   await launchUrl(uri, mode: LaunchMode.externalApplication);
//                 }
//               },
//             ),
//             filled: true,
//             fillColor: AppColors.lightGreyColor,
//             contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//             border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
//             enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(14),
//                 borderSide: BorderSide(color: AppColors.greyColor.withOpacity(0.2), width: 1)),
//             focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(14),
//                 borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.5)),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _field({
//     required BuildContext ctx,
//     required TextEditingController ctrl,
//     required String label,
//     required String hint,
//     required IconData icon,
//     required CustomSize size,
//     String? Function(String?)? validator,
//     void Function(String)? onChanged,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label,
//             style: GoogleFonts.poppins(
//                 fontSize: size.customWidth(ctx) * 0.036,
//                 fontWeight: FontWeight.w600,
//                 color: AppColors.textPrimaryColor)),
//         const SizedBox(height: 8),
//         TextFormField(
//           controller: ctrl,
//           validator: validator,
//           onChanged: onChanged,
//           style: GoogleFonts.poppins(
//               fontSize: size.customWidth(ctx) * 0.038, color: AppColors.textPrimaryColor),
//           decoration: InputDecoration(
//             hintText: hint,
//             hintStyle: GoogleFonts.poppins(
//                 fontSize: size.customWidth(ctx) * 0.035,
//                 color: AppColors.textSecondaryColor.withOpacity(0.7)),
//             prefixIcon: Icon(icon, color: AppColors.primaryColor, size: 22),
//             filled: true,
//             fillColor: AppColors.lightGreyColor,
//             contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//             border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
//             enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(14),
//                 borderSide: BorderSide(color: AppColors.greyColor.withOpacity(0.2), width: 1)),
//             focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(14),
//                 borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.5)),
//             errorBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(14),
//                 borderSide: const BorderSide(color: AppColors.errorColor, width: 1)),
//             focusedErrorBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(14),
//                 borderSide: const BorderSide(color: AppColors.errorColor, width: 1.5)),
//           ),
//         ),
//       ],
//     );
//   }
// }

// // ═══════════════════════════════════════════════════════════════
// //   Quick option tile widget — unchanged from original
// // ═══════════════════════════════════════════════════════════════
// class _QuickOptionTile extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final String sublabel;
//   final Color color;
//   final VoidCallback onTap;

//   const _QuickOptionTile({
//     required this.icon,
//     required this.label,
//     required this.sublabel,
//     required this.color,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
//         decoration: BoxDecoration(
//           color: color.withOpacity(0.07),
//           borderRadius: BorderRadius.circular(14),
//           border: Border.all(color: color.withOpacity(0.25), width: 1),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                   color: color.withOpacity(0.12),
//                   borderRadius: BorderRadius.circular(10)),
//               child: Icon(icon, color: color, size: 22),
//             ),
//             const SizedBox(height: 8),
//             Text(label,
//                 style: GoogleFonts.poppins(
//                     fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimaryColor),
//                 textAlign: TextAlign.center),
//             const SizedBox(height: 2),
//             Text(sublabel,
//                 style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textSecondaryColor),
//                 textAlign: TextAlign.center),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ═══════════════════════════════════════════════════════════════
// //   In-App Map View Screen — unchanged from original
// // ═══════════════════════════════════════════════════════════════
// class _InAppMapViewScreen extends StatelessWidget {
//   final LocationItem location;
//   final LatLng? initial;

//   const _InAppMapViewScreen({required this.location, this.initial});

//   @override
//   Widget build(BuildContext context) {
//     final center = initial ?? const LatLng(31.5204, 74.3587);
//     final size = CustomSize();

//     return Scaffold(
//       body: Stack(
//         children: [
//           FlutterMapViewWidget(center: center, label: location.label),

//           Positioned(
//             top: 0, left: 0, right: 0,
//             child: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [Colors.black.withOpacity(0.65), Colors.transparent],
//                 ),
//               ),
//               child: SafeArea(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   child: Row(
//                     children: [
//                       GestureDetector(
//                         onTap: () => Get.back(),
//                         child: Container(
//                           padding: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                               color: Colors.white.withOpacity(0.15),
//                               borderRadius: BorderRadius.circular(12)),
//                           child: const Icon(Icons.arrow_back_ios_new_rounded,
//                               color: Colors.white, size: 18),
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: Text(location.label,
//                             style: GoogleFonts.poppins(
//                                 color: Colors.white,
//                                 fontSize: size.customWidth(context) * 0.042,
//                                 fontWeight: FontWeight.w600),
//                             overflow: TextOverflow.ellipsis),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           Positioned(
//             bottom: 0, left: 0, right: 0,
//             child: Container(
//               decoration: const BoxDecoration(
//                   color: AppColors.whiteColor,
//                   borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
//               child: SafeArea(
//                 top: false,
//                 child: Padding(
//                   padding: EdgeInsets.fromLTRB(
//                       size.customWidth(context) * 0.05, 20,
//                       size.customWidth(context) * 0.05,
//                       size.customHeight(context) * 0.025),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Center(
//                         child: Container(
//                           width: 40, height: 4,
//                           margin: const EdgeInsets.only(bottom: 16),
//                           decoration: BoxDecoration(
//                               color: Colors.grey.withOpacity(0.3),
//                               borderRadius: BorderRadius.circular(2)),
//                         ),
//                       ),
//                       Text(location.label,
//                           style: GoogleFonts.poppins(
//                               fontSize: size.customWidth(context) * 0.046,
//                               fontWeight: FontWeight.bold,
//                               color: AppColors.textPrimaryColor)),
//                       const SizedBox(height: 6),
//                       Row(children: [
//                         const Icon(Icons.location_on_outlined, size: 15, color: AppColors.textSecondaryColor),
//                         const SizedBox(width: 4),
//                         Expanded(
//                           child: Text('${location.address}, ${location.city}',
//                               style: GoogleFonts.poppins(
//                                   fontSize: size.customWidth(context) * 0.035,
//                                   color: AppColors.textSecondaryColor)),
//                         ),
//                       ]),
//                       const SizedBox(height: 16),
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton.icon(
//                           onPressed: () async {
//                             final uri = Uri.parse(location.mapsUrl);
//                             if (await canLaunchUrl(uri)) {
//                               await launchUrl(uri, mode: LaunchMode.externalApplication);
//                             }
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: AppColors.primaryColor,
//                             foregroundColor: Colors.white,
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
//                             padding: const EdgeInsets.symmetric(vertical: 14),
//                             elevation: 2,
//                           ),
//                           icon: const Icon(Icons.open_in_new_rounded, size: 18),
//                           label: Text('Open in Google Maps',
//                               style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14)),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// lib/view/expert/location/expert_locations_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:speechspectrum/view/expert/location/flutter_map_view_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import 'package:speechspectrum/controllers/location_controller.dart';
import 'package:speechspectrum/models/location_model.dart';
import 'map_picker_screen.dart';
import 'location_picker_screen.dart';

class ExpertLocationsScreen extends StatefulWidget {
  const ExpertLocationsScreen({super.key});

  @override
  State<ExpertLocationsScreen> createState() => _ExpertLocationsScreenState();
}

class _ExpertLocationsScreenState extends State<ExpertLocationsScreen> {
  // FIX 1: Proper GetX usage — avoids "improper use of GetX" error
  late final LocationController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered<LocationController>()
        ? Get.find<LocationController>()
        : Get.put(LocationController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchMyLocations();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();

    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      appBar: _buildAppBar(context, size),
      body: Obx(() {
        if (controller.isLoading.value) {
          return _buildLoader(context, size);
        }
        if (controller.myLocations.isEmpty) {
          return _buildEmptyState(context, size);
        }
        return RefreshIndicator(
          color: AppColors.primaryColor,
          onRefresh: () => controller.fetchMyLocations(),
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
              _buildHeaderBanner(context, size),
              SizedBox(height: size.customHeight(context) * 0.025),
              ...controller.myLocations
                  .map((loc) => _buildLocationCard(context, size, loc))
                  .toList(),
            ],
          ),
        );
      }),
      floatingActionButton: _buildFAB(context, size),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, CustomSize size) {
    return AppBar(
      backgroundColor: AppColors.whiteColor,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded,
            color: AppColors.textPrimaryColor, size: 20),
        onPressed: () => Get.back(),
      ),
      title: Text(
        'My Locations',
        style: GoogleFonts.poppins(
          color: AppColors.textPrimaryColor,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        Obx(() => controller.isLoading.value
            ? const Padding(
                padding: EdgeInsets.all(16),
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
                onPressed: () => controller.fetchMyLocations(),
              )),
        SizedBox(width: size.customWidth(context) * 0.01),
      ],
    );
  }

  Widget _buildHeaderBanner(BuildContext context, CustomSize size) {
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
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.location_on_rounded,
                color: Colors.white, size: 28),
          ),
          SizedBox(width: size.customWidth(context) * 0.04),
          Expanded(
            child: Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${controller.myLocations.length} Location${controller.myLocations.length != 1 ? 's' : ''} Added',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: size.customWidth(context) * 0.044,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Tap + to add a new clinic or office',
                      style: GoogleFonts.poppins(
                        color: Colors.white.withOpacity(0.85),
                        fontSize: size.customWidth(context) * 0.031,
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationCard(
      BuildContext context, CustomSize size, LocationItem location) {
    return Container(
      margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.018),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(size.customWidth(context) * 0.045),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(Icons.business_rounded,
                      color: AppColors.primaryColor, size: 26),
                ),
                SizedBox(width: size.customWidth(context) * 0.035),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              location.label,
                              style: GoogleFonts.poppins(
                                fontSize: size.customWidth(context) * 0.042,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimaryColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: location.isActive
                                  ? AppColors.successColor.withOpacity(0.1)
                                  : AppColors.errorColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              location.isActive ? 'Active' : 'Inactive',
                              style: GoogleFonts.poppins(
                                fontSize: size.customWidth(context) * 0.027,
                                fontWeight: FontWeight.w600,
                                color: location.isActive
                                    ? AppColors.successColor
                                    : AppColors.errorColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.customHeight(context) * 0.006),
                      _infoRow(Icons.location_on_outlined, location.address, size, context),
                      SizedBox(height: size.customHeight(context) * 0.004),
                      _infoRow(Icons.location_city_outlined, location.city, size, context),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Divider(height: 1, color: AppColors.greyColor.withOpacity(0.15)),

          // FIX 2: Removed "In-App Map" button — now only 4 actions: View Map, Copy Link, Edit, Delete
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.customWidth(context) * 0.02,
              vertical: size.customHeight(context) * 0.006,
            ),
            child: Row(
              children: [
                _cardAction(
                  icon: Icons.map_outlined,
                  label: 'View Map',
                  color: AppColors.accentColor,
                  onTap: () => _openInAppMap(location),
                ),
                _cardAction(
                  icon: Icons.copy_outlined,
                  label: 'Copy Link',
                  color: AppColors.secondaryColor,
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: location.mapsUrl));
                    Get.snackbar(
                      'Copied!',
                      'Maps link copied to clipboard',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: AppColors.textPrimaryColor,
                      colorText: Colors.white,
                      margin: const EdgeInsets.all(16),
                      borderRadius: 12,
                      duration: const Duration(seconds: 2),
                    );
                  },
                ),
                _cardAction(
                  icon: Icons.edit_outlined,
                  label: 'Edit',
                  color: AppColors.warningColor,
                  onTap: () => _openLocationSheet(context, size, existing: location),
                ),
                _cardAction(
                  icon: Icons.delete_outline_rounded,
                  label: 'Delete',
                  color: AppColors.errorColor,
                  onTap: () => _showDeleteConfirm(context, size, location),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(
      IconData icon, String text, CustomSize size, BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 13, color: AppColors.textSecondaryColor),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: size.customWidth(context) * 0.032,
              color: AppColors.textSecondaryColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _cardAction({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 19),
              const SizedBox(height: 4),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: color,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFAB(BuildContext context, CustomSize size) {
    return FloatingActionButton.extended(
      onPressed: () => _openLocationSheet(context, size),
      backgroundColor: AppColors.primaryColor,
      elevation: 4,
      icon: const Icon(Icons.add_location_alt_rounded, color: Colors.white),
      label: Text(
        'Add Location',
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
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
          Text(
            'Loading your locations...',
            style: GoogleFonts.poppins(
              color: AppColors.textSecondaryColor,
              fontSize: size.customWidth(context) * 0.036,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, CustomSize size) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(size.customWidth(context) * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add_location_alt_outlined,
                  size: 64, color: AppColors.primaryColor),
            ),
            SizedBox(height: size.customHeight(context) * 0.03),
            Text(
              'No Locations Yet',
              style: GoogleFonts.poppins(
                fontSize: size.customWidth(context) * 0.052,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimaryColor,
              ),
            ),
            SizedBox(height: size.customHeight(context) * 0.012),
            Text(
              'Add your clinic or office locations\nso patients can find you easily.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: size.customWidth(context) * 0.035,
                color: AppColors.textSecondaryColor,
                height: 1.6,
              ),
            ),
            SizedBox(height: size.customHeight(context) * 0.04),
            ElevatedButton.icon(
              onPressed: () => _openLocationSheet(context, size),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: size.customWidth(context) * 0.08,
                  vertical: size.customHeight(context) * 0.018,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                elevation: 2,
              ),
              icon: const Icon(Icons.add_location_alt_rounded),
              label: Text(
                'Add First Location',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openLocationSheet(BuildContext context, CustomSize size,
      {LocationItem? existing}) {
    if (existing != null) {
      controller.populateForm(existing);
    } else {
      controller.clearForm();
    }
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: true,
      builder: (ctx) => ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.92,
        ),
        child: _LocationFormSheet(
          controller: controller,
          size: size,
          isEditing: existing != null,
          existingLocation: existing,
        ),
      ),
    );
  }

  void _openInAppMap(LocationItem location) {
    LatLng? initial;
    try {
      final uri = Uri.parse(location.mapsUrl);
      final q = uri.queryParameters['q'] ?? '';
      final parts = q.split(',');
      if (parts.length == 2) {
        final lat = double.tryParse(parts[0].trim());
        final lng = double.tryParse(parts[1].trim());
        if (lat != null && lng != null) {
          initial = LatLng(lat, lng);
        }
      }
    } catch (_) {}
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => InAppMapViewScreen(
          location: location,
          initial: initial,
        ),
      ),
    );
  }

  Future<void> _openInExternalMaps(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        _urlError();
      }
    } catch (_) {
      _urlError();
    }
  }

  void _urlError() => Get.snackbar('Error', 'Could not open map',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.errorColor,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12);

  void _showDeleteConfirm(
      BuildContext context, CustomSize size, LocationItem location) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => _DeleteConfirmDialog(
        location: location,
        controller: controller,
      ),
    );
  }
}

// ── Stateful delete dialog — no Obx needed ──────────────────────
class _DeleteConfirmDialog extends StatefulWidget {
  final LocationItem location;
  final LocationController controller;

  const _DeleteConfirmDialog({
    required this.location,
    required this.controller,
  });

  @override
  State<_DeleteConfirmDialog> createState() => _DeleteConfirmDialogState();
}

class _DeleteConfirmDialogState extends State<_DeleteConfirmDialog> {
  bool _deleting = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      contentPadding: const EdgeInsets.all(24),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.errorColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.delete_forever_rounded,
                color: AppColors.errorColor, size: 38),
          ),
          const SizedBox(height: 16),
          Text(
            'Delete Location?',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '"${widget.location.label}" will be permanently removed.',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: AppColors.textSecondaryColor,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _deleting ? null : () => Navigator.pop(context),
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
                              .deleteLocation(widget.location.locationId);
                          if (mounted) setState(() => _deleting = false);
                          if (ok && context.mounted) Navigator.pop(context);
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
                  child: _deleting
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2))
                      : Text('Delete',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600, fontSize: 14)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}  // ← closes _DeleteConfirmDialogState

// ═══════════════════════════════════════════════════════════════
//   Location Form Bottom Sheet
// ═══════════════════════════════════════════════════════════════
class _LocationFormSheet extends StatefulWidget {
  final LocationController controller;
  final CustomSize size;
  final bool isEditing;
  final LocationItem? existingLocation;

  const _LocationFormSheet({
    required this.controller,
    required this.size,
    required this.isEditing,
    this.existingLocation,
  });

  @override
  State<_LocationFormSheet> createState() => _LocationFormSheetState();
}

class _LocationFormSheetState extends State<_LocationFormSheet> {
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
      // FIX 3: viewInsets padding prevents overflow when keyboard opens
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        // FIX 3: shrinkWrap content — no unbounded height
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
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Title row
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      widget.isEditing
                          ? Icons.edit_location_alt_rounded
                          : Icons.add_location_alt_rounded,
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
                          widget.isEditing ? 'Edit Location' : 'Add New Location',
                          style: GoogleFonts.poppins(
                            fontSize: size.customWidth(context) * 0.046,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimaryColor,
                          ),
                        ),
                        Text(
                          widget.isEditing
                              ? 'Update location details'
                              : 'Choose existing or fill manually',
                          style: GoogleFonts.poppins(
                            fontSize: size.customWidth(context) * 0.031,
                            color: AppColors.textSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // ── Option tiles (only on CREATE) ─────────────────
              if (!widget.isEditing) ...[
                SizedBox(height: size.customHeight(context) * 0.025),
                Row(
                  children: [
                    Expanded(
                      child: _QuickOptionTile(
                        icon: Icons.list_alt_rounded,
                        label: 'Select existing',
                        sublabel: 'From saved locations',
                        color: AppColors.primaryColor,
                        onTap: () async {
                          // Use Navigator.push to avoid GetX context issue in bottom sheet
                          final result = await Navigator.of(context).push<LocationItem>(
                            MaterialPageRoute(
                              builder: (_) => const LocationPickerScreen(),
                            ),
                          );
                          if (result != null && mounted) {
                            widget.controller.populateFromExisting(result);
                            setState(() {});
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _QuickOptionTile(
                        icon: Icons.map_rounded,
                        label: 'Pick on map',
                        sublabel: 'Tap to choose',
                        color: AppColors.accentColor,
                        onTap: () async {
                          final result = await Navigator.of(context).push<MapPickResult>(
                            MaterialPageRoute(
                              builder: (_) => const MapPickerScreen(),
                            ),
                          );
                          if (result != null && mounted) {
                            widget.controller.populateFromMapPick(
                              address: result.address,
                              city: result.city,
                              mapsUrl: result.mapsUrl,
                            );
                            setState(() {});
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.customHeight(context) * 0.025),
                Row(
                  children: [
                    Expanded(child: Divider(color: AppColors.greyColor.withOpacity(0.25))),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'or fill manually',
                        style: GoogleFonts.poppins(
                          fontSize: size.customWidth(context) * 0.03,
                          color: AppColors.textSecondaryColor,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: AppColors.greyColor.withOpacity(0.25))),
                  ],
                ),
              ],

              SizedBox(height: size.customHeight(context) * 0.022),

              _field(
                ctx: context,
                ctrl: widget.controller.labelController,
                label: 'Location Label',
                hint: 'e.g. Main Clinic, Downtown Office',
                icon: Icons.label_outline_rounded,
                size: size,
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Label is required' : null,
              ),
              SizedBox(height: size.customHeight(context) * 0.018),

              _field(
                ctx: context,
                ctrl: widget.controller.addressController,
                label: 'Street Address',
                hint: 'e.g. 123 DHA Phase 6',
                icon: Icons.home_outlined,
                size: size,
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Address is required' : null,
              ),
              SizedBox(height: size.customHeight(context) * 0.018),

              _field(
                ctx: context,
                ctrl: widget.controller.cityController,
                label: 'City',
                hint: 'e.g. Lahore, Karachi, Islamabad',
                icon: Icons.location_city_outlined,
                size: size,
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'City is required' : null,
              ),
              SizedBox(height: size.customHeight(context) * 0.018),

              // FIX 5: Maps URL — removed auto-generate button, updated hint text
              _buildMapsUrlField(context, size),

              SizedBox(height: size.customHeight(context) * 0.03),

              // Edit: pick on map button
              if (widget.isEditing) ...[
                OutlinedButton.icon(
                  onPressed: () async {
                    LatLng? initial;
                    try {
                      final uri = Uri.parse(
                          widget.controller.mapsUrlController.text.trim());
                      final q = uri.queryParameters['q'] ?? '';
                      final parts = q.split(',');
                      if (parts.length == 2) {
                        final lat = double.tryParse(parts[0]);
                        final lng = double.tryParse(parts[1]);
                        if (lat != null && lng != null) {
                          initial = LatLng(lat, lng);
                        }
                      }
                    } catch (_) {}
                    final result = await Navigator.of(context).push<MapPickResult>(
                      MaterialPageRoute(
                        builder: (_) => MapPickerScreen(initialPosition: initial),
                      ),
                    );
                    if (result != null && mounted) {
                      widget.controller.populateFromMapPick(
                        address: result.address,
                        city: result.city,
                        mapsUrl: result.mapsUrl,
                      );
                      setState(() {});
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primaryColor,
                    side: BorderSide(color: AppColors.primaryColor.withOpacity(0.5)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    padding: EdgeInsets.symmetric(vertical: size.customHeight(context) * 0.016),
                    minimumSize: const Size(double.infinity, 0),
                  ),
                  icon: const Icon(Icons.map_rounded, size: 18),
                  label: Text('Pick new location on map',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14)),
                ),
                SizedBox(height: size.customHeight(context) * 0.018),
              ],

              // Submit button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saving
                      ? null
                      : () async {
                          if (!_formKey.currentState!.validate()) return;
                          setState(() => _saving = true);
                          bool ok;
                          if (widget.isEditing) {
                            ok = await widget.controller.updateLocation(
                                widget.existingLocation!.locationId);
                          } else {
                            ok = await widget.controller.createLocation();
                          }
                          if (mounted) setState(() => _saving = false);
                          if (ok && context.mounted) Navigator.pop(context);
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
                          widget.isEditing ? 'Update Location' : 'Save Location',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: size.customWidth(context) * 0.042,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // FIX 5: Removed auto-generate button row, updated hint to "Selected from map or paste manually"
  Widget _buildMapsUrlField(BuildContext context, CustomSize size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Google Maps URL',
          style: GoogleFonts.poppins(
            fontSize: size.customWidth(context) * 0.036,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimaryColor,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller.mapsUrlController,
          style: GoogleFonts.poppins(
            fontSize: size.customWidth(context) * 0.033,
            color: AppColors.textPrimaryColor,
          ),
          decoration: InputDecoration(
            // FIX 5: Updated hint text as requested
            hintText: 'Selected from map or paste manually',
            hintStyle: GoogleFonts.poppins(
              fontSize: size.customWidth(context) * 0.031,
              color: AppColors.textSecondaryColor.withOpacity(0.7),
            ),
            prefixIcon: const Icon(Icons.map_outlined, color: AppColors.accentColor, size: 22),
            suffixIcon: IconButton(
              icon: const Icon(Icons.open_in_new_rounded,
                  color: AppColors.accentColor, size: 18),
              tooltip: 'Preview in Maps',
              onPressed: () async {
                final url = widget.controller.mapsUrlController.text.trim();
                if (url.isEmpty) return;
                final uri = Uri.tryParse(url);
                if (uri != null && await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              },
            ),
            filled: true,
            fillColor: AppColors.lightGreyColor,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: AppColors.greyColor.withOpacity(0.2), width: 1)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.5)),
          ),
        ),
      ],
    );
  }

  Widget _field({
    required BuildContext ctx,
    required TextEditingController ctrl,
    required String label,
    required String hint,
    required IconData icon,
    required CustomSize size,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.poppins(
                fontSize: size.customWidth(ctx) * 0.036,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimaryColor)),
        const SizedBox(height: 8),
        TextFormField(
          controller: ctrl,
          validator: validator,
          onChanged: onChanged,
          style: GoogleFonts.poppins(
              fontSize: size.customWidth(ctx) * 0.038, color: AppColors.textPrimaryColor),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.poppins(
                fontSize: size.customWidth(ctx) * 0.035,
                color: AppColors.textSecondaryColor.withOpacity(0.7)),
            prefixIcon: Icon(icon, color: AppColors.primaryColor, size: 22),
            filled: true,
            fillColor: AppColors.lightGreyColor,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: AppColors.greyColor.withOpacity(0.2), width: 1)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.5)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: AppColors.errorColor, width: 1)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: AppColors.errorColor, width: 1.5)),
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//   Quick option tile widget — unchanged from original
// ═══════════════════════════════════════════════════════════════
class _QuickOptionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String sublabel;
  final Color color;
  final VoidCallback onTap;

  const _QuickOptionTile({
    required this.icon,
    required this.label,
    required this.sublabel,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.07),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withOpacity(0.25), width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(height: 8),
            Text(label,
                style: GoogleFonts.poppins(
                    fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimaryColor),
                textAlign: TextAlign.center),
            const SizedBox(height: 2),
            Text(sublabel,
                style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textSecondaryColor),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//   In-App Map View Screen — unchanged from original
// ═══════════════════════════════════════════════════════════════
class InAppMapViewScreen extends StatelessWidget {
  final LocationItem location;
  final LatLng? initial;

  const InAppMapViewScreen({super.key, required this.location, this.initial});

  @override
  Widget build(BuildContext context) {
    final center = initial ?? const LatLng(31.5204, 74.3587);
    final size = CustomSize();

    return Scaffold(
      body: Stack(
        children: [
          FlutterMapViewWidget(center: center, label: location.label),

          Positioned(
            top: 0, left: 0, right: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black.withOpacity(0.65), Colors.transparent],
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(12)),
                          child: const Icon(Icons.arrow_back_ios_new_rounded,
                              color: Colors.white, size: 18),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(location.label,
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: size.customWidth(context) * 0.042,
                                fontWeight: FontWeight.w600),
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 0, left: 0, right: 0,
            child: Container(
              decoration: const BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      size.customWidth(context) * 0.05, 20,
                      size.customWidth(context) * 0.05,
                      size.customHeight(context) * 0.025),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 40, height: 4,
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(2)),
                        ),
                      ),
                      Text(location.label,
                          style: GoogleFonts.poppins(
                              fontSize: size.customWidth(context) * 0.046,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimaryColor)),
                      const SizedBox(height: 6),
                      Row(children: [
                        const Icon(Icons.location_on_outlined, size: 15, color: AppColors.textSecondaryColor),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text('${location.address}, ${location.city}',
                              style: GoogleFonts.poppins(
                                  fontSize: size.customWidth(context) * 0.035,
                                  color: AppColors.textSecondaryColor)),
                        ),
                      ]),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            final uri = Uri.parse(location.mapsUrl);
                            if (await canLaunchUrl(uri)) {
                              await launchUrl(uri, mode: LaunchMode.externalApplication);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            elevation: 2,
                          ),
                          icon: const Icon(Icons.open_in_new_rounded, size: 18),
                          label: Text('Open in Google Maps',
                              style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}