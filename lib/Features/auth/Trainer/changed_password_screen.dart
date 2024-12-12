import 'package:flutter/material.dart';
import 'package:pro_icon/Core/widgets/base_app_Scaffold.dart';

import '../../../Core/Theming/Colors/app_colors.dart';

class ChangedPasswordScreen extends StatefulWidget {
  static const routeName = '/changed-password-screen';
  const ChangedPasswordScreen({super.key});

  @override
  State<ChangedPasswordScreen> createState() => _ChangedPasswordScreenState();
}

class _ChangedPasswordScreenState extends State<ChangedPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseAppScaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 170,
          ),
          const Image(image: AssetImage("assets/images/200-60-pro-2 1.png")),
          const SizedBox(
            height: 30,
          ),
          Container(
            width: 330,
            height: 270,
            decoration: BoxDecoration(
                color: Colors.white54, borderRadius: BorderRadius.circular(24)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Image(image: AssetImage("assets/images/Layer_1.png")),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Password Successfully Changed"),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    width: 294,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8)),
                    child: MaterialButton(
                      onPressed: () {},
                      color: AppColors.buttonColors,
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
