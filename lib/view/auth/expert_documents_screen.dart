// view/auth/expert_documents_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import '../../controllers/registration_controller.dart';
import '../../routes/app_routes.dart';
import '../../constants/app_colors.dart';
import '../../constants/custom_size.dart';

class ExpertDocumentsScreen extends StatefulWidget {
  const ExpertDocumentsScreen({super.key});

  @override
  State<ExpertDocumentsScreen> createState() => _ExpertDocumentsScreenState();
}

class _ExpertDocumentsScreenState extends State<ExpertDocumentsScreen> {
  final RegistrationController regController = Get.find();
  final ImagePicker _imagePicker = ImagePicker();

  File? _profileImage;
  File? _degreeDocument;
  File? _certificateDocument;

  String? _profileImageName;
  String? _degreeDocName;
  String? _certificateDocName;

  bool _isUploading = false;

  Future<void> _pickProfileImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          _profileImage = File(image.path);
          _profileImageName = image.name;
        });
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick image: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.errorColor,
        colorText: AppColors.whiteColor,
      );
    }
  }

  Future<void> _pickDocument(bool isDegree) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.single.path != null) {
        setState(() {
          if (isDegree) {
            _degreeDocument = File(result.files.single.path!);
            _degreeDocName = result.files.single.name;
          } else {
            _certificateDocument = File(result.files.single.path!);
            _certificateDocName = result.files.single.name;
          }
        });
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick document: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.errorColor,
        colorText: AppColors.whiteColor,
      );
    }
  }

  Future<void> _uploadDocumentsAndContinue() async {
    // Validate all documents are selected
    if (_profileImage == null) {
      Get.snackbar(
        'Missing Document',
        'Please select a profile image',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.warningColor,
        colorText: AppColors.whiteColor,
      );
      return;
    }

    if (_degreeDocument == null) {
      Get.snackbar(
        'Missing Document',
        'Please select your degree document',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.warningColor,
        colorText: AppColors.whiteColor,
      );
      return;
    }

    if (_certificateDocument == null) {
      Get.snackbar(
        'Missing Document',
        'Please select your certificate document',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.warningColor,
        colorText: AppColors.whiteColor,
      );
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      // Upload all documents
      final success = await regController.uploadExpertDocuments(
        profileImage: _profileImage!,
        degreeDoc: _degreeDocument!,
        certificateDoc: _certificateDocument!,
      );

      setState(() {
        _isUploading = false;
      });

      if (success) {
        Get.toNamed(AppRoutes.signup);
      }
    } catch (e) {
      setState(() {
        _isUploading = false;
      });
      Get.snackbar(
        'Upload Failed',
        'Failed to upload documents. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.errorColor,
        colorText: AppColors.whiteColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.blackColor),
          onPressed: () => Get.back(),
        ),
        title: Column(
          children: [
            SizedBox(height: size.customHeight(context) * 0.025),
            LinearProgressIndicator(
              value: 5 / 6,
              backgroundColor: AppColors.greyColor.withOpacity(0.3),
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
              minHeight: size.customHeight(context) * 0.008,
            ),
            SizedBox(height: size.customHeight(context) * 0.008),
            Text(
              'STEP 5/6',
              style: GoogleFonts.poppins(
                fontSize: size.customWidth(context) * 0.03,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: size.customWidth(context) * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.customHeight(context) * 0.03),

              /// Title
              Center(
                child: Text(
                  'Upload Documents',
                  style: GoogleFonts.poppins(
                    fontSize: size.customWidth(context) * 0.06,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimaryColor,
                  ),
                ),
              ),

              SizedBox(height: size.customHeight(context) * 0.01),

              /// Subtitle
              Center(
                child: Text(
                  'Please upload your profile image and credentials',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: size.customWidth(context) * 0.038,
                    color: AppColors.textSecondaryColor,
                  ),
                ),
              ),

              SizedBox(height: size.customHeight(context) * 0.04),

              /// Profile Image Upload
              _buildImageUploadSection(context, size),

              SizedBox(height: size.customHeight(context) * 0.03),

              /// Degree Document Upload
              _buildDocumentUploadCard(
                context: context,
                size: size,
                title: 'Degree Document',
                subtitle: 'Upload your degree certificate (PDF only)',
                icon: Icons.school_outlined,
                fileName: _degreeDocName,
                onTap: () => _pickDocument(true),
              ),

              SizedBox(height: size.customHeight(context) * 0.02),

              /// Certificate Document Upload
              _buildDocumentUploadCard(
                context: context,
                size: size,
                title: 'Certificate Document',
                subtitle: 'Upload your professional certificate (PDF only)',
                icon: Icons.card_membership_outlined,
                fileName: _certificateDocName,
                onTap: () => _pickDocument(false),
              ),

              SizedBox(height: size.customHeight(context) * 0.05),

              /// Upload and Continue Button
              SizedBox(
                width: double.infinity,
                height: size.customHeight(context) * 0.065,
                child: ElevatedButton(
                  onPressed: _isUploading ? null : _uploadDocumentsAndContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    disabledBackgroundColor: AppColors.greyColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(size.customHeight(context) * 0.2),
                    ),
                    elevation: 3,
                  ),
                  child: _isUploading
                      ? SizedBox(
                          height: size.customHeight(context) * 0.03,
                          width: size.customHeight(context) * 0.03,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(AppColors.whiteColor),
                          ),
                        )
                      : Text(
                          'Upload & Continue',
                          style: GoogleFonts.poppins(
                            fontSize: size.customWidth(context) * 0.045,
                            fontWeight: FontWeight.w600,
                            color: AppColors.whiteColor,
                          ),
                        ),
                ),
              ),

              SizedBox(height: size.customHeight(context) * 0.03),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageUploadSection(BuildContext context, CustomSize size) {
    return Center(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(size.customWidth(context) * 0.05),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(size.customHeight(context) * 0.02),
          boxShadow: [
            BoxShadow(
              color: AppColors.greyColor.withOpacity(0.15),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              'Profile Image',
              style: GoogleFonts.poppins(
                fontSize: size.customWidth(context) * 0.045,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimaryColor,
              ),
            ),
            SizedBox(height: size.customHeight(context) * 0.02),
            GestureDetector(
              onTap: _pickProfileImage,
              child: Container(
                height: size.customHeight(context) * 0.15,
                width: size.customHeight(context) * 0.15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryColor.withOpacity(0.1),
                  border: Border.all(
                    color: AppColors.primaryColor,
                    width: 2,
                  ),
                ),
                child: _profileImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(size.customHeight(context) * 0.15),
                        child: Image.file(
                          _profileImage!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Icon(
                        Icons.add_a_photo_outlined,
                        size: size.customHeight(context) * 0.05,
                        color: AppColors.primaryColor,
                      ),
              ),
            ),
            SizedBox(height: size.customHeight(context) * 0.015),
            Text(
              _profileImageName ?? 'Tap to select image',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: size.customWidth(context) * 0.035,
                color: _profileImageName != null
                    ? AppColors.successColor
                    : AppColors.textSecondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentUploadCard({
    required BuildContext context,
    required CustomSize size,
    required String title,
    required String subtitle,
    required IconData icon,
    required String? fileName,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(size.customHeight(context) * 0.02),
      child: Container(
        padding: EdgeInsets.all(size.customWidth(context) * 0.04),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(size.customHeight(context) * 0.02),
          border: Border.all(
            color: fileName != null
                ? AppColors.successColor
                : AppColors.greyColor.withOpacity(0.3),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.greyColor.withOpacity(0.15),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(size.customWidth(context) * 0.03),
              decoration: BoxDecoration(
                color: fileName != null
                    ? AppColors.successColor.withOpacity(0.1)
                    : AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(size.customHeight(context) * 0.015),
              ),
              child: Icon(
                fileName != null ? Icons.check_circle_outline : icon,
                color: fileName != null ? AppColors.successColor : AppColors.primaryColor,
                size: size.customHeight(context) * 0.04,
              ),
            ),
            SizedBox(width: size.customWidth(context) * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: size.customWidth(context) * 0.04,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimaryColor,
                    ),
                  ),
                  SizedBox(height: size.customHeight(context) * 0.005),
                  Text(
                    fileName ?? subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: size.customWidth(context) * 0.032,
                      color: fileName != null
                          ? AppColors.successColor
                          : AppColors.textSecondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.upload_file_outlined,
              color: AppColors.primaryColor,
              size: size.customHeight(context) * 0.03,
            ),
          ],
        ),
      ),
    );
  }
}