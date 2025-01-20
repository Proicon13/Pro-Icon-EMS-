
  import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/theme/app_text_styles.dart';
import 'package:pro_icon/Core/utils/enums/gender.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';
import 'package:pro_icon/Core/widgets/base_app_Scaffold.dart';
import 'package:pro_icon/Core/widgets/custom_button.dart';
import 'package:pro_icon/Core/widgets/custom_confirmation_dialog.dart';
import 'package:pro_icon/Core/widgets/custom_header.dart';
import 'package:pro_icon/Core/widgets/custom_svg_visual.dart';
import 'package:pro_icon/Features/languges_screen/cubit/languges_cubit.dart';
import 'package:pro_icon/Features/languges_screen/cubit/languges_state.dart';

import '../../../Core/constants/app_assets.dart';
import '../widget/language_screen_content.dart';

class LangugesScreen extends StatelessWidget {

  static const routeName = '/Languges_screen';

       LangugesScreen({super.key});



    @override
    Widget build(BuildContext context) {
      return BaseAppScaffold(
        body: LanguageScreenContent()
      );
    }
  }
