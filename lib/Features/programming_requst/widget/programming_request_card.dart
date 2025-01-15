import 'package:flutter/material.dart';
import 'package:pro_icon/Core/theme/app_colors.dart';
import 'package:pro_icon/Core/theme/app_text_styles.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_config.dart';
import 'package:pro_icon/data/models/programming_request.dart';

class ProgrammingRequestCard extends StatelessWidget {
  final ProgrammingRequest programmingRequest;
  const ProgrammingRequestCard({super.key, required this.programmingRequest});

  @override
  Widget build(BuildContext context) {
    return SizeConfig(
      baseSize: const Size(398, 95),
      width: context.setMinSize(398),
      height: context.setMinSize(95),
      child: Builder(
        builder: (context) {
          return Container(
            width: context.sizeConfig.width,
            height: context.sizeConfig.height,
            margin: EdgeInsets.only(top: context.setMinSize(30)),
            padding: EdgeInsets.symmetric(
                horizontal: context.setMinSize(16),
                vertical: context.setMinSize(12)),
            decoration: BoxDecoration(
              color: AppColors.darkGreyColor,
              borderRadius: BorderRadius.circular(context.setMinSize(8)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon Section
                // const Image(
                //   image: AssetImage(Assets.assetsIconForCard),
                //   width: 40,
                //   height: 40,
                // ),
                context.setMinSize(12).horizontalSpace,

                // Information Section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Id:${programmingRequest.id}",
                        style: AppTextStyles.fontSize16(context).copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      context.setMinSize(4).verticalSpace,
                      Text(
                        programmingRequest.createdAt!
                            .toIso8601String()
                            .split("T")[0]
                            .replaceAll("-", "/"), // DD/MM/YYYY format
                        style: AppTextStyles.fontSize14(context).copyWith(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                context.setMinSize(10).horizontalSpace,

                // Status Section
                Container(
                  height: context.setMinSize(30),
                  padding: EdgeInsets.symmetric(
                    horizontal: context.setMinSize(6),
                    vertical: context.setMinSize(4),
                  ),
                  decoration: BoxDecoration(
                    color: programmingRequest.status == "PENDING"
                        ? Colors.yellow
                        : programmingRequest.status == "APPROVED"
                            ? Colors.green
                            : Colors.red,
                    borderRadius: BorderRadius.circular(context.setMinSize(8)),
                  ),
                  child: Center(
                    child: Text(
                      programmingRequest.status!.toLowerCase(),
                      style: AppTextStyles.fontSize14(context).copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
