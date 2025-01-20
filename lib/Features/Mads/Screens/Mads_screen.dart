import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';
import 'package:pro_icon/Core/widgets/base_app_Scaffold.dart';
import 'package:pro_icon/Core/widgets/custom_header.dart';
import 'package:pro_icon/Features/Mads/Widgets/card_Mads_Widget.dart';
import 'package:pro_icon/Features/Mads/session_details/screen/session_activity.dart';

class MadsScreen extends StatelessWidget {
  static const String routeName = "/mads-screen";
  const MadsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseAppScaffold(
      body: Padding(
        padding: SizeConstants.kScaffoldPadding(context),
        child: Column(
          children: [
            context.setMinSize(30).verticalSpace,
            CustomHeader(titleKey: "MaDs".tr()),
            context.setMinSize(10).verticalSpace,
            Expanded(
              child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (contet, index) {
                    return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, SessionActivityScreen.routeName);
                        },
                        child: const CardMadsWidget());
                  }),
            )
          ],
        ),
      ),
    );
  }
}
