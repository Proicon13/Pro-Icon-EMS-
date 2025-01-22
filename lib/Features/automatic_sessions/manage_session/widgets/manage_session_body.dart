import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Features/main/cubit/cubit/main_cubit.dart';
import 'package:pro_icon/Features/main/main_screen.dart';

import '../../../../Core/entities/automatic_session_entity.dart';
import '../../../../Core/utils/responsive_helper/size_constants.dart';
import '../../../../Core/widgets/custom_header.dart';
import 'manage_session_form.dart';

class ManageAutoSessionBody extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  final AutomaticSessionEntity? session;
  const ManageAutoSessionBody({
    super.key,
    required this.formKey,
    this.session,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: SizeConstants.kScaffoldPadding(context),
        child: Column(
          children: [
            context.setMinSize(20).verticalSpace,
            CustomHeader(
                onBack: () => Navigator.pushReplacementNamed(
                    context, MainScreen.routeName,
                    arguments: MainSections.autoSessions),
                titleKey: session == null
                    ? "newSession.title".tr()
                    : "editSession.title".tr()),
            context.setMinSize(40).verticalSpace,
            ManageSessionForm(
              formKey: formKey,
              session: session,
            )
          ],
        ),
      ),
    );
  }
}
