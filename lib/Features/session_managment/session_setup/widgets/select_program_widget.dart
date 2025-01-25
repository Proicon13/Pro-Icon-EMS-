import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';

import '../../../../Core/entities/program_entity.dart';
import '../../../../Core/widgets/custom_circular_image.dart';
import '../../../../Core/widgets/custom_dropdown_section.dart';
import '../cubits/cubit/session_setup_cubit.dart';
import '../cubits/cubit/session_setup_state.dart';

class SelectProgramWidget extends StatelessWidget {
  const SelectProgramWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
      buildWhen: (previous, current) => current.programs != previous.programs,
      builder: (context, state) {
        if (state.selectedSessionMode == 'Program') {
          return DropdownFormSection<ProgramEntity>(
              title: "Select Program",
              name: 'program',
              hintText: "Select",
              items: state.programs
                  .map((program) => DropdownMenuItem<ProgramEntity>(
                        value: program,
                        child: Row(
                          children: [
                            CustomCircularImage(
                                width: context.setMinSize(20),
                                height: context.setMinSize(20),
                                imageUrl: "${program.image}"),
                            context.setMinSize(10).horizontalSpace,
                            Text("${program.name}")
                          ],
                        ),
                      ))
                  .toList());
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
