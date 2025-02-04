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
        Expanded(
          child: SizeConfig(
            baseSize: const Size(124, 180),
            width: context.setMinSize(124),
            height: context.setMinSize(180),
            child: SizedBox(
              width: context.sizeConfig.width,
              height: context.sizeConfig.height,
              child: const TextFormSection(
                title: " number",
                name: "15",
                hintText: "15",
              ),
            ),
          ),
        ),

        context.setMinSize(10).horizontalSpace,

        Expanded(
          child: SizeConfig(
            baseSize: const Size(124, 180),
            width: context.setMinSize(124),
            height: context.setMinSize(180),
            child: SizedBox(
              width: context.sizeConfig.width,
              height: context.sizeConfig.height,
              child: const TextFormSection(
                title: "Invitations",
                name: "1",
                hintText: "1",
              ),
            ),
          ),
        ),
        context.setMinSize(10).horizontalSpace,

        Expanded(
          child: SizeConfig(
            baseSize: const Size(124, 180),
            width: context.setMinSize(124),
            height: context.setMinSize(180),
            child: SizedBox(
              width: context.sizeConfig.width,
              height: context.sizeConfig.height,
              child: const TextFormSection(
                title: "Bonus",
                name: "1",
                hintText: "1",
              ),
            ),
          ),
        ),
      ],
    );
  }
}
