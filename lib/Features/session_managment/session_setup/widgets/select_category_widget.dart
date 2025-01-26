import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/entities/automatic_session_entity.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';

import '../../../../Core/entities/category_entity.dart';
import '../../../../Core/widgets/custom_circular_image.dart';
import '../../../../Core/widgets/custom_dropdown_section.dart';
import '../cubits/cubit/session_setup_cubit.dart';
import '../cubits/cubit/session_setup_state.dart';

class SelectCategoryWidget extends StatelessWidget {
  const SelectCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
      buildWhen: (previous, current) =>
          previous.categriesMangement != current.categriesMangement ||
          previous.selectedSessionMode != current.selectedSessionMode,
      builder: (context, state) {
        if (state.selectedSessionMode == SessionControlMode.program) {
          return DropdownFormSection<CategoryEntity>(
              title: "Select Category",
              name: 'Category',
              hintText: "Select",
              onChanged: (value) {
                if (value != null) {
                  context.read<SessionCubit>().selectCategory(value);
                }
              },
              items: state.categriesMangement
                  .map((category) => DropdownMenuItem<CategoryEntity>(
                        value: category,
                        child: Row(
                          children: [
                            CustomCircularImage(
                                width: context.setMinSize(20),
                                height: context.setMinSize(20),
                                imageUrl: "${category.image}"),
                            context.setMinSize(10).horizontalSpace,
                            Text("${category.name}")
                          ],
                        ),
                      ))
                  .toList());
        }

        return DropdownFormSection<AutomaticSessionEntity>(
            title: "Select Automatic Session",
            name: 'session',
            hintText: "Select Auto Session",
            onChanged: (value) {
              if (value != null) {
                context.read<SessionCubit>().selectAutomaticSession(value);
              }
            },
            items: state.automaticSessions
                .map((session) => DropdownMenuItem<AutomaticSessionEntity>(
                      value: session,
                      child: Row(
                        children: [
                          CustomCircularImage(
                              width: context.setMinSize(20),
                              height: context.setMinSize(20),
                              imageUrl: ""),
                          context.setMinSize(10).horizontalSpace,
                          Text("${session.name}")
                        ],
                      ),
                    ))
                .toList());
      },
    );
  }
}
