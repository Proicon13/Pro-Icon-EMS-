import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: modes.map((mode) {
        return SessionModeCard(
          mode: mode,
          onTap: () =>
              context.read<SessionCubit>().selectSessionMode(mode['mode']),
          isSelected: context.watch<SessionCubit>().state.selectedSessionMode ==
              mode['mode'],
        );
      }).toList(),
    );
  }
}
