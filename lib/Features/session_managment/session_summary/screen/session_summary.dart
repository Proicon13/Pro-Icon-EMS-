import 'package:flutter/material.dart';
import 'package:pro_icon/Core/constants/app_assets.dart';
import 'package:pro_icon/Core/theme/app_colors.dart';
import 'package:pro_icon/Core/theme/app_text_styles.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_config.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';
import 'package:pro_icon/Core/widgets/base_app_scaffold.dart';
import 'package:pro_icon/Core/widgets/custom_header.dart';
import 'package:pro_icon/Core/widgets/custom_rectaungular_image.dart';
import 'package:pro_icon/Core/widgets/custom_svg_visual.dart';
import 'package:pro_icon/Features/session_managment/session_summary/widget/charts_widget.dart';
import 'package:pro_icon/Features/session_managment/session_summary/widget/participants_widget.dart';

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
              const CustomHeader(titleKey: "Session Summary"),
              context.setMinSize(30).verticalSpace,
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Session details",
                  style: AppTextStyles.fontSize16(context).copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              context.setMinSize(25).verticalSpace,
              // TODO: REFACTOR TO SESSION CARD AND PROVIDE ALL PARAMETRS
              SizeConfig(
                baseSize: const Size(400, 110),
                width: context.setMinSize(400),
                height: context.setMinSize(110),
                child: Builder(builder: (context) {
                  return Container(
                    width: context.sizeConfig.width,
                    height: context.sizeConfig.height,
                    padding: EdgeInsets.all(context.setMinSize(12)),
                    decoration: BoxDecoration(
                      color: AppColors.darkGreyColor,
                      borderRadius:
                          BorderRadius.circular(context.setMinSize(16)),
                    ),
                    child: Row(
                      children: [
                        CustomRectangularImage(
                            width: context.setMinSize(81),
                            height: context.setMinSize(79),
                            imageUrl: Assets.assetsSessionSummaryImage),
                        context.setMinSize(15).horizontalSpace,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Automatic session",
                              style: AppTextStyles.fontSize16(context).copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            context.setMinSize(7).verticalSpace,
                            Row(
                              children: [
                                Text(
                                  "HZ 80",
                                  style: AppTextStyles.fontSize14(context)
                                      .copyWith(color: Colors.white),
                                ),
                                context.setMinSize(10).horizontalSpace,
                                const CustomSvgVisual(
                                    assetPath: Assets.assetsImagesPulseIcon),
                                context.setMinSize(10).horizontalSpace,
                                Text(
                                  "PU 550",
                                  style: AppTextStyles.fontSize14(context)
                                      .copyWith(color: Colors.white),
                                )
                              ],
                            ),
                            context.setMinSize(10).verticalSpace,
                            Row(
                              children: [
                                Row(
                                  children: [
                                    CustomSvgVisual(
                                      assetPath: Assets.assetsImagesMadsIcon,
                                      width: context.setMinSize(16),
                                      height: context.setMinSize(16),
                                    ),
                                    context.setMinSize(10).horizontalSpace,
                                    Text(
                                      "3 MADS",
                                      style: AppTextStyles.fontSize14(context)
                                          .copyWith(color: Colors.grey),
                                    )
                                  ],
                                ),
                                context.setMinSize(40).horizontalSpace,
                                Row(
                                  children: [
                                    const CustomSvgVisual(
                                        assetPath:
                                            Assets.assetsImagesDurationIcon),
                                    context.setMinSize(10).horizontalSpace,
                                    Text("15 Min",
                                        style: AppTextStyles.fontSize14(context)
                                            .copyWith(color: Colors.grey))
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ),
              context.setMinSize(40).verticalSpace,
              // TODO: TRANSLATIONS FOR ALL TEXTS IN THIS SCREEN AND INNER WIDGETS
              Container(
                  child: const TabBar(
                      indicatorColor: Colors.red,
                      labelColor: Colors.white,
                      dividerHeight: 0,
                      tabs: [
                    Tab(
                      text: "Participants",
                    ),
                    Tab(
                      text: "Statistics",
                    ),
                  ])),
              context.setMinSize(20).verticalSpace,
              const Expanded(
                child: TabBarView(
                    children: [ParticipantsWidget(), ChartsWidget()]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
