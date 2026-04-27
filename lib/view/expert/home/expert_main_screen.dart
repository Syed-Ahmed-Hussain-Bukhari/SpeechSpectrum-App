// // lib/view/expert/home/expert_main_screen.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/expert_profile_controller.dart';
// import 'package:speechspectrum/routes/app_routes.dart';
// import 'package:speechspectrum/view/chat/expert/expert_chats_list_screen.dart';
// import 'package:speechspectrum/view/expert/home/expert_home_content_screen.dart';
// import 'package:speechspectrum/view/expert/profile/expert_profile_screen.dart';

// class ExpertMainScreen extends StatefulWidget {
//   const ExpertMainScreen({super.key});

//   @override
//   State<ExpertMainScreen> createState() => _ExpertMainScreenState();
// }

// class _ExpertMainScreenState extends State<ExpertMainScreen> {
//   int _selectedIndex = 0;
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   late final ExpertProfileController _profileController;

//   final List<Widget> _screens = const [
//     ExpertHomeContentScreen(),
//     ExpertChatsListScreen(),
//     ExpertProfileScreen(),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _profileController = Get.isRegistered<ExpertProfileController>()
//         ? Get.find<ExpertProfileController>()
//         : Get.put(ExpertProfileController());
//   }

//   void _onTap(int index) => setState(() => _selectedIndex = index);

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();
//     final screenWidth = size.customWidth(context);

//     return Scaffold(
//       key: _scaffoldKey,
//       backgroundColor: AppColors.lightGreyColor,
//       appBar: AppBar(
//         backgroundColor: AppColors.whiteColor,
//         elevation: 0,
//         surfaceTintColor: Colors.transparent,
//         leading: IconButton(
//           icon: Icon(Icons.menu,
//               color: AppColors.primaryColor, size: screenWidth * 0.065),
//           onPressed: () => _scaffoldKey.currentState?.openDrawer(),
//         ),
//         title: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Flexible(
//               child: Text(
//                 'Speech',
//                 style: GoogleFonts.poppins(
//                   color: AppColors.primaryColor,
//                   fontWeight: FontWeight.bold,
//                   fontSize: screenWidth * 0.048,
//                 ),
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//             Flexible(
//               child: Text(
//                 'Spectrum',
//                 style: GoogleFonts.poppins(
//                   color: AppColors.textPrimaryColor,
//                   fontWeight: FontWeight.bold,
//                   fontSize: screenWidth * 0.048,
//                 ),
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ],
//         ),
//         centerTitle: false,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.notifications_outlined,
//                 color: AppColors.primaryColor, size: screenWidth * 0.065),
//             onPressed: () => Get.toNamed(AppRoutes.notification),
//           ),
//         ],
//       ),
//       drawer: _ExpertDrawer(
//         profileController: _profileController,
//         onHomePressed: () => _onTap(0),
//         onMessagesPressed: () => _onTap(1),
//         onProfilePressed: () => _onTap(2),
//       ),
//       body: _screens[_selectedIndex],
//       bottomNavigationBar: SafeArea(
//         child: _ExpertBottomNav(
//           selectedIndex: _selectedIndex,
//           onTap: _onTap,
//         ),
//       ),
//     );
//   }
// }

// // ═══════════════════════════════════════════════════════════════
// //   Expert Bottom Navigation
// // ═══════════════════════════════════════════════════════════════
// class _ExpertBottomNav extends StatelessWidget {
//   final int selectedIndex;
//   final Function(int) onTap;

//   const _ExpertBottomNav({
//     required this.selectedIndex,
//     required this.onTap,
//   });

//   static const _items = [
//     (Icons.home_outlined, Icons.home, 'Home'),
//     (Icons.chat_bubble_outline, Icons.chat_bubble, 'Messages'),
//     (Icons.person_outline, Icons.person, 'Profile'),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();
//     final screenWidth = size.customWidth(context);
//     final screenHeight = size.customHeight(context);

