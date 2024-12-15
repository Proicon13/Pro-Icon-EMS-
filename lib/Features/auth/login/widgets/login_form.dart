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
        spacing: 40.h,
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

          // Password Field
          TextFormSection(
            title: "Password",
            name: "password",
            hintText: "****************",
            obscureText: true,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: "Password is required"),
              FormBuilderValidators.minLength(6,
                  errorText: "Password must be at least 6 characters long"),
            ]),
          ),
        ],
      ),
    );
  }
}
