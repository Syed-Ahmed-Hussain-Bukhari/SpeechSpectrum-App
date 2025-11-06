import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import 'package:speechspectrum/routes/app_routes.dart';
import 'package:speechspectrum/view/AWARENESS/AWARENESS_screen.dart';
import 'package:speechspectrum/view/home/home_content_screen.dart';
import 'package:speechspectrum/view/profile_screen.dart/profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> _screens = [
    const HomeContentScreen(),
    const AwarenessScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.lightGreyColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: AppColors.primaryColor),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        title: Row(
          children: [
            Text(
              'Speech',
              style: GoogleFonts.poppins(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              'Spectrum',
              style: GoogleFonts.poppins(
                color: AppColors.textPrimaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: AppColors.primaryColor),
            onPressed: () {
              Get.toNamed(AppRoutes.notification);
            },
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: AppColors.greyColor,
          selectedLabelStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          unselectedLabelStyle: GoogleFonts.poppins(fontSize: 12),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.lightbulb_outline),
              activeIcon: Icon(Icons.lightbulb),
              label: 'Awareness',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    final size = CustomSize();
    
    return Drawer(
  child: Container(
    color: AppColors.whiteColor,
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        // --- FIXED: Removed the fixed height constraint on the Container ---
        Container(
          // height: size.customHeight(context) * 0.25, // <-- This line caused the overflow. REMOVED.
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primaryColor, AppColors.secondaryColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 20,top: 20,right: 20),
              child: Column(
                // The Column is the RenderFlex that was overflowing
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Syed Ahmed',
                    style: GoogleFonts.poppins(
                      color: AppColors.whiteColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'ahmed@email.com',
                    style: GoogleFonts.poppins(
                      color: AppColors.whiteColor.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // -------------------------------------------------------------------
        _buildDrawerItem(
          icon: Icons.home_outlined,
          title: 'Home',
          onTap: () {
            Navigator.pop(context);
            setState(() => _selectedIndex = 0);
          },
        ),
        _buildDrawerItem(
          icon: Icons.assignment_outlined,
          title: 'Screening',
          onTap: () {
            Navigator.pop(context);
            Get.toNamed(AppRoutes.questionnaire);
          },
        ),
        _buildDrawerItem(
          icon: Icons.bar_chart_outlined,
          title: 'Results',
          onTap: () {
            Navigator.pop(context);
            Get.toNamed(AppRoutes.results);
          },
        ),
        _buildDrawerItem(
          icon: Icons.lightbulb_outline,
          title: 'Awareness',
          onTap: () {
            Navigator.pop(context);
            setState(() => _selectedIndex = 1);
          },
        ),
        const Divider(),
        _buildDrawerItem(
          icon: Icons.settings_outlined,
          title: 'Settings',
          onTap: () {
            Navigator.pop(context);
            Get.toNamed(AppRoutes.settings);
          },
        ),
        _buildDrawerItem(
          icon: Icons.description_outlined,
          title: 'Terms & Conditions',
          onTap: () {
            Navigator.pop(context);
            Get.toNamed(AppRoutes.termsAndConditions);
          },
        ),
        _buildDrawerItem(
          icon: Icons.privacy_tip_outlined,
          title: 'Privacy Policy',
          onTap: () {
            Navigator.pop(context);
            Get.toNamed(AppRoutes.privacyPolicy);
          },
        ),
        _buildDrawerItem(
          icon: Icons.info_outline,
          title: 'About',
          onTap: () {
            Navigator.pop(context);
            Get.toNamed(AppRoutes.about);
          },
        ),
        const Divider(),
        _buildDrawerItem(
          icon: Icons.logout,
          title: 'Logout',
          onTap: () {
            Get.offAllNamed(AppRoutes.login);
          },
          color: AppColors.errorColor,
        ),

        SizedBox(height: 60,),
      ],
    ),
  ),
);
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    return ListTile(
      leading: Icon(icon, color: color ?? AppColors.textPrimaryColor),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          color: color ?? AppColors.textPrimaryColor,
          fontSize: 15,
        ),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
    );
  }
}
