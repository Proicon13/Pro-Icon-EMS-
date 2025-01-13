import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/cubits/user_state/user_state_cubit.dart';
import 'package:pro_icon/Core/entities/program_entity.dart';
import 'package:pro_icon/Core/entities/programmer_entity.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_config.dart';
import 'package:pro_icon/Core/widgets/base_app_scaffold.dart';
import 'package:pro_icon/Core/widgets/custom_header.dart';
import 'package:pro_icon/Core/widgets/empty_state_widget.dart';
import 'package:pro_icon/Features/CategoryDetails/Widget/program_card.dart';

import '../../Core/utils/responsive_helper/size_constants.dart';

class MyProgramsScreen extends StatelessWidget {
  static const routeName = '/my-programs';
  const MyProgramsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseAppScaffold(
      body: Padding(
        padding: SizeConstants.kScaffoldPadding(context),
        child: Column(
          children: [
            context.setMinSize(30).verticalSpace,
            const CustomHeader(titleKey: "My Programs"),
            context.setMinSize(40).verticalSpace,
            BlocSelector<UserStateCubit, UserStateState, List<ProgramEntity>>(
              selector: (state) {
                return (state.currentUser as ProgrammerEntity).customPrograms!;
              },
              builder: (context, state) {
                if (state.isEmpty)
                  return const Expanded(
                      child: EmptyStateWidget(message: "No Programs yet"));
                return Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        context.setMinSize(20).verticalSpace,
                    itemCount: state.length,
                    itemBuilder: (context, index) {
                      final program = state[index];
                      return SizeConfig(
                        baseSize: const Size(398, 175),
                        width: context.setMinSize(398),
                        height: context.setMinSize(175),
                        child: Builder(builder: (context) {
                          return ProgramCardWithActions(
                            program: program,
                            onEdit: () {},
                            onDelete: () {},
                          );
                        }),
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
