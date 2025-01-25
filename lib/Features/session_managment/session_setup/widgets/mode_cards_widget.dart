import 'package:flutter/material.dart';

import 'package:pro_icon/Features/session_managment/session_setup/widgets/session_mode_card.dart';

import '../../../../Core/constants/app_assets.dart';


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
        return SessionModeCard(mode: mode, context: context);
      }).toList(),
    );
  }
}


