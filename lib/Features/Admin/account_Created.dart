import 'package:flutter/material.dart';

class AccountCreatedScreen extends StatefulWidget {
  static const routeName = "/account-creted";
  const AccountCreatedScreen({super.key});

  @override
  State<AccountCreatedScreen> createState() => _AccountCreatedScreenState();
}

class _AccountCreatedScreenState extends State<AccountCreatedScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/splash.png"),
                fit: BoxFit.cover)),
        child: Column(
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
              height: 230,
              decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(24)),
              child: const SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Image(image: AssetImage("assets/images/Layer_1.png")),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Account created successfully"),
                    SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
