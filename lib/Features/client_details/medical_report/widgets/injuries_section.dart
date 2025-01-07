import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/core/theme/app_text_styles.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../Core/entities/client_entity.dart';
import '../../../../Core/widgets/custom_snack_bar.dart';
import '../../cubit/cubit/client_details_cubit.dart';
import '../cubits/cubit/medical_info_cubit.dart';
import 'health_condition_grid.dart';

class InjuriesSecion extends StatelessWidget {
  final ClientEntity client;
  const InjuriesSecion({
    super.key,
    required this.client,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedicalInfoCubit, MedicalInfoState>(
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.clientInjuries != current.clientInjuries ||
          previous.injuriesUpdateStatus != current.injuriesUpdateStatus ||
          previous.isInjurySectionOpen != current.isInjurySectionOpen,
      listener: (context, state) {
        if (state.status == ClientDetailsStatus.error) {
          buildCustomAlert(context, state.message, Colors.red);
        }
      },
      builder: (context, state) {
        if (state.status == ClientDetailsStatus.error) {
          return SizedBox(
            height: context.setMinSize(200),
            width: double.infinity,
            child: Center(
              child: Text(
                state.message,
                style: AppTextStyles.fontSize14(context),
              ),
            ),
          );
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          child: state.isInjurySectionOpen
              ? _buildContentSection(state, context)
              : const SizedBox.shrink(
                  key: ValueKey("injuries-section-closed"),
                ),
        );
      },
    );
  }

  Skeletonizer _buildContentSection(
      MedicalInfoState state, BuildContext context) {
    return Skeletonizer(
      enabled: state.status == ClientDetailsStatus.loading,
      child: HealthConditionGrid(
        key: const ValueKey("injuries-grid"),
        healthConditions: state.allInjuries,
        itemCount: state.status == ClientDetailsStatus.loading
            ? 2
            : state.allInjuries.length,
        selectedConditions: state.clientInjuries,
        isLoading: state.status == ClientDetailsStatus.loading,
        onSelect: (index) {
          context.read<MedicalInfoCubit>().updateInjury(client.id!, index);
        },
      ),
    );
  }
}
