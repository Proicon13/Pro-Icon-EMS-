import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../Core/Theming/Colors/app_colors.dart';
import '../../../../Core/Theming/app_text_styles.dart';

class PhoneNumberField extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const PhoneNumberField({
    super.key,
    this.controller,
    this.validator,
  });

  @override
  State<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  String _countryCode = "+20"; // Default country code (Egypt)

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.lightGreyColor, width: 1.3),
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
                  setState(() {
                    _countryCode = "+${country.phoneCode}";
                  });
                },
              );
            },
            child: Row(
              children: [
                Text(
                  _countryCode,
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
            child: TextFormField(
              controller: widget.controller,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(11),
              ],
              style: AppTextStyles.fontSize14.copyWith(color: Colors.white),
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none, // No internal borders
                hintText: "1033266355", // Placeholder
                hintStyle: AppTextStyles.fontSize14
                    .copyWith(color: AppColors.white71Color),
              ),
              validator: widget.validator,
            ),
          ),
        ],
      ),
    );
  }
}
