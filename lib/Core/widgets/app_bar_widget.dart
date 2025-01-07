import 'package:flutter/material.dart';
import 'package:pro_icon/Core/entities/user_entity.dart';
import 'package:pro_icon/Core/theme/app_colors.dart';
import 'package:pro_icon/Core/theme/app_text_styles.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/widgets/custom_circular_image.dart';
import 'package:pro_icon/Features/Profile/Screens/profile_screen.dart';

class AppBarWidget extends StatelessWidget {
  final String text;
  final UserEntity user;
  const AppBarWidget({super.key, required this.text, required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: AppTextStyles.fontSize24(context)
                  .copyWith(color: Colors.white),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              user.fullname!,
              style: AppTextStyles.fontSize20(context)
                  .copyWith(color: AppColors.white71Color),
            )
          ],
        ),
        GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const ProfileScreen()));
            },
            child: CustomCircularImage(
                width: context.setMinSize(70),
                height: context.setMinSize(70),
                imageUrl: user.image!))
      ],
    );
  }
}
