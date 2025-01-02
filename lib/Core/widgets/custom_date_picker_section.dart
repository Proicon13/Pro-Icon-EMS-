import 'package:flutter/material.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';

import '../theme/app_text_styles.dart';
import 'custom_date_picker_field.dart';

class DatePickerFormSection extends StatelessWidget {
  final String title;
  final String name;
  final String hintText;
  final String? Function(DateTime?)? validator;
  final Function(DateTime?)? onChanged;
  final FormFieldSetter<DateTime>? onSaved;
  final DateTime? initialValue;
  final DateTime? firstDate;
  final DateTime? lastDate;

  const DatePickerFormSection({
    super.key,
    required this.title,
    required this.name,
    required this.hintText,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.initialValue,
    this.firstDate,
    this.lastDate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.fontSize16(context)
              .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        context.setMinSize(15).verticalSpace,
        CustomDatePickerField(
          name: name,
          hintText: hintText,
          initialValue: initialValue,
          firstDate: firstDate,
          lastDate: lastDate,
          validator: validator,
          onChanged: onChanged,
          onSaved: onSaved,
        ),
      ],
    );
  }
}