//     return Container(
//       margin: EdgeInsets.symmetric(
//         horizontal: screenWidth * 0.04,
//         vertical: screenHeight * 0.012,
//       ),
//       padding: EdgeInsets.symmetric(vertical: screenHeight * 0.008),
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(screenWidth * 0.08),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withOpacity(0.08),
//               blurRadius: 20,
//               offset: const Offset(0, 4)),
//           BoxShadow(
//               color: AppColors.primaryColor.withOpacity(0.05),
//               blurRadius: 10,
//               offset: const Offset(0, 2)),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: List.generate(_items.length, (i) {
//           final item = _items[i];
//           final isSelected = selectedIndex == i;
//           return Flexible(
//             flex: isSelected ? 2 : 1,
//             child: GestureDetector(
//               onTap: () => onTap(i),
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 300),
//                 curve: Curves.easeInOut,
//                 margin:
//                     EdgeInsets.symmetric(horizontal: screenWidth * 0.008),
//                 padding: EdgeInsets.symmetric(
//                   horizontal: screenWidth * 0.025,
//                   vertical: screenHeight * 0.01,
//                 ),
//                 decoration: BoxDecoration(
//                   color: isSelected
//                       ? AppColors.primaryColor
//                       : Colors.transparent,
//                   borderRadius:
//                       BorderRadius.circular(screenWidth * 0.06),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(
//                       isSelected ? item.$2 : item.$1,
//                       color: isSelected
//                           ? AppColors.whiteColor
//                           : AppColors.greyColor,
//                       size: screenWidth * 0.055,
//                     ),
//                     if (isSelected) ...[
//                       SizedBox(width: screenWidth * 0.015),
//                       Flexible(
//                         child: Text(
//                           item.$3,
//                           style: GoogleFonts.poppins(
//                             color: AppColors.whiteColor,
//                             fontSize: screenWidth * 0.032,
//                             fontWeight: FontWeight.w600,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                           maxLines: 1,
//                         ),
//                       ),
//                     ],
//                   ],
//                 ),
//               ),
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }

// // ═══════════════════════════════════════════════════════════════
// //   Expert Animated Drawer
// // ═══════════════════════════════════════════════════════════════
// class _ExpertDrawer extends StatelessWidget {
//   final ExpertProfileController profileController;
//   final VoidCallback onHomePressed;
//   final VoidCallback onMessagesPressed;
//   final VoidCallback onProfilePressed;

//   const _ExpertDrawer({
//     required this.profileController,
//     required this.onHomePressed,
//     required this.onMessagesPressed,
//     required this.onProfilePressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();
//     final screenWidth = size.customWidth(context);
//     final screenHeight = size.customHeight(context);

//     return Drawer(
//       child: Container(
//         color: AppColors.whiteColor,
//         child: Column(
//           children: [
//             // Header
//             Obx(() => _buildHeader(
//                 context, screenWidth, screenHeight, profileController)),

//             // Menu items
//             Expanded(
//               child: ListView(
//                 padding: EdgeInsets.zero,
//                 children: [
//                   _buildSectionLabel('MAIN', screenWidth),
//                   _buildItem(
//                     context: context,
//                     icon: Icons.dashboard_outlined,
//                     selectedIcon: Icons.dashboard,
//                     title: 'Dashboard',
//                     screenWidth: screenWidth,
//                     screenHeight: screenHeight,
//                     onTap: () {
//                       Navigator.pop(context);
//                       onHomePressed();
//                     },
//                   ),
//                   _buildItem(
//                     context: context,
//                     icon: Icons.chat_bubble_outline,
//                     selectedIcon: Icons.chat_bubble,
//                     title: 'Messages',
//                     screenWidth: screenWidth,
//                     screenHeight: screenHeight,
//                     onTap: () {
//                       Navigator.pop(context);
//                       onMessagesPressed();
//                     },
//                   ),
//                   SizedBox(height: screenHeight * 0.01),
//                   _buildSectionLabel('MANAGEMENT', screenWidth),
//                   _buildItem(
//                     context: context,
//                     icon: Icons.location_on_outlined,
//                     selectedIcon: Icons.location_on,
//                     title: 'My Locations',
//                     screenWidth: screenWidth,
//                     screenHeight: screenHeight,
//                     onTap: () {
//                       Navigator.pop(context);
//                       Get.toNamed(AppRoutes.expertLocations);
//                     },
//                   ),
//                   _buildItem(
//                     context: context,
//                     icon: Icons.calendar_month_outlined,
//                     selectedIcon: Icons.calendar_month,
//                     title: 'My Slots',
//                     screenWidth: screenWidth,
//                     screenHeight: screenHeight,
//                     onTap: () {
//                       Navigator.pop(context);
//                       Get.toNamed(AppRoutes.expertSlots);
//                     },
//                   ),
//                   _buildItem(
//                     context: context,
//                     icon: Icons.event_note_outlined,
//                     selectedIcon: Icons.event_note,
//                     title: 'My Appointments',
//                     screenWidth: screenWidth,
//                     screenHeight: screenHeight,
//                     onTap: () {
//                       Navigator.pop(context);
//                       Get.toNamed(AppRoutes.myAppointments);
//                     },
//                   ),
//                   SizedBox(height: screenHeight * 0.01),
//                   _buildSectionLabel('ACCOUNT', screenWidth),
//                   _buildItem(
//                     context: context,
//                     icon: Icons.person_outline,
//                     selectedIcon: Icons.person,
//                     title: 'My Profile',
//                     screenWidth: screenWidth,
//                     screenHeight: screenHeight,
//                     onTap: () {
//                       Navigator.pop(context);
//                       onProfilePressed();
//                     },
//                   ),
//                   _buildItem(
//                     context: context,
//                     icon: Icons.settings_outlined,
//                     selectedIcon: Icons.settings,
//                     title: 'Settings',
//                     screenWidth: screenWidth,
//                     screenHeight: screenHeight,
//                     onTap: () {
//                       Navigator.pop(context);
//                       Get.toNamed(AppRoutes.settings);
//                     },
//                   ),
//                   _buildItem(
//                     context: context,
//                     icon: Icons.info_outline,
//                     selectedIcon: Icons.info,
//                     title: 'About',
//                     screenWidth: screenWidth,
//                     screenHeight: screenHeight,
//                     onTap: () {
//                       Navigator.pop(context);
//                       Get.toNamed(AppRoutes.about);
//                     },
//                   ),
//                   SizedBox(height: screenHeight * 0.02),
//                 ],
//               ),
//             ),

