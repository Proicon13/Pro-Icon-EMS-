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
              title: 'Password',
              obscureText: true,
              hintText: 'Enter your password',
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                    errorText: "Password is required"),
                FormBuilderValidators.minLength(8,
                    errorText: "Password must be at least 8 characters long"),
              ]),
            ),
            TextFormSection(
              name: 'confirmPassword',
              title: 'Confirm Password',
              hintText: 'Enter your password',
              obscureText: true,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                    errorText: " Confirm Password is required"),
              ]),
            ),
          ],
        ));
  }
}
