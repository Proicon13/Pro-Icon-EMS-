import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../medical_report/widgets/section_title.dart';
import '../cubits/cubit/strategy_cubit.dart';

class TrainingTypesSectionTitle extends StatelessWidget {
  const TrainingTypesSectionTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<StrategyCubit, StrategyState, bool>(
      selector: (state) => state.isTrainingTypesopen!,
      builder: (context, state) {
        return SectionTitle(
          title: "training.type".tr(),
          onToggle: () {
            context.read<StrategyCubit>().toggleIsSectionOpen();
          },
          isOpen: state,
        );
      },
    );
  }
}
