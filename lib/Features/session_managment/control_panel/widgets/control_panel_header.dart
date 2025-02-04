import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/widgets/custom_confirmation_dialog.dart';
import 'package:pro_icon/Features/session_managment/control_panel/cubits/cubit/control_panel_cubit.dart';

import '../../../../Core/constants/app_assets.dart';
import '../../../../Core/utils/responsive_helper/size_config.dart';
import '../../../../Core/widgets/custom_asset_image.dart';
import '../../../custom_programs/manage_program/cubits/cubit/manage_custom_program_cubit.dart';
import '../../../main/main_screen.dart';
import '../../session_summary/screen/session_summary.dart';

class ControlPanelHeader extends StatelessWidget {
  const ControlPanelHeader({
    super.key,
  });

  @override
  Widget build(BuildContext ctx) {
    final cubit = ctx.read<ControlPanelCubit>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ctx.setMinSize(16).horizontalSpace,
        GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: ctx.setSp(24), // Responsive size for the icon
          ),
          onTap: () {
            final isSavingSession =
                cubit.state.saveSessionStatus == RequetsStatus.loading;

            if (isSavingSession) return;
            showDialog(
                context: ctx,
                builder: (context) {
                  return CustomConfirmationDialog(
                      title: "Are you sure you want to exit?",
                      confirmationTitle: "Yes, Exit",
                      onConfirm: () async {
                        final isSessionCounted = cubit.state.isSessionCounted;
                        Navigator.pop(context);

                        if (isSessionCounted) {
                          cubit.stopSession(true);
                          final session = await cubit.saveSession();
                          Future.delayed(const Duration(seconds: 3), () {
                            if (ctx.mounted) {
                              Navigator.pushReplacementNamed(
                                  ctx, SessionSummary.routeName,
                                  arguments: session);
                            }
                          });
                        } else {
                          Navigator.popUntil(
                              ctx, ModalRoute.withName(MainScreen.routeName));
                        }
                      });
                });
          },
        ),
        // Pushes the title to the center
        Expanded(
            child: SizeConfig(
          baseSize: const Size(128, 40),
          width: ctx.setMinSize(128), // width of logo
          height: ctx.setMinSize(40), // height of logo
          child: Builder(builder: (context) {
            //new context to get parent size
            return SizedBox(
              width: context.sizeConfig.width, // take full scaled width
              height: context.sizeConfig.height,
              child: AspectRatio(
                aspectRatio:
                    context.sizeConfig.width / context.sizeConfig.height,
                child: const CustomAssetImage(
                  path: Assets.assetsImagesLogo,
                  fit: BoxFit.contain,
                ),
              ),
            );
          }),
        )),
        // Ensures symmetry on the right
      ],
    );
  }
}
