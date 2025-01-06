import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/cubit/medical_info_cubit.dart';
import 'section_title.dart';

class DiseasesSectionTitle extends StatelessWidget {
  const DiseasesSectionTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<MedicalInfoCubit, MedicalInfoState, bool>(
      selector: (state) => state.isDiseaseSectionOpen,
      builder: (context, state) {
        return SectionTitle(
          title: "medicalInfo.diseases".tr(),
          onToggle: () =>
              context.read<MedicalInfoCubit>().toggleDiseaseSection(),
          isOpen: state,
        );
      },
    );
  }
}
