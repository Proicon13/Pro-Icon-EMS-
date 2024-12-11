
  import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:pro_icon/Features/Trainer/reset_password.dart';

import '../../Core/Theming/Colors/app_color.dart';

class ForgotPassword extends StatefulWidget {
    const ForgotPassword({super.key});

    @override
    State<ForgotPassword> createState() => _ForgotPasswordState();
  }

  class _ForgotPasswordState extends State<ForgotPassword> {
    @override
    Widget build(BuildContext context) {
      return  SafeArea(
        child: Scaffold(
            body: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/images/splash.png") , fit: BoxFit.cover)
              ),
              child: Column(
                children: [
                  SizedBox(height: 170,),
                  Image(image: AssetImage("assets/images/200-60-pro-2 1.png")),
                  SizedBox(height: 30,),
                  Container(
                    width: 330,
                    height: 300,
                    decoration: BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.circular(24)
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(

                          children: [
                            SizedBox(height: 20,),
                            Text("Forget password" ,style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            ) , ),

                            Padding(
                              padding: const EdgeInsets.only(left: 30 , right: 20),
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

                            OtpForm(),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("Resend code"),
                                Text("s 00:56" , style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black
                                ),)
                              ],
                            ),





                            SizedBox(height: 12,),
                            Container(
                              width: 294 ,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              child: MaterialButton(
                                onPressed: (){
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>ResetPassword()));
                                } ,
                                color: AppColor.buttonColors,
                                child: Text("Send" , style: TextStyle(
                                    color: Colors.white,
                                  fontSize: 16
                                ),),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
        ),
      );
    }
  }
  var authOutlineInputBorder = OutlineInputBorder(

    borderRadius: const BorderRadius.all(Radius.circular(12)),

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
                             BorderSide(color: AppColor.buttonColor))),
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
                            BorderSide(color: AppColor.buttonColor))),
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
                            BorderSide(color: AppColor.buttonColor))),
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
                            BorderSide(color: AppColor.buttonColor))),
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
                            BorderSide(color: AppColor.buttonColor))),
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
                            BorderSide(color: AppColor.buttonColor))),
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
