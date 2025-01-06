import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/entities/client_entity.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Features/client_details/medical_report/cubits/cubit/medical_info_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../Core/theme/app_text_styles.dart';
import '../../cubit/cubit/client_details_cubit.dart';
import 'health_condition_grid.dart';

class DiseaseSection extends StatelessWidget {
  final ClientEntity client;
  const DiseaseSection({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MedicalInfoCubit, MedicalInfoState>(
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.clientDiseases != current.clientDiseases ||
          previous.diseaseUpdateStatus != current.diseaseUpdateStatus ||
          previous.isDiseaseSectionOpen != current.isDiseaseSectionOpen,
      builder: (context, state) {
        if (state.status == ClientDetailsStatus.error) {
          return SizedBox(
            height: context.setMinSize(200),
            child: Center(
              child: Text(
                state.message,
                style: AppTextStyles.fontSize14(context)
                    .copyWith(color: Colors.white),
              ),
            ),
          );
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          child: state.isDiseaseSectionOpen
              ? _buildSectionContent(state, context)
              : const SizedBox.shrink(
                  key: ValueKey("Diseases-grid-closed"),
                ),
        );
      },
    );
  }

  Skeletonizer _buildSectionContent(
      MedicalInfoState state, BuildContext context) {
    return Skeletonizer(
      enabled: state.status == ClientDetailsStatus.loading,
      child: HealthConditionGrid(
        key: const ValueKey("Diseases-grid"),
        healthConditions: state.allDiseases,
        itemCount: state.status == ClientDetailsStatus.loading
            ? 2
            : state.allDiseases.length,
        selectedConditions: state.clientDiseases,
        isLoading: state.status == ClientDetailsStatus.loading,
        onSelect: (index) {
          context.read<MedicalInfoCubit>().updateDisease(client.id!, index);
        },
      ),
    );
  }
}
