import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Features/CategoryDetails/Screens/Category_details.dart';

import '../../../Core/widgets/custom_loader.dart';
import '../cubit/home_cubit.dart';
import 'category_card.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (BuildContext context, state) {
        if (state is CategoryError) {
          return SizedBox(
              height: context.setMinSize(300),
              child: Center(child: Text("${state.errorMessage}")));
        }
        if (state is CategoryLoaded) {
          return _buildCategoriesGrid(state, context);
        } else {
          return SizedBox(
            height: context.setMinSize(300),
            child: const CustomLoader(),
          );
        }
      },
    );
  }

  GridView _buildCategoriesGrid(CategoryLoaded state, BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: state.categories.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: context.setMinSize(5),
        mainAxisSpacing: context.setMinSize(10),
      ),
      itemBuilder: (context, index) {
        final currentCategory = state.categories[index];
        return CategoryCard(
            onTap: () {
              Navigator.pushNamed(context, CategoryDetails.routeName,
                  arguments: [state.categories, index]);
            },
            currentCategory: currentCategory);
      },
    );
  }
}
