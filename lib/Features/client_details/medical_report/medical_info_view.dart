import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/dependencies.dart';
import 'package:pro_icon/Core/entities/client_entity.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/widgets/custom_button.dart';
import 'package:pro_icon/Core/widgets/text_form_section.dart';
import 'package:pro_icon/Features/client_details/medical_report/cubits/cubit/medical_info_cubit.dart';
import 'package:pro_icon/Features/client_details/medical_report/widgets/disease_section.dart';

import '../../../Core/widgets/custom_snack_bar.dart';
import '../cubit/cubit/client_details_cubit.dart';
import 'widgets/disease_section_title.dart';
import 'widgets/injuries_section.dart';
import 'widgets/injuries_section_title.dart';

class MedicalInfoView extends StatefulWidget {
  const MedicalInfoView({super.key});

  @override
  State<MedicalInfoView> createState() => _MedicalInfoViewState();
}

class _MedicalInfoViewState extends State<MedicalInfoView> {
  late final ClientEntity _client;
  late TextEditingController _notesController;

  @override
  void initState() {
    _client = BlocProvider.of<ClientDetailsCubit>(context).state.client!;
    _notesController = TextEditingController(text: _client.medicalNotes);
    super.initState();
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
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
            const InjuriesSectionTitle(),
            context.setMinSize(10).verticalSpace,
            InjuriesSecion(
              client: _client,
            ),
            context.setMinSize(20).verticalSpace,
            const DiseasesSectionTitle(),
            context.setMinSize(10).verticalSpace,
            DiseaseSection(client: _client),
            context.setMinSize(20).verticalSpace,
            TextFormSection(
              title: "notes".tr(),
              name: "notes",
              hintText: "",
              controller: _notesController,
              maxLines: 5,
            ),
            context.setMinSize(20).verticalSpace,
            SaveMedicalInfoButton(
                notesController: _notesController, client: _client),
            context.setMinSize(20).verticalSpace,
          ],
        ),
      ),
    );
  }
}

class SaveMedicalInfoButton extends StatelessWidget {
  const SaveMedicalInfoButton({
    super.key,
    required TextEditingController notesController,
    required ClientEntity client,
  })  : _notesController = notesController,
        _client = client;

  final TextEditingController _notesController;
  final ClientEntity _client;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ClientDetailsCubit, ClientDetailsState>(
        listener: (context, state) {
          if (state.clientUpdateStatus == ClientDetailsStatus.success) {
            final cubit =
                BlocProvider.of<ClientDetailsCubit>(context, listen: false);
            buildCustomAlert(
                context, 'notes.updateSuccessMessage'.tr(), Colors.green);
            Future.delayed(const Duration(seconds: 3),
                () => cubit.setUpdateStatus(ClientDetailsStatus.intial));
          }
          if (state.clientUpdateStatus == ClientDetailsStatus.error) {
            buildCustomAlert(context, state.message!, Colors.red);
          }
        },
        child: CustomButton(
            onPressed: () {
              if (_notesController.text.isNotEmpty &&
                  _notesController.text != _client.medicalNotes) {
                final body = {'medicalNotes': _notesController.text};
                final cubit =
                    BlocProvider.of<ClientDetailsCubit>(context, listen: false);
                cubit.updateClient(body, _client.id!);
              }
            },
            text: "save".tr()));
  }
}
