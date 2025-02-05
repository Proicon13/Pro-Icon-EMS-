import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/widgets/custom_button.dart';
import 'package:pro_icon/Core/widgets/custom_dropdown_section.dart';
import 'package:pro_icon/Features/client_details/history_info/widgets/start_date_widget.dart';

import '../../../../Core/widgets/text_form_section.dart';

class HistoryInfoBody extends StatefulWidget {
  HistoryInfoBody({super.key});

  @override
  State<HistoryInfoBody> createState() => _HistoryInfoBodyState();
}

class _HistoryInfoBodyState extends State<HistoryInfoBody> {
  late final GlobalKey<FormBuilderState> _formKey;

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

  Widget build(BuildContext context) {
    //TODO: LISTEN TO UPDATE CLIENT STATUS
    return SingleChildScrollView(
      child: FormBuilder(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StartDateWidget(),
            context.setMinSize(20).verticalSpace,
            TextFormSection(
                readOnly: true,
                title: "Trainer".tr(),
                name: "trainer",
                intialValue:
                    "", //TODO: here we put client trainer as intial value,
                hintText: "Added by"),
            context.setMinSize(20).verticalSpace,
            TextFormSection(
                title: "Cancelations".tr(),
                name: "cancelations",
                intialValue:
                    "", //TODO: here we put client cancelations as intial value
                hintText: "number of cancelations"),
            context.setMinSize(20).verticalSpace,
            DropdownFormSection<String>(
              title: "status".tr(),
              name: "status",
              initialValue:
                  "ACTIVE", //TODO: here we put client status as intial value,
              hintText: "Active".tr(),
              items: ["ACTIVE", "INACTIVE"]
                  .map(
                      (e) => DropdownMenuItem<String>(value: e, child: Text(e)))
                  .toList(),
            ),
            context.setMinSize(15).verticalSpace,
            TextFormSection(
              title: "notes".tr(),
              name: "historyNotes",
              intialValue:
                  "", // TODO: here we put client historyNotes as intial value,
              hintText: "",
              maxLines: 5,
            ),
            context.setMinSize(20).verticalSpace,
            CustomButton(
                onPressed: () {
                  if (_formKey.currentState?.saveAndValidate() ?? false) {
                    //TODO: CHECK IF CHANGES IN THE FORM
                    //TODO: HANDLE UPDATE LOGIC
                  }
                },
                text: "save".tr()),
            context.setMinSize(15).verticalSpace,
          ],
        ),
      ),
    );
  }
}
