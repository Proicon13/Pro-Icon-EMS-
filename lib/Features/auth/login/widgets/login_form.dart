import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../Core/widgets/text_form_section.dart';

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
          TextFormSection(
            title: "Email",
            name: "email",
            hintText: "someone@gmail.com",
            keyboardInputType: TextInputType.emailAddress,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: "Email is required"),
              FormBuilderValidators.email(
                  errorText: "Enter a valid email address"),
            ]),
          ),
          40.h.verticalSpace,
          // Password Field
          TextFormSection(
            title: "Password",
            name: "password",
            hintText: "****************",
            obscureText: true,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: "Password is required"),
              FormBuilderValidators.minLength(8,
                  errorText: "Password must be at least 8 characters long"),
            ]),
          ),
        ],
      ),
    );
  }
}
