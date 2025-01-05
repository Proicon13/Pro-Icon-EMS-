import 'package:flutter/material.dart';
import 'package:pro_icon/Core/theme/app_text_styles.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';

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
    return GestureDetector(
      onTap: () => onSelect(),
      child: Row(
        key: ValueKey(healthCondition.id),
        children: [
          Container(
            width: context.setMinSize(25),
            height: context.setMinSize(25),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(color: Colors.white, width: 2),
              color: isSelected ? Colors.white : Colors.transparent,
            ),
            child: isSelected
                ? Icon(
                    Icons.check,
                    color: Colors.black,
                    size: context.setMinSize(17),
                  )
                : null,
          ),
          context.setMinSize(10).horizontalSpace,
          Text(
            healthCondition.name,
            style:
                AppTextStyles.fontSize14(context).copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
