// animated_bottom_navigation.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';

class BottomNavigationController extends GetxController {
  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}

class AnimatedBottomNavigation extends StatelessWidget {
  final Function(int) onTap;

  AnimatedBottomNavigation({
    super.key,
    required this.onTap,
  });

  final BottomNavigationController controller = Get.put(BottomNavigationController());

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();
    final screenWidth = size.customWidth(context);
    final screenHeight = size.customHeight(context);

    return 
    Container(
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenHeight * 0.012,
        // vertical: screenHeight * 0.006,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.0,
        vertical: screenHeight * 0.008,
      ),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(screenWidth * 0.08),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(
                context: context,
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                label: 'Home',
                index: 0,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
             _buildNavItem(
                context: context,
                icon: Icons.chat_bubble_outline,
                activeIcon: Icons.chat_bubble,
                label: 'Chat',
                index: 1,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              _buildNavItem(
                context: context,
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                label: 'Profile',
                index: 2,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
            ],
          )),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
    required double screenWidth,
    required double screenHeight,
  }) {
    final isSelected = controller.selectedIndex.value == index;

    return Flexible(
      flex: isSelected ? 2 : 1,
      child: GestureDetector(
        onTap: () {
          controller.changeIndex(index);
          onTap(index);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.008),
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.025,
            vertical: screenHeight * 0.01,
          ),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(screenWidth * 0.06),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isSelected ? activeIcon : icon,
                color: isSelected ? AppColors.whiteColor : AppColors.greyColor,
                size: screenWidth * 0.055,
              ),
              if (isSelected) ...[
                SizedBox(width: screenWidth * 0.015),
                Flexible(
                  child: Text(
                    label,
                    style: GoogleFonts.poppins(
                      color: AppColors.whiteColor,
                      fontSize: screenWidth * 0.032,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// Alternative Style 2 - Floating Elevated Button Style
class AnimatedBottomNavigationStyle2 extends StatelessWidget {
  final Function(int) onTap;

  AnimatedBottomNavigationStyle2({
    super.key,
    required this.onTap,
  });

  final BottomNavigationController controller = Get.put(BottomNavigationController());

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();
    final screenWidth = size.customWidth(context);
    final screenHeight = size.customHeight(context);

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.035,
        vertical: screenHeight * 0.01,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.012,
        vertical: screenHeight * 0.006,
      ),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(screenWidth * 0.1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 25,
            offset: const Offset(0, 5),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildFloatingNavItem(
                context: context,
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                label: 'Home',
                index: 0,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              _buildFloatingNavItem(
                context: context,
                icon: Icons.chat_bubble_outline,
                activeIcon: Icons.chat_bubble,
                label: 'Chat',
                index: 1,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              _buildFloatingNavItem(
                context: context,
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                label: 'Profile',
                index: 2,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
            ],
          )),
    );
  }

  Widget _buildFloatingNavItem({
    required BuildContext context,
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
    required double screenWidth,
    required double screenHeight,
  }) {
    final isSelected = controller.selectedIndex.value == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          controller.changeIndex(index);
          onTap(index);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOutCubic,
          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.006),
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.015,
            vertical: screenHeight * 0.012,
          ),
          decoration: BoxDecoration(
            gradient: isSelected
                ? LinearGradient(
                    colors: [AppColors.primaryColor, AppColors.secondaryColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            borderRadius: BorderRadius.circular(screenWidth * 0.08),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.primaryColor.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isSelected ? activeIcon : icon,
                color: isSelected ? AppColors.whiteColor : AppColors.greyColor,
                size: screenWidth * 0.06,
              ),
              SizedBox(height: screenHeight * 0.003),
              Flexible(
                child: Text(
                  label,
                  style: GoogleFonts.poppins(
                    color: isSelected
                        ? AppColors.whiteColor
                        : AppColors.textSecondaryColor,
                    fontSize: screenWidth * 0.028,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Alternative Style 3 - Dark Mode with Minimal Design
class AnimatedBottomNavigationStyle3 extends StatelessWidget {
  final Function(int) onTap;

  AnimatedBottomNavigationStyle3({
    super.key,
    required this.onTap,
  });

  final BottomNavigationController controller = Get.put(BottomNavigationController());

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();
    final screenWidth = size.customWidth(context);
    final screenHeight = size.customHeight(context);

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: screenHeight * 0.012,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.02,
        vertical: screenHeight * 0.008,
      ),
      decoration: BoxDecoration(
        color: AppColors.textPrimaryColor,
        borderRadius: BorderRadius.circular(screenWidth * 0.075),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMinimalNavItem(
                context: context,
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                label: 'Home',
                index: 0,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              _buildMinimalNavItem(
                context: context,
                icon: Icons.chat_bubble_outline,
                activeIcon: Icons.chat_bubble,
                label: 'Chat',
                index: 1,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              _buildMinimalNavItem(
                context: context,
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                label: 'Profile',
                index: 2,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
            ],
          )),
    );
  }

  Widget _buildMinimalNavItem({
    required BuildContext context,
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
    required double screenWidth,
    required double screenHeight,
  }) {
    final isSelected = controller.selectedIndex.value == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          controller.changeIndex(index);
          onTap(index);
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.01,
            horizontal: screenWidth * 0.01,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: isSelected ? screenWidth * 0.11 : screenWidth * 0.09,
                    height: isSelected ? screenWidth * 0.11 : screenWidth * 0.09,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primaryColor
                          : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Icon(
                    isSelected ? activeIcon : icon,
                    color:
                        isSelected ? AppColors.whiteColor : AppColors.greyColor,
                    size: screenWidth * 0.055,
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.004),
              Flexible(
                child: Text(
                  label,
                  style: GoogleFonts.poppins(
                    color:
                        isSelected ? AppColors.whiteColor : AppColors.greyColor,
                    fontSize: screenWidth * 0.026,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Style 4 - Compact Modern Design (Best for small screens)
class AnimatedBottomNavigationStyle4 extends StatelessWidget {
  final Function(int) onTap;

  AnimatedBottomNavigationStyle4({
    super.key,
    required this.onTap,
  });

  final BottomNavigationController controller = Get.put(BottomNavigationController());

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();
    final screenWidth = size.customWidth(context);
    final screenHeight = size.customHeight(context);

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.06,
        vertical: screenHeight * 0.01,
      ),
      height: screenHeight * 0.07,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Obx(() => Row(
            children: [
              _buildCompactNavItem(
                context: context,
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                label: 'Home',
                index: 0,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
                _buildCompactNavItem(
                context: context,
                icon: Icons.chat_bubble_outline,
                activeIcon: Icons.chat_bubble,
                label: 'Chat',
                index: 1,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              _buildCompactNavItem(
                context: context,
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                label: 'Profile',
                index: 2,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
            ],
          )),
    );
  }

  Widget _buildCompactNavItem({
    required BuildContext context,
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
    required double screenWidth,
    required double screenHeight,
  }) {
    final isSelected = controller.selectedIndex.value == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          controller.changeIndex(index);
          onTap(index);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: EdgeInsets.all(screenWidth * 0.012),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primaryColor.withOpacity(0.15)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(screenWidth * 0.04),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isSelected ? activeIcon : icon,
                color: isSelected
                    ? AppColors.primaryColor
                    : AppColors.greyColor,
                size: screenWidth * 0.058,
              ),
              SizedBox(height: screenHeight * 0.002),
              Text(
                label,
                style: GoogleFonts.poppins(
                  color: isSelected
                      ? AppColors.primaryColor
                      : AppColors.textSecondaryColor,
                  fontSize: screenWidth * 0.026,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
                overflow: TextOverflow.clip,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}