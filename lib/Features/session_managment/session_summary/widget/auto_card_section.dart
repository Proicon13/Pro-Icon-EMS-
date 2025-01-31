import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:pro_icon/Core/utils/enums/gender.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';

import '../../../../Core/constants/app_assets.dart';
import '../../../../Core/utils/responsive_helper/size_config.dart';
import 'auto_session_card.dart';

class AutoCardSection extends StatelessWidget {
  const AutoCardSection({super.key});

  @override
  Widget build(BuildContext context) {
    return  SizeConfig(
      baseSize: const Size(400, 120),
      width: context.setMinSize(400),
      height: context.setMinSize(120),
      child: Builder(builder: (context) {
        return  AutoSessionCard(
          title: 'Automatic session'.tr(),
          hzValue: '80 HZ',
          puValue: 'Pu 550',
          madsCount: '3 mads',
          duration: '15 min'.tr(),
          imageUrl: '${Assets.assetsSessionSummaryImage}',
        );
      }),
    );
  }
}
