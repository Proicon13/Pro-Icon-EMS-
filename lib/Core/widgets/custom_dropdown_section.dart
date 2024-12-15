import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/Theming/app_text_styles.dart';
import 'package:pro_icon/Core/Theming/Colors/app_colors.dart';

class DropdownFormSection extends StatelessWidget {
  final String title;
  final String name;
  final String hintText;
  final List<DropdownMenuItem<String>> items;
  final String? Function(String?)? validator;

  const DropdownFormSection({
    super.key,
    required this.title,
    required this.name,
    required this.hintText,
    required this.items,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title Text
        Text(
          title,
          style: AppTextStyles.fontSize16.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        15.h.verticalSpace, // Space between title and dropdown
        // Dropdown Field
        FormBuilderDropdown<String>(
          name: name,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(
                color: AppColors.lightGreyColor,
                width: 1.3,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(
                color: AppColors.lightGreyColor,
                width: 1.3,
              ),
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
          ),
          items: items,
          dropdownColor: AppColors.backgroundColor,
          hint: Text(
            hintText,
            style: AppTextStyles.fontSize14.copyWith(
              color: AppColors.white71Color,
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
