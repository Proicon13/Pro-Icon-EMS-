import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../Core/widgets/text_form_section.dart';
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
          TextFormSection(
            title: "Full Name",
            name: "fullName",
            hintText: "Moaid Mohamed",
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                  errorText: "Full Name is required"),
              FormBuilderValidators.minLength(3,
                  errorText: "Name must be at least 3 characters"),
            ]),
          ),
          TextFormSection(
            title: "Email",
            name: "email",
            hintText: "moaidmohamed123@gmail.com",
            keyboardInputType: TextInputType.emailAddress,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: "Email is required"),
              FormBuilderValidators.email(
                  errorText: "Enter a valid email address"),
            ]),
          ),
          const PhoneFormSection(),
        ],
      ),
    );
  }
}
