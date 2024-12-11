import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_icon/Core/Theming/Colors/app_color.dart';
import 'package:pro_icon/Features/Admin/Admin_auth.dart';

import 'Features/Trainer/trainer.dart';



class RoleCase extends StatefulWidget {
  const RoleCase({super.key});

  @override
  State<RoleCase> createState() => _RoleCaseState();
}

class _RoleCaseState extends State<RoleCase> {


  String selectedRole = "";

  void navigateBasedOnRole() {
    if (selectedRole == "Admin") {
      // التوجيه لصفحة الأدمن
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => AdminAuth()));
    // استبدل بـ اسم صفحة الأدمن الفعلي
    } else if (selectedRole == "Coach") {
      // التوجيه لصفحة المدرب
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => TrainerAuth()));  // استبدل بـ اسم صفحة المدرب الفعلي
    } else {
      // إذا لم يتم اختيار دور
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("يرجى اختيار دور أولاً!"),
      ));
    }
  }


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
                  height: 295,
                  decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.circular(24)
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      Text("Welcome!" ,style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      ) , ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                            InkWell(
                                onTap: ()
                                {
                                  setState(() {
                                    selectedRole = "Admin";
                                  });
                                },
                                child: Opacity(
                                  opacity: selectedRole == "Admin" ? 0.5 : 1.0,
                                    child: Image(image: AssetImage("assets/images/Group 2.png")))),
                            InkWell(
                              onTap: ()
                                {
                                  setState(() {
                                    selectedRole = "Coach";
                                  });
                                },
                                child: Opacity(
                                  opacity: selectedRole == "Coach" ? 0.5 : 1.0,
                                    child: Image(image: AssetImage("assets/images/Group 1.png"))))
                        ],
                      ),
                    SizedBox(height: 20,),
                    Container(
                      width: 294 ,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: MaterialButton(
                        onPressed: (){
                          navigateBasedOnRole();
                        } ,
                        color: AppColor.buttonColors,
                        child: Text("Next" , style: TextStyle(
                          color: Colors.white
                        ),),
                      ),
                    )
                    ],
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
