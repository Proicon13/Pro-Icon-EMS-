import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pro_icon/Core/theme/app_colors.dart';
import 'package:pro_icon/Core/theme/app_text_styles.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';
import 'package:pro_icon/Core/widgets/custom_button.dart';

import '../../../Core/utils/enums/filteration_type.dart';
import '../cubits/user_managment_cubit.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog();

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  late GlobalKey<FormBuilderState> _formKey;
  @override
  void initState() {
    _formKey = GlobalKey<FormBuilderState>();
    super.initState();
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final selectedType =
          _formKey.currentState?.value['filterationType']! as FilterationType;

      Navigator.pop(context);
      BlocProvider.of<UserManagmentCubit>(context, listen: false)
          .onFilter(selectedType);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: SizeConstants.kDefaultBorderRadius(context),
      ),
      backgroundColor: AppColors.backgroundColor,
      child: SizedBox(
        width: context.screenWidth * 0.7,
        height: context.sizeConfig.height * 0.47,
        child: Stack(
          children: [
            Container(
              padding: SizeConstants.kScaffoldPadding(context),
              child: FormBuilder(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (context.sizeConfig.height * 0.08)
                        .verticalSpace, // Responsive vertical space
                    const DialogTitle(),
                    (context.sizeConfig.height * 0.025)
                        .verticalSpace, // Responsive vertical space
                    const FilterationOptions(), // No need to pass state here
                    (context.sizeConfig.height * 0.025)
                        .verticalSpace, // Responsive vertical space
                    SubmitButton(
                      onSubmit: () => _handleSubmit(),
                    ),
                    (context.sizeConfig.height * 0.005).verticalSpace,
                  ],
                ),
              ),
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.setMinSize(15),
                      vertical: context.setMinSize(15)),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: context.setMinSize(30),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class DialogTitle extends StatelessWidget {
  const DialogTitle();

  @override
  Widget build(BuildContext context) {
    return Text(
      "Sort by:",
      style: AppTextStyles.fontSize20(context).copyWith(color: Colors.white),
    );
  }
}

class FilterationOptions extends StatefulWidget {
  const FilterationOptions();

  @override
  _FilterationOptionsState createState() => _FilterationOptionsState();
}

class _FilterationOptionsState extends State<FilterationOptions> {
  FilterationType _selectedOption = FilterationType.newest;

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<FilterationType>(
      name: "filterationType",
      initialValue: _selectedOption,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: FilterationType.values
              .map((type) => Padding(
                    padding: EdgeInsets.only(
                        bottom:
                            (context.sizeConfig.height * 0.008)), // Add spacing
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedOption = type;
                          field.didChange(type); // Update form value
                        });
                      },
                      child: Row(
                        children: [
                          Transform.scale(
                            scale: context.scaleHeight,
                            child: Radio<FilterationType>(
                              value: type,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              groupValue: _selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  _selectedOption = value!;
                                  field.didChange(value);
                                });
                              },
                              activeColor:
                                  Colors.white, // Customize radio color
                            ),
                          ),
                          context.setMinSize(10).horizontalSpace,
                          Expanded(
                            child: Text(
                              type.name,
                              style: AppTextStyles.fontSize16(context)
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
              .toList(),
        );
      },
    );
  }
}

class SubmitButton extends StatelessWidget {
  final void Function() onSubmit;

  const SubmitButton({
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: () => onSubmit(),
      text: "See results",
    );
  }
}
