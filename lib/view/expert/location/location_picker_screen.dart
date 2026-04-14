// // // lib/view/expert/location/location_picker_screen.dart
// // //
// // // Navigated to from the Create/Edit bottom sheet.
// // // Returns a LocationItem to the caller via Get.back(result: item).

// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:url_launcher/url_launcher.dart';
// // import 'package:speechspectrum/constants/app_colors.dart';
// // import 'package:speechspectrum/constants/custom_size.dart';
// // import 'package:speechspectrum/controllers/location_controller.dart';
// // import 'package:speechspectrum/models/location_model.dart';

// // class LocationPickerScreen extends StatefulWidget {
// //   const LocationPickerScreen({super.key});

// //   @override
// //   State<LocationPickerScreen> createState() => _LocationPickerScreenState();
// // }

// // class _LocationPickerScreenState extends State<LocationPickerScreen> {
// //   late final LocationController controller;

// //   @override
// //   void initState() {
// //     super.initState();
// //     controller = Get.find<LocationController>();
// //     WidgetsBinding.instance.addPostFrameCallback((_) {
// //       controller.fetchAllLocations();
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
// //           'Select Location',
// //           style: GoogleFonts.poppins(
// //             color: AppColors.textPrimaryColor,
// //             fontSize: 18,
// //             fontWeight: FontWeight.w600,
// //           ),
// //         ),
// //         actions: [
// //           Obx(() => controller.isLoadingAll.value
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
// //                   icon: const Icon(Icons.refresh_rounded,
// //                       color: AppColors.primaryColor),
// //                   onPressed: () => controller.fetchAllLocations(),
// //                 )),
// //           SizedBox(width: size.customWidth(context) * 0.01),
// //         ],
// //       ),
// //       body: Column(
// //         children: [
// //           // ── Search bar ────────────────────────────────────────
// //           Container(
// //             color: AppColors.whiteColor,
// //             padding: EdgeInsets.fromLTRB(
// //               size.customWidth(context) * 0.04,
// //               0,
// //               size.customWidth(context) * 0.04,
// //               size.customHeight(context) * 0.018,
// //             ),
// //             child: TextField(
// //               controller: controller.searchController,
// //               onChanged: controller.filterLocations,
// //               style: GoogleFonts.poppins(
// //                 fontSize: size.customWidth(context) * 0.038,
// //                 color: AppColors.textPrimaryColor,
// //               ),
// //               decoration: InputDecoration(
// //                 hintText: 'Search by label, address or city...',
// //                 hintStyle: GoogleFonts.poppins(
// //                   fontSize: size.customWidth(context) * 0.035,
// //                   color: AppColors.textSecondaryColor.withOpacity(0.7),
// //                 ),
// //                 prefixIcon: const Icon(Icons.search_rounded,
// //                     color: AppColors.primaryColor, size: 22),
// //                 suffixIcon: Obx(() => controller.searchController.text.isNotEmpty
// //                     ? IconButton(
// //                         icon: const Icon(Icons.close_rounded,
// //                             color: AppColors.textSecondaryColor, size: 18),
// //                         onPressed: () {
// //                           controller.searchController.clear();
// //                           controller.filterLocations('');
// //                         },
// //                       )
// //                     : const SizedBox.shrink()),
// //                 filled: true,
// //                 fillColor: AppColors.lightGreyColor,
// //                 contentPadding:
// //                     const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// //                 border: OutlineInputBorder(
// //                   borderRadius: BorderRadius.circular(14),
// //                   borderSide: BorderSide.none,
// //                 ),
// //                 enabledBorder: OutlineInputBorder(
// //                   borderRadius: BorderRadius.circular(14),
// //                   borderSide: BorderSide(
// //                       color: AppColors.greyColor.withOpacity(0.2), width: 1),
// //                 ),
// //                 focusedBorder: OutlineInputBorder(
// //                   borderRadius: BorderRadius.circular(14),
// //                   borderSide:
// //                       const BorderSide(color: AppColors.primaryColor, width: 1.5),
// //                 ),
// //               ),
// //             ),
// //           ),

