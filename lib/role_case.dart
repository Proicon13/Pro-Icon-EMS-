import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pro_icon/Core/Theming/Colors/app_colors.dart';
import 'package:pro_icon/Core/Theming/app_text_styles.dart';
import 'package:pro_icon/Core/constants/app_assets.dart';
import 'package:pro_icon/Core/widgets/base_app_Scaffold.dart';
import 'package:pro_icon/Core/widgets/custom_button.dart';
import 'package:pro_icon/Features/auth/Admin/Admin_auth.dart';
import 'Features/auth/Trainer/trainer.dart';

enum Role { admin, coach }

class RoleSelectionScreen extends StatefulWidget {
  static const routeName = '/role-case';
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  Role? selectedRole;

  void navigateBasedOnRole() {
    if (selectedRole == Role.admin) {
      // Navigate to Admin page
      Navigator.pushReplacementNamed(context, AdminAuth.routeName);
    } else if (selectedRole == Role.coach) {
      // Navigate to Coach page
      Navigator.pushReplacementNamed(context, TrainerAuth.routeName);
    } else {
      // If no role is selected
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please select a role"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseAppScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.w),
        child: Column(
          children: [
            SizedBox(height: 170.h),
            SizedBox(
                width: 200.w,
                child: AspectRatio(
                    aspectRatio: 200.w / 60.h,
                    child: const Image(
                        fit: BoxFit.cover,
                        image: AssetImage(Assets.assetsImagesLogo)))),
            SizedBox(height: 63.h),
            Container(
              decoration: BoxDecoration(
                color: AppColors.containerColor,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text("Welcome!",
                      style: AppTextStyles.fontSize20
                          .copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedRole = Role.admin;
                          });
                        },
                        child: Opacity(
                          opacity: selectedRole == Role.admin ? 0.5 : 1.0,
                          child: const Image(
                            image: AssetImage(Assets.assetsImagesAdmin),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedRole = Role.coach;
                          });
                        },
                        child: Opacity(
                          opacity: selectedRole == Role.coach ? 0.5 : 1.0,
                          child: const Image(
                            image: AssetImage(Assets.assetsImagesTrainer),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.w),
                      child: SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          text: 'Next',
                          onPressed: navigateBasedOnRole,
                        ),
                      )),
                  SizedBox(
                    height: 27.h,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
