import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Core/Theming/app_text_styles.dart';
import 'phone_form_field.dart';

class PhoneFormSection extends StatelessWidget {
  const PhoneFormSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Phone Number",
          style: AppTextStyles.fontSize16
              .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        15.h.verticalSpace,
        PhoneNumberField(
          controller: TextEditingController(),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Phone number is required";
            }
            if (!RegExp(r'^[0-9]{11}$').hasMatch(value)) {
              return "Enter a valid 11-digit phone number";
            }
            return null;
          },
        ),
      ],
    );
  }
}
