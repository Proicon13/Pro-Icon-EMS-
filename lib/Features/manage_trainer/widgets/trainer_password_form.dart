import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Features/main/cubit/cubit/main_cubit.dart';
import 'package:pro_icon/Features/main/main_screen.dart';
import 'package:pro_icon/Features/manage_trainer/cubits/cubit/trainer_password_cubit.dart';
import 'package:pro_icon/data/models/sign_up_request_builder.dart';

import '../../../Core/utils/enums/role.dart';
import '../../../Core/widgets/confirm_password_form_section.dart';
import '../../../Core/widgets/custom_button.dart';
import '../../../Core/widgets/custom_loader.dart';
import '../../../Core/widgets/custom_snack_bar.dart';
import '../../../Core/widgets/email_form_section.dart';
import '../../../Core/widgets/password_form_section.dart';

class TrainerPasswordForm extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  const TrainerPasswordForm({super.key, required this.formKey});
  Widget _buildSpace(BuildContext context) =>
      context.setMinSize(30).verticalSpace;
  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formKey,
      child: Column(
        children: [
          const EmailFormSection(),
          _buildSpace(
            context,
          ),
          const PasswordFormSection(),
          _buildSpace(
            context,
          ),
          const ConfirmPasswordFormSection(),
          _buildSpace(
            context,
          ),
          _buildSpace(context),
          _buildConfirmButton()
        ],
      ),
    );
  }

  BlocConsumer<TrainerPasswordCubit, TrainerPasswordState>
      _buildConfirmButton() {
    return BlocConsumer<TrainerPasswordCubit, TrainerPasswordState>(
      listener: (context, state) {
        if (state.status == RequestStatus.error) {
          buildCustomAlert(context, state.message!, Colors.red);
        }
        if (state.status == RequestStatus.success) {
          SignupRequestBuilder().reset();
          buildCustomAlert(context, state.message!, Colors.green);

          Future.delayed(const Duration(seconds: 3), () {
            // move to main screen with users section view
            Navigator.of(context).pushNamedAndRemoveUntil(
                MainScreen.routeName,
                arguments: MainSections.users,
                (route) => false);
          });
        }
      },
      builder: (context, state) {
        if (state.status == RequestStatus.submitting) {
          return const CustomLoader();
        } else {
          return CustomButton(
              onPressed: () => _onConfirm(context), text: "confirm".tr());
        }
      },
    );
  }

  void _onConfirm(BuildContext context) {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      final formData = formKey.currentState!.value;
      final email = formData['email'];
      final password = formData['password'];
      final confirmPassword = formData['confirmPassword'];

      if (password != confirmPassword) {
        buildCustomAlert(
            context, "resetPassword.passwordMismatch".tr(), Colors.red);
      } else {
        final builder = SignupRequestBuilder();
        builder.setPassword(password);
        builder.setEmail(email);
        builder.setRole(rolesMap[Role.coach]!);
        final signUpRequest = builder.build();

        BlocProvider.of<TrainerPasswordCubit>(context, listen: false)
            .registerTrainer(signUpRequest: signUpRequest);
      }
    }
  }
}
