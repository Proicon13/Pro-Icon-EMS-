import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/Theming/app_text_styles.dart';

import '../../../core/widgets/custom_text_field.dart';

class TextFormSection extends StatelessWidget {
  final String title;
  final String name;
  final String hintText;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  final FormFieldSetter<String>? onSaved;
  final TextInputType? keyboardInputType;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;

  const TextFormSection(
      {super.key,
      required this.title,
      required this.name,
      required this.hintText,
      this.validator,
      this.onChanged,
      this.onSaved,
      this.keyboardInputType,
      this.inputFormatters,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        title,
        style: AppTextStyles.fontSize16
            .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
      ),
      15.h.verticalSpace,
      CustomTextField(
        name: name,
        controller: controller,
        inputFormatters: inputFormatters,
        keyboardInputType: keyboardInputType,
        hintText: hintText,
        validator: validator,
        onChanged: onChanged,
        onSaved: onSaved,
      ),
    ]);
  }
}
