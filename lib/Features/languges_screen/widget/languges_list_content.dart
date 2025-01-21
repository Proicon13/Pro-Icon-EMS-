import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Features/languges_screen/widget/language_card.dart';

import '../../../Core/constants/app_assets.dart';
import '../../../Core/widgets/custom_button.dart';
import '../../../Core/widgets/custom_confirmation_dialog.dart';
import '../../../Core/widgets/custom_header.dart';
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

                  return LanguageCard(
                      languageName: language,
                      flagSvg: flagSvg!,
                      isSelected: state.selectedLanguage == language,
                      onTap: () {
                        context.read<LanguageCubit>().selectLanguage(language);
                      });
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
