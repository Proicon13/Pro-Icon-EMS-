import 'package:flutter/material.dart';

class KeyboardDismissable extends StatelessWidget {
  final Widget child;
  const KeyboardDismissable({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: child,
    );
  }
}
