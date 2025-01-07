import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/constants/app_assets.dart';
import 'package:pro_icon/Core/theme/app_colors.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/widgets/custom_svg_visual.dart';
import 'package:pro_icon/Features/main/cubit/cubit/main_cubit.dart';

class MainBottomNavBar extends StatelessWidget {
  final PageController pageController;

  const MainBottomNavBar({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.black,
          elevation: 0,
          currentIndex: MainSections.values.indexOf(state.currentSection),
          onTap: (index) {
            // Skip the placeholder (center button)
            if (index == 2) return;

            final selectedSection = MainSections.values[index];
            context.read<MainCubit>().changeSection(selectedSection);
            pageController.jumpToPage(index);
          },
          items: MainSections.values.map((section) {
            if (section == MainSections.start) {
              // Placeholder for the center floating button
              return const BottomNavigationBarItem(
                icon: SizedBox.shrink(),
                label: '',
              );
            }

            return BottomNavigationBarItem(
              icon: CustomSvgVisual(
                assetPath: _getIconPath(section),
                height: context.setMinSize(20),
                width: context.setMinSize(20),
                color: state.currentSection == section
                    ? AppColors.primaryColor
                    : Colors.white,
              ),
              label: _getLabel(section),
            );
          }).toList(),
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: Colors.white,
          selectedFontSize: context.setSp(12),
          unselectedFontSize: context.setSp(12),
        );
      },
    );
  }

  String _getLabel(MainSections section) {
    switch (section) {
      case MainSections.programs:
        return 'Programs';
      case MainSections.autoSessions:
        return 'Auto session';
      case MainSections.users:
        return 'User manager';
      case MainSections.settings:
        return 'Settings';
      default:
        return '';
    }
  }

  String _getIconPath(MainSections section) {
    switch (section) {
      case MainSections.programs:
        return Assets.assetsImagesProgramsIcon;
      case MainSections.autoSessions:
        return Assets.assetsImagesAutoSessionIcon;
      case MainSections.users:
        return Assets.assetsImagesUsersIcon;
      case MainSections.settings:
        return Assets.assetsImagesSettingsIcon;
      default:
        return '';
    }
  }
}
