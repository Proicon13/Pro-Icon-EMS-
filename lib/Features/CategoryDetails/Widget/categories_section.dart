import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';

import '../../../data/models/categories_model.dart';
import '../../home/widgets/category_card.dart';
import '../Cubit/category_details_cubit.dart';

class CategoriesListSection extends StatelessWidget {
  const CategoriesListSection({
    super.key,
    required this.categories,
  });

  final List<Categories> categories;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CategoryDetailsCubit, CategoryDetailsState, int>(
      selector: (state) {
        return state.currentCategoryIndex!;
      },
      builder: (context, state) {
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(left: context.setMinSize(16)),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final currentCategory = categories[index];
            return AnimatedScale(
              scale: index == state ? 1 : 0.8,
              duration: const Duration(milliseconds: 400),
              child: AnimatedOpacity(
                opacity: index == state ? 1 : 0.65,
                duration: const Duration(milliseconds: 400),
                child: CategoryCard(
                  currentCategory: currentCategory,
                  onTap: () {
                    context
                        .read<CategoryDetailsCubit>()
                        .onCategoryChanged(categories[index], index);
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