//             // Logout
//             SafeArea(
//               top: false,
//               child: _buildLogoutButton(
//                   context, screenWidth, screenHeight),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader(BuildContext context, double screenWidth,
//       double screenHeight, ExpertProfileController ctrl) {
//     return Container(
//       width: double.infinity,
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [AppColors.primaryColor, AppColors.secondaryColor],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       child: SafeArea(
//         bottom: false,
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//             horizontal: screenWidth * 0.05,
//             vertical: screenHeight * 0.025,
//           ),
//           child: Row(
//             children: [
//               // Avatar
//               Container(
//                 width: screenWidth * 0.15,
//                 height: screenWidth * 0.15,
//                 decoration: BoxDecoration(
//                   color: AppColors.whiteColor,
//                   shape: BoxShape.circle,
//                   boxShadow: [
//                     BoxShadow(
//                         color: Colors.black.withOpacity(0.1),
//                         blurRadius: 8,
//                         offset: const Offset(0, 2))
//                   ],
//                 ),
//                 alignment: Alignment.center,
//                 child: Text(
//                   ctrl.userInitial,
//                   style: GoogleFonts.poppins(
//                     fontSize: screenWidth * 0.07,
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.primaryColor,
//                   ),
//                 ),
//               ),
//               SizedBox(width: screenWidth * 0.04),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       ctrl.fullName.isNotEmpty ? ctrl.fullName : 'Expert',
//                       style: GoogleFonts.poppins(
//                         color: AppColors.whiteColor,
//                         fontSize: screenWidth * 0.042,
//                         fontWeight: FontWeight.w600,
//                       ),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     SizedBox(height: screenHeight * 0.003),
//                     Text(
//                       ctrl.specialization.isNotEmpty
//                           ? ctrl.specialization
//                           : 'Speech Therapist',
//                       style: GoogleFonts.poppins(
//                         color: AppColors.whiteColor.withOpacity(0.85),
//                         fontSize: screenWidth * 0.03,
//                       ),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     SizedBox(height: screenHeight * 0.006),
//                     // Approval badge
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 8, vertical: 2),
//                       decoration: BoxDecoration(
//                         color: ctrl.isApproved
//                             ? AppColors.successColor.withOpacity(0.25)
//                             : AppColors.warningColor.withOpacity(0.25),
//                         borderRadius: BorderRadius.circular(20),
//                         border: Border.all(
//                             color: AppColors.whiteColor.withOpacity(0.4)),
//                       ),
//                       child: Text(
//                         ctrl.isApproved ? '✓ Approved' : 'Pending',
//                         style: GoogleFonts.poppins(
//                           color: AppColors.whiteColor,
//                           fontSize: screenWidth * 0.027,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () => Get.back(),
//                 child: Container(
//                   padding: EdgeInsets.all(screenWidth * 0.02),
//                   decoration: BoxDecoration(
//                     color: AppColors.whiteColor.withOpacity(0.2),
//                     borderRadius:
//                         BorderRadius.circular(screenWidth * 0.02),
//                   ),
//                   child: Icon(Icons.chevron_right,
//                       color: AppColors.whiteColor,
//                       size: screenWidth * 0.05),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSectionLabel(String label, double screenWidth) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//           horizontal: screenWidth * 0.06, vertical: screenWidth * 0.03),
//       child: Text(
//         label,
//         style: GoogleFonts.poppins(
//           fontSize: screenWidth * 0.03,
//           fontWeight: FontWeight.w600,
//           color: AppColors.textSecondaryColor,
//           letterSpacing: 1.2,
//         ),
//       ),
//     );
//   }

