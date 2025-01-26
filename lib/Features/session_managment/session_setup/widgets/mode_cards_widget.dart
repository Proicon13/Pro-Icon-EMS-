import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Features/session_managment/session_setup/widgets/session_mode_card.dart';

import '../../../../Core/constants/app_assets.dart';
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: modes.map((mode) {
        return SessionModeCard(
          mode: mode,
          isSelected: context.watch<SessionCubit>().state.selectedSessionMode ==
              mode['mode'],
        );
      }).toList(),
    );
  }
}
