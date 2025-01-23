import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/entities/automatic_session_entity.dart';
import 'package:pro_icon/Core/networking/api_constants.dart';
import 'package:pro_icon/Core/theme/app_text_styles.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_config.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';
import 'package:pro_icon/Core/widgets/custom_loader.dart';
import 'package:pro_icon/Core/widgets/empty_state_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../Core/theme/app_colors.dart';
import '../../../Core/widgets/custom_snack_bar.dart';
import '../cubits/auto_sessions_cubit.dart';
import '../cubits/main_auto_session_cubit.dart';
import 'auto_session_card.dart';
import 'session_list_view.dart';

class MainAutoSection extends StatelessWidget {
  final ScrollController scrollController;

  const MainAutoSection({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      child: BlocConsumer<MainAutoSessionCubit, MainAutoSessionState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) => _handleStateListener(context, state),
        buildWhen: (previous, current) =>
            previous.status != current.status ||
            previous.sessions != current.sessions,
        builder: (context, state) => _buildStateContent(context, state),
      ),
    );
  }

  void _handleStateListener(BuildContext context, MainAutoSessionState state) {
    if (state.isError) {
      buildCustomAlert(context, state.message!, Colors.red);
    }
  }

  Widget _buildStateContent(BuildContext context, MainAutoSessionState state) {
    if (state.isLoading) {
      return _buildLoadingList(context);
    } else if (state.sessions?.isEmpty ?? true) {
      return const Center(
          child: EmptyStateWidget(message: "No Automatic Sessions Yet"));
    } else {
      return _buildSessionList(context, state);
    }
  }

  Widget _buildLoadingList(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.separated(
        key: const ValueKey("main-auto-list-loading"),
        padding: SizeConstants.kBottomNavBarPadding(context),
        itemCount: 2,
        separatorBuilder: (context, index) =>
            context.setMinSize(20).verticalSpace,
        itemBuilder: (context, index) {
          return SizeConfig(
            baseSize: const Size(398, 88),
            width: context.setMinSize(398),
            height: context.setMinSize(88),
            child: Builder(builder: (context) {
              return MainSessionCard(
                session: MainAutomaticSessionEntity(
                    name: "Loading",
                    createdById: 1,
                    image: "",
                    duration: 0,
                    id: 1,
                    sessionPrograms: const []),
                onTap: () {},
              );
            }),
          );
        },
      ),
    );
  }

  Widget _buildSessionList(BuildContext context, MainAutoSessionState state) {
    return Column(
      children: [
        Expanded(
          child: SessionsListView(
            controller: scrollController,
            sessions: state.sessions!,
            mode: AutoSession.main,
          ),
        ),
        context.setMinSize(10).verticalSpace,
        state.sessions!.length < ApiConstants.defaultPerPage &&
                state.canLoadMore
            ?
            // build load more text here
            _buildLoadMore(context)
            : const SizedBox.shrink()
      ],
    );
  }

  Widget _buildLoadMore(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: context.setMinSize(70)),
      child: BlocSelector<MainAutoSessionCubit, MainAutoSessionState, bool>(
        selector: (state) {
          return state.isPaginating!;
        },
        builder: (context, isPaginating) {
          if (isPaginating) {
            return const CustomLoader();
          }
          return GestureDetector(
            onTap: () {
              context.read<MainAutoSessionCubit>().fetchMainSessions();
            },
            child: Center(
                child: Text(
              "Load More...",
              style: AppTextStyles.fontSize16(context).copyWith(
                  color: AppColors.primaryColor, fontWeight: FontWeight.w500),
            )),
          );
        },
      ),
    );
  }
}
