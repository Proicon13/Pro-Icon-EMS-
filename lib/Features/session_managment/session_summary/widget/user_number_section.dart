import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';

import 'kal_and_prize_secion.dart';
import 'minandmax_section.dart';

class UserNumberSection extends StatelessWidget {
  const UserNumberSection({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        // TODO: EXTRACT TO SEPERATE WIDGET (ICONPATH,TITLE )
        MinandmaxSection(minNumber: '20', maxNumber: '20', ),
        context.setMinSize(40).horizontalSpace,
        KalAndPrizeSecion(kalNumber: '100', prizeNumber: '80')
      ],
    );
  }
}
