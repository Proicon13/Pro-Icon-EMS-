import 'package:flutter/cupertino.dart';
import 'package:pro_icon/Core/theme/app_text_styles.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Features/session_managment/session_summary/widget/session_card_widget.dart';

import '../../../../Core/constants/app_assets.dart';

class ParticipantsWidget extends StatelessWidget {
  const ParticipantsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: ListView.builder(
          itemCount: 4,
          itemBuilder: (context , index){
            return    Padding(
              padding: EdgeInsets.all(context.setMinSize(8)),
              child: const SessionCardSummary(
                imageUrl: Assets.assetsSessionSummaryUsereImage,
                userName: "omar Sabry",
                madsCount: "8",
                userAge: "26",
                userHeight: "173" ,
                userWeight: "70"  ,
                duration: "90",
                MinNumber: '70',
                MaxNumber: '100',
                KalNumber: "100",
                SvgPath: "${Assets.assetsSessionSummaryHeartIcon}",

                PrizeNumber: '100' ,
              ),
            );
          }
      ),
    );
  }
}
