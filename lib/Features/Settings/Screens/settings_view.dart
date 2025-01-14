import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/cubits/user_state/user_state_cubit.dart';
import 'package:pro_icon/Core/theme/app_colors.dart';
import 'package:pro_icon/Core/theme/app_text_styles.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';
import 'package:pro_icon/Core/widgets/custom_circular_image.dart';
import 'package:pro_icon/Core/widgets/custom_header.dart';
import 'package:pro_icon/Features/Mads/Screens/Mads_screen.dart';
import 'package:pro_icon/Features/ProgrammingRequst/screen/Programming_request.dart';

import '../../../Core/dependencies.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
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
      'title': 'Programming request',
      'icon': Icons.backup_table_outlined,
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
    return Padding(
      padding: SizeConstants.kScaffoldPadding(context),
      child: Column(
        children: [
          // CustomAppBar
          context.setMinSize(30).verticalSpace,
          CustomHeader(
            titleKey: "settings".tr(),
            isIconVisible: false,
          ),
          context.setMinSize(30).verticalSpace,

          Row(
            children: [
              CustomCircularImage(
                  width: context.setMinSize(80),
                  height: context.setMinSize(80),
                  imageUrl: getIt<UserStateCubit>().state.currentUser!.image!),
              const SizedBox(width: 16),

              // get user info from user state
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Admin 123",
                      style: AppTextStyles.fontSize20(context).copyWith(
                        color: Colors.white,
                      )),
                  context.setMinSize(10).verticalSpace,
                  Text("omarsabry8989@gmail.com",
                      style: AppTextStyles.fontSize16(context).copyWith(
                        color: AppColors.white71Color,
                      )),
                ],
              ),
            ],
          ),
          context.setMinSize(30).verticalSpace,

          Expanded(
            child: ListView.builder(
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
                  trailing:
                      const Icon(Icons.arrow_forward_ios, color: Colors.white),
                  onTap: () {
                    // إضافة وظيفة عند النقر على العنصر
                    switch (item['title']) {
                      case 'Edit Profile':
                        // انتقل إلى شاشة تعديل الملف الشخصي
                        break;
                      case 'Mads':
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const MadsScreen()));
                        break;
                      case 'Programming request':
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const ProgrammingRequest()));
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
