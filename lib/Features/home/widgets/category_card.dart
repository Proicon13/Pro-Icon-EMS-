import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_config.dart';

import '../../../Core/theme/app_text_styles.dart';
import '../../../Core/widgets/custom_rectaungular_image.dart';
import '../../../data/models/categories_model.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.currentCategory,
    this.onTap,
  });

  final Categories currentCategory;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      return SizeConfig(
        baseSize: const Size(101, 135),
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
                Text(
                  "${currentCategory.name}",
                  style: AppTextStyles.fontSize16(context).copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: context.setMinSize(16)),
                ),
              ],
            ),
          );
        }),
      );
    });
  }
}
