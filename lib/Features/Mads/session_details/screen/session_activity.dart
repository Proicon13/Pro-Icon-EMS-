import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pro_icon/Core/constants/app_assets.dart';
import 'package:pro_icon/Core/theme/app_colors.dart';
import 'package:pro_icon/Core/theme/app_text_styles.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_config.dart';
import 'package:pro_icon/Core/widgets/base_app_Scaffold.dart';
import 'package:pro_icon/Core/widgets/custom_date_picker_field.dart';
import 'package:pro_icon/Core/widgets/custom_header.dart';

class SessionActivityScreen extends StatelessWidget {

  static const routeName ='/session_activity';

  @override
  Widget build(BuildContext context) {
    return BaseAppScaffold(
      resizeToAvoidButtomPadding: true,

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 40,),
            CustomHeader(titleKey: "Session activity"),
            SizedBox(height: 20,),
            Row(
              children: [
                Text("Chosse date" , style: AppTextStyles.fontSize16(context).copyWith(
                  color: Colors.white
                ),),
                SizedBox(width: 20,),
                Expanded(
                  child: CustomDatePickerField(name: "From" , hintText: "From",)
                ),
                SizedBox(width: 16),
                Expanded(
                  child: CustomDatePickerField(name: "To" , hintText: "To",)
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    // Apply action
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.red)
                  ),
                  child: Text('Apply' , style: AppTextStyles.fontSize16(context).copyWith(
                    color: Colors.white
                  ),),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  SizeConfig(
                    
                      baseSize: Size(398, 137),
                      width: context.setMinSize(398) ,
                      height: context.setMinSize(137) ,
                      child: Builder(
                        builder: (context) {
                          return Container(
                            width: context.sizeConfig.width,
                              height: context.sizeConfig.height,
                              child: _buildSessionItem('ID. 4', '15-12-2024', 'Captain Ahmed Mohammed' ,context));
                        }
                      )),
                  SizeConfig(

                      baseSize: Size(398, 137),
                      width: context.setMinSize(398) ,
                      height: context.setMinSize(137) ,
                      child: Builder(
                          builder: (context) {
                            return Container(
                                width: context.sizeConfig.width,
                                height: context.sizeConfig.height,
                                child: _buildSessionItem('ID. 4', '15-12-2024', 'Captain Ahmed Mohammed' ,context));
                          }
                      )),
                  SizeConfig(

                      baseSize: Size(398, 137),
                      width: context.setMinSize(398) ,
                      height: context.setMinSize(137) ,
                      child: Builder(
                          builder: (context) {
                            return Container(
                                width: context.sizeConfig.width,
                                height: context.sizeConfig.height,
                                child: _buildSessionItem('ID. 4', '15-12-2024', 'Captain Ahmed Mohammed' ,context));
                          }
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSessionItem(String id, String date, String name , context) {


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
                    SizedBox(width: 8), // مسافة صغيرة بين الأيقونة والنص
                    Text(
                      id,
                      style: AppTextStyles.fontSize14(context).copyWith(
                        color: Colors.white,
                      ),
                    ),
                    Spacer(), // يقوم بملء المساحة المتبقية بين النصوص
                    Text(
                      date,
                      style: AppTextStyles.fontSize14(context).copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                Row(
                  children: [
                    SvgPicture.asset(Assets.assetsForMadsUserIcon),
                    SizedBox(width: 15,),
                    Text(name , style: AppTextStyles.fontSize14(context).copyWith(
                        color: Colors.white) )
                  ],
                ),
              ],
            ),
          )
        );


  }
}