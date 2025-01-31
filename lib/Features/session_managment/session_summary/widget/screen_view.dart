import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pro_icon/Features/session_managment/session_summary/widget/participants_widget.dart';

import 'charts_widget.dart';

class ScreenView extends StatelessWidget {
  const ScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(
          children: [ParticipantsWidget(), ChartsWidget()]),
    );
  }
}
