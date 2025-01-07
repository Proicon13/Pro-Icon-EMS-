import 'package:flutter/material.dart';
import 'package:pro_icon/Features/Profile/Screens/Profile.dart';

class AppBarWidget extends StatelessWidget {
  final String text;
  final String username;
  const AppBarWidget({super.key, required this.text, required this.username});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                text,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                username,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.normal),
              )
            ],
          ),
          InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const Profile()));
              },
              child:
                  const Image(image: AssetImage("assets/images/userImage.png")))
        ],
      ),
    );
  }
}
