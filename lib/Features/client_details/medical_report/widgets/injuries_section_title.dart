import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/cubit/medical_info_cubit.dart';
import 'section_title.dart';

class InjuriesSectionTitle extends StatelessWidget {
  const InjuriesSectionTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<MedicalInfoCubit, MedicalInfoState, bool>(
      selector: (state) => state.isInjurySectionOpen,
      builder: (context, state) {
        return SectionTitle(
          title: "medicalInfo.injuries".tr(),
          onToggle: () =>
              context.read<MedicalInfoCubit>().toggleInjurySection(),
          isOpen: state,
        );
      },
    );
  }
}
