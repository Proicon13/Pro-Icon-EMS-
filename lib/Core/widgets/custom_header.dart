import 'package:flutter/material.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class CustomHeader extends StatelessWidget {
  final String titleKey;
  final VoidCallback? onBack;
  final bool? isIconVisible;

  const CustomHeader({
    Key? key,
    required this.titleKey,
    this.isIconVisible,
    this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final headerHeight = context.setMinSize(70); // Adjustable height for header
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.backgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          isIconVisible != null
              ? const SizedBox.shrink()
              : GestureDetector(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: context.setSp(24), // Responsive size for the icon
                  ),
                  onTap: onBack ?? () => Navigator.of(context).pop(),
                ),
          const Spacer(), // Pushes the title to the center
          Text(
            titleKey,
            style:
                AppTextStyles.fontSize20(context).copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const Spacer(), // Ensures symmetry on the right
        ],
      ),
    );
  }
}
