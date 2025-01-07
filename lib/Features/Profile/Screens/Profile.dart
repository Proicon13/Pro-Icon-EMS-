import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/widgets/base_app_Scaffold.dart';
import 'package:pro_icon/Core/widgets/custom_button.dart';
import 'package:pro_icon/Core/widgets/custom_dropdown_section.dart';
import 'package:pro_icon/Core/widgets/text_form_section.dart';
import 'package:pro_icon/Features/CategoryDetails/Widget/custom_app_bar.dart';
import 'package:pro_icon/Features/auth/register/widgets/phone_form_field.dart';
import 'package:pro_icon/Features/home/screens/home_screen.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return BaseAppScaffold(
      resizeToAvoidButtomPadding: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(
              icon: Icons.arrow_back_ios,
              text: "Profile",
              onIconPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()));
              },
            ),
            40.h.verticalSpace,
            Column(
              children: [
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      child: Image(
                        image: AssetImage("assets/images/userImage.png"),
                        fit: BoxFit.cover,
                        width: 93,
                      ),
                    ),
                    Positioned(
                      left: 10,
                      bottom: 0,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Icon(Icons.edit, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            20.h.verticalSpace,
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextFormSection(
                title: "Full name",
                keyboardInputType: TextInputType.text,
                name: "omar Sabry",
                hintText: "omar Sabry",
              ),
            ),
            20.h.verticalSpace,
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextFormSection(
                title: "Email",
                keyboardInputType: TextInputType.text,
                name: "omar Sabry",
                hintText: "omarsabry8989@gmail.com",
              ),
            ),
            40.h.verticalSpace,
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: PhoneNumberField(
                  countryCode: "20",
                  onCountryCodeChanged: (value) {},
                  validator: (value) {
                    return null;
                  }),
            ),
            40.h.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 130,
                      child: const DropdownFormSection(
                          title: "Country",
                          name: "Egypt",
                          hintText: "Egypt",
                          items: []),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 130,
                      child: const DropdownFormSection(
                          title: "City",
                          name: "Sohag",
                          hintText: "sohag",
                          items: []),
                    ),
                  ),
                ),
              ],
            ),
            40.h.verticalSpace,
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextFormSection(
                title: "Full Adress",
                keyboardInputType: TextInputType.text,
                name: "address",
                hintText: "Egypt , sohag , 20st",
              ),
            ),
            40.h.verticalSpace,
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                  width: 380,
                  child: CustomButton(onPressed: () {}, text: "Confirm")),
            ),
            20.h.verticalSpace
          ],
        ),
      ),
    );
  }
}
