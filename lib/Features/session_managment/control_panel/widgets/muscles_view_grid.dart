import 'package:flutter/material.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_config.dart';

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
    final muscleEntries = musclesMap.entries.toList();

    // Ensure safe handling for small lists
    final int firstHalfSize =
        muscleEntries.length >= 5 ? 5 : muscleEntries.length;
    final int secondHalfSize =
        (muscleEntries.length > 5) ? muscleEntries.length - 5 : 0;

    final leftColumnMuscles = muscleEntries.take(firstHalfSize).toList();
    final rightColumnMuscles = secondHalfSize > 0
        ? muscleEntries.skip(5).take(secondHalfSize).toList()
        : <MapEntry<String, int>>[];

    return SizedBox(
      width: double.infinity,
      height: context.sizeConfig.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: LayoutBuilder(builder: (context, constraints) {
              return SizeConfig(
                baseSize: const Size(150, 290),
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                child: Builder(builder: (context) {
                  return SizedBox(
                    height: context.sizeConfig.height,
                    width: context.sizeConfig.width,
                    child: MuscleColumn(muscleEntries: leftColumnMuscles),
                  );
                }),
              );
            }),
          ),
          SizedBox(
            width: context.sizeConfig.width * 0.4,
            height: context.sizeConfig.height,
            child: const CustomAssetImage(
              path: Assets.assetsImagesBodyImage,
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            child: LayoutBuilder(builder: (context, constraints) {
              return SizeConfig(
                baseSize: const Size(150, 290),
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                child: Builder(builder: (context) {
                  return SizedBox(
                    height: context.sizeConfig.height,
                    width: context.sizeConfig.width,
                    child: MuscleColumn(muscleEntries: rightColumnMuscles),
                  );
                }),
              );
            }),
          ),
        ],
      ),
    );
  }
}
