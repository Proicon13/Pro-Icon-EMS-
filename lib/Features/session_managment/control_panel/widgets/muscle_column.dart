import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Features/session_managment/control_panel/cubits/cubit/control_panel_cubit.dart';

import 'muscle_row.dart';

class MuscleColumn extends StatelessWidget {
  final List<MapEntry<String, int>> muscleEntries;

  const MuscleColumn({required this.muscleEntries, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ControlPanelCubit>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: muscleEntries.map((entry) {
        return MuscleRow(
          value: entry.value,
          imagePath: "", // Add appropriate image paths if available
          onIncrement: () {
            cubit.adjustMuscleValue(entry.key, true);
          },
          onDecrement: () {
            if (entry.value > 0) cubit.adjustMuscleValue(entry.key, false);
          },
        );
      }).toList(),
    );
  }
}
