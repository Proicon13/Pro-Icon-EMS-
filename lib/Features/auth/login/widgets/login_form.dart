import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';

import '../../../../Core/widgets/email_form_section.dart';
import '../../../../Core/widgets/password_form_section.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  const LoginForm({
    super.key,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formKey,
      child: Column(
        children: [
          const EmailFormSection(),
          context.setMinSize(40).verticalSpace,
          const PasswordFormSection(),
        ],
      ),
    );
  }
}
