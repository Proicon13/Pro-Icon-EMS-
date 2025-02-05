import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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
  TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StartDateWidget(),
          context.setMinSize(20).verticalSpace,
          TextFormSection(
              readOnly: true,
              title: "Trainer".tr(),
              name: "trainer",
              hintText: "Added by"),
          context.setMinSize(20).verticalSpace,
          TextFormSection(
              title: "Cancelations".tr(),
              name: "cancelations",
              intialValue:
                  "", // here we put client cancelations as intial value
              hintText: "number of cancelations"),
          context.setMinSize(20).verticalSpace,
          DropdownFormSection<String>(
            title: "status".tr(),
            name: "status",
            hintText: "Active".tr(),
            items: ["ACTIVE", "INACTIVE"]
                .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
                .toList(),
          ),
          context.setMinSize(15).verticalSpace,
          TextFormSection(
            title: "notes".tr(),
            name: "historyNotes",
            hintText: "",
            controller: _notesController,
            maxLines: 5,
          ),
          context.setMinSize(20).verticalSpace,
          CustomButton(onPressed: () {}, text: "save".tr()),
          context.setMinSize(15).verticalSpace,
        ],
      ),
    );
  }
}
