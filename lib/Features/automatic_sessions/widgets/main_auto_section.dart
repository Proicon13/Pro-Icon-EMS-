import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/entities/automatic_session_entity.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_config.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';
import 'package:pro_icon/Core/widgets/empty_state_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
        buildWhen: (previous, current) => previous.status != current.status,
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
    return SessionsListView(
      controller: scrollController,
      sessions: state.sessions!,
      mode: AutoSession.main,
    );
  }
}
