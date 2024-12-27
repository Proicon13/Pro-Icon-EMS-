import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';

import '../../../../Core/theme/app_colors.dart';
import '../../../../Core/theme/app_text_styles.dart';

class PhoneNumberField extends StatelessWidget {
  final String countryCode;
  final Function(String) onCountryCodeChanged;
  final String? Function(String?)? validator;
  final String? errorMessage;
  final String? intialValue;

  const PhoneNumberField({
    super.key,
    required this.countryCode,
    required this.onCountryCodeChanged,
    required this.validator,
    this.errorMessage,
    this.intialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: SizeConstants.kDefaultBorderRadius(context),
            border: Border.all(
                color: errorMessage != null && errorMessage!.isNotEmpty
                    ? Colors.red
                    : AppColors.lightGreyColor,
                width: context.setMinSize(1.6)),
          ),
          padding: EdgeInsets.symmetric(
              horizontal: context.setMinSize(16),
              vertical: context.setMinSize(13)),
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
                      style: AppTextStyles.fontSize14(context).copyWith(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: Colors.white,
                      size: context.setSp(15),
                    ),
                  ],
                ),
              ),
              context
                  .setMinSize(10)
                  .horizontalSpace, // Space between flag and line
              // Vertical Line
              Container(
                width: context.setMinSize(2),
                height: context.setMinSize(30),
                color: AppColors.lightGreyColor,
              ),
              context
                  .setMinSize(10)
                  .horizontalSpace, // Space between line and text field
              // Text Field
              Expanded(
                child: FormBuilderTextField(
                    name: "phone",
                    initialValue: intialValue,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    style: AppTextStyles.fontSize14(context)
                        .copyWith(color: Colors.white),
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      hintText: "1033266355",
                      hintStyle: AppTextStyles.fontSize14(context)
                          .copyWith(color: AppColors.white71Color),
                    ),
                    validator: validator),
              ),
            ],
          ),
        ),
        context.setMinSize(5).verticalSpace,
        errorMessage != null && errorMessage!.isNotEmpty
            ? Row(
                children: [
                  context.setMinSize(20).horizontalSpace,
                  Text(
                    errorMessage ?? "",
                    style: AppTextStyles.fontSize14(context)
                        .copyWith(color: Colors.red),
                  ),
                ],
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
