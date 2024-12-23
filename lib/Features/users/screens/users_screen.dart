import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pro_icon/Core/widgets/base_app_scaffold.dart';
import 'package:pro_icon/Core/widgets/custom_app_bar.dart';

import '../widgets/user_screen_body.dart';

class UsersScreen extends StatelessWidget {
  static const routeName = '/users-screen';
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseAppScaffold(
      appBar: CustomAppBar(
        titleKey: "userManagment.screen.title".tr(),
      ),
      body: const UsersScreenBody(),
    );
  }
}
