import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';

import '../../users/widgets/user_variation_column.dart';
import '../cubits/auto_sessions_cubit.dart';
import '../cubits/custom_auto_session_cubit.dart';

class AutoSessionVariationSection extends StatelessWidget {
  final CustomAutoSessionCubit customAutoSessionCubit;
  final AutoSessionsCubit autoSessionsCubit;
  const AutoSessionVariationSection({
    super.key,
    required this.customAutoSessionCubit,
    required this.autoSessionsCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocSelector<AutoSessionsCubit, AutoSessionsState, bool>(
          selector: (state) => state.currentSessionSection == AutoSession.main,
          builder: (context, state) {
            return UserVariationColumn(
              onTap: () {
                autoSessionsCubit.changeSessionSection(AutoSession.main);
              },
              isSelected: state,
              userVariation: "mainAuto.title".tr(),
            );
          },
        ),
        context.setMinSize(20).horizontalSpace,
        BlocSelector<AutoSessionsCubit, AutoSessionsState, bool>(
          selector: (state) =>
              state.currentSessionSection == AutoSession.custom,
          builder: (context, state) {
            return UserVariationColumn(
              onTap: () {
                autoSessionsCubit.changeSessionSection(AutoSession.custom);
                customAutoSessionCubit.fetchCustomSessions(isFirstFetch: true);
              },
              isSelected: state,
              userVariation: "customAuto.title".tr(),
            );
          },
        ),
      ],
    );
  }
}
