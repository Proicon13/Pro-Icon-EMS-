import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../Core/utils/enums/training_types.dart';
import '../../../../Core/widgets/checkbox_item.dart';
import '../../../../Core/widgets/custom_snack_bar.dart';
import '../cubits/cubit/strategy_cubit.dart';

class TrainingTypesList extends StatelessWidget {
  const TrainingTypesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StrategyCubit, StrategyState>(
      listener: (context, state) {
        if (state.strategyStatus == StrategyStatus.error) {
          buildCustomAlert(context, state.message!, Colors.red);
        }
      },
      buildWhen: (previous, current) =>
          previous.currentTrainingType != current.currentTrainingType ||
          previous.strategyStatus != current.strategyStatus ||
          previous.isTrainingTypesopen != current.isTrainingTypesopen,
      builder: (context, state) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          child: state.isTrainingTypesopen!
              ? _buildTrainingTypesList(context, state)
              : const SizedBox.shrink(),
        );
      },
    );
  }

  Widget _buildTrainingTypesList(BuildContext context, StrategyState state) {
    final isLoading = state.strategyStatus == StrategyStatus.loading;
    final itemCount = isLoading ? 3 : TrainingTypes.values.length;

    return Skeletonizer(
      enabled: isLoading,
      child: ListView.builder(
        key: isLoading
            ? const ValueKey("loading-training-types-list")
            : const ValueKey("training-types-list"),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          final title = isLoading
              ? "Loading Training Type $index"
              : TrainingTypes.values[index].title;

          final key = ValueKey(isLoading
              ? "loading-$index"
              : "success-${TrainingTypes.values[index].jsonName}");

          return Container(
            margin: EdgeInsets.only(bottom: context.setMinSize(30)),
            child: CheckboxItem(
              key: key,
              isSelected: !isLoading &&
                  TrainingTypes.values[index] == state.currentTrainingType,
              onSelect: () {
                if (!isLoading) {
                  context
                      .read<StrategyCubit>()
                      .setTrainingType(TrainingTypes.values[index]);
                }
              },
              title: title,
            ),
          );
        },
      ),
    );
  }
}
