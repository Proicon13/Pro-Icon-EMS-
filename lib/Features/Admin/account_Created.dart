
  import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Core/Theming/Colors/app_color.dart';

class AccountCreated extends StatefulWidget {
    const AccountCreated({super.key});

    @override
    State<AccountCreated> createState() => _AccountCreatedState();
  }

  class _AccountCreatedState extends State<AccountCreated> {
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
                    height: 230,
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

                          Text("Account created successfully"),

                          SizedBox(height: 12,),

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
