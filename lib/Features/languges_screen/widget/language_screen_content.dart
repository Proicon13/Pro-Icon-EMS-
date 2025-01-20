import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Core/utils/responsive_helper/size_constants.dart';
import 'languges_list_content.dart';

class LanguageScreenContent extends StatelessWidget {
  LanguageScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: SizeConstants.kScaffoldPadding(context),
        child: LangugesListContent());
  }
}
