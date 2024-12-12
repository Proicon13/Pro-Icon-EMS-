import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_icon/Core/widgets/base_app_Scaffold.dart';

import '../../Core/Theming/Colors/app_color.dart';
import 'forgot_password_screen.dart';

class OtpScreen extends StatefulWidget {
  static const String routeName = '/otp-screen';
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
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
            height: 300,
            decoration: BoxDecoration(
                color: Colors.white54, borderRadius: BorderRadius.circular(24)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Forget password",
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 30, right: 20),
                      child: Text(
                        'Please enter the code sent to your email',
                        style: TextStyle(
                          fontSize: 14, // حجم الخط
                          color: Colors.black, // لون النص
                          fontWeight: FontWeight.normal, // سمك الخط
                          height: 1.5, // المسافة بين الأسطر
                        ),
                      ),
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
                              context, ForgotPasswordScreen.routeName);
                        },
                        color: AppColor.buttonColors,
                        child: const Text(
                          "Send",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
