import 'package:flutter/material.dart';
import 'package:pro_icon/Core/constants/app_assets.dart';
import 'package:pro_icon/Core/widgets/base_app_Scaffold.dart';
import 'package:pro_icon/Features/auth/role_selection/role_selection_screen.dart';

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
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => const RoleSelectionScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const BaseAppScaffold(
      body: Center(
        child: Image(image: AssetImage(Assets.assetsImagesLogo)),
      ),
    );
  }
}
