import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pro_icon/Core/widgets/base_app_Scaffold.dart';

import '../widget/language_screen_content.dart';

class LangugesScreen extends StatelessWidget {
  static const routeName = '/Languges_screen';

  const LangugesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseAppScaffold(body: LanguageScreenContent());
  }
}
