import 'package:flutter/material.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleKey;
  final VoidCallback? onBack;

  const CustomAppBar({
    Key? key,
    required this.titleKey,
    this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBarHeight = context.setMinSize(70);
    return AppBar(
      toolbarHeight: appBarHeight,
      backgroundColor: AppColors.backgroundColor,
      elevation: 0,
      title: Text(
        titleKey,
        style: AppTextStyles.fontSize20(context).copyWith(color: Colors.white),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
          size: context.setSp(24), // Responsive size for the icon
        ),
        onPressed: onBack ?? () => Navigator.of(context).pop(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
