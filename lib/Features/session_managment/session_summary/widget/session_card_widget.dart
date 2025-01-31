import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/widgets/custom_circular_image.dart';
import 'package:pro_icon/Features/session_managment/session_summary/widget/card_data_content.dart';
import 'package:pro_icon/Features/session_managment/session_summary/widget/kal_and_prize_secion.dart';
import 'package:pro_icon/Features/session_managment/session_summary/widget/minandmax_section.dart';
import 'package:pro_icon/Features/session_managment/session_summary/widget/user_number_section.dart';

import '../../../../Core/constants/app_assets.dart';
import '../../../../Core/theme/app_colors.dart';
import '../../../../Core/theme/app_text_styles.dart';
import '../../../../Core/utils/responsive_helper/size_config.dart';
import '../../../../Core/widgets/custom_svg_visual.dart';

class SessionCardSummary extends StatelessWidget {
  //TODO: fix naming conventions
  //Todo: fixed Done
  final String imageUrl;

  final String duration;




  const SessionCardSummary(
      {Key? key,
      required this.imageUrl,


      required this.duration,




      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizeConfig(
      baseSize: const Size(398, 170),
      width: context.setMinSize(398),
      height: context.setMinSize(170),
      child: Builder(
        builder: (context) {
          return Container(
            width: context.sizeConfig.width,
            height: context.sizeConfig.height,
            padding: EdgeInsets.symmetric(
                horizontal: context.setMinSize(16),
                vertical: context.setMinSize(14)),
            decoration: BoxDecoration(
              color: AppColors.darkGreyColor,
              borderRadius: BorderRadius.circular(context.setMinSize(10)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomCircularImage(
                  width: context.setMinSize(50),
                  height: context.setMinSize(50),
                  imageUrl: imageUrl,
                ),
                context.setMinSize(15).horizontalSpace,
              const  CardDataContent()
              ],
            ),
          );
        },
      ),
    );
  }




}
