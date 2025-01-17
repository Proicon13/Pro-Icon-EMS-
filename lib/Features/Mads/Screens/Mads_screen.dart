import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pro_icon/Core/constants/app_assets.dart';
import 'package:pro_icon/Core/theme/app_colors.dart';
import 'package:pro_icon/Core/theme/app_text_styles.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_config.dart';
import 'package:pro_icon/Core/widgets/base_app_Scaffold.dart';
import 'package:pro_icon/Core/widgets/custom_header.dart';
import 'package:pro_icon/Features/CategoryDetails/Widget/custom_app_bar.dart';
import 'package:pro_icon/Features/Mads/Widgets/card_Mads_Widget.dart';
import 'package:pro_icon/Features/Settings/Screens/settings_view.dart';
import 'package:pro_icon/Features/home/screens/home_view.dart';


class MadsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BaseAppScaffold(

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 30,),
           CustomAppBar(icon: Icons.arrow_back_ios, text: "Mads" , onIconPressed: (){
             Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SettingsView()));
           },),

            SizedBox(height: 25,),
            // Card 1: Active
           SizedBox(
             height: 500,
             child: ListView.builder(
               itemCount: 2,
                 itemBuilder: (contet , index)
                 {
                   return InkWell(
                     onTap: (){
                       Navigator.pushNamed(context, "/session_activity");
                     },
                       child: CardMadsWidget()
                   );
                 }
             ),
           )
          ],
        ),
      ),
    );
  }
}


