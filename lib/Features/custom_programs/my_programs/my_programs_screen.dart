import 'package:flutter/material.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/widgets/base_app_scaffold.dart';
import 'package:pro_icon/Core/widgets/custom_header.dart';

import '../../../Core/utils/responsive_helper/size_constants.dart';
import 'widgets/custom_program_list_section.dart';

class MyProgramsScreen extends StatelessWidget {
  static const routeName = '/my-programs';
  const MyProgramsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseAppScaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          size: context.setMinSize(30),
          color: Colors.black,
        ),
        elevation: 1,
        backgroundColor: Colors.lightGreen,
      ),
      body: Padding(
        padding: SizeConstants.kScaffoldPadding(context),
        child: Column(
          children: [
            context.setMinSize(30).verticalSpace,
            const CustomHeader(titleKey: "My Programs"),
            context.setMinSize(40).verticalSpace,
            const CustomProgramSection()
          ],
        ),
      ),
    );
  }
}
