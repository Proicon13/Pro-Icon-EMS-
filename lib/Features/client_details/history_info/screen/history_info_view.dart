import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pro_icon/Core/widgets/base_app_Scaffold.dart';

import '../widgets/history_info_body.dart';

class HistoryInfoView extends StatelessWidget {
  const HistoryInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return  BaseAppScaffold(
      body: HistoryInfoBody()
    );
  }
}
