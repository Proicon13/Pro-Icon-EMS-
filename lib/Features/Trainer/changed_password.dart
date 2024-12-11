
  import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Core/Theming/Colors/app_color.dart';

class ChangedPassword extends StatefulWidget {
    const ChangedPassword({super.key});

    @override
    State<ChangedPassword> createState() => _ChangedPasswordState();
  }

  class _ChangedPasswordState extends State<ChangedPassword> {
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
                    height: 270,
                    decoration: BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.circular(24)
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 20,),


                          Image(image: AssetImage("assets/images/Layer_1.png")),
                          SizedBox(height: 20,),

                          Text("Password Successfully Changed"),

                          SizedBox(height: 12,),
                          Container(
                            width: 294 ,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child: MaterialButton(
                              onPressed: (){

                              } ,
                              color: AppColor.buttonColors,
                              child: Text("Login" , style: TextStyle(
                                  color: Colors.white
                              ),),
                            ),
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
