import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pro_icon/Core/theme/app_colors.dart';
import 'package:pro_icon/Core/theme/app_text_styles.dart';
import 'package:pro_icon/Core/widgets/base_app_Scaffold.dart';
import 'package:pro_icon/Core/widgets/custom_button.dart';
import 'package:pro_icon/Core/widgets/custom_snack_bar.dart';
import 'package:pro_icon/Core/widgets/custom_text_field.dart';
import 'package:pro_icon/Core/widgets/keyboard_dismissable.dart';
import 'package:pro_icon/Core/widgets/pro_icon_logo.dart';
import 'package:pro_icon/Features/auth/reset_password/cubits/otp/otp_cubit.dart';
import 'package:pro_icon/Features/auth/reset_password/screens/set_new_password_screen.dart';

import '../../../../Core/dependencies.dart';
import '../../../../data/models/reset_password_request_builder.dart';

class OtpScreen extends StatefulWidget {
  static const String routeName = '/otp-screen';
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _otpFormKey = GlobalKey<FormBuilderState>();

  void _submitOtp(BuildContext context) {
    if (_otpFormKey.currentState?.saveAndValidate() ?? false) {
      // Retrieve all OTP digits
      final formData = _otpFormKey.currentState?.value;
      final otpCode = formData!.entries
          .map((entry) => entry.value) // Combine all digit inputs
          .join();

      if (otpCode.length == 6) {
        // set the otp code
        final builder = ResetPasswordRequestBuilder();
        builder.setResetCode(otpCode);
        // navigate to next screen
        Navigator.pushReplacementNamed(context, SetNewPasswordScreen.routeName);
        log("OTP Code: $otpCode");
      }
    } else {
      // Validation failed
      buildCustomSnackBar(
          context, "otp.screen.validationMessage".tr(), Colors.red);
    }
  }

  Widget _buildOtpField(BuildContext context, String fieldName) {
    return Expanded(
      child: CustomTextField(
        name: fieldName,
        textAlign: TextAlign.center,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
          vertical: 20.h,
        ),
        keyboardInputType: TextInputType.number,
        errorTextStyle: const TextStyle(
          height: 0,
          fontSize: 0,
        ),
        errorMaxLines: 1,
        inputFormatters: [
          // Only allow a single digit
          LengthLimitingTextInputFormatter(1),
        ],
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(errorText: ""),
        ]),
        onChanged: (value) {
          if (value?.isNotEmpty ?? false) {
            FocusScope.of(context).nextFocus(); // Move to next field
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _otpFormKey.currentState?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissable(
      child: BaseAppScaffold(
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
          child: SizedBox(
            width: double.infinity,
            child: CustomButton(
              text: 'next'.tr(),
              onPressed: () => _submitOtp(context),
            ),
          ),
        ),
        body: BlocProvider<OtpCubit>(
          create: (context) => getIt<OtpCubit>(),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  90.h.verticalSpace,
                  const Center(child: ProIconLogo()),
                  50.h.verticalSpace,
                  Text(
                    "verification.title".tr(),
                    style: AppTextStyles.fontSize24.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  25.h.verticalSpace,
                  Text(
                    "otp.screen.message".tr(),
                    style: AppTextStyles.fontSize14
                        .copyWith(color: AppColors.white71Color),
                  ),
                  70.h.verticalSpace,
                  FormBuilder(
                    key: _otpFormKey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildOtpField(context, 'otp1'),
                        10.w.horizontalSpace,
                        _buildOtpField(context, 'otp2'),
                        10.w.horizontalSpace,
                        _buildOtpField(context, 'otp3'),
                        10.w.horizontalSpace,
                        _buildOtpField(context, 'otp4'),
                        10.w.horizontalSpace,
                        _buildOtpField(context, 'otp5'),
                        10.w.horizontalSpace,
                        _buildOtpField(context, 'otp6'),
                      ],
                    ),
                  ),
                  30.h.verticalSpace,
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "otp.screen.didn'tReceive".tr(),
                          style: AppTextStyles.fontSize14
                              .copyWith(color: Colors.white),
                        ),
                        5.w.horizontalSpace,
                        BlocConsumer<OtpCubit, OtpState>(
                          listener: (context, state) {
                            if (state.resendOtpStatus ==
                                ResendOtpStatus.success) {
                              buildCustomSnackBar(context,
                                  state.resendCodeMessage!, Colors.green);
                            }
                            if (state.resendOtpStatus ==
                                ResendOtpStatus.error) {
                              buildCustomSnackBar(context,
                                  state.resendCodeMessage!, Colors.red);
                            }
                          },
                          buildWhen: (previous, current) =>
                              previous.resendOtpStatus !=
                              current.resendOtpStatus,
                          builder: (context, state) {
                            return GestureDetector(
                              onTap: () {
                                // make request to email to resend code
                                BlocProvider.of<OtpCubit>(context,
                                        listen: false)
                                    .resendCode();
                              },
                              child: Text(
                                "otp.screen.resendLabel".tr(),
                                style: AppTextStyles.fontSize14.copyWith(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
