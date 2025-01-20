import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';

import '../../../Core/constants/app_assets.dart';
import '../../../Core/theme/app_text_styles.dart';
import '../../../Core/widgets/custom_button.dart';
import '../../../Core/widgets/custom_confirmation_dialog.dart';
import '../../../Core/widgets/custom_header.dart';
import '../../../Core/widgets/custom_svg_visual.dart';
import '../cubit/languges_cubit.dart';
import '../cubit/languges_state.dart';

class LangugesListContent extends StatelessWidget {
  LangugesListContent({super.key});

  final Map<String, String> languagesWithFlags = {
    'Germany': '${Assets.assetsGermanyFlag}',
    'English': '${Assets.assetsUkFlag}',
    'Spanish': '${Assets.assetsSpainFlag}',
    'French': '${Assets.assetsFranchFlag}',
    'Brazil': '${Assets.assetsBrazilFlag}',
    'Italy': '${Assets.assetsItalySvg}',
  };
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguagesState>(
      builder: (context, state) {
        return Column(
          children: [
            context.setMinSize(20).verticalSpace,
            CustomHeader(titleKey: "Select Language".tr()),
            context.setMinSize(20).verticalSpace,
            Expanded(
              child: ListView.separated(
                itemCount: languagesWithFlags.length,
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.grey,
                  height: 1,
                ),
                itemBuilder: (context, index) {
                  final language = languagesWithFlags.keys.elementAt(index);
                  final flagSvg = languagesWithFlags[language];
                  //TODO: REFACTOR THE LIST TILE TO A SEPARATE WIDGET (lANGUAGECARD)
                  //TODO: add required parameters to the widget constructor (icon,title,onTap)
                  return ListTile(
                    leading: CustomSvgVisual(
                        assetPath:
                            "${flagSvg}") //TODO: add width and height to the svg(responsive)
                    ,
                    title: Text(
                      language,
                      style: AppTextStyles.fontSize16(context).copyWith(
                        color: Colors.white,
                      ),
                    ),
                    trailing: state.selectedLanguage == language
                        ? const CustomSvgVisual(
                            assetPath: Assets
                                .assetsSelectedIcon) //TODO: add width and height to the svg(responsive)
                        : null,
                    onTap: () {
                      context.read<LanguageCubit>().selectLanguage(language);
                    },
                  );
                },
              ),
            ),
            if (state.selectedLanguage != null)
              CustomButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return CustomConfirmationDialog(
                              title: "Change Languages",
                              confirmationTitle: "change Confirm",
                              onConfirm: () {});
                        });
                  },
                  text: "confirm".tr()),
            context.setMinSize(20).verticalSpace,
          ],
        );
      },
    );
  }
}
