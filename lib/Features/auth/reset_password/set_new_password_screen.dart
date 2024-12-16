import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/Theming/Colors/app_colors.dart';

import 'package:pro_icon/Core/widgets/base_app_Scaffold.dart';
import 'package:pro_icon/data/models/reset_password_request_builder.dart';

import '../../../Core/Theming/app_text_styles.dart';
import '../../../Core/widgets/custom_button.dart';

import '../../../Core/widgets/pro_icon_logo.dart';

import '../register/widgets/set_password_from.dart';

class SetNewPasswordScreen extends StatefulWidget {
  static const routeName = '/set-new-password';
  const SetNewPasswordScreen({super.key});

  @override
  State<SetNewPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetNewPasswordScreen> {
  final _setNewPasswordFormKey = GlobalKey<FormBuilderState>();
  void _submitForm(BuildContext context) {
    if (_setNewPasswordFormKey.currentState?.validate() ?? false) {
      _setNewPasswordFormKey.currentState?.save();
      // get form data
      final formData = _setNewPasswordFormKey.currentState?.value;
      final password = formData!['password'];
      final confirmPassword = formData['confirmPassword'];
      if (password != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: AppColors.primaryColor,
              content: Text('Password does`t match')),
        );
      } else {
        final builder = ResetPasswordRequestBuilder();
        builder.setNewPassword(password);

        final resetPasswordRequest = builder.build();
        log('resetPasswordRequest: ${resetPasswordRequest.toString()}');
        log('builder after step 3: ${builder.toString()}');

        // handle sign up request here
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _setNewPasswordFormKey.currentState?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseAppScaffold(
      resizeToAvoidButtomPadding: true,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            90.h.verticalSpace,
            const Center(child: ProIconLogo()),
            50.h.verticalSpace,
            Text(
              "Set New Password",
              style: AppTextStyles.fontSize24.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            40.h.verticalSpace,
            SetPasswordForm(setPasswordFormKey: _setNewPasswordFormKey),
            40.h.verticalSpace,
            SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: "Confirm",
                  onPressed: () => _submitForm(context),
                )),
          ]),
        )),
      ),
    );
  }
}
