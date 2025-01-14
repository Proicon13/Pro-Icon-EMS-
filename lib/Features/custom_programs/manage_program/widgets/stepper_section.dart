import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';

import '../../../../Core/theme/app_text_styles.dart';
import '../cubits/cubit/manage_custom_program_cubit.dart';

class StepperSection extends StatelessWidget {
  final PageController pageController;

  const StepperSection({
    super.key,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ManageCustomProgramCubit, ManageCustomProgramState,
        int>(
      selector: (state) => state.currentStep!,
      builder: (context, currentStep) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildStep(
              context,
              stepIndex: 0,
              title: "program.info".tr(),
              currentStep: currentStep,
              onTap: () {
                context.read<ManageCustomProgramCubit>().setStep(0);
                pageController.jumpToPage(0);
              },
            ),
            _buildLine(context, isActive: currentStep >= 1),
            _buildStep(
              context,
              stepIndex: 1,
              title: "chronaxie.title".tr(),
              currentStep: currentStep,
              onTap: () {
                context.read<ManageCustomProgramCubit>().setStep(1);
                pageController.jumpToPage(1);
              },
            ),
            _buildLine(context, isActive: currentStep >= 2),
            _buildStep(
              context,
              stepIndex: 2,
              title: "activeMuscles.title".tr(),
              currentStep: currentStep,
              onTap: () {
                context.read<ManageCustomProgramCubit>().setStep(2);
                pageController.jumpToPage(2);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildStep(
    BuildContext context, {
    required int stepIndex,
    required String title,
    required int currentStep,
    required VoidCallback onTap,
  }) {
    final isActive = stepIndex == currentStep || stepIndex < currentStep;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: context.setMinSize(40),
            height: context.setMinSize(40),
            decoration: BoxDecoration(
              color: isActive ? Colors.red : Colors.grey[700],
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              (stepIndex + 1).toString(),
              style: AppTextStyles.fontSize16(context).copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        context.setMinSize(10).verticalSpace,
        Text(
          title,
          style: AppTextStyles.fontSize12(context).copyWith(
            color: isActive ? Colors.white : Colors.grey[400],
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  /// Builds the line between steps
  Widget _buildLine(BuildContext context, {required bool isActive}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(bottom: context.setMinSize(20)),
        height: context.setMinSize(3),
        color: isActive ? Colors.red : Colors.grey[700],
      ),
    );
  }
}
