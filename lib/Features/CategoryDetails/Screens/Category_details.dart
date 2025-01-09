import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_config.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';
import 'package:pro_icon/Core/widgets/base_app_Scaffold.dart';
import 'package:pro_icon/Core/widgets/custom_header.dart';
import 'package:pro_icon/Core/widgets/empty_state_widget.dart';
import 'package:pro_icon/Features/CategoryDetails/Cubit/category_details_cubit.dart';
import 'package:pro_icon/Features/CategoryDetails/Widget/program_card.dart';
import 'package:pro_icon/data/models/categories_model.dart';

import '../../../Core/dependencies.dart';
import '../Widget/categories_section.dart';

class CategoryDetails extends StatefulWidget {
  static const routeName = "/Category-details";
  const CategoryDetails(
      {super.key, required this.categories, required this.currentIndex});
  final List<Categories> categories;
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
            BlocBuilder<CategoryDetailsCubit, CategoryDetailsState>(
              buildWhen: (previous, current) =>
                  previous.programs != current.programs,
              builder: (context, state) {
                if (state.programs!.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Padding(
                      padding: SizeConstants.kScaffoldPadding(context),
                      child: const EmptyStateWidget(message: "No Programs"),
                    ),
                  );
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final program = state.programs![index];
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: context.setMinSize(10),
                            horizontal: SizeConstants.kScaffoldPadding(context)
                                .horizontal),
                        child: SizeConfig(
                          baseSize: const Size(398, 175),
                          width: context.setMinSize(398),
                          height: context.setMinSize(175),
                          child: Builder(builder: (context) {
                            return ProgramCard(
                                key: ValueKey(program.id!), program: program);
                          }),
                        ),
                      );
                    },
                    childCount: state.programs!.length,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
