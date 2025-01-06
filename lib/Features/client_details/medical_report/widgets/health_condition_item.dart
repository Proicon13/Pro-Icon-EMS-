import 'package:flutter/material.dart';

import '../../../../Core/widgets/checkbox_item.dart';
import '../../../../data/models/health_condition.dart';

class HealthConditionItem extends StatelessWidget {
  final HealthCondition healthCondition;
  final bool isSelected;
  final VoidCallback onSelect;

  const HealthConditionItem({
    Key? key,
    required this.healthCondition,
    required this.isSelected,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckboxItem(
      key: ValueKey(healthCondition.id),
      isSelected: isSelected,
      onSelect: onSelect,
      title: healthCondition.name,
    );
  }
}
