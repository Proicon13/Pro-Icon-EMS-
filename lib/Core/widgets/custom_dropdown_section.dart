import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/theme/app_colors.dart';
import 'package:pro_icon/Core/theme/app_text_styles.dart';

class DropdownFormSection extends StatelessWidget {
  final String title;
  final String name;
  final String hintText;
  final List<DropdownMenuItem<String>> items;
  final String? Function(String?)? validator;
  final String? initialValue;

  const DropdownFormSection({
    super.key,
    required this.title,
    required this.name,
    required this.hintText,
    required this.items,
    this.validator,
    this.initialValue,
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
          initialValue: initialValue,
          decoration: InputDecoration(
            border: buildEnabledBorder(context),
            disabledBorder: buildEnabledBorder(context),
            focusedBorder: buildFocusedBorder(context),
            errorBorder: buildErrorBorder(context),
            enabledBorder: buildEnabledBorder(context),
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

OutlineInputBorder buildErrorBorder(BuildContext context) {
  return const OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.red,
      width: 1.3,
    ),
    borderRadius: BorderRadius.all(Radius.circular(8)),
  );
}

OutlineInputBorder buildEnabledBorder(BuildContext context) {
  return const OutlineInputBorder(
    borderSide: BorderSide(
      color: AppColors.lightGreyColor,
      width: 1.3,
    ),
    borderRadius: BorderRadius.all(Radius.circular(8)),
  );
}

OutlineInputBorder buildFocusedBorder(BuildContext context) {
  return const OutlineInputBorder(
    borderSide: BorderSide(
      color: AppColors.primaryColor,
      width: 1.3,
    ),
    borderRadius: BorderRadius.all(Radius.circular(8)),
  );
}
