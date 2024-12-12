// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../Core/widgets/base_app_Scaffold.dart';
// Ensure correct import path

class AccountCreatedScreen extends StatefulWidget {
  static const routeName = "/account-creted";
  const AccountCreatedScreen({super.key});

  @override
  State<AccountCreatedScreen> createState() => _AccountCreatedScreenState();
}

class _AccountCreatedScreenState extends State<AccountCreatedScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseAppScaffold(
      body: Column(
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
                color: Colors.white54, borderRadius: BorderRadius.circular(24)),
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
    );
  }
}
