import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../Core/utils/responsive_helper/size_config.dart';
import '../../../Core/widgets/custom_confirmation_dialog.dart';
import '../../../Core/widgets/custom_snack_bar.dart';
import '../../../Core/widgets/empty_state_widget.dart';
import '../../../data/models/mad.dart';
import '../Cubit/mads_cubit.dart';
import 'mad_card.dart';

class MadsListSection extends StatelessWidget {
  const MadsListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MadsCubit, MadsState>(
      listenWhen: (previous, current) =>
          previous.status != current.status ||
          previous.changeStatus != current.changeStatus,
      listener: (context, state) {
        if (state.status == MadsRequestStatus.error) {
          buildCustomAlert(context, state.message!, Colors.red);
        }
        if (state.changeStatus == MadsRequestStatus.success) {
          context.read<MadsCubit>().setChangeStatus(MadsRequestStatus.intial);
          buildCustomAlert(context, state.message!, Colors.green);
        }
      },
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.madsList != current.madsList,
      builder: (context, state) {
        if (state.status == MadsRequestStatus.loading) {
          return Expanded(
            child: _buildLoadingList(context),
          );
        }
        if (state.madsList!.isEmpty ||
            state.status == MadsRequestStatus.error) {
          return const Expanded(child: EmptyStateWidget(message: "No Mads"));
        }
        return Expanded(
          child: _buildMadsList(state, context),
        );
      },
    );
  }
}

ListView _buildMadsList(MadsState state, BuildContext context) {
  return ListView.separated(
      separatorBuilder: (context, index) =>
          context.setMinSize(20).verticalSpace,
      key: const ValueKey("mads-list-loaded"),
      itemCount: state.madsList!.length,
      itemBuilder: (ctx, index) {
        return SizeConfig(
            baseSize: const Size(398, 145),
            width: context.setMinSize(398),
            height: context.setMinSize(145),
            child: Builder(builder: (context) {
              final mad = state.madsList![index];
              return MadCard(
                key: ValueKey(mad.id),
                mad: mad,
                onDeactivate: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return CustomConfirmationDialog(
                          title:
                              "Are you sure you want to ${mad.isActive ? "deactivate" : "activate"} this mad? ",
                          confirmationTitle:
                              "Yes,${mad.isActive ? " Deactivate" : " Activate"}",
                          onConfirm: () {
                            Navigator.pop(context);
                            ctx.read<MadsCubit>().changeMadStatus(
                                index: index, status: !mad.isActive);
                          },
                        );
                      });
                },
              );
            }));
      });
}

Widget _buildLoadingList(BuildContext context) {
  return Skeletonizer(
    enabled: true,
    child: ListView.separated(
        separatorBuilder: (context, index) =>
            context.setMinSize(20).verticalSpace,
        key: const ValueKey("mads-loading-list"),
        itemCount: 3,
        itemBuilder: (contet, index) {
          return SizeConfig(
              baseSize: const Size(398, 145),
              width: context.setMinSize(398),
              height: context.setMinSize(145),
              child: Builder(builder: (context) {
                return MadCard(
                  mad: Mad(id: 1, serialNo: 00000, isActive: true),
                );
              }));
        }),
  );
}