//   Widget _buildItem({
//     required BuildContext context,
//     required IconData icon,
//     required IconData selectedIcon,
//     required String title,
//     required double screenWidth,
//     required double screenHeight,
//     required VoidCallback onTap,
//   }) {
//     return Container(
//       margin: EdgeInsets.symmetric(
//           horizontal: screenWidth * 0.04, vertical: screenHeight * 0.003),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: onTap,
//           borderRadius: BorderRadius.circular(screenWidth * 0.025),
//           child: Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: screenWidth * 0.04,
//               vertical: screenHeight * 0.015,
//             ),
//             child: Row(
//               children: [
//                 Icon(icon,
//                     color: AppColors.textSecondaryColor,
//                     size: screenWidth * 0.055),
//                 SizedBox(width: screenWidth * 0.04),
//                 Text(
//                   title,
//                   style: GoogleFonts.poppins(
//                     color: AppColors.textPrimaryColor,
//                     fontSize: screenWidth * 0.038,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildLogoutButton(BuildContext context, double screenWidth,
//       double screenHeight) {
//     return Container(
//       padding: EdgeInsets.all(screenWidth * 0.04),
//       decoration: BoxDecoration(
//         border: Border(
//             top: BorderSide(
//                 color: AppColors.greyColor.withOpacity(0.2), width: 1)),
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: () => _showLogoutDialog(context),
//           borderRadius: BorderRadius.circular(screenWidth * 0.025),
//           child: Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: screenWidth * 0.04,
//               vertical: screenHeight * 0.015,
//             ),
//             child: Row(
//               children: [
//                 Icon(Icons.logout,
//                     color: AppColors.errorColor, size: screenWidth * 0.055),
//                 SizedBox(width: screenWidth * 0.04),
//                 Text(
//                   'Logout Account',
//                   style: GoogleFonts.poppins(
//                     color: AppColors.errorColor,
//                     fontSize: screenWidth * 0.038,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _showLogoutDialog(BuildContext context) {
//     final ctrl = profileController;
//     Get.dialog(
//       AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         title: Text('Logout',
//             style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
//         content: Text('Are you sure you want to logout?',
//             style: GoogleFonts.poppins(color: AppColors.textSecondaryColor)),
//         actions: [
//           TextButton(
//             onPressed: () => Get.back(),
//             child: Text('Cancel',
//                 style: GoogleFonts.poppins(
//                     color: AppColors.textSecondaryColor,
//                     fontWeight: FontWeight.w600)),
//           ),
//           Obx(() => ElevatedButton(
//                 onPressed: ctrl.isLoggingOut.value
//                     ? null
//                     : () {
//                         Get.back();
//                         ctrl.logout();
//                       },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.errorColor,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                 ),
//                 child: ctrl.isLoggingOut.value
//                     ? const SizedBox(
//                         width: 20,
//                         height: 20,
//                         child: CircularProgressIndicator(
//                             color: Colors.white, strokeWidth: 2))
//                     : Text('Logout',
//                         style: GoogleFonts.poppins(
//                             color: AppColors.whiteColor,
//                             fontWeight: FontWeight.w600)),
//               )),
//         ],
//       ),
//     );
//   }
// }


// // lib/view/expert/home/expert_main_screen.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/expert_profile_controller.dart';
// import 'package:speechspectrum/routes/app_routes.dart';
// import 'package:speechspectrum/view/chat/expert/expert_chats_list_screen.dart';
// import 'package:speechspectrum/view/expert/home/expert_home_content_screen.dart';
// import 'package:speechspectrum/view/expert/profile/expert_profile_screen.dart';

// class ExpertMainScreen extends StatefulWidget {
//   const ExpertMainScreen({super.key});

//   @override
//   State<ExpertMainScreen> createState() => _ExpertMainScreenState();
// }

// class _ExpertMainScreenState extends State<ExpertMainScreen> {
//   int _selectedIndex = 0;
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   late final ExpertProfileController _profileController;

//   // Remove const — screens need live controller access
//   late final List<Widget> _screens;

//   @override
//   void initState() {
//     super.initState();
//     _profileController = Get.isRegistered<ExpertProfileController>()
//         ? Get.find<ExpertProfileController>()
//         : Get.put(ExpertProfileController());

//     _screens = [
//       const ExpertHomeContentScreen(),
//       const ExpertChatsListScreen(),
//       const ExpertProfileScreen(),
//     ];
//   }

//   void _onTap(int index) => setState(() => _selectedIndex = index);

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();
//     final screenWidth = size.customWidth(context);

