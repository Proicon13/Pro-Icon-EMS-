import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/cubits/user_state/user_state_cubit.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Features/Profile/Cubit/profile_cubit.dart';

import '../../../Core/constants/app_assets.dart';
import '../../../Core/widgets/custom_circular_image.dart';
import '../../../Core/widgets/custom_svg_visual.dart';

class ProfileImageSection extends StatelessWidget {
  const ProfileImageSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<UserStateCubit, UserStateState, String>(
      selector: (state) {
        return state.currentUser!.image!;
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            context.read<ProfileCubit>().onPickImage();
          },
          child: Stack(
            children: [
              CustomCircularImage(
                width: context.setMinSize(65),
                height: context.setMinSize(65),
                imageUrl: state,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: CustomSvgVisual(
                  assetPath: Assets.assetsImagesEditProfileIcon,
                  width: context.setMinSize(30),
                  height: context.setMinSize(30),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
