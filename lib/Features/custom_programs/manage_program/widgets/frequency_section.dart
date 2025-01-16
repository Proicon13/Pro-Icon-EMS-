import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/widgets/custom_text_field.dart';
import 'package:pro_icon/Features/custom_programs/manage_program/cubits/cubit/manage_custom_program_cubit.dart';
import 'package:pro_icon/data/models/cycle.dart';

import '../../../../Core/constants/app_assets.dart';
import '../../../../Core/theme/app_text_styles.dart';
import '../../../../Core/utils/responsive_helper/size_config.dart';
import '../../../../Core/widgets/custom_dropdown_section.dart';
import '../../../../Core/widgets/custom_svg_visual.dart';

class FrequencyCyclesSection extends StatelessWidget {
  const FrequencyCyclesSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocSelector<ManageCustomProgramCubit, ManageCustomProgramState, int>(
          selector: (state) {
            return state.cycles.length;
          },
          builder: (context, state) {
            return DropdownFormSection<int>(
              title: "Cycles No.",
              name: "cycles",
              initialValue: state == 0 ? null : state,
              onChanged: (index) => context
                  .read<ManageCustomProgramCubit>()
                  .onCyclesSelected(index ?? 1),
              items: [1, 2, 3, 4, 5, 6]
                  .map((number) => DropdownMenuItem<int>(
                        value: number,
                        child: Text(
                          number.toString(),
                          style: AppTextStyles.fontSize14(context).copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ))
                  .toList(),
              hintText: "Number of Cycles",
            );
          },
        ),
        BlocSelector<ManageCustomProgramCubit, ManageCustomProgramState,
            List<Cycle>>(
          selector: (state) {
            return state.cycles;
          },
          builder: (context, state) {
            if (state.isEmpty) return const SizedBox.shrink();
            return Column(
              children: [
                context.setMinSize(20).verticalSpace,
                ListView.separated(
                    separatorBuilder: (context, index) =>
                        context.setMinSize(10).verticalSpace,
                    itemCount: state.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final cycle = state[index];
                      return SizeConfig(
                        baseSize: const Size(398, 70),
                        width: context.sizeConfig.width,
                        height: context.setMinSize(70),
                        child: Builder(builder: (context) {
                          return FrequencyCycleCard(
                            key: ValueKey(index),
                            cycle: cycle,
                            index: index,
                          );
                        }),
                      );
                    }),
              ],
            );
          },
        )
      ],
    );
  }
}

class FrequencyCycleCard extends StatelessWidget {
  final Cycle cycle;
  final int index;
  const FrequencyCycleCard({
    super.key,
    required this.cycle,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: Radius.circular(context.setMinSize(8)),
      color: Colors.white,
      child: Container(
        height: context.sizeConfig.height,
        width: context.sizeConfig.width,
        padding: EdgeInsets.symmetric(
            horizontal: context.setMinSize(10),
            vertical: context.setMinSize(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Cycle ${index + 1}',
              style: AppTextStyles.fontSize12(context)
                  .copyWith(color: Colors.white),
            ),
            context.setMinSize(30).horizontalSpace,
            SizedBox(
                height: context.sizeConfig.height,
                width: context.sizeConfig.width * 0.17,
                child: CustomTextField(
                  name: "cycle-${index + 1}",
                  isDense: true,
                  onChanged: (value) {
                    if (value != null && value.isNotEmpty) {
                      context
                          .read<ManageCustomProgramCubit>()
                          .onCycleFrequencyChanged(cycle.id!, int.parse(value));
                    }
                  },
                  contentPadding: EdgeInsets.symmetric(
                    vertical: context.sizeConfig.height * 0.15,
                    horizontal: context.sizeConfig.width * 0.02,
                  ),
                  intialValue: cycle.frequency.toString(),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(3)
                  ],
                  keyboardInputType: TextInputType.number,
                )),
            const Spacer(),
            CounterRow(
                count: cycle.adjustment!.toInt(),
                onIncrement: () {
                  context
                      .read<ManageCustomProgramCubit>()
                      .incrementCycleAdjustment(cycle.id!);
                },
                onDecrement: () {
                  context
                      .read<ManageCustomProgramCubit>()
                      .decrementCycleAdjustment(cycle.id!);
                }),
            context.setMinSize(30).horizontalSpace,
            GestureDetector(
              onTap: () {
                context.read<ManageCustomProgramCubit>().removeCycle(cycle.id!);
              },
              child: CustomSvgVisual(
                assetPath: Assets.assetsImagesCloseIcon,
                width: context.setMinSize(24),
                height: context.setMinSize(24),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CounterRow extends StatelessWidget {
  final int count;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CounterRow({
    Key? key,
    required this.count,
    required this.onIncrement,
    required this.onDecrement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Decrement Button
        GestureDetector(
          onTap: onDecrement,
          child: Container(
            width: context.setMinSize(28),
            height: context.setMinSize(28),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(context.setMinSize(8)),
            ),
            child: Icon(
              Icons.remove,
              size: context.setMinSize(14),
              color: Colors.black,
            ),
          ),
        ),

        context.setMinSize(20).horizontalSpace,

        // Count Display
        Text(count.toString(),
            style: AppTextStyles.fontSize16(context).copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            )),

        context.setMinSize(20).horizontalSpace,

        // Increment Button
        GestureDetector(
          onTap: onIncrement,
          child: Container(
            width: context.setMinSize(28),
            height: context.setMinSize(28),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(context.setMinSize(8)),
            ),
            child: Icon(
              Icons.add,
              size: context.setMinSize(14),
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
