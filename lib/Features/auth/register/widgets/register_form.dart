import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/widgets/email_form_section.dart';

import '../../../../Core/widgets/fullname_form_section.dart';
import 'phone_form_section.dart';

class RegisterForm extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  const RegisterForm({
    super.key,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formKey,
      child: Column(
        children: [
          const FullNameFormSection(),
          context.setMinSize(35).verticalSpace,
          const EmailFormSection(),
          context.setMinSize(35).verticalSpace,
          const PhoneFormSection(),
        ],
      ),
    );
  }
}
