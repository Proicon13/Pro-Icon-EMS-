import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_icon/Core/Theming/Colors/app_color.dart';
import 'package:pro_icon/Features/Admin/Admin_auth.dart';
import 'Features/Trainer/trainer.dart';

enum Role { admin, coach }

class RoleCase extends StatefulWidget {
  static const routeName = '/role-case';
  const RoleCase({super.key});

  @override
  State<RoleCase> createState() => _RoleCaseState();
}

class _RoleCaseState extends State<RoleCase> {
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
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/splash.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 170),
              const Image(
                  image: AssetImage("assets/images/200-60-pro-2 1.png")),
              const SizedBox(height: 30),
              Container(
                width: 330,
                height: 295,
                decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      "Welcome!",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
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
                              image: AssetImage("assets/images/Group 2.png"),
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
                              image: AssetImage("assets/images/Group 1.png"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: 294,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: MaterialButton(
                        onPressed: navigateBasedOnRole,
                        color: AppColor.buttonColors,
                        child: const Text(
                          "Next",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
