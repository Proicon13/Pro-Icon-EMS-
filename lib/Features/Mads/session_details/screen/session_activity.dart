import 'package:flutter/material.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';
import 'package:pro_icon/Core/widgets/base_app_Scaffold.dart';
import 'package:pro_icon/Core/widgets/custom_header.dart';
import 'package:pro_icon/Features/Mads/session_details/widgets/cards_session_widget.dart';
import 'package:pro_icon/Features/Mads/session_details/widgets/choose_date_widget.dart';

class SessionActivityScreen extends StatelessWidget {
  static const routeName = '/session_activity';
  const SessionActivityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseAppScaffold(
      body: Padding(
        padding: SizeConstants.kScaffoldPadding(
            context), // use responsive scaffold padding from sizeConstants
        child: Column(
          children: [
            context.setMinSize(30).verticalSpace,
            const CustomHeader(titleKey: "Session activity"),
            context.setMinSize(20).verticalSpace,
            const ChooseDateWidget(),
            context.setMinSize(16).verticalSpace,
            const CardsSessionWidget()
          ],
        ),
      ),
    );
  }
}
