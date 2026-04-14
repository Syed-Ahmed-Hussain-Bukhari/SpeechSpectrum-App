// lib/view/expert/home/expert_bottom_nav.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';

class ExpertBottomNav extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const ExpertBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  static const _items = [
    (Icons.home_outlined, Icons.home, 'Home'),
    (Icons.chat_bubble_outline, Icons.chat_bubble, 'Messages'),
    (Icons.person_outline, Icons.person, 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();
    final screenWidth = size.customWidth(context);
    final screenHeight = size.customHeight(context);

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenHeight * 0.012,
      ),
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.008),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(screenWidth * 0.08),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 4)),
          BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(_items.length, (i) {
          final item = _items[i];
          final isSelected = selectedIndex == i;
          return Flexible(
            flex: isSelected ? 2 : 1,
            child: GestureDetector(
              onTap: () => onTap(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                margin:
                    EdgeInsets.symmetric(horizontal: screenWidth * 0.008),
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.025,
                  vertical: screenHeight * 0.01,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primaryColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(screenWidth * 0.06),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isSelected ? item.$2 : item.$1,
                      color: isSelected
                          ? AppColors.whiteColor
                          : AppColors.greyColor,
                      size: screenWidth * 0.055,
                    ),
                    if (isSelected) ...[
                      SizedBox(width: screenWidth * 0.015),
                      Flexible(
                        child: Text(
                          item.$3,
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
        }),
      ),
    );
  }
}