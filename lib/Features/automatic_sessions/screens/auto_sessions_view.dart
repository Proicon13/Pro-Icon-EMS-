import 'package:flutter/material.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/widgets/custom_header.dart';

class AutoSessionsView extends StatelessWidget {
  const AutoSessionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        context.setMinSize(30).verticalSpace,
        const CustomHeader(
          titleKey: "Automatic Sessions",
          isIconVisible: false,
        ),
      ],
    );
  }
}
