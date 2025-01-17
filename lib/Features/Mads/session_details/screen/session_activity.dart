import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pro_icon/Core/constants/app_assets.dart';
import 'package:pro_icon/Core/theme/app_colors.dart';
import 'package:pro_icon/Core/theme/app_text_styles.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_config.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';
import 'package:pro_icon/Core/widgets/base_app_Scaffold.dart';
import 'package:pro_icon/Core/widgets/custom_button.dart';
import 'package:pro_icon/Core/widgets/custom_date_picker_field.dart';
import 'package:pro_icon/Core/widgets/custom_header.dart';

class SessionActivityScreen extends StatelessWidget {
  static const routeName = '/session_activity';

  @override
  Widget build(BuildContext context) {
    // TODO: REFACTOR CODE INTO SEPERATE WIDGETS AND SECTIONS
    return BaseAppScaffold(
      resizeToAvoidButtomPadding: true,
      body: Padding(
        padding:  EdgeInsets.all(16), // use responsive scaffold padding from sizeConstants
        child: Column(
          children: [
            const SizedBox(
              // use responsive height and use from figma apply to all screens and widgets
              height: 40,
            ),
            const CustomHeader(titleKey: "Session activity"),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  "Chosse date",
                  style: AppTextStyles.fontSize16(context)
                      .copyWith(color: Colors.white),
                ),
                context.setMinSize(10).horizontalSpace,
                Expanded(
                    child: CustomDatePickerField(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: context.setMinSize(5),
                    vertical: context.setMinSize(10),
                  ),
                  name: "From",
                  hintText: "From",
                )),
                context.setMinSize(10).horizontalSpace,
                Expanded(
                    child: CustomDatePickerField(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: context.setMinSize(5),
                    vertical: context.setMinSize(10),
                  ),
                  name: "To",
                  hintText: "To",
                )),
                context.setMinSize(15).horizontalSpace, // use responsive spaces
                SizedBox(
                    width: context.setMinSize(60),
                    child: CustomButton(onPressed: () {}, text: "Apply"))
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  SizeConfig(
                      baseSize: const Size(398, 137),
                      width: context.setMinSize(398),
                      height: context.setMinSize(137),
                      child: Builder(builder: (context) {
                        return Container(
                            width: context.sizeConfig.width,
                            height: context.sizeConfig.height,
                            child: _buildSessionItem('ID. 4', '15-12-2024',
                                'Captain Ahmed Mohammed', context));
                      })),
                  SizeConfig(
                      baseSize: const Size(398, 137),
                      width: context.setMinSize(398),
                      height: context.setMinSize(137),
                      child: Builder(builder: (context) {
                        return Container(
                            width: context.sizeConfig.width,
                            height: context.sizeConfig.height,
                            child: _buildSessionItem('ID. 4', '15-12-2024',
                                'Captain Ahmed Mohammed', context));
                      })),
                  SizeConfig(
                      baseSize: const Size(398, 137),
                      width: context.setMinSize(398),
                      height: context.setMinSize(137),
                      child: Builder(builder: (context) {
                        return Container(
                            width: context.sizeConfig.width,
                            height: context.sizeConfig.height,
                            child: _buildSessionItem('ID. 4', '15-12-2024',
                                'Captain Ahmed Mohammed', context));
                      })),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSessionItem(String id, String date, String name, context) {
    // TODO: DO USE SIZECONFIG FOR RESPONSIVE TO PUT SIZES BASED ON CARD SIZE
    return Card(
        color: AppColors.darkGreyColor,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    Assets.assetsSessionIcon,
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 8), // مسافة صغيرة بين الأيقونة والنص
                  Text(
                    id,
                    style: AppTextStyles.fontSize14(context).copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(), // يقوم بملء المساحة المتبقية بين النصوص
                  Text(
                    date,
                    style: AppTextStyles.fontSize14(context).copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SvgPicture.asset(Assets.assetsForMadsUserIcon),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(name,
                      style: AppTextStyles.fontSize14(context)
                          .copyWith(color: Colors.white))
                ],
              ),
            ],
          ),
        ));
  }
}
