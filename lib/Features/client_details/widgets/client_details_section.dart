import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../Core/entities/client_entity.dart';
import '../../../Core/utils/responsive_helper/size_constants.dart';
import '../../../Core/widgets/custom_snack_bar.dart';
import '../cubit/cubit/client_details_cubit.dart';
import 'client_details_card.dart';

class ClientDetailsSection extends StatelessWidget {
  const ClientDetailsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: SizeConstants.kScaffoldPadding(context),
      child: BlocConsumer<ClientDetailsCubit, ClientDetailsState>(
        listener: (context, state) {
          if (state.status == ClientDetailsStatus.error) {
            buildCustomAlert(context, state.message!, Colors.red);
          }
        },
        buildWhen: (previous, current) =>
            previous.status != current.status ||
            previous.client != current.client,
        builder: (context, state) {
          switch (state.status) {
            case ClientDetailsStatus.error:
              return const SizedBox.shrink();
            case ClientDetailsStatus.success:
              return ClientDetailsCard(
                  onProfileImageTap: () {
                    context.read<ClientDetailsCubit>().onUpdateProfile(
                          state.client!.id!,
                        );
                  },
                  client: state.client!);
            case ClientDetailsStatus.loading:
              return const Skeletonizer(
                enabled: true,
                child: ClientDetailsCard(
                  client: ClientEntity(
                    id: 0,
                    address: "loading",
                    email: "loading",
                    fullname: "loading",
                    phone: "loading",
                    weight: 10,
                    height: 10,
                    gender: "loading",
                  ),
                ),
              );

            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
