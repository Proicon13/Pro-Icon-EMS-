
  import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pro_icon/Core/widgets/base_app_scaffold.dart';
import 'package:pro_icon/Features/CategoryDetails/Widget/custom_app_bar.dart';
import 'package:pro_icon/Features/Mads/Widgets/card_Mads_Widget.dart';
import 'package:pro_icon/Features/Settings/Screens/settings_Screen.dart';

class MadsScreen extends StatefulWidget {
    const MadsScreen({super.key});

    @override
    State<MadsScreen> createState() => _MadsScreenState();
  }

  class _MadsScreenState extends State<MadsScreen> {
    @override
    Widget build(BuildContext context) {
      return BaseAppScaffold(
          resizeToAvoidBottomInset: true,
          body: Column(
            children: [
              CustomAppBar(icon: Icons.arrow_back_ios, text: "MaDs" , onIconPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SettingsScreen()));
              },),
              CardMadsWidget()

            ],
          ),
      );
    }
  }
