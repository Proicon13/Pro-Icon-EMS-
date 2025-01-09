import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';

import '../../../Core/utils/responsive_helper/size_config.dart';
import '../../../Core/utils/responsive_helper/size_constants.dart';
import '../../../Core/widgets/empty_state_widget.dart';
import '../Cubit/category_details_cubit.dart';
import 'program_card.dart';

class ProgramsListSection extends StatelessWidget {
  const ProgramsListSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryDetailsCubit, CategoryDetailsState>(
      buildWhen: (previous, current) => previous.programs != current.programs,
      builder: (context, state) {
        if (state.programs!.isEmpty) {
          return _buildEmptyStateWidget(context);
        }
        return _buildProgramsList(state);
      },
    );
  }

  SliverList _buildProgramsList(CategoryDetailsState state) {
    return SliverList(
      key: const ValueKey("programs-List"),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final program = state.programs![index];
          return Padding(
            padding: EdgeInsets.symmetric(
                vertical: context.setMinSize(10),
                horizontal: SizeConstants.kScaffoldPadding(context).horizontal),
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
  }

  SliverToBoxAdapter _buildEmptyStateWidget(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: SizeConstants.kScaffoldPadding(context),
        child: const EmptyStateWidget(message: "No Programs"),
      ),
    );
  }
}
