import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pro_icon/Core/entities/session_program_entity.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/data/mappers/session_program_mapper.dart';

import '../../../../Core/entities/automatic_session_entity.dart';
import '../../../../Core/widgets/custom_button.dart';
import '../../../../Core/widgets/custom_loader.dart';
import '../../../../Core/widgets/custom_snack_bar.dart';
import '../../../../data/models/auto_session_model.dart';
import '../cubits/cubit/manage_custom_session_cubit.dart';

class ManageSessionBottomNav extends StatelessWidget {
  final AutomaticSessionEntity? session;
  final GlobalKey<FormBuilderState> formKey;

  const ManageSessionBottomNav({
    super.key,
    required this.formKey,
    this.session,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.setMinSize(16),
      ),
      child: SizedBox(
        height: context.setMinSize(80),
        child: Column(
          children: [
            BlocConsumer<ManageCustomSessionCubit, ManageCustomSessionState>(
              listenWhen: (previous, current) =>
                  previous.addSessionStatus != current.addSessionStatus ||
                  previous.editSessionStatus != current.editSessionStatus,
              listener: (context, state) {
                _handleStatusChanges(context, state);
              },
              buildWhen: (previous, current) =>
                  previous.addSessionStatus != current.addSessionStatus ||
                  previous.editSessionStatus != current.editSessionStatus,
              builder: (context, state) {
                if (_isLoading(state)) {
                  return const CustomLoader();
                }
                return CustomButton(
                  onPressed: () => _handleConfirm(context),
                  text: "confirm".tr(),
                );
              },
            ),
            context.setMinSize(20).verticalSpace,
          ],
        ),
      ),
    );
  }

  void _handleStatusChanges(
      BuildContext context, ManageCustomSessionState state) {
    if (state.addSessionStatus == ManageCustomSessionStatus.error ||
        state.editSessionStatus == ManageCustomSessionStatus.error) {
      buildCustomAlert(
          context, state.message ?? "An error occurred", Colors.red);
    } else if (state.addSessionStatus == ManageCustomSessionStatus.success ||
        state.editSessionStatus == ManageCustomSessionStatus.success) {
      buildCustomAlert(context, state.message ?? "Success", Colors.green);
    }
  }

  bool _isLoading(ManageCustomSessionState state) {
    return state.addSessionStatus == ManageCustomSessionStatus.loading ||
        state.editSessionStatus == ManageCustomSessionStatus.loading;
  }

  void _handleConfirm(BuildContext context) {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      final cubit = context.read<ManageCustomSessionCubit>();
      if (cubit.state.sessionPrograms.isEmpty) {
        buildCustomAlert(
            context, "Please select at least one program", Colors.red);
        return;
      }

      final formData = formKey.currentState!.value;
      final name = formData['name'] as String;
      final duration = int.parse(formData['duration'] as String);
      final durationDifference = cubit.getTimeDifference(duration);

      if (durationDifference < 0) {
        buildCustomAlert(
            context,
            "programs` duration excceds session time by ${durationDifference.abs()} seconds",
            Colors.red);
        return;
      }
      if (durationDifference > 0) {
        buildCustomAlert(
            context,
            "programs` duration is less than session time by ${durationDifference} seconds",
            Colors.red);
        return;
      }

      final request = AutoSessionModel(
        name: name,
        duration: duration,
        sessionPrograms:
            List<SessionProgramEntity>.from(cubit.state.sessionPrograms)
                .map((e) => SessionProgramMapper.toModel(e))
                .toList(),
      );

      // Check if changes exist before deciding to add or edit
      if (session == null) {
        cubit.addSession(request);
      } else {
        _handleEdit(context, cubit, request);
      }
    }
  }

  void _handleEdit(BuildContext context, ManageCustomSessionCubit cubit,
      AutoSessionModel request) {
    final isChanged = session!.name != request.name ||
        session!.duration != request.duration ||
        !const ListEquality().equals(
          session!.sessionPrograms,
          request.sessionPrograms,
        );

    if (!isChanged) {
      return;
    }

    cubit.editSession(request, session!.id!);
  }
}
