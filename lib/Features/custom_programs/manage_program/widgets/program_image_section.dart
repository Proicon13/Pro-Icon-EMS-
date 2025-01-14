import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';

import '../../../../Core/constants/app_assets.dart';
import '../../../../Core/widgets/custom_circular_image.dart';
import '../../../../Core/widgets/custom_svg_visual.dart';
import '../cubits/cubit/manage_custom_program_cubit.dart';

class ProgramImageSection extends StatelessWidget {
  const ProgramImageSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ManageCustomProgramCubit, ManageCustomProgramState,
        String>(
      selector: (state) {
        return state.customProgramEntity!.image;
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () {},
          child: Stack(
            children: [
              CustomCircularImage(
                width: context.setMinSize(90),
                height: context.setMinSize(90),
                imageUrl: state,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: CustomSvgVisual(
                  assetPath: Assets.assetsImagesEditProfileIcon,
                  width: context.setMinSize(40),
                  height: context.setMinSize(40),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
