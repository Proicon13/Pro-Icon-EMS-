
  import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pro_icon/role_case.dart';

class SplashScreen extends StatefulWidget {
    const SplashScreen({super.key});

    @override
    State<SplashScreen> createState() => _SplashScreenState();
  }

  class _SplashScreenState extends State<SplashScreen> {
   
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 4) , (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => RoleCase()) );
    });
  }
    
    Widget build(BuildContext context) {
      return SafeArea(
        child: Scaffold(
          body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/splash.png") , fit: BoxFit.cover)
            ),
            child: Center(
              child: Image(image: AssetImage("assets/images/200-60-pro-2 1.png")),
            ),
          )
        ),
      );
    }
  }
