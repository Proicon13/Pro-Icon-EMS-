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
                    child: MuscleColumn(
                      muscleEntries: musclesMap.entries
                          .where((entry) =>
                              musclesMap.entries.toList().indexOf(entry) % 2 ==
                              0)
                          .toList(),
                    ),
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
            child: LayoutBuilder(builder: (context, constarints) {
              return SizeConfig(
                baseSize: const Size(150, 290),
                width: constarints.maxWidth,
                height: constarints.maxHeight,
                child: Builder(builder: (context) {
                  return SizedBox(
                    height: context.sizeConfig.height,
                    width: context.sizeConfig.width,
                    child: MuscleColumn(
                      muscleEntries: musclesMap.entries
                          .where((entry) =>
                              musclesMap.entries.toList().indexOf(entry) % 2 !=
                              0)
                          .toList(),
                    ),
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
