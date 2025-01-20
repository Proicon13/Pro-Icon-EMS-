import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';

import '../../../Core/constants/app_assets.dart';
import '../../../Core/theme/app_text_styles.dart';
import '../../../Core/utils/responsive_helper/size_constants.dart';
import '../../../Core/widgets/custom_button.dart';
import '../../../Core/widgets/custom_confirmation_dialog.dart';
import '../../../Core/widgets/custom_header.dart';
import '../../../Core/widgets/custom_svg_visual.dart';
import '../cubit/languges_cubit.dart';
import '../cubit/languges_state.dart';
import 'languges_list_content.dart';

class LanguageScreenContent extends StatelessWidget {
   LanguageScreenContent({super.key});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: SizeConstants.kScaffoldPadding(context),
      child: LangugesListContent()
    );
  }
}
