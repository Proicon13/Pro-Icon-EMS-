import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onIconPressed;

  const CustomAppBar({
    super.key,
    required this.icon,
    required this.text,
    this.onIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Row(
        children: [
          IconButton(
            icon: Icon(icon, color: Colors.grey),
            onPressed: onIconPressed ?? () {},
          ),
          Expanded(
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }
}
