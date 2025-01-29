import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pro_icon/Core/utils/enums/gender.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';
import 'package:pro_icon/Core/widgets/base_app_scaffold.dart';
import 'package:pro_icon/Core/widgets/custom_app_bar.dart';
import 'package:pro_icon/Core/widgets/custom_button.dart';
import 'package:pro_icon/Core/widgets/custom_loader.dart';
import 'package:pro_icon/Core/widgets/custom_snack_bar.dart';
import 'package:pro_icon/Core/widgets/keyboard_dismissable.dart';
import 'package:pro_icon/Features/clients/add_client/cubits/cubit/client_registration_cubit.dart';
import 'package:pro_icon/Features/clients/add_client/widgets/client_additional_data_form.dart';
import 'package:pro_icon/Features/main/main_screen.dart';
import 'package:pro_icon/data/models/client_regestraion_request_builder.dart';

import '../../../../Core/dependencies.dart';
import '../../../main/cubit/cubit/main_cubit.dart';
import '../../../session_managment/control_panel/screens/control_panel_screen.dart';

class ClientAdditionalDataScreen extends StatefulWidget {
  static const routeName = '/client-additional-data';
  final String toRoute; // the route to navigate to after adding the client
  const ClientAdditionalDataScreen({super.key, required this.toRoute});

  @override
  State<ClientAdditionalDataScreen> createState() =>
      _ClientAdditionalDataScreenState();
}

class _ClientAdditionalDataScreenState
    extends State<ClientAdditionalDataScreen> {
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
    return BlocProvider<ClientRegistrationCubit>(
      create: (context) => getIt<ClientRegistrationCubit>(),
      child: KeyboardDismissable(
        child: BaseAppScaffold(
          appBar: CustomAppBar(titleKey: 'userManagment.screen.addClient'.tr()),
          body: Padding(
            padding: SizeConstants.kScaffoldPadding(context),
            child: AddClientBody(
              formKey: _formKey,
            ),
          ),
          bottomNavigationBar: Padding(
            padding: SizeConstants.kBottomNavBarPadding(context),
            child:
                BlocConsumer<ClientRegistrationCubit, ClientRegistrationState>(
              listener: (context, state) {
                if (state.requestStatus == RequestStatus.success) {
                  // reset client registration builder after success
                  ClientRegistrationBuilder().reset();
                  buildCustomAlert(context, state.message!, Colors.green);
                  Future.delayed(const Duration(seconds: 3), () {
                    if (context.mounted) {
                      if (widget.toRoute == MainScreen.routeName) {
                        Navigator.pushReplacementNamed(
                          context,
                          MainScreen.routeName,
                          arguments: MainSections.users,
                        );
                      } else {
                        Navigator.popUntil(context,
                            ModalRoute.withName(ControlPanelScreen.routeName));
                      }
                    }
                  });
                } else if (state.requestStatus == RequestStatus.error) {
                  buildCustomAlert(context, state.message!, Colors.red);
                }
              },
              builder: (context, state) {
                if (state.requestStatus == RequestStatus.loading) {
                  return SizedBox(
                    height: context.setMinSize(50),
                    child: const CustomLoader(),
                  );
                }
                return Builder(builder: (context) {
                  return CustomButton(
                      onPressed: () => _onSubmit(context),
                      text: "confirm".tr());
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  void _onSubmit(BuildContext context) {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final formData = _formKey.currentState!.value;

      // use builder to build current fields
      final builder = ClientRegistrationBuilder()
          .setEmail(formData['email'])
          .setBirthDate(formData['birthdate'])
          .setGender((formData['gender'] as Gender).jsonName)
          .setHeight(int.parse(formData['height']))
          .setWeight(int.parse(formData['weight']));

      final clientData = builder.build();

      BlocProvider.of<ClientRegistrationCubit>(context, listen: false)
          .registerClient(clientData);
    }
  }
}

class AddClientBody extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  const AddClientBody({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return ClientAdditionalDataForm(formKey: formKey);
  }
}
