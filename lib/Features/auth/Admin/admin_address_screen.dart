import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_icon/Features/auth/Admin/confirm_admin_password.dart';
import '../../../Core/Theming/Colors/app_colors.dart';
import '../../../Core/widgets/base_app_Scaffold.dart';

class AdminAdressScreen extends StatefulWidget {
  static const routeName = '/admin-address';
  const AdminAdressScreen({super.key});

  @override
  State<AdminAdressScreen> createState() => _AdminAdressScreenState();
}

class _AdminAdressScreenState extends State<AdminAdressScreen> {
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
                    "Sign Up",
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
                          Row(
                            children: [
                              Container(
                                  width: 142,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(24)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: DropdownButton(
                                        items: const [],
                                        hint: const Text("Country"),
                                        onChanged: (value) {}),
                                  )),
                              const SizedBox(
                                width: 12,
                              ),
                              Container(
                                  width: 142,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(24)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: DropdownButton(
                                        items: const [],
                                        hint: const Text("City"),
                                        onChanged: (value) {}),
                                  )),
                            ],
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            height: 40,
                            child: TextFormField(
                              obscureText: true,
                              decoration: const InputDecoration(
                                label: Text("street name"),

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
                                label: Text("postal Code"),

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
                            context, ConfirmAdminPassword.routeName);
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
