import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/cubits/user_state/user_state_cubit.dart';
import 'package:pro_icon/Core/dependencies.dart';
import 'package:pro_icon/Core/entities/admin_entity.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';
import 'package:pro_icon/Core/widgets/base_app_scaffold.dart';
import 'package:pro_icon/Core/widgets/custom_button.dart';
import 'package:pro_icon/Core/widgets/custom_header.dart';
import 'package:pro_icon/Core/widgets/custom_loader.dart';
import 'package:pro_icon/Core/widgets/empty_state_widget.dart';
import 'package:pro_icon/Features/programming_requst/cubit/programmer_request_cubit.dart';
import 'package:pro_icon/Features/programming_requst/widget/programming_request_card.dart';
import 'package:pro_icon/data/models/programming_request.dart';

import '../../../Core/widgets/custom_snack_bar.dart';

class ProgrammingRequestScreen extends StatelessWidget {
  static const routeName = "/programming-request";
  const ProgrammingRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          getIt<ProgrammerRequestCubit>()..checkRequestStatus(),
      child: const BaseAppScaffold(
        body: ProgrammingRequestBody(),
      ),
    );
  }
}

class ProgrammingRequestBody extends StatelessWidget {
  const ProgrammingRequestBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: SizeConstants.kScaffoldPadding(context),
      child: Column(
        children: [
          context.setMinSize(20).verticalSpace,
          const CustomHeader(titleKey: "Programming request"),
          const ProgrammingRequestContent(),
        ],
      ),
    );
  }
}

class ProgrammingRequestContent extends StatelessWidget {
  const ProgrammingRequestContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProgrammerRequestCubit, ProgrammerRequestState>(
      buildWhen: (previous, current) =>
          previous.checkStatus != current.checkStatus,
      builder: (context, state) {
        if (state.isCheckLoading) {
          return const Expanded(child: CustomLoader());
        }
        if (state.isCheckSuccess) {
          return const UserProgrammingRequest();
        }

        return const SizedBox.shrink();
      },
      listener: (context, state) {
        if (state.checkStatus == ProgrammerRequestStatus.error) {
          buildCustomAlert(context, state.message!, Colors.red);
        }
      },
    );
  }
}

class UserProgrammingRequest extends StatelessWidget {
  const UserProgrammingRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<UserStateCubit, UserStateState, ProgrammingRequest?>(
      selector: (state) =>
          (state.currentUser as AdminEntity).programmingRequest,
      builder: (context, request) {
        if (request == null) {
          return const NoRequestContent();
        }
        return ProgrammingRequestCard(programmingRequest: request);
      },
    );
  }
}

class NoRequestContent extends StatelessWidget {
  const NoRequestContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const EmptyStateWidget(message: "No Pending Request"),
        context.setMinSize(30).verticalSpace,
        BlocConsumer<ProgrammerRequestCubit, ProgrammerRequestState>(
          buildWhen: (previous, current) =>
              previous.applyStatus != current.applyStatus,
          listener: (context, state) {
            if (state.applyStatus == ProgrammerRequestStatus.error) {
              buildCustomAlert(context, state.message!, Colors.red);
            }
            if (state.applyStatus == ProgrammerRequestStatus.success) {
              buildCustomAlert(context, state.message!, Colors.green);
              Future.delayed(const Duration(seconds: 3), () {
                context.read<ProgrammerRequestCubit>().setApplyStatus(
                      ProgrammerRequestStatus.initial,
                    );
              });
            }
          },
          builder: (context, state) {
            if (state.isApplyLoading) {
              return SizedBox(
                  height: context.setMinSize(60), child: const CustomLoader());
            }
            return CustomButton(
              onPressed: () {
                context.read<ProgrammerRequestCubit>().applyForProgrammer();
              },
              text: "Apply to programmer role",
            );
          },
        ),
      ],
    );
  }
}
