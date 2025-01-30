import 'package:circular_seek_bar/circular_seek_bar.dart';
import 'package:flutter/material.dart';

class TimerCard extends StatelessWidget {
  final double size;
  final String value;
  final TextStyle textStyle;
  final num currentValue;
  final num fullValue;
  final bool isRed;

  const TimerCard({
    required this.size,
    required this.value,
    required this.textStyle,
    required this.currentValue,
    required this.fullValue,
    required this.isRed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ensure fullValue is not zero to avoid division by zero
    final double percentage = fullValue > 0 ? (currentValue / fullValue) : 0;

    return Stack(
      alignment: Alignment.center,
      children: [
        CircularSeekBar(
          width: size,
          height: size,
          progress: percentage * 100, // Safely calculated percentage
          barWidth: size * 0.06,
          startAngle: 0, // Start from top (12 o'clock position)
          sweepAngle: 360, // Full circle

          strokeCap: StrokeCap.round,
          progressGradientColors: isRed
              ? [const Color(0xFFDA393B), const Color(0xFFED847E)]
              : [const Color(0xFF1BC871), const Color(0xFF8DFF98)],
          trackColor: Colors.grey.shade300,
          innerThumbColor: Colors.white, // Always white
          innerThumbRadius: size * 0.04,
          outerThumbRadius: size * 0.05,
          outerThumbColor:
              isRed ? const Color(0xFFDA393B) : const Color(0xFF1BC871),
          outerThumbStrokeWidth: size * 0.01, // Slight border effect
          // animation: true,
        ),
        Text(
          value,
          style: textStyle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
