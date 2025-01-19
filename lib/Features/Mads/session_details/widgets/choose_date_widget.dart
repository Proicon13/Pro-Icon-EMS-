import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';

import '../../../../Core/theme/app_text_styles.dart';
import '../../../../Core/widgets/custom_button.dart';
import '../../../../Core/widgets/custom_date_picker_field.dart';

class ChooseDateWidget extends StatefulWidget {
  const ChooseDateWidget({super.key});

  @override
  State<ChooseDateWidget> createState() => _ChooseDateWidgetState();
}

class _ChooseDateWidgetState extends State<ChooseDateWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Choose date",
          style:
              AppTextStyles.fontSize16(context).copyWith(color: Colors.white),
        ),
        context.setMinSize(10).horizontalSpace,
        Expanded(
            child: CustomDatePickerField(
          contentPadding: EdgeInsets.symmetric(
            horizontal: context.setMinSize(5),
            vertical: context.setMinSize(10),
          ),
          name: "From",
          hintText: "From",
        )),
        context.setMinSize(10).horizontalSpace,
        Expanded(
            child: CustomDatePickerField(
          contentPadding: EdgeInsets.symmetric(
            horizontal: context.setMinSize(5),
            vertical: context.setMinSize(10),
          ),
          name: "To",
          hintText: "To",
        )),
        context.setMinSize(15).horizontalSpace, // use responsive spaces
        SizedBox(
            width: context.setMinSize(60),
            child: CustomButton(onPressed: () {}, text: "Apply"))
      ],
    );
  }
}
