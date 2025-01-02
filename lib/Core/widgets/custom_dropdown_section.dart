import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/theme/app_colors.dart';
import 'package:pro_icon/Core/theme/app_text_styles.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';

class DropdownFormSection<T> extends StatelessWidget {
  final String title;
  final String name;
  final String hintText;
  final List<DropdownMenuItem<T>> items; // List of generic items

  final String? Function(T?)? validator;
  final T? initialValue; // Initial value as a string (e.g., name)
  final void Function(T?)? onChanged;

  const DropdownFormSection({
    super.key,
    required this.title,
    required this.name,
    required this.hintText,
    required this.items,
    this.validator,
    this.initialValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title Text
        Text(
          title,
          style: AppTextStyles.fontSize16(context).copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        context
            .setMinSize(10)
            .verticalSpace, // Space between title and dropdown
        // Dropdown Field
        FormBuilderDropdown<T>(
          name: name,
          key: ValueKey(name),
          onChanged: onChanged,
          initialValue: initialValue ?? null,
          decoration: InputDecoration(
            errorStyle:
                AppTextStyles.fontSize14(context).copyWith(color: Colors.red),
            isDense: true,
            border: buildEnabledBorder(context),
            disabledBorder: buildEnabledBorder(context),
            focusedBorder: buildFocusedBorder(context),
            errorBorder: buildErrorBorder(context),
            enabledBorder: buildEnabledBorder(context),
            contentPadding: EdgeInsets.symmetric(
              horizontal: context.setMinSize(12),
              vertical: context.setMinSize(20),
            ),
          ),
          items: items,
          dropdownColor: AppColors.backgroundColor,
          style:
              AppTextStyles.fontSize16(context).copyWith(color: Colors.white),
          hint: Text(
            hintText,
            style: AppTextStyles.fontSize14(context).copyWith(
              color: AppColors.white71Color,
            ),
          ),
          validator: (value) => validator?.call(value),
        ),
      ],
    );
  }
}

OutlineInputBorder buildErrorBorder(BuildContext context) {
  return OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.red,
      width: context.setMinSize(1.6),
    ),
    borderRadius: SizeConstants.kDefaultBorderRadius(context),
  );
}

OutlineInputBorder buildEnabledBorder(BuildContext context) {
  return OutlineInputBorder(
    borderSide: BorderSide(
        color: AppColors.lightGreyColor, width: context.setMinSize(1.6)),
    borderRadius: SizeConstants.kDefaultBorderRadius(context),
  );
}

OutlineInputBorder buildFocusedBorder(BuildContext context) {
  return OutlineInputBorder(
    borderSide: BorderSide(
        color: AppColors.primaryColor, width: context.setMinSize(1.6)),
    borderRadius: SizeConstants.kDefaultBorderRadius(context),
  );
}
