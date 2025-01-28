import 'package:flutter/material.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';

import '../../../../Core/constants/app_assets.dart';
import '../../../../Core/widgets/custom_asset_image.dart';
import 'muscle_column.dart';

class MusclesValueGrid extends StatelessWidget {
  final Map<String, int> musclesMap;
  const MusclesValueGrid({
    super.key,
    required this.musclesMap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: context.sizeConfig.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SizedBox(
              height: context.sizeConfig.height,
              child: MuscleColumn(
                muscleEntries: musclesMap.entries
                    .where((entry) =>
                        musclesMap.entries.toList().indexOf(entry) % 2 == 0)
                    .toList(),
              ),
            ),
          ),
          SizedBox(
            width: context.sizeConfig.width * 0.28,
            height: context.sizeConfig.height,
            child: const CustomAssetImage(
              path: Assets.assetsImagesBodyImage,
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            child: SizedBox(
              height: context.sizeConfig.height,
              child: MuscleColumn(
                muscleEntries: musclesMap.entries
                    .where((entry) =>
                        musclesMap.entries.toList().indexOf(entry) % 2 != 0)
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
