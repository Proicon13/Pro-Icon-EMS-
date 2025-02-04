import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/dependencies.dart';
import 'package:pro_icon/Core/widgets/base_app_scaffold.dart';
import 'package:pro_icon/Core/widgets/custom_app_bar.dart';
import 'package:pro_icon/Features/client_details/cubit/cubit/client_details_cubit.dart';

import '../../Core/widgets/keyboard_dismissable.dart';
import 'widgets/client_details_body.dart';

class ClientDetailsScreen extends StatelessWidget {
  static const routeName = '/client_details_screen';
  final int clientId;
  const ClientDetailsScreen({super.key, required this.clientId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ClientDetailsCubit>(
      create: (context) =>
          getIt<ClientDetailsCubit>()..getClientDetails(clientId),
      child: KeyboardDismissable(
        child: BaseAppScaffold(
          appBar: CustomAppBar(titleKey: "clientInfo.title".tr()),

          body: const ClientDetailsBody(),
        ),
      ),
    );
  }
}
