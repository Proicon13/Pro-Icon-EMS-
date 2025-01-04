import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../theme/app_text_styles.dart';
import '../utils/enums/gender.dart';
import 'custom_dropdown_section.dart';

class GenderFormSection extends StatelessWidget {
  final String? name;
  final Gender? intialValue;
  const GenderFormSection({
    super.key,
    this.name,
    this.intialValue,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownFormSection<Gender>(
      title: "gender".tr(),
      name: name ?? "gender",
      hintText: "Select Gender",
      initialValue: intialValue ?? Gender.male,
      items: Gender.values
          .map((gender) => DropdownMenuItem<Gender>(
                value: gender,
                child: Text(
                  gender.name,
                  style: AppTextStyles.fontSize14(context).copyWith(
                    color: Colors.white,
                  ),
                ),
              ))
          .toList(),
    );
  }
}
