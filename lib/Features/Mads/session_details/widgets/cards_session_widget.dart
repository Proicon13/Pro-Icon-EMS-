import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/entities/mad_session_entity.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../Core/utils/responsive_helper/size_config.dart';
import '../../../../Core/widgets/custom_snack_bar.dart';
import '../../../../Core/widgets/empty_state_widget.dart';
import '../../Cubit/cubit/session_details_cubit.dart';
import 'session_card.dart';

class CardsSessionWidget extends StatefulWidget {
  const CardsSessionWidget({super.key});

  @override
  State<CardsSessionWidget> createState() => _CardsSessionWidgetState();
}

class _CardsSessionWidgetState extends State<CardsSessionWidget> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SessionDetailsCubit, SessionDetailsState>(
      listenWhen: (previous, current) =>
          previous.requestStatus != current.requestStatus,
      buildWhen: (previous, current) =>
          previous.requestStatus != current.requestStatus ||
          previous.sessions != current.sessions,
      listener: (context, state) {
        if (state.isError) {
          buildCustomAlert(context, state.message!, Colors.red);
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return _buildSessionsLoading();
        }
        return _buildSessionsLoaded(state);
      },
    );
  }

  Expanded _buildSessionsLoaded(SessionDetailsState state) {
    if (state.sessions!.isEmpty) {
      return const Expanded(child: EmptyStateWidget(message: "No Sessions"));
    }
    return Expanded(
      child: ListView.separated(
          key: const ValueKey(
            "sessions-list-loaded ",
          ),
          controller: _scrollController,
          itemCount: state.sessions!.length,
          separatorBuilder: (context, index) =>
              context.setMinSize(20).verticalSpace,
          itemBuilder: (context, index) {
            final session = state.sessions![index];
            return SizeConfig(
              baseSize: const Size(398, 137),
              width: context.setMinSize(398),
              height: context.setMinSize(137),
              child: Builder(builder: (context) {
                return SessionCard(
                  key: ValueKey(session.id),
                  session: session,
                );
              }),
            );
          }),
    );
  }

  Expanded _buildSessionsLoading() {
    return Expanded(
      child: Skeletonizer(
        enabled: true,
        child: ListView.separated(
          key: const ValueKey("sessions-loading-list"),
          itemCount: 2,
          separatorBuilder: (context, index) =>
              context.setMinSize(20).verticalSpace,
          itemBuilder: (context, index) => SizeConfig(
              baseSize: const Size(398, 137),
              width: context.setMinSize(398),
              height: context.setMinSize(137),
              child: Builder(builder: (context) {
                return SessionCard(
                  session: MadSessionEntity(
                      captainName: "loading", date: DateTime.now(), id: 0),
                );
              })),
        ),
      ),
    );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (maxScroll == currentScroll) {
      context.read<SessionDetailsCubit>().fetchMadSessions();
    }
  }
}
