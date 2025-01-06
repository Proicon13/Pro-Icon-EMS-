
  import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/widgets/base_app_scaffold.dart';
import 'package:pro_icon/Features/CategoryDetails/Widget/custom_app_bar.dart';

  import 'package:flutter/material.dart';
import 'package:pro_icon/Features/Mads/Screens/Mads_screen.dart';

  class SettingsScreen extends StatefulWidget {
    const SettingsScreen({super.key});

    @override
    State<SettingsScreen> createState() => _SettingsScreenState();
  }

  class _SettingsScreenState extends State<SettingsScreen> {

    final List<Map<String, dynamic>> settingsItems = [
      {
        'title': 'Edit Profile',
        'icon': Icons.person,
      },
      {
        'title': 'Mads',
        'icon': Icons.video_library,
      },
      {
        'title': 'Language',
        'icon': Icons.language,
      },
      {
        'title': 'Logout',
        'icon': Icons.logout,
      },
    ];

    @override
    Widget build(BuildContext context) {
      return BaseAppScaffold(
        resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            // CustomAppBar
            CustomAppBar(icon: Icons.arrow_back_ios, text: "Settings"),
            40.h.verticalSpace,


            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage("assets/images/userImage.png"),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Admin 123",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "omarsabry8989@gmail.com",
                        style: TextStyle(
                          color: Colors.white60,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            40.h.verticalSpace,


            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                itemCount: settingsItems.length,
                itemBuilder: (context, index) {
                  final item = settingsItems[index];
                  return ListTile(
                    leading: Icon(item['icon'], color: Colors.white),
                    title: Text(
                      item['title'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                    onTap: () {
                      // إضافة وظيفة عند النقر على العنصر
                      switch (item['title']) {
                        case 'Edit Profile':
                        // انتقل إلى شاشة تعديل الملف الشخصي
                          break;
                        case 'Mads':
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MadsScreen()));
                          break;
                        case 'Language':
                        // انتقل إلى شاشة اللغة
                          break;
                        case 'Logout':
                        // تنفيذ عملية تسجيل الخروج
                          break;
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      );
    }
  }