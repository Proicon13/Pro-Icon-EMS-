import 'package:flutter/cupertino.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Features/session_managment/session_summary/widget/session_card_widget.dart';

import '../../../../Core/constants/app_assets.dart';

class ParticipantsWidget extends StatelessWidget {
  const ParticipantsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, index) =>
            context.setMinSize(15).verticalSpace,
        itemCount: 4,
        itemBuilder: (context, index) {
          return const SessionCardSummary(
            imageUrl: Assets.assetsSessionSummaryUsereImage,
            duration: "90",
          );
        });
  }
}
