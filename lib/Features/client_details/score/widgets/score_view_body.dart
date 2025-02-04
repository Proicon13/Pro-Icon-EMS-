import 'package:flutter/material.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Features/Mads/session_details/widgets/choose_date_widget.dart';
import 'package:pro_icon/Features/client_details/score/widgets/score_details_section.dart';

class ScoreViewBody extends StatelessWidget {
  const ScoreViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ChooseDateWidget(),
          context.setMinSize(15).verticalSpace,
          const Divider(
            thickness: 1,
            color: Colors.grey,
          ),
          const ScoreDetailsSection()
        ],
      ),
    );
  }
}
