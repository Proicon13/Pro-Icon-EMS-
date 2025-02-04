import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_config.dart';
import 'package:pro_icon/Core/widgets/text_form_section.dart';

class ScoreDetailsSection extends StatelessWidget {
  const ScoreDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //TODO: NO NEED TO USE SIZE CONFIG HERE WE CAN JUST USE EXPANDED SINCE TEXT FORMSECTION TAKES SIZES FROM THE SCREEN ITSELF
        const Expanded(
          child: TextFormSection(
            title: " number",
            name: "15",
            hintText: "15",
          ),
        ),

        context.setMinSize(10).horizontalSpace,

        const Expanded(
          child: TextFormSection(
            title: "Invitations",
            name: "1",
            hintText: "1",
          ),
        ),
        context.setMinSize(10).horizontalSpace,

        const Expanded(
          child: TextFormSection(
            title: "Bonus",
            name: "1",
            hintText: "1",
          ),
        ),
      ],
    );
  }
}
