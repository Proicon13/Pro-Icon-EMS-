
  import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_icon/Features/Admin/account_Created.dart';

import '../../Core/Theming/Colors/app_color.dart';

class ConfirmAdminPassword extends StatefulWidget {
    const ConfirmAdminPassword({super.key});

    @override
    State<ConfirmAdminPassword> createState() => _ConfirmAdminPasswordState();
  }

  class _ConfirmAdminPasswordState extends State<ConfirmAdminPassword> {
    @override
    Widget build(BuildContext context) {
      return   SafeArea(
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
                      child: Column(
                        children: [
                          SizedBox(height: 20,),
                          Text("Sign Up" ,style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ) , ),

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
                                        label: Text("Password"),
                                        fillColor: Colors.white,
                                        filled: true,
                                        isDense: true, // تقليل الارتفاع
                                        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12), // تعديل الحشو الداخلي
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  Container(
                                    height: 40,
                                    child: TextFormField(
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        label: Text("Confirm Password"),

                                        fillColor: Colors.white,

                                        filled: true,
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12), // تعديل الحشو الداخلي
                                      ),
                                    ),
                                  ),

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
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => AccountCreated()));
                              } ,
                              color: AppColor.buttonColors,
                              child: Text("Confirm Password" , style: TextStyle(
                                  color: Colors.white
                              ),),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("have an account ?"),
                              SizedBox(width: 8,),
                              Text("Sign up Here" , style: TextStyle(
                                  color: Colors.red
                              ),)
                            ],
                          )
                        ],
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
