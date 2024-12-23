import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/dependencies.dart';
import 'package:pro_icon/Core/widgets/base_app_Scaffold.dart';
import 'package:pro_icon/Core/widgets/keyboard_dismissable.dart';
import 'package:pro_icon/Core/widgets/pro_icon_logo.dart';
import 'package:pro_icon/Features/auth/login/screens/login_screen.dart';
import 'package:pro_icon/Features/auth/register/cubits/register_cubit.dart';
import 'package:pro_icon/Features/auth/register/screens/admin_address_screen.dart';
import 'package:pro_icon/data/models/sign_up_request_builder.dart';

import '../../../../Core/theme/app_text_styles.dart';
import '../../../../Core/widgets/custom_button.dart';
import '../../../../Core/widgets/have_account_row.dart';
import '../widgets/register_form.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/sign-up';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormBuilderState> _registerFormKey =
      GlobalKey<FormBuilderState>();
  void _submitForm(BuildContext context, String phoneCode) {
    if (_registerFormKey.currentState?.validate() ?? false) {
      _registerFormKey.currentState?.save();
      // handle register logic
      final builder = SignupRequestBuilder();

      final fullName = _registerFormKey.currentState?.fields['fullName']?.value;
      final email = _registerFormKey.currentState?.fields['email']?.value;
      final phone = _registerFormKey.currentState?.fields['phone']?.value;

      builder
          .setFullname(fullName)
          .setEmail(email)
          .setPhone("$phoneCode$phone");

      log("Builder after Step 1: ${builder.toString()}");
      Navigator.pushNamed(context, AdminAddressScreen.routeName);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _registerFormKey.currentState?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterCubit>(
      create: (_) => getIt<RegisterCubit>(),
      child: KeyboardDismissable(
        child: BaseAppScaffold(
          resizeToAvoidButtomPadding: true,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  90.h.verticalSpace,
                  const Center(child: ProIconLogo()),
                  50.h.verticalSpace,
                  Text(
                    "signup".tr(),
                    style: AppTextStyles.fontSize24.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  40.h.verticalSpace,
                  RegisterForm(
                    formKey: _registerFormKey,
                  ),
                  40.h.verticalSpace,
                  SizedBox(
                    width: double.infinity,
                    child: BlocSelector<RegisterCubit, RegisterState, String>(
                      selector: (state) => state.phoneCode!,
                      builder: (context, state) {
                        return CustomButton(
                          text: "Next",
                          onPressed: () => _submitForm(context, state),
                        );
                      },
                    ),
                  ),
                  15.h.verticalSpace,
                  HaveAccountRow(
                    action: "signin".tr(),
                    title: "haveAccount.title".tr(),
                    onAction: () =>
                        Navigator.pushNamed(context, LoginScreen.routeName),
                  ),
                  30.h.verticalSpace,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
