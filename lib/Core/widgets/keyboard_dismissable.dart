import 'package:flutter/material.dart';

class KeyboardDismissable extends StatelessWidget {
  final Widget child;
  final void Function()? onDismiss;
  const KeyboardDismissable({super.key, required this.child, this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onDismiss ?? () => FocusManager.instance.primaryFocus?.unfocus(),
      child: child,
    );
  }
}
