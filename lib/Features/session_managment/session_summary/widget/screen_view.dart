import 'package:flutter/material.dart';
import 'package:pro_icon/Features/session_managment/session_summary/widget/participants_widget.dart';

import 'charts_widget.dart';

// TODO: FOCUS ON NAMING CONVENTIONS IN ALL WIDGETS AND FILES REVISE ALL
class ScreenView extends StatelessWidget {
  const ScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: TabBarView(children: [ParticipantsWidget(), ChartsWidget()]),
    );
  }
}
