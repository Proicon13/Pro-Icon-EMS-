import 'package:flutter/material.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';

import '../../../../data/models/health_condition.dart';
import 'health_condition_item.dart';

class HealthConditionGrid extends StatelessWidget {
  final List<HealthCondition> healthConditions;
  final List<HealthCondition> selectedConditions;
  final ValueChanged<int> onSelect;
  final int itemCount;
  final bool isLoading;

  const HealthConditionGrid({
    Key? key,
    required this.healthConditions,
    required this.selectedConditions,
    required this.onSelect,
    required this.itemCount,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: context.setMinSize(10),
          crossAxisSpacing: context.setMinSize(80),
          childAspectRatio: context.setMinSize(110) / context.setMinSize(30)),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (isLoading) {
          return HealthConditionItem(
              healthCondition: HealthCondition(id: index, name: "loading"),
              isSelected: false,
              onSelect: () {});
        } else {
          final condition = healthConditions[index];
          final isSelected =
              selectedConditions.any((c) => c.id == condition.id);

          return HealthConditionItem(
            healthCondition: condition,
            isSelected: isSelected,
            onSelect: () => onSelect(condition.id),
          );
        }
      },
    );
  }
}
