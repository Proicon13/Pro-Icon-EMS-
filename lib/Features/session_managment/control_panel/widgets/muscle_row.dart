import 'package:flutter/material.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';

import '../../../../Core/widgets/counter_row.dart';
import '../../../../Core/widgets/custom_circular_image.dart';

class MuscleRow extends StatelessWidget {
  final int value;
  final String imagePath;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const MuscleRow({
    required this.value,
    required this.imagePath,
    required this.onIncrement,
    required this.onDecrement,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: context.setMinSize(10),
      ),
      child: Row(
        children: [
          CustomCircularImage(
            width: context.setMinSize(40),
            height: context.setMinSize(40),
            imageUrl: imagePath,
          ),
          const Spacer(),
          CounterRow(
            count: value,
            size: context.setMinSize(28),
            onIncrement: onIncrement,
            onDecrement: onDecrement,
          ),
        ],
      ),
    );
  }
}
