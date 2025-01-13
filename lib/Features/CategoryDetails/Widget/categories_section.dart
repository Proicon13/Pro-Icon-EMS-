import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/entities/category_entity.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';

import '../../home/widgets/category_card.dart';
import '../Cubit/category_details_cubit.dart';

class CategoriesListSection extends StatelessWidget {
  const CategoriesListSection({
    super.key,
    required this.categories,
  });

  final List<CategoryEntity> categories;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CategoryDetailsCubit, CategoryDetailsState, int>(
      selector: (state) => state.currentCategoryIndex!,
      builder: (context, selectedIndex) {
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(left: context.setMinSize(16)),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final currentCategory = categories[index];
            return CategoryItem(
              category: currentCategory,
              isSelected: index == selectedIndex,
              onTap: () {
                context
                    .read<CategoryDetailsCubit>()
                    .onCategoryChanged(currentCategory, index);
              },
            );
          },
        );
      },
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  final CategoryEntity category;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedScale(
        scale: isSelected ? 1 : 0.7,
        duration: const Duration(milliseconds: 300),
        child: AnimatedOpacity(
          opacity: isSelected ? 1 : 0.65,
          duration: const Duration(milliseconds: 300),
          child: CategoryCard(
            currentCategory: category,
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