// //           // ── List ──────────────────────────────────────────────
// //           Expanded(
// //             child: Obx(() {
// //               if (controller.isLoadingAll.value) {
// //                 return _buildLoadingState(context, size);
// //               }
// //               if (controller.filteredAllLocations.isEmpty) {
// //                 return _buildEmptyState(context, size);
// //               }
// //               return ListView.builder(
// //                 padding: EdgeInsets.all(size.customWidth(context) * 0.04),
// //                 itemCount: controller.filteredAllLocations.length,
// //                 itemBuilder: (ctx, i) {
// //                   final loc = controller.filteredAllLocations[i];
// //                   return _buildLocationTile(context, size, loc);
// //                 },
// //               );
// //             }),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildLocationTile(
// //       BuildContext context, CustomSize size, LocationItem loc) {
// //     return Container(
// //       margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.015),
// //       decoration: BoxDecoration(
// //         color: AppColors.whiteColor,
// //         borderRadius: BorderRadius.circular(18),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.05),
// //             blurRadius: 12,
// //             offset: const Offset(0, 3),
// //           ),
// //         ],
// //       ),
// //       child: Material(
// //         color: Colors.transparent,
// //         child: InkWell(
// //           onTap: () => _confirmSelection(loc),
// //           borderRadius: BorderRadius.circular(18),
// //           child: Padding(
// //             padding: EdgeInsets.all(size.customWidth(context) * 0.04),
// //             child: Row(
// //               children: [
// //                 // Icon
// //                 Container(
// //                   width: 50,
// //                   height: 50,
// //                   decoration: BoxDecoration(
// //                     color: AppColors.primaryColor.withOpacity(0.1),
// //                     borderRadius: BorderRadius.circular(14),
// //                   ),
// //                   child: const Icon(Icons.business_rounded,
// //                       color: AppColors.primaryColor, size: 24),
// //                 ),
// //                 SizedBox(width: size.customWidth(context) * 0.035),

// //                 // Info
// //                 Expanded(
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Text(
// //                         loc.label,
// //                         style: GoogleFonts.poppins(
// //                           fontSize: size.customWidth(context) * 0.04,
// //                           fontWeight: FontWeight.w700,
// //                           color: AppColors.textPrimaryColor,
// //                         ),
// //                         maxLines: 1,
// //                         overflow: TextOverflow.ellipsis,
// //                       ),
// //                       const SizedBox(height: 3),
// //                       Row(
// //                         children: [
// //                           const Icon(Icons.location_on_outlined,
// //                               size: 13, color: AppColors.textSecondaryColor),
// //                           const SizedBox(width: 3),
// //                           Expanded(
// //                             child: Text(
// //                               loc.address,
// //                               style: GoogleFonts.poppins(
// //                                 fontSize: size.customWidth(context) * 0.032,
// //                                 color: AppColors.textSecondaryColor,
// //                               ),
// //                               maxLines: 1,
// //                               overflow: TextOverflow.ellipsis,
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                       const SizedBox(height: 2),
// //                       Row(
// //                         children: [
// //                           const Icon(Icons.location_city_outlined,
// //                               size: 13, color: AppColors.textSecondaryColor),
// //                           const SizedBox(width: 3),
// //                           Text(
// //                             loc.city,
// //                             style: GoogleFonts.poppins(
// //                               fontSize: size.customWidth(context) * 0.03,
// //                               color: AppColors.textSecondaryColor,
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ],
// //                   ),
// //                 ),

