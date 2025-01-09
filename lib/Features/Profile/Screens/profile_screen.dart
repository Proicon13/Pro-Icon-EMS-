import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/cubits/phone_registration/phone_register_cubit.dart';
import 'package:pro_icon/Core/cubits/region_cubit/region_cubit.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';
import 'package:pro_icon/Core/widgets/base_app_scaffold.dart';
import 'package:pro_icon/Core/widgets/custom_header.dart';
import 'package:pro_icon/Features/Profile/Cubit/profile_cubit.dart';

import '../../../Core/dependencies.dart';
import '../../../Core/widgets/keyboard_dismissable.dart';
import '../widgets/profile_image_section.dart';
import '../widgets/update_profile_form.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = "ProfileScreen";
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileCubit>(
          create: (context) => getIt<ProfileCubit>(),
        ),
        BlocProvider<RegionCubit>(
          create: (context) => getIt<RegionCubit>()..getCountries(),
        ),
        BlocProvider<PhoneRegistrationCubit>(
          create: (context) => getIt<PhoneRegistrationCubit>(),
        )
      ],
      child: KeyboardDismissable(
        child: BaseAppScaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: SizeConstants.kScaffoldPadding(context),
              child: Column(
                children: [
                  context.setMinSize(30).verticalSpace,
                  CustomHeader(titleKey: "profile".tr()),
                  context.setMinSize(30).verticalSpace,
                  const ProfileImageSection(),
                  context.setMinSize(20).verticalSpace,
                  UpdateProfileForm(formKey: _formKey)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
