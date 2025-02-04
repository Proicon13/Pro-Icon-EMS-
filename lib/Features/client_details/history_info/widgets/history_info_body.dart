import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';
import 'package:pro_icon/Core/widgets/custom_button.dart';
import 'package:pro_icon/Core/widgets/custom_dropdown_section.dart';
import 'package:pro_icon/Features/client_details/history_info/widgets/start_date_widget.dart';
import 'package:pro_icon/Features/client_details/history_info/widgets/trainer_data_section.dart';

import '../../../../Core/widgets/text_form_section.dart';
class HistoryInfoBody extends StatefulWidget {
  HistoryInfoBody({super.key});

  @override
  State<HistoryInfoBody> createState() => _HistoryInfoBodyState();
}

class _HistoryInfoBodyState extends State<HistoryInfoBody> {


  TextEditingController _notesController = TextEditingController();

  @override

  void dispose () {
    _notesController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: SizeConstants.kScaffoldPadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StartDateWidget(),
            context.setMinSize(40).verticalSpace,
            ClientHistoryInfo(title: "Trainer name".tr(), name: "Omar Sabry"),
            context.setMinSize(20).verticalSpace,
            ClientHistoryInfo(title: "Cancelations".tr(), name: "6 times"),
            context.setMinSize(20).verticalSpace,
            DropdownFormSection(
              title: "status".tr(),
              name: "Active".tr(),
              hintText: "Active".tr(),
              items: const [],
            ),
            context.setMinSize(15).verticalSpace,
            TextFormSection(
              title: "notes".tr(),
              name: "notes",
              hintText: "",
              controller: _notesController,
              maxLines: 5,
            ),
            context.setMinSize(20).verticalSpace,
            CustomButton(onPressed: () {}, text: "Save".tr()),
            context.setMinSize(15).verticalSpace,
          ],
        ),
      ),
    );
  }
}