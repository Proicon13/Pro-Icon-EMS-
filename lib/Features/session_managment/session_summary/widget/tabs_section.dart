import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabsSection extends StatelessWidget {
  const TabsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
        child:  TabBar(
            indicatorColor: Colors.red,
            labelColor: Colors.white,
            dividerHeight: 0,
            tabs: [
              Tab(
                text: "Participants".tr(),
              ),
              Tab(
                text: "Statistics".tr(),
              ),
            ]));
  }
}
