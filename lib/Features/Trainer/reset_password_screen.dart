import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Core/Theming/Colors/app_color.dart';
import 'changed_password_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const routeName = '/reset-password';
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/splash.png"),
                fit: BoxFit.cover)),
        child: Column(
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
              height: 300,
              decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(24)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Forgot Password",
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
                                obscureText: true,
                                decoration: const InputDecoration(
                                  label: Text("New Password"),
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
                                  label: Text(" Confirm Password"),

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
                              context, ChangedPasswordScreen.routeName);
                        },
                        color: AppColor.buttonColors,
                        child: const Text(
                          "Save",
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
      )),
    );
  }
}
