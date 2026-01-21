// lib/view/children/create_edit_child_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/components/custom_button.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import 'package:speechspectrum/controllers/child_controller.dart';
import 'package:speechspectrum/models/child_model.dart';

class CreateEditChildScreen extends StatefulWidget {
  const CreateEditChildScreen({super.key});

  @override
  State<CreateEditChildScreen> createState() => _CreateEditChildScreenState();
}

class _CreateEditChildScreenState extends State<CreateEditChildScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _dateController;

  late ChildController controller;

  String selectedGender = 'male';
  DateTime? selectedDate;
  ChildData? existingChild;
  bool isEditMode = false;

  @override
  void initState() {
    super.initState();
    
    // Get existing controller or create new one
    if (Get.isRegistered<ChildController>()) {
      controller = Get.find<ChildController>();
    } else {
      controller = Get.put(ChildController());
    }
    
    existingChild = Get.arguments as ChildData?;
    isEditMode = existingChild != null;

    _nameController = TextEditingController(text: existingChild?.childName ?? '');
    _dateController = TextEditingController(
      text: existingChild?.getFormattedDate() ?? '',
    );

    if (existingChild != null) {
      selectedGender = existingChild!.gender.toLowerCase();
      try {
        selectedDate = DateTime.parse(existingChild!.dateOfBirth);
      } catch (e) {
        selectedDate = null;
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.25,
            pinned: true,
            elevation: 0,
            backgroundColor: AppColors.primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              background: _buildHeader(context),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.whiteColor),
              onPressed: () => Get.back(),
            ),
          ),

          // Form Content
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Info Card
                    Container(
                      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryColor.withOpacity(0.1),
                            AppColors.secondaryColor.withOpacity(0.05),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: AppColors.primaryColor.withOpacity(0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.info_outline,
                            color: AppColors.primaryColor,
                            size: 24,
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                          Expanded(
                            child: Text(
                              isEditMode
                                  ? 'Update your child\'s information below'
                                  : 'Add your child\'s details to create their profile',
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.width * 0.035,
                                color: AppColors.textPrimaryColor,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                    // Child Name Field
                    Text(
                      'Child Name',
                      style: GoogleFonts.poppins(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimaryColor,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    _buildTextField(
                      context: context,
                      controller: _nameController,
                      hintText: 'Enter child\'s full name',
                      icon: Icons.person_outline,
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return 'Child name is required';
                        }
                        if (val.trim().length < 2) {
                          return 'Name must be at least 2 characters';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.025),

                    // Date of Birth Field
                    Text(
                      'Date of Birth',
                      style: GoogleFonts.poppins(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimaryColor,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    _buildDateField(context),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.025),

                    // Gender Selection
                    Text(
                      'Gender',
                      style: GoogleFonts.poppins(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimaryColor,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                    _buildGenderSelector(context),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),

                    // Submit Button
                    Obx(() => CustomButton(
                          title: isEditMode ? 'Update Profile' : 'Create Profile',
                          height: MediaQuery.of(context).size.height * 0.065,
                          width: double.infinity,
                          radius: 15,
                          color: AppColors.primaryColor,
                          loading: isEditMode
                              ? controller.isUpdating.value
                              : controller.isCreating.value,
                          onTap: _handleSubmit,
                        )),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryColor, AppColors.secondaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isEditMode ? Icons.edit_rounded : Icons.add_circle_outline_rounded,
                  size: 45,
                  color: AppColors.whiteColor,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              Text(
                isEditMode ? 'Edit Child Profile' : 'Add New Child',
                style: GoogleFonts.poppins(
                  color: AppColors.whiteColor,
                  fontSize: MediaQuery.of(context).size.width * 0.055,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.005),
              Text(
                isEditMode
                    ? 'Update your child\'s information'
                    : 'Create a profile for your child',
                style: GoogleFonts.poppins(
                  color: AppColors.whiteColor.withOpacity(0.9),
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required BuildContext context,
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      cursorColor: AppColors.primaryColor,
      style: GoogleFonts.poppins(
        fontSize: MediaQuery.of(context).size.width * 0.04,
        color: AppColors.textPrimaryColor,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: AppColors.primaryColor),
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
          fontSize: MediaQuery.of(context).size.width * 0.04,
          color: AppColors.greyColor,
        ),
        filled: true,
        fillColor: AppColors.whiteColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: AppColors.errorColor, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: AppColors.errorColor, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.02,
          horizontal: MediaQuery.of(context).size.width * 0.04,
        ),
      ),
    );
  }

  Widget _buildDateField(BuildContext context) {
    return TextFormField(
      controller: _dateController,
      readOnly: true,
      onTap: () => _selectDate(context),
      validator: (val) =>
          val == null || val.trim().isEmpty ? 'Date of birth is required' : null,
      cursorColor: AppColors.primaryColor,
      style: GoogleFonts.poppins(
        fontSize: MediaQuery.of(context).size.width * 0.04,
        color: AppColors.textPrimaryColor,
      ),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.cake_outlined, color: AppColors.primaryColor),
        suffixIcon: const Icon(Icons.calendar_today, color: AppColors.primaryColor),
        hintText: 'Select date of birth',
        hintStyle: GoogleFonts.poppins(
          fontSize: MediaQuery.of(context).size.width * 0.04,
          color: AppColors.greyColor,
        ),
        filled: true,
        fillColor: AppColors.whiteColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: AppColors.errorColor, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: AppColors.errorColor, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.02,
          horizontal: MediaQuery.of(context).size.width * 0.04,
        ),
      ),
    );
  }

  Widget _buildGenderSelector(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildGenderOption(
            context: context,
            label: 'Male',
            value: 'male',
            icon: Icons.boy,
            color: Colors.blue,
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.04),
        Expanded(
          child: _buildGenderOption(
            context: context,
            label: 'Female',
            value: 'female',
            icon: Icons.girl,
            color: Colors.pink,
          ),
        ),
      ],
    );
  }

  Widget _buildGenderOption({
    required BuildContext context,
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    final isSelected = selectedGender.toLowerCase() == value.toLowerCase();

    return GestureDetector(
      onTap: () => setState(() => selectedGender = value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.02,
        ),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.15) : AppColors.whiteColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? color : AppColors.greyColor.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 45,
              color: isSelected ? color : AppColors.greyColor,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: MediaQuery.of(context).size.width * 0.04,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? color : AppColors.textSecondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now().subtract(const Duration(days: 365 * 3)),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryColor,
              onPrimary: AppColors.whiteColor,
              onSurface: AppColors.textPrimaryColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        final months = [
          'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
          'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
        ];
        _dateController.text =
            '${months[picked.month - 1]} ${picked.day}, ${picked.year}';
      });
    }
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      if (selectedDate == null) {
        Get.snackbar(
          'Validation Error',
          'Please select date of birth',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.errorColor,
          colorText: AppColors.whiteColor,
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
          duration: const Duration(seconds: 3),
        );
        return;
      }

      final formattedDate =
          '${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}';

      if (isEditMode && existingChild != null) {
        controller.updateChild(
          childId: existingChild!.childId,
          childName: _nameController.text.trim(),
          dateOfBirth: formattedDate,
          gender: selectedGender.toLowerCase(),
        );
      } else {
        controller.createChild(
          childName: _nameController.text.trim(),
          dateOfBirth: formattedDate,
          gender: selectedGender.toLowerCase(),
        );
      }
    }
  }
}