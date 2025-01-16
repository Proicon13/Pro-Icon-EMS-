import 'package:flutter/material.dart';
import 'package:pro_icon/Core/widgets/base_app_scaffold.dart';
import 'package:pro_icon/Features/CategoryDetails/Widget/custom_app_bar.dart';
import 'package:pro_icon/Features/Settings/Screens/settings_view.dart';

import '../Widgets/card_Mads_Widget.dart';

class MadsScreen extends StatefulWidget {
  const MadsScreen({super.key});

  @override
  State<MadsScreen> createState() => _MadsScreenState();
}

class _MadsScreenState extends State<MadsScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: recode this screen to use sizeconfig for responsive
    return BaseAppScaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomAppBar(
              icon: Icons.arrow_back_ios,
              text: "MaDs",
              onIconPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const SettingsView()));
              },
            ),

            // remove this padding use padding wisley
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/session_activity');
                  },
                  child: const CardMadsWidget()),
            )
          ],
        ),
      ),
    );
  }
}
