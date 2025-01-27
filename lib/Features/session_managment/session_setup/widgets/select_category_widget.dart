import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';

import '../../../../Core/entities/category_entity.dart';
import '../../../../Core/theme/app_text_styles.dart';
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
          previous.categriesMangement != current.categriesMangement,
      builder: (context, state) {
        if (state.selectedSessionMode == 'Program') {
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
        if (state.errorMessage!.isNotEmpty) {
          return Text(
            state.errorMessage!,
            style: AppTextStyles.fontSize14(context).copyWith(
              color: Colors.red,
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
