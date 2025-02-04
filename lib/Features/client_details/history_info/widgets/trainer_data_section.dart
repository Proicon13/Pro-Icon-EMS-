import 'package:flutter/material.dart';
import 'package:pro_icon/Core/theme/app_text_styles.dart';
import 'package:pro_icon/Core/utils/enums/gender.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';

// TODO: rename this to client history info column to since it repeated in many places(start,end date, trainer name,cancelations)

class ClientHistoryInfo extends StatelessWidget {
  final String title;
  final String name;

  ClientHistoryInfo({super.key, required this.title, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: AppTextStyles.fontSize16(context)
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        context.setMinSize(15).verticalSpace,
        Text(
          name,
          style: AppTextStyles.fontSize16(context).copyWith(color: Colors.grey),
        )
      ],
    );
  }
}
