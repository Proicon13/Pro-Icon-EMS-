import 'package:flutter/material.dart';
import 'package:pro_icon/Features/users/widgets/user_variation_column.dart';

class ClientSectionTitle extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Function() onTap;
  const ClientSectionTitle(
      {super.key,
      required this.title,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return UserVariationColumn(
        userVariation: title, isSelected: isSelected, onTap: onTap);
  }
}
