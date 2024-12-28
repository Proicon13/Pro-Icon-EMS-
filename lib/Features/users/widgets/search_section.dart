import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';
import 'package:pro_icon/Core/widgets/custom_svg_visual.dart';

import '../../../Core/constants/app_assets.dart';
import '../../../Core/theme/app_colors.dart';
import '../../../Core/utils/responsive_helper/size_config.dart';
import '../../../Core/widgets/custom_text_field.dart';

class SearchSection extends StatelessWidget {
  final void Function(String) onSearch;
  final void Function() onFilterPressed;
  final void Function() onAddPressed;

  const SearchSection({
    super.key,
    required this.onSearch,
    required this.onFilterPressed,
    required this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    final double searchBarHeight =
        context.setMinSize(50); // height for search bar
    final iconsBaseSize = const Size(60, 50);
    final double iconSize = context.setMinSize(24);

    return Row(
      children: [
        // Search Bar
        Expanded(
          child: SizedBox(
            height: searchBarHeight,
            child: CustomTextField(
              name: 'searchBar',
              hintText: "userManagment.screen.searchHint".tr(),
              onChanged: (value) => onSearch(value ?? ''),
              keyboardInputType: TextInputType.emailAddress,
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: context.setMinSize(5)),
                child: Icon(
                  Icons.search,
                  color: AppColors.white71Color,
                  size: iconSize,
                ),
              ),
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                vertical: (searchBarHeight - iconSize) /
                    2, // to center content vertically
              ),
            ),
          ),
        ),

        context.setMinSize(10).horizontalSpace,

        // Filter Button
        InkWell(
          onTap: onFilterPressed,
          child: SizeConfig(
            baseSize: iconsBaseSize,
            height: searchBarHeight,
            width: context.setMinSize(60),
            child: Builder(builder: (context) {
              return Container(
                height: context.sizeConfig.height,
                width: context.sizeConfig.width,
                padding: EdgeInsets.symmetric(
                    horizontal: context.setMinSize(10),
                    vertical: context.setMinSize(10)),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: SizeConstants.kDefaultBorderRadius(context),
                ),
                child: Center(
                  child: CustomSvgVisual(
                    width: iconSize,
                    height: iconSize,
                    assetPath: Assets.assetsImagesFilterIcon,
                  ),
                ),
              );
            }),
          ),
        ),

        context.setMinSize(10).horizontalSpace,

        // Add Button
        InkWell(
          onTap: onAddPressed,
          child: SizeConfig(
            baseSize: iconsBaseSize,
            height: searchBarHeight,
            width: context.setMinSize(60),
            child: Builder(builder: (context) {
              return Container(
                height: context.sizeConfig.height,
                width: context.sizeConfig.width,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: SizeConstants.kDefaultBorderRadius(context),
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: iconSize,
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
