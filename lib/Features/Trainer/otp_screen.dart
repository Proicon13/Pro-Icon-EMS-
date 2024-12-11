import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Core/Theming/Colors/app_color.dart';
import 'forgot_password.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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




                          SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: SingleChildScrollView(
                              child: Column(

                                children: [
                                  Container(
                                    height: 40,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        label: Text("Email"),
                                        fillColor: Colors.white,
                                        filled: true,
                                        isDense: true, // تقليل الارتفاع
                                        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12), // تعديل الحشو الداخلي
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 24),


                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 12,),
                          Container(
                            width: 294 ,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child: MaterialButton(
                              onPressed: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ForgotPassword()));
                              } ,
                              color: AppColor.buttonColors,
                              child: Text("Send" , style: TextStyle(
                                  color: Colors.white
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