//     return Scaffold(
//       key: _scaffoldKey,
//       backgroundColor: AppColors.lightGreyColor,
//       appBar: AppBar(
//         backgroundColor: AppColors.whiteColor,
//         elevation: 0,
//         surfaceTintColor: Colors.transparent,
//         leading: IconButton(
//           icon: Icon(Icons.menu,
//               color: AppColors.primaryColor, size: screenWidth * 0.065),
//           onPressed: () => _scaffoldKey.currentState?.openDrawer(),
//         ),
//         title: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Flexible(
//               child: Text(
//                 'Speech',
//                 style: GoogleFonts.poppins(
//                   color: AppColors.primaryColor,
//                   fontWeight: FontWeight.bold,
//                   fontSize: screenWidth * 0.048,
//                 ),
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//             Flexible(
//               child: Text(
//                 'Spectrum',
//                 style: GoogleFonts.poppins(
//                   color: AppColors.textPrimaryColor,
//                   fontWeight: FontWeight.bold,
//                   fontSize: screenWidth * 0.048,
//                 ),
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ],
//         ),
//         centerTitle: false,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.notifications_outlined,
//                 color: AppColors.primaryColor, size: screenWidth * 0.065),
//             onPressed: () => Get.toNamed(AppRoutes.notification),
//           ),
//         ],
//       ),
//       drawer: _ExpertDrawer(
//         profileController: _profileController,
//         onHomePressed: () => _onTap(0),
//         onMessagesPressed: () => _onTap(1),
//         onProfilePressed: () => _onTap(2),
//       ),
//       body: _screens[_selectedIndex],
//       bottomNavigationBar: SafeArea(
//         child: _ExpertBottomNav(
//           selectedIndex: _selectedIndex,
//           onTap: _onTap,
//         ),
//       ),
//     );
//   }
// }

// // ═══════════════════════════════════════════════════════════════
// //   Expert Bottom Navigation
// // ═══════════════════════════════════════════════════════════════
// class _ExpertBottomNav extends StatelessWidget {
//   final int selectedIndex;
//   final Function(int) onTap;

//   const _ExpertBottomNav({
//     required this.selectedIndex,
//     required this.onTap,
//   });

//   static const _items = [
//     (Icons.home_outlined, Icons.home, 'Home'),
//     (Icons.chat_bubble_outline, Icons.chat_bubble, 'Messages'),
//     (Icons.person_outline, Icons.person, 'Profile'),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();
//     final screenWidth = size.customWidth(context);
//     final screenHeight = size.customHeight(context);

//     return Container(
//       margin: EdgeInsets.symmetric(
//         horizontal: screenWidth * 0.04,
//         vertical: screenHeight * 0.012,
//       ),
//       padding: EdgeInsets.symmetric(vertical: screenHeight * 0.008),
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(screenWidth * 0.08),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withOpacity(0.08),
//               blurRadius: 20,
//               offset: const Offset(0, 4)),
//           BoxShadow(
//               color: AppColors.primaryColor.withOpacity(0.05),
//               blurRadius: 10,
//               offset: const Offset(0, 2)),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: List.generate(_items.length, (i) {
//           final item = _items[i];
//           final isSelected = selectedIndex == i;
//           return Flexible(
//             flex: isSelected ? 2 : 1,
//             child: GestureDetector(
//               onTap: () => onTap(i),
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 300),
//                 curve: Curves.easeInOut,
//                 margin:
//                     EdgeInsets.symmetric(horizontal: screenWidth * 0.008),
//                 padding: EdgeInsets.symmetric(
//                   horizontal: screenWidth * 0.025,
//                   vertical: screenHeight * 0.01,
//                 ),
//                 decoration: BoxDecoration(
//                   color: isSelected
//                       ? AppColors.primaryColor
//                       : Colors.transparent,
//                   borderRadius:
//                       BorderRadius.circular(screenWidth * 0.06),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(
//                       isSelected ? item.$2 : item.$1,
//                       color: isSelected
//                           ? AppColors.whiteColor
//                           : AppColors.greyColor,
//                       size: screenWidth * 0.055,
//                     ),
//                     if (isSelected) ...[
//                       SizedBox(width: screenWidth * 0.015),
//                       Flexible(
//                         child: Text(
//                           item.$3,
//                           style: GoogleFonts.poppins(
//                             color: AppColors.whiteColor,
//                             fontSize: screenWidth * 0.032,
//                             fontWeight: FontWeight.w600,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                           maxLines: 1,
//                         ),
//                       ),
//                     ],
//                   ],
//                 ),
//               ),
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }

// // ═══════════════════════════════════════════════════════════════
// //   Expert Animated Drawer
// // ═══════════════════════════════════════════════════════════════
// class _ExpertDrawer extends StatelessWidget {
//   final ExpertProfileController profileController;
//   final VoidCallback onHomePressed;
//   final VoidCallback onMessagesPressed;
//   final VoidCallback onProfilePressed;

