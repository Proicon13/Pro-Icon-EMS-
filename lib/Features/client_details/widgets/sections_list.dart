import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';

import '../../users/widgets/user_variation_column.dart';
import '../cubit/cubit/client_details_cubit.dart';

class SectionsList extends StatelessWidget {
  final PageController pageController;
  const SectionsList({
    super.key,
    required this.pageController,
  });

  void _animateToNextPage(int index) {
    pageController.jumpToPage(
      index,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.setHeight(50),
      child:
          BlocSelector<ClientDetailsCubit, ClientDetailsState, ClientSections>(
        selector: (state) => state.currentSection,
        builder: (context, state) {
          return ListView.builder(
            padding: EdgeInsets.only(left: context.setMinSize(16)),
            scrollDirection: Axis.horizontal,
            itemCount: ClientSections.values.length,
            itemBuilder: (context, index) {
              final section = ClientSections.values[index];
              final isSelected = section == state;
              return Container(
                margin: EdgeInsets.only(right: context.setMinSize(20)),
                child: UserVariationColumn(
                    userVariation: section.name,
                    isSelected: isSelected,
                    onTap: () {
                      BlocProvider.of<ClientDetailsCubit>(context)
                          .onSectionChanged(section);
                      _animateToNextPage(index);
                    }),
              );
            },
          );
        },
      ),
    );
  }
}
