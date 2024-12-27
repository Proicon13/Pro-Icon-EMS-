import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/cubits/phone_registration/phone_register_cubit.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';

import '../../../../Core/theme/app_text_styles.dart';
import 'phone_form_field.dart';

class PhoneFormSection extends StatelessWidget {
  final String? intialValue;
  final bool? isFieldNotRequired;
  const PhoneFormSection(
      {super.key, this.intialValue, this.isFieldNotRequired});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "signup.phone".tr(),
          style: AppTextStyles.fontSize16(context)
              .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        context.setMinSize(15).verticalSpace,
        BlocBuilder<PhoneRegistrationCubit, PhoneRegistrationState>(
          builder: (context, state) {
            return PhoneNumberField(
              countryCode: state.phoneCode!,
              errorMessage: state.errorMessage,
              intialValue: intialValue,
              validator: isFieldNotRequired != null
                  ? null
                  : (phone) {
                      if (phone == null) {
                        BlocProvider.of<PhoneRegistrationCubit>(context,
                                listen: false)
                            .setErrorMessage(
                          "register.phoneRequired".tr(),
                        );
                      } else if (phone.length < 10) {
                        BlocProvider.of<PhoneRegistrationCubit>(context,
                                listen: false)
                            .setErrorMessage("register.phoneInvalid".tr());
                      } else {
                        BlocProvider.of<PhoneRegistrationCubit>(context,
                                listen: false)
                            .setErrorMessage('');
                      }
                      return null;
                    },
              onCountryCodeChanged: (phoneCode) {
                BlocProvider.of<PhoneRegistrationCubit>(context, listen: false)
                    .setCountryCode(phoneCode);
              },
            );
          },
        ),
      ],
    );
  }
}
