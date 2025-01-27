import 'package:flutter/material.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';

class CounterRow extends StatelessWidget {
  final num count;
  final double? size;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CounterRow({
    Key? key,
    required this.count,
    this.size,
    required this.onIncrement,
    required this.onDecrement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Decrement Button
        GestureDetector(
          onTap: onDecrement,
          child: Container(
            width: size ?? context.setMinSize(28),
            height: size ?? context.setMinSize(28),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(context.setMinSize(8)),
            ),
            child: Icon(
              Icons.remove,
              size: size != null ? size! / 2 : context.setMinSize(14),
              color: Colors.black,
            ),
          ),
        ),

        // Count Display
        SizedBox(
          width: context.setMinSize(45),
          child: Center(
            child: Text(
              count is double ? count.toStringAsFixed(1) : count.toString(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: context.setMinSize(14),
              ),
            ),
          ),
        ),

        // Increment Button
        GestureDetector(
          onTap: onIncrement,
          child: Container(
            width: size ?? context.setMinSize(28),
            height: size ?? context.setMinSize(28),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(context.setMinSize(8)),
            ),
            child: Icon(
              Icons.add,
              size: size != null ? size! / 2 : context.setMinSize(14),
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
