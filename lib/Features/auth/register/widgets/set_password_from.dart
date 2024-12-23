import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../Core/widgets/text_form_section.dart';

class SetPasswordForm extends StatelessWidget {
  const SetPasswordForm({
    super.key,
    required GlobalKey<FormBuilderState> setPasswordFormKey,
  }) : _setPasswordFormKey = setPasswordFormKey;

  final GlobalKey<FormBuilderState> _setPasswordFormKey;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
        key: _setPasswordFormKey,
        child: Column(
          children: [
            TextFormSection(
              name: 'password',
              title: 'setPasswordForm.passwordTitle'.tr(),
              obscureText: true,
              hintText: 'setPasswordForm.passwordHint'.tr(),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                    errorText: "setPasswordForm.passwordRequiredError".tr()),
                FormBuilderValidators.minLength(8,
                    errorText: "setPasswordForm.passwordMinLengthError".tr()),
              ]),
            ),
            30.h.verticalSpace,
            TextFormSection(
              name: 'confirmPassword',
              title: 'setPasswordForm.confirmPasswordTitle'
                  .tr(), // "Confirm Password"
              hintText: 'setPasswordForm.passwordHint'.tr(),
              obscureText: true,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                    errorText:
                        "setPasswordForm.confirmPasswordRequiredError".tr()),
              ]),
            ),
          ],
        ));
  }
}
