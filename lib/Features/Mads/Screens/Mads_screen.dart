import 'package:flutter/material.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';
import 'package:pro_icon/Core/widgets/base_app_Scaffold.dart';
import 'package:pro_icon/Features/CategoryDetails/Widget/custom_app_bar.dart';
import 'package:pro_icon/Features/Mads/Widgets/card_Mads_Widget.dart';
import 'package:pro_icon/Features/Settings/Screens/settings_view.dart';

class MadsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseAppScaffold(
      body: Padding(
        padding: SizeConstants.kScaffoldPadding(context),
        child: Column(
          children: [
            context.setMinSize(10).verticalSpace,
            CustomAppBar(
              icon: Icons.arrow_back_ios,
              text: "Mads",
              onIconPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const SettingsView()));
              },
            ),
            const SizedBox(
              height: 25,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (contet, index) {
                    return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/session_activity");
                        },
                        child: const CardMadsWidget());
                  }),
            )
          ],
        ),
      ),
    );
  }
}
