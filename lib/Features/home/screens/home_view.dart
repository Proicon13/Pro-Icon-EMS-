import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/dependencies.dart';
import 'package:pro_icon/Core/entities/user_entity.dart';
import 'package:pro_icon/Core/theme/app_text_styles.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';
import 'package:pro_icon/Core/widgets/app_bar_widget.dart';
import 'package:pro_icon/Core/widgets/pro_icon_logo.dart';
import 'package:pro_icon/Features/home/cubit/home_cubit.dart';

import '../../../Core/cubits/user_state/user_state_cubit.dart';
import '../widgets/categories_section.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => getIt<HomeCubit>()..getCategories(),
      child: Padding(
        padding: SizeConstants.kScaffoldPadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            context.setMinSize(30).verticalSpace,
            const Center(child: ProIconLogo()),
            context.setMinSize(30).verticalSpace,
            BlocSelector<UserStateCubit, UserStateState, UserEntity>(
              selector: (state) => state.currentUser!,
              builder: (context, state) {
                return AppBarWidget(text: "Welcome!", user: state);
              },
            ),
            const Divider(
              thickness: 2,
              color: Colors.grey,
            ),
            context.setMinSize(20).verticalSpace,
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Choose a category to start with",
                style: AppTextStyles.fontSize16(context)
                    .copyWith(color: Colors.white),
              ),
            ),
            context.setMinSize(20).verticalSpace,
            const CategoriesSection(),
          ],
        ),
      ),
    );
  }
}
