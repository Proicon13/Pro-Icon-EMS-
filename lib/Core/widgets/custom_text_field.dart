import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/Theming/app_text_styles.dart';

import '../Theming/Colors/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String name;
  final String? hintText;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  final FormFieldSetter<String>? onSaved;
  final TextInputType? keyboardInputType;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final bool obsecure;

  const CustomTextField({
    super.key,
    required this.name,
    this.hintText,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.keyboardInputType,
    this.inputFormatters,
    this.controller,
    this.obsecure = false,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      obscureText: obsecure,
      controller: controller,
      inputFormatters: inputFormatters,
      keyboardType: keyboardInputType,
      style: AppTextStyles.fontSize14.copyWith(color: Colors.white),
      textInputAction: TextInputAction.next,
      cursorColor: Colors.white,
      cursorErrorColor: Colors.red,
      decoration: InputDecoration(
        hintText: hintText ?? '',
        hintStyle:
            AppTextStyles.fontSize14.copyWith(color: AppColors.white71Color),
        border: buildEnabledBorder(context),
        disabledBorder: buildEnabledBorder(context),
        focusedBorder: buildFocusedBorder(context),
        errorBorder: buildErrorBorder(context),
        enabledBorder: buildEnabledBorder(context),
        contentPadding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 15.h),
        errorStyle: AppTextStyles.fontSize14.copyWith(color: Colors.red),
      ),
      validator: validator,
      onChanged: onChanged ?? (value) {},
      onSaved: onSaved,
    );
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
}
