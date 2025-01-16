import 'package:flutter/material.dart';
import 'package:pro_icon/Core/constants/app_assets.dart';
import 'package:pro_icon/Core/theme/app_text_styles.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';

import '../../../Core/utils/responsive_helper/size_config.dart';

class CardMadsWidget extends StatefulWidget {
  //TODO: use named routes for navigation (add route name here)

  const CardMadsWidget({super.key});

  @override
  State<CardMadsWidget> createState() => _CardMadsWidgetState();
}

class _CardMadsWidgetState extends State<CardMadsWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO:recode this screen to use sizeconfig for responsive
    return SizedBox(
      height: 600, // Why to put specfic height ?? // you can use
      child: Padding(
        padding: const EdgeInsets.all(
            8.0), // why to put specific padding too many paddings ?? instead wrap the scaffold once with one padding
        child: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            // TODO:recode this Mad card to use sizeconfig for responsive

            // TODO: Add gesture detector here to navigate to activity screen and remove it from the entire list view
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizeConfig(
                baseSize: const Size(398, 137),
                width: context.setMinSize(398),
                height: context.setMinSize(137),
                child: Builder(builder: (context) {
                  return Container(
                    width: context.sizeConfig.width,
                    height: context.sizeConfig.height,
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(
                          24), // Adjust the radius to use context.setMinSize() also for any padding or spaces
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 20),
                            // TODO:use svg for icons and use CustomSvgVisual widget for all icons
                            child: Image(
                                image: AssetImage(
                                    "assets/images/layers 1.png")), //use customAssetImage and set height and width for it to be scaled using context.setSizeMin
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    // TODO: USE APPTEXTSTYLES fonts
                                    // TODO: Used APPTEXTSTYLES fonts

                                    Text("No.",
                                        style: AppTextStyles.fontSize16(context)
                                            .copyWith(color: Colors.white)),
                                    const SizedBox(width: 12),
                                    Text("123456789",
                                        style: AppTextStyles.fontSize16(context)
                                            .copyWith(color: Colors.white)),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/Vector (1).png",
                                      width: 20,
                                      height: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text("5 Sessions",
                                        style: AppTextStyles.fontSize16(context)
                                            .copyWith(color: Colors.white)),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // this widget is inside card so it should take heights and widths based on parent size config

                                      // TODO: REMOVE THIS SIZECONFIG here and use context.setMinSize for width and height ,
                                      SizeConfig(
                                        baseSize: const Size(68, 24),
                                        width: context.setMinSize(68),
                                        height: context.setMinSize(24),
                                        child: Builder(builder: (context) {
                                          return Container(
                                              width: context.sizeConfig.width,
                                              height: context.sizeConfig.height,
                                              child: ElevatedButton(
                                                onPressed: () {},
                                                child: Text(
                                                  "active",
                                                  style: AppTextStyles
                                                          .fontSize16(context)
                                                      .copyWith(
                                                          color: Colors.white),
                                                ),
                                                style: const ButtonStyle(
                                                    backgroundColor:
                                                        WidgetStatePropertyAll(
                                                            Colors.green)),
                                              ));
                                        }),
                                      ),
                                      const Image(
                                          image: AssetImage(
                                              Assets.assetsIconPowerForMads))
                                    ])
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            );
          },
        ),
      ),
    );
  }
}
