import 'package:flutter/material.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';

import '../theme/app_text_styles.dart';

class CheckboxItem extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onSelect;
  final String title;

  const CheckboxItem({
    Key? key,
    required this.isSelected,
    required this.onSelect,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelect(),
      child: Row(
        children: [
          Container(
            width: context.setMinSize(25),
            height: context.setMinSize(25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(context.setMinSize(5)),
              border: Border.all(color: Colors.white, width: 2),
              color: isSelected ? Colors.white : Colors.transparent,
            ),
            child: isSelected
                ? Icon(
                    Icons.check,
                    color: Colors.black,
                    size: context.setMinSize(20),
                  )
                : null,
          ),
          context.setMinSize(10).horizontalSpace,
          Text(
            title,
            style:
                AppTextStyles.fontSize16(context).copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