//   const _ExpertDrawer({
//     required this.profileController,
//     required this.onHomePressed,
//     required this.onMessagesPressed,
//     required this.onProfilePressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();
//     final screenWidth = size.customWidth(context);
//     final screenHeight = size.customHeight(context);

//     return Drawer(
//       child: Container(
//         color: AppColors.whiteColor,
//         child: Column(
//           children: [
//             // Header — wrap only this in Obx since it reads reactive fields
//             Obx(() => _buildHeader(
//                 context, screenWidth, screenHeight, profileController)),

//             // Menu items — no reactive data, no Obx needed
//             Expanded(
//               child: ListView(
//                 padding: EdgeInsets.zero,
//                 children: [
//                   _buildSectionLabel('MAIN', screenWidth),
//                   _buildItem(
//                     context: context,
//                     icon: Icons.dashboard_outlined,
//                     selectedIcon: Icons.dashboard,
//                     title: 'Dashboard',
//                     screenWidth: screenWidth,
//                     screenHeight: screenHeight,
//                     onTap: () {
//                       Navigator.pop(context);
//                       onHomePressed();
//                     },
//                   ),
//                   _buildItem(
//                     context: context,
//                     icon: Icons.chat_bubble_outline,
//                     selectedIcon: Icons.chat_bubble,
//                     title: 'Messages',
//                     screenWidth: screenWidth,
//                     screenHeight: screenHeight,
//                     onTap: () {
//                       Navigator.pop(context);
//                       onMessagesPressed();
//                     },
//                   ),
//                   SizedBox(height: screenHeight * 0.01),
//                   _buildSectionLabel('MANAGEMENT', screenWidth),
//                   _buildItem(
//                     context: context,
//                     icon: Icons.location_on_outlined,
//                     selectedIcon: Icons.location_on,
//                     title: 'My Locations',
//                     screenWidth: screenWidth,
//                     screenHeight: screenHeight,
//                     onTap: () {
//                       Navigator.pop(context);
//                       Get.toNamed(AppRoutes.expertLocations);
//                     },
//                   ),
//                   _buildItem(
//                     context: context,
//                     icon: Icons.calendar_month_outlined,
//                     selectedIcon: Icons.calendar_month,
//                     title: 'My Slots',
//                     screenWidth: screenWidth,
//                     screenHeight: screenHeight,
//                     onTap: () {
//                       Navigator.pop(context);
//                       Get.toNamed(AppRoutes.expertSlots);
//                     },
//                   ),
//                   _buildItem(
//                     context: context,
//                     icon: Icons.event_note_outlined,
//                     selectedIcon: Icons.event_note,
//                     title: 'My Appointments',
//                     screenWidth: screenWidth,
//                     screenHeight: screenHeight,
//                     onTap: () {
//                       Navigator.pop(context);
//                       Get.toNamed(AppRoutes.myAppointments);
//                     },
//                   ),
//                   SizedBox(height: screenHeight * 0.01),
//                   _buildSectionLabel('ACCOUNT', screenWidth),
//                   _buildItem(
//                     context: context,
//                     icon: Icons.person_outline,
//                     selectedIcon: Icons.person,
//                     title: 'My Profile',
//                     screenWidth: screenWidth,
//                     screenHeight: screenHeight,
//                     onTap: () {
//                       Navigator.pop(context);
//                       onProfilePressed();
//                     },
//                   ),
//                   _buildItem(
//                     context: context,
//                     icon: Icons.settings_outlined,
//                     selectedIcon: Icons.settings,
//                     title: 'Settings',
//                     screenWidth: screenWidth,
//                     screenHeight: screenHeight,
//                     onTap: () {
//                       Navigator.pop(context);
//                       Get.toNamed(AppRoutes.settings);
//                     },
//                   ),
//                   _buildItem(
//                     context: context,
//                     icon: Icons.info_outline,
//                     selectedIcon: Icons.info,
//                     title: 'About',
//                     screenWidth: screenWidth,
//                     screenHeight: screenHeight,
//                     onTap: () {
//                       Navigator.pop(context);
//                       Get.toNamed(AppRoutes.about);
//                     },
//                   ),
//                   SizedBox(height: screenHeight * 0.02),
//                 ],
//               ),
//             ),

