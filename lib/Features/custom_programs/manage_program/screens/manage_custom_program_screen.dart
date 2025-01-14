import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/entities/program_entity.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';
import 'package:pro_icon/Core/widgets/base_app_scaffold.dart';
import 'package:pro_icon/Core/widgets/custom_header.dart';
import 'package:pro_icon/Features/custom_programs/manage_program/cubits/cubit/manage_custom_program_cubit.dart';

import '../../../../Core/dependencies.dart';
import '../widgets/stepper_section.dart';
import 'program_info_view.dart';

class ManageCustomProgramScreen extends StatefulWidget {
  static const String routeName = '/manage-custom-program-screen';
  final CustomProgramEntity? program;
  const ManageCustomProgramScreen({super.key, this.program});

  @override
  State<ManageCustomProgramScreen> createState() =>
      _ManageCustomProgramScreenState();
}

class _ManageCustomProgramScreenState extends State<ManageCustomProgramScreen> {
  late PageController _pageController;
  final pages = {
    0: const ProgramInfoView(),
    1: const Center(
        child: Text(
      "Choronaxie",
    )),
    2: const Center(
        child: Text(
      "Active",
    ))
  };

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ManageCustomProgramCubit>(
      create: (context) {
        if (widget.program != null) {
          return getIt<ManageCustomProgramCubit>()..setProgram(widget.program!);
        } else {
          return getIt<ManageCustomProgramCubit>();
        }
      },
      child: BaseAppScaffold(
        body: Padding(
          padding: SizeConstants.kScaffoldPadding(context),
          child: Column(children: [
            context.setMinSize(20).verticalSpace,
            CustomHeader(titleKey: "manageProgram.title".tr()),
            context.setMinSize(20).verticalSpace,
            SizedBox(
              width: context.sizeConfig.width * 0.7,
              child: StepperSection(
                pageController: _pageController,
              ),
            ),
            Expanded(
              child: PageView.builder(
                itemCount: 3,
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                itemBuilder: (context, index) {
                  return pages[index]!;
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}
