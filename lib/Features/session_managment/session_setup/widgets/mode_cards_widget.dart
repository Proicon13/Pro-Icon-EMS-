import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Features/session_managment/session_setup/widgets/session_mode_card.dart';

import '../../../../Core/constants/app_assets.dart';
import '../cubits/cubit/session_setup_cubit.dart';
import '../cubits/cubit/session_setup_state.dart';

class ModeCardsWidget extends StatelessWidget {
  final List<Map<String, dynamic>> modes = const [
    {
      'mode': SessionControlMode.program,
      'icon': Assets.assetsImagesProgramsIcon,
      'label': 'Program',
    },
    {
      'mode': SessionControlMode.auto,
      'icon': Assets.assetsImagesAutoSessionIcon,
      'label': 'Auto session',
    },
  ];
  const ModeCardsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Expanded(
        child: SessionModeCard(
          mode: modes[0],
          onTap: () =>
              context.read<SessionCubit>().selectSessionMode(modes[0]['mode']),
          isSelected: context.watch<SessionCubit>().state.selectedSessionMode ==
              modes[0]['mode'],
        ),
      ),
      context.setMinSize(50).horizontalSpace,
      Expanded(
        child: SessionModeCard(
          mode: modes[1],
          onTap: () =>
              context.read<SessionCubit>().selectSessionMode(modes[1]['mode']),
          isSelected: context.watch<SessionCubit>().state.selectedSessionMode ==
              modes[1]['mode'],
        ),
      )
    ]);
  }
}
