import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/cubits/user_state/user_state_cubit.dart';
import 'package:pro_icon/Core/entities/admin_entity.dart';
import 'package:pro_icon/Core/entities/programmer_entity.dart';
import 'package:pro_icon/Core/entities/user_entity.dart';
import 'package:pro_icon/Core/theme/app_colors.dart';
import 'package:pro_icon/Core/theme/app_text_styles.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';
import 'package:pro_icon/Core/widgets/custom_circular_image.dart';
import 'package:pro_icon/Core/widgets/custom_header.dart';
import 'package:pro_icon/Core/widgets/custom_svg_visual.dart';
import 'package:pro_icon/Features/Mads/Screens/Mads_screen.dart';
import 'package:pro_icon/Features/Profile/Screens/profile_screen.dart';
import 'package:pro_icon/Features/auth/role_selection/screens/role_selection_screen.dart';
import 'package:pro_icon/Features/custom_programs/my_programs/my_programs_screen.dart';
import 'package:pro_icon/Features/languges_screen/screen/languges_screen.dart';
import 'package:pro_icon/Features/programming_requst/screen/programming_request_screen.dart';

import '../../../Core/constants/app_assets.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsItems = [
      {
        'title': 'Edit Profile',
        'icon': Assets.assetsImagesProfileIcon
        ,
        'onTap': () => Navigator.pushNamed(context, ProfileScreen.routeName),
      },
      {
        'title': 'Mads',
        'icon': Assets.assetsImagesMadsIcon,
        'onTap': () => Navigator.pushNamed(
              context,
              MadsScreen.routeName,
            ),
      },
      {
        'title': 'Programming request',
        'icon': Assets.assetsImagesMyProgramsIcon,
        'requiredType': AdminEntity,
        'onTap': () =>
            Navigator.pushNamed(context, ProgrammingRequestScreen.routeName),
      },
      {
        'title': 'My Programs',
        'icon': Assets.assetsImagesMyProgramsIcon,
        'requiredType': ProgrammerEntity,
        'onTap': () => Navigator.pushNamed(context, MyProgramsScreen.routeName),
      },
      {
        'title': 'Language',
        'icon': Assets.assetsImagesLanguagesIcon,
        'onTap': () {
          Navigator.pushNamed(context, LangugesScreen.routeName);
        },
      },
      {
        'title': 'Logout',
        'icon': Assets.assetsImagesLogoutIcon,
        'onTap': () {
          // Perform logout
          context.read<UserStateCubit>().logOut();
          Navigator.pushNamedAndRemoveUntil(
              context, RoleSelectionScreen.routeName, (route) => false);
        },
      },
    ];

    return Padding(
      padding: SizeConstants.kScaffoldPadding(context),
      child: Column(
        children: [
          context.setMinSize(10).verticalSpace,
          const CustomHeaderWidget(),
          context.setMinSize(30).verticalSpace,
          const UserInfoSection(),
          context.setMinSize(20).verticalSpace,
          Expanded(
            child: ListView.builder(
              itemCount: settingsItems.length,
              itemBuilder: (context, index) {
                final item = settingsItems[index];
                final requiredType = item['requiredType'];

                // Only show BlocSelector if the item has a required type
                if (requiredType != null) {
                  return BlocSelector<UserStateCubit, UserStateState,
                      UserEntity>(
                    selector: (state) => state.currentUser!,
                    builder: (context, user) {
                      if (user.runtimeType == requiredType) {
                        return SettingsItem(
                          title: item['title'] as String,
                          icon: item['icon'] as String,
                          onTap: item['onTap'] as Function(),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  );
                }

                // Render the item directly if no user type is required
                return SettingsItem(
                  title: item['title'] as String,
                  icon: item['icon'] as String,
                  onTap: item['onTap'] as Function(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CustomHeaderWidget extends StatelessWidget {
  const CustomHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomHeader(
      titleKey: 'settings',
      isIconVisible: false,
    );
  }
}

class UserInfoSection extends StatelessWidget {
  const UserInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<UserStateCubit, UserStateState, UserEntity>(
      selector: (state) => state.currentUser!,
      builder: (context, user) {
        return Row(
          children: [
            CustomCircularImage(
              width: context.setMinSize(70),
              height: context.setMinSize(70),
              imageUrl: user.image!,
            ),
            context.setMinSize(16).horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.fullname!,
                  style: AppTextStyles.fontSize20(context).copyWith(
                    color: Colors.white,
                  ),
                ),
                context.setMinSize(8).verticalSpace,
                Text(
                  user.email!,
                  style: AppTextStyles.fontSize16(context).copyWith(
                    color: AppColors.white71Color,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class SettingsItem extends StatelessWidget {
  final String title;
  final String icon;
  final Function() onTap;

  const SettingsItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CustomSvgVisual(
        assetPath: icon,
        width: context.setMinSize(30),
        height: context.setMinSize(30),
      ),
      title: Text(
        title,
        style: AppTextStyles.fontSize18(context).copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing:
          const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 25),
      onTap: onTap,
    );
  }
}
