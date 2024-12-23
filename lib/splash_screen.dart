import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/cubits/cubit/user_state_cubit.dart';
import 'package:pro_icon/Core/widgets/base_app_Scaffold.dart';
import 'package:pro_icon/Core/widgets/pro_icon_logo.dart';
import 'package:pro_icon/Features/auth/role_selection/screens/role_selection_screen.dart';
import 'package:pro_icon/Features/users/screens/users_screen.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserStateCubit>().intializeUser();
  }

  @override
  Widget build(BuildContext context) {
    return BaseAppScaffold(
        body: BlocListener<UserStateCubit, UserStateState>(
      listener: (context, state) {
        if (state.userStatus == UserStatus.loggedIn) {
          Future.delayed(const Duration(seconds: 2), () {
            if (context.mounted) {
              Navigator.of(context).pushReplacementNamed(UsersScreen.routeName);
            }
          });
        } else {
          Future.delayed(const Duration(seconds: 2), () {
            if (context.mounted) {
              Navigator.of(context)
                  .pushReplacementNamed(RoleSelectionScreen.routeName);
            }
          });
        }
      },
      child: const Center(
        child: ProIconLogo(),
      ),
    ));
  }
}
