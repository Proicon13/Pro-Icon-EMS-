import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../Core/Theming/Colors/app_colors.dart';
import '../../../../Core/Theming/app_text_styles.dart';

class PhoneNumberField extends StatelessWidget {
  final String countryCode;
  final Function(String) onCountryCodeChanged;
  final String? Function(String?)? validator;
  final String? errorMessage;

  const PhoneNumberField({
    super.key,
    required this.countryCode,
    required this.onCountryCodeChanged,
    required this.validator,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5.h,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: errorMessage != null && errorMessage!.isNotEmpty
                    ? Colors.red
                    : AppColors.lightGreyColor,
                width: 1.3),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            children: [
              // Country Picker Button
              GestureDetector(
                onTap: () {
                  showCountryPicker(
                    context: context,
                    showPhoneCode: true,
                    onSelect: (Country country) {
                      onCountryCodeChanged("+${country.phoneCode}");
                    },
                  );
                },
                child: Row(
                  children: [
                    Text(
                      countryCode,
                      style: AppTextStyles.fontSize14.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              10.w.horizontalSpace, // Space between flag and line
              // Vertical Line
              Container(
                width: 1.w,
                height: 24.h,
                color: AppColors.lightGreyColor,
              ),
              10.w.horizontalSpace, // Space between line and text field
              // Text Field
              Expanded(
                child: FormBuilderTextField(
                    name: "phone",
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    style:
                        AppTextStyles.fontSize14.copyWith(color: Colors.white),
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      hintText: "1033266355",
                      hintStyle: AppTextStyles.fontSize14
                          .copyWith(color: AppColors.white71Color),
                    ),
                    validator: validator),
              ),
            ],
          ),
        ),
        errorMessage != null && errorMessage!.isNotEmpty
            ? Row(
                children: [
                  20.w.horizontalSpace,
                  Text(
                    errorMessage ?? "",
                    style: AppTextStyles.fontSize14.copyWith(color: Colors.red),
                  ),
                ],
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
