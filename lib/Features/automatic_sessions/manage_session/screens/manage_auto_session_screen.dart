import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pro_icon/Core/entities/automatic_session_entity.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/widgets/base_app_scaffold.dart';
import 'package:pro_icon/Core/widgets/custom_button.dart';
import 'package:pro_icon/Core/widgets/keyboard_dismissable.dart';
import 'package:pro_icon/Features/automatic_sessions/manage_session/cubits/cubit/manage_custom_session_cubit.dart';

import '../../../../Core/dependencies.dart';
import '../widgets/manage_session_body.dart';

class ManageAutoSessionScreen extends StatefulWidget {
  static const routeName = '/manage_auto_session_screen';
  final AutomaticSessionEntity? session;
  const ManageAutoSessionScreen({super.key, this.session});

  @override
  State<ManageAutoSessionScreen> createState() =>
      _ManageAutoSessionScreenState();
}

class _ManageAutoSessionScreenState extends State<ManageAutoSessionScreen> {
  late GlobalKey<FormBuilderState> _formKey;

  @override
  void initState() {
    _formKey = GlobalKey<FormBuilderState>();
    super.initState();
  }

  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ManageCustomSessionCubit>(
      create: (context) => getIt<ManageCustomSessionCubit>()
        ..onInit(widget.session)
        ..getSessionPrograms(),
      child: KeyboardDismissable(
        child: BaseAppScaffold(
          body: ManageAutoSessionBody(
            formKey: _formKey,
            session: widget.session,
          ),
          bottomNavigationBar: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.setMinSize(16),
                  vertical: context.setMinSize(15)),
              child: CustomButton(onPressed: () {}, text: "confirm".tr())),
        ),
      ),
    );
  }
}
