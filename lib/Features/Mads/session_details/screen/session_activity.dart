import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/dependencies.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';
import 'package:pro_icon/Core/widgets/base_app_Scaffold.dart';
import 'package:pro_icon/Core/widgets/custom_header.dart';
import 'package:pro_icon/Features/Mads/Cubit/cubit/session_details_cubit.dart';
import 'package:pro_icon/Features/Mads/session_details/widgets/cards_session_widget.dart';
import 'package:pro_icon/Features/Mads/session_details/widgets/choose_date_widget.dart';

class SessionActivityScreen extends StatelessWidget {
  final int madId;
  static const routeName = '/session_activity';
  const SessionActivityScreen({Key? key, required this.madId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SessionDetailsCubit>(
      create: (context) => getIt<SessionDetailsCubit>()
        ..setMadId(madId)
        ..fetchMadSessions(),
      child: BaseAppScaffold(
        body: Padding(
          padding: SizeConstants.kScaffoldPadding(
              context), // use responsive scaffold padding from sizeConstants
          child: Column(
            children: [
              context.setMinSize(30).verticalSpace,
              const CustomHeader(titleKey: "Session activity"),
              context.setMinSize(20).verticalSpace,
              const ChooseDateWidget(),
              context.setMinSize(16).verticalSpace,
              const CardsSessionWidget()
            ],
          ),
        ),
      ),
    );
  }
}
