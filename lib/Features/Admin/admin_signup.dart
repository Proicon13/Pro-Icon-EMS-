
  import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_icon/Features/Admin/confirm_admin_password.dart';

import '../../Core/Theming/Colors/app_color.dart';

class AdminSignup extends StatefulWidget {
    const AdminSignup({super.key});

    @override
    State<AdminSignup> createState() => _AdminSignupState();
  }

  class _AdminSignupState extends State<AdminSignup> {
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
                    height: 340,
                    decoration: BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.circular(24)
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 20,),
                          Text("Sign Uo" ,style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ) , ),

                          SizedBox(height: 20,),
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
                                          borderRadius: BorderRadius.circular(24)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: DropdownButton(items: [], hint: Text("Country"), onChanged: (value){}),
                                        )),
                                      SizedBox(width: 12,),
                                      Container(
                                          width: 142,
                                          height: 35,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(24)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4),
                                            child: DropdownButton(items: [],hint: Text("City"), onChanged: (value){}),
                                          )),
                                    ],
                                  ),
                                  const SizedBox(height: 24),
                                  Container(
                                    height: 40,
                                    child: TextFormField(
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        label: Text("street name"),

                                        fillColor: Colors.white,

                                        filled: true,
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12), // تعديل الحشو الداخلي
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 24,),
                                  Container(
                                    height: 40,
                                    child: TextFormField(

                                      decoration: InputDecoration(
                                        label: Text("postal Code"),

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
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ConfirmAdminPassword()));
                              } ,
                              color: AppColor.buttonColors,
                              child: Text("Next" , style: TextStyle(
                                  color: Colors.white
                              ),),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(" have an  account ?"),
                              SizedBox(width: 8,),
                              Text("Sign In Here" , style: TextStyle(
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
