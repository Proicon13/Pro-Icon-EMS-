import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pro_icon/Core/constants/app_assets.dart';
import 'package:pro_icon/Core/constants/app_constants.dart';
import 'package:pro_icon/Core/theme/app_colors.dart';
import 'package:pro_icon/Core/theme/app_text_styles.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_config.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';
import 'package:pro_icon/Core/widgets/base_app_Scaffold.dart';
import 'package:pro_icon/Core/widgets/custom_button.dart';
import 'package:pro_icon/Core/widgets/custom_date_picker_field.dart';
import 'package:pro_icon/Core/widgets/custom_header.dart';
import 'package:pro_icon/Core/widgets/custom_svg_visual.dart';
import 'package:pro_icon/Features/Mads/session_details/widgets/cards_session_widget.dart';
import 'package:pro_icon/Features/Mads/session_details/widgets/choose_date_widget.dart';

class SessionActivityScreen extends StatelessWidget {
  static const routeName = '/session_activity';

  @override
  Widget build(BuildContext context) {
    // TODO: REFACTOR CODE INTO SEPERATE WIDGETS AND SECTIONS
    return BaseAppScaffold(
      resizeToAvoidButtomPadding: true,
      body: Padding(
        padding: SizeConstants.kScaffoldPadding(context), // use responsive scaffold padding from sizeConstants
        child: Column(
          children: [
             context.setMinSize(30).verticalSpace,
            const CustomHeader(titleKey: "Session activity"),
           context.setMinSize(20).verticalSpace,
         const   ChooseDateWidget(),
            context.setMinSize(16).verticalSpace,
      const      CardsSessionWidget()
          ],
        ),
      ),
    );
  }


}
