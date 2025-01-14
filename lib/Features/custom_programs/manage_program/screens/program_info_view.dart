import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';

import '../cubits/cubit/manage_custom_program_cubit.dart';
import '../widgets/program_image_placeholder.dart';
import '../widgets/program_image_section.dart';
import '../widgets/program_info_section.dart';

class ProgramInfoView extends StatefulWidget {
  const ProgramInfoView({super.key});

  @override
  State<ProgramInfoView> createState() => _ProgramInfoViewState();
}

class _ProgramInfoViewState extends State<ProgramInfoView> {
  late GlobalKey<FormBuilderState> _formKey;

  @override
  void initState() {
    _formKey = GlobalKey<FormBuilderState>();
    super.initState();
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ManageCustomProgramCubit>();
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        context.setMinSize(10).verticalSpace,
        !cubit.state.isEditMode
            ? const ProfileImagePlaceholder()
            : const Center(child: ProgramImageSection()),
        ProgramInfoForm(formKey: _formKey)
      ]),
    );
  }
}