// //                 // Right actions
// //                 Column(
// //                   children: [
// //                     // Open map
// //                     GestureDetector(
// //                       onTap: () => _openMap(loc.mapsUrl),
// //                       child: Container(
// //                         padding: const EdgeInsets.all(8),
// //                         decoration: BoxDecoration(
// //                           color: AppColors.accentColor.withOpacity(0.1),
// //                           borderRadius: BorderRadius.circular(10),
// //                         ),
// //                         child: const Icon(Icons.map_outlined,
// //                             color: AppColors.accentColor, size: 18),
// //                       ),
// //                     ),
// //                     const SizedBox(height: 8),
// //                     // Select arrow
// //                     GestureDetector(
// //                       onTap: () => _confirmSelection(loc),
// //                       child: Container(
// //                         padding: const EdgeInsets.all(8),
// //                         decoration: BoxDecoration(
// //                           color: AppColors.primaryColor.withOpacity(0.1),
// //                           borderRadius: BorderRadius.circular(10),
// //                         ),
// //                         child: const Icon(Icons.check_rounded,
// //                             color: AppColors.primaryColor, size: 18),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   void _confirmSelection(LocationItem loc) {
// //     Get.back(result: loc);
// //   }

// //   Future<void> _openMap(String url) async {
// //     try {
// //       final uri = Uri.parse(url);
// //       if (await canLaunchUrl(uri)) {
// //         await launchUrl(uri, mode: LaunchMode.externalApplication);
// //       }
// //     } catch (_) {}
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
// //             'Loading available locations...',
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
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           Icon(Icons.search_off_rounded,
// //               size: 64, color: AppColors.textSecondaryColor.withOpacity(0.4)),
// //           SizedBox(height: size.customHeight(context) * 0.02),
// //           Text(
// //             'No locations found',
// //             style: GoogleFonts.poppins(
// //               fontSize: size.customWidth(context) * 0.042,
// //               fontWeight: FontWeight.w600,
// //               color: AppColors.textPrimaryColor,
// //             ),
// //           ),
// //           SizedBox(height: size.customHeight(context) * 0.008),
// //           Text(
// //             'Try a different search term',
// //             style: GoogleFonts.poppins(
// //               fontSize: size.customWidth(context) * 0.034,
// //               color: AppColors.textSecondaryColor,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // lib/view/expert/location/location_picker_screen.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/location_controller.dart';
// import 'package:speechspectrum/models/location_model.dart';

// class LocationPickerScreen extends StatefulWidget {
//   const LocationPickerScreen({super.key});

//   @override
//   State<LocationPickerScreen> createState() => _LocationPickerScreenState();
// }

// class _LocationPickerScreenState extends State<LocationPickerScreen> {
//   // Controller is always registered by ExpertLocationsScreen before navigation
//   final LocationController _c = Get.find<LocationController>();
//   final TextEditingController _searchCtrl = TextEditingController();

//   List<LocationItem> _filtered = [];
//   bool _loading = false;

//   @override
//   void initState() {
//     super.initState();
//     _fetchLocations();
//   }

//   @override
//   void dispose() {
//     _searchCtrl.dispose();
//     super.dispose();
//   }

//   Future<void> _fetchLocations() async {
//     if (!mounted) return;
//     setState(() => _loading = true);
//     await _c.fetchAllLocations();
//     if (!mounted) return;
//     setState(() {
//       _filtered = List.from(_c.allLocations);
//       _loading = false;
//     });
//   }

//   void _onSearch(String q) {
//     setState(() {
//       if (q.trim().isEmpty) {
//         _filtered = List.from(_c.allLocations);
//       } else {
//         final lower = q.toLowerCase();
//         _filtered = _c.allLocations
//             .where((l) =>
//                 l.label.toLowerCase().contains(lower) ||
//                 l.address.toLowerCase().contains(lower) ||
//                 l.city.toLowerCase().contains(lower))
//             .toList();
//       }
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
//         title: Text(
//           'Select Location',
//           style: GoogleFonts.poppins(
//             color: AppColors.textPrimaryColor,
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         actions: [
//           if (_loading)
//             const Padding(
//               padding: EdgeInsets.all(16),
//               child: SizedBox(
//                 width: 20,
//                 height: 20,
//                 child: CircularProgressIndicator(
//                     color: AppColors.primaryColor, strokeWidth: 2),
//               ),
//             )
//           else
//             IconButton(
//               icon: const Icon(Icons.refresh_rounded,
//                   color: AppColors.primaryColor),
//               onPressed: _fetchLocations,
//             ),
//           const SizedBox(width: 4),
//         ],
//       ),
//       body: Column(
//         children: [
//           // ── Search bar ──────────────────────────────────────
//           Container(
//             color: AppColors.whiteColor,
//             padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
//             child: TextField(
//               controller: _searchCtrl,
//               onChanged: _onSearch,
//               style: GoogleFonts.poppins(
//                 fontSize: 15,
//                 color: AppColors.textPrimaryColor,
//               ),
//               decoration: InputDecoration(
//                 hintText: 'Search by label, address or city...',
//                 hintStyle: GoogleFonts.poppins(
//                   fontSize: 14,
//                   color: AppColors.textSecondaryColor.withOpacity(0.7),
//                 ),
//                 prefixIcon: const Icon(Icons.search_rounded,
//                     color: AppColors.primaryColor, size: 22),
//                 suffixIcon: _searchCtrl.text.isNotEmpty
//                     ? IconButton(
//                         icon: const Icon(Icons.close_rounded,
//                             color: AppColors.textSecondaryColor, size: 18),
//                         onPressed: () {
//                           _searchCtrl.clear();
//                           _onSearch('');
//                         },
//                       )
//                     : null,
//                 filled: true,
//                 fillColor: AppColors.lightGreyColor,
//                 contentPadding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(14),
//                   borderSide: BorderSide.none,
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(14),
//                   borderSide: BorderSide(
//                       color: AppColors.greyColor.withOpacity(0.2), width: 1),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(14),
//                   borderSide: const BorderSide(
//                       color: AppColors.primaryColor, width: 1.5),
//                 ),
//               ),
//             ),
//           ),

//           // ── List ────────────────────────────────────────────
//           Expanded(
//             child: _loading
//                 ? _buildLoading(context, size)
//                 : _filtered.isEmpty
//                     ? _buildEmpty(context, size)
//                     : ListView.builder(
//                         padding:
//                             EdgeInsets.all(size.customWidth(context) * 0.04),
//                         itemCount: _filtered.length,
//                         itemBuilder: (ctx, i) =>
//                             _buildTile(context, size, _filtered[i]),
//                       ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTile(
//       BuildContext context, CustomSize size, LocationItem loc) {
//     return Container(
//       margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.015),
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(18),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 12,
//               offset: const Offset(0, 3)),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: () => Get.back(result: loc),
//           borderRadius: BorderRadius.circular(18),
//           child: Padding(
//             padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//             child: Row(
//               children: [
//                 // Icon badge
//                 Container(
//                   width: 50,
//                   height: 50,
//                   decoration: BoxDecoration(
//                     color: AppColors.primaryColor.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(14),
//                   ),
//                   child: const Icon(Icons.business_rounded,
//                       color: AppColors.primaryColor, size: 24),
//                 ),
//                 SizedBox(width: size.customWidth(context) * 0.035),

//                 // Info
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         loc.label,
//                         style: GoogleFonts.poppins(
//                           fontSize: size.customWidth(context) * 0.04,
//                           fontWeight: FontWeight.w700,
//                           color: AppColors.textPrimaryColor,
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       const SizedBox(height: 3),
//                       Row(children: [
//                         const Icon(Icons.location_on_outlined,
//                             size: 13,
//                             color: AppColors.textSecondaryColor),
//                         const SizedBox(width: 3),
//                         Expanded(
//                           child: Text(
//                             loc.address,
//                             style: GoogleFonts.poppins(
//                               fontSize: size.customWidth(context) * 0.032,
//                               color: AppColors.textSecondaryColor,
//                             ),
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                       ]),
//                       const SizedBox(height: 2),
//                       Row(children: [
//                         const Icon(Icons.location_city_outlined,
//                             size: 13,
//                             color: AppColors.textSecondaryColor),
//                         const SizedBox(width: 3),
//                         Text(
//                           loc.city,
//                           style: GoogleFonts.poppins(
//                             fontSize: size.customWidth(context) * 0.03,
//                             color: AppColors.textSecondaryColor,
//                           ),
//                         ),
//                       ]),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(width: 8),

