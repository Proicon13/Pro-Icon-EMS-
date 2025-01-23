import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Features/automatic_sessions/manage_session/widgets/session_programs_section.dart';

import '../../../../Core/entities/automatic_session_entity.dart';
import '../../../../Core/widgets/text_form_section.dart';

class ManageSessionForm extends StatelessWidget {
  const ManageSessionForm({
    super.key,
    required this.formKey,
    this.session,
  });

  final GlobalKey<FormBuilderState> formKey;
  final AutomaticSessionEntity? session;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
        key: formKey,
        child: Column(children: [
          _buildSessionNameDurationSection(context),
          context.setMinSize(10).verticalSpace,
          const SessionProgramsSection()
        ]));
  }

  Widget _buildSessionNameDurationSection(BuildContext context) {
    return SizedBox(
      height: context.setMinSize(140),
      child: Row(children: [
        Expanded(
            flex: 2,
            child: TextFormSection(
              title: "Name",
              name: "name",
              hintText: "Session Name",
              intialValue: session?.name ?? null,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: "Name is required"),
                FormBuilderValidators.maxLength(50,
                    errorText: "Name cannot exceed 50 characters"),
              ]),
            )),
        context.setMinSize(30).horizontalSpace,
        Expanded(
            flex: 1,
            child: TextFormSection(
              title: "Duration (min)",
              name: "duration",
              hintText: "10 mins",
              intialValue: session?.duration.toString() ?? null,
              keyboardInputType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3)
              ],
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: "Required field"),
              ]),
            ))
      ]),
    );
  }
}
