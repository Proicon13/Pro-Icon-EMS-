import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';

import '../../../../Core/theme/app_text_styles.dart';
import '../../../../Core/widgets/custom_button.dart';
import '../../../../Core/widgets/custom_date_picker_field.dart';
import '../../Cubit/cubit/session_details_cubit.dart';

class ChooseDateWidget extends StatefulWidget {
  const ChooseDateWidget({super.key});

  @override
  State<ChooseDateWidget> createState() => _ChooseDateWidgetState();
}

class _ChooseDateWidgetState extends State<ChooseDateWidget> {
  late TextEditingController fromController;
  late TextEditingController toController;
  // TODO: translate all TEXTSSSSSSSSSSSS
  @override
  void initState() {
    fromController = TextEditingController();
    toController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    fromController.dispose();
    toController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Choose date",
          style:
              AppTextStyles.fontSize16(context).copyWith(color: Colors.white),
        ),
        context.setMinSize(5).horizontalSpace,
        Expanded(
            child: CustomDatePickerField(
          controller: fromController,
          contentPadding: EdgeInsets.symmetric(
            horizontal: context.setMinSize(4),
            vertical: context.setMinSize(10),
          ),
          name: "From",
          hintText: "From",
        )),
        context.setMinSize(5).horizontalSpace,
        Expanded(
            child: CustomDatePickerField(
          controller: toController,
          contentPadding: EdgeInsets.symmetric(
            horizontal: context.setMinSize(4),
            vertical: context.setMinSize(10),
          ),
          name: "To",
          hintText: "To",
        )),
        context.setMinSize(10).horizontalSpace, // use responsive spaces
        SizedBox(
            width: context.setMinSize(80),
            child: CustomButton(
                onPressed: () {
                  if (fromController.text.isNotEmpty &&
                      toController.text.isNotEmpty) {
                    final fromDate = DateTime.parse(fromController.text);
                    final toDate = DateTime.parse(toController.text);

                    context
                        .read<SessionDetailsCubit>()
                        .fetchMadSessions(from: fromDate, to: toDate);
                  }
                },
                text: "Apply"))
      ],
    );
  }
}
