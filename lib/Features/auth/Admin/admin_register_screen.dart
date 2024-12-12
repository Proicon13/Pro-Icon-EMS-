import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_icon/Core/widgets/base_app_Scaffold.dart';
import 'package:pro_icon/Features/auth/Admin/admin_address_screen.dart';

import '../../../Core/Theming/Colors/app_colors.dart';

class AdminRegisterScreen extends StatefulWidget {
  static const String routeName = "/admin-register";
  const AdminRegisterScreen({super.key});

  @override
  State<AdminRegisterScreen> createState() => _AdminRegisterScreenState();
}

class _AdminRegisterScreenState extends State<AdminRegisterScreen> {
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
            height: 340,
            decoration: BoxDecoration(
                color: Colors.white54, borderRadius: BorderRadius.circular(24)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Sign Uo",
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                label: Text("Email"),
                                fillColor: Colors.white,
                                filled: true,
                                isDense: true, // تقليل الارتفاع
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 12), // تعديل الحشو الداخلي
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            height: 40,
                            child: TextFormField(
                              obscureText: true,
                              decoration: const InputDecoration(
                                label: Text("Password"),

                                fillColor: Colors.white,

                                filled: true,
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 12), // تعديل الحشو الداخلي
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          SizedBox(
                            height: 40,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                label: Text("phone Number"),

                                fillColor: Colors.white,

                                filled: true,
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 12), // تعديل الحشو الداخلي
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    width: 294,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8)),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, AdminAdressScreen.routeName);
                      },
                      color: AppColors.buttonColors,
                      child: const Text(
                        "Next",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(" have an  account ?"),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Sign In Here",
                        style: TextStyle(color: Colors.red),
                      )
                    ],
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
