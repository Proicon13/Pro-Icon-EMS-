import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/entities/automatic_session_entity.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';

import '../../../../Core/entities/category_entity.dart';
import '../../../../Core/utils/responsive_helper/size_config.dart';
import '../../../../Core/widgets/custom_circular_image.dart';
import '../../../../Core/widgets/custom_dropdown_section.dart';
import '../../../../Core/widgets/custom_loader.dart';
import '../cubits/cubit/session_setup_cubit.dart';
import '../cubits/cubit/session_setup_state.dart';

class SelectCategoryWidget extends StatelessWidget {
  const SelectCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
      buildWhen: (previous, current) =>
          previous.categriesMangement != current.categriesMangement ||
          previous.selectedSessionMode != current.selectedSessionMode ||
          previous.automaticSessions != current.automaticSessions ||
          previous.isLoading != current.isLoading,
      builder: (context, state) {
        if (state.isLoading) {
          return SizedBox(
              height: context.screenHeight * 0.3, child: const CustomLoader());
        }

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
                      child: _buildDropdownItem(
                          context, category.image!, category.name!),
                    ))
                .toList(),
            selectedItemBuilder: (context, selectedValue) {
              final category = state.categriesMangement.firstWhere(
                  (cat) => cat == selectedValue,
                  orElse: () =>
                      CategoryEntity(id: 0, name: "Unknown", image: ""));
              return Text(category.name!);
            },
          );
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
                    child: _buildDropdownItem(
                        context,
                        session is MainAutomaticSessionEntity
                            ? (session).image ?? ""
                            : "",
                        session.name!),
                  ))
              .toList(),
          selectedItemBuilder: (context, selectedValue) {
            final session = state.automaticSessions.firstWhere(
                (sess) => sess == selectedValue,
                orElse: () =>
                    const AutomaticSessionEntity(id: 0, name: "Unknown"));
            return Text(session.name!);
          },
        );
      },
    );
  }

  /// Reusable widget for dropdown items
  Widget _buildDropdownItem(
      BuildContext context, String imageUrl, String title) {
    return SizeConfig(
      baseSize: const Size(398, 65),
      width: context.setMinSize(398),
      height: context.setMinSize(65),
      child: Builder(builder: (context) {
        return SizedBox(
          width: double.infinity,
          height: context.sizeConfig.height,
          child: Row(
            children: [
              SizedBox(
                child: CustomCircularImage(
                  width: context.setMinSize(50),
                  height: context.setMinSize(50),
                  imageUrl: imageUrl,
                ),
              ),
              context.setMinSize(20).horizontalSpace,
              Text(
                title,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        );
      }),
    );
  }
}
