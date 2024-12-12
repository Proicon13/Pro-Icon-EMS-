import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_icon/Core/widgets/base_app_Scaffold.dart';

import 'package:pro_icon/Features/Trainer/reset_password_screen.dart';

import '../../Core/Theming/Colors/app_color.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = '/forgot-password-screen';
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
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
                    const OtpForm(),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Resend code"),
                        Text(
                          "s 00:56",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        )
                      ],
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
                              context, ResetPasswordScreen.routeName);
                        },
                        color: AppColor.buttonColors,
                        child: const Text(
                          "Send",
                          style: TextStyle(color: Colors.white, fontSize: 16),
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

var authOutlineInputBorder = const OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(12)),
);

class OtpForm extends StatelessWidget {
  const OtpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 40,
                width: 40,
                child: TextFormField(
                  onSaved: (pin) {},
                  onChanged: (pin) {
                    if (pin.isNotEmpty) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[100],
                      hintStyle: const TextStyle(color: Color(0xFF757575)),
                      border: authOutlineInputBorder,
                      enabledBorder: authOutlineInputBorder,
                      focusedBorder: authOutlineInputBorder.copyWith(
                          borderSide:
                              const BorderSide(color: AppColor.buttonColor))),
                ),
              ),
              SizedBox(
                height: 40,
                width: 40,
                child: TextFormField(
                  onSaved: (pin) {},
                  onChanged: (pin) {
                    if (pin.isNotEmpty) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[100],
                      hintStyle: const TextStyle(color: Color(0xFF757575)),
                      border: authOutlineInputBorder,
                      enabledBorder: authOutlineInputBorder,
                      focusedBorder: authOutlineInputBorder.copyWith(
                          borderSide:
                              const BorderSide(color: AppColor.buttonColor))),
                ),
              ),
              SizedBox(
                height: 40,
                width: 40,
                child: TextFormField(
                  onSaved: (pin) {},
                  onChanged: (pin) {
                    if (pin.isNotEmpty) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[100],
                      hintStyle: const TextStyle(color: Color(0xFF757575)),
                      border: authOutlineInputBorder,
                      enabledBorder: authOutlineInputBorder,
                      focusedBorder: authOutlineInputBorder.copyWith(
                          borderSide:
                              const BorderSide(color: AppColor.buttonColor))),
                ),
              ),
              SizedBox(
                height: 40,
                width: 40,
                child: TextFormField(
                  onSaved: (pin) {},
                  onChanged: (pin) {
                    if (pin.isNotEmpty) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[100],
                      hintStyle: const TextStyle(color: Color(0xFF757575)),
                      border: authOutlineInputBorder,
                      enabledBorder: authOutlineInputBorder,
                      focusedBorder: authOutlineInputBorder.copyWith(
                          borderSide:
                              const BorderSide(color: AppColor.buttonColor))),
                ),
              ),
              SizedBox(
                height: 40,
                width: 40,
                child: TextFormField(
                  onSaved: (pin) {},
                  onChanged: (pin) {
                    if (pin.isNotEmpty) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[100],
                      hintStyle: const TextStyle(color: Color(0xFF757575)),
                      border: authOutlineInputBorder,
                      enabledBorder: authOutlineInputBorder,
                      focusedBorder: authOutlineInputBorder.copyWith(
                          borderSide:
                              const BorderSide(color: AppColor.buttonColor))),
                ),
              ),
              SizedBox(
                height: 40,
                width: 40,
                child: TextFormField(
                  onSaved: (pin) {},
                  onChanged: (pin) {
                    if (pin.isNotEmpty) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[100],
                      hintStyle: const TextStyle(color: Color(0xFF757575)),
                      border: authOutlineInputBorder,
                      enabledBorder: authOutlineInputBorder,
                      focusedBorder: authOutlineInputBorder.copyWith(
                          borderSide:
                              const BorderSide(color: AppColor.buttonColor))),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