//             // Logout
//             SafeArea(
//               top: false,
//               child: _buildLogoutButton(
//                   context, screenWidth, screenHeight),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader(BuildContext context, double screenWidth,
//       double screenHeight, ExpertProfileController ctrl) {
//     // NOTE: This is called inside Obx() so all .value reads are reactive
//     return Container(
//       width: double.infinity,
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [AppColors.primaryColor, AppColors.secondaryColor],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       child: SafeArea(
//         bottom: false,
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//             horizontal: screenWidth * 0.05,
//             vertical: screenHeight * 0.025,
//           ),
//           child: Row(
//             children: [
//               // Avatar
//               Container(
//                 width: screenWidth * 0.15,
//                 height: screenWidth * 0.15,
//                 decoration: BoxDecoration(
//                   color: AppColors.whiteColor,
//                   shape: BoxShape.circle,
//                   boxShadow: [
//                     BoxShadow(
//                         color: Colors.black.withOpacity(0.1),
//                         blurRadius: 8,
//                         offset: const Offset(0, 2))
//                   ],
//                 ),
//                 alignment: Alignment.center,
//                 child: Text(
//                   ctrl.userInitial,
//                   style: GoogleFonts.poppins(
//                     fontSize: screenWidth * 0.07,
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.primaryColor,
//                   ),
//                 ),
//               ),
//               SizedBox(width: screenWidth * 0.04),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       ctrl.fullName.isNotEmpty ? ctrl.fullName : 'Expert',
//                       style: GoogleFonts.poppins(
//                         color: AppColors.whiteColor,
//                         fontSize: screenWidth * 0.042,
//                         fontWeight: FontWeight.w600,
//                       ),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     SizedBox(height: screenHeight * 0.003),
//                     Text(
//                       ctrl.specialization.isNotEmpty
//                           ? ctrl.specialization
//                           : 'Speech Therapist',
//                       style: GoogleFonts.poppins(
//                         color: AppColors.whiteColor.withOpacity(0.85),
//                         fontSize: screenWidth * 0.03,
//                       ),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     SizedBox(height: screenHeight * 0.006),
//                     // Approval badge
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 8, vertical: 2),
//                       decoration: BoxDecoration(
//                         color: ctrl.isApproved
//                             ? AppColors.successColor.withOpacity(0.25)
//                             : AppColors.warningColor.withOpacity(0.25),
//                         borderRadius: BorderRadius.circular(20),
//                         border: Border.all(
//                             color: AppColors.whiteColor.withOpacity(0.4)),
//                       ),
//                       child: Text(
//                         ctrl.isApproved ? '✓ Approved' : 'Pending',
//                         style: GoogleFonts.poppins(
//                           color: AppColors.whiteColor,
//                           fontSize: screenWidth * 0.027,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () => Get.back(),
//                 child: Container(
//                   padding: EdgeInsets.all(screenWidth * 0.02),
//                   decoration: BoxDecoration(
//                     color: AppColors.whiteColor.withOpacity(0.2),
//                     borderRadius:
//                         BorderRadius.circular(screenWidth * 0.02),
//                   ),
//                   child: Icon(Icons.chevron_right,
//                       color: AppColors.whiteColor,
//                       size: screenWidth * 0.05),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSectionLabel(String label, double screenWidth) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//           horizontal: screenWidth * 0.06, vertical: screenWidth * 0.03),
//       child: Text(
//         label,
//         style: GoogleFonts.poppins(
//           fontSize: screenWidth * 0.03,
//           fontWeight: FontWeight.w600,
//           color: AppColors.textSecondaryColor,
//           letterSpacing: 1.2,
//         ),
//       ),
//     );
//   }

