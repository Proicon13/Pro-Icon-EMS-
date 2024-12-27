import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/widgets/password_form_section.dart';

import '../../../../Core/widgets/confirm_password_form_section.dart';

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
            const PasswordFormSection(),
            context.setMinSize(30).verticalSpace,
            const ConfirmPasswordFormSection(),
          ],
        ));
  }
}
