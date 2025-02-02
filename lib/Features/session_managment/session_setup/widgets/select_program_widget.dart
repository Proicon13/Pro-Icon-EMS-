import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_config.dart';

import '../../../../Core/entities/program_entity.dart';
import '../../../../Core/widgets/custom_circular_image.dart';
import '../../../../Core/widgets/custom_dropdown_section.dart';
import '../cubits/cubit/session_setup_cubit.dart';
import '../cubits/cubit/session_setup_state.dart';

class SelectProgramWidget extends StatelessWidget {
  const SelectProgramWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      child: BlocBuilder<SessionCubit, SessionState>(
        buildWhen: (previous, current) =>
            current.programs != previous.programs ||
            current.selectedSessionMode != previous.selectedSessionMode ||
            previous.isLoading != current.isLoading,
        builder: (context, state) {
          if (state.isLoading) {
            return const SizedBox.shrink();
          }
          if (state.selectedSessionMode == SessionControlMode.program) {
            return DropdownFormSection<ProgramEntity>(
                title: "Select Program",
                name: 'program',
                hintText: "Select",
                onChanged: (value) {
                  if (value != null) {
                    context.read<SessionCubit>().selectProgram(value);
                  }
                },
                selectedItemBuilder: (context, program) =>
                    Text("${program!.name}"),
                items: state.programs
                    .map((program) => DropdownMenuItem<ProgramEntity>(
                          value: program,
                          child: SizeConfig(
                            baseSize: const Size(398, 65),
                            width: context.setMinSize(398),
                            height: context.setMinSize(65),
                            child: Builder(builder: (context) {
                              return SizedBox(
                                width: double.infinity,
                                height: context.sizeConfig.height,
                                child: Row(
                                  children: [
                                    CustomCircularImage(
                                        width: context.setMinSize(40),
                                        height: context.setMinSize(40),
                                        imageUrl: "${program.image}"),
                                    context.setMinSize(20).horizontalSpace,
                                    Text("${program.name}")
                                  ],
                                ),
                              );
                            }),
                          ),
                        ))
                    .toList());
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
