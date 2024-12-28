import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pro_icon/Core/dependencies.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/widgets/base_app_scaffold.dart';
import 'package:pro_icon/Features/manage_trainer/cubits/cubit/trainer_password_cubit.dart';
import 'package:pro_icon/Features/manage_trainer/widgets/trainer_password_form.dart';

import '../../../Core/utils/responsive_helper/size_constants.dart';
import '../../../Core/widgets/custom_app_bar.dart';

class TrainerPasswordRegestraionScreen extends StatefulWidget {
  static const routeName = '/trainer-password-regestraion-screen';
  const TrainerPasswordRegestraionScreen({super.key});

  @override
  State<TrainerPasswordRegestraionScreen> createState() =>
      _TrainerPasswordRegestraionScreenState();
}

class _TrainerPasswordRegestraionScreenState
    extends State<TrainerPasswordRegestraionScreen> {
  late GlobalKey<FormBuilderState> _formKey;

  @override
  void initState() {
    _formKey = GlobalKey<FormBuilderState>();
    super.initState();
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseAppScaffold(
      appBar: CustomAppBar(
        titleKey: "userManagment.screen.addTrainer".tr(),
      ),
      body: SingleChildScrollView(
          child: Padding(
              padding: SizeConstants.kScaffoldPadding(context),
              child: Column(
                children: [
                  context.setMinSize(50).verticalSpace,
                  BlocProvider<TrainerPasswordCubit>(
                    create: (context) => getIt<TrainerPasswordCubit>(),
                    child: TrainerPasswordForm(formKey: _formKey),
                  ),
                ],
              ))),
    );
  }
}
