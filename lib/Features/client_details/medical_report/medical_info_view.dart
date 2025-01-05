import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/dependencies.dart';
import 'package:pro_icon/Core/entities/client_entity.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Features/client_details/medical_report/cubits/cubit/medical_info_cubit.dart';
import 'package:pro_icon/Features/client_details/medical_report/widgets/disease_section.dart';
import 'package:pro_icon/Features/client_details/medical_report/widgets/section_title.dart';

import '../cubit/cubit/client_details_cubit.dart';
import 'widgets/injuries_section.dart';

class MedicalInfoView extends StatefulWidget {
  const MedicalInfoView({super.key});

  @override
  State<MedicalInfoView> createState() => _MedicalInfoViewState();
}

class _MedicalInfoViewState extends State<MedicalInfoView> {
  late final ClientEntity _client;

  @override
  void initState() {
    _client = BlocProvider.of<ClientDetailsCubit>(context).state.client!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<MedicalInfoCubit>()..renderHealthConditions(_client.id!),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            context.setMinSize(30).verticalSpace,
            BlocSelector<MedicalInfoCubit, MedicalInfoState, bool>(
              selector: (state) => state.isInjurySectionOpen,
              builder: (context, state) {
                return SectionTitle(
                  title: "medicalInfo.injuries".tr(),
                  onToggle: () =>
                      context.read<MedicalInfoCubit>().toggleInjurySection(),
                  isOpen: state,
                );
              },
            ),
            context.setMinSize(10).verticalSpace,
            InjuriesSecion(
              client: _client,
            ),
            context.setMinSize(20).verticalSpace,
            BlocSelector<MedicalInfoCubit, MedicalInfoState, bool>(
              selector: (state) => state.isDiseaseSectionOpen,
              builder: (context, state) {
                return SectionTitle(
                  title: "medicalInfo.diseases".tr(),
                  onToggle: () =>
                      context.read<MedicalInfoCubit>().toggleDiseaseSection(),
                  isOpen: state,
                );
              },
            ),
            DiseaseSection(client: _client),
            context.setMinSize(20).verticalSpace,
          ],
        ),
      ),
    );
  }
}
