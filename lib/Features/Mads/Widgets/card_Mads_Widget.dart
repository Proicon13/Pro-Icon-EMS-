import 'package:flutter/material.dart';
import 'package:pro_icon/Core/constants/app_assets.dart';
import 'package:pro_icon/Core/theme/app_text_styles.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';

import '../../../Core/utils/responsive_helper/size_config.dart';

class CardMadsWidget extends StatefulWidget {
  const CardMadsWidget({super.key});

  @override
  State<CardMadsWidget> createState() => _CardMadsWidgetState();
}

class _CardMadsWidgetState extends State<CardMadsWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO:recode this screen to use sizeconfig for responsive
    return SizedBox(
      height: 600,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            // TODO:recode this Mad card to use sizeconfig for responsive
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizeConfig(

                baseSize:  Size(398, 137),
                width: context.setMinSize(398) ,
                height: context.setMinSize(137) ,
                child: Builder(
                  builder: (context) {
                    return Container(
                      width: context.sizeConfig.width,
                      height: context.sizeConfig.height,
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(24),
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
                                  image: AssetImage("assets/images/layers 1.png")),
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

                                      Text(
                                        "No.",
                                        style: AppTextStyles.fontSize16(context).copyWith(
                                          color: Colors.white
                                        )
                                      ),
                                      SizedBox(width: 12),
                                      Text(
                                        "123456789",
                                        style: AppTextStyles.fontSize16(context).copyWith(
                                          color: Colors.white
                                        )
                                      ),
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
                                       Text(
                                        "5 Sessions",
                                        style: AppTextStyles.fontSize16(context).copyWith(
                                          color: Colors.white
                                        )
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizeConfig(
                                        baseSize: Size(68, 24),
                                        width: context.setMinSize(68),
                                        height: context.setMinSize(24),
                                        child: Builder(
                                            builder: (context) {
                                              return Container(
                                                  width: context.sizeConfig.width,
                                                  height: context.sizeConfig.height,

                                                  child: ElevatedButton(
                                                    onPressed: (){},
                                                    child: Text("active" , style: AppTextStyles.fontSize16(context).copyWith(
                                                        color: Colors.white
                                                    ),),
                                                    style: ButtonStyle(
                                                        backgroundColor: WidgetStatePropertyAll(Colors.green)
                                                    ),
                                                  ));
                                            }
                                        ),
                                      ),
                                      Image(image: AssetImage(Assets.assetsIconPowerForMads))
                                    ]
                                  )

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
                  }
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
