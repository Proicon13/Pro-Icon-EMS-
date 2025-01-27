import 'package:flutter/material.dart';

import 'muscle_row.dart';

class MuscleColumn extends StatelessWidget {
  final List<MapEntry<String, int>> muscleEntries;

  const MuscleColumn({required this.muscleEntries, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: muscleEntries.map((entry) {
        return MuscleRow(
          value: entry.value,
          imagePath: "", // Add appropriate image paths if available
          onIncrement: () {},
          onDecrement: () {
            if (entry.value > 0) {}
          },
        );
      }).toList(),
    );
  }
}
