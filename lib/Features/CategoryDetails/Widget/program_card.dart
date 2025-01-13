import 'package:flutter/material.dart';
import 'package:pro_icon/Core/entities/program_entity.dart';
import 'package:pro_icon/Core/theme/app_colors.dart';
import 'package:pro_icon/Core/theme/app_text_styles.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';

import '../../../Core/constants/app_assets.dart';
import '../../../Core/widgets/custom_circular_image.dart';
import '../../../Core/widgets/custom_svg_visual.dart';

abstract class BaseProgramCard extends StatelessWidget {
  final ProgramEntity program;

  const BaseProgramCard({
    Key? key,
    required this.program,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.sizeConfig.height,
      padding: EdgeInsets.symmetric(
        horizontal: context.setMinSize(20),
      ),
      decoration: BoxDecoration(
        color: AppColors.darkGreyColor,
        borderRadius: SizeConstants.kDefaultBorderRadius(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          context.setMinSize(20).verticalSpace,
          _buildHeader(context),
          context.setMinSize(20).verticalSpace,
          buildFooter(context), // This will be implemented in child classes
        ],
      ),
    );
  }

  /// Builds the header with the image and title
  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomCircularImage(
          width: context.setMinSize(65),
          height: context.setMinSize(65),
          imageUrl: program.image,
        ),
        context.setMinSize(20).horizontalSpace,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(context),
            context.setMinSize(10).verticalSpace,
            _buildMetadata(context),
          ],
        ),
      ],
    );
  }

  /// Builds the title of the program
  Widget _buildTitle(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: context.sizeConfig.width * 0.6,
      ),
      child: Text(
        program.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyles.fontSize16(context).copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  /// Builds the metadata (HZ and Pulse)
  Widget _buildMetadata(BuildContext context) {
    return Row(
      children: [
        Text(
          "HZ ${program.hertez}",
          style: AppTextStyles.fontSize14(context).copyWith(
            color: Colors.white,
          ),
        ),
        context.setMinSize(5).horizontalSpace,
        CustomSvgVisual(
          assetPath: Assets.assetsImagesPulseIcon,
          width: context.setMinSize(20),
          height: context.setMinSize(20),
        ),
        context.setMinSize(5).horizontalSpace,
        Text(
          "PU ${program.pulse}",
          style: AppTextStyles.fontSize14(context).copyWith(
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  /// Footer widget to be implemented in child classes
  Widget buildFooter(BuildContext context);
}

class ProgramCardWithDescription extends BaseProgramCard {
  const ProgramCardWithDescription({
    Key? key,
    required ProgramEntity program,
  }) : super(key: key, program: program);

  @override
  Widget buildFooter(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: context.sizeConfig.width * 0.89,
      ),
      child: Text(
        program.description,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyles.fontSize12(context).copyWith(
          color: AppColors.white71Color,
        ),
      ),
    );
  }
}

class ProgramCardWithActions extends BaseProgramCard {
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ProgramCardWithActions({
    Key? key,
    required ProgramEntity program,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key, program: program);

  @override
  Widget buildFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          child: CustomSvgVisual(
            assetPath: Assets.assetsImagesEditIcon,
            width: context.setMinSize(25),
            height: context.setMinSize(25),
          ),
          onTap: onEdit, // Trigger edit callback
        ),
        context.setMinSize(20).horizontalSpace,
        GestureDetector(
          child: CustomSvgVisual(
            assetPath: Assets.assetsImagesDeleteIcon,
            width: context.setMinSize(25),
            height: context.setMinSize(25),
          ),
          onTap: onDelete, // Trigger edit callback
        ),
      ],
    );
  }
}
