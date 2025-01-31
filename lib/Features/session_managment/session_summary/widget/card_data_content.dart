import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/utils/enums/gender.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Features/session_managment/session_summary/widget/height_and_weight_row.dart';
import 'package:pro_icon/Features/session_managment/session_summary/widget/name_row.dart';
import 'package:pro_icon/Features/session_managment/session_summary/widget/user_number_section.dart';

class CardDataContent extends StatelessWidget {
  const CardDataContent({super.key});

  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // TODO: NAME DETAILS ROW
         NameRow(userName: "omar sabry".tr(), madsCount: '7'),
          context.setMinSize(10).verticalSpace,
          HeightAndWeightRow(userAge: "25", userHight: "174 cm", userWeight: "70 kg"),
          context.setMinSize(20).verticalSpace,
          const    UserNumberSection(),
        ],
      ),
    );
  }
}
