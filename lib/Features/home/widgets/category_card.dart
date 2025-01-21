import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/entities/category_entity.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_config.dart';

import '../../../Core/theme/app_text_styles.dart';
import '../../../Core/widgets/custom_rectaungular_image.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.currentCategory,
    this.onTap,
  });

  final CategoryEntity currentCategory;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      return SizeConfig(
        baseSize: const Size(110, 135),
        width: size.maxWidth,
        height: size.maxHeight,
        child: Builder(builder: (context) {
          return GestureDetector(
            key: ValueKey(currentCategory.id),
            onTap: onTap,
            child: Column(
              children: [
                CustomRectangularImage(
                    height: context.setMinSize(101),
                    width: context.setMinSize(101),
                    imageUrl: currentCategory.image!),
                context.setMinSize(5).verticalSpace,
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: context.sizeConfig.width,
                  ),
                  child: Text(
                    "${currentCategory.name}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.fontSize14(context).copyWith(
                      color: Colors.white,
                      fontSize: context.setMinSize(14),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      );
    });
  }
}
