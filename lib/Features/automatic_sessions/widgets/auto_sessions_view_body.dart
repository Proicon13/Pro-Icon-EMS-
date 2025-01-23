import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/theme/app_colors.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Features/automatic_sessions/widgets/main_auto_section.dart';

import '../../../Core/widgets/custom_header.dart';
import '../cubits/auto_sessions_cubit.dart';
import '../cubits/custom_auto_session_cubit.dart';
import '../manage_session/screens/manage_auto_session_screen.dart';
import 'auto_session_variation_section.dart';
import 'custom_auto_section.dart';

class AutoSessionsViewBody extends StatelessWidget {
  const AutoSessionsViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final autoSessionsCubit = context.read<AutoSessionsCubit>();

    final customAutoSessionCubit = context.read<CustomAutoSessionCubit>();
    return Stack(
      children: [
        Column(
          children: [
            context.setMinSize(30).verticalSpace,
            CustomHeader(
              titleKey: "automaticSession.title".tr(),
              isIconVisible: false,
            ),
            context.setMinSize(40).verticalSpace,
            AutoSessionVariationSection(
              autoSessionsCubit: autoSessionsCubit,
              customAutoSessionCubit: customAutoSessionCubit,
            ),
            context.setMinSize(40).verticalSpace,
            const SessionsListSection(),
          ],
        ),
        Positioned(
            bottom: context.setMinSize(35),
            right: context.setMinSize(20),
            child: FloatingActionButton(
                backgroundColor: AppColors.primaryColor,
                onPressed: () async {
                  final result = await Navigator.pushNamed(
                      context, ManageAutoSessionScreen.routeName);

                  if (result != null) {
                    context
                        .read<CustomAutoSessionCubit>()
                        .handleCustomSessionsOnPop();
                  }
                },
                child: Icon(
                  Icons.add,
                  size: context.setMinSize(40),
                  color: Colors.white,
                )))
      ],
    );
  }
}

class SessionsListSection extends StatefulWidget {
  const SessionsListSection({super.key});

  @override
  State<SessionsListSection> createState() => _SessionsListSectionState();
}

class _SessionsListSectionState extends State<SessionsListSection> {
  late ScrollController _scrollController;
  late PageController _pageController;

  @override
  void initState() {
    _scrollController = ScrollController();

    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();

    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AutoSessionsCubit, AutoSessionsState>(
      listenWhen: (previous, current) =>
          previous.currentSessionSection != current.currentSessionSection,
      listener: (context, state) {
        _pageController.animateToPage(
          AutoSession.values.indexOf(state.currentSessionSection!),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: Expanded(
        child: PageView.builder(
            itemCount: AutoSession.values.length,
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              if (index == 0) {
                return MainAutoSection(scrollController: _scrollController);
              } else {
                return CustomAutoSection(scrollController: _scrollController);
              }
            }),
      ),
    );
  }
}
