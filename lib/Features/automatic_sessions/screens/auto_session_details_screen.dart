import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pro_icon/Core/constants/app_assets.dart';
import 'package:pro_icon/Core/entities/automatic_session_entity.dart';
import 'package:pro_icon/Core/entities/session_program_entity.dart';
import 'package:pro_icon/Core/theme/app_text_styles.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_config.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';
import 'package:pro_icon/Core/widgets/base_app_scaffold.dart';
import 'package:pro_icon/Core/widgets/custom_network_image.dart';
import 'package:pro_icon/Core/widgets/custom_rectaungular_image.dart';
import 'package:pro_icon/Core/widgets/custom_svg_visual.dart';
import 'package:pro_icon/Core/widgets/pro_icon_logo.dart';

import '../../../Core/theme/app_colors.dart';
import '../../../Core/widgets/empty_state_widget.dart';

class AutoSessionDetailsScreen extends StatelessWidget {
  static const String routeName = '/auto-session-details';
  final AutomaticSessionEntity session;
  const AutoSessionDetailsScreen({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return BaseAppScaffold(
      body: AutomaticSessionDetailsBody(session: session),
    );
  }
}

class AutomaticSessionDetailsBody extends StatelessWidget {
  final AutomaticSessionEntity session;
  const AutomaticSessionDetailsBody({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Header Section
        SliverToBoxAdapter(
          child: HeaderSection(session: session),
        ),
        // Space between sections
        SliverToBoxAdapter(
          child: context.setMinSize(30).verticalSpace,
        ),
        // Programs Package Section
        SliverToBoxAdapter(
          child: Padding(
            padding: SizeConstants.kScaffoldPadding(context),
            child: Text(
              "programsPackage.title".tr(),
              style: AppTextStyles.fontSize18(context).copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(child: context.setMinSize(16).verticalSpace),
        // Lazy-Loading Programs List

        session.sessionPrograms!.isEmpty
            ? SliverToBoxAdapter(
                child: Expanded(
                    child: Center(
                        child: EmptyStateWidget(
                            message: "noPrograms.title".tr()))))
            : SliverPadding(
                padding: SizeConstants.kScaffoldPadding(context),
                sliver: SliverList(
                  key: const ValueKey("programs-List"),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return SizeConfig(
                          baseSize: const Size(398, 85),
                          width: context.setMinSize(398),
                          height: context.setMinSize(85),
                          child: Builder(builder: (context) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ProgramCard(
                                  program: session.sessionPrograms![index]),
                            );
                          }));
                    },
                    childCount: session.sessionPrograms?.length ?? 0,
                  ),
                ),
              ),
      ],
    );
  }
}

class HeaderSection extends StatelessWidget {
  final AutomaticSessionEntity session;
  const HeaderSection({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Background Image with Back Icon
        Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: context.sizeConfig.height *
                  0.25, // Adjust height for the header
              child: session is MainAutomaticSessionEntity
                  ? CustomNetworkImage(
                      imageUrl:
                          (session as MainAutomaticSessionEntity).image ?? "",
                      errorAssetPath: Assets.assetsImagesLogo,
                    )
                  : const Center(
                      child: ProIconLogo(),
                    ),
            ),
            Positioned(
              top: context.setMinSize(16),
              left: context.setMinSize(16),
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: CustomSvgVisual(
                    assetPath: Assets.assetsImagesCirculedBackIcon,
                    width: context.setMinSize(40),
                    height: context.setMinSize(40),
                  )),
            )
          ],
        ),
        // Name and Duration Section
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.setMinSize(16),
            vertical: context.setMinSize(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  session.name ?? "Session Name",
                  style: AppTextStyles.fontSize20(context).copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                children: [
                  CustomSvgVisual(
                    assetPath: Assets.assetsImagesDurationIcon,
                    width: context.setMinSize(20),
                    height: context.setMinSize(20),
                  ),
                  context.setMinSize(8).horizontalSpace,
                  Text(
                    "${session.duration ?? 0} mins",
                    style: AppTextStyles.fontSize16(context)
                        .copyWith(color: AppColors.lightGreyColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ProgramsPackageSection extends StatelessWidget {
  final List<SessionProgramEntity> sessionPrograms;
  const ProgramsPackageSection({super.key, required this.sessionPrograms});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return ProgramCard(program: sessionPrograms[index]);
        },
        childCount: sessionPrograms.length,
      ),
    );
  }
}

class ProgramCard extends StatelessWidget {
  final SessionProgramEntity program;
  const ProgramCard({super.key, required this.program});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.sizeConfig.height,
      width: context.sizeConfig.width,
      padding: EdgeInsets.all(context.setMinSize(14)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.setMinSize(10)),
        color: AppColors.darkGreyColor,
      ),
      margin: EdgeInsets.only(bottom: context.setMinSize(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomRectangularImage(
              width: context.setMinSize(60),
              height: context.setMinSize(60),
              imageUrl: program.program.image),
          context.setMinSize(12).horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        program.program.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.fontSize16(context).copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Row(children: [
                      Text(
                        "HZ ${program.program.hertez}",
                        style: AppTextStyles.fontSize14(context)
                            .copyWith(color: Colors.white),
                      ),
                      context.setMinSize(4).horizontalSpace,
                      Icon(
                        Icons.bolt,
                        size: context.setMinSize(23),
                        color: AppColors.primaryColor,
                      ),
                      context.setMinSize(4).horizontalSpace,
                      Text(
                        "PU${program.program.pulse}",
                        style: AppTextStyles.fontSize14(context)
                            .copyWith(color: Colors.white),
                      ),
                    ])
                  ],
                ),
                context.setMinSize(10).verticalSpace,
                Row(
                  children: [
                    CustomSvgVisual(
                      assetPath: Assets.assetsImagesDurationIcon,
                      width: context.setMinSize(20),
                      height: context.setMinSize(20),
                    ),
                    context.setMinSize(4).horizontalSpace,
                    Text(
                      "${program.duration} s",
                      style: AppTextStyles.fontSize14(context)
                          .copyWith(color: AppColors.lightGreyColor),
                    ),
                    context.setMinSize(8).horizontalSpace,
                    Icon(
                      Icons.bolt,
                      size: context.setMinSize(20),
                      color: AppColors.primaryColor,
                    ),
                    context.setMinSize(4).horizontalSpace,
                    Text(
                      "${program.pulse}",
                      style: AppTextStyles.fontSize14(context)
                          .copyWith(color: AppColors.lightGreyColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
