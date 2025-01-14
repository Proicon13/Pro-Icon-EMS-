import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pro_icon/Core/entities/program_entity.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/widgets/base_app_scaffold.dart';
import 'package:pro_icon/Core/widgets/custom_header.dart';

class ManageCustomProgramScreen extends StatefulWidget {
  static const String routeName = '/manage-custom-program-screen';
  final CustomProgramEntity? program;
  const ManageCustomProgramScreen({super.key, this.program});

  @override
  State<ManageCustomProgramScreen> createState() =>
      _ManageCustomProgramScreenState();
}

class _ManageCustomProgramScreenState extends State<ManageCustomProgramScreen> {
  late ScrollController stepController;

  @override
  void initState() {
    stepController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    stepController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseAppScaffold(
      body: Column(children: [
        context.setMinSize(30).verticalSpace,
        CustomHeader(titleKey: "manageProgram.title".tr()),
        context.setMinSize(40).verticalSpace,
        Stepper(
            type: StepperType.horizontal,
            currentStep: 0,
            steps: [
              Step(
                title: Text("program.info".tr()),
                content: const SizedBox.shrink(),
              ),
              Step(
                title: Text("chronaxie.title".tr()),
                content: const SizedBox.shrink(),
              ),
              Step(
                title: Text("activeMuscles.title".tr()),
                content: const SizedBox.shrink(),
              ),
            ],
            controller: stepController)
      ]),
    );
  }
}
