

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pro_icon/Core/theme/app_colors.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_config.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';

import 'package:pro_icon/Core/widgets/base_app_Scaffold.dart';
import 'package:pro_icon/Features/users/widgets/size_config_wrapper.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import 'char_data.dart';

class ChartsWidget extends StatelessWidget {
  const ChartsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseAppScaffold(
      body: SizeConfig(
        baseSize: Size(400, 255),
        width: context.setMinSize(400),
        height: context.setMinSize(255),
        child: Builder(
          builder: (context) {
            return Container(
              width: context.sizeConfig.width,
              height: context.sizeConfig.height,
              decoration: const  BoxDecoration(
                color: AppColors.darkGreyColor
              ),
              child: SfCartesianChart(


                primaryXAxis: CategoryAxis(
                  title: AxisTitle(text: 'MADs'),
                ),
                primaryYAxis: NumericAxis(
                  title: AxisTitle(text: 'Statistics'),
                  minimum: 0,
                  maximum: 80,
                  interval: 20,
                ),
                series: <ColumnSeries<ChartData, String>>[
                  ColumnSeries<ChartData, String>(
                    dataSource: [
                      ChartData('MAD1', 80),
                      ChartData('MAD2', 60),
                      ChartData('MAD3', 62),
                      ChartData('MAD4', 40),
                      ChartData('MAD5', 20),
                      ChartData('MAD6', 0),
                      ChartData('MAD7', 50),
                    ],
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    color: Colors.red,
                    dataLabelSettings: const  DataLabelSettings(isVisible: true , color: Colors.white),
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