//   Widget _buildItem({
//     required BuildContext context,
//     required IconData icon,
//     required IconData selectedIcon,
//     required String title,
//     required double screenWidth,
//     required double screenHeight,
//     required VoidCallback onTap,
//   }) {
//     return Container(
//       margin: EdgeInsets.symmetric(
//           horizontal: screenWidth * 0.04, vertical: screenHeight * 0.003),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: onTap,
//           borderRadius: BorderRadius.circular(screenWidth * 0.025),
//           child: Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: screenWidth * 0.04,
//               vertical: screenHeight * 0.015,
//             ),
//             child: Row(
//               children: [
//                 Icon(icon,
//                     color: AppColors.textSecondaryColor,
//                     size: screenWidth * 0.055),
//                 SizedBox(width: screenWidth * 0.04),
//                 Text(
//                   title,
//                   style: GoogleFonts.poppins(
//                     color: AppColors.textPrimaryColor,
//                     fontSize: screenWidth * 0.038,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildLogoutButton(BuildContext context, double screenWidth,
//       double screenHeight) {
//     return Container(
//       padding: EdgeInsets.all(screenWidth * 0.04),
//       decoration: BoxDecoration(
//         border: Border(
//             top: BorderSide(
//                 color: AppColors.greyColor.withOpacity(0.2), width: 1)),
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: () => _showLogoutDialog(context),
//           borderRadius: BorderRadius.circular(screenWidth * 0.025),
//           child: Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: screenWidth * 0.04,
//               vertical: screenHeight * 0.015,
//             ),
//             child: Row(
//               children: [
//                 Icon(Icons.logout,
//                     color: AppColors.errorColor, size: screenWidth * 0.055),
//                 SizedBox(width: screenWidth * 0.04),
//                 Text(
//                   'Logout Account',
//                   style: GoogleFonts.poppins(
//                     color: AppColors.errorColor,
//                     fontSize: screenWidth * 0.038,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _showLogoutDialog(BuildContext context) {
//     final ctrl = profileController;
//     Get.dialog(
//       AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         title: Text('Logout',
//             style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
//         content: Text('Are you sure you want to logout?',
//             style: GoogleFonts.poppins(color: AppColors.textSecondaryColor)),
//         actions: [
//           TextButton(
//             onPressed: () => Get.back(),
//             child: Text('Cancel',
//                 style: GoogleFonts.poppins(
//                     color: AppColors.textSecondaryColor,
//                     fontWeight: FontWeight.w600)),
//           ),
//           // Obx wraps ONLY the button that changes based on isLoggingOut
//           Obx(() => ElevatedButton(
//                 onPressed: ctrl.isLoggingOut.value
//                     ? null
//                     : () {
//                         Get.back();
//                         ctrl.logout();
//                       },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.errorColor,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                 ),
//                 child: ctrl.isLoggingOut.value
//                     ? const SizedBox(
//                         width: 20,
//                         height: 20,
//                         child: CircularProgressIndicator(
//                             color: Colors.white, strokeWidth: 2))
//                     : Text('Logout',
//                         style: GoogleFonts.poppins(
//                             color: AppColors.whiteColor,
//                             fontWeight: FontWeight.w600)),
//               )),
//         ],
//       ),
//     );
//   }
// }


// lib/view/expert/home/expert_main_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import 'package:speechspectrum/controllers/expert_drawer_controller.dart';
import 'package:speechspectrum/controllers/expert_profile_controller.dart';
import 'package:speechspectrum/controllers/logout_controller.dart';
import 'package:speechspectrum/routes/app_routes.dart';
import 'package:speechspectrum/view/chat/expert/expert_chats_list_screen.dart';
import 'package:speechspectrum/view/expert/appointments/my_appointments_screen.dart';
import 'package:speechspectrum/view/expert/home/expert_home_content_screen.dart';
import 'package:speechspectrum/view/expert/profile/expert_profile_screen.dart';
import 'package:speechspectrum/widget/expert_animated_drawer.dart';
import 'package:speechspectrum/widget/expert_bottom_nav.dart';

class ExpertMainScreen extends StatefulWidget {
  const ExpertMainScreen({super.key});

  @override
  State<ExpertMainScreen> createState() => _ExpertMainScreenState();
}

class _ExpertMainScreenState extends State<ExpertMainScreen> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();

    // Register all controllers once here
    if (!Get.isRegistered<ExpertProfileController>()) {
      Get.put(ExpertProfileController());
    }
    if (!Get.isRegistered<ExpertDrawerController>()) {
      Get.put(ExpertDrawerController());
    }
    if (!Get.isRegistered<LogoutController>()) {
      Get.put(LogoutController());
    }

    // Late-init screens after controllers are registered
    _screens = const [
      ExpertHomeContentScreen(),
      MyAppointmentsScreen(),
      ExpertProfileScreen(),
    ];
  }

  void _onTap(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();
    final screenWidth = size.customWidth(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.lightGreyColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.menu,
              color: AppColors.primaryColor, size: screenWidth * 0.065),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                'Speech',
                style: GoogleFonts.poppins(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.048,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Flexible(
              child: Text(
                'Spectrum',
                style: GoogleFonts.poppins(
                  color: AppColors.textPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.048,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined,
                color: AppColors.primaryColor, size: screenWidth * 0.065),
            onPressed: () => Get.toNamed(AppRoutes.notification),
          ),
        ],
      ),

      // ── Separated Drawer ──────────────────────────────────────
      drawer: ExpertAnimatedDrawer(
        onHomePressed: () => _onTap(0),
        onMessagesPressed: () => _onTap(1),
        onProfilePressed: () => _onTap(2),
      ),

      body: _screens[_selectedIndex],

      // ── Separated Bottom Nav ──────────────────────────────────
      bottomNavigationBar: SafeArea(
        child: ExpertBottomNav(
          selectedIndex: _selectedIndex,
          onTap: _onTap,
        ),
      ),
    );
  }
}