import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pro_icon/Core/constants/app_constants.dart';
import 'package:pro_icon/Core/entities/client_entity.dart';
import 'package:pro_icon/Core/theme/app_text_styles.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';
import 'package:pro_icon/Core/widgets/custom_button.dart';
import 'package:pro_icon/Core/widgets/custom_dropdown_section.dart';
import 'package:pro_icon/Core/widgets/custom_text_field.dart';
import 'package:pro_icon/Features/client_details/history_info/widgets/start_date_widget.dart';
import 'package:pro_icon/Features/client_details/history_info/widgets/trainer_data_section.dart';
import 'package:pro_icon/Features/client_details/medical_report/medical_info_view.dart';

import '../../../../Core/widgets/text_form_section.dart';

class HistoryInfoBody extends StatelessWidget {
   HistoryInfoBody({super.key, });


  TextEditingController _notesController = TextEditingController();

  Widget build(BuildContext context) {
    return  Padding(
      padding: SizeConstants.kScaffoldPadding(context),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           const  StartDateWidget(),
            context.setMinSize(40).verticalSpace,
            TrainerDataSection(title: "Trainer name", name: "Omar Sabry"),
            context.setMinSize(20).verticalSpace,
            TrainerDataSection(title: "Cancelations", name: "6 times"),
            context.setMinSize(20).verticalSpace,
         const  DropdownFormSection(title: "status", name: "Active", hintText:"Active" , items: []),
            context.setMinSize(15).verticalSpace,
            TextFormSection(
              title: "notes".tr(),
              name: "notes",
              hintText: "",
              controller: _notesController,
              maxLines: 5,
            ),
            context.setMinSize(20).verticalSpace,
           CustomButton(onPressed: (){}, text: "Save"),

            context.setMinSize(15).verticalSpace,

        
        
          ],
        ),
      ),
    );
  }
}