//                 // Action buttons
//                 Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     // Open in external maps
//                     GestureDetector(
//                       onTap: () async {
//                         final uri = Uri.tryParse(loc.mapsUrl);
//                         if (uri != null && await canLaunchUrl(uri)) {
//                           await launchUrl(uri,
//                               mode: LaunchMode.externalApplication);
//                         }
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                           color: AppColors.accentColor.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: const Icon(Icons.map_outlined,
//                             color: AppColors.accentColor, size: 18),
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     // Select this location
//                     GestureDetector(
//                       onTap: () => Get.back(result: loc),
//                       child: Container(
//                         padding: const EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                           color: AppColors.primaryColor.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: const Icon(Icons.check_rounded,
//                             color: AppColors.primaryColor, size: 18),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildLoading(BuildContext context, CustomSize size) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const CircularProgressIndicator(
//               color: AppColors.primaryColor, strokeWidth: 3),
//           SizedBox(height: size.customHeight(context) * 0.02),
//           Text(
//             'Loading locations...',
//             style: GoogleFonts.poppins(
//               color: AppColors.textSecondaryColor,
//               fontSize: size.customWidth(context) * 0.036,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildEmpty(BuildContext context, CustomSize size) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.search_off_rounded,
//               size: 64,
//               color: AppColors.textSecondaryColor.withOpacity(0.4)),
//           SizedBox(height: size.customHeight(context) * 0.02),
//           Text(
//             'No locations found',
//             style: GoogleFonts.poppins(
//               fontSize: size.customWidth(context) * 0.042,
//               fontWeight: FontWeight.w600,
//               color: AppColors.textPrimaryColor,
//             ),
//           ),
//           SizedBox(height: size.customHeight(context) * 0.008),
//           Text(
//             'Try a different search term',
//             style: GoogleFonts.poppins(
//               fontSize: size.customWidth(context) * 0.034,
//               color: AppColors.textSecondaryColor,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// lib/view/expert/location/location_picker_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import 'package:speechspectrum/controllers/location_controller.dart';
import 'package:speechspectrum/models/location_model.dart';
import 'expert_locations_screen.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({super.key});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  // Controller is always registered by ExpertLocationsScreen before navigation
  final LocationController _c = Get.find<LocationController>();
  final TextEditingController _searchCtrl = TextEditingController();

  List<LocationItem> _filtered = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _fetchLocations();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  Future<void> _fetchLocations() async {
    if (!mounted) return;
    setState(() => _loading = true);
    await _c.fetchAllLocations();
    if (!mounted) return;
    setState(() {
      _filtered = List.from(_c.allLocations);
      _loading = false;
    });
  }

  void _onSearch(String q) {
    setState(() {
      if (q.trim().isEmpty) {
        _filtered = List.from(_c.allLocations);
      } else {
        final lower = q.toLowerCase();
        _filtered = _c.allLocations
            .where((l) =>
                l.label.toLowerCase().contains(lower) ||
                l.address.toLowerCase().contains(lower) ||
                l.city.toLowerCase().contains(lower))
            .toList();
      }
    });
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
          'Select Location',
          style: GoogleFonts.poppins(
            color: AppColors.textPrimaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          if (_loading)
            const Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                    color: AppColors.primaryColor, strokeWidth: 2),
              ),
            )
          else
            IconButton(
              icon: const Icon(Icons.refresh_rounded,
                  color: AppColors.primaryColor),
              onPressed: _fetchLocations,
            ),
          const SizedBox(width: 4),
        ],
      ),
      body: Column(
        children: [
          // ── Search bar ──────────────────────────────────────
          Container(
            color: AppColors.whiteColor,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
            child: TextField(
              controller: _searchCtrl,
              onChanged: _onSearch,
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: AppColors.textPrimaryColor,
              ),
              decoration: InputDecoration(
                hintText: 'Search by label, address or city...',
                hintStyle: GoogleFonts.poppins(
                  fontSize: 14,
                  color: AppColors.textSecondaryColor.withOpacity(0.7),
                ),
                prefixIcon: const Icon(Icons.search_rounded,
                    color: AppColors.primaryColor, size: 22),
                suffixIcon: _searchCtrl.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close_rounded,
                            color: AppColors.textSecondaryColor, size: 18),
                        onPressed: () {
                          _searchCtrl.clear();
                          _onSearch('');
                        },
                      )
                    : null,
                filled: true,
                fillColor: AppColors.lightGreyColor,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(
                      color: AppColors.greyColor.withOpacity(0.2), width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                      color: AppColors.primaryColor, width: 1.5),
                ),
              ),
            ),
          ),

          // ── List ────────────────────────────────────────────
          Expanded(
            child: _loading
                ? _buildLoading(context, size)
                : _filtered.isEmpty
                    ? _buildEmpty(context, size)
                    : ListView.builder(
                        padding:
                            EdgeInsets.all(size.customWidth(context) * 0.04),
                        itemCount: _filtered.length,
                        itemBuilder: (ctx, i) =>
                            _buildTile(context, size, _filtered[i]),
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildTile(
      BuildContext context, CustomSize size, LocationItem loc) {
    return Container(
      margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.015),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 3)),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Get.back(result: loc),
          borderRadius: BorderRadius.circular(18),
          child: Padding(
            padding: EdgeInsets.all(size.customWidth(context) * 0.04),
            child: Row(
              children: [
                // Icon badge
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.business_rounded,
                      color: AppColors.primaryColor, size: 24),
                ),
                SizedBox(width: size.customWidth(context) * 0.035),

                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loc.label,
                        style: GoogleFonts.poppins(
                          fontSize: size.customWidth(context) * 0.04,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimaryColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 3),
                      Row(children: [
                        const Icon(Icons.location_on_outlined,
                            size: 13,
                            color: AppColors.textSecondaryColor),
                        const SizedBox(width: 3),
                        Expanded(
                          child: Text(
                            loc.address,
                            style: GoogleFonts.poppins(
                              fontSize: size.customWidth(context) * 0.032,
                              color: AppColors.textSecondaryColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ]),
                      const SizedBox(height: 2),
                      Row(children: [
                        const Icon(Icons.location_city_outlined,
                            size: 13,
                            color: AppColors.textSecondaryColor),
                        const SizedBox(width: 3),
                        Text(
                          loc.city,
                          style: GoogleFonts.poppins(
                            fontSize: size.customWidth(context) * 0.03,
                            color: AppColors.textSecondaryColor,
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                // Action buttons
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Open in external maps
                    GestureDetector(
                      onTap: () {
                        LatLng? initial;
                        try {
                          final uri = Uri.parse(loc.mapsUrl);
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
                              location: loc,
                              initial: initial,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.accentColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.map_outlined,
                            color: AppColors.accentColor, size: 18),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Select this location
                    GestureDetector(
                      onTap: () => Get.back(result: loc),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.check_rounded,
                            color: AppColors.primaryColor, size: 18),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoading(BuildContext context, CustomSize size) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
              color: AppColors.primaryColor, strokeWidth: 3),
          SizedBox(height: size.customHeight(context) * 0.02),
          Text(
            'Loading locations...',
            style: GoogleFonts.poppins(
              color: AppColors.textSecondaryColor,
              fontSize: size.customWidth(context) * 0.036,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty(BuildContext context, CustomSize size) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off_rounded,
              size: 64,
              color: AppColors.textSecondaryColor.withOpacity(0.4)),
          SizedBox(height: size.customHeight(context) * 0.02),
          Text(
            'No locations found',
            style: GoogleFonts.poppins(
              fontSize: size.customWidth(context) * 0.042,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimaryColor,
            ),
          ),
          SizedBox(height: size.customHeight(context) * 0.008),
          Text(
            'Try a different search term',
            style: GoogleFonts.poppins(
              fontSize: size.customWidth(context) * 0.034,
              color: AppColors.textSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}