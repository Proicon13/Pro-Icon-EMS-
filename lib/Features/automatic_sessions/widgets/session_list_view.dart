import 'package:flutter/material.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_config.dart';
import 'package:pro_icon/Features/automatic_sessions/cubits/auto_sessions_cubit.dart';
import 'package:pro_icon/Features/automatic_sessions/screens/auto_session_details_screen.dart';
import 'package:pro_icon/Features/automatic_sessions/widgets/auto_session_card.dart';

import '../../../Core/entities/automatic_session_entity.dart';
import '../../../Core/utils/responsive_helper/size_constants.dart';
import '../manage_session/screens/manage_auto_session_screen.dart';

class SessionsListView extends StatelessWidget {
  final ScrollController controller;
  final List<AutomaticSessionEntity> sessions;
  final AutoSession mode;

  const SessionsListView({
    Key? key,
    required this.controller,
    required this.sessions,
    required this.mode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: SizeConstants.kBottomNavBarPadding(context),
      controller: controller,
      itemCount: sessions.length,
      separatorBuilder: (context, index) =>
          context.setMinSize(20).verticalSpace,
      itemBuilder: (context, index) =>
          _buildSessionCard(context, sessions[index]),
    );
  }

  Widget _buildSessionCard(
      BuildContext context, AutomaticSessionEntity session) {
    switch (mode) {
      case AutoSession.main:
        return SizeConfig(
            baseSize: const Size(398, 88),
            width: context.setMinSize(398),
            height: context.setMinSize(88),
            child: Builder(builder: (context) {
              return MainSessionCard(
                session: session as MainAutomaticSessionEntity,
                onTap: () {
                  _onCardTap(context, session);
                },
              );
            }));

      case AutoSession.custom:
        return SizeConfig(
          baseSize: const Size(398, 88),
          width: context.setMinSize(398),
          height: context.setMinSize(88),
          child: Builder(builder: (context) {
            return CustomSessionCard(
              session: session as CustomAutomaticSessionEntity,
              onDelete: () {},
              onEdit: () {
                Navigator.pushNamed(context, ManageAutoSessionScreen.routeName,
                    arguments: session);
              },
              onTap: () {
                _onCardTap(context, session);
              },
            );
          }),
        );
    }
  }

  void _onCardTap(BuildContext context, AutomaticSessionEntity session) {
    Navigator.pushNamed(context, AutoSessionDetailsScreen.routeName,
        arguments: session);
  }
}
