import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Features/auth/register/cubit/cubit/register_cubit.dart';

import '../../../../Core/Theming/app_text_styles.dart';
import 'phone_form_field.dart';

class PhoneFormSection extends StatelessWidget {
  const PhoneFormSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Phone Number",
          style: AppTextStyles.fontSize16
              .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        15.h.verticalSpace,
        BlocBuilder<RegisterCubit, RegisterState>(
          builder: (context, state) {
            return PhoneNumberField(
              countryCode: state.phoneCode!,
              errorMessage: state.errorMessage,
              validator: (phone) {
                if (phone == null) {
                  BlocProvider.of<RegisterCubit>(context, listen: false)
                      .setErrorMessage('Phone number is required');
                } else if (phone.length < 10) {
                  BlocProvider.of<RegisterCubit>(context, listen: false)
                      .setErrorMessage(
                          'Phone number is cannot be smaller than 10 digits');
                } else {
                  BlocProvider.of<RegisterCubit>(context, listen: false)
                      .setErrorMessage('');
                }
                return null;
              },
              onCountryCodeChanged: (phoneCode) {
                BlocProvider.of<RegisterCubit>(context, listen: false)
                    .setCountryCode(phoneCode);
              },
            );
          },
        ),
      ],
    );
  }
}
