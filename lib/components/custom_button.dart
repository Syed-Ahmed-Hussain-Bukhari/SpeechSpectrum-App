import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool loading;
  final double height;
  final double width;
  final Color? color;
  final double radius;

  const CustomButton({
    super.key,
    required this.radius,
    this.color,
    required this.height,
    required this.width,
    required this.title,
    this.onTap,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: loading ? null : onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color ?? AppColors.primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          boxShadow: [
            BoxShadow(
              color: (color ?? AppColors.primaryColor).withOpacity(0.3),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: loading
              ? CircularProgressIndicator(
                  strokeWidth: CustomSize().customWidth(context) / 200,
                  color: Colors.white,
                )
              : FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: CustomSize().customWidth(context) * 0.045,
                      fontWeight: FontWeight.w600,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}