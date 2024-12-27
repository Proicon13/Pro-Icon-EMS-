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
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';
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
      buildCustomAlert(
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
          vertical: context.setMinSize(20),
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

  Widget _otpSpace(BuildContext context) {
    return context.setMinSize(10).horizontalSpace;
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
          padding: SizeConstants.kBottomNavBarPadding(context),
          child: CustomButton(
            text: 'next'.tr(),
            onPressed: () => _submitOtp(context),
          ),
        ),
        body: BlocProvider<OtpCubit>(
          create: (context) => getIt<OtpCubit>(),
          child: SingleChildScrollView(
            child: Padding(
              padding: SizeConstants.kScaffoldPadding(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  context.setMinSize(90).verticalSpace,
                  const Center(child: ProIconLogo()),
                  context.setMinSize(50).h.verticalSpace,
                  Text(
                    "verification.title".tr(),
                    style: AppTextStyles.fontSize24(context).copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  context.setMinSize(25).verticalSpace,
                  Text(
                    "otp.screen.message".tr(),
                    style: AppTextStyles.fontSize14(context)
                        .copyWith(color: AppColors.white71Color),
                  ),
                  context.setMinSize(25).verticalSpace,
                  FormBuilder(
                    key: _otpFormKey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildOtpField(context, 'otp1'),
                        _otpSpace(context),
                        _buildOtpField(context, 'otp2'),
                        _otpSpace(context),
                        _buildOtpField(context, 'otp3'),
                        _otpSpace(context),
                        _buildOtpField(context, 'otp4'),
                        _otpSpace(context),
                        _buildOtpField(context, 'otp5'),
                        _otpSpace(context),
                        _buildOtpField(context, 'otp6'),
                      ],
                    ),
                  ),
                  context.setMinSize(20).verticalSpace,
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "otp.screen.didn'tReceive".tr(),
                          style: AppTextStyles.fontSize14(context)
                              .copyWith(color: Colors.white),
                        ),
                        context.setMinSize(5).horizontalSpace,
                        BlocConsumer<OtpCubit, OtpState>(
                          listener: (context, state) {
                            if (state.resendOtpStatus ==
                                ResendOtpStatus.success) {
                              buildCustomAlert(context,
                                  state.resendCodeMessage!, Colors.green);
                            }
                            if (state.resendOtpStatus ==
                                ResendOtpStatus.error) {
                              buildCustomAlert(context,
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
                                style:
                                    AppTextStyles.fontSize14(context).copyWith(
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
