import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pro_icon/Core/theme/app_text_styles.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';
import 'package:pro_icon/Core/widgets/base_app_scaffold.dart';
import 'package:pro_icon/Core/widgets/custom_header.dart';
import 'package:pro_icon/Features/session_managment/session_summary/widget/auto_card_section.dart';
import 'package:pro_icon/Features/session_managment/session_summary/widget/screen_view.dart';
import 'package:pro_icon/Features/session_managment/session_summary/widget/tabs_section.dart';

class SessionSummary extends StatelessWidget {
  static const routeName = '/session_summary';
  const SessionSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseAppScaffold(
      body: Padding(
        padding: SizeConstants.kScaffoldPadding(context),
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              context.setMinSize(25).verticalSpace,
              CustomHeader(titleKey: "Session Summary.title".tr()),
              context.setMinSize(30).verticalSpace,
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Session details.title".tr(),
                  style: AppTextStyles.fontSize16(context).copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              context.setMinSize(25).verticalSpace,
              const AutoCardSection(),
              context.setMinSize(40).verticalSpace,
              const TabsSection(),
              context.setMinSize(20).verticalSpace,
              const TabBarDetails()
            ],
          ),
        ),
      ),
    );
  }
}
