import 'package:flutter/material.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';

import '../theme/app_colors.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      width: context.setMinSize(50),
      height: context.setMinSize(50),
      child: CircularProgressIndicator(
        color: AppColors.primaryColor,
        strokeWidth: context.setMinSize(5),
      ),
    ));
  }
}
