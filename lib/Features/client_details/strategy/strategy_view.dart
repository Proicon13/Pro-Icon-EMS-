import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pro_icon/Core/dependencies.dart';
import 'package:pro_icon/Core/entities/client_entity.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/widgets/custom_button.dart';
import 'package:pro_icon/Core/widgets/text_form_section.dart';
import 'package:pro_icon/Features/client_details/strategy/cubits/cubit/strategy_cubit.dart';
import 'package:pro_icon/Features/client_details/strategy/widgets/target_section_title.dart';
import 'package:pro_icon/data/models/client_strategy.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../Core/widgets/custom_loader.dart';
import '../../../Core/widgets/custom_snack_bar.dart';
import '../cubit/cubit/client_details_cubit.dart';
import 'widgets/training_type_section_title.dart';
import 'widgets/training_types_list.dart';

class StrategyView extends StatefulWidget {
  const StrategyView({super.key});

  @override
  State<StrategyView> createState() => _StrategyViewState();
}

class _StrategyViewState extends State<StrategyView> {
  late ClientEntity _client;
  late GlobalKey<FormBuilderState> _formKey;

  @override
  void initState() {
    _client = BlocProvider.of<ClientDetailsCubit>(context).state.client!;
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
    return BlocProvider<StrategyCubit>(
      create: (context) =>
          getIt<StrategyCubit>()..getClientStrategy(_client.id!),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            context.setMinSize(20).verticalSpace,
            const TrainingTypesSectionTitle(),
            context.setMinSize(20).verticalSpace,
            const TrainingTypesList(),
            context.setMinSize(40).verticalSpace,
            const TargetSectionTile(),
            context.setMinSize(20).verticalSpace,
            TargetDetailsForm(formKey: _formKey, client: _client),
          ],
        ),
      ),
    );
  }
}

class TargetDetailsForm extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  final ClientEntity client;
  const TargetDetailsForm({
    super.key,
    required this.formKey,
    required this.client,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formKey,
      child: BlocConsumer<StrategyCubit, StrategyState>(
        listener: (context, state) {
          if (state.strategyUpdateStatus == StrategyStatus.error) {
            buildCustomAlert(context, state.message!, Colors.red);
          }
          if (state.strategyUpdateStatus == StrategyStatus.success) {
            buildCustomAlert(
                context, 'Strategy Updated successfully', Colors.green);
            Future.delayed(const Duration(seconds: 3), () {
              context.read<StrategyCubit>().updateStatus(StrategyStatus.intial);
            });
          }
        },
        buildWhen: (previous, current) =>
            previous.clientStrategy != current.clientStrategy ||
            previous.strategyUpdateStatus != current.strategyUpdateStatus ||
            previous.strategyStatus != current.strategyStatus ||
            previous.isTargetSectionOpen != current.isTargetSectionOpen ||
            previous.currentTrainingType != current.currentTrainingType,
        builder: (context, state) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeOut,
            child: state.isTargetSectionOpen!
                ? Skeletonizer(
                    enabled: state.strategyStatus == StrategyStatus.loading,
                    child: _buildTargetSectionContent(context, state, client),
                  )
                : const SizedBox.shrink(
                    key: ValueKey("target-section-closed"),
                  ),
          );
        },
      ),
    );
  }

  Widget _buildTargetSectionContent(
      BuildContext context, StrategyState state, ClientEntity client) {
    final isLoading = state.strategyStatus == StrategyStatus.loading;
    final inputFormatters = [LengthLimitingTextInputFormatter(3)];
    final currentClientStrategy = state.clientStrategy!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormSection(
          title: "Target Weight (Kg)",
          name: !isLoading ? "targetWeight" : "targetWeight-loading",
          hintText: "80 Kg",
          intialValue: currentClientStrategy.targetWeight.toString(),
          inputFormatters: inputFormatters,
          keyboardInputType: TextInputType.number,
          validator: FormBuilderValidators.required(
              errorText: "Target Weight is required"),
        ),
        context.setMinSize(20).verticalSpace,
        TextFormSection(
          title: "Muscle mass (Kg)",
          name: !isLoading ? "musclesMass" : "muscleMass-loading",
          hintText: "80 Kg",
          intialValue: currentClientStrategy.musclesMass.toString(),
          inputFormatters: inputFormatters,
          keyboardInputType: TextInputType.number,
          validator: FormBuilderValidators.required(
              errorText: "Muscle Mass is required"),
        ),
        context.setMinSize(20).verticalSpace,
        TextFormSection(
          title: "Body fat mass (Kg)",
          name: !isLoading ? "bodyFatMass" : "bodyFatMass-loading",
          hintText: "80 Kg",
          intialValue: currentClientStrategy.bodyFatMass.toString(),
          inputFormatters: inputFormatters,
          keyboardInputType: TextInputType.number,
          validator: FormBuilderValidators.required(
              errorText: "Body Fat Mass is required"),
        ),
        context.setMinSize(30).verticalSpace,
        state.strategyUpdateStatus == StrategyStatus.loading
            ? SizedBox(
                height: context.setMinSize(60), child: const CustomLoader())
            : CustomButton(
                onPressed: () {
                  if (formKey.currentState?.saveAndValidate() ?? false) {
                    final formData = formKey.currentState?.value;
                    final newStrategy = ClientStrategy(
                      targetWeight: int.parse(formData!['targetWeight']),
                      musclesMass: int.parse(formData['musclesMass']),
                      bodyFatMass: int.parse(formData['bodyFatMass']),
                      trainingType: state.currentTrainingType,
                    );

                    if (state.clientStrategy != newStrategy) {
                      context.read<StrategyCubit>().updateClientStrategy(
                          client.id!, newStrategy.toJson());
                    }
                  }
                },
                text: "save".tr()),
        context.setMinSize(30).verticalSpace,
      ],
    );
  }
}
