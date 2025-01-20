import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/dependencies.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';
import 'package:pro_icon/Core/widgets/base_app_Scaffold.dart';
import 'package:pro_icon/Core/widgets/custom_header.dart';
import 'package:pro_icon/Features/Mads/Cubit/mads_cubit.dart';

import '../Widgets/mads_list_section.dart';

class MadsScreen extends StatelessWidget {
  static const String routeName = "/mads-screen";
  const MadsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MadsCubit>(
      create: (context) => getIt<MadsCubit>()..processMads(),
      child: BaseAppScaffold(
        body: Padding(
          padding: SizeConstants.kScaffoldPadding(context),
          child: Column(
            children: [
              context.setMinSize(30).verticalSpace,
              CustomHeader(titleKey: "madsscreen.title".tr()),
              context.setMinSize(10).verticalSpace,
              const MadsListSection(),
            ],
          ),
        ),
      ),
    );
  }
}
