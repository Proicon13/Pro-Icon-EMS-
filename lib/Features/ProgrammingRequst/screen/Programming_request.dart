  
  import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/constants/app_assets.dart';
import 'package:pro_icon/Core/dependencies.dart';
import 'package:pro_icon/Core/theme/app_text_styles.dart';
import 'package:pro_icon/Core/widgets/base_app_scaffold.dart';
import 'package:pro_icon/Core/widgets/custom_button.dart';
import 'package:pro_icon/Core/widgets/custom_header.dart';
import 'package:pro_icon/Features/ProgrammingRequst/cubit/programmer_request_cubit.dart';
import 'package:pro_icon/Features/ProgrammingRequst/widget/card_request.dart';
import 'package:pro_icon/Features/auth/reset_password/screens/set_new_password_screen.dart';

class ProgrammingRequest extends StatelessWidget {
    const ProgrammingRequest({super.key});

    @override
    Widget build(BuildContext context) {
      return BlocProvider(

        create: (BuildContext context) => getIt<ProgrammerRequestCubit>()..getProgrammingRequests(),
        child: BaseAppScaffold(

          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                CustomHeader(titleKey: "Programming request"),
                const SizedBox(height: 150,),
                Image(image: AssetImage(Assets.assetsImagesProgrammingRequest)),

                Text("No pending requests" , style: AppTextStyles.fontSize16(context).copyWith(
                  color: Colors.grey
                ),),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 20 , right: 20),
                  child: CustomButton(onPressed: (){}, text: "Apply to programmer role"),
                ),


              ],
            ),
          ),
        ),
      );
    }
  }
  