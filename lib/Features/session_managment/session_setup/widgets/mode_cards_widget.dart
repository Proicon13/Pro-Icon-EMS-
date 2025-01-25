import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';

import '../../../../Core/constants/app_assets.dart';
import '../../../../Core/theme/app_colors.dart';
import '../../../../Core/theme/app_text_styles.dart';
import '../../../../Core/utils/responsive_helper/size_config.dart';
import '../../../../Core/widgets/custom_svg_visual.dart';
import '../cubits/cubit/session_setup_cubit.dart';

class ModeCardsWidget extends StatelessWidget {
  final List<Map<String, dynamic>> modes = const [
    {
      'mode': 'Program',
      'icon': Assets.assetsForProgramIcon,
      'label': 'Program',
    },
    {
      'mode': 'Auto session',
      'icon': Assets.assetsForautoSessionIcon,
      'label': 'Auto session',
    },
  ];
  const ModeCardsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: modes.map((mode) {
        return GestureDetector(
          onTap: () {
            context.read<SessionCubit>().selectSessionMode(mode['mode']);
          },
          child: SizeConfig(
            baseSize: const Size(170, 165),
            width: context.setMinSize(170),
            height: context.setMinSize(165),
            child: Builder(
              builder: (context) {
                // TODO: refactor this to a separate widget SessionModeCard and pass the required parameters
                return Container(
                  width: context.sizeConfig.width,
                  height: context.sizeConfig.height,
                  margin: EdgeInsets.only(
                      right: context.setMinSize(30)), // مسافة بين الـ modes
                  decoration: BoxDecoration(
                    color: AppColors.darkGreyColor,
                    border: context
                                .watch<SessionCubit>()
                                .state
                                .selectedSessionMode ==
                            mode['mode']
                        ? Border.all(
                            color: Colors.red,
                            width: 2,
                          )
                        : null,
                  ),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: CustomSvgVisual(
                              assetPath: mode['icon'],
                              width: context.setMinSize(65),
                              height: context.setMinSize(65),
                            ),
                          ),
                          context.setMinSize(15).verticalSpace,
                          Text(
                            mode['label'],
                            style: AppTextStyles.fontSize16(context).copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      if (context
                              .watch<SessionCubit>()
                              .state
                              .selectedSessionMode ==
                          mode['mode']) // علامة "Selected"
                        Positioned(
                          top: 0, // توضع العلامة من فوق
                          right: 0, // توضع العلامة على اليمين
                          child: CustomSvgVisual(
                            assetPath: Assets.assetsSelectedIcon,
                            width: context.setMinSize(24), // حجم الأيقونة
                            height: context.setMinSize(24),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      }).toList(),
    );
  }
}
