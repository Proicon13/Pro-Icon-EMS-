import 'package:flutter/material.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';

import '../../../Core/utils/responsive_helper/size_constants.dart';
import 'client_details_section.dart';

class ClientDetailsBody extends StatelessWidget {
  const ClientDetailsBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: SizeConstants.kScaffoldPadding(context),
        child: Column(
          children: [
            context.setMinSize(50).verticalSpace,
            const ClientDetailsSection()
          ],
        ));
  }
}
