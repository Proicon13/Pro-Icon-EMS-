import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';

import '../../../core/widgets/custom_text_field.dart';
import '../theme/app_text_styles.dart';

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
  final bool obscureText;
  final String? intialValue;

  const TextFormSection(
      {super.key,
      required this.title,
      required this.name,
      required this.hintText,
      this.intialValue,
      this.validator,
      this.onChanged,
      this.onSaved,
      this.keyboardInputType,
      this.inputFormatters,
      this.controller,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        title,
        style: AppTextStyles.fontSize16(context)
            .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
      ),
      context.setMinSize(15).verticalSpace,
      CustomTextField(
        name: name,
        intialValue: intialValue,
        controller: controller,
        inputFormatters: inputFormatters,
        keyboardInputType: keyboardInputType,
        hintText: hintText,
        validator: validator,
        onChanged: onChanged,
        onSaved: onSaved,
        obsecure: obscureText,
      ),
    ]);
  }
}
