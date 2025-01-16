import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class CustomDatePickerField extends StatelessWidget {
  final String name;
  final String? hintText;
  final String? Function(DateTime?)? validator;
  final Function(DateTime?)? onChanged;
  final FormFieldSetter<DateTime>? onSaved;
  final DateTime? initialValue;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final bool isDense;
  final EdgeInsets? contentPadding;
  final TextAlign? textAlign;

  const CustomDatePickerField({
    super.key,
    required this.name,
    this.hintText,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.initialValue,
    this.firstDate,
    this.lastDate,
    this.isDense = true,
    this.contentPadding,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderDateTimePicker(
      name: name,
      initialValue: initialValue,
      firstDate: firstDate ?? DateTime(1970),
      lastDate: lastDate ?? DateTime.now(),
      style: AppTextStyles.fontSize14(context).copyWith(color: Colors.white),
      textAlign: textAlign ?? TextAlign.start,
      inputType: InputType.date,
      format: DateFormat('yyyy-MM-dd'),
      decoration: InputDecoration(
        isDense: isDense,
        hintText: hintText ?? '',
        hintStyle: AppTextStyles.fontSize14(context)
            .copyWith(color: AppColors.white71Color),
        border: buildEnabledBorder(context),
        disabledBorder: buildEnabledBorder(context),
        focusedBorder: buildFocusedBorder(context),
        errorBorder: buildErrorBorder(context),
        enabledBorder: buildEnabledBorder(context),
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(
                horizontal: context.setMinSize(17),
                vertical: context.setMinSize(20)),
        errorStyle:
            AppTextStyles.fontSize14(context).copyWith(color: Colors.red),
      ),
      validator: validator,
      onChanged: onChanged ?? (value) {},
      onSaved: onSaved,
    );
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
        color: AppColors.lightGreyColor,
        width: context.setMinSize(1.6),
      ),
      borderRadius: SizeConstants.kDefaultBorderRadius(context),
    );
  }

  OutlineInputBorder buildFocusedBorder(BuildContext context) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.primaryColor,
        width: context.setMinSize(1.6),
      ),
      borderRadius: SizeConstants.kDefaultBorderRadius(context),
    );
  }
}
