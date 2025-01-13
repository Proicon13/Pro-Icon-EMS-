import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/entities/category_entity.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';
import 'package:pro_icon/Core/widgets/base_app_Scaffold.dart';
import 'package:pro_icon/Core/widgets/custom_header.dart';
import 'package:pro_icon/Features/CategoryDetails/Cubit/category_details_cubit.dart';

import '../../../Core/dependencies.dart';
import '../Widget/categories_section.dart';
import '../Widget/programs_list_section.dart';

class CategoryDetails extends StatefulWidget {
  static const routeName = "/Category-details";
  const CategoryDetails(
      {super.key, required this.categories, required this.currentIndex});
  final List<CategoryEntity> categories;
  final int currentIndex;

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoryDetailsCubit>(
      create: (context) => getIt<CategoryDetailsCubit>()
        ..intialize(
            widget.categories[widget.currentIndex], widget.currentIndex),
      child: BaseAppScaffold(
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(height: context.setMinSize(20)),
            ),
            SliverPadding(
              padding: SizeConstants.kScaffoldPadding(context),
              sliver: SliverToBoxAdapter(
                child: CustomHeader(
                    titleKey: widget.categories[widget.currentIndex].name!),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: context.setMinSize(30)),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: context.screenHeight * 0.15,
                child: CategoriesListSection(categories: widget.categories),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: context.setMinSize(30)),
            ),
            const ProgramsListSection(),
          ],
        ),
      ),
    );
  }
}
