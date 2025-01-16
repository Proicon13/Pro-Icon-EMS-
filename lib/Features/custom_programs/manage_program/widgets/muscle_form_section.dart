import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pro_icon/Core/theme/app_text_styles.dart';

import '../../../../Core/widgets/custom_dropdown_section.dart';
import '../../../../Core/widgets/text_form_section.dart';

enum MuscleFormMode { value, active }

class MuscleFormSection extends StatelessWidget {
  final String muscleName; // Name of the muscle
  final int? value; // Initial value (for "value" mode)
  final bool? isActive; // Initial isActive status (for "active" mode)
  final MuscleFormMode mode; // Mode: "value" or "active"
  final void Function(dynamic newValue)? onChange; // Callback for updates

  const MuscleFormSection({
    super.key,
    required this.muscleName,
    this.value,
    this.isActive,
    required this.mode,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return mode == MuscleFormMode.value
        ? SizedBox(
            child: TextFormSection(
              title: muscleName,
              name: muscleName,
              hintText: "Enter value",
              intialValue: value?.toString(),
              keyboardInputType: TextInputType.number,
              onChanged: onChange,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                  errorText: "Value is required",
                )
              ]),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          )
        : DropdownFormSection<bool>(
            title: muscleName,
            name: muscleName,
            hintText: "Select status",
            items: [
              DropdownMenuItem(
                  value: true,
                  child: Text(
                    "Active",
                    style: AppTextStyles.fontSize16(context)
                        .copyWith(color: Colors.white),
                  )),
              DropdownMenuItem(
                  value: false,
                  child: Text("In Active",
                      style: AppTextStyles.fontSize16(context)
                          .copyWith(color: Colors.white))),
            ],
            initialValue: isActive,
            onChanged: onChange,
          );
  }
}
