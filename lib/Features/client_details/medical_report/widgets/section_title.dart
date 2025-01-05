import 'package:flutter/material.dart';
import 'package:pro_icon/Core/theme/app_text_styles.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final bool isOpen;
  final VoidCallback onToggle;

  const SectionTitle({
    Key? key,
    required this.title,
    this.isOpen = true,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyles.fontSize16(context)
              .copyWith(fontWeight: FontWeight.w500, color: Colors.white),
        ),
        GestureDetector(
          onTap: onToggle,
          child: Icon(
            isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            color: Colors.white,
            size: context.setMinSize(20),
          ),
        )
      ],
    );
  }
}
