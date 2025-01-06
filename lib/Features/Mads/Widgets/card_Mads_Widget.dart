
  import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pro_icon/Core/widgets/custom_asset_image.dart';

import '../../../Core/constants/app_assets.dart';

class CardMadsWidget extends StatefulWidget {
    const CardMadsWidget({super.key});

    @override
    State<CardMadsWidget> createState() => _CardMadsWidgetState();
  }

  class _CardMadsWidgetState extends State<CardMadsWidget> {
    @override
    Widget build(BuildContext context) {
      return SizedBox(
        height: 600,
        child: ListView.builder(
            itemBuilder: (context , index)
            {
              return Card(
                child: Container(
                  width: 398,
                  height: 137,
                  decoration: BoxDecoration(
                    color: Colors.grey[800]
                  ),
                  child: Row(
                    children: [
                     Image(image: AssetImage("assets/images/layers 1.png")),
                      Column(
                        children: [
                          Row(children: [
                            Text("No."),
                            Text("123456789534")
                          ],)
                        ],
                      ),
                    ],
                  ) ,
                ),
              );
            }
        ),
      );
    }
  }
